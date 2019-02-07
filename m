Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7DC282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E6721872
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549571751;
	bh=2MzJld4j6HNnmPdZQtxAwolfBTJ/b9uQc0fC7nuFfGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nzwyk0vAzE0p9I5Jwp+HZI6VT/Ll31YT/uA3P9DGujYEMsbJ30l1bG1H0zdF9QqOP
	 v9/vBM0xkIPrrvyqJOHBLd0ppme+581WaIp+pRDIaxDJX7zHvkjf/Y+nQub6BIgsyH
	 Z/8Ja5ONIh3Jpt1jRiiOcVPEJO7k99mXF978RLzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfBGUfu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfBGUfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 15:35:50 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCBE620663;
        Thu,  7 Feb 2019 20:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549571748;
        bh=2MzJld4j6HNnmPdZQtxAwolfBTJ/b9uQc0fC7nuFfGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFvH+ljmWPslk9Bh2QpC5Hc08JhhYZ4ZpaiL2dDWGLBT1Ncgs5KDPIrI6xjt7DL28
         G9ZhJMeWNoJ4n7c0AtlYQ/RPxQ+v0jqHLuJq9wrJA44PWy1HHY7TP0Nkqt6tLlr03O
         Ri4SLyMmIw86q2Vv8z1+n+mhDz5t6r+5j3uCx5SY=
Date:   Thu, 7 Feb 2019 14:35:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     joro@8bytes.org, dwmw2@infradead.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, jacob.jun.pan@intel.com,
        keith.busch@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check PRG response
 PASID bit status.
Message-ID: <20190207203546.GL7268@google.com>
References: <cover.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2be716037209f722304e94da6df39aec5a37f236.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be716037209f722304e94da6df39aec5a37f236.1549479043.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


"PCI/ATS: Add pci_pggrp_rsp_need_pasid() interface"

On Thu, Feb 07, 2019 at 10:37:58AM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Add a new function to return the status of PRG response PASID
> required bit in PRI status register. This function will be used by

"return the PRG Response PASID Required bit in the Page Request Status
Register".

That's just to make it clear exactly what the name of the bit is.
Without the capitalization, you can't tell where the name itself
begins.

> drivers like IOMMU, if it is required to enforce the PASID required for
> page-group responses.

If I'm reading the spec (PCIe r4.0, sec 10.5.2.3) correctly, when this bit
is set, it means the Function expects a PASID on responses it receives
from the host.  It's not so much that the IOMMU "enforces" anything;
it's just that when this bit is set, the IOMMU must supply the PASID
in its responses to that Function.

s/page-group responses/PRG (Page Request Group) Response Messages/

> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c             | 27 +++++++++++++++++++++++++++
>  include/linux/pci-ats.h       |  5 +++++
>  include/uapi/linux/pci_regs.h |  1 +
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 5b78f3b1b918..666d03332944 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -368,6 +368,33 @@ int pci_pasid_features(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
> +/**
> + * pci_pggrp_rsp_need_pasid - Return PRG response PASID required bit status.

pci_prg_resp_pasid_required()?

"PRG" seems to be the standard spec terminology, so I think using
"pggrp" muddies the water a little bit.

> + * @pdev: PCI device structure
> + *
> + * Returns positive if PASID is required, 0 otherwise.
> + *
> + * Eventhough the PRG response PASID status is read from PRI status
> + * register, Since this API will mainly be used by PASID users, this
> + * function is defined within #ifdef CONFIG_PCI_PASID instead of
> + * CONFIG_PCI_PRI.

s/Eventhough/Even though/
s/Since/since/

> + *
> + */
> +int pci_pggrp_rsp_need_pasid(struct pci_dev *pdev)
> +{
> +	u16 status;
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return 0;
> +
> +	pci_read_config_word(pdev, pos + PCI_PRI_STATUS, &status);
> +
> +	return status & PCI_PRI_STATUS_PASID;
> +}
> +EXPORT_SYMBOL_GPL(pci_pggrp_rsp_need_pasid);
> +
>  #define PASID_NUMBER_SHIFT	8
>  #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>  /**
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 7c4b8e27268c..ea29c7c64482 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -40,6 +40,7 @@ void pci_disable_pasid(struct pci_dev *pdev);
>  void pci_restore_pasid_state(struct pci_dev *pdev);
>  int pci_pasid_features(struct pci_dev *pdev);
>  int pci_max_pasids(struct pci_dev *pdev);
> +int pci_pggrp_rsp_need_pasid(struct pci_dev *pdev);
>  
>  #else  /* CONFIG_PCI_PASID */
>  
> @@ -66,6 +67,10 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>  	return -EINVAL;
>  }
>  
> +static int pci_pggrp_rsp_need_pasid(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_PCI_PASID */
>  
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e1e9888c85e6..898be572b010 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -880,6 +880,7 @@
>  #define  PCI_PRI_STATUS_RF	0x001	/* Response Failure */
>  #define  PCI_PRI_STATUS_UPRGI	0x002	/* Unexpected PRG index */
>  #define  PCI_PRI_STATUS_STOPPED	0x100	/* PRI Stopped */
> +#define  PCI_PRI_STATUS_PASID	0x8000	/* PRG Response PASID Required */
>  #define PCI_PRI_MAX_REQ		0x08	/* PRI max reqs supported */
>  #define PCI_PRI_ALLOC_REQ	0x0c	/* PRI max reqs allowed */
>  #define PCI_EXT_CAP_PRI_SIZEOF	16
> -- 
> 2.20.1
> 
