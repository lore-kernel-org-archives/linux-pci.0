Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A6C282DA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 19:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475E1217FA
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530499;
	bh=eGZIH1j5aHLmXDg/L+dky5LAU15lpR120g+KfFXu1Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WdF/oR3H5VzmvQImxrXgs/RR1fQ1ZMbkEjXH8U8tZpvdgA0j4gfoDLsntsU8XfdH8
	 0+Py/RNuWtwCiQC18vnR5C+DzatSJEdzwLY2fZcw00gcL8TDgfWhev8iNCoFsKSgCV
	 EBaw+L6X6DjpOSq6BR3yQ8/xwpAcPxNRTlofl8UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732731AbfDQTsS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfDQTsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Apr 2019 15:48:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B636205C9;
        Wed, 17 Apr 2019 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555530497;
        bh=eGZIH1j5aHLmXDg/L+dky5LAU15lpR120g+KfFXu1Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1HiLnkNh0eFB3sALCNyGZ3En7o4R97MLBoKHqM6WapogYTEaRZXExR2tuajTfA6oB
         nV9NapbSYmCuuF6+fkZJVhei9hqnQ2JahFVdSmXNquU+odAWz9MvNuKXPuKqnMou+H
         1N6aYcZqiqjALTei2cNkfqnowwRCVrRBWduA5XA0=
Date:   Wed, 17 Apr 2019 14:48:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        okaya@kernel.org, zhongmiao@hisilicon.com, eric.auger@redhat.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/9] PCI: Add a stub for pci_ats_disabled()
Message-ID: <20190417194816.GB18308@google.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
 <20190417182448.12382-3-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-3-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 17, 2019 at 07:24:41PM +0100, Jean-Philippe Brucker wrote:
> Currently pci_ats_disabled() is only defined when CONFIG_PCI is enabled.
> Since we're about to use the function in the Arm SMMUv3 driver, which
> could be built with CONFIG_PCI disabled, add a definition of
> pci_ats_disabled() for !CONFIG_PCI.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 169c6a18d0b0..61d7cd888bad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1713,6 +1713,7 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>  							 struct pci_dev *dev)
>  { return NULL; }
> +static inline bool pci_ats_disabled(void) { return true; }
>  #endif /* CONFIG_PCI */
>  
>  #ifdef CONFIG_PCI_ATS
> -- 
> 2.21.0
> 
