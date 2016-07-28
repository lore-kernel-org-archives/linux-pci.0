Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53494 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754844AbcG1SnM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Jul 2016 14:43:12 -0400
Date: Thu, 28 Jul 2016 13:43:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: wangyijing <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, jianghong011@huawei.com
Subject: Re: Question about cacheline size in PCIe SAS card
Message-ID: <20160728184306.GA12187@localhost>
References: <5799BF23.2020902@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5799BF23.2020902@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 04:15:31PM +0800, wangyijing wrote:
> Hi all, we found a question about PCIe cacheline, the cacheline here is mean the
> configure space register at offset 0x0C in type 0 and type 1 configure space header.
> 
> We did a hotplug in our platform for PCIe SAS controller, this sas controller has
> SSD disks and the disk sector is 520 bytes. Defaultly, BIOS set cacheline size to
> 64bytes, we test the IO read(io size is 128k/256k), the bandwith is 6G.
> After hotplug, the cacheline size in SAS controller changes to 0(default after #RST),
> and we test the IO read again, the bandwith changes to 5.2G.
> 
> We Tested other SAS controller which is not 520 bytes sector, we didn't found this issue,
> and I grep the PCI_CACHE_LINE_SIZE in kernel, I found most of code change the PCI_CACHE_LINE_SIZE
> are device driver, like net, ata, and some arm pci controller.
> 
> In PCI 3.0 spec, I found there are descriptions about cacheline size releated to performance,
> but in PCIe 3.0 spec, there is nothing related to cacheline size.

Not quite true: sec 7.5.1.3 of PCIe r3.0 says:

  This field [Cache Line Size] is implemented by PCI Express devices
  as a read-write field for legacy compatibility purposes but has no
  effect on any PCI Express device behavior.

Unless your SAS controller is doing something wrong, I suspect
something other than Cache Line Size is responsible for the difference
in performance.

After hot-add of your controller, Cache Line Size is probably zero
because Linux doesn't set it.  What happens if you set it manually
using "setpci"?  Does that affect the performance?

You might look at the MPS and MRRS settings in the two scenarios also.

You could try collecting the output of "lspci -vvxxx" for the whole
system in the default case and again after the hotplug, and then
compare the two for differences.

Bjorn
