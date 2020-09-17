Return-Path: <SRS0=aHqq=C2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB895C433E2
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 16:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B99621D90
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600361622;
	bh=6+WiNVNUK0WVAF4Ka/mkudbm4081hA29z9BacHCkjUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ytoClPXXIl3BHihFKQYzFv1PIc3kT5JxQUQanOKgND1POS6WMZjS/edw0fpVYRxZz
	 JEEa39QhN780FX89qI1y+9EqQbCH2kySf0BKjR9biKMUlMEZbmg/0DCxSsYH3e+/Qt
	 TVISGqQm1CaIneM0fy3XGvxo3oFhFA4BkxlLcAc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgIQQxl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Sep 2020 12:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbgIQQxJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 12:53:09 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DAB7206E6;
        Thu, 17 Sep 2020 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600361504;
        bh=6+WiNVNUK0WVAF4Ka/mkudbm4081hA29z9BacHCkjUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eNHTEuAQxtV1/GcQH7qv1k8d4vHIxPDIIyneSiNWeItqDAUu8Pg6rANV7qEmA1lTw
         6DWTsoNDKg5ftjisEQtZTXh6PjmUQsinh8crAWipysDShqoUOHb/8gLBw0DV9Oueu/
         6LzPG0NX2hiDFP2RVKuPEnKjWTv9wFyUtXzNnBts=
Date:   Thu, 17 Sep 2020 11:51:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: Re: [PATCH -next] PCI/IOV: use module_pci_driver to simplify the code
Message-ID: <20200917165143.GA1707439@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917071042.1909191-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alexander]

On Thu, Sep 17, 2020 at 03:10:42PM +0800, Liu Shixin wrote:
> Use the module_pci_driver() macro to make the code simpler
> by eliminating module_init and module_exit calls.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Applied to pci/misc for v5.10, thanks!

> ---
>  drivers/pci/pci-pf-stub.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
> index a0b2bd6c918a..45855a5e9fca 100644
> --- a/drivers/pci/pci-pf-stub.c
> +++ b/drivers/pci/pci-pf-stub.c
> @@ -37,18 +37,6 @@ static struct pci_driver pf_stub_driver = {
>  	.probe			= pci_pf_stub_probe,
>  	.sriov_configure	= pci_sriov_configure_simple,
>  };
> -
> -static int __init pci_pf_stub_init(void)
> -{
> -	return pci_register_driver(&pf_stub_driver);
> -}
> -
> -static void __exit pci_pf_stub_exit(void)
> -{
> -	pci_unregister_driver(&pf_stub_driver);
> -}
> -
> -module_init(pci_pf_stub_init);
> -module_exit(pci_pf_stub_exit);
> +module_pci_driver(pf_stub_driver);
>  
>  MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 
