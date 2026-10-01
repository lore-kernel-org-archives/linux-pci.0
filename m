Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FD63B9D8C
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790882360; cv=none; b=d+puYiUsGyWRnfrWeN8X4k8nQxoUbYt9d7AbRUe453h0uGEpruGVNJzgeloSQQ8LAA0VAFhHspH3EfY6ChT7wv2XOgCFJ+qiX4YwRiS2E5WcAcY6Guvs60PKFEcEUeWP9kBkDyq1lqITsFfZkSIs+XNr8iBKcbgAlpl6dxCe2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790882360; c=relaxed/simple;
	bh=fO68JDy7h2mkSC3wXOiTOR3KYoEnokUrbzSoIUOfMVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2xWjMDRwioKab9OCqaKPwsgCvSujgYtQCEW1gGtHG7brvLGpanC9rtEaQJaEo/Fri3PK3bOkcPqRN2+/ecCODgY6DeXN4MVnWEEbH0gmdmFAh565QU+Of5yknWA+Euv2LDvrAnnYExe6Zir8dhHcFkE+HeS+lPQoBJ4uwgN5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=quVvXwwj; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="quVvXwwj"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-5339b4a29f9so851061cf.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790882356; x=1791487156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H5ABqliwt/0HVQecrzmM2IfcVofZb65+VwqbBeb7yHg=;
        b=quVvXwwj5ePkH9anmrBdM2truSpmQi7t4poj2NJ0fWi2kvwmLENF1dBP4YPkrB4FiY
         hArb4hcdczVEl2ZTEfDw+chea5oxgc4s8C1u/HTWim1ZCyS5QEI+woE2s4HO5zGe4Dfw
         0j/9h+4LuuIac/tRDmhrrC8adSEa3V0D8mMoYamHS6blSYXFsZCM/49Sz91EwBBLaAAt
         FCwTSWFsJUDBeALpniCC46ClkLUcyqQOp+Q3fMm4zy4FpSAhyKsQR8um0I2yEWyzF+t3
         o4Zw9YpqnGE9QfdCRwDj0Y7paJCLaAQl1FBhZ9X1NFU02lC/4tI2osQTLPMO0gUJwhK7
         Ktiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790882356; x=1791487156;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5ABqliwt/0HVQecrzmM2IfcVofZb65+VwqbBeb7yHg=;
        b=Vcf0iz8z3bjvq0prQpsHDQFOpq2tIVt0a1IJeCiADMBTlu/AfAzdwGAEYVkrW1XJaU
         CMBYVU/+nllUK77xVjLnCOdWocDGmkA8vqwcpmO2BrIWcYDr5EhRFxVdtYESfBzfzkWn
         X800LiLqi0wZ40lIdyvWlx3YN3jXSk4U3iv0J2IAcREp8yzkQCBGpU/ybR3ICGkDi4VK
         nn6krFeEAJrpMim5uk24X5zcEhQQogVv44q6SIkxgRTe/7xmQsWItESYx1APxd/fNqHE
         etyw/fEAUaGHnceoWuPDRIIqbsvk89jr6znj6z1TNrzgAoUv6knn8+isxslpohobZjW/
         HkWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbj9XWN/PC9AR4F3fZNMqCLIA1tZbnXOkwitnBhNbipTTYx2DKGV6mt+sTw/NBGbUwG+nm7/sr1sQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mZGMLxf4hXGSlBaHoswzJzHaShpRgEIf0oeyQtnE/znIvL/yzK
	opJ1zz690sR89i/Lbhmxgx3ud3qBz/Kdn4QboqWou/M9e2PIMntht85lKXTkW+feQSA=
X-Gm-Gg: AYBFou01ignUpmwMI1xxDmZG3NnOd6C6mrVsEP7GLtmdMCuO+R7bOU+6B6Yzf9tRkbT
	VBPF78WYANB+OO73SSK0d2yMX+i+3FPdkkH3fCiMNrGRkm+xDbm9COTBY6oE54Q0lb3IWxdfXEj
	kB6qvOJaiWor84ldrmF9pBIfFLmQBi5NMIspJuHVUgdVwF5xT7G93ecaIowCEP5QezW9i6nZtAB
	pKG6+4eI3j3TZQiKEBOj0mj5w0r37y2dUzCAylc4hta6RLp7lu3/WHFZDsbuhjR4ANGI2fztnUP
	OdOk9l19OjP7UwWTBHGXcUz7q6PxSg1so0knnqlQkPqeH/QEAayqZQCb7hT/sS4Vw5TxhiV37Y5
	vvWSuy5ciGjjbjQwUULQjrz5K9/XjzspU1jbXgcsNqY3a14rU98QmogEjStzIap1aYrQVn1YcG+
	l72j6Ds1cM7AnJecLLLZGE0Iu6yalzfwk1zpHdu9B8rOZpd4QC5Ez5gAMUmAX/cXrRL3hzmAs=
X-Received: by 2002:a05:622a:4296:b0:533:3fc2:8b19 with SMTP id d75a77b69052e-533cba5b5b6mr2082701cf.20.1790882356405;
        Thu, 01 Oct 2026 12:19:16 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398bf8196sm5954131cf.22.2026.10.01.12.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 12:19:16 -0700 (PDT)
Message-ID: <9c426950-b3f3-42fd-b31d-f14085a7d2d1@riscstar.com>
Date: Thu, 1 Oct 2026 14:19:14 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
To: Greg KH <gregkh@linuxfoundation.org>, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
 bhelgaas@google.com, abelvesa@kernel.org, daniel@riscstar.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260918152659.413268-1-elder@riscstar.com>
 <20260918152659.413268-4-elder@riscstar.com>
 <2026100159-retold-could-3468@gregkh>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <2026100159-retold-could-3468@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 7:06 AM, Greg KH wrote:
> On Fri, Sep 18, 2026 at 10:26:58AM -0500, Alex Elder wrote:
>> The TC9564 SoC incorporates a PCIe switch, which is connected via
>> the second PCI segment (0001) on the RB3gen2 platform.  The third
>> downstream port of that switch (pcie@3,0) has an embedded PCIe
>> endpoint that implements two PCIe functions.
>>
>> The SoC implements other peripherals, and they will be accessed via
>> PCI endpoint bus.  Define the devicetree nodes representing these
>> buses, including the mapping of each BAR's address range to its
>> local address space.
>>
>> The endpoint's ranges property must be defined, but it will be
>> updated dynamically to include all BARs.  As a result of this update,
>> the parent address portion of each range will reflect the specific
>> address assigned to the BAR.
>>
>> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 30 ++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
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
>> +					 <0x2 0x0 0x0  0x83050100 0x0 0x4000  0x0 0x80000>,
>> +					 <0x4 0x0 0x0  0x83050100 0x0 0x84000  0x0 0x200000>;
>> +
>> +				pci-ep-bus@4 {
>> +					compatible = "simple-bus";
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					/* Map 0x0-0x1fffff to BAR 4 */
>> +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
>> +				};
>>   			};
>>   		};
>>   	};
>> -- 
>> 2.53.0
>>
> 
> This doesn't apply to the char-misc-testing branch :(

Sorry about that.  It does apply to to the for-next branch for
Qualcomm, so this should probably get merged through that path.

https://lore.kernel.org/lkml/20260918152659.413268-1-elder@riscstar.com/

> So I took the first two patches only.

Thank you.

					-Alex

> thanks,
> 
> greg k-h

