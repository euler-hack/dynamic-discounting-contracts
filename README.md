# dynamic-discounting-contracts
Dynamic discounting system implementation (blockchain side)


| Метод | Входные данные | Описание |
| --- | --- | --- |
| createP2POrder | uint8,address,string,[uint256,uint256]| Создаёт p2p заявку на контракт, семантика параметров: <сторона BUY=0, SELL=0>,<тот, к кому обращена заявка>, <описание предмета договора>, [<сумма к оплате>, <сумма скидки>]|
| acceptP2POrder | uint8 | Подтвердить чужую заявку, обращенную к себе. Аргумент - id p2p-заявки |
| getOrderDetails | uint8 | Получить детальную информацию по заявке. Аргумент - id p2p-заявки |
