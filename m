Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEC306B1B
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530120; cv=none; b=Ql9tXGOecn6Kc7zAfKhZ5SVN6te+1Ug9DvlgQoovvJ/mTZcyM1tjFJ10BUEBwD7zSW7psqHXLYzo2dlnFSLBcJnFFCpl2SsEyJKM7GwcX6Etf0qTbdO95GGV4eHhegaTozQSclF2TukXT9ykFhaxWPBOvinowb25aRkBTCdG+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530120; c=relaxed/simple;
	bh=QPF7Zu2r+fCfqNyJkt1Bte+V+ziLRm+jV4lSeXPHZEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aq66tf3HxMU9pxccOYb2OmqJFx9FkWcXyKpY9bEdJyjmc63iqnD+I4fJ5PD+n5r0w07FARkeFN9t0+bhde/PuFltVHe6yMc2Dbo3pIHbyhZGZuIKdlbOZagvxomRE1BlNS4d6lITzTdT5KW+GadL6H/aFPGvdmxVCPqU4mO9XoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-501488a12cbso77519811cf.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 08:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530117; x=1770134917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3iP0W+rICWiFtIz9Lnj4u7VRlu+Bycye5GdS1BEDSM=;
        b=AzokpvXwIWLhl0CNF0Z8o+RSgSy+989+itRkB56x06WVrLkeE7e1oemizZht4Dwjco
         FkjNatJMb45wUfOtf1Rp/HPatTk2+/ooVmgF+QuRu8hMV1H119Ib9NfgQcfOo8WMX0BC
         djlxkhLecb8HmII250RC/xFGTqrZY9ZCYQk5ckFqRxFEidKnmJm4/yHFvj9VVT732Evg
         FGY/3A1OUSp4fyQSLzNOPDMCwqq3adMEwFC6I6863x1iXsJUH9i0kLXZj18zF4FUU1x5
         5HiagY4DH+nb2Ci8x+bxApY/yL9Awp0pCVz7xm3KEMwaEdUW0xkQy2iM07w8O2jmrrDy
         g5kw==
X-Forwarded-Encrypted: i=1; AJvYcCWfp06IZM4npPoS5O5is//X5cpkzbB7ukeORwJI6BG23fMjIKRWBd8G7eohMpkrZuaxUI81PXWsaWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc116DENb8yCDqyUQzJEB0pHANrvfXC7IuUGPgcvlFG0xrC/tE
	Y3j06svNNupZjS4F7QvSNfvJtqUA7oTGqs4K9TfZL6slk0cnRBLLkGMNe8GxdL3wLPQ6+Q==
X-Gm-Gg: AZuq6aJI4rfdv7t9m1H6OFdbZtTKhbBW7FbSGfQMdtDGl12+b3Q80AgAlM7I8Xm+Dw1
	aImBkM+tNdC1OpsZHKggE0qrSKzrAYhk6O21ZIUTUhfoN34oP6bZmjv+5aQNZKcLss6QzrmTozB
	cHHUS75i4WDMtgxt6C1vY9FWirDD+Se6DZNE4L6MIGg1Mpv9Di7ARvz1VC9foys6Hlb+h6p3off
	6D5eVUrPjdp5gIqK7Mq4Ej7Hkt0EjJIs6t4BgN3F0xyQO/VnFT35JbYvv0emj8pOaghKOHXf5e8
	Fk9nOesSAVvetDtKHPVedHcbAjX3Dy86xC/pZrxlSt5dHEXCDYEXWDWavg1xHuJKikn035DnXEx
	W6nS5qELnfAAzypVmAeblWqJFw2Fq2XZBPHthgSillVtq95dDYsXL02wdPwbV9AxMr45CnfsHCU
	1GivLvlkasdgNi0bW3tuB8CvDAH/ayL2GDZSxVftqprb/rJiwD18xk4B9jiI8=
