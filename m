Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456141;
	b=jn+EaT8tbVjtCdtzUNNl41G+7FlbzgG4A9av3bw2lmYDheZaiqfMm82fUEmrmElkmPrH
	 BlzebrnFGsGO1lDLYtAb9Okf0zkyorbafvY+WAKlJ8rowL5ON0sCvLyWv40yHbKoXpbbq
	 AaTMNe9ZkUWow4myERdHiPNEdun5KWvGeeDDq8WSm2h5fQZ3bVUa8f8sEGr0JINa4Mpt4
	 UGQugghlVXQvCgniF35rZKQB7ItJMgSBw2dSNByNwgDwI6qFEZ06hczbBau9bsIUvJK8d
	 g4ULYii8j6wW2yM7vdZ35L1ieyNv/cg23L+ob89V+HZtDHE3ktUFETtu2caLPhmJr7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456141;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=vEVjlzEn3WQFHK2xKs1NM+I3I5U4uHmFSrkbLsNjbyc=;
	b=Xx514VMDE8IM5g7d4ptssjMP7nwuY+tQkR1ewR6aJHFOtimtR2Crk4+RsTkkfQi/2ipN
	 KXT1tiI+rl59HcjAlKycpE0O9nTG2Yx/EbqnzJX0zkE0VbeXM18xtrWgITnuyrw+DIlNd
	 YHJUTqIgIpdxKgbmGaGsoTgT2uJUJlXCcQC/FDum8fEmdiPxcxlil0aaKC2iOKMMeXtzh
	 m6e6QuKVI48SOvp69Q7INaQrzW0TnamCWDMN0qs3hlk9LAlY2qu5qbXoUdq9Oaxtm0Ngr
	 MdCMm6RYJiaNNy7YkrhLpXvVALZljy8p09c9arc1r31RH4ByRi1IpvhVHFX2jV9dl2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONGPw028;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C346606A31A;
	Mon, 23 Nov 2026 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONGPw028
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFFD1F000C6;
	Mon, 23 Nov 2026 17:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456140;
	bh=vEVjlzEn3WQFHK2xKs1NM+I3I5U4uHmFSrkbLsNjbyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ONGPw02805aZXiAZ9uoMdJTODGLJ6aif30OMG33tebxMo3leiamcx5r2qzpet8alD
	 hVECUG6XNRaY0A3zQ55zLA6Su+mEgIu4M82I9lysgqxUOAdAtwBRYdtjU0x69rcRoC
	 yrnaY5aN8BNetyVVyimIo7V5FRUuk/oQHk9XpnlRQifYkUcUoL8cqi83pD3VqTK6Zh
	 Kogg7JMAJiBHhk1GgPmeaKlE32jM73SkdzBQqKQg2LKVjKXFlZloZwcOSnXDUh6DvU
	 TVNv1Ybi+YJgiYSQm4ktSRZ/vXhTLAHltSVY8fzZMSpZsx6lGD5Fqxc3h9tNgIkcEF
	 rvYlvC2w3yJhg==
Date: Mon, 23 Nov 2026 11:48:57 -0600
From: Rob Herring <robh@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key B connector
Message-ID: <20261123174857.GA55094-robh@kernel.org>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
 <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
 <CAKTNdwEFSDn4K_15pVK7=ZEWwanHQ284R4=spWWLCB0UspEMow@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKTNdwEFSDn4K_15pVK7=ZEWwanHQ284R4=spWWLCB0UspEMow@mail.gmail.com>

On Mon, Nov 23, 2026 at 02:04:29PM +0400, Alexey Charkov wrote:
> Hi Krishna,
> 
> On Sun, Nov 22, 2026 at 10:46 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
> >
> > Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> > defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> > connector is used to attach WWAN Adapters to the host machine over
> > interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0. The slot also
> > accepts SATA and PCIe SSD Adapters, which use the same pins.
> >
> > Interfaces that share connector pins are described as one graph port
> > per pin group, with the endpoint number selecting between the mutually
> > exclusive interfaces.
> >
> > The connector provides a primary power supply of 3.3V/VBAT, along with
> > optional GPIO signals: FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1# and DPR
> > for WWAN Adapters, and DEVSLP, PLN# and SMBus ALERT# for SSD Adapters,
> > plus an I2C parent for the SSD SMBus.
> >
> > The function of the GPIO_0..GPIO_11 pins depends on the Port
> > Configuration, so they are described by gpioN-gpios properties with the
> > function of each pin per configuration documented in the binding. The
> > Adapter configuration is either sensed through config-gpios
> > (CONFIG_0..3) or fixed with config-state, which defaults to WWAN PCIe.
> >
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-b-connector.yaml    | 332 +++++++++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 333 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
> > new file mode 100644
> > index 000000000000..4760863ff4f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
> > @@ -0,0 +1,332 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PCIe M.2 Mechanical Key B Connector
> > +
> > +maintainers:
> > +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > +
> > +description:
> > +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
> > +  connector. Mechanical Key B connectors are used to connect WWAN devices to
> > +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
> > +  selected by the Adapter's configuration pins. The slot also accepts SATA and
> > +  PCIe SSD Adapters, which use the same pins as the WWAN interfaces.
> > +
> > +properties:
> > +  compatible:
> > +    const: pcie-m2-b-connector
> > +
> > +  vpcie3v3-supply:
> > +    description: A phandle to the regulator for the 3.3v/VBAT supply.
> 
> The node name doesn't match what the spec calls it ("pcie" seems
> redundant). Also, can a module have separate supplies for its 3.3v and
> VBAT?

Yes, but 'vpcie3v3' is already the name we use elsewhere for PCI.

Don't know about VBAT comment...

Rob
