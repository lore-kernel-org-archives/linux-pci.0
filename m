Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE0C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 07:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C52171F
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 07:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Tm5QnHe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDLHCB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:02:01 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17377 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLHCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 03:02:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb037e60000>; Fri, 12 Apr 2019 00:01:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 00:02:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 12 Apr 2019 00:02:00 -0700
Received: from [10.24.70.250] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 07:01:56 +0000
Subject: Re: [PATCH 26/30] dt-bindings: pci: tegra: Document nvidia,plat-gpios
 optional prop
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190411170355.6882-1-mmaddireddy@nvidia.com>
 <20190411170355.6882-27-mmaddireddy@nvidia.com>
 <20190411201813.GT256045@google.com>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <477907b6-deb5-0a0f-19af-9b68dc9bf71b@nvidia.com>
Date:   Fri, 12 Apr 2019 12:31:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411201813.GT256045@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555052518; bh=o7+iOvtHRQU2BpXjojOwT2sXgTfmxodumGAP1G5ZeBU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=Tm5QnHe8hXw9uQeezAp68aDuSrjXNJR47jLwfeaVV2pl2hcjDfQW8S5cDz5kXZ1EB
         L63mH+/DxH8zhM/9rcxCL86ceMpg8wePp3byvW2Nl4Wx686ovkN4/HDUDCOsXzBigj
         l6hEvenwi8apIRlvzzQhLR/e3Cn6g3QIA5HyCQVOMh/heZPpIDYPsaLaiPX3P5SfzO
         uGPSntrbbxxfaGceJIivUek8KeYCCFb+pFGzZIhn3UaYrR1T63fKPeknF/DsWAf1vZ
         Wf6BgNPzHtZvxVX7Y0dz/OPyBuxbNkNVUzbed2hu68oj2Sa0QeqQO0GKzO8upqTKgW
         cJ67kd0DCxkTg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 12-Apr-19 1:48 AM, Bjorn Helgaas wrote:
> On Thu, Apr 11, 2019 at 10:33:51PM +0530, Manikanta Maddireddy wrote:
>> Document "nvidia,plat-gpios" optional property which supports configuring
>> of platform specific gpios.
> s/gpios/GPIOs/ (also in the description below)
>
> Acronyms in commit logs, comments, printks, etc should be capitalized.
I will take care of it in next version.
>
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
>>  
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
>> -- 
>> 2.17.1
>>
