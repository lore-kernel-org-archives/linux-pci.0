Return-Path: <SRS0=LN2z=AB=free-electrons.com=gregory.clement@kernel.org>
Return-Path: <SRS0=LN2z=AB=free-electrons.com=gregory.clement@kernel.org>
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Jan Luebbe <jlu@pengutronix.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,  Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,  Jason Cooper <jason@lakedaemon.net>,  linux-pci@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH 0/2] fix 4GB DRAM window support on mvebu
References: <20170828152517.24506-1-jlu@pengutronix.de>
	<20170830200700.GX8154@bhelgaas-glaptop.roam.corp.google.com>
Date: Thu, 31 Aug 2017 10:11:34 +0200
In-Reply-To: <20170830200700.GX8154@bhelgaas-glaptop.roam.corp.google.com>
	(Bjorn Helgaas's message of "Wed, 30 Aug 2017 15:07:00 -0500")
Message-ID: <87y3q017ih.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and Jan,
=20
 On mer., ao=C3=BBt 30 2017, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Aug 28, 2017 at 05:25:15PM +0200, Jan Luebbe wrote:
>> The current MBUS DRAM window calculation fails for 4GB windows because it
>> overflows. This is fixed in the first patch by using u64 instead of u32 =
to
>> store the size. The second excplicitly checks that we don't try to confi=
gure a
>> too large memory window in the pci driver.
>>=20
>> As they don't depend on each other, they could also go in separatly.
>>=20
>> Jan Luebbe (2):
>>   bus: mbus: fix window size calculation for 4GB windows
>>   PCI: mvebu: Check DRAM window size
>>=20
>>  drivers/bus/mvebu-mbus.c     |  2 +-
>>  drivers/pci/host/pci-mvebu.c | 27 ++++++++++++++++++++++-----
>>  include/linux/mbus.h         |  4 ++--
>>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> Since these can be applied separately, I'll let somebody else take care of
> the drivers/bus/mvebu-mbus.c part.

I think I am the one who should take it. I will apply it when v4.14-rc1
will be released as it is too late for me for 4.14 now.

However I am not against the fact that it is applied through an other
tree because we don't touch this file for the next release so there is
no risk for a conflict, I can give my Acked-by if needed.

Thanks,

Gregory

>
> I'll look for an ack from Thomas or Jason before applying the second patc=
h,
> which touches drivers/pci/host/pci-mvebu.c.

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
