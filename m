Return-Path: <SRS0=/Beh=CI=mobiveil.co.in=l.subrahmanya@kernel.org>
Return-Path: <SRS0=/Beh=CI=mobiveil.co.in=l.subrahmanya@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171110003910.GA18818@bhelgaas-glaptop.roam.corp.google.com>
References: <CAFZiPx1x9irvXCm7W9t_VjGnw2VLPhptO8WfuRXPd1jpcBU2Sw@mail.gmail.com>
 <697da40c-7cdd-3d05-5846-37eae31bb729@mobiveil.co.in> <alpine.DEB.2.20.1711091427050.1839@nanos>
 <CAFZiPx1pJ4WyDkP2dT8eQvZRukTbZA9H+kTD506e19s0SU8rtQ@mail.gmail.com> <20171110003910.GA18818@bhelgaas-glaptop.roam.corp.google.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 10 Nov 2017 11:20:44 +0530
Message-ID: <CAFZiPx04sHC2dLwJAR6Ci3zAa+5YaX-82yd38=frkamEE2YwYw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Peter W Newton <peter.newton@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	"M.h. Lian" <minghuan.lian@nxp.com>, Raj Raina <rajesh.raina@nxp.com>,
	Rajan Kapoor <rajan.kapoor@nxp.com>, Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Fri, Nov 10, 2017 at 6:09 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Nov 10, 2017 at 05:59:56AM +0530, Subrahmanya Lingappa wrote:
>> On Thu, Nov 9, 2017 at 6:57 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Thu, 9 Nov 2017, subrahmanya_lingappa wrote:
>> >
>> >> From e38b741006856f3a3623109dd5ddf5f99326ce61 Mon Sep 17 00:00:00 2001
>> >> From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> >> Date: Thu, 9 Nov 2017 04:25:21 -0500
>> >> Subject: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
>> >>
>> >> This patch exports irq_set_msi_desc symbol which is used by
>> >> few PCIe root port drivers.
>> >
>> > And which one of those is modular?
>>
>> I think this one is, as I see at least 25 other files using it, albeit
>> SoC devices.
>
> A modular driver would have "tristate" in its Kconfig.  You mentioned
> pcie-xilinx.c, which has:
>
>   obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>
>   config PCIE_XILINX
>           bool "Xilinx AXI PCIe host bridge support"
>
> It's "bool", so not modular, so it shouldn't require the
> EXPORT_SYMBOL().
>
> You saw an undefined symbol error, though.  Was that on an upstream
> kernel, or possibly some other kernel that has changes to make this
> driver modular?
>
> I don't think your mobiveil driver (as posted) requires this
> EXPORT_SYMBOL() either.
>

Agreed, I will drop this patch from my next driver revison.

> Bjorn
