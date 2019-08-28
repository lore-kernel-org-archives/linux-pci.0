Return-Path: <SRS0=6piv=WY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB349C3A5A1
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AA422CF8
	for <linux-pci@archiver.kernel.org>; Wed, 28 Aug 2019 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ddOdhhcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfH1QQf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:16:35 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7261 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1QQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 12:16:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d66a8e40000>; Wed, 28 Aug 2019 09:16:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 28 Aug 2019 09:16:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 28 Aug 2019 09:16:34 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 16:16:33 +0000
Received: from [10.25.74.161] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Aug
 2019 16:16:28 +0000
Subject: Re: [PATCH V2 3/6] PCI: tegra: Add support to configure sideband pins
To:     Andrew Murray <andrew.murray@arm.com>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <gustavo.pimentel@synopsys.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190828131505.28475-1-vidyas@nvidia.com>
 <20190828131505.28475-4-vidyas@nvidia.com>
 <20190828150739.GX14582@e119886-lin.cambridge.arm.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <015280f6-cf13-9a36-6ae7-77476d089af4@nvidia.com>
Date:   Wed, 28 Aug 2019 21:46:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828150739.GX14582@e119886-lin.cambridge.arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567008996; bh=vkYR9GMGra4mXvzpjpzlucRSvf0JCKSyhfkQefgDo5g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ddOdhhcYgMCMUdb0NaOCMhghD3DAvywx7L0BfIq4QMvoctZLVx6TYtgcTOWclJqd1
         Kk5QMQWGX+FdIkHUG+yE+dFVqPPL2JPHnamym5DTHQJ5RrGsjvtzPckOR4ct3icH3n
         kCVV6C3TQnc35zWT2euvmQP/mBZ52L7x1JhVWJAgvn05Mi5U8tbzCM6htKUHVtGfl6
         xYhsu/1q0UBrr458CbH/lzSxu99dJmrc1xEPJJ3IMYPLXhWR0TKHihzHQNrpli90zw
         FtrGsKFehb71WlKSxCLC9ZxPCmQYeXv7qntl9qOoeOh8VaCFgBbrNAorTAI4jyOjwX
         df6qf8GLoa4GA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/28/2019 8:37 PM, Andrew Murray wrote:
> On Wed, Aug 28, 2019 at 06:45:02PM +0530, Vidya Sagar wrote:
>> Add support to configure sideband signal pins when information is present
>> in respective controller's device-tree node.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V2:
>> * Addressed review comment from Andrew Murray
>> * Handled failure case of pinctrl_pm_select_default_state() cleanly
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index fc0dbeb31d78..057ba4f9fbcd 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -1304,8 +1304,13 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to get runtime sync for PCIe dev: %d\n",
>>   			ret);
>> -		pm_runtime_disable(dev);
>> -		return ret;
>> +		goto fail_pm_get_sync;
>> +	}
>> +
>> +	ret = pinctrl_pm_select_default_state(pcie->dev);
> 
> This patch looks OK, though you're still using pcie->dev here instead of dev.
I'll take care of this.
Thanks for the thorough review.

- Vidya Sagar

> 
> Thanks,
> 
> Andrew Murray
> 
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
>> +		goto fail_pinctrl;
>>   	}
>>   
>>   	tegra_pcie_init_controller(pcie);
>> @@ -1332,7 +1337,9 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>>   
>>   fail_host_init:
>>   	tegra_pcie_deinit_controller(pcie);
>> +fail_pinctrl:
>>   	pm_runtime_put_sync(dev);
>> +fail_pm_get_sync:
>>   	pm_runtime_disable(dev);
>>   	return ret;
>>   }
>> -- 
>> 2.17.1
>>

