Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472A548551
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874077; cv=none; b=Xw3zJjiQCHa07h/mfCYE9fo/fdR7Qnw36RIi79T4P/+Qd4YYdrjomdKQvKLuBXE6RiqrPaTUPJ8/yAppgAiNKpapAKywwvmQZ0K9HoByvnLyZVRStVok0/SwEylgM0+oaT/3nqzdfurOmZq3/iBE0ZLLLluFXg52ev8NKun4zHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874077; c=relaxed/simple;
	bh=pAsEvkPu3covvOGoVW/KlsUNTc00k7Qd0xwuz3K8QkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixfP60Jvkc1/Q4RWog4MCnau+gKMft4qRZQdnInoyMjy4Kz7gyEq9rGRLWYiawVgXcM9VzxQUnIiS4j0iijGMQEjoVkRC7UDqw/1yk1IonlnR+uLkKJrCWCvp5q/vhDXdrD/coM4jT0/lRi1ZTjazD7u4JravsAmOKmmybqhsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=RNoQ8z7X; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="RNoQ8z7X"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-939c25604d4so36762285a.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788874062; x=1789478862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qNO/TqMTBOHVJmTKy/WseOZnYihRsPoGCcusIiyOoTY=;
        b=RNoQ8z7Xs/IqIBn1H7QZuEX8UcDt+ZJXY+/HJicZ0ZlCoNsm2JNSYt8+FQqVJWpA28
         83nAk1992L8N6lSwVm7EhMiv432dxySWQs0/XC/FnPF0HxrlScto18D346xICY/oLwyl
         irOEbF7GJoHQuL9sh6pVrmojYxJkyztF3mTnr8KtPzJpaswh3uIv4kst3avjigaA0Sal
         9gm6EEDGuq9/tvKYGCmkq9m2HIBkcbg7W94vFh2v55S9QQLgJi5p1xNRwrmq05uxnPDv
         9GoK8SvimaKPug9Ea9kMdPURJcaShAFvniEEAZaJaiIRTtjIurko2iE/a+zOS1UF95Mi
         wEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874062; x=1789478862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNO/TqMTBOHVJmTKy/WseOZnYihRsPoGCcusIiyOoTY=;
        b=sh8KXRd3B0OKaSewYlB9rlcp4K9n5CFqShdyETC8kwP13tzTsktp8PFxQvx7UJjiRn
         8QQx1YPPoPhXzJ1kf0gz3FztViiAas4GwXuZhLIQ5zI6n/fzsSgBGo+Md4Co3nL77g6p
         O6soUBSQxI7cChkouEofzhXxQTUb0CPvVr1Ooe5w2patP48InwbcamW/9uMni7y6xXO2
         crKGwMQtghKnVLCFSNvUiMKJ+YGy+2Vqwpn34ya/TUoHu3RfnUIKYTasXxoIZluek/49
         ktA+yIbGJ7bxlQ6n31sACkLmiw4KNkx0rR62ZE66vmypOFLJiFPImcIm0XUJCPPkV/SL
         wtCw==
X-Forwarded-Encrypted: i=1; AKwUvBxYW/uCPyeROCOwS00JtgR4DGpUx3F1+4Oi4jmcdk5WattlXHe8Wjqg4p0RulaSqquAl7wCJIu+FSk=@vger.kernel.org
X-Gm-Message-State: AFuF++lEyEzDjYctrRxBaT9g1t/r3y7JjfIkzp+MZQ6+yTpNnlakJFI5
	qdahaG49uLSygo74CAUysKU1bHp8mh909BXtK2eVhaCOThqDg8S88ECI25Ce4AB9h54=
