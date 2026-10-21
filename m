Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792597473;
	b=r4HAglo2bqU5VRIWWbXlo9ym/iJtaK7a2wcRNCUHiH2xIXgAvLxtGcQDCbYWRf5juiZo
	 rbSBcnzucv681hr4PmRQ7DRkbUgRXsX2DMbKQ01cPtasccL0g14daO3OrvHhR8TP3aK9L
	 qu1MhN6A0xwYp8WzxhR5+7HdsV4RatsqgKmnnmDgcx3ckQ3nObbdq0qYzFAPrqff14waq
	 /fjF51oQJnEAsecwJGHQVFt2wx308nC3vbJkAgdhMdwGfZJZvfnLT3fHdcpd9VEJrGJS7
	 3mx7NF86moGxTb1gR7ucy0zOjzRlDoaztE0cGO4t8cKXqin4nFUrjwJ5axdTL3gxDyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
	b=WH1R5g6/DGyViXGSLM/ZYQDlN12dgcWWVlS14nmvn2Y8q836+L8XqsvuxV+x4YOPhKJw
	 GKoswo6U+jf/GyK4C0wUGj+6mR4aID+V5IZBlwMMPxqvdXfl3M5HJtwgAd2kJGD4w7T1s
	 HBKzz91CZ6Gcw/tH5gjcwiRQTmUM00T1u+yManhzETQic/EdsQ37Bw8sV26E7/QcJLKGD
	 H3xpvxrH1/Soi2LaFe1RiDm12lT0lAZ0Jr2aku0kwR8Spf0VJqCaI9mDxn8ExQUn4hstS
	 tsqDaCIC8RIjd8JwYRqfZaQSNE7/hdVOQcLbchDe17YCQBxgRGKCE3QKPZY/Hh5betg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b="fT1Ejq+/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A960A2627
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E6A960A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=fT1Ejq+/
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso127928766b.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 08:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792597471; cv=none;
        d=google.com; s=arc-20260327;
        b=HEmVAbQ41zQQ+kvG9mIjIEW6P+4aq2Lls+UpRRzBaYnkkkoDrK8m0/nRDzfT7kiQ4C
         Xm6MPXeSL88vZZ3MfeRie5MtrxsRcsNRtfnywgKijmcDlpITpUiM6n3XQlGfh/jr4Gbc
         ELIRQRcJPI4z79yMx5CGGwBe4DeJtSHWMJeTGBMI36WvQqA4/EPgE16InxDbPvKGSkKY
         TLbmB6Mxp0+xEwbFH7QY17al9DK42CKeAcqeHnOHSgR/sE88/RylnlWpQMBTbC/g8dYB
         5YRw5r7shtLE8awaI9DkKb0WosunsYCz/q/uWHrJuvZfpyZqLbQg6yAVhanODOF/IvNv
         WW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
        fh=JT19lwrc+le7QVW2eOhG6qTJMJlqy2oyLEvPfpYemZw=;
        b=dVWI6ttKuayKdCk5WjTojfOl5WG/l0bqzYE3Wx2v5kbIUrT/DW0gHCfjaKj7bsTilM
         XmNOxFiOJFOQQuJOTeaN9rO1OvlM74o8xmB424e33nmfKTfkFPkBj1MM5kCI9wsM23sO
         KJ2I6GgDZJpXyPU33L7Z8BVATHNHX9gnwAwjm4cX/b283wxc7d1NeIi5cIZKySN+opsI
         WdsyO6r4ECEpdQJFLR0iCpipEOb1TJ2CVFNIrrJLBV8O4SZ49XqRxf2212zBYZAhGW/U
         ertUW1wW3AEs9vFe9Zus0SJ7pKswu1ihbFRdrLwQnue8qcb14lSrugixQuRmcCbCcQdo
         2biw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1792597471; x=1793202271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
        b=fT1Ejq+/L56l79ie+PNmdQbxUE9/wPpsUh5WzFCARRIo7DhXjRMQdSMvNzHnT/eXUK
         U1uG49UybtIek/3tGTHsFnortB7I2Ud3eqM90D/fcwX2ZoNpWpLOYqIySWj5tZGiVmo5
         A8c4weGoCSi9qGxJAFMQK7fltmLgJitKz6b5FZvPv8IhrMLbQUQ3XkwLPLN4X5zIAw7V
         jDdMr7FQo9B1Jxu6a/lEtrZm7yUThf57nza2x9rNdhhjVZ2bCwn+ycLxa1LDU2+7gAwM
         c4w3om4KynnPQ8oVYNL8wqUCw1p0MtaOC4BAZXAZdu98lWHTUOJYF6I9QRNLwZnlW/9S
         b/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597471; x=1793202271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JP3isnTjkGCFTemUyIlLVxDc+jortqiyhczyp4kIfzM=;
        b=QMu1zLog7g+PqT93FG5qhPFExuqhILn9rUZ0c7E+t0OXjwwVQUKrqN+HG6GI7F4MPv
         wQrBMah7Npx+axV1uSgDGnA6nH/YsgXwvrTGl46a6JJeFtE7Cys+HoRAQ38LNA7DGu5E
         3m3vLVdjGSCVYz7qE9DnaKY1EJ9/XZpU5WEtmTguQ7cqxi3L9FsDDauzG+HWY1mvIa9g
         +nzwnpkzOYv8ToDBMjXhUR9SjL9URthX6FtxTGv8Zql25/dbeoWqWeJWCD/fV6EDmaji
         QnNHqMLBHl6AOeEELtIEoeAaaRrvxQVYh+vJFje3WcDsTg5mMzmzJYP2wbSU8ry9TAMN
         6nkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGv32EW4lg7L2Cs2nJsi+wOh0Z9eetZVxrGjNSbiyIMkbgSuZOcFVHvwEe9Bsok8dS/JzHxhG74xg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/uXHrQvQx5FdR6lC/aHg2oFo1q0F4F7byYeSX03QaEk3HEZUZ
	xLu8EJKosRNl3FYvPYehioAtsYkR9FVRCjG1AMIwK37sx+v0PKyTYqhv0jpdsEuei5FwUb65wJF
	ZvQ8XnYBd21sB4V5kX2rDk8wkHKpAUNmddZmIWvtCow==
