Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF0C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84994206B6
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 12:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84994206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeK2XNz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:13:55 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:28162 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeK2XNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 18:13:55 -0500
Received: from [10.18.29.147] (10.18.29.147) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 29 Nov
 2018 20:08:57 +0800
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
To:     Dan Carpenter <dan.carpenter@oracle.com>, <kbuild@01.org>
CC:     <kbuild-all@01.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>
References: <20181129090340.GO3073@unbuntlaptop>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <6da0ecdc-47e6-960e-c84e-2eb30632c317@amlogic.com>
Date:   Thu, 29 Nov 2018 20:08:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181129090340.GO3073@unbuntlaptop>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.147]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018/11/29 17:03, Dan Carpenter wrote:
> Hi Yue,
> 
> url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/dt-bindings-PCI-meson-add-DT-bindings-for-Amlogic-Meson-PCIe-controller/20181122-225955
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> 
> smatch warnings:
> drivers/pci/controller/dwc/pci-meson.c:171 meson_pcie_get_mem_shared() error: passing non negative 6 to ERR_PTR
> 
> # https://github.com/0day-ci/linux/commit/c882cdc75e49b6de65cd3d95ebf688272af6b5f9
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout c882cdc75e49b6de65cd3d95ebf688272af6b5f9
> vim +171 drivers/pci/controller/dwc/pci-meson.c
> 
> c882cdc75 Yue Wang 2018-11-22  160  
> c882cdc75 Yue Wang 2018-11-22  161  static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
> c882cdc75 Yue Wang 2018-11-22  162  					       struct meson_pcie *mp,
> c882cdc75 Yue Wang 2018-11-22  163  					       const char *id)
> c882cdc75 Yue Wang 2018-11-22  164  {
> c882cdc75 Yue Wang 2018-11-22  165  	struct device *dev = mp->pci.dev;
> c882cdc75 Yue Wang 2018-11-22  166  	struct resource *res;
> c882cdc75 Yue Wang 2018-11-22  167  
> c882cdc75 Yue Wang 2018-11-22  168  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
> c882cdc75 Yue Wang 2018-11-22  169  	if (!res) {
> c882cdc75 Yue Wang 2018-11-22  170  		dev_err(dev, "No REG resource %s\n", id);
> c882cdc75 Yue Wang 2018-11-22 @171  		return ERR_PTR(ENXIO);
>                                                                ^^^^^
>                                                                -ENXIO
> 
> c882cdc75 Yue Wang 2018-11-22  172  	}
> c882cdc75 Yue Wang 2018-11-22  173  
> c882cdc75 Yue Wang 2018-11-22  174  	return devm_ioremap(dev, res->start, resource_size(res));
> c882cdc75 Yue Wang 2018-11-22  175  }
> c882cdc75 Yue Wang 2018-11-22  176  
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> .
> 

Yes, it's really a silly mistake. 
I'll fix it.

thanks.
