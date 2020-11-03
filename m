Return-Path: <SRS0=8M4G=EJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A10C4742C
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 02:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A4922243
	for <linux-pci@archiver.kernel.org>; Tue,  3 Nov 2020 02:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CqPgPiOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCCTG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Nov 2020 21:19:06 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43998 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCCTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 21:19:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A32Ixvk116417;
        Mon, 2 Nov 2020 20:18:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604369939;
        bh=pxVD0Y8rm2OksWXogd9PKo7OgRR//q33FB505JhqllU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CqPgPiOw7NFyZeR3mPBho+EWhQGeEcPsKN1R0JhbXKyzaIlxd0hnt5tgXGapHORTz
         dpzmpDTkTk91ToZCENTOVGn02JIaJ2mVI4teZy2aF5cIrHF8NHjNGD0gOzrSvuAyLE
         tUul7l7ljgp8lFA6HD2B0PZCewkc89QazY9jW4RI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A32IxqL071624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 20:18:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 20:18:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 20:18:58 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A32IssU060640;
        Mon, 2 Nov 2020 20:18:56 -0600
Subject: Re: [PATCH 8/8] arm64: dts: ti: k3-j721e-main: Fix PCIe maximum
 outbound regions
To:     Nishanth Menon <nm@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-9-kishon@ti.com>
 <20201102164137.ntl3v6gu274ek2r2@gauze>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5cabd631-274d-ab4a-6a72-777981967154@ti.com>
Date:   Tue, 3 Nov 2020 07:48:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102164137.ntl3v6gu274ek2r2@gauze>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nishanth,

On 02/11/20 10:11 pm, Nishanth Menon wrote:
> On 15:41-20201102, Kishon Vijay Abraham I wrote:
>> PCIe controller in J721E supports a maximum of 32 outbound regions.
>> commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree
>> nodes") incorrectly added maximum number of outbound regions to 16. Fix
>> it here.
>>
>> Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index e2a96b2c423c..61b533130ed1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -652,7 +652,7 @@
>>  		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 239 1>;
>>  		clock-names = "fck";
>> -		cdns,max-outbound-regions = <16>;
>> +		cdns,max-outbound-regions = <32>;
>>  		max-functions = /bits/ 8 <6>;
>>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>>  		dma-coherent;
>> @@ -701,7 +701,7 @@
>>  		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 240 1>;
>>  		clock-names = "fck";
>> -		cdns,max-outbound-regions = <16>;
>> +		cdns,max-outbound-regions = <32>;
>>  		max-functions = /bits/ 8 <6>;
>>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>>  		dma-coherent;
>> @@ -750,7 +750,7 @@
>>  		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 241 1>;
>>  		clock-names = "fck";
>> -		cdns,max-outbound-regions = <16>;
>> +		cdns,max-outbound-regions = <32>;
>>  		max-functions = /bits/ 8 <6>;
>>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>>  		dma-coherent;
>> @@ -799,7 +799,7 @@
>>  		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
>>  		clocks = <&k3_clks 242 1>;
>>  		clock-names = "fck";
>> -		cdns,max-outbound-regions = <16>;
>> +		cdns,max-outbound-regions = <32>;
>>  		max-functions = /bits/ 8 <6>;
>>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>>  		dma-coherent;
>> -- 
>> 2.17.1
>>
> 
> Does this need to be part of this series? If NOT, please pull this  out
> and repost so that it can be independently picked up since there is no
> dependency on the bindings or any part of this series?
> 
Sure, okay!

Regards
Kishon
