Return-Path: <SRS0=ROz5=S4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE0C43219
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20A42067C
	for <linux-pci@archiver.kernel.org>; Fri, 26 Apr 2019 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NtF6jaDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfDZQ1U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:27:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38618 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZQ1T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Apr 2019 12:27:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so1814908plb.5
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2019 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFTDFIiGeBY+s6YmepTrCsCQDN9X74pQQ9rzxjiOPX4=;
        b=NtF6jaDLLrHyEtIJFx8/rKFNFS+LN7qfUj9Q0eAPjr6VPTFtDj0oJk+4k8siiDiOWf
         OItvidXvmoYcII1hUkRPFdaKgvgGnmnobxPhZU3cDkBvX0QQ7evdfdIjS3Aq0gXhBSAQ
         7MVjbaif3+hER4lYOogeZ5TZr2446dKiQFQvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFTDFIiGeBY+s6YmepTrCsCQDN9X74pQQ9rzxjiOPX4=;
        b=fXdI4w9wocEwnGzXQ/yzzkqbV59IxmX3uwlYK/ioZ+VgQezwuhohBA9gd+gdPwAe1H
         PWjcU1FQptabbLwGT/iIKiwT35odhqCmdflGFqQoGOvhi9KQyrTo7PZO+QUtP4vdWNTZ
         cEMumLj+WZ/WIZv05Klqu3VlRCD/yoIq9q+SHX5IGEKyy6hzDBgWEN1bnRHdrpHW7guc
         i2ItsDMLT8824U0CkzN2dfnpcXR3zUtKEOsHj4c4/HBiCPdFvLP77CmI7trybNdA8Yi5
         pwQhyApxBJuu/o6UTTbvh4gcSnPaixOUP+YLqFT+QgaX7fvmfGXeMAnmSrmQGVyBI51K
         EmVA==
X-Gm-Message-State: APjAAAWahlvQsAbAsAgHZ6c71ezqJAKvu8b4NScIXrR8ZOS7M0ytoqBR
        b+P1ohfBXu0WcWxroWlvjjwICw==
X-Google-Smtp-Source: APXvYqwkyWGFDtYvUde2dNIWk2Qp6UYEnUMtU+jmrJdlRlyJ/j7fzMb7mDS0z3HzgbL2rzOzdxTgGA==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18mr38572018plp.187.1556296038843;
        Fri, 26 Apr 2019 09:27:18 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 19sm35180404pga.88.2019.04.26.09.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:27:17 -0700 (PDT)
Subject: Re: [PATCH] PCI: iproc: Enable iProc config read for PAXBv2
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1556270404-27058-1-git-send-email-srinath.mannam@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <83a11790-64d8-6f4d-a772-9dcc81411e21@broadcom.com>
Date:   Fri, 26 Apr 2019 09:27:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556270404-27058-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Srinath,

On 4/26/2019 2:20 AM, Srinath Mannam wrote:
> iProc config read flag has to enable for PAXBv2 instead of PAXB.
> 
> Fixes: f78e60a29d4ff ("PCI: iproc: Reject unconfigured physical functions from PAXC")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index c20fd6b..9d5cbc7 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1347,7 +1347,6 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
>  		break;
>  	case IPROC_PCIE_PAXB:
>  		regs = iproc_pcie_reg_paxb;
> -		pcie->iproc_cfg_read = true;
>  		pcie->has_apb_err_disable = true;
>  		if (pcie->need_ob_cfg) {
>  			pcie->ob_map = paxb_ob_map;
> @@ -1356,6 +1355,7 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
>  		break;
>  	case IPROC_PCIE_PAXB_V2:
>  		regs = iproc_pcie_reg_paxb_v2;
> +		pcie->iproc_cfg_read = true;
>  		pcie->has_apb_err_disable = true;
>  		if (pcie->need_ob_cfg) {
>  			pcie->ob_map = paxb_v2_ob_map;
> 

Fix looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