X-Gm-Gg: AYBFou1DKV3UQHVS6IGJy3sW49kaav+6eeEopjqjMhhWqlWmlrUzFiFWk5+0tMOC83r
	NhYH4UspNBjj0XInK7spnp4MTsoaEkjdtw7/rYplDlZi7eqJBvYmPLGPdYnht0M5fFq/FKsVhmq
	yleXDotG4GFkcHfnxuNCb6w0uR6fekUy/o3h/hzHlETmNFFyN3DOtFHXO7Zo649hZqWWOkbB9T/
	3bmvzWer+bUYt777fcBbG8oL5qogRlM4gzTjQJABpMjODDNXy3uuDPI+ZPWoT+e2oGPDbtgJIIo
	cB7BbZ8Z+fsgtPTxRnSayQT3jjdUejhouo1SomEKN31JBk/nkkWoj56JNCgE3UwALuIkcWHIUvw
	dXLTs5sefzY0qnc8iPljVtIZxBG9Jc+sv6DmRU/JQR1Rq+aNfI+09cqp5TBFhskUTHqzQ2w==
X-Received: by 2002:a17:906:4fc8:b0:c2d:ca32:2176 with SMTP id
 a640c23a62f3a-c467961d9f7mr245660266b.8.1792597471151; Wed, 21 Oct 2026
 08:44:31 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com> <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 21 Oct 2026 19:44:20 +0400
X-Gm-Features: AclHuK_OzLUc98RwVb-VyZ4la1jnJworigni-GUiOSt1W-ytIr-eQQIArUmgwS4
Message-ID: <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Wed, Oct 21, 2026 at 5:51=E2=80=AFPM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by the
> Adapter's configuration pins.
>
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals for WWAN-specific power/radio control:
> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_ON_WWAN#, and DPR.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 147 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.=
yaml
> new file mode 100644
> index 000000000000..a7f4bcbc5119
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yam=
l
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key B Connector
> +
> +maintainers:
> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical =
Key B
> +  connector. Mechanical Key B connectors are used to connect WWAN device=
s to
> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB =
2.0,
> +  selected by the Adapter's configuration pins.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-b-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
> +
> +  full-card-power-off-gpios:
> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal=
 is
> +      used by the host system to turn off the entire Adapter. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO output to RESET# signal. This signal is used by th=
e
> +      host system to place the WWAN Adapter into a power-on reset condit=
ion.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
> +      details.
> +    maxItems: 1
> +
> +  w-disable1-gpios:
> +    description: GPIO output to W_DISABLE1# signal. This signal is used =
by
> +      the host system to disable the WWAN radio on the Adapter. Refer, P=
CI
> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  w-disable2-gpios:
> +    description: GPIO output to W_DISABLE2# signal (default function of
> +      GPIO_10). This signal is used by the host system to disable a seco=
nd
> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0,
> +      sec 3.1.12.3 for more details.
> +    maxItems: 1
> +
> +  wowwan-gpios:
> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Adapt=
er
> +      asserts this signal to wake up the host system. Refer, PCI Express=
 M.2
> +      Specification r4.0, sec 3.2.13.3.6 for more details.
> +    maxItems: 1
> +
> +  dpr-gpios:
> +    description: GPIO output to the Dynamic Power Reduction (DPR) signal=
.
> +      This signal is provided by a host system proximity sensor to the
> +      Adapter to trigger a reduction in the radio transmit output power =
to
> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specifica=
tion
> +      r4.0, sec 3.2.13.4 for more details.
> +    maxItems: 1

This seems to be missing the four CONFIG_* pins, which are quite
crucial in these connectors, as they define which interfaces the
module asks the host to provide on the respective pins. Without those
module type detection is impossible.

> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host s=
ystem to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.1=
2.1 for
> +      more details.
> +    maxItems: 1
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on th=
e
> +      connector. Since a single connector can have multiple interfaces, =
every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: PCIe interface for WWAN
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: SSIC interface for WWAN
> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0 interface for WWAN
> +
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB3.1 Gen1 interface for WWAN
> +
> +    anyOf:
> +      - required:
> +          - port@0
> +      - required:
> +          - port@1
> +      - required:
> +          - port@3

This misses SATA which shares pins with PCIe. PCIe second lane also
conflicts with USB 3.1/SSIC, which isn't captured here. Should it be?

Should the graph also envisage connections for the I2C bus (GNSS),
audio (2 or 4 wire), re-muxing of W_DISABLE2# and WAKE_ON_WWAN# into
HSIC functions in Port Config_3, GNSS interrupt line and the such?
Should the connector node also define pinctrl configurations for each
of the 15 interface configurations?

Best regards,
Alexey
