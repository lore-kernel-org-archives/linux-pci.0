Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55A57D2B.4010207@broadcom.com>
Date: Tue, 14 Jul 2015 14:20:43 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Jon Mason <jonmason@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] arm64: dts: Add Broadcom North Star 2 support
References: <1436837955-26279-1-git-send-email-rjui@broadcom.com> <1436837955-26279-5-git-send-email-rjui@broadcom.com> <20150714092353.GA12675@leverpostej>
In-Reply-To: <20150714092353.GA12675@leverpostej>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/14/2015 2:23 AM, Mark Rutland wrote:
> Hi,
> 
>> +/dts-v1/;
>> +
>> +#include "ns2.dtsi"
>> +
>> +/ {
>> +       model = "Broadcom NS2 SVK";
>> +       compatible = "brcm,ns2-svk", "brcm,ns2";
>> +
>> +       chosen {
>> +               bootargs = "console=ttyS0,115200n8 earlycon=uart8250,mmio32,0x66130000";
>> +       };
> 
> Please use stdout-path instead (you can use /aliases to make it
> simpler). It'll save a redundant description of the UART and will remove
> the dependency on Linux-specific naming of the UART.
> 
> [...]

Saw that Arnd also has the same comment. I will fix this.

> 
>> +/ {
>> +       compatible = "brcm,ns2";
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       cpus {
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +
>> +               cpu@0 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a57", "arm,armv8";
>> +                       reg = <0 0>;
>> +                       enable-method = "spin-table";
>> +                       cpu-release-addr = <0 0x84b00000>;
>> +               };
>> +       };
> 
> Shouldn't the other CPUs be described?

Let me give that a try but there's a chance that I cannot enable other 3
cores until we have a more stable bootloader configuration.

> 
> Using spin-table for SMP is somewhat unfortunate, as it comes with a
> number of problems (e.g. unwoken secondaries spinning in the kernel). I
> would strongly advise using PSCI instead.
>

Yes I agree and I'm fully aware PSCI is the preferred way of bringing up
ARMv8 cores. Unfortunately this is currently out of my control as this
is done in ARM Trusted Firmware that was handled by a different team
within Broadcom and they have very tight schedule and will not have time
to add PSCI support in the near term.

The plan is to use spin-table for now and convert to PSCI when we have
the support for it in our ATF. That should happen within the next couple
months.


>> +
>> +       timer {
>> +               compatible = "arm,armv8-timer";
>> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) |
>> +                             IRQ_TYPE_EDGE_RISING)>,
>> +                            <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) |
>> +                             IRQ_TYPE_EDGE_RISING)>,
>> +                            <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) |
>> +                             IRQ_TYPE_EDGE_RISING)>,
>> +                            <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) |
>> +                             IRQ_TYPE_EDGE_RISING)>;
>> +               clock-frequency = <25000000>;
>> +       };
> 
> Please fix your firmware to configure CNTFRQ_EL0, it is simply a bug not
> to, and using clock-frequency does not fix all the problems that not
> configuring it causes.

Yes will do this.

> 
> Thanks,
> Mark.
> 

Thanks,

Ray
