Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892B2236E3
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476557; cv=pass; b=kMSkfy/kUttWZLKgOdFTWkenqe6KiPvKmTNI1WBaJB7KSTwXZA6dkLV9ltOUdaMCD6Z5w+g4xfWGsqEg9mch6JToN3wWSs2sxXmOxBZOhVFfH9dQLqHBkE2Hku56gIHknw1t96plhlWhqpoY99yNI6ZroIEnHik6T8sN6TQtaYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476557; c=relaxed/simple;
	bh=SD8bwUDdBddm0zHH51qwfp9UPjfJkW2MFdQRs4LmgX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eK7rlibzNMPLJLzdfw5H3IkTQy0vlOk8A3e74sspyiOB9SlRWz9qRuf2c/NkpeMBg4DCqnbn/fIzFDUfpSW+0nPWpIyKdgwUT4b33trUyDfFZRHcMmlHKA8o8wAqhusoQb22c6TmqLtIHAMwBSvUvT0DJB5Zk6pMQDmG1xqlomw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WaD8s0V2; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WaD8s0V2"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso3490653e87.1
        for <linux-pci@vger.kernel.org>; Sun, 10 May 2026 22:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778476552; cv=none;
        d=google.com; s=arc-20240605;
        b=RlDM7Js1RUrPJef+d5HDkNZUJDW9aXnAXbEKMqk+6n/ZH3kMTJnChqSag1/+9kHIiC
         j3Uz1CHY6Dpdk/31cRZ0sMs+T5eMOTB7l2pGG3+3D7QKm69NNGycFRm0RrN71DXzVedh
         w8MEP/xgSpgv2wlEbaD/ye2+WVNstaDZjc6rfKpAzTR5BVk4YABD6p+hz39wsmKCwiV2
         4RLNmPjfSCXyHgEm8fJULyN6+GhirwEfGqch/o1G3etLinG+jdeTFJdW8+XO29OeVuzg
         gPDlMJivo3k9iz2CG7QaR8kHQ8nr+rkv/ALH9mJeqSwJWnvHRO1gt3PzHMHDVyR490FL
         Tizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=akkiEFtz33SlVQRBU3vV8aupDFCE2BQOw1/swe6zPGA=;
        fh=4ezUOIld0WtELVay3oUnBtv0/8QtpXCheUm/fzigZKM=;
        b=G26kxSFEwxfogKgC2O70YJbLOAyg8t3Apexuf6CsMHX9h0u45keFU19rYttrTNnQdt
         n9xXUAKh92nXXDeFTqHgwHjpvQPu0glBVujwH85KM02RmlNSOAM2hXI5W05lfDwj0QwU
         syxqFtLl8yptl/qAYpaNcSwfrkE1inwC+kIXi5zGt2QPn/87ljbZR1eHVPYZ/+TYK22U
         K2HRgFQXIHXD2bB99hKykoVzrKBAcETb+z20mHedtw6zgYeBCoKHgIitkVThuYGAPAq6
         AWSXgf5Qoy2rE7rDaxBfPjWA9V6tind4BoWmOejNOyFl0hDKogsaNanMqB1EAOnnwA2H
         wCOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778476552; x=1779081352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akkiEFtz33SlVQRBU3vV8aupDFCE2BQOw1/swe6zPGA=;
        b=WaD8s0V23hKcnzdcNXedzIKS7Nz2nzsw5M5P0BQHdn9kHIsGEtUOrpxW+Hm+8RXZxD
         nvUHrR381lrKoz8/sxKJ+QNPv1IVpZ0dwgpiNvtf7z0QkjebLgslRvV/h2m+48l9UWpn
         9tAl9AKImll1c67xccFzGhvTXYjb0D3w6NjZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778476552; x=1779081352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akkiEFtz33SlVQRBU3vV8aupDFCE2BQOw1/swe6zPGA=;
        b=YoSpo4wUw5bUBXf8xJyYosSPnmG1c+GP5F4cnbhoDjJ2Mf7V/mHTAzaBomQA5ZjKRs
         CrylmcUKPwkORuL0TXvu/6Rf6xzeUHQmAxzzNNM0fjop7b+GTgai/DaZrq+c9IwtCLPD
         X9Oajhd1yEdXo1LkojhkJt8Nm/PWOVD+ubuFxwxKP7/pxFyfqEBNebAUj7a5G/LI6kal
         zGdBfhIqo9lOnb+9jqbmJ3reAuftDqQ9Qa9Y0NNPAnaaeVXMmKNVXARdhi8WI08F6e0c
         w/CRPEEBLEIdCRSQelovWH0XAcwEZkBZKk+6APQjzq0PnVbUOUUz4StjwnX1+W9cKquS
         TKOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+V5VlDBIPcPAYGQX3gcCuIubeCJORzpFM+GiF0S3JDpyZc2cQSEoK18pdyHerTRj1s++Fi6FUvdYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+acGyLISvM/k9H0aYFDSNsyWIz6/fV20v2LT/axpjqHaA+q2
	fRZSE6ZfRxfWl01WUFuUNrVVoDI9LFjp/S7slowb9+vbv4l1z7pkIcto3NnovZGkX+I0MH+WB3d
	MoJTZiT86F09sXBmuaZErqpbwWqArjxdGLZyi4T3W
