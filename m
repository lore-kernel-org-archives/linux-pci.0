Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbdDDQnP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Apr 2017 12:43:15 -0400
Date: Tue, 4 Apr 2017 11:43:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Message-ID: <20170404164311.GB27692@bhelgaas-glaptop.roam.corp.google.com>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490703404-4944-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,

On Tue, Mar 28, 2017 at 02:16:44PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> ATS is broken on these devices. Under invalidation load, the
> GPU does not reply to invalidations anymore, causing
> Completion-wait loop timeouts on the AMD IOMMU driver side.
> Fix it by not enabling ATS on these devices.
> 
> Note that below mentioned commit is not broken, it just
> triggers the issue because it might cause invalidation
> storms on devices.
> 
> Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> Reported-by: Daniel Drake <drake@endlessm.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/pci/ats.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index eeb9fb2..711bdb2 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -17,10 +17,18 @@
>  
>  #include "pci.h"
>  
> +static const struct pci_device_id broken_ats_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x98e4) }, /* AMD Stoney GPU part */
> +	{ 0 }
> +};
> +
>  void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
>  
> +	if (pci_match_id(broken_ats_tbl, dev))
> +		return;

This is fine functionally, but from a stylistic point of view, I guess
I would prefer to have it implemented in drivers/pci/quirks.c just to
have some consistency in how we work around device defects.

>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
>  	if (!pos)
>  		return;
> -- 
> 1.9.1
> 
