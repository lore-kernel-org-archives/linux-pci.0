Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3637BC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0116F218A1
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nfNeL0QY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDOSCP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:02:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14807 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfDOSCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 14:02:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4c7230000>; Mon, 15 Apr 2019 11:02:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 11:02:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 11:02:14 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 18:02:07 +0000
Subject: Re: [PATCH 28/30] dt-bindings: pci: tegra: Document nvidia,rst-gpio
 optional prop
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-29-mmaddireddy@nvidia.com> <20190415142012.GB29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <02b91c79-cb55-d6f9-f153-cadbfa9c8b8b@nvidia.com>
Date:   Mon, 15 Apr 2019 23:31:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415142012.GB29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555351331; bh=OWnRJD1VUc3ahBf2uPnV45ooKcoQ1aBSTGicw6uRXV0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=nfNeL0QYK5yJYpne8ypyrLcM70/6NkJS+jLIHVxySs3CSV7G8zSpGapqkjz7Nlcmd
         E49zvj7EN/KMe+vzPXtrd5vv8C+cTxPreGpulaxoZjFHwHs84k7M7pAqesn0a40Emp
         XG41rDraFmeYw4dihBfLjp7hdkgmHaR7tRqwiX2+QiseBZC0O6m31ZA2pRV+CgMW2m
         +MjF8QyZY81Q5LZxkq481Jzog/K0pnNqTjKHlBU74X5uH20FUVeghrM/cTBQwj5B66
         1Zgds0JroNgscknhddpWzupOffFMqggXG5MwQQEGgccL83ndj5jAB/pCLv3YpIoBtX
         l21tIC93EdqIA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:50 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:53PM +0530, Manikanta Maddireddy wrote:
>> Document "nvidia,rst-gpio" optional property which supports GPIO based
>> PERST# signal.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> index dca8393b86d1..23928fd59538 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> @@ -75,6 +75,8 @@ Optional properties:
>>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
>>  - nvidia,plat-gpios: A list of platform specific gpios which controls
>>    endpoint's internal regulator or PCIe logic.
>> +- nvidia,rst-gpio: If GPIO is used as PERST# signal instead of available
>> +  SFIO, add this property with phandle to GPIO controller and GPIO number.
> GPIO properties are pretty much standardized, so this should really be
> called just "reset-gpio".
>
> Also it looks like this is documented in the wrong place. In the example
> below you set this property for the root port, that is inside a child
> node of the PCI controller, but if I understand correctly, and it's hard
> to say from the context, the above is documented as part of the
> properties of the host bridge node.
>
> Thierry
I will correct this in V2.

Manikanta
>>  
>>  Required properties on Tegra124 and later (deprecated):
>>  - phys: Must contain an entry for each entry in phy-names.
>> @@ -671,6 +673,7 @@ Board DTS:
>>  
>>  		pci@1,0 {
>>  			nvidia,num-lanes = <4>;
>> +			nvidia,rst-gpio = <&tegra_main_gpio TEGRA_MAIN_GPIO(A, 3) 0>;
>>  			status = "okay";
>>  		};
>>  
>> -- 
>> 2.17.1
>>

