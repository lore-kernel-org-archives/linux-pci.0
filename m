Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:46244 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750987AbaBMTwY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 14:52:24 -0500
Date: Thu, 13 Feb 2014 19:51:48 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213195148.GP13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1392236171-10512-4-git-send-email-will.deacon@arm.com>
 <D2AE4AE6-E8FA-4DD8-B92B-E37205A2548C@codeaurora.org>
 <20140213110721.GC13576@mudshark.cambridge.arm.com>
 <20140213180616.GD17248@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140213180616.GD17248@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 06:06:16PM +0000, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2014 at 11:07:21AM +0000, Will Deacon wrote:
> 
> > Not in this case! kvmtool generates the following:
> 
> Well, the example is nice so someone can review it..
>  
> > 	pci {
> > 		#address-cells = <0x3>;
> > 		#size-cells = <0x2>;
> > 		#interrupt-cells = <0x1>;
> > 		compatible = "arm,pci-cam-generic";
> > 		reg = <0x0 0x40000000>;
> > 		ranges = <0x1000000 0x0 0x0 0x0 0x0 0x0 0x10000 0x2000000 0x0 0x41000000 0x0 0x41000000 0x0 0x3f000000>;
> > 		interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x0 0x4 0x1 0x800 0x0 0x0 0x1 0x1 0x0 0x5 0x1 0x1000 0x0 0x0 0x1 0x1 0x0 0x6 0x1 0x1800 0x0 0x0 0x1 0x1 0x0 0x7 0x1>;
> > 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> > 	};
> 
> 
> Looks like there are a few misses in the above. How about this:
> 
> pci {
>     compatible = "arm,pci-cam-generic"
>     device_type = "pci";
>     ** ^^^^^^^^^^^^^^^^^
>     ** MANDATORY for the host bridge node

Ok, I'll add that.

>     #address-cells = <3>;
>     #size-cells = <2>;
> 
>     // BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2)
>     ranges = <0x1000000 0x0 0x00000000  0x0 0x00000000  0x0 0x00010000>,
>                                         ^^^^^^^^^^^^^^
>             ** ?? Is this why you had problems with the offset? Should
> 	    ** be the cpu physical address of the start of the IO window.
>              <0x2000000 0x0 0x41000000  0x0 0x41000000  0x0 0x3f000000>;
> 
>    
>     #interrupt-cells = <0x1>;
>     // PCI_DEVICE(3) INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER_DATA(3)
>     interrupt-map = <  0x0 0x0 0x0 0x1  0x1  0x0 0x4 0x1
>                      0x800 0x0 0x0 0x1  0x1  0x0 0x5 0x1 
>                     0x1000 0x0 0x0 0x1  0x1  0x0 0x6 0x1
>                     0x1800 0x0 0x0 0x1  0x1  0x0 0x7 0x1>;
>                  **                    ^^^^^^
>                  ** This should be a phandle to the interrupt controller

That is a phandle, libfdt/kvmtool just ends up dealing with the number
directly. I'll fix in the example.

>     // PCI_DEVICE(3) INT#1()
>     interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> }
> 
> I keep thinking of making a pcie-dt.h file with helper macros for
> all this. :|

If it's not being generated automatically, that could be useful.

> FWWI, I like to put a double space between the logically distinct
> things in the lists.


Makes sense, I may well do the same.

Thanks,

Will
