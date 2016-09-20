Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "liudongdong (C)" <liudongdong3@huawei.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, "Lorenzo.Pieralisi@arm.com" <Lorenzo.Pieralisi@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jcm@redhat.com" <jcm@redhat.com>, "Chenxin (Charles)" <charles.chenxin@huawei.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH V2 1/3] PCI: hisi: re-architect Hip05/Hip06 controllers driver to preapare for ACPI
Date: Tue, 20 Sep 2016 15:22:40 +0200
Message-ID: <3554735.zkBHRv36Sl@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1F87AAFD@lhreml507-mbx>
References: <1472644094-82731-1-git-send-email-liudongdong3@huawei.com> <6532722.cVEMfv9Kqj@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1F87AAFD@lhreml507-mbx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, September 20, 2016 9:45:13 AM CEST Gabriele Paoloni wrote:
> > 
> > I think this would be easier if you separate the ACPI code from the
> > DT code and not try to have a common file used for both.
> > 
> > Sharing the config space accessors really isn't worth it when both
> > variants are fairly simple to do, but they don't fit in a common
> > model because one is called from the ACPI quirks and the other
> > is called from the dw-pcie driver with completely different calling
> > conventions.
> 
> Not sure about this...
> From my perspective having the shared code would make clear that
> the two drivers (ACPI and DT) are kind of related...
> 
> For example see the reply from Bjorn to the xgene driver:
> https://lkml.org/lkml/2016/9/19/749
> 
> I know in our case the duplication isn't much but as I said
> I am a bit reluctant to rework this... 

It's clearly a question of perspective: The way I see it, this
is not a driver at all, but a quirk for the acpi-pci driver,
and having hardware specific code shared between the two
complicates things.

In both cases (xgene and hisi), only a very small portion of
PCI host driver is needed as for the ACPI quirk, while all
of the hardware specific setup can be left to the firmware
here.

	Arnd
