Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69579C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3863B2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jwutfQGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfDOPy7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:54:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6042 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOPy7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:54:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4a93f0002>; Mon, 15 Apr 2019 08:54:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:54:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:54:58 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:54:40 +0000
Subject: Re: [PATCH 04/30] PCI: tegra: Add PCIe Gen2 link speed support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-5-mmaddireddy@nvidia.com> <20190415112108.GE29254@ulmo>
 <5b3b5882-b841-658b-57dd-1572f20dab69@nvidia.com>
 <20190415153651.GL29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <ab436004-248f-3874-a48f-7be5463f2edf@nvidia.com>
Date:   Mon, 15 Apr 2019 21:23:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415153651.GL29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555343679; bh=pzEMMfELgAOfDtT/r+u/PPGDD24KdQ/sRANHSbhv4Hg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=jwutfQGPVd9Z5LsoDKyzVRBTxxhk91BYDnChlQF34C5Wu+9ul8M/74atdaw5tTcSX
         qPvVeU8GRD8yV6EyP1iHppuO6fHCmWD8lRCaV96OW/vBE9ckJm4kXojJYD+kk6hzPf
         9TI6Of4w7XioxbOXwJ2xRbIf4cDtGa4D8kImLS3nztraW8YDYdAqBuzKAv+8ZxCoBS
         /zuwnvVFxegyJwKO8JQX9454dULIlaVPXB548UgKvwKabPZsy0wOZUqiV5OFJaAsAk
         dY/uHl4rIaXO1X4/EVISQVBPLomuBBsiwWuM9uUSD8sqJNgb/a33jUnCYnht2cZQxD
         ReAH13uEY2T1A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 9:06 PM, Thierry Reding wrote:
> On Mon, Apr 15, 2019 at 08:17:02PM +0530, Manikanta Maddireddy wrote:
>>
>> On 15-Apr-19 4:51 PM, Thierry Reding wrote:
>>> On Thu, Apr 11, 2019 at 10:33:29PM +0530, Manikanta Maddireddy wrote:
>>>> Tegra124, 132, 210 and 186 support Gen2 link speed. After PCIe link is up
>>>> in Gen1, set target link speed as Gen2 and retrain link. Link switches to
>>>> Gen2 speed if Gen2 capable end point is connected, else link stays in Gen1.
>>>>
>>>> Per PCIe 4.0r0.9 sec 7.6.3.7 implementation note, driver need to wait for
>>>> PCIe LTSSM to come back from recovery before retraining the link.
>>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>>  drivers/pci/controller/pci-tegra.c | 61 ++++++++++++++++++++++++++++++
>>>>  1 file changed, 61 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>>>> index a61ce9d475b4..6ccda82735f8 100644
>>>> --- a/drivers/pci/controller/pci-tegra.c
>>>> +++ b/drivers/pci/controller/pci-tegra.c
>>>> @@ -191,6 +191,8 @@
>>>>  #define  RP_LINK_CONTROL_STATUS_DL_LINK_ACTIVE	0x20000000
>>>>  #define  RP_LINK_CONTROL_STATUS_LINKSTAT_MASK	0x3fff0000
>>>>  
>>>> +#define RP_LINK_CONTROL_STATUS_2		0x000000b0
>>>> +
>>>>  #define PADS_CTL_SEL		0x0000009c
>>>>  
>>>>  #define PADS_CTL		0x000000a0
>>>> @@ -2096,6 +2098,62 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
>>>>  		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
>>>>  }
>>>>  
>>>> +#define LINK_RETRAIN_TIMEOUT 100000
>>> This is oddly placed. I think this should go somewhere near the top of
>>> the file. We already have PME_ACK_TIMEOUT there.
>>>
>>> But to be honest, I wouldn't even bother with the #define. This is used
>>> exactly twice and is much longer to type than the actual number.
>> I will move #define to top of the file. Macro name tells us what this timeout,
>> so I will keep the macro intact.
>>>> +
>>>> +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie)
>>>> +{
>>>> +	struct device *dev = pcie->dev;
>>>> +	struct tegra_pcie_port *port, *tmp;
>>>> +	ktime_t deadline;
>>>> +	u32 val;
>>> The driver uses u32 value for register values elsewhere. It'd be good to
>>> stay consistent with that convention.
>> Do you mean "unsigned long"? I observed this discrepancy, in few places u32 is used
>> and in some places "unsigned long" is used to store register value. I am continuing
>> to u32 and we need a new patch to change all "unsigned long" variables to u32
>> which are used to store register values.
> I meant to say that we spell out "value" everywhere else and don't use
> the abbreviation.
>
> Thierry
Got it, I will take care of it in V2.
