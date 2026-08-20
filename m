Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224C47ECC7
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246543; cv=none; b=b4MSYf65VtY7rZlno/0ICz6iz6CdM3JQpGzUo1qOQfvEAm6YMPYZV1bVWwsLcTyI5nlTlE3rtX56vSnMzqrMgU+2CwuW8teODjUbtUzQ3ZGqZd4oZjIofrEtBTYQS2UT1OCuDuC2PkbRD3ZCMCsRmlFJbaWTemX2NtduIY+GbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246543; c=relaxed/simple;
	bh=SAJrYqbGk1s4xK6V6dw0Lh5Mwx0RBK1vXRkc5c1kNhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpmQm44c2+bJ7m53qNX7utjeFZnFEPOYMXvVEbuFnJaMHuZLiUON7BT1rOW6P7xwzeay4C1Hslgure2Qgnipsmzq+s1RhdAUoQWVuMJ7V8XikRPsx7lmSECuBeu/yAPmByUu7nG58YUexwvxI8fURqrGgAmtHWfXqzuCrHo+3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=dFz34+G+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="dFz34+G+"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f032b47e3cso1077096d6.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787246540; x=1787851340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJH818idnhGd0jN2j2NKg/qLJJl/ayYbpw4TVR9577Q=;
        b=dFz34+G+1WCMAoUhot2+4CYCkk0HvsFbIvPq4KtpJsTJebf4QhCWMKyNQu80OPgHpz
         3bGjzt4yUXosemgIQi39sUQhQcNU/hSDomtxxNdQHFJK/3uVnjoxEgePEnxKNK2sZ2HA
         A5KG62dsMcfnmzpWwDqWPtPkqhrsgUSRUL5ZCYseW4utSx0/9dCXL468izjo6DWFJ3kX
         VKPS2Ji43qpUTo0gY0dKrU37PMVTD4dGZlfqGInozQ2DYFOcThKMpgZCP5G9zUbWCGAh
         Faro4Er1BNmvT8lFR50k5H7qLd5iWuaK8QLxtRWrCHb7Ftt/a2EZsJiQfpRC8bp83Ohu
         VlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246540; x=1787851340;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJH818idnhGd0jN2j2NKg/qLJJl/ayYbpw4TVR9577Q=;
        b=IBSMUKgLDM6OSAK4zvvX6JYsw1PhECvT+/u13dv4+KlPQ9N9501aMi9QBVPDYjtLcN
         LeKI4yBqnvkMLPx7Odgz0UEiYbD2vH2NtUTjThpa9NvU4EDE2seSiZCKAnP1d+iC5VyV
         txoS0JYNnXdc+6lYrKnPep1EPY0YmBYtSMWEY5E4z1pZs4QtIc7JGgQ8XjlGHbX9j+jE
         dRmsD0LZhlN4Q6VeC9Unk/UpwZYM+Z/fLoX06qwgw9RAqyfqNCjwjQN7EEPryavlumTh
         Qn4cHnFx4oVuY2SKfpibSU9VpRAifG4sSMdZ0brhnguSonZBzowrk5bi3byIUuW8NlnN
         7gFw==
X-Forwarded-Encrypted: i=1; AHgh+RqeIxrBE2WKzxayPAHK0qZChd4byoNrjW9D6H76kCGT6TNiUMkSu/UmTOuIjc259AlLLlQeYyuvhQI=@vger.kernel.org
X-Gm-Message-State: AFuF++mr3yXI3/MarUoYLyE/YhgOITlYa8npVT6yuDm3TETU7Z3PvdX4
	W9XlTzlnu3Xep2O/wstSymPyUuqbZ8jS4HdVCeVX3cb/mQWNawqdtvaXau7o0X7z9pc=
X-Gm-Gg: AR+sD11gpSfW6HGQTg2pJHAcGMyvgNbmXrrbuNq9QlBSBnGormzwFrjxr0VqjfFI32V
	ws0H1iJ5mTMCTKg01IwvV3P557SNjZxGej65e0E91/qC/dIKVxvfc+aq9MNH39Tkchpuj3lAatc
	KhIn+eAIcGl4obc/du+vlqRjxT4rIBoVU950KZmvGyElewLYVgeCiFpB37NzT8djf7urs6RyS5q
	D5rpbuvqAb5/u7ERQtBolTfx83mDK4Qni6UH6QKBk+X9KGHV78u9iZgopIvtDW6mWmY8qRWcIZG
	oW2vmAeZlTb5h8bT9R7cSvvJS1CHdCUqwRdHNT9gu37FXiqr9xCrCqE4L6dcfleqt2O3Rfq3nyo
	brfOTFpUNwBaC8U0+G4rg8R3eYpf5B64OR+5hayPkgV8ofctoun7R1NljNiN7+NmdVWbJqpCoFG
	ANc2JuiBKwvQaOLJNnVXePgEUEq4S6oqdWeQ7R26ymZ2gfMAs5vuP47qZtG7Lh
X-Received: by 2002:ad4:5d42:0:b0:907:5460:601d with SMTP id 6a1803df08f44-90c5e7036f8mr156204246d6.3.1787246540087;
        Thu, 20 Aug 2026 10:22:20 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b2b38sm42839666d6.43.2026.08.20.10.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:22:19 -0700 (PDT)
