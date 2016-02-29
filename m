Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27160 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbcB2R15 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Feb 2016 12:27:57 -0500
Subject: Re: [PATCH v4 00/11] PCI VPD access fixes
To: Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <56D47F90.6020301@oracle.com>
Date: Mon, 29 Feb 2016 11:27:44 -0600
MIME-Version: 1.0
In-Reply-To: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2/22/2016 6:46 PM, Bjorn Helgaas wrote:
> Hi Hannes,
> 
> This is a revision of your v3 series:
> http://lkml.kernel.org/r/1455525722-122040-1-git-send-email-hare@suse.de
> 
> Here's the description from your v3 posting:
> 
>   the current PCI VPD page access assumes that the entire possible VPD
>   data is readable. However, the spec only guarantees a VPD data up to
>   the 'end' marker, with everything beyond that being undefined.
>   This causes a system lockup on certain devices.
> 
>   With this patch we always set the VPD sysfs attribute size to '0', and
>   calculate the available VPD size on the first access.
>   If no valid data can be read an I/O error is returned.
> 
>   I've also included the patch from Babu to blacklists devices which
>   are known to lockup when accessing the VPD data.
> 
> I tweaked a few things, mostly whitespace and printk changes.  The
> appended diff shows the changes I made.
> 
> I added some patches on top to clean up and simplify the VPD code.
> These shouldn't make any functional difference unless I've made a
> mistake.  I've built these, but I don't really have a way to test
> them.
> 
> I am still waiting for bugzilla links from Babu for the blacklist
> patch.

 Sorry. I was on vacation. Just back in office today. Here is the 
 Bugzilla link.  https://bugzilla.kernel.org/show_bug.cgi?id=110681

     
