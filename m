Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB1C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372AA218A1
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Aa9+iYlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfDOSGS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:06:18 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14619 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfDOSGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 14:06:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4c8060000>; Mon, 15 Apr 2019 11:05:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 11:06:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 11:06:17 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 18:05:46 +0000
Subject: Re: [PATCH 30/30] PCI: tegra: Change link retry log level to INFO
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-31-mmaddireddy@nvidia.com> <20190415142338.GD29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <26c565cb-1eee-3314-cb50-c36e102b322d@nvidia.com>
Date:   Mon, 15 Apr 2019 23:35:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415142338.GD29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555351558; bh=9hny0GU0PVPQuUon8vo5c0DeoBN1v3yIBjB2d/KHWuo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=Aa9+iYlu7tSCzMBcVfMpQQpnDLNBTa3FP5yCrnZQSF+S0vI0jZ2mOHq8DuBQakb9y
         1lBskS8ktwtH5cUGCwZZNmx/cqSrtK8TX4PXcNGXKMONUkPcNzxe3y+KyeXGJFx+2D
         D2is2NJsKlvsBpdUiBjRM8EVba4ehyVgNnF6eUmqEZf8AnX+4r0v6/DnVjwm8obFl+
         Ke/t94k56jP2lm90zJ7DVw4jM7s2Gqc+xj/T/J5yZojmG/8Whh1cFlkFz2BKXNO42S
         v2dJvy0FKon6QT60k+g+z2blrRIlwOvLnOJuz6HPVq3zkxrG8PLf+VVrvR8LCdmaCw
         N+9NpwVBTGzEw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:53 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:55PM +0530, Manikanta Maddireddy wrote:
>> Link retry log is info log not error, so change it to INFO log level.
> The wording here is confusing. The log is clearly error level right now.
> Perhaps you meant to say something like this:
>
>     Letting users know that a link is down and in the process of being
>     brought up again is informational, not an error condition.
>
> Thierry
I will update in V2.

Manikanta
>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  drivers/pci/controller/pci-tegra.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index 75873e6627f9..55f8ff4f3e07 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -2461,7 +2461,7 @@ static bool tegra_pcie_port_check_link(struct tegra_pcie_port *port)
>>  		} while (--timeout);
>>  
>>  		if (!timeout) {
>> -			dev_err(dev, "link %u down, retrying\n", port->index);
>> +			dev_info(dev, "link %u down, retrying\n", port->index);
>>  			goto retry;
>>  		}
>>  
>> -- 
>> 2.17.1
>>

