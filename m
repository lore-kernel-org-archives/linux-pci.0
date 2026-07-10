Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7B643B49F
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699303; cv=none; b=GkqZL6pkrmmM5QqsNHpxUAjmNNPM7niG6Of0xghPdn4C0zS6qq+90alAsT2pmJuJjKq6+DVxYTGOEeXCIdFejcUd9526tPOszNbWyMUYfCnCYXP/g3y3ER5MHoeq964jb7754HIxEtKvTpwq+jEr2mZcXRMnNTUUVX0Pm5rFSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699303; c=relaxed/simple;
	bh=VwiAZXZIJdaH4H2GdoTNqGdH0W6/6abMGB1zwC68+H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv6LQxXP6Z8py40bNhlQ4CHXBOUlvS/x0mKC/Zwjr1rrjsm3RYaB8Om3U+jrpQOgSon0JPhgD2Y1/VYt9VKH8OkUT2YGiJjnrQFBNuX1E+nSwK9ZWpdVEF4LaDOavfHcqqE9sxJjA6KI/Zpw3g+qRbIkWHCb4He8xrpQprXazik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=fW/C5PTn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="fW/C5PTn"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f032b47e3cso8479396d6.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783699295; x=1784304095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBrb1/xcTqbJkDmBUM03GUxf19wY42RaKRfKCOCo/XA=;
        b=fW/C5PTn9OkaaVedVbRIYeolJtsZX3QWZQcB/OPi9i5gyYN09QUgIOkUSTn3NKJ1IV
         Th9DjBBgMgdy2RaJlSL9Zjzgf6z9h6uW5YStGvtZg35/ITdlfNxk/jhOoC8tpcZ3dyBu
         h+aPMYWZtfs54HzvlzqSE4OzMkqGb2nWpHjl6c7gWoaFZwfwNjfHqFMZGiFgPH7amXQn
         CBHaoK4JXffkHjCE01QqubQQXvLl6Ww3w6qxnp6O+IcliYrxr4fvIW7A0cpbPy4FyVYI
         YmeK6QIkEi1TTxFa3Sn/qW95vHdujZ7DXtg/Gra4ZLmfa8e6xN7sm5iAeLaH9w0VLdKq
         5toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699295; x=1784304095;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBrb1/xcTqbJkDmBUM03GUxf19wY42RaKRfKCOCo/XA=;
        b=S/h8/+TWRWd4pWGz1KhUlPBBpCZaGAYhZk/EmHG/OBAjO/8Bt2qipZy9OOxJ3/BJr6
         KMr9MKu/QdA6HQLdjmhHr/YkLbrDlolw1dGpwGeb2uW3oyrS9MrdE/L/sFzfnwnD7FOn
         gqF+1kvTavj5sW1iRqIOmQ/oSakDn8C8W+7NVSoXTkwjpdaeXdYuMbSr2MqAgRY31/IE
         0m0OgNbyu8vGjKGQZ0LG/RKFCOnNSPcCugHAiViy2cUxqCPR8xfvMlUTBRMe/6S06KXi
         qS9ZTVVrfw4QEl9tQaEy5dBThrROl7NF4vEFCcUhWsUQxm8jxtXSLO3hFSwIpzDI/auI
         tuQQ==
X-Gm-Message-State: AOJu0YygoUTaaWq6CU7jMO65CIaDOt+eAokBoYI3YNMDTibUAtGafs/A
	pSnzcm27TA4l9yi0X73f9ybi+lh7rKMaipNPM5otqci5rbnJPEcg3lBY2uhcQeqvhI0=
X-Gm-Gg: AfdE7cmk4TuRGLqJx+pCCWBx7TuUMuQxjB7LwFdEZ0RzTvHcg20k18NZ/zPymII21Vq
	9hYeSrkd/llTyK79LvDfJ70NWqJOi+nv95MoXSMeLV4pF2AdCjeRrZ7SZ+V7WCg4QvwYsfIRyb2
	PiDXbn2Ma5I4HzuBVOF3qPg+VUS9L7H+cdCCCvgqrDt7Xg8W+E8jh3lnbhoTCqrObKBpE+Tn+6r
	xT1vaEVwLvAD+OSbhrhRivfZGR346p4IkSK9BhNIet2wN3TkhZfLSpu/JImpym5ooSz3WdMFUMP
	JYZNI0JLTVsLjMStvma64KAkJUD6h363nEv6Y2CGBLXWh2pgj1qnpBRZpzTJto465o5niQiQ6N1
	KsEI66yhtBFO0smH1o1px+g3Cn+bXOAZaU4A2m6+MWuKXJMzfxW5xnr8w9ziJxmzz7odU0pHLFI
	rsQUAkJhgKwfIO
X-Received: by 2002:ad4:5c47:0:b0:8ef:8e79:bb51 with SMTP id 6a1803df08f44-8fec2279f84mr159256126d6.40.1783699294772;
        Fri, 10 Jul 2026 09:01:34 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9036e27f765sm8965376d6.11.2026.07.10.09.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 09:01:34 -0700 (PDT)
Message-ID: <79888a39-ac3c-440a-9299-582066868140@riscstar.com>
Date: Fri, 10 Jul 2026 11:01:32 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent for
 MSI handle check
To: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Christian Bruel <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>,
 Nam Cao <namcao@linutronix.de>, Qiang Yu <qiang.yu@oss.qualcomm.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Xincheng Zhang <zhangxincheng@ultrarisc.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-5-inochiama@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260709040027.958400-5-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 11:00 PM, Inochi Amaoto wrote:
> The IMSIC device on RISC-V based system does not require ID
> remapping for MSI. So this device only needs "msi-parent"
> property for IMSIC-based SoC, and the "msi-map" is not a
> necessary property.
> 
> Add new condition for MSI handling on IMSIC based SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

I have nothing to add here.	-Alex

> ---
>   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index b3216141881c..91bbbc8924f6 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -27,8 +27,11 @@ allOf:
>     - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
>     - if:
>         not:
> -        required:
> -          - msi-map
> +        anyOf:
> +          - required:
> +              - msi-map
> +          - required:
> +              - msi-parent
>       then:
>         properties:
>           interrupt-names:

