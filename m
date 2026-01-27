Received: from mail-vs1-f66.google.com (mail-vs1-f66.google.com [209.85.217.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61962346766
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516244; cv=none; b=Ithd4oVMw6dQazRboIyy2haIixv5Y9mgSbbIANy7ktxQsFvdnjQeahoPdBgvRwmrp/E8mXz++pzaYxYM6hzCXCqqOHkM8IYwY8EH7IlcdF670CkHZT604Yqb5O9d15n7HeewUb51UvSSQvZh9e5F5aUf8TXUhGa3r2a6yUxT+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516244; c=relaxed/simple;
	bh=VR7NKRn1EzgAvvzhExxtxmFQMZZBrouxWpYgT74wAco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3YAs7FX9G0Fidq+w8CI0iUtzqAzPCgbWmreocxw+F/zT+3UZQb2zKYwFItaPFxW1JXqno19ecByi538sviHx7YuTuK6ooK0Ve9AxAP92cfHg1pBLregSRYqStWlLTc9Z0MZxkFbjF7Fau1e7JEOaBnF9KIaMT+QAghh1N1tUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f66.google.com with SMTP id ada2fe7eead31-5f52ed75c45so3809316137.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 04:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769516242; x=1770121042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h95kKSGuxlIi6DsiBy3i3OTVnWNnI1FQj5Fv8XU8C14=;
        b=omOa2PPirDERURpt1rRDambyOZdMa9RS2zG68fz/acpVxVvYgmvt7v2pTdARqYBc1c
         GjVUGxfYXbClbBiBGeSTuo8c4uzNoY2ZpcKc0MRqWKxtjiW+fE0VDPX2DPJ8kCf/YfeW
         LJHv4glZiIS6HZmRUEaSCsh1R2Nf+EZmIWi5vw8OLDXX5odDRV4xYRBzSACmT+agzWB6
         CHTMroVriNw7KUVOumXq7Qz9Ie8duKQEqn1I+/ay9HNb/zLxK+EePZHE9lmQv9TDAeFI
         gszmkY694EYqGbOPB/HeXml6QPg2CriX5IPpy8RUzjmluKeJ2EjUUYu+I6kdrWoM+Pd2
         kcNw==
X-Forwarded-Encrypted: i=1; AJvYcCUuYG5AcFJZojadR74vlx9IsDuI5XAk3J7OWpuEf4hB2GW/5OXDrUw4jGHKDNYwlOMPvMqaRhXPR/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBUGMLL8HJZNZPN2ln66FSvnhOL6bYKPSaV6uLcwsUrjDp3qa
	A6tDvySv7E864V2+FqO64u9aBsPuV15oQGwZ+YtilAM5g1Hb4HRjYwfMlSgstIjH4mc=
X-Gm-Gg: AZuq6aKYejt6SBZ02cCsBsK/JchA4qOWgIMwe5lDwaS0pR8E73hSaS08OmrIvOeX5n3
	Q/7mQrd//9UQZLCOZhwsFRk30fgnu6i1XiwYd64DNZ4IdmCgHT+eSoWciELjQyI1zXlLBa6UaBP
	f2KRNKDhCPp/QLOTm3GmVvcptl2qpC9hlN6QiET1AH0wOiGM2GcJeA9XPoQQsvDINOIQTnfIsMo
	dwydfKrSKTr+JL9hjFaheSkhOr649Z/cOyIlfN5srG+StmNS4U4lzcsyYXFVW2IZj5A2kq/xlYG
	6iWvrhT5xdHRqKNtaJ2VXnyMTJYeXavFyQJTgLGgy53ANNKrDPMY+6JazFupd64/QaOr5GzJLID
	P4OLS0ftGuQ9N4HkyLBAN/iwJdtSSrPwHunYzCewop5QKkXLRKef3BcBhLVdJLyhNdPhTcCFpyw
	ictp54gqxp0MCUA+Q2FSOnC0zNjUhbUyrlHng/VW4tFrKAN9HNuTbY
X-Received: by 2002:a05:6214:2407:b0:894:6a0a:b0cc with SMTP id 6a1803df08f44-894cc7c406bmr13220846d6.7.1769509575088;
        Tue, 27 Jan 2026 02:26:15 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949a5666e5sm100230526d6.48.2026.01.27.02.26.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 02:26:14 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70c6b2bcaso33098185a.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 02:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJOQnTjzGECruWN7wLZuZECbeymS1dYdT+g0Y/y48mvHDzEgcI+eTbsgEQtwkkDBJn2EzI9cs294U=@vger.kernel.org
X-Received: by 2002:a05:6102:32c4:b0:5db:ca9e:b57d with SMTP id
 ada2fe7eead31-5f72368a7cbmr661077137.19.1769509270640; Tue, 27 Jan 2026
 02:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-1-c55ec1b5d8bf@linaro.org>
In-Reply-To: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-1-c55ec1b5d8bf@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jan 2026 11:20:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU9HcK3xX=itqe2di1HS1SJvV6=ySqKyrtj7Yr1yXyuqQ@mail.gmail.com>
X-Gm-Features: AZwV_QgWv7FB_90Ca_fAZmW1VQjnUFaVdHL_S5QmJWKKvUrnnNh7whB0F4bfOtQ
Message-ID: <CAMuHMdU9HcK3xX=itqe2di1HS1SJvV6=ySqKyrtj7Yr1yXyuqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: usb: document the Renesas
 UPD720201/UPD720202 USB 3.0 xHCI Host Controller
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neil,

On Tue, 27 Jan 2026 at 10:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> Document the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller,
> which connects over PCIe and requires specific power supplies to

Here: "requires"...

> start up.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/usb/renesas,upd720201-pci.yaml        | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml b/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml
> new file mode 100644
> index 000000000000..df3cdcf44747
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/renesas,upd720201-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UPD720201/UPD720202 USB 3.0 xHCI Host Controller (PCIe)
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description:
> +  UPD720201 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> +  The UPD720202 up to two downstream ports, while UPD720201 supports up to
> +  four downstream USB 3.0 rev1.0 ports.
> +
> +properties:
> +  compatible:
> +    const: pci1912,0014

Just wondering: how does having a new driver
drivers/pci/pwrctrl/pci-pwrctrl-upd720201.c matching against this
compatible play well with normal PCI discovery and probing of
drivers/usb/host/xhci-pci-renesas.c?

> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd33-supply:
> +    description: +3.3 V power supply for analog circuit
> +
> +  vdd10-supply:
> +    description: +1.05 V power supply
> +
> +  vdd33-supply:
> +    description: +3.3 V power supply
> +
> +required:
> +  - compatible
> +  - reg

... but no power supplies are listed here? ...

> +
> +allOf:
> +  - $ref: usb-xhci.yaml
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie@0 {
> +        reg = <0x0 0x1000>;
> +        ranges = <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +
> +        usb@0 {

The actual DTS uses "usb-controller".

> +            compatible = "pci1912,0014";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;

... also not in the example?

> +        };
> +    };
>
> --
> 2.34.1

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