> 
> Bjorn
> 
> ---
> 
> Babu Moger (1):
>       FIXME need bugzilla link
> 
> Bjorn Helgaas (7):
>       PCI: Use bitfield instead of bool for struct pci_vpd_pci22.busy
>       PCI: Move pci_read_vpd() and pci_write_vpd() close to other VPD code
>       PCI: Move pci_vpd_release() from header file to pci/access.c
>       PCI: Remove struct pci_vpd_ops.release function pointer
>       PCI: Rename VPD symbols to remove unnecessary "pci22"
>       PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
>       PCI: Sleep rather than busy-wait for VPD access completion
> 
> Hannes Reinecke (3):
>       PCI: Update VPD definitions
>       PCI: Allow access to VPD attributes with size 0
>       PCI: Determine actual VPD size on first access
> 
> 
>  drivers/pci/access.c    |  240 ++++++++++++++++++++++++++++++-----------------
>  drivers/pci/pci-sysfs.c |   22 +++-
>  drivers/pci/pci.h       |   16 ++-
>  drivers/pci/probe.c     |    2 
>  drivers/pci/quirks.c    |   29 ++++++
>  include/linux/pci.h     |   27 +++++
>  6 files changed, 231 insertions(+), 105 deletions(-)
> 
> 
> Below are the changes I made to your v3 series:
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 8b6f5a2..4850f06 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -283,9 +283,9 @@ struct pci_vpd_pci22 {
>  	struct pci_vpd base;
>  	struct mutex lock;
>  	u16	flag;
> +	u8	cap;
>  	u8	busy:1;
>  	u8	valid:1;
> -	u8	cap;
>  };
>  
>  /**
> @@ -311,9 +311,9 @@ static size_t pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
>  			    (tag == PCI_VPD_LTIN_RW_DATA)) {
>  				if (pci_read_vpd(dev, off+1, 2,
>  						 &header[1]) != 2) {
> -					dev_dbg(&dev->dev,
> -						"invalid large VPD tag %02x size at offset %zu",
> -						tag, off + 1);
> +					dev_warn(&dev->dev,
> +						 "invalid large VPD tag %02x size at offset %zu",
> +						 tag, off + 1);
>  					return 0;
>  				}
>  				off += PCI_VPD_LRDT_TAG_SIZE +
> @@ -325,15 +325,17 @@ static size_t pci_vpd_pci22_size(struct pci_dev *dev, size_t old_size)
>  				pci_vpd_srdt_size(header);
>  			tag = pci_vpd_srdt_tag(header);
>  		}
> +
>  		if (tag == PCI_VPD_STIN_END)	/* End tag descriptor */
>  			return off;
> +
>  		if ((tag != PCI_VPD_LTIN_ID_STRING) &&
>  		    (tag != PCI_VPD_LTIN_RO_DATA) &&
>  		    (tag != PCI_VPD_LTIN_RW_DATA)) {
> -			dev_dbg(&dev->dev,
> -				"invalid %s VPD tag %02x at offset %zu",
> -				(header[0] & PCI_VPD_LRDT) ? "large" : "short",
> -				tag, off);
> +			dev_warn(&dev->dev,
> +				 "invalid %s VPD tag %02x at offset %zu",
> +				 (header[0] & PCI_VPD_LRDT) ? "large" : "short",
> +				 tag, off);
>  			return 0;
>  		}
>  	}
> @@ -366,7 +368,7 @@ static int pci_vpd_pci22_wait(struct pci_dev *dev)
>  			return ret;
>  
>  		if ((status & PCI_VPD_ADDR_F) == vpd->flag) {
> -			vpd->busy = false;
> +			vpd->busy = 0;
>  			return 0;
>  		}
>  
> @@ -393,16 +395,18 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
>  	if (pos < 0)
>  		return -EINVAL;
>  
> -	if (!vpd->valid && vpd->base.len > 0) {
> -		vpd->valid = true;
> +	if (!vpd->valid) {
> +		vpd->valid = 1;
>  		vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
>  	}
> +
>  	if (vpd->base.len == 0)
>  		return -EIO;
>  
> +	if (pos >= vpd->base.len)
> +		return 0;
> +
>  	if (end > vpd->base.len) {
> -		if (pos > vpd->base.len)
> -			return 0;
>  		end = vpd->base.len;
>  		count = end - pos;
>  	}
> @@ -422,7 +426,7 @@ static ssize_t pci_vpd_pci22_read(struct pci_dev *dev, loff_t pos, size_t count,
>  						 pos & ~3);
>  		if (ret < 0)
>  			break;
> -		vpd->busy = true;
> +		vpd->busy = 1;
>  		vpd->flag = PCI_VPD_ADDR_F;
>  		ret = pci_vpd_pci22_wait(dev);
>  		if (ret < 0)
> @@ -459,10 +463,11 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
>  	if (pos < 0 || (pos & 3) || (count & 3))
>  		return -EINVAL;
>  
> -	if (!vpd->valid && vpd->base.len > 0) {
> -		vpd->valid = true;
> +	if (!vpd->valid) {
> +		vpd->valid = 1;
>  		vpd->base.len = pci_vpd_pci22_size(dev, vpd->base.len);
>  	}
> +
>  	if (vpd->base.len == 0)
>  		return -EIO;
>  
> @@ -492,7 +497,7 @@ static ssize_t pci_vpd_pci22_write(struct pci_dev *dev, loff_t pos, size_t count
>  		if (ret < 0)
>  			break;
>  
> -		vpd->busy = true;
> +		vpd->busy = 1;
>  		vpd->flag = 0;
>  		ret = pci_vpd_pci22_wait(dev);
>  		if (ret < 0)
> @@ -572,8 +577,8 @@ int pci_vpd_pci22_init(struct pci_dev *dev)
>  		vpd->base.ops = &pci_vpd_pci22_ops;
>  	mutex_init(&vpd->lock);
>  	vpd->cap = cap;
> -	vpd->busy = false;
> -	vpd->valid = false;
> +	vpd->busy = 0;
> +	vpd->valid = 0;
>  	dev->vpd = &vpd->base;
>  	return 0;
>  }
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index df1178f..626c3b2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2135,45 +2135,31 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
>  
>  /*
> - * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
> - * will dump 32k of data. The default length is set as 32768.
> - * Reading a full 32k will cause an access beyond the VPD end tag.
> - * The system behaviour at that point is mostly unpredictable.
> - * Apparently, some vendors have not implemented this VPD headers properly.
> - * Adding a generic function disable vpd data for these buggy adapters
> - * Add the DECLARE_PCI_FIXUP_FINAL line below with the specific with
> - * vendor and device of interest to use this quirk.
> + * If a device follows the VPD format spec, the PCI core will not read or
> + * write past the VPD End Tag.  But some vendors do not follow the VPD
> + * format spec, so we can't tell how much data is safe to access.  Devices
> + * may behave unpredictably if we access too much.  Blacklist these devices
> + * so we don't touch VPD at all.
>   */
>  static void quirk_blacklist_vpd(struct pci_dev *dev)
>  {
>  	if (dev->vpd) {
>  		dev->vpd->len = 0;
> -		dev_warn(&dev->dev, "PCI vpd access has been disabled due to firmware bug\n");
> +		dev_warn(&dev->dev, FW_BUG "VPD access disabled\n");
>  	}
>  }
>  
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
> -		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
> -		quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
>  		quirk_blacklist_vpd);
>  
> 