X-Gm-Gg: Acq92OFz17SvqPwBZbTBbfIq2BAquV1mZ8YtBZSa6ccGfa2mBH/dkNJQ6z+1WRwXwz3
	4HLZ6nTdT6cIM37X5uwphsS+pzlpfHLwZVAtHL+I9dX7/IqCiQ/Jih/NBjvl3h3xZurU3N1VSrY
	FDegbdADPi3aKmK8puHG/pCk6WqsrL5sxtxaTQZuPv0grsBWVce1gL9+hWaCm8g9zfSnK9uyqkV
	6ZGK4c5xEksiND5XaToNNe97eutTlIdDxyfb6CUCZ5n0OBr21egJrlzrtjHRZFwolKvmREoG/Nr
	2+kM73+8sqxVBO6+f1e3l6I8wUinYbzqRyxVsQ==
X-Received: by 2002:a05:6512:6d0:b0:5a8:74c3:5d9b with SMTP id
 2adb3069b0e04-5a8b6c5f46fmr2281211e87.0.1778476552163; Sun, 10 May 2026
 22:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508063633.3894348-1-wenst@chromium.org> <20260508175418.GA97653@bhelgaas>
In-Reply-To: <20260508175418.GA97653@bhelgaas>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 11 May 2026 13:15:40 +0800
X-Gm-Features: AVHnY4LZjBv6gGSmOK6fCKQuMDYhc9G69oS06Omds3Eto3-e9S9bD2qEZifR9TI
Message-ID: <CAGXv+5GBd_RiAiJRbjE82j_fFPdhan+W2z7tx3o8HAKvsrD0zg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 1:54=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > controller memory access could be limited to a small region by the
> > firmware configuring a memory protection unit. This memory region
> > must be assigned to the PCIe controller so that the OS knows to
> > use that region. Otherwise PCIe devices would not work properly.
> >
> > Allow the memory-region property with one item pointing to a
> > restricted DMA buffer.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This patch compliments another patch that moved the memory-region from
> > the PCIe device to the PCIe controller [1].
> >
> > [1] https://lore.kernel.org/all/20260430120725.241779-1-wenst@chromium.=
org/
> >
> >  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.y=
aml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > index 4db700fc36ba..4a9e41d01628 100644
> > --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> > @@ -115,6 +115,10 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  memory-region:
> > +    maxItems: 1
> > +    description: phandle to restricted DMA buffer
>
> I guess this is similar to
> https://lore.kernel.org/linux-pci/20250716053950.199079-1-huaqian.li@siem=
ens.com/
> and uses
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/re=
served-memory/shared-dma-pool.yaml?

Correct.

> Looks like those keystone changes were never merged; I don't know what
> happened to them.  But it will be good if everybody does it the same
> way.

Not sure what you mean. "dt-bindings: PCI: ti,am65: Extend for use with
PVU" was merged as commit 57a48a2619c5. Maybe you are referring to the
last patch in that series that adds a DT overlay?

> I wish there were a simple way to grep for this restricted DMA
> concept.  Maybe there is and I just haven't found it :)

Probably just grepping for "restricted" in the PCI bindings. :|


ChenYu

> >    mediatek,pbus-csr:
> >      $ref: /schemas/types.yaml#/definitions/phandle-array
> >      items:
> > --
> > 2.54.0.563.g4f69b47b94-goog
> >
