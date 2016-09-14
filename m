Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:53595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763787AbcINVdE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2016 17:33:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        gabriele.paoloni@huawei.com, minyard@acm.org,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        john.garry@huawei.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, xuwei5@hisilicon.com,
        linuxarm@huawei.com, linux-serial@vger.kernel.org,
        linux-pci@vger.kernel.org, zourongrong@gmail.com,
        liviu.dudau@arm.com, kantyzc@163.com, zhichang.yuan02@gmail.com
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
Date: Wed, 14 Sep 2016 23:32:11 +0200
Message-ID: <5869118.UilSPY9Sai@wuerfel>
In-Reply-To: <57D963C4.4010406@hisilicon.com>
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com> <5140357.dcW9ibtZJ6@wuerfel> <57D963C4.4010406@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 14, 2016 10:50:44 PM CEST zhichang.yuan wrote:
> 
> On 2016/9/14 20:33, Arnd Bergmann wrote:
> > On Wednesday, September 14, 2016 8:15:52 PM CEST Zhichang Yuan wrote:
> > 
> >> +Required properties:
> >> +- compatible: should be "hisilicon,low-pin-count"
> >> +- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
> >> +- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
> >> +- reg: base address and length of the register set for the device.
> >> +- ranges: define a 1:1 mapping between the I/O space of the child device and
> >> +	  the parent.
> > 
> > Do we still need the "ranges" here? The property in your example seems
> > wrong.
> 
> I think "ranges" is needed.
> without this, of_translate_address --> __of_translate_address --> of_translate_one will fail when translating the child's IO resource.
>
> > 
> >> +	ranges = <0x01 0xe4 0x0 0xe4 0x1000>;
> > 
> > You translate I/O port 0x00e4 through 0x10e4 to CPU address 0x0e4?
> The hip06 LPC is defined as isa type.
> So, 0x01 0xe4 is the local IO address of 0xe4. With this ranges, 0xe4 of child will be 1:1 mapped as 0xe4.
> It means no translation.

No, "no translation" would be leaving out the ranges, we should
fix the code so it handles this case according to the specification
of the ISA DT binding, rather than adding an incorrect ranges
property to make it work with the incorrect Linux implementation.

of_translate_address() should fail here, and whichever code calls
it should try something else, possibly something we have to
implement that can return the correct IORESOURCE_* type.

> > 
> > I don't get this part. The bus driver should not care what its
> > children are, just register and PIO ranges that the bus can handle
> > in theory, i.e. from 0x000 to 0xfff.
> 
> Just as we discussed in V2, the legacy PIO range is specific to some
> device, such as for ipmi bt, 0xe4 - 0xe7 will be populated.
> I don't want to occupy a larger PIO range in which only small part PIOs
> are used by our LPC. At this moment, two PIO ranges are using
> through the device property configuration, 0xe4-0xe7, 0x2f8-0x2ff.
>
> If we configure 0-0x1000 for the LPC to cover those two ranges, most
> PIO are wasted and other PIO device on other buses lose the chance to
> use the PIO below 0x1000.
> Otherwise, PIO conflict will happen. So, My idea is only occupied
> the PIO ranges which are really needed for the children.

The only thing it can realistically conflict with would be another
LPC bus behind on a PCI host bridge. On ARM64, all regular PCI
devices that have IORESOURCE_IO ports are intentionally moved
to (bus) port numbers above 0x1000.

> And there are probably multiple child devices under LPC, the global arm64_extio_ops only can cover one PIO range. It is fortunate only ipmi driver can not support I/O
> operation registering, serial driver has serial_in/serial_out to
> be registered. So, only the PIO range for ipmi device is stored
> in arm64_extio_ops and the indirect-IO
> works well for ipmi device.

You should not do that in the serial driver, please just use the
normal 8250 driver that works fine once you handle the entire
port range.
 

	Arnd
