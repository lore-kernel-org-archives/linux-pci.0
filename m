Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D1423EA4;
	Tue, 28 Jul 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244184; cv=none; b=WAW5C5PskoyIKBuYNH9eHmCZROD5e/76jCX1zf3B1Gp4V5pWkVtQHe9Gd/w2xWTD2IxKXzU8qrJ03JltHK27T6ejQoi5z1lT4xA15R9AaoeK/tVT/KNHkyi6/jpuGsgBI/4N7/I1IWf/PGX4sC0PVltYzcTkPSh+7GvBRb/9RCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244184; c=relaxed/simple;
	bh=J67shwpbuU8mvhmK2Tp/JfpVxXj/331Uec4VDUvk7+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gft/kQjwt/lr+u7OVBLtfFJJK3hQ2HIK1zud2xj2NXvhCM20oANpoxhSkhMnshxSIH6NnyrcMT5pH1Z7riVfuASyim6burXvpCZQmqNN88+b41j7S3rHBwDAy0YhrbhpLwsfgrl3lhh7vHRLAi7yl7/xCVvdfYWIH4z1UbA/dtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IunwN6tM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IunwN6tM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542441F000E9;
	Tue, 28 Jul 2026 13:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244182;
	bh=k37+FHrFh/Jrh0T9kw1dTGUOp/80bppOsaQVSFejzdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IunwN6tMhaH39Eo20mVijv1GGXdrsc/jmst0MZTJQ4qCbF1/8lrRFvXHG+n61aWGn
	 Ve0zgVdVL5HiLkohdZXspNNQe4LfR4fz9MqndZzWmx2sNPgX/nMut8OthFjVkpCtfa
	 fqzr3cXXXVQYTsbcqH1al3Sl6L9HF2xCAAVIdkr6TOUbmS+ztt842AVtiH3Q+MomU0
	 smapeueB0298h6M2jnkF3BlsizAGLsD2X3cjWmSyxLpxcHVmxDF91lJeXQqxH9Qtnb
	 lXGcuDXXQt74Md9LJwvKpZKS9nhKC3XkYHNtJROssUuGc241Jils0GSvf80Xw+hgRr
	 iYTuLImYDmcfg==
Date: Tue, 28 Jul 2026 15:09:33 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: PCI: toshiba,tc9563: Restrict Tx
 Amplitude, DFE and N_FTS to USP, DSP1 and DSP2
Message-ID: <pgb5r2w7ab24mkxqqftlgypaubg4zcd5pbt27eczdncshmlmse@z56fok3dnq6a>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-1-ec4286e31331@oss.qualcomm.com>
 <5ed98bb8-566a-4054-83a5-f7dc64c8600d@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ed98bb8-566a-4054-83a5-f7dc64c8600d@riscstar.com>

On Mon, Jul 27, 2026 at 10:59:02AM -0500, Alex Elder wrote:
> On 7/25/26 3:59 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > TC9563 switch allows configuring Tx Amplitude, DFE and N_FTS settings only
> > to USP, DSP1 and DSP2 ports. These settings don't apply to DSP3 and also
> > the integrated Ethernet MAC Endpoint.
> 
> s/and also the/nor its/
> 
> Also I don't know if there is only one Ethernet MAC here, but
> the TC9564 has two, so maybe make "MAC Endpoint" plural.
> 
> > 
> > So restrict these properties and also move the
> > 'toshiba,tx-amplitude-microvolt' property to DSP2 in the example to conform
> > to the binding.
> > 
> > Fixes: 26f3ac884835 ("dt-bindings: PCI: Add binding for Toshiba TC9563 PCIe switch")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> I have some other questions with implied suggestions below, but
> this looks good to me.
> 
> Acked-by: Alex Elder <elder@riscstar.com>
> 
> > ---
> >   .../devicetree/bindings/pci/toshiba,tc9563.yaml     | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > index b3ad05d90201..f084830c6d0c 100644
> > --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> > @@ -54,7 +54,7 @@ properties:
> >             - description: I2C slave address
> >   patternProperties:
> > -  "^pcie@[1-3],0$":
> > +  "^pcie@[1-2],0$":
> >       description:
> >         child nodes describing the internal downstream ports of
> >         the tc9563 switch.
> 
> Can you offer any explanation about why the settings apply to these
> two downstream ports but not the third?  (I think it's because the
> third has a different type of link to the endpoint.)
> 

There was no explanation provided in the manual or in the application note. But
since these are PHY related tunings and the VDSP has an integrated MAC Endpoint,
these tunings are irrelevant.

> > @@ -64,6 +64,21 @@ patternProperties:
> >         - $ref: /schemas/pci/pci-pci-bridge.yaml#
> >       unevaluatedProperties: false
> > +  "^pcie@[3],0$":
> 
> Can this just be "^pcie@3,0$"?
> 
> Is there any need to define "^pcie@3,1" for the second PCI function?
> 

Good question. I tried "^pcie@3,0$" first, but it throwed the dt_binding_check
error:

/home/mani/tc9563-fix/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml:
patternProperties: '^pcie@3,0$' should not be valid under {'pattern': '^\\^[a-zA-Z0-9,\\-._#@]+\\$$'}
        hint: Fixed strings belong in 'properties', not 'patternProperties'

Looks like the schema doesn't allow fixed strings in patternProperties. So I
used regex, just to satisfy the requirement.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
