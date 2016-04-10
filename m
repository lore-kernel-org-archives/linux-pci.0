Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53558 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbcDJV1F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 10 Apr 2016 17:27:05 -0400
Date: Sun, 10 Apr 2016 16:27:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jordan Hargrave <Jordan_Hargrave@dell.com>
Cc: bhelgaas@google.com, alexander.duyck@gmail.com,
	linux-pci@vger.kernel.org, babu.moger@oracle.com, hare@suse.de,
	linux-kernel@vger.kernel.org, jharg93@gmail.com
Subject: Re: [PATCH 2/2] Create sysfs entries for PCI VPDI and VPDR tags
Message-ID: <20160410212702.GB5852@localhost>
References: <1455827464-11398-1-git-send-email-Jordan_Hargrave@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455827464-11398-1-git-send-email-Jordan_Hargrave@dell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 18, 2016 at 02:31:04PM -0600, Jordan Hargrave wrote:
> The VPD-R is a readonly area of the PCI Vital Product Data region.
> There are some standard keywords for serial number, manufacturer,
> and vendor-specific values.  Dell Servers use a vendor-specific
> tag to store number of ports and port mapping of partitioned NICs.
> 
> info = VPD-Info string
> PN = Part Number
> SN = Serial Number
> MN = Manufacturer ID
> Vx = Vendor-specific (x=0..9 A..Z)
> 
> This creates a sysfs subdirectory in the pci device: vpdattr with
> 'info', 'EC', 'SN', 'V0', etc. files containing the tag values.
> 
> Added pci.h patch
> 
> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
> ---
>  include/linux/pci.h     |   3 +
>  1 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 8135a2f..c1313b1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -372,6 +372,9 @@ struct pci_dev {
>  	const struct attribute_group **msi_irq_groups;
>  #endif
>  	struct pci_vpd *vpd;
> +	int vpdr_len;
> +	u8 *vpdr_data;
> +	char *vpdi_data;

This should be squashed into the patch that uses the fields you're adding.

>  #ifdef CONFIG_PCI_ATS
>  	union {
>  		struct pci_sriov *sriov;	/* SR-IOV capability related */
> -- 
> 2.5.0
> 
