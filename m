Return-Path: <SRS0=aHqq=C2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42409C43461
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 01:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC60520770
	for <linux-pci@archiver.kernel.org>; Thu, 17 Sep 2020 01:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600307572;
	bh=neceQT6+xGjn6pOGNbJTvuTFtnkTlyf8OtQvnCuaUEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q5RQBOWFakvtWrJH1Jz0x1JmK8FJrlw6ZrTr8qbQtwajKq1w1FbE2kWSezyo4izD6
	 RafL+NrU/vBloRKR2HHNg0noFenWHXy6TLeI24g1yT4EWs9SlatIH3zxLBWPcTbvp/
	 GxQ3RjgOOA8jZCz+8XID1K3DTYQ4/ENhmWeQe4iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgIQBwt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Sep 2020 21:52:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43526 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIQBws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 21:52:48 -0400
Received: by mail-io1-f68.google.com with SMTP id z25so402132iol.10;
        Wed, 16 Sep 2020 18:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eeo2RxIy09U3tisfj7sBhkZOIk4q9g2XE/z4whZwqUA=;
        b=VKvawtrbKeud7wt2MBz0dL6srq13WxBpvOIwvUwOTd2f6K5I0BKkvafGXVke8vqAfa
         egu0zDRneKT7+0ZY0jpDdVGUCWZIMOjUdSXXnFDM4JQL3SAciTSwWYRh6P/RmfgyLo9+
         IiAcfkKIqFgfvA/RvskKs/kfvnL7lHSdzXcc4K+tGkbJaD2LpOD/ttNK1DHW6WWHOhu1
         5+IhAp7I5NCEQ8x6WUfbCXJuKllaALMpbjImkL64mdXCrLsGDzBucBQlsyN2NNNKefpK
         0fvv7q6QF010Z/nwbo5Sxzj7kx5WFVzoa7WerTNvCu/5uvOGPB9D4yvA3m9DrswLJSbX
         7FuQ==
X-Gm-Message-State: AOAM532chYa9Ya0NE6gL56i6cyofcgnTKJFTGvCYH5QJ4S+gnqCjshfK
        w9Da6ULV6pStO7bmZreKYg==
X-Google-Smtp-Source: ABdhPJwY6xr3vb1swKAQ5WvmeGwOnOBoBbtymdMSqkRnDHosXTbREj7fm0gsF54+Ft9qfMhdo+0Ahg==
X-Received: by 2002:a6b:e206:: with SMTP id z6mr21772899ioc.208.1600307568030;
        Wed, 16 Sep 2020 18:52:48 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w70sm11885701ilk.87.2020.09.16.18.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 18:52:47 -0700 (PDT)
Received: (nullmailer pid 680592 invoked by uid 1000);
        Thu, 17 Sep 2020 01:52:45 -0000
Date:   Wed, 16 Sep 2020 19:52:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>, linux-pci@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] PCI: iproc: Display PCIe Link information
Message-ID: <20200917015245.GA678675@bogus>
References: <20200915134541.14711-1-srinath.mannam@broadcom.com>
 <20200915134541.14711-4-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915134541.14711-4-srinath.mannam@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 15, 2020 at 07:15:41PM +0530, Srinath Mannam wrote:
> After successful linkup more comprehensive information about PCIe link
> speed and link width will be displayed to the console.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index cc5b7823edeb..8ef2d1fe392c 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1479,6 +1479,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  {
>  	struct device *dev;
>  	int ret;
> +	struct pci_dev *pdev;
>  	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>  
>  	dev = pcie->dev;
> @@ -1542,6 +1543,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>  		goto err_power_off_phy;
>  	}
>  
> +	for_each_pci_bridge(pdev, host->bus) {
> +		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +			pcie_print_link_status(pdev);
> +	}

If this information is useful for 1 host implementation, why not all of 
them and put this in a common spot.

Rob
