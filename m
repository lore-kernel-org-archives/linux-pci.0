Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8DC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD14520818
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 17:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qHI9HUQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfDOR7E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:59:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4281 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfDOR7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 13:59:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4c66b0000>; Mon, 15 Apr 2019 10:59:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 10:59:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 10:59:02 -0700
Received: from [10.24.70.150] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 17:58:51 +0000
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document nvidia,plat-gpios
 optional prop
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com> <20190415141654.GA29254@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <b575fd56-0d31-bbe2-deef-5a21d6e4b33e@nvidia.com>
Date:   Mon, 15 Apr 2019 23:28:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415141654.GA29254@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555351147; bh=u29FCoUdZfu2TbF1TlU7wtsmcVpPKbjIGyJjBkv4deI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=qHI9HUQoU0E0R+xyBV35PY5JiAtECzlMl55DNgXf+bNlftIFl1cxdhK6ATCjdE1JY
         DjHa3vI/X6W/a7NA7UU5UoQOB0byo4MrmkfZg/12eg5IiubklfsK9RNXD9MNHrbZdb
         yyZzFIAUczYdBi3ECMJWDgDQVeYEx1OM9duGWYAPAdVWIaha/TO6nbokKIBcOquA1M
         m0X9q8GZNVPXXuE9oe3z3SEJ58wm72HaAT4nc4GjPqEwZCPQVZCYxmMI6C78HAacjf
         04cz+eLCkKBEOxKjKPwDun4hTU5ikusRmFLIAHeH0br1lKVczXgJmxzxRQVVlBI5lx
         aQDRJnZxauOGA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15-Apr-19 7:46 PM, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
>> Document "nvidia,plat-gpios" optional property which supports configuring
>> of platform specific gpios.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> index fbbd3bcb3435..dca8393b86d1 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>> @@ -73,6 +73,8 @@ Optional properties:
>>    pinctrl phandle to allow driver to explicitly put PCIe IO in DPD state.
>>  - pinctrl-1: PCIe IO(bias & REFCLK) deep power down(DPD) enable state.
>>    Pass pinctrl phandle to allow driver bring PCIe IO out of DPD state.
>> +- nvidia,plat-gpios: A list of platform specific gpios which controls
>> +  endpoint's internal regulator or PCIe logic.
> We discussed this with Vidya during review of the Tegra194 PCIe device
> tree bindings and arrived at the conclusion that all of the GPIOs that
> need to be controlled for PCI to work can be modelled as proper device
> nodes (I think regulator and GPIO-controlled muxes were the only two
> use-cases for which we need this).
>
> Can the same be done for this PCI controller? What use-cases are we
> talking about?
In Tegra194 case it is apt to use regulator framework because gpios are used
to control regulators. However I published this patch to control vendor defined
gpios in endpoints. For ex: isolate gpio in RTL8111. Since I am not sure if
regulator framework is apt, I published as gpio patch.
>>  Required properties on Tegra124 and later (deprecated):
>>  - phys: Must contain an entry for each entry in phy-names.
>> @@ -567,6 +569,7 @@ Board DTS:
>>  		pci@2,0 {
>>  			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
>>  			phy-names = "pcie-0";
>> +			nvidia,plat-gpios = <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
>>  			status = "okay";
>>  		};
>>  	};
> I recall this being the setup for Jetson Nano and the X.3 GPIO going to
> an Ethernet device. Let's find out what exactly this GPIO is used for
> and why we need it to be set up as part of the PCI controller driver
> rather than the Ethernet device.
>
> If it turns out we can't model this other than with a generic GPIO type
> of property we need a better explanation than the above, and the Jetson
> Nano use-case would provide that explanation.
>
> And if indeed we cannot model this more accurately, I think we should
> use something like the gpio-hog binding rather than some custom PCI
> controller property.
>
> Thierry
Yes, in Jetson Nano gpio x.3 is controlling isolate pin of RTL8111.
RTL8111 datasheet available online says that as long as isolate
pin is asserted it'll not sample RX lanes and doesn't drive TX lanes.
Since RTL8111 PCIe IP should be active when PCIe host driver is
attempting link up, this gpio can be controlled by host driver only.

I didn't go for gpio-hog because this gpio should be asserted
during suspend, to enable wake on LAN.

Manikanta