X-Received: by 2002:a05:6214:d0a:b0:894:653a:ebc4 with SMTP id 6a1803df08f44-894cc7b9a7bmr20373506d6.9.1769523046273;
        Tue, 27 Jan 2026 06:10:46 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949c95b6ebsm99851886d6.50.2026.01.27.06.10.45
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 06:10:45 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-894774491deso89864336d6.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 06:10:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnqp82scay347FWvj3hEOIhZhdMMz3nT4iaLqmoQ+z5wsRaHQ/aIuumlWsZVi0lcHZi/5zynE93hU=@vger.kernel.org
X-Received: by 2002:a05:6122:340e:b0:566:2568:df1b with SMTP id
 71dfb90a1353d-566794c0a54mr742458e0c.2.1769522547250; Tue, 27 Jan 2026
 06:02:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-0-c55ec1b5d8bf@linaro.org>
 <20260127-topic-sm8650-ayaneo-pocket-s2-base-v2-1-c55ec1b5d8bf@linaro.org>
 <CAMuHMdU9HcK3xX=itqe2di1HS1SJvV6=ySqKyrtj7Yr1yXyuqQ@mail.gmail.com> <6e8c3d6b-8cba-42da-bafa-28becfa15d60@linaro.org>
In-Reply-To: <6e8c3d6b-8cba-42da-bafa-28becfa15d60@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jan 2026 15:02:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=u280N2HUgpiHtRXuMv0RhtDeEFDaSLFQ0Wg8frt+6A@mail.gmail.com>
X-Gm-Features: AZwV_QhN9K-WsMdmqL2nfJrvZ40lsYIN6kZoo7JRPE4M6cKNWw4lsg30FvWZJqY
Message-ID: <CAMuHMdV=u280N2HUgpiHtRXuMv0RhtDeEFDaSLFQ0Wg8frt+6A@mail.gmail.com>
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

On Tue, 27 Jan 2026 at 14:55, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> On 1/27/26 11:20, Geert Uytterhoeven wrote:
> > On Tue, 27 Jan 2026 at 10:57, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >> Document the Renesas UPD720201/UPD720202 USB 3.0 xHCI Host Controller,
> >> which connects over PCIe and requires specific power supplies to
> >
> > Here: "requires"...
>
> Sorry I don't understand

Please read below the continuations ("...") below...

>
> >
> >> start up.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/renesas,upd720201-pci.yaml
> >> @@ -0,0 +1,55 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/usb/renesas,upd720201-pci.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: UPD720201/UPD720202 USB 3.0 xHCI Host Controller (PCIe)
> >> +
> >> +maintainers:
> >> +  - Neil Armstrong <neil.armstrong@linaro.org>
> >> +
> >> +description:
> >> +  UPD720201 USB 3.0 xHCI Host Controller via PCIe x1 Gen2 interface.
> >> +  The UPD720202 up to two downstream ports, while UPD720201 supports up to
> >> +  four downstream USB 3.0 rev1.0 ports.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: pci1912,0014
> >
> > Just wondering: how does having a new driver
> > drivers/pci/pwrctrl/pci-pwrctrl-upd720201.c matching against this
> > compatible play well with normal PCI discovery and probing of
> > drivers/usb/host/xhci-pci-renesas.c?
>
> In Linux, power control is implemented as a platform device driver,
> so it doesn't collide with the pci driver.
>
> The pci driver won't probe until the device shows up on the bus anyway,
> so he power control will attach as platform for this purpose.

OK.

> >> +  avdd33-supply:
> >> +    description: +3.3 V power supply for analog circuit
> >> +
> >> +  vdd10-supply:
> >> +    description: +1.05 V power supply
> >> +
> >> +  vdd33-supply:
> >> +    description: +3.3 V power supply
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >
> > ... but no power supplies are listed here? ...
>
> None are stricly required, they can be supplied directly without
> a passive regulator. Not sure they should be required

So the goal of this binding is to document the required power supplies
which are not required? I am confused (but that could just be me ;-)...

> >> +examples:
> >> +  - |
> >> +    pcie@0 {
> >> +        reg = <0x0 0x1000>;
> >> +        ranges = <0x02000000 0x0 0x100000 0x10000000 0x0 0x0>;
> >> +        #address-cells = <3>;
> >> +        #size-cells = <2>;
> >> +        device_type = "pci";
> >> +
> >> +        usb@0 {
> >
> > The actual DTS uses "usb-controller".
> >
> >> +            compatible = "pci1912,0014";
> >> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> >
> > ... also not in the example?
> >
> >> +        };
> >> +    };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
