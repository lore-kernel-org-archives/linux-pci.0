Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A37C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C52218DA
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LXSEReN4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfDOSFS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:05:18 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15032 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfDOSFR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 14:05:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4c7d90000>; Mon, 15 Apr 2019 11:05:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 11:05:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 11:05:16 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 18:04:35 +0000
Subject: Re: [PATCH 29/30] PCI: tegra: Add support for GPIO based PCIe reset
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-30-mmaddireddy@nvidia.com> <20190415142058.GC29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <e8645ef4-eb84-b692-def7-ecaf0f7df4a2@nvidia.com>
Date:   Mon, 15 Apr 2019 23:33:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415142058.GC29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555351513; bh=dQysmyT9KsoVQ2NdLB4PQ76psXsAzT8xZkrvsrNLeWA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=LXSEReN4HYAIOwRcL+L0YPq00ehiTYtqgN/KXh5bBUtAMJUAlbLBvUJurM7oIsAxZ
         v5LiAgrZhjL+U93ut+jSrHWNuvLyGik8nlURMUx8RxsAQLQrFId+9I2R1hpz9S6uiv
         HMqqrpP9eRXeNOwPuzEds7GKLsqhMvQS1j0zE4bG72pEtj19zVMjNLbxRZTFDmTCQe
         eQM1OejbUCPwVWwbD8WgTxah4iudaqczIku+ud4dnFnWjDbKG6cyemdsv8y031u6UO
         J5wkHpsQMMvEnhB1aBD0KAYx8QVU565LpHjLeE93O0fZW2gACi3xk+xlge6+xcpTJJ
         LSt9NkGqSWEAg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:50 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:54PM +0530, Manikanta Maddireddy wrote:
>> Add support for GPIO based PERST# instead of SFIO mode controller by AFI.
>> GPIO number comes from per port PCIe device tree node.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 37 +++++++++++++++++++++++++-----
>>  1 file changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 4a91c9fb3a9d..75873e6627f9 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/debugfs.h>
>>  #include <linux/delay.h>
>>  #include <linux/export.h>
>> +#include <linux/gpio.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/iopoll.h>
>>  #include <linux/irq.h>
>> @@ -26,6 +27,7 @@
>>  #include <linux/module.h>
>>  #include <linux/msi.h>
>>  #include <linux/of_address.h>
>> +#include <linux/of_gpio.h>
>>  #include <linux/of_pci.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/pci.h>
>> @@ -406,6 +408,7 @@ struct tegra_pcie_port {
>>  
>>  	int n_gpios;
>>  	int *gpios;
>> +	int rst_gpio;
> This should be using GPIO descriptor APIs.
>
> Thierry
I will take care of it in V2.

Manikanta
>
>>  };
>>  
>>  struct tegra_pcie_bus {
>> @@ -589,15 +592,23 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
>>  	unsigned long value;
>>  
>>  	/* pulse reset signal */
>> -	value = afi_readl(port->pcie, ctrl);
>> -	value &= ~AFI_PEX_CTRL_RST;
>> -	afi_writel(port->pcie, value, ctrl);
>> +	if (gpio_is_valid(port->rst_gpio)) {
>> +		gpio_set_value(port->rst_gpio, 0);
>> +	} else {
>> +		value = afi_readl(port->pcie, ctrl);
>> +		value &= ~AFI_PEX_CTRL_RST;
>> +		afi_writel(port->pcie, value, ctrl);
>> +	}
>>  
>>  	usleep_range(1000, 2000);
>>  
>> -	value = afi_readl(port->pcie, ctrl);
>> -	value |= AFI_PEX_CTRL_RST;
>> -	afi_writel(port->pcie, value, ctrl);
>> +	if (gpio_is_valid(port->rst_gpio)) {
>> +		gpio_set_value(port->rst_gpio, 1);
>> +	} else {
>> +		value = afi_readl(port->pcie, ctrl);
>> +		value |= AFI_PEX_CTRL_RST;
>> +		afi_writel(port->pcie, value, ctrl);
>> +	}
>>  }
>>  
>>  static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
>> @@ -2241,6 +2252,20 @@ static int tegra_pcie_parse_plat_dt(struct tegra_pcie_port *port,
>>  		}
>>  	}
>>  
>> +	port->rst_gpio = of_get_named_gpio(np, "nvidia,rst-gpio", 0);
>> +	if (gpio_is_valid(port->rst_gpio)) {
>> +		err = devm_gpio_request(dev, port->rst_gpio, "pex_rst_gpio");
>> +		if (err < 0) {
>> +			dev_err(dev, "rst_gpio request failed: %d\n", err);
>> +			return err;
>> +		}
>> +		err = gpio_direction_output(port->rst_gpio, 0);
>> +		if (err < 0) {
>> +			dev_err(dev, "rst_gpio set o/p failed: %d\n", err);
>> +			return err;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.17.1
>>