X-Gm-Gg: AYBFou0PlC9MJZPf7rkcPJKEmaJ/sHDetsYVcAjztLtbPXBCALyN6hxb2IX+rfEVBWc
	LBhMBXTabXw4pLZBpqqm+2Ano/wp4CR6Swc7ujqvn3W9zhpKDK99xl3JgS9Q+evt6HJDgxbjB5P
	J8eXx5mJNX2aIFtEpEMcnkctb42E18PFYgzPXWMkWUbjnqrw3EewmNA7GwlsCEuKmP4uwpfdF+3
	gKvJduQJB33MkBlO6ovTaw1rwYGhUIxsvpi14V56GohJ6gVq6jMnzzXmwhJyZy9tVs28FVgKsQX
	0HpYpgVagsy3T8G+fqziMhjk7v6vX2tEQJZskQuyyrt0hCK4dBMtsIoCjG8wMbtk2jwnf5UUWs0
	eeAdcWNwcW0N5/J/M+gZdKoGNe953LUAvWThLRrAPfg6h2u8CTj9PvsnlFOb2cF0lWq3+2wZcoJ
	Vi8vpWE5KI8V2L//l+g4OcWGrWm5ygKlxqTlX99VIWfIC299d/HUVZJlS0WdDP
X-Received: by 2002:a05:620a:8c0e:b0:939:6dfa:db9d with SMTP id af79cd13be357-939804fa21fmr2230570085a.50.1788874062236;
        Tue, 08 Sep 2026 06:27:42 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939b8fbc1dbsm249492285a.11.2026.09.08.06.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 06:27:41 -0700 (PDT)
Message-ID: <8f6cbccf-3169-4b32-9c8b-406d53449590@riscstar.com>
Date: Tue, 8 Sep 2026 08:27:40 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Daniel Thompson <daniel@riscstar.com>,
 Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 12:15 PM, Lorenzo Bianconi wrote:
> The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is registered as an auxiliary device by the TC9563
> power controller and accessed through the same register map.

s/power controller/power controller driver/

On the other hand, this is a devicetree binding, which should
really focus on the hardware, not the software.  The auxiliary
device and the regmap are software constructs that aren't
hardware-related.

I think this description should focus on the fact that the
TC9563 SoC (which contains the PCIe switch) *also* has a
GPIO controller that is managed via the same I2C interface.
And that it's possible the description within the binding
should be modified that way as well.  (However please defer
to any input provided by the devicetree maintainers...)

> Describe the switch node itself as the embedded GPIO controller and

s/as the/as implementing an/

> document the per-port reset-gpios property.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

I will let the devicetree maintainers comment on the way you
document your properties.

					-Alex

> ---
>   .../devicetree/bindings/pci/toshiba,tc9563.yaml       | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index f084830c6d0c..c4cd162cb084 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -31,6 +31,11 @@ properties:
>       description:
>         GPIO controlling the RESX# pin.
>   
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
>     vdd18-supply: true
>   
>     vdd09-supply: true
> @@ -84,6 +89,11 @@ $defs:
>       type: object
>   
>       properties:
> +      reset-gpios:
> +        maxItems: 1
> +        description:
> +          GPIO controlling the reset line connected to the downstream port.
> +
>         toshiba,tx-amplitude-microvolt:
>           description:
>             Change Tx Margin setting for low power consumption.
> @@ -128,7 +138,7 @@ examples:
>               ranges;
>               bus-range = <0x01 0xff>;
>   
> -            pcie@0,0 {
> +            tc9563: pcie@0,0 {
>                   compatible = "pci1179,0623";
>   
>                   reg = <0x10000 0x0 0x0 0x0 0x0>;
> @@ -149,6 +159,9 @@ examples:
>   
>                   resx-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>   
> +                gpio-controller;
> +                #gpio-cells = <2>;
> +
>                   pcie@1,0 {
>                       compatible = "pciclass,0604";
>                       reg = <0x20800 0x0 0x0 0x0 0x0>;
> @@ -158,6 +171,8 @@ examples:
>                       ranges;
>                       bus-range = <0x03 0xff>;
>   
> +                    reset-gpios = <&tc9563 2 GPIO_ACTIVE_LOW>;
> +
>                       toshiba,no-dfe-support;
>                   };
>   
> @@ -170,6 +185,8 @@ examples:
>                       ranges;
>                       bus-range = <0x04 0xff>;
>   
> +                    reset-gpios = <&tc9563 3 GPIO_ACTIVE_LOW>;
> +
>                       toshiba,tx-amplitude-microvolt = <10>;
>                   };
>   
> 

