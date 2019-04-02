Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65429C43381
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 08:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E1620830
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 08:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="XIbYFjU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfDBIIP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:08:15 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:46291 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBIIP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 04:08:15 -0400
Received: from [10.71.15.162] (unknown [147.50.13.10])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 13127CE33;
        Tue,  2 Apr 2019 11:08:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1554192492; bh=DknWXun24RTH1a1SWb1YAKOhyo9gwYcwyQNCnGwpFVE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XIbYFjU4DprTLHHbB9AM+TdhLQZVtNkv/fcL78o6p7C+TlHxniFikKDa4W9TooAi1
         rlqL9YluKslTah7D9j2Z25GYWaBxrazGsWjp8X8LxFsJHxwUi2j6vefSEpBvIlOPXO
         msEX4Sr2vcde4L7/y23KKBN6QkTnfUOj/sxw6OpTqfF1bWhujmZl2t2zESSmqid3Ue
         yeL/Ivo3ZKHxr6FCH3rNlH9ExqWF0S9mHd5QDYNCyQpEu6xWrCUWmkTOwXfHxosJRJ
         e/gjubmAQ0QtpYt7nKqIq+MrXJUtbrXo2bEB52D0/P5iYlsPK0zoQxBwKPbcOe8I8o
         CCuDxs/j48v+g==
Subject: Re: [PATCH v1 1/3] PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
 <958ae127-3aa2-6824-c875-e3012644ed3d@free.fr>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <58b4db00-a0fa-5058-99ee-c11c8e2fa529@mm-sol.com>
Date:   Tue, 2 Apr 2019 11:08:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <958ae127-3aa2-6824-c875-e3012644ed3d@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Thank you for the work on that!

On 3/28/19 7:01 PM, Marc Gonzalez wrote:
> Initialize PCIE20_PARF_BDF_TRANSLATE_N for ops_2_3_2.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0ed235d560e3..5e5522a427b8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -54,6 +54,7 @@
>  #define PCIE20_PARF_LTSSM			0x1B0
>  #define PCIE20_PARF_SID_OFFSET			0x234
>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
> +#define PCIE20_PARF_BDF_TRANSLATE_N		0x250
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> @@ -602,6 +603,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>  	val |= BIT(31);
>  	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  
> +	val = PCI_DEVID(1, 0);
> +	writel(val, pcie->parf + PCIE20_PARF_BDF_TRANSLATE_N);

I wonder, shouldn't this register manipulation happen in common code
e.g. pcie-designware-host.c and of course the manipulation should be
conditional because not all platforms might have iommu.

Also, could we have more generic iommu-map description like the one for
sdm845 at [1] ?

-- 
regards,
Stan
