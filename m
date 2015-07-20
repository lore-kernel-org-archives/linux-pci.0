Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59238 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056AbbGTO1Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 10:27:25 -0400
Date: Mon, 20 Jul 2015 16:27:22 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH 3/8] PCI: Reduce size of ATS structure elements
Message-ID: <20150720142722.GI13082@suse.de>
References: <20150717212759.18379.44858.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150717213208.18379.24197.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717213208.18379.24197.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 17, 2015 at 04:32:08PM -0500, Bjorn Helgaas wrote:
> The extended capabilities list is linked with 12-bit pointers, and the ATS
> Smallest Translation Unit and Invalidate Queue Depth fields are both 5
> bits.
> 
> Use u16 and u8 to hold the extended capability address and the stu and qdep
> values.  No functional change.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  include/linux/pci.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ba4a23b..1997853 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -376,9 +376,9 @@ struct pci_dev {
>  		struct pci_sriov *sriov;	/* SR-IOV capability related */
>  		struct pci_dev *physfn;	/* the PF this VF is associated with */
>  	};
> -	int		ats_cap;	/* ATS Capability offset */
> -	int		ats_stu;	/* ATS Smallest Translation Unit */
> -	int		ats_qdep;	/* ATS Invalidate Queue Depth */
> +	u16		ats_cap;	/* ATS Capability offset */
> +	u8		ats_stu;	/* ATS Smallest Translation Unit */
> +	u8		ats_qdep;	/* ATS Invalidate Queue Depth */
>  #endif
>  	phys_addr_t rom; /* Physical address of ROM if it's not from the BAR */
>  	size_t romlen; /* Length of ROM if it's not from the BAR */

I was about to suggest to fold this into the previous patch. But since
the elements in the old ats-struct were also ints, it makes sense to
have this as a seperate patch :)


Reviewed-by: Joerg Roedel <jroedel@suse.de>

