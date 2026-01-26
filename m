Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD272DA77F
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461485; cv=none; b=uemeV7VP7dhfpP8HgmWa650xyPml24SuRrrKhfs7TP+TnxqyA+7tG40+lQZH1qGfWJNYIkavdyJt2YMBU8rZv4Q3Qjuinst9ry2aolYfUyyuM2sgi7RoP1sCQV7Qyr6EGR7FVI8KOrlbiKfPbndLlI4e7gXog77wqenVb0mA/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461485; c=relaxed/simple;
	bh=WqSXMgwN1bj6WlKNWD0giAIg11OWSEsUWJe5KbkBJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8eG6CximPy6CTWR+eyNv8eoBd+rWzJcBgOTocE5utUVZfpGu2RL5RWsMq+jBtCfWqiG0ELlbRY3aBPGjq6okxkzrWRXQS57EAiXd3qmRdxUTKkmFnDTrTyU1tHc969c+d5SkuBFNLT3UeJzgGWzw6CvcjGwlugfYUjBaiMRRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbDWJmw2; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbDWJmw2"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56641200d6eso3008048e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 13:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769461483; x=1770066283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCW3LI0lwZJMRrEDS+3kqbUxY3kv4Hh4/Y+P85JSc/0=;
        b=SbDWJmw25iZpTuDFZlEX12ZKGbdbr0YjBOW8o5PYP2mweByU/iPW3fKfdabyNsXZEM
         6oCO2K9BC4qC2elGiGrei8+tqGzcknHy6kvZjWwXL6uDHKPQVzX61v4SRS8MsiQv+bIn
         MpELAVQe1ofCz8K++GHpvm/+hyHfhy2acE8OvzvwXNMPxltrYb2vrfK4OnFafwYiux4H
         dSeCAZnJkrwjk8Fw++ShZQrixDsVA9GJv+DVrMy+p+SgY+UOh7rahLOL6ef9DGnPsPb/
         ReUj9vExdNdOlAcXq1TZVZ7zJyonnzhQahdEOidCnf+FVufF2/od4PON9PmpubFRo//W
         sygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769461483; x=1770066283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCW3LI0lwZJMRrEDS+3kqbUxY3kv4Hh4/Y+P85JSc/0=;
        b=t5yi/N6WeIgn8VfsxJc+WVXC3WQDDBs7OmIbqbbV4RHeXqHrz5IZB6FDGlkvTeapbs
         mG3pPS++3/Z6kaN93M6Z8MNS5naLXcTx5NsGTQtpgFv3ByeFH229dr7quu6plo4WG+Rn
         rI5lQQ+ap/fVMDB38HNKgwx4007WVwwvCQcwGV9Am5IRSvea77Sk0ReXhjbDfa9JtnoG
         J5IsdnBOnQj5G5OoBxgBo7noi2qZL60kx9gFwqedp+HcMNFB9QDjggb2fWHYvpMyPlIH
         gd7kq8o+YSsfDyi/jzKFRzoZjtyFHfmmIOLvIc+YpEUDEff4sVvviyQoY2uLKN+MIlzo
         i03A==
X-Forwarded-Encrypted: i=1; AJvYcCXQAhltNECHSFuc2yvgZ5pi3zXYwae90HrzjsBnVHTTpFTmiCWYIz+nPlXOzYhbfumKVm6fTBiDJQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvf00iBr4fC6nMRnA4n2xftfGQqw/GpVih5a8t3XvnvhacGAkM
	SutVxif1yMJD4n+ouTVc5/sJLrDPbsNpHzCSPJJCQF0a3V+1s6V9SgBmAUQd3Q==
