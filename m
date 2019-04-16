Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37805C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 06:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A7B2073F
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 06:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfDPG2G (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:28:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfDPG2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 02:28:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D654AA156125666E6E8D;
        Tue, 16 Apr 2019 14:28:03 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 14:27:53 +0800
Subject: Re: [PATCH] pci: fix warning for struct hisi_pcie_platform_ops
To:     Mao Wenan <maowenan@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>
References: <20190415085349.161915-1-maowenan@huawei.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5CB575E5.7000304@hisilicon.com>
Date:   Tue, 16 Apr 2019 14:27:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190415085349.161915-1-maowenan@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/4/15 16:53, Mao Wenan wrote:
> There is one warning exist while compiling drivers/pci/controller/dwc/pcie-hisi.c.
> make allmodconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> make C=2 drivers/pci/controller/dwc/pcie-hisi.o ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> drivers/pci/controller/dwc/pcie-hisi.c:365:21: warning: symbol 'hisi_pcie_platform_ops' was not declared. Should it be static?
> 
> Fixes: a2ec1996098("PCI: hisi: Add DT almost-ECAM support for Hip06/Hip07 host controllers")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>

Acked-by: Zhou Wang <wangzhou1@hisilicon.com>

Thanks,
Zhou

> ---
>  drivers/pci/controller/dwc/pcie-hisi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
> index 6d9e1b2..11f5ff7 100644
> --- a/drivers/pci/controller/dwc/pcie-hisi.c
> +++ b/drivers/pci/controller/dwc/pcie-hisi.c
> @@ -362,7 +362,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>  
> -struct pci_ecam_ops hisi_pcie_platform_ops = {
> +static struct pci_ecam_ops hisi_pcie_platform_ops = {
>  	.bus_shift    = 20,
>  	.init         =  hisi_pcie_platform_init,
>  	.pci_ops      = {
> 

