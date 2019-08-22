Return-Path: <SRS0=DRQQ=WS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244EC3A59D
	for <linux-pci@archiver.kernel.org>; Thu, 22 Aug 2019 04:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A69C2339E
	for <linux-pci@archiver.kernel.org>; Thu, 22 Aug 2019 04:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ROuN6NSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfHVESe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Aug 2019 00:18:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15301 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfHVESe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 00:18:34 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5e179a0000>; Wed, 21 Aug 2019 21:18:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 21:18:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 21 Aug 2019 21:18:33 -0700
Received: from [10.24.47.72] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Aug
 2019 04:18:31 +0000
Subject: Re: [PATCH -next] PCI: tegra: Fix the error return code in
 tegra_pcie_dw_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20190822020352.35412-1-weiyongjun1@huawei.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <3038da4d-154a-16a8-4a1f-4dcce3e93cb8@nvidia.com>
Date:   Thu, 22 Aug 2019 09:48:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822020352.35412-1-weiyongjun1@huawei.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566447514; bh=BMpeZdixRD7N4xGpj4hhFWaDqnjlbOJumU2yCQur+xI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ROuN6NSrDyNPmYuaKPY5ChvaBQ8b82nscgFymCgi8wT6D89dNI00I2XCm7+wQC/Hp
         cdHrCWS8Q/0dXuyUVb4+Vm796mCEy6rDYIFhp48ysrYgPTnvuzZx15vgFy+ece0VtQ
         VAR6ZEBJZ8kyJs6S3gsuwnl/u4s+MuCxotoCamPOXfQ9LPY4kSbfuNHPX5Z2i8s7Se
         YGT/pmzOKXxMsuD3kKQROkcbcLEktU/fQQSA6Ke2B7VUQNxuwwJd/4k7DsPqBsaRy9
         R0s8hEvYrmodOYj0Ce3TLx8NeS9Wmv3mxm3qcRJw9syDWy3HnLbt47iML3JIf3cz6/
         FJaElRmv0eg/A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/22/2019 7:33 AM, Wei Yongjun wrote:
> Fix the error return code in tegra_pcie_dw_probe() by using error code
> instead of PTR_ERR(NULL) which is always 0.
> 
> Fixes: 6404441c8e13 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index fc0dbeb31d78..678a6b51c7aa 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1384,7 +1384,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   						      "appl");
>   	if (!pcie->appl_res) {
>   		dev_err(dev, "Failed to find \"appl\" region\n");
> -		return PTR_ERR(pcie->appl_res);
> +		return -ENODEV;
>   	}
>   
>   	pcie->appl_base = devm_ioremap_resource(dev, pcie->appl_res);
> @@ -1400,7 +1400,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   
>   	phys = devm_kcalloc(dev, pcie->phy_count, sizeof(*phys), GFP_KERNEL);
>   	if (!phys)
> -		return PTR_ERR(phys);
> +		return -ENOMEM;
>   
>   	for (i = 0; i < pcie->phy_count; i++) {
>   		name = kasprintf(GFP_KERNEL, "p2u-%u", i);
> @@ -1422,7 +1422,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>   	if (!dbi_res) {
>   		dev_err(dev, "Failed to find \"dbi\" region\n");
> -		return PTR_ERR(dbi_res);
> +		return -ENODEV;
>   	}
>   	pcie->dbi_res = dbi_res;
>   
> @@ -1437,7 +1437,7 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
>   						   "atu_dma");
>   	if (!atu_dma_res) {
>   		dev_err(dev, "Failed to find \"atu_dma\" region\n");
> -		return PTR_ERR(atu_dma_res);
> +		return -ENODEV;
>   	}
>   	pcie->atu_dma_res = atu_dma_res;
> 
Thanks for pushing this change.
BTW, did you use any infrastructure to simulate missing entries in device-tree to
see if the driver is returning error or not? Or you found out by just reviewing the code?

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> 
> 