X-Gm-Gg: AZuq6aLnrPlqxiS8KJUGkImQ0CSWvsrxuFNhM7M4ICrRMcAuwFN3KRe3tcNy763gt9s
	VZ18HldgwXqrhKIXtk3vTZLwY7VVk4e/J3x8BrXjV+4BcIF5xw1n/TEgcyK7qh8E7WFOPI2NUll
	unTn+a8KE0/MqLBVj11lmfdAcNfnhdPUMS2kDourDXtCcK/F9DciNt9xD3mAu/2wIvKhUc6gFOT
	hSnmBCMjtE63dGjI9WffM0EgvQnuGHAhYtOjEtHeuc56LAbspmvnym+NbY8qvbQ+/+JU3oEW0Jh
	4avoLMRCsIXv+5AYtlN8qwLbTRSFTuthH3rzMrMcc7R2N0FxKCz7Bf+oi9d3dphUuLs0bdnpXsN
	vdmbkIdMssEY505iKxdiTvVdNmO2wUm1o/kXsWVgWuL7XKZ2vZInxuh24G8HsQjUhwr7R74PkUz
	sut2ifwmlZfdUyfJAA+laY7tKwtuFCo1viq2O7Iy6llH++ptGzzfgG
X-Received: by 2002:a05:7301:1003:b0:2b0:5028:bafd with SMTP id 5a478bee46e88-2b7642198c5mr2076868eec.8.1769454774472;
        Mon, 26 Jan 2026 11:12:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:cb35:17f5:7e82:90c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b749e301f0sm13452476eec.35.2026.01.26.11.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:12:53 -0800 (PST)
Date: Mon, 26 Jan 2026 11:12:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christopher Ruehl <chris.ruehl@gtsys.com.hk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix emails with spaces or missing brackets
Message-ID: <m5ckxhpvhtjcc6fzlsz7y5sjxvzlbx6n7vel264hbw47joivi6@iwchebcbyjod>
References: <20260126164724.2832009-1-robh@kernel.org>
 <9a3d4ae8-b57e-450e-971b-d09fc923eee1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3d4ae8-b57e-450e-971b-d09fc923eee1@roeck-us.net>

On Mon, Jan 26, 2026 at 09:21:15AM -0800, Guenter Roeck wrote:
> On 1/26/26 08:47, Rob Herring (Arm) wrote:
> > Fix email addresses with spaces or missing brackets. A pending
> > dtschema meta-schema change will check for these.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> For hwmon:
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

For input:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> > ---
> >   Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml    | 2 +-
> >   Documentation/devicetree/bindings/input/syna,rmi4.yaml          | 2 +-
> >   .../devicetree/bindings/media/samsung,exynos5250-gsc.yaml       | 2 +-
> >   Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml     | 2 +-
> >   4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> > index 3d14d5fc96c5..7b38f2182ffa 100644
> > --- a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >   title: Sensirion SHTC1 Humidity and Temperature Sensor IC
> >   maintainers:
> > -  - Christopher Ruehl chris.ruehl@gtsys.com.hk
> > +  - Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> >   description: |
> >     The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensors
> > diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > index f369385ffaf0..8685ef4481f4 100644
> > --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > @@ -8,7 +8,7 @@ title: Synaptics RMI4 compliant devices
> >   maintainers:
> >     - Jason A. Donenfeld <Jason@zx2c4.com>
> > -  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > +  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >     - Vincent Huang <vincent.huang@tw.synaptics.com>
> >   description: |
> > diff --git a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> > index 878397830a4d..9196cf5dac0f 100644
> > --- a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> > +++ b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> > @@ -9,7 +9,7 @@ title: Samsung Exynos SoC G-Scaler
> >   maintainers:
> >     - Inki Dae <inki.dae@samsung.com>
> >     - Krzysztof Kozlowski <krzk@kernel.org>
> > -  - Seung-Woo Kim <sw0312.kim@samsung.com
> > +  - Seung-Woo Kim <sw0312.kim@samsung.com>
> >   description:
> >     G-Scaler is used for scaling and color space conversion on Samsung Exynos
> > diff --git a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > index d286b77921e0..8f5d33050348 100644
> > --- a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >   title: Mobiveil AXI PCIe Host Bridge
> >   maintainers:
> > -  - Frank Li <Frank Li@nxp.com>
> > +  - Frank Li <Frank.Li@nxp.com>
> >   description:
> >     Mobiveil's GPEX 4.0 is a PCIe Gen4 host bridge IP. This configurable IP

Thanks.

-- 
Dmitry
