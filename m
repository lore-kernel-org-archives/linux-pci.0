Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4641FC65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 23:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A45220870
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 23:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544655829;
	bh=rCUFrWxgWufh5Jw7RzwGQ22WvDAuiy3dVXny+uMtL4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EvWf6uRHOet535OoRrpuiUDPz8S0LowiEAtK0u/KXDZin7ENlhyTN+GzDgGuLpIRt
	 cZQmMV7kGJKVJHPpWZ8mczxaPte/hm1z+kAqJJAFE+vcnhB/IiH9M4zIwkD++tR5SL
	 wxTX6t4CWsrT42kO2mKTjod55H9S1P/qbuvzqPqw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A45220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLLXDs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 18:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbeLLXDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 18:03:48 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857C620851;
        Wed, 12 Dec 2018 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544655826;
        bh=rCUFrWxgWufh5Jw7RzwGQ22WvDAuiy3dVXny+uMtL4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SzeZngOJs1rNv1igua9m9jEsgSpX/aqB271/ck6uaOr8u7Mj4HcBQMWfD/HvFHkSU
         pRQY5iAjlJHq5xfxulLsizvG+9Ju1TAyXvpyXaw2DkCw9oA6xG1/FEg6Oyq1S9dE8B
         j6EJ6RUfvFHlLPt+UcP9jAepw2jcRWDXP4DYZNm4=
Date:   Wed, 12 Dec 2018 17:03:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>
Subject: Re: [RFC 6/6] pci: pci_ids: Add Synopsys device id 0xedda
Message-ID: <20181212230345.GN99796@google.com>
References: <cover.1544610287.git.gustavo.pimentel@synopsys.com>
 <df5417ded1e55e5f994ab0ec7f696ddba83eaa35.1544610287.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5417ded1e55e5f994ab0ec7f696ddba83eaa35.1544610287.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 12:13:26PM +0100, Gustavo Pimentel wrote:
> Create and add Synopsys device id (0xedda) to pci id list, since this id
> is now being use on two different drivers (pci_endpoint_test.ko and
> dw-edma-pcie.ko).

Please run "git log --oneline include/linux/pci_ids.h" and make your
subject line match, i.e.,

  PCI: Add Synopsys endpoint EDDA Device ID

Also, if you want, you can reorder this to add the ID first and use it
in drivers/misc/pci_endpoint_test.c, and then just use it from the
first appearance of drivers/dma/dw-edma/dw-edma-pcie.c.  Either way is
fine.

For the include/linux/pci_ids.h change,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> ---
>  drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
>  drivers/misc/pci_endpoint_test.c   | 2 +-
>  include/linux/pci_ids.h            | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index f29a861..50e0db4 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -280,7 +280,7 @@ static const struct dev_pm_ops dw_edma_pcie_dev_pm_ops = {
>  };
>  
>  static const struct pci_device_id dw_edma_pcie_id_table[] = {
> -	{ PCI_DEVICE_DATA(SYNOPSYS, 0xedda, &snps_edda_data) },
> +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 896e2df..d27efe838 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -788,7 +788,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
> +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 69f0abe..57f17dd 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2358,6 +2358,7 @@
>  #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
>  
>  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
> +#define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
>  
>  #define PCI_VENDOR_ID_VITESSE		0x1725
>  #define PCI_DEVICE_ID_VITESSE_VSC7174	0x7174
> -- 
> 2.7.4
> 
