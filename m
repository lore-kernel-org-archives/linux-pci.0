Return-Path: <SRS0=KF9H=JT=nic.cz=marek.behun@kernel.org>
Return-Path: <SRS0=KF9H=JT=nic.cz=marek.behun@kernel.org>
Date: Tue, 3 Jul 2018 17:00:59 +0200
From: Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas
 <helgaas@kernel.org>, linux-pci@vger.kernel.org, Antoine =?ISO-8859-1?Q?T?=
 =?ISO-8859-1?Q?=E9nart?= <antoine.tenart@free-electrons.com>,
 =?ISO-8859-1?Q?Gr=E9gory?=  Clement <gregory.clement@free-electrons.com>,
 =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>
Subject: pcie-aardvark GEN2 link speed 2.5 GT/s instead of 5.0 GT/s
Message-ID: <20180703170059.6c5f8b47@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,
for our testing purposes we are trying various PCIe cards on our Armada
3720 board, but for some reason we cannot link the device at 5.0 GT/s.
The board should support PCIe GEN 2, and when given an ASM1062 MiniPCIe
SATA card, lspci -vvv prints:
   LnkCap:	Port #1, Speed 5GT/s, Width x1, ...
but
   LnkSta:	Speed 2.5GT/s, Width x1, ...

Is it possible to train the link with pcie-aardvark to 5.0GT/s?
Thank you.

Marek Behun
