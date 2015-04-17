Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:37541 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753766AbbDQItU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 04:49:20 -0400
Date: Fri, 17 Apr 2015 16:45:46 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	CPGS <cpgs@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [query] how to use "ranges" in device tree
Message-ID: <20150417164546.3925eb7c@xhacker>
In-Reply-To: <5862495.WQJXyp7MlL@wuerfel>
References: <20150416215938.347caa68@xhacker>
	<20150417102413.705b1ca0@xhacker>
	<20150417115016.69857a77@xhacker>
	<5862495.WQJXyp7MlL@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd,

On Fri, 17 Apr 2015 01:32:00 -0700
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 17 April 2015 11:50:16 Jisheng Zhang wrote:
> > Hi all,
> > 
> > I got the solution, the ranges can define two or more ranges. What I need to do
> > is just add ranges for 0xe0000000 - 0xf0000000 as the following:
> > 
> > soc {
> >         ranges = <0 0xf7000000 0x1000000
> >                   0xe0000000 0xe0000000 0x10000000>;  //add this line
> >         ...
> >         pcie: pcie@e40000 {
> >                 ...
> >                 reg = <0xe40000 0x10000>, <0xe0000000 0x8000000>;
> >                 reg-names = "dbi", "pad", "config";
> >                 ...
> >         };
> > }
> > 
> > Now, we can get the config space correctly.
> > 
> 
> This will work correctly, but it is not a very clean solution, because
> you define an intermediate address space that has some part of the
> bus mapped to zero, and another part mapped to a high address that
> matches the address the CPU sees.

Seems I had a better understanding of the "ranges" usage, thanks for
your explanation. 

> 
> A nicer (but a little more complicated) way to do this would be to use
> #address-cells=<2> in the parent bus and use that to enumerate the

In this way, we need to change all device nodes' "reg" in arch/arm/boot/dts/berlin2q.dtsi?
And in arm64 case, we should use #address-cells=<3>?

If above two answer is yes, setting "ranges = <..>" seems add complexity in my
humble opinion. So is it better to use 1:1 mapping by "ranges;" in "/soc" node?

Thanks a lot,
Jisheng

> address ranges that get passed through:
> 
> soc {
> 	#address-cells=<2>;
> 	#size-cells=<1>;
>         ranges = <0 0  0xf7000000  0x1000000>, /* 0: the normal regs */
> 		  <1 0  0xe0000000 0x16000000>; /* 1: reallocated registers for PCI */
> 
> 	pcie@e40000 {
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		reg = <0 0xe40000 0x10000>, <1 0 0x8000000>;
> 
> 		/* memory space at pci address 0xf0000000, cpu address 0xf0000000, 
> 		   bus address 0x10000000 */
> 		ranges = <0x02000000 0 0xf0000000   0 0x10000000   0 0x06000000>;
> 	};
> 
> 	...
> };
> 
> The ranges property inside of the pcie node here should match whatever you program
> into the inbound mapping registers of the PCIe host controller (if any).
> 
> 	Arnd

