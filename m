Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58250EC1C
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747356; cv=none; b=r9ebGpLX1CGGslhfWnACenD8WWHlC8xvjuDlr0ubYwlQc0kNYuaAMLgo4bdQ0Hbuk7wCfLngdhH3+GaxRQrPIrq7SxCputa5NfDApH4o7LTMMHo5L3a+4fJw1elqPTswh8HijrVzuD+xT4DZaimG7xmux9xisPZ5hwCpW6VZfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747356; c=relaxed/simple;
	bh=xLP8ZqqCxQPMvm6zHvf1Ffu9vtw7liSp3jcXxbjvmYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZHv1QLJ8Rq3qm2z0fGH4gVVTA6/o0olDBKRIVoiSJ1MZ8TGRl0605BrKnurUkoKa6fDe8lo350RQGd2wObQFwLIdNy3ZdP/aJ2oF3FUqajRcdwXn66EVnHkZ6jwY76471fienqEXSm40D9jCF88dYMdqNMWpe7QiGdY5mBf+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=WP8N7DLa; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="WP8N7DLa"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a222edc62so101491885a.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789747354; x=1790352154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6GtIbzjgakznD0y35eQfGVe5BRX2BKpmAlzkE/AHnw=;
        b=WP8N7DLaanleDnTxo1YMCAPIYmeFM1Xma9twiGgJ69WHcigTECOXNFB2du8AdvXVhQ
         LynNjqNCs5aaNEe2P0IG5W4dIrWOplerNuUOHoiehCWoQX8EJ1vSLhOejWKj6GGG0XGl
         vMDVBjZ2o65lHDxE0jbUXHDhXzdXcWQZ1ByhR6CpzHC7OMzGWNSqlBew9tMl2bUo8DiD
         DYOvdM2aGo5sZQK9IwnERFo1zE6JlL5JEOZVN1Qo3gXfXVQGiDlo9MsdImxl+ksEyUSr
         yr/mBais2pND6WHxJ5zF/MewoA52AYwlbiBPa2XWBehVXWa/QZHwMdE6Zbt8s7U7jXZZ
         DuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789747354; x=1790352154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6GtIbzjgakznD0y35eQfGVe5BRX2BKpmAlzkE/AHnw=;
        b=UxIdcNqZLEAQEpYrOY6lkLayIzoNc2l07cm5cq1Dgcxc/N31yMCOKU4YOEmCt5YNrE
         k/aDNyIqzmhWDkolYdXXTWcMAwXCNJaw6cCeVYWTx7nzOKv8aBTMTogT1TJUhlmpTWSz
         Nc6JITbiZt7c9jG6ZijoGV/hdl9r7bT3tZMJoZc5KNOZz3AZakiT39fNumtByNU4uuyA
         39GZZEfna04bvQStENuGAU2RR3r1U38ogJo9XPE307KUxRvLUO58Av6lZrvCqJvqRlB8
         H3tNpfV/2Snf0FONJVIMzuTxaZpxZEVmYeV/ILtcJDP1vOrZ+PhMPr3DzadwUpGPKHlg
         Kp8g==
X-Forwarded-Encrypted: i=1; AKwUvBzl+ci4PX8ZaJYyXoe4jLOpIzjpXgnHmVlYespmi/Vizh6q31+xPchU5pXkCwQkW1BB4Zf+viRmMws=@vger.kernel.org
X-Gm-Message-State: AFuF++kLp9Ij2U/JpDLzWFcXWvAa4/JmyP865ngcGPwx2Ea8Tw8aCbX1
	h8MT04sHg6gcI/E2cypyLC4yEunf8fGcT5dS2bSgbW3sVxsmBB9vmdmCkaAJhq+CVCM=
X-Gm-Gg: AYBFou3uukSAZpQOLfqiVyZHj7cL2i2v9iywduQDphQi4PGRUHeqEQOezhPm/Nao5Y8
	Rf2Z9Wmqnqa0PTVVKEzeWEpKWl3Q7Fm8iVkg1LVq7/WYRcrlwpO6h1dF88hliiPUyS3qK5XS042
	1EDjiFIHHqa15nDe/WK+ivXj5883RpcogtXq8aJxbI9V/nXAfAguPgrerMwXLixLxGGv8FH4/WY
	flW4UxtbFw+AnHirXFubG7VqEHrro+/DCRg8aNPMZ63wPCZUtQUS2MhZdal7AOY7yreJrPKEeFd
	BfQHI7QqxG/sX4A8c5OnoU1B2Dq3sIHfYCJa1zJw6KS2EFGdx59vS+A3Ra0K8pc+gUfK2MGpSFR
	xigBgykJGwiX4JfZDy1XmIuG1O76QFhwA8UE2xj6Wjb5MoDq7dJhfd/2Z1etxvTfs905qfLybDr
	CuVPFEm235TjxHOFo8r35d+e250xr/OnlXAOxQiAGsHED02TTV4f/WQ9xzYyalqmYUABe3oH4=
