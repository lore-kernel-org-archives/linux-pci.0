Return-Path: <SRS0=MB38=JT=bootlin.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=MB38=JT=bootlin.com=thomas.petazzoni@kernel.org>
Date: Tue, 3 Jul 2018 17:05:09 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lorenzo
 Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas  <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Antoine =?UTF-8?B?VMOpbmFydA==?=
 <antoine.tenart@free-electrons.com>, =?UTF-8?B?R3LDqWdvcnk=?=  Clement
 <gregory.clement@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, Victor Gu <xigu@marvell.com>
Subject: Re: pcie-aardvark GEN2 link speed 2.5 GT/s instead of 5.0 GT/s
Message-ID: <20180703170509.33935a67@windsurf>
In-Reply-To: <20180703170059.6c5f8b47@dellmb.labs.office.nic.cz>
References: <20180703170059.6c5f8b47@dellmb.labs.office.nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hello,

+Victor Gu in Cc.

On Tue, 3 Jul 2018 17:00:59 +0200, Marek Beh=C3=BAn wrote:

> for our testing purposes we are trying various PCIe cards on our Armada
> 3720 board, but for some reason we cannot link the device at 5.0 GT/s.
> The board should support PCIe GEN 2, and when given an ASM1062 MiniPCIe
> SATA card, lspci -vvv prints:
>    LnkCap:	Port #1, Speed 5GT/s, Width x1, ...
> but
>    LnkSta:	Speed 2.5GT/s, Width x1, ...
>=20
> Is it possible to train the link with pcie-aardvark to 5.0GT/s?

I would need to do some research to be able to answer, but as a quick
reply, I would like to suggest to try the following patch series:

  https://patchwork.ozlabs.org/project/linux-pci/list/?series=3D52819

Could you let us know if it helps or not ?

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
