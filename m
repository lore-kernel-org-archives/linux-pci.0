Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFBEC10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4D21873
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KWaFbm1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfDOPZn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:25:43 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5345 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfDOPZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:25:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4a2720000>; Mon, 15 Apr 2019 08:25:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:25:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:25:41 -0700
Received: from [10.24.70.150] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:25:37 +0000
Subject: Re: [PATCH 17/30] PCI: tegra: Use switch statements in
 tegra_pcie_isr()
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-18-mmaddireddy@nvidia.com> <20190415132523.GS29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <a34fd1ff-67ad-5f1d-4ba2-12a5e48bf187@nvidia.com>
Date:   Mon, 15 Apr 2019 20:55:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415132523.GS29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555341938; bh=DoxrXCG4lrpj2r2A6VTefsO+MPxOoLBw9h/XYq3KUnE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=KWaFbm1D9XkouADd1oiQybttMT+Pz306Gc5tC5lMyP8M65mzCeq5Uni5Ktjh4fFks
         WXN+TwEqBlSPvkD81UP+9VlBDxBwsDPMCjIkLb0baIlKZxzLP96SFyVxGUL0jjaMg5
         vNgz6aleVN2TC/Tq8rPloJxYQSwMzG4GiuDfUGpYxKDEjzpwdLok6OXHRZMlnkt3Fx
         Cve0v9Sw4DYQQubZotuQS0tqRryDm4VPPPOO5yrDveMN6VjUrNJBVEXkAg71i+5I7I
         ++1YrohfpRT9EJxUD1tHMU0pZtC81dqfzh9Qzo3M7dSqEJhojnQZauxZkhYpS6Ibau
         SZCPlu2IE4ERg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 6:55 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:42PM +0530, Manikanta Maddireddy wrote:
>> Use switch statements in tegra_pcie_isr() for better code readability.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 37 ++++++++++++++++--------------
>>  1 file changed, 20 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index cdaaf13a9fd7..cf2715065a53 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -842,36 +842,39 @@ static irqreturn_t tegra_pcie_isr(int irq, void *arg)
>>  	};
>>  	struct tegra_pcie *pcie = arg;
>>  	struct device *dev = pcie->dev;
>> -	u32 code, signature;
>> +	u32 code, signature, fpci;
>> +	u64 address;
>>  
>>  	code = afi_readl(pcie, AFI_INTR_CODE) & AFI_INTR_CODE_MASK;
>>  	signature = afi_readl(pcie, AFI_INTR_SIGNATURE);
>>  	afi_writel(pcie, 0, AFI_INTR_CODE);
>>  
>> -	if (code == AFI_INTR_LEGACY)
>> -		return IRQ_NONE;
>> -
>>  	if (code >= ARRAY_SIZE(err_msg))
>> -		code = 0;
>> +		return IRQ_NONE;
>>  
>> +	switch (code) {
>> +	case AFI_INTR_LEGACY:
>> +		return IRQ_NONE;
>>  	/*
>>  	 * do not pollute kernel log with master abort reports since they
>>  	 * happen a lot during enumeration
>>  	 */
>> -	if (code == AFI_INTR_MASTER_ABORT)
>> +	case AFI_INTR_MASTER_ABORT:
>>  		dev_dbg(dev, "%s, signature: %08x\n", err_msg[code], signature);
>> -	else
>> +		fpci = afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
>> +		address = (u64)fpci << 32 | (signature & 0xfffffffc);
>> +		dev_dbg(dev, "  FPCI address: %10llx\n", address);
>> +		break;
>> +	case AFI_INTR_TARGET_ABORT:
>> +	case AFI_INTR_FPCI_DECODE_ERROR:
>>  		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
>> -
>> -	if (code == AFI_INTR_TARGET_ABORT || code == AFI_INTR_MASTER_ABORT ||
>> -	    code == AFI_INTR_FPCI_DECODE_ERROR) {
>> -		u32 fpci = afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
>> -		u64 address = (u64)fpci << 32 | (signature & 0xfffffffc);
>> -
>> -		if (code == AFI_INTR_MASTER_ABORT)
>> -			dev_dbg(dev, "  FPCI address: %10llx\n", address);
>> -		else
>> -			dev_err(dev, "  FPCI address: %10llx\n", address);
>> +		fpci = afi_readl(pcie, AFI_UPPER_FPCI_ADDRESS) & 0xff;
>> +		address = (u64)fpci << 32 | (signature & 0xfffffffc);
>> +		dev_err(dev, "  FPCI address: %10llx\n", address);
>> +		break;
>> +	default:
>> +		dev_err(dev, "%s, signature: %08x\n", err_msg[code], signature);
>> +		break;
>>  	}
>>  
>>  	return IRQ_HANDLED;
> I don't think this improves readability. It does duplicate some code and
> is actually longer than the previous variant, so I don't think this adds
> value.
>
> Thierry
There is multiple conditions check in single "if" statement and there is if-else statement
inside "if", so I felt switch case makes it more clear. I agree there is duplicate code.

Manikanta
