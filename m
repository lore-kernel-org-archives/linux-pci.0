Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4730C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 23:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FF4218A6
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 23:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549063190;
	bh=g1mezfgWxOBeEihWUpSlMncrogrq+7+PvctfxDm16vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oflUJ5G2k7d//MR+iN0A7OthQy3qCCT6ryJ3I+Ghk3E18KbZsaxfMbhUajrX52aoJ
	 DIPZu/S1P1LWyP/NdDq+4+k5fUP6mzxwRgdsNEU2Y29ZUSpIWyhNyJobLCMp6mFIkJ
	 B1Je99cskq5MeTUFdESd7eCzfa3GjizvmjFsR33Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbfBAXTu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfBAXTu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 18:19:50 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3303A214C6;
        Fri,  1 Feb 2019 23:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549063189;
        bh=g1mezfgWxOBeEihWUpSlMncrogrq+7+PvctfxDm16vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FLuSpk8fAGdtvV2L1/DhHyaIlsXqIgXrPZ1xdU/07a0e9utzDUjUsdR1bXwQPoYMS
         znNNvQD2mnpx592ZlfJnj7VQ28DTcW9NW2xqy/uPsK3iiwOlnT3aqu6mIjPk3tCk4M
         VK/k6B8wr4C/kcWFz/sQZa/zLkETNHeu2m0Dh4Ss=
Date:   Fri, 1 Feb 2019 17:19:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunyong Yang <shunyong.yang@hxt-semitech.com>
Cc:     okaya@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH v2 1/2] PCI: Add HXT vendor ID and ACS quirk
Message-ID: <20190201231947.GV229773@google.com>
References: <bcaf1d5d-23a6-d4e6-08e8-587daf6cca06@kernel.org>
 <ccf67e5f70f2d09d07268a5735ac6cee801eb9ca.1541574331.git.shunyong.yang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccf67e5f70f2d09d07268a5735ac6cee801eb9ca.1541574331.git.shunyong.yang@hxt-semitech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 03:24:12PM +0800, Shunyong Yang wrote:
> Add the HXT vendor ID to pci_ids.h and use it in quirks. As the
> design of HXT SD4800 ACS feature is the same as QCOM QDF2xxx,
> pci_quirk_qcom_rp_acs() is reused for SD4800 quirk.
> 
> cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>

I applied both of these to pci/misc for v5.1, thanks!

As I'm sure you know, both the ACS and the pciehp issues are cases where
the part does not conform to the PCIe spec.  Hopefully future parts will
change the design so they *do* conform to the spec so we don't have to add
quirks for every new part.  Adding quirks works around the problem, but
it's a hassle for customers (and developers and distributors) because they
need kernel updates when they wouldn't otherwise.

Bjorn

> ---
> v2:
>   Add Reviewed-by: Sinan Kaya.
> 
> v1:
>   Initial version.
> ---
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..1e00ef6a88f4 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4495,6 +4495,8 @@ static int pci_quirk_mf_endpoint_acs(struct pci_dev *dev, u16 acs_flags)
>  	/* QCOM QDF2xxx root ports */
>  	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
>  	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
> +	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
> +	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
>  	/* Intel PCH root ports */
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_pch_acs },
>  	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, pci_quirk_intel_spt_pch_acs },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe1ba1a..e60a6bc38298 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2565,6 +2565,8 @@
>  
>  #define PCI_VENDOR_ID_HYGON		0x1d94
>  
> +#define PCI_VENDOR_ID_HXT		0x1dbf
> +
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
>  
> -- 
> 1.8.3.1
> 
