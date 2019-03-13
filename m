Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B35C43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5537D2171F
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 10:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YWT4M/EO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfCMKiE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:38:04 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59038 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMKiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 06:38:04 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 2271D24E0969;
        Wed, 13 Mar 2019 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1552473484; bh=fRn9dW93qpk3SMK4vDY3nYibYTYJ+W1xRSlyuh38EnI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=YWT4M/EO3kG6bfAhgfbQ4ETsL4XqQEDrU4UCxjJhkoQVe/OSjudAmt5XRojW/Sepk
         jGu8E03KQefZkorGB6Dk14skPNCcav2jLHIHjb0OnLX4cANmElahfo0a7aWiBHDMl8
         ie8OvFxuQDbr6Gu15rF/BT8Znr0miUqVsd5jkuR5PNJO1hkyQCCTXwK2VlIcPfKimY
         e7zdz76MeSBwMF6RWJqm8D14OW5AY9MZ/9jk76M0D+lYRU9pYR2zyV9MW1A2tt9yl0
         UVJ2Pv8TTVUjw23klDflheIIAoR+PmGxjLGWz7JdIB71Fno3lxiNYaygwosOg0NKhD
         qVRj4HBRJwcyQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D2FA9A0097;
        Wed, 13 Mar 2019 10:38:03 +0000 (UTC)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 03:38:03 -0700
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:38:01 +0100
Received: from [10.107.19.55] (10.107.19.55) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 11:38:01 +0100
Subject: Re: [PATCH v2 4/5] PCI: dwc: Use devm_pci_alloc_host_bridge() to
 simplify the code
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190301125510.4e2ee985@xhacker.debian>
 <20190301125901.5ee7730c@xhacker.debian>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <3b1a5c1e-e458-20cf-51ce-1a7846ebf8c0@synopsys.com>
Date:   Wed, 13 Mar 2019 10:37:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190301125901.5ee7730c@xhacker.debian>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.55]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 01/03/2019 05:06, Jisheng Zhang wrote:
> Use devm_pci_alloc_host_bridge() to simplify the error code path.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 66569d0f3ab9..4831c12fee93 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -357,7 +357,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		dev_err(dev, "Missing *config* reg space\n");
>  	}
>  
> -	bridge = pci_alloc_host_bridge(0);
> +	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
>  		return -ENOMEM;
>  
> @@ -368,7 +368,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  
>  	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
>  	if (ret)
> -		goto error;
> +		return ret;
>  
>  	/* Get the I/O and memory ranges from DT */
>  	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
> @@ -412,8 +412,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  						resource_size(pp->cfg));
>  		if (!pci->dbi_base) {
>  			dev_err(dev, "Error with ioremap\n");
> -			ret = -ENOMEM;
> -			goto error;
> +			return -ENOMEM;
>  		}
>  	}
>  
> @@ -424,8 +423,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  					pp->cfg0_base, pp->cfg0_size);
>  		if (!pp->va_cfg0_base) {
>  			dev_err(dev, "Error with ioremap in function\n");
> -			ret = -ENOMEM;
> -			goto error;
> +			return -ENOMEM;
>  		}
>  	}
>  
> @@ -435,8 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  						pp->cfg1_size);
>  		if (!pp->va_cfg1_base) {
>  			dev_err(dev, "Error with ioremap\n");
> -			ret = -ENOMEM;
> -			goto error;
> +			return -ENOMEM;
>  		}
>  	}
>  
> @@ -459,14 +456,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			    pp->num_vectors == 0) {
>  				dev_err(dev,
>  					"Invalid number of vectors\n");
> -				goto error;
> +				return -EINVAL;
>  			}
>  		}
>  
>  		if (!pp->ops->msi_host_init) {
>  			ret = dw_pcie_allocate_domains(pp);
>  			if (ret)
> -				goto error;
> +				return ret;
>  
>  			if (pp->msi_irq)
>  				irq_set_chained_handler_and_data(pp->msi_irq,
> @@ -475,7 +472,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		} else {
>  			ret = pp->ops->msi_host_init(pp);
>  			if (ret < 0)
> -				goto error;
> +				return ret;
>  		}
>  	}
>  
> @@ -515,8 +512,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  err_free_msi:
>  	if (IS_ENABLED(CONFIG_PCI_MSI) && !pp->ops->msi_host_init)
>  		dw_pcie_free_msi(pp);
> -error:
> -	pci_free_host_bridge(bridge);
>  	return ret;
>  }
>  
> 

Nice!

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
