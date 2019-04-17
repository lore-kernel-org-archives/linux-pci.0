Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E1C282DC
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 19:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800D42183F
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530471;
	bh=d8gKCuw8mxLdXW711uuIWJMqzQlgj1Z+FJteTwebKrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZoD+ftvKKTarMXdJf5KaGP3Nheu0Ze3guIbwrQYtzIPYlrgtrrjBozvzy8Auppb3c
	 5+Qb7TIsmsGK1A72yTJewoUGO6b1CMTo5pCbTDRKZYQRa2LaU/xw5I1diI+FYAo87O
	 Tee5OMFS06nX5w22TO9w0zd1f8VxdeZkRQ4cSjQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfDQTru (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfDQTru (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 15:47:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61F83205C9;
        Wed, 17 Apr 2019 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555530469;
        bh=d8gKCuw8mxLdXW711uuIWJMqzQlgj1Z+FJteTwebKrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POWFFCG4Gh0+ASda6B5d1ZcY25xjayK0cI8+3hVO5LhNFFNQSkpO4DoKiFlYK0bHP
         xDy8CgNNAcflM1fbAHjtZKshkG4yyligOflFqkIEGFP5Dfj6zobbfOoy77NJf2cz31
         ci1xGoEyh/DsL8ViNusv88PJmh138nZUMhLK181I=
Date:   Wed, 17 Apr 2019 14:47:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: Move ATS declarations outside of CONFIG_PCI
Message-ID: <20190417194747.GA18308@google.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
 <20190417182448.12382-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 07:24:40PM +0100, Jean-Philippe Brucker wrote:
> At the moment, the ATS functions are only defined when CONFIG_PCI is
> enabled. Since we're about to use them in the Arm SMMUv3 driver, which
> could be built with CONFIG_PCI disabled, and they are already guarded by
> CONFIG_PCI_ATS which depends on CONFIG_PCI, move the definitions outside
> of CONFIG_PCI.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

I guess this is OK with me, although AFAICS they're only used in
arm_smmu_enable_ats() and arm_smmu_disable_ats() and I personally
wouldn't find it objectionable to wrap the bodies of those functions
in "#ifdef CONFIG_PCI".  That might even be a useful hint to the
reader, as opposed to relying on all these stub functions
(dev_is_pci(), pci_ats_disabled(), pci_enable_ats(),
pci_disable_ats(), as well as the complete struct pci_dev declaration)
that depend on config settings that aren't obvious in the caller.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..169c6a18d0b0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1521,21 +1521,6 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  
>  bool pci_ats_disabled(void);
>  
> -#ifdef CONFIG_PCI_ATS
> -/* Address Translation Service */
> -void pci_ats_init(struct pci_dev *dev);
> -int pci_enable_ats(struct pci_dev *dev, int ps);
> -void pci_disable_ats(struct pci_dev *dev);
> -int pci_ats_queue_depth(struct pci_dev *dev);
> -int pci_ats_page_aligned(struct pci_dev *dev);
> -#else
> -static inline void pci_ats_init(struct pci_dev *d) { }
> -static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> -static inline void pci_disable_ats(struct pci_dev *d) { }
> -static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> -static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> -#endif
> -
>  #ifdef CONFIG_PCIE_PTM
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
>  #else
> @@ -1730,6 +1715,21 @@ static inline const struct pci_device_id *pci_match_id(const struct pci_device_i
>  { return NULL; }
>  #endif /* CONFIG_PCI */
>  
> +#ifdef CONFIG_PCI_ATS
> +/* Address Translation Service */
> +void pci_ats_init(struct pci_dev *dev);
> +int pci_enable_ats(struct pci_dev *dev, int ps);
> +void pci_disable_ats(struct pci_dev *dev);
> +int pci_ats_queue_depth(struct pci_dev *dev);
> +int pci_ats_page_aligned(struct pci_dev *dev);
> +#else
> +static inline void pci_ats_init(struct pci_dev *d) { }
> +static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> +static inline void pci_disable_ats(struct pci_dev *d) { }
> +static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> +static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> +#endif
> +
>  /* Include architecture-dependent settings and functions */
>  
>  #include <asm/pci.h>
> -- 
> 2.21.0
> 
