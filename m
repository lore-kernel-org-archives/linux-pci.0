Return-Path: <SRS0=qLqV=WL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC6AC31E40
	for <linux-pci@archiver.kernel.org>; Thu, 15 Aug 2019 04:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221FC2171F
	for <linux-pci@archiver.kernel.org>; Thu, 15 Aug 2019 04:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565844509;
	bh=eJoKIAKFOaVxC/CSNxG99YuD4m+X/ugeNrGPcSoTiAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M+zAcqAhzVywBq0cAX7Z0vkg7SLLfkssGRhPSuSuulzXyb7aSf0QECuLM216uVT9X
	 tkIvYxxG9THAE2kBPtSGJtfOTO+aFq2KqXvz+0Rp+USkOqPeeUzvPPdcuKssd1kR9+
	 M7lcpwLIbAvCVbNmAQ809vML1C2kp+kIEBaan4yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfHOEs2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfHOEs2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 00:48:28 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FDDD2067D;
        Thu, 15 Aug 2019 04:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565844507;
        bh=eJoKIAKFOaVxC/CSNxG99YuD4m+X/ugeNrGPcSoTiAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGUiFK0iNyMhj0wJolegwNmoUdH7PxzwSqC2romohG0/Boa6PyZmpAIxyrCN1kTFD
         cbsqcAuHjt2+bM8v4T06KK4YTQBwNoda8ujhNTX3Y7pSuNLMFjYs6PNIIn92Y37b9J
         zB6otBvA9ambess7rG/CmEhpHVxt1T4kDHCwQ8Po=
Date:   Wed, 14 Aug 2019 23:48:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 3/7] PCI/ATS: Initialize PASID in pci_ats_init()
Message-ID: <20190815044826.GE253360@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5edb0209f7657e0706d4e5305ea0087873603daf.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:06:00PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, PASID Capability checks are repeated across all PASID API's.
> Instead, cache the capability check result in pci_pasid_init() and use
> it in other PASID API's. Also, since PASID is a shared resource between
> PF/VF, initialize PASID features with default values in pci_pasid_init().
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c       | 74 +++++++++++++++++++++++++++++------------
>  include/linux/pci-ats.h |  5 +++
>  include/linux/pci.h     |  1 +
>  3 files changed, 59 insertions(+), 21 deletions(-)
> 

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 280be911f190..1f4be27a071d 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -30,6 +30,8 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  
>  	pci_pri_init(dev);
> +
> +	pci_pasid_init(dev);
>  }
>  
>  /**
> @@ -315,6 +317,40 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>  #endif /* CONFIG_PCI_PRI */
>  
>  #ifdef CONFIG_PCI_PASID
> +
> +void pci_pasid_init(struct pci_dev *pdev)
> +{
> ...
> +}

> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 33653d4ca94f..bc7f815d38ff 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -40,6 +40,7 @@ static inline int pci_reset_pri(struct pci_dev *pdev)
>  
>  #ifdef CONFIG_PCI_PASID
>  
> +void pci_pasid_init(struct pci_dev *pdev);

This also looks like it should be static in ats.c.

>  int pci_enable_pasid(struct pci_dev *pdev, int features);
>  void pci_disable_pasid(struct pci_dev *pdev);
>  void pci_restore_pasid_state(struct pci_dev *pdev);
> @@ -48,6 +49,10 @@ int pci_max_pasids(struct pci_dev *pdev);
>  
>  #else  /* CONFIG_PCI_PASID */
>  
> +static inline void pci_pasid_init(struct pci_dev *pdev)
> +{
> +}
> +
>  static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	return -EINVAL;
