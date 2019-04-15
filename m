Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB8C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BD72146E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="drwhkWOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfDOOtq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:49:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12625 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDOOtq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 10:49:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb49a0e0000>; Mon, 15 Apr 2019 07:49:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 07:49:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 15 Apr 2019 07:49:45 -0700
Received: from [10.24.70.150] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 14:49:42 +0000
Subject: Re: [PATCH 05/30] PCI: tegra: Advertise PCIe Advanced Error Reporting
 (AER) capability
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-6-mmaddireddy@nvidia.com> <20190415112321.GF29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <be5b0ef9-ccb9-c850-12f8-96bb5eb9ed45@nvidia.com>
Date:   Mon, 15 Apr 2019 20:19:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415112321.GF29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555339791; bh=5MfL8xU3gNo++B5CrJH9QeO3bikIAWWVHbG41iA/l4A=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=drwhkWOm5MU1XVTMcjnr/JMKlJduWImSIYI2NJukay5q9p35jstcAHLLSB/yk3BPs
         WqTgh5Wr5S4qtuJP0o0cjhrn4Dv4Wrn5WBBzCRY72sjdu1gPJ4fb6GEi5jFZ8khJ/8
         e8VOpPv8Jn7r1EP87dewX98Xhb1wT4W9nC+MCKNWhl86RzyJadRB/YeeW0PeWsOiB/
         aWsQzEtKt8CuG+rjClOnXcKGrAZ66u+kvRKt98CS5UCjnyIBN0xrGa/5UnfHASutlA
         pLgv87t+oB81AQEXCNWEzaA90tFDmPtJp+Awac4jT/0FDqQmirvdiT2jyDVlTHndLa
         sQTEjipzLwT8A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 4:53 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:30PM +0530, Manikanta Maddireddy wrote:
>> Default root port setting hides AER capability. This patch enables the
>> advertisement of AER capability by root port.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 6ccda82735f8..9ff1a0e2797f 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -180,6 +180,9 @@
>>  #define RP_VEND_XP	0x00000f00
>>  #define  RP_VEND_XP_DL_UP	(1 << 30)
>>  
>> +#define RP_VEND_CTL1	0x00000f48
>> +#define  RP_VEND_CTL1_ERPT	(1 << 13)
>> +
>>  #define RP_VEND_CTL2 0x00000fa8
>>  #define  RP_VEND_CTL2_PCA_ENABLE (1 << 7)
>>  
>> @@ -478,6 +481,16 @@ static void tegra_pcie_port_reset(struct tegra_pcie_port *port)
>>  	afi_writel(port->pcie, value, ctrl);
>>  }
>>  
>> +static void tegra_pcie_enable_rp_features(struct tegra_pcie_port *port)
> Why not call this tegra_pcie_enable_aer()? Are you planning on adding a
> lot more overrides to this function? If there aren't too many, you may
> want to just have one small function per feature and drop the comment in
> the function body.
>
> If there's going to be a lot, the above seems okay.
>
> Thierry
Yes, I am going to add more overrides.
>> +{
>> +	u32 value;
>> +
>> +	/* Enable AER capability */
>> +	value = readl(port->base + RP_VEND_CTL1);
>> +	value |= RP_VEND_CTL1_ERPT;
>> +	writel(value, port->base + RP_VEND_CTL1);
>> +}
>> +
>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>>  {
>>  	unsigned long ctrl = tegra_pcie_port_get_pex_ctrl(port);
>> @@ -502,6 +515,8 @@ static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
>>  		value |= RP_VEND_CTL2_PCA_ENABLE;
>>  		writel(value, port->base + RP_VEND_CTL2);
>>  	}
>> +
>> +	tegra_pcie_enable_rp_features(port);
>>  }
>>  
>>  static void tegra_pcie_port_disable(struct tegra_pcie_port *port)
>> -- 
>> 2.17.1
>>

