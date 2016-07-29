Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34318 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbcG2MlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jul 2016 08:41:10 -0400
Date: Fri, 29 Jul 2016 07:41:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: wangyijing <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, jianghong011@huawei.com
Subject: Re: Question about cacheline size in PCIe SAS card
Message-ID: <20160729124101.GA23928@localhost>
References: <5799BF23.2020902@huawei.com>
 <20160728184306.GA12187@localhost>
 <579AC545.2030306@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <579AC545.2030306@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 29, 2016 at 10:53:57AM +0800, wangyijing wrote:
> Hi Bjorn, thanks for your comment!
> 
> 在 2016/7/29 2:43, Bjorn Helgaas 写道:
> > On Thu, Jul 28, 2016 at 04:15:31PM +0800, wangyijing wrote:
> >> Hi all, we found a question about PCIe cacheline, the cacheline here is mean the
> >> configure space register at offset 0x0C in type 0 and type 1 configure space header.
> >>
> >> We did a hotplug in our platform for PCIe SAS controller, this sas controller has
> >> SSD disks and the disk sector is 520 bytes. Defaultly, BIOS set cacheline size to
> >> 64bytes, we test the IO read(io size is 128k/256k), the bandwith is 6G.
> >> After hotplug, the cacheline size in SAS controller changes to 0(default after #RST),
> >> and we test the IO read again, the bandwith changes to 5.2G.
> >>
> >> We Tested other SAS controller which is not 520 bytes sector, we didn't found this issue,
> >> and I grep the PCI_CACHE_LINE_SIZE in kernel, I found most of code change the PCI_CACHE_LINE_SIZE
> >> are device driver, like net, ata, and some arm pci controller.
> >>
> >> In PCI 3.0 spec, I found there are descriptions about cacheline size releated to performance,
> >> but in PCIe 3.0 spec, there is nothing related to cacheline size.
> > 
> > Not quite true: sec 7.5.1.3 of PCIe r3.0 says:
> > 
> >   This field [Cache Line Size] is implemented by PCI Express devices
> >   as a read-write field for legacy compatibility purposes but has no
> >   effect on any PCI Express device behavior.
> 
> Oh, sorry, I searched the key word "cacheline" in PCIe spec, according
> to this description, there is no effect on any PCIe device.
> 
> > 
> > Unless your SAS controller is doing something wrong, I suspect
> > something other than Cache Line Size is responsible for the difference
> > in performance.
> > 
> > After hot-add of your controller, Cache Line Size is probably zero
> > because Linux doesn't set it.  What happens if you set it manually
> > using "setpci"?  Does that affect the performance?
> 
> Yes, after hotplug, the cacheline size is reset to 0, linux doesn't
> touch it, and we tried to change cacheline size to 64 bytes by setpci,
> if we test the IO at this time, the IO bandwith is still 5.2G,
> but if we reset the firmware after change the cacheline size to 64 bytes,
> then test IO bandwith again, the IO bandwith would reach the 6G again.

OK, that sounds like the category of "your controller doing something
wrong," namely, it is somehow dependent on the Cache Line Size when it
shouldn't be.

If you change Linux to set the Cache Line Size during hot-add, does
that fix it?  I assume you might still need to reset the firmware to
make the card notice the change?

I wonder how this works in the non-hotplug case.  Does the BIOS reset
the firmware somehow after setting Cache Line Size?  Is there an
option ROM that might do this?

Maybe the quark driver needs a quirk in its probe routine that sets
the Cache Line Size and resets the firmware?

Bjorn
