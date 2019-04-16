Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA54C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7EC20880
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i4INWmBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfDPRzx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:55:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16352 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfDPRzw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 13:55:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb617230000>; Tue, 16 Apr 2019 10:55:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Apr 2019 10:55:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Apr 2019 10:55:50 -0700
Received: from [10.25.74.19] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Apr
 2019 17:55:44 +0000
Subject: Re: [PATCH V2 13/16] arm64: tegra: Enable PCIe slots in P2972-0000
 board
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>, <kishon@ti.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <lorenzo.pieralisi@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-14-git-send-email-vidyas@nvidia.com>
 <20190415151235.GH29254@ulmo>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <d020562a-d97c-7eae-cd4f-01e4df0ff686@nvidia.com>
Date:   Tue, 16 Apr 2019 23:25:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415151235.GH29254@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555437347; bh=NA09hSTwzj4+9peETlLcM5Mh7kA4wJJDZSW0zsGuB1c=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=i4INWmBqVuMCJB021yrPTM+zjHV+e5oH3xPjJUmOfwh4g5RirGijSl+/pTAlIeTog
         0paibHDXjJcgei4w0Leph9tFhvEpujRc5kRha5pxaulh0X7+klkp6Qc2KCjOj5etcv
         0HpaW7mDzXq+Jl29hOrlcpIzzaaEhWiVOK6WiJEtg9KC7w7NjSXmC8ru1pFmg0ibms
         jTKgkgrWmvolzV9oLwVAWdax2p2g2EkYeny9JtI6TVuZ3y/zh7qldVMeTmn0CjnO8l
         yMmUitSfpqCzwmJnGli/lMpiyrdzDwdy7lma8tDRG0156Vu6IFwoKwiiFuz4UxLCnn
         FtyhkLKXgtNIA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/15/2019 8:42 PM, Thierry Reding wrote:
> On Fri, Apr 05, 2019 at 01:24:40AM +0530, Vidya Sagar wrote:
>> Enable PCIe controller nodes to enable respective PCIe slots on
>> P2972-0000 board. Following is the ownership of slots by different
>> PCIe controllers.
>> Controller-0 : M.2 Key-M slot
>> Controller-1 : On-board Marvell eSATA controller
>> Controller-3 : M.2 Key-E slot
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> Changes since [v1]:
>> * Dropped 'pcie-' from phy-names property strings
>>
>>   arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |  2 +-
>>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 50 ++++++++++++++++++++++
>>   2 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> index 246c1ebbd055..13263529125b 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
>> @@ -191,7 +191,7 @@
>>   						regulator-boot-on;
>>   					};
>>   
>> -					sd3 {
>> +					vdd_1v8ao: sd3 {
>>   						regulator-name = "VDD_1V8AO";
>>   						regulator-min-microvolt = <1800000>;
>>   						regulator-max-microvolt = <1800000>;
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> index b62e96945846..82eb30bceaa6 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>> @@ -169,4 +169,54 @@
>>   			};
>>   		};
>>   	};
>> +
>> +	pcie@14180000 {
>> +		status = "okay";
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_2>,
>> +		       <&p2u_3>,
>> +		       <&p2u_4>,
>> +		       <&p2u_5>;
> 
> You can use multiple entries on a single line, especially if they are
> this short.
> 
>> +		phy-names = "p2u-0", "p2u-1", "p2u-2",
>> +			    "p2u-3";
> 
> Same here.
> 
>> +	};
>> +
>> +	pcie@14100000 {
>> +		status = "okay";
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_0>;
>> +		phy-names = "p2u-0";
>> +	};
>> +
>> +	pcie@14140000 {
>> +		status = "okay";
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_7>;
>> +		phy-names = "p2u-0";
>> +	};
>> +
>> +	pcie@141a0000 {
>> +		status = "disabled";
>> +
>> +		vddio-pex-ctl-supply = <&vdd_1v8ao>;
>> +
>> +		phys = <&p2u_12>,
>> +		       <&p2u_13>,
>> +		       <&p2u_14>,
>> +		       <&p2u_15>,
>> +		       <&p2u_16>,
>> +		       <&p2u_17>,
>> +		       <&p2u_18>,
>> +		       <&p2u_19>;
>> +
>> +		phy-names = "p2u-0", "p2u-1", "p2u-2",
>> +			    "p2u-3", "p2u-4", "p2u-5",
>> +			    "p2u-6", "p2u-7";
> 
> And here.
I'll take care of all these in V3 series.

> 
> Thierry
> 
>> +	};
>>   };
>> -- 
>> 2.7.4
>>