Message-ID: <c3212784-1144-4d09-bf58-eb99e8f06517@riscstar.com>
Date: Thu, 20 Aug 2026 12:22:17 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, bhelgaas@google.com, daniel@riscstar.com,
 mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
 <20260817024317.GA32943-robh@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260817024317.GA32943-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/26 9:43 PM, Rob Herring wrote:
> On Thu, Aug 13, 2026 at 05:29:41PM -0500, Alex Elder wrote:
>> Define the binding for the Toshiba TC9564 PCI endpoint function device.
>> The third downstream PCIe switch port within this chip has an embedded
>> PCIe controller, and that implements two of these PCIe functions.
> 
> A better subject would be "dt-bindings: misc: Add Toshiba PC9564
> endpoint functon device".

OK.  And yes, I'll do a better job explaining that the TC9564
is (to the best of my knowledge) also sold (but re-branded)
as the Qualcomm QPS615.  I'll see if Qualcomm has a particular
wording they'd prefer.

Thanks.

					-Alex


> 
>>
>> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>>   MAINTAINERS                                   |   6 +
>>   2 files changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>> new file mode 100644
>> index 0000000000000..30a76f377eec8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>> @@ -0,0 +1,150 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/misc/pci1179,0220.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Toshiba TC9564 internal PCI endpoint function
>> +
>> +maintainers:
>> +  - Alex Elder <elder@kernel.org>
>> +  - Daniel Thompson <danielt@kernel.org>
>> +
>> +description: >
>> +  The Toshiba TC9564 is specialized SoC that implements a PCIe switch
>> +  as well as an Ethernet AVB/TSN bridge.  In addition to these, the SoC
>> +  implements other functions, including a reset and clock controller,
>> +  an address translation unit, and a few other devices.
>> +
>> +  The PCI switch has three downstream ports.  The first two are exposed
>> +  externally, while the third is used by an internal PCIe endpoint.  The
>> +  internal endpoint implements two PCIe functions, and attached to each
>> +  of these is a 10 Gbps capable Synopsys Ethernet controller and an
>> +  interrupt controller that converts internal "wired" interrupts into
>> +  MSIs delivered to the host.
>> +
>> +  PCIe BARs provide access to registers that manage almost all IP blocks.
>> +  The SoC is modeled using a PCI endpoint bus.  The IP blocks are bound
>> +  to platform drivers that access the hardware using MMIO through the
>> +  PCI BARs.
>> +
>> +          ------------------------------------
>> +          |               Host               |
>> +          -----........---------------...-----
>> +              |        |             |   |
>> +              |  PCIe  |             |I2C|
>> +              |        |             |   |
>> +    ----------+........+-------------+...+---------------------------
>> +    |         |upstream|          |          |     ---------------- |
>> +    | Toshiba | Port 0 |          |          +-----+ PCIe pwrctrl | |
>> +    | TC9564  ----++----          |   I2C    |     ---------------- |
>> +    |  SoC        ||              |controller|     ---------------- |
>> +    |             ||              |          +-----+     GPIO     | |
>> +    |             ||              |          |     |  controller  | |
>> +    |       ------++------        ------------     ---------------- |
>> +    |       |     US     |                                          |
>> +    |       |            |    ------------------------------------- |
>> +    |       |         DS3+====+          downstream port 3        | |
>> +    |       |            |    |-----------------------------------| |
>> +    |       |    PCIe    |    |       embedded PCIe endpoint      | |
>> +    |       |            |    |~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~| |
>> +    |       |   Switch   |    | PCIe function 0 | PCIe function 1 | |
>> +    |       |            |    |-----------------+-----------------| |
>> +    |       |            |    |  BAR  | |  BAR  |         |  BAR  | |
>> +    |       |            |    |   0   | |   4   |         |   4   | |
>> +    |       | DS1    DS2 |    ----.---- ----.----         ----.---- |
>> +    |       --++------++--        :      ...:                 :...  |
>> +    |         ||      ||          :      :  :   -------       :  |  |
>> +    |         ||      ||   -------.---  -.- :...|clock|       : -.- |
>> +    |         ||      ||   |translate|  |M| :   -------       : |M| |
>> +    |         ||      ||   -----------  |S| :                 : |S| |
>> +    |         ||      ||                |I| :   -------       : |I| |
>> +    |         ||      ||                |G| :...|reset|       : |G| |
>> +    |         ||      ||                |E| :   -------       : |E| |
>> +    | --------++--  --++--------        |N| :                 : |N| |
>> +    | |downstream|  |downstream|      ------.----       ------.---- |
>> +    | |  port 1  |  |  port 2  |      | XGMAC 0 |       | XGMAC 1 | |
>> +    --+..........+--+..........+-------+.......+---------+.....+-----
>> +                                      |       |          |     |
>> +                                      |USXGMII|          |SGMII|
>> +                                      |       |          |     |
>> +                                    ---+.....+---      --+.....+--
>> +                                    |  Ethernet |      | Ethernet|
>> +                                    |    PHY    |      |   PHY   |
>> +                                    -------------      -----------
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-ep-bus.yaml
>> +
>> +properties:
>> +  compatible:
>> +    const: pci1179,0220 # Toshiba TC96564 (a.k.a. Qualcomm QPS615)
> 
> Perhaps somewhere besides a comment say what the relationship to a
> Qualcomm device is.
> 
> Rob