X-Received: by 2002:a05:620a:3710:b0:93b:d79b:9a5b with SMTP id af79cd13be357-93bdca7992dmr437096285a.60.1789747353937;
        Fri, 18 Sep 2026 09:02:33 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e9ead7sm169853585a.23.2026.09.18.09.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:02:33 -0700 (PDT)
Message-ID: <36595da1-5943-4557-976f-4df709492045@riscstar.com>
Date: Fri, 18 Sep 2026 11:02:32 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-4-elder@riscstar.com>
 <20260918153925.E51901F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260918153925.E51901F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 10:39 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci: MMIO translation failure due to static dummy ranges bypassing dynamic update

The same Sashiko report was made in version 2 of this series.
  
https://lore.kernel.org/sashiko-reviews/ed783639-05ed-4ad9-b881-d1689a8b2418@riscstar.com/

(I repeat and reword my explanation below.)

If I knew how to make Sashiko take into account the prerequisite
series I would gladly do so:
   https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/


> --
> 
> commit 07e53b54e0b29671e1a08f764661a81fe5484062
> Author: Alex Elder <elder@riscstar.com>
> 
> arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses
> 
> This commit adds devicetree nodes for a PCIe endpoint and its peripheral
> buses on the QCS6490 RB3gen2 platform. It also defines static ranges for
> the endpoint BARs, with the expectation that these will be updated
> dynamically.
> 
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 3bb5fca8e2b13..5b7f5292a8864 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -955,11 +955,41 @@ pcie@3,0 {
>>   			bus-range = <0x5 0xff>;
>>   
>>   			dev@0,0 {
>> +				compatible = "pci1179,0220";
>>   				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				/* Ranges will be updated dynamically */
>> +				ranges = <0x0 0x0 0x0  0x83050000 0x0 0x0  0x0 0x4000>,
> 
> [Severity: High]
> Does defining these dummy ranges statically bypass the dynamic update?
> 
> During PCI enumeration, pci_set_of_node() binds existing nodes like dev@0,0
> to the corresponding pci_dev. Later, when the PCI quirk calls
> of_pci_make_dev_node() to dynamically update the ranges,
> of_pci_make_dev_node() checks if (pci_device_to_OF_node(pdev)) and returns
> immediately without calling of_pci_add_properties().

The series mentioned above changes this code so that, rather
than returning immediately in this exact case, it updates the
ranges property to incorporate the BAR addresses assigned
during PCI enumeration.

> As a result, the dummy ranges are left intact, which causes child devices
> on the PCI endpoint bus to use these static ranges instead of the actual
> BAR addresses assigned by the PCI core. Will this lead to invalid memory
> accesses or driver probe failures?

And with the above series in place, the ranges are *not* left intact.

					-Alex

>> +					 <0x2 0x0 0x0  0x83050000 0x0 0x4000  0x0 0x80000>,
>> +					 <0x4 0x0 0x0  0x83050000 0x0 0x84000  0x0 0x200000>;
>> +
>> +				pci-ep-bus@4 {
>> +					compatible = "simple-bus";
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					/* Map 0x0-0x1fffff to BAR 4 */
>> +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
>> +				};
>>   			};
>>   
>>   			dev@0,1 {
>> +				compatible = "pci1179,0220";
>>   				reg = <0x50100 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				/* Ranges will be updated dynamically */
>> +				ranges = <0x0 0x0 0x0  0x83050100 0x0 0x0  0x0 0x4000>,
> 
> [Severity: High]
> This appears to have the same issue. Because the dev@0,1 node is already
> present, the dynamic update logic in of_pci_make_dev_node() will bypass it.
> 
> Child devices under this node will then attempt to translate MMIO addresses
> using these static dummy ranges instead of the actual BAR addresses assigned
> by the PCI core.
> 

