Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 20 Sep 2015 12:04:45 -0700
From: Greg KH <greg@kroah.com>
To: Knuth Posern <knuth@posern.org>
Cc: linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Allow loading of module on recent Apple
 MacBooks with thunderbolt 2 controller
Message-ID: <20150920190445.GA10274@kroah.com>
References: <55FEF7EB.7030705@posern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55FEF7EB.7030705@posern.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 20, 2015 at 08:16:11PM +0200, Knuth Posern wrote:
> The pci device ids listed in the thunderbolt driver are to restrictive,
> which prevents the driver from being loaded on recent Apple MacBooks
> using a thunderbolt 2 controller. In particular this prevented any
> hot-plugging functionality for thunderbolt based ethernet dongles
> (i.e. Apples thunderbolt gigabit ethernet broadcom tg3 based dongle
> Model A1433 EMC 2590).
> 
> Changing the subvendor and subdevice to PCI_ANY_ID the thunderbolt driver
> loads and binds to the pci device 07:00.0 System peripheral:
> Intel Corporation Device 156c which is the thunderbolt 2 controller on
> the MacBookPro12,1.
> 
> Successfully tested on MacBookPro12,1. With the patch the thunderbolt
> module gets now loaded on boot. And it provides hot-plugging support both
> for a cold-plugged and a warm-plugged ethernet dongle.
> 
> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> Acked-by: Knuth Posern <knuth@posern.org>
> ---
> 
> This patch is submitted for upstream inclusion.
> 
> Thanks to Greg and Andreas helping coming up with the patch fixing the
> bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=100191
> 
> This is a second trial for me, so I hope the format of this mail is
> convenient.
> For the changelog/comment, I tried to follow Andrew Mortons guide
> https://www.ozlabs.org/~akpm/stuff/tpp.txt
> 
> - why the kernel needed patching
> 1st paragraph.
> 
> - the overall design approach in the patch
> - implementation details
> 2nd paragraph
> 
> - testing results
> 3rd paragraph
> 
> Cheers,
> 
> Knuth.
> 
> --- linux/drivers/thunderbolt/nhi.c.orig 2015-09-20 17:36:14.014964300 +0200
> +++ linux/drivers/thunderbolt/nhi.c 2015-09-13 09:58:18.000000000 +0200
> @@ -643,7 +643,7 @@ static struct pci_device_id nhi_ids[] =
> {
> .class = PCI_CLASS_SYSTEM_OTHER << 8, .class_mask = ~0,
> .vendor = PCI_VENDOR_ID_INTEL, .device = 0x156c,
> - .subvendor = 0x2222, .subdevice = 0x1111,
> + .subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID,

Ah, _so_ close.  Everything above the patch looks great (proper format
and the like), but the patch itself here is somehow corrupted, you lost
all leading whitespace, so it can not be applied by any tool :(

Third time's a charm?

greg k-h
