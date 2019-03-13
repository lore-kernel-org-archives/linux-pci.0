Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ABEC43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 18:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C802075C
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 18:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xf/whbTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMS3o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:29:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35752 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfCMS3o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 14:29:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id t18so3125619wrx.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2019 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yCGlUYyvseuMdq+fHdqMPEdXXQajF2Y1L5aFQYQJj2I=;
        b=Xf/whbTwsOJFPCBuPse4L3OlK6L7vPQxh+qcYOqdikOV4PRIlGr7U/1ekqT3m8S7V7
         WJ0fx5Ew167o/FBrU6a2z3E7ip+CSFfANPSVS6FUwwNha71if75RS+JIlImh+44c2LFV
         dRT7PbzZFim4gAjC7kRU2LVjNvtg5gZozQ6rfEWfDLY8domR8UF1/maLhI4Ag2nL6KzV
         LKjBkfEQXhDQe6Cn0Vrd0CuE9IVJqQHPMOYu/SZDB1TzcHyljE98ESoQJsec7aj5R+Xs
         0+Wx3SY/sAVlu7/b+Whex7frGoTgYIFSa6qduhRBpplnxalYRkjrPVfQjKq96k4g/5XP
         hEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yCGlUYyvseuMdq+fHdqMPEdXXQajF2Y1L5aFQYQJj2I=;
        b=cnEQfGOkPmdtrzgR8YY6732fBDtDACYhwPo508TPwz5Vyh691rSM69agZ4BVvXNnI2
         esZUYqDa+MDTob5h5eJlBnqCTD6RXoIlX9mSSLQ3IBiiCqg5bxemmr+yI0ypvApOqeUC
         6ZoUpfLwbppuNoEdnvlX5SkEUsDPhpJ+jOp6Cv0tMcKDAWwCBkh6YNzs91ekpvYEydB8
         2RKWKMX2JvBxS7L7+leT79L1S5i/SsZ0dtlBt0T1X/cGzTmlGGCOg495iQnbZcH/gA6h
         Zda90jda/mEj6vDK66wkVCO6XC/HD5Qka4cVbezkGGnp733MgDa5ijrn/e0fNjlD5DCc
         iCTQ==
X-Gm-Message-State: APjAAAVdJ5plr2zvfO3CgJ37VrO5gLr/JXf+TcaFKytM1IXmbRauX8+7
        GWn8cZfejSU6OyyyUiIu/UxZXnAEcuQ=
X-Google-Smtp-Source: APXvYqzWeaJmJym2U45c/HmcNke+nnSTFQ8QoqdxZ3mEdK5+8HSo1Gneqed0MwW+FU17dyAndMYhkg==
X-Received: by 2002:adf:f343:: with SMTP id e3mr27220725wrp.205.1552501782261;
        Wed, 13 Mar 2019 11:29:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id t69sm4002749wmt.16.2019.03.13.11.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:29:41 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: qcom: Use default config space read function
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <94bb3f22-c5a7-1891-9d89-42a520e9a592@free.fr>
 <65321fe3-ca29-c454-63ae-98a46c2e5158@mm-sol.com>
 <1205cbfb-ac06-63a5-9401-75d4e68b15b5@free.fr>
 <38ad143b-3b07-4d19-8ccd-ca39fb51e53d@free.fr>
 <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3c76613e-e60d-94b8-dd6f-b8f4e1928263@linaro.org>
Date:   Wed, 13 Mar 2019 18:29:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <7d3d788a-d6a3-a70b-adab-6c65771cacc4@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 13/03/2019 11:45, Marc Gonzalez wrote:
> We don't need to fudge the device class in qcom_pcie_rd_own_conf()
> because dw_pcie_setup_rc() already does the right thing:
> 
> 	/* Program correct class for RC */
> 	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Changes from v1 to v2: Completely drop qcom_pcie_rd_own_conf
> Srinivas, could you test this patch on apq/ipq8064?
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
I tried this patch on IFC6410 board which has APQ8064, and the pci does 
not work anymore after applying this patch.

non-working output of 'lspci -vvv' 
https://paste.ubuntu.com/p/ndmdsW4zkJ/ and bootlog 
ahttps://paste.ubuntu.com/p/CqVzGymnq8/

working without patch : https://paste.ubuntu.com/p/TJm4hgjGW4/

I have not debugged it any further other than just testing the patch.
Let me know if you need any more dumps for more debug.

Thanks,
srini

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3de5510fd3d5..d0c5c7616b3e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1131,25 +1131,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>   	return ret;
>   }
>   
> -static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> -				 u32 *val)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -
> -	/* the device class is not reported correctly from the register */
> -	if (where == PCI_CLASS_REVISION && size == 4) {
> -		*val = readl(pci->dbi_base + PCI_CLASS_REVISION);
> -		*val &= 0xff;	/* keep revision id */
> -		*val |= PCI_CLASS_BRIDGE_PCI << 16;
> -		return PCIBIOS_SUCCESSFUL;
> -	}
> -
> -	return dw_pcie_read(pci->dbi_base + where, size, val);
> -}
> -
>   static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>   	.host_init = qcom_pcie_host_init,
> -	.rd_own_conf = qcom_pcie_rd_own_conf,
>   };
>   
>   /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> 
