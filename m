Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF08C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B06B2147C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YKnJ5KAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfDOPM7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:12:59 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3644 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfDOPM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:12:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb49f670002>; Mon, 15 Apr 2019 08:12:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 08:12:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 08:12:58 -0700
Received: from [10.24.70.150] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 15:12:54 +0000
Subject: Re: [PATCH 14/30] PCI: tegra: Set target speed as Gen1 before link up
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-15-mmaddireddy@nvidia.com> <20190415115218.GP29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <75493937-fd77-024b-0e07-62ecc009c917@nvidia.com>
Date:   Mon, 15 Apr 2019 20:42:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415115218.GP29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555341159; bh=n5/zWvssIxk0EjRIhdyufdR/rmLEKHNSmrEg09fhlec=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=YKnJ5KAaCI2/awPujIHVYZCzpGBu2cXPMv5z70H2rHR1EuJaI1GzrcpU7k4LIYd4s
         SZSytj+6DOXBOe/LtV7THBsGYUAMwV7mxDaqvVN9PixS+noWfkP9xjQMTkXp2gIvpA
         UB5yV+t0x4eV7mW+VNh3pWuesfBLDmzlvL/5SFbKFHlFVAV6xFGM4Ih3ygYL9y8iO7
         gNjJNcrmtoFA7iUZyKiWAm1LFiiKdrwW8Qh8b/4ewxln8uoRE52j8WuJtTm08OPn4P
         KW5Z96pZOjgU6M4oNMt1OkaN71JfdjRsCIa+NasaWs3XnkFzpiAvxEyrestNNyuq/H
         QSZCSSgFD1M7Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 5:22 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:39PM +0530, Manikanta Maddireddy wrote:
>> Some of the legacy PCIe endpoints doesn't enumerate if root port advertises
>> both Gen-1 and Gen-2 speeds. Hence, the strategy followed here is to
>> initially advertise only Gen-1 and after link is up, retrain link to Gen-2
>> speed.
>>
>> Following two cards display this behaviour,
>>   - Fusion HDTV 5 Express card
>>   - IOGear SIL - PCIE - SATA card
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 7dc728cc5f51..7e24eac12668 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -670,6 +670,17 @@ static void tegra_pcie_apply_sw_fixup(struct tegra_pcie_port *port)
>>  		value |= soc->update_fc_val;
>>  		writel(value, port->base + RP_VEND_XP);
>>  	}
>> +
>> +	/*
>> +	 * PCIe link doesn't come up with few legacy PCIe endpoints
>> +	 * if root port advertises both Gen-1 and Gen-2 speeds.
>> +	 * Hence, the strategy followed here is to initially advertise
>> +	 * only Gen-1 and after link is up, retrain link to Gen-2 speed
>> +	 */
>> +	value = readl(port->base + RP_LINK_CONTROL_STATUS_2);
>> +	value &= ~PCI_EXP_LNKSTA_CLS;
>> +	value |= PCI_EXP_LNKSTA_CLS_2_5GB;
>> +	writel(value, port->base + RP_LINK_CONTROL_STATUS_2);
>>  }
>>  
>>  static void tegra_pcie_port_enable(struct tegra_pcie_port *port)
> This looks like it's related to the earlier patch that adds support for
> retraining the link at Gen-2. As such, I think the two patches should be
> moved closer together to make that more obvious.
>
> Also, perhaps even the order needs to be changed. For example, if the
> earlier patch enables advertisement of Gen-2, then there will be a
> period of 10 or so patches where the above devices wouldn't work. So if
> this fixes an error introduced by an earlier patch, it makes sense to
> resort the patches so that we first fix the potential error and then
> introduce the code that would cause the error to happen.
>
> Thierry
Both are independent patches. Even though HW init Target speed is Gen2, Tegra
PCIe gets the link up in Gen1 only because HW autonomous speed change feature
is not available. After link up in Gen1 SW has to retrain the link to Gen2, which is
done in 4/30. Current patch changes the HW init value of Target speed to Gen1,
to support the cards mentioned in commit message.
