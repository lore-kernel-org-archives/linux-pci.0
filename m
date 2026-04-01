Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D643CEE6;
	Wed,  1 Apr 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051384; cv=none; b=MctrnhsvRd9A2+6qiCe6ATScYEVaev99h+INxA333SdnAe10xgSTWFWOTBBd9yOG1jIJ4whwgQWWhf8gxCOVjtg0PFPu6VZzQb7JjQLRDkXxZeL3aaadGLKcAidnqC6v4L0yIvsu/Aqu3Al+zl1bgih2OEuyWdmn9bST/JtoQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051384; c=relaxed/simple;
	bh=wnicqEeHIcqp5ZnGqJTdM7J1jA0zUu3BuP2FzYEpCj0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=tLgYGrNDplB1mSS2TjTUSm8aUoGCq8yJmER5Acjk8zWqLqMCULU6MnNCHMPdkS7buKSSc65EMBfyhsXeaGVDXS6iCIRKUe91wM95YakdLgeTbWApynoVG9al/oru7aSJaC34VSZLrfpLCxE8Ii4Vgua4oZ1MD8lCQqPQE4sV6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=QXD80xXj; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="QXD80xXj"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7vwx-005MN0-3I; Wed, 01 Apr 2026 15:49:39 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7vww-00490O-FA; Wed, 01 Apr 2026 15:49:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775051378;
	bh=fI1MXVmfBBplFMrNS9AHS7FUoW6UH37o/7iySpxDqLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXD80xXjmv8zRKKTemd5Oo1nyFUtxLSfSM8fu/3kq3G3gAA3/td479zV2BROwA7Ev
	 M5uJyY2MB5l95RjD3AWt66Q0DjJ6oiDRH0ydZZCoUMvgVVWFL7+1DV4v4rzHQrfEvd
	 iCH1SSOyLxDKFSwIdcf6flYlczUM4PvsNJR8SJcaHyMKbkcoqjN90ZeTRsPjLmBJX1
	 gXprSW9Idf16Ht7m0VMDmgbdnvYUA2cb9eFO5cuNbJ6arlzANHsJgeb8VFO8VMaZ77
	 24XMxSAp4CjMwC59cGSiSZtOLv2AmoKq0BIEB07adfzJ2lJGO5PHnzssmrkG2r8lXr
	 DjCRbRFD2KxQg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 06297240041;
	Wed,  1 Apr 2026 15:49:38 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id DC41A240036;
	Wed,  1 Apr 2026 15:49:37 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 978A723BFD;
	Wed,  1 Apr 2026 15:49:37 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 1 Apr 2026 15:49:37 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Eckert.Florian@googlemail.com,
	Rahul Tanwar <rtanwar@maxlinear.com>, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ajay Agarwal <ajayagarwal@google.com>, devicetree@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, ms@dev.tdt.de,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v3 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu
 resource
In-Reply-To: <CAL_JsqL2JW6zecCJGhFiJYraSGRNJGRsZ+oWJ+=4JWY5GD9SPQ@mail.gmail.com>
References: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
 <20260401-pcie-intel-gw-v3-7-63b008c5b7b2@dev.tdt.de>
 <177503985369.3634917.6461713197883659054.robh@kernel.org>
 <CAL_JsqL2JW6zecCJGhFiJYraSGRNJGRsZ+oWJ+=4JWY5GD9SPQ@mail.gmail.com>
Message-ID: <5dd6db90e7cd5b2e75dbb85dab202dde@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1775051379-F97366CA-F08873F8/0/0



On 2026-04-01 15:07, Rob Herring wrote:
> On Wed, Apr 1, 2026 at 5:37=E2=80=AFAM Rob Herring (Arm) <robh@kernel.o=
rg>=20
> wrote:
>>=20
>>=20
>> On Wed, 01 Apr 2026 11:31:43 +0200, Florian Eckert wrote:
>> > The 'atu' information is already set in the dwc core, if it is speci=
fied
>> > in the devicetree. The driver uses its own default, if not set in th=
e
>> > devicetree. This information is hardware specific and should therefo=
re be
>> > maintained in the devicetree rather than in the source.
>> >
>> > To be backward compatibile, this field is not mandatory. If 'atu'
>> > resource is not specified in the devicetree, the driver=E2=80=99s de=
fault value
>> > is used.
>> >
>> > Old DTS entry for PCIe:
>> >
>> > reg =3D <0xd1000000 0x1000>,
>> >       <0xd3000000 0x20000>,
>> >       <0xd0c41000.0x1000>;
>> > reg-names =3D "dbi", "config", "app";
>> >
>> > New DTS entry for PCIe:
>> >
>> > reg =3D <0xd1000000 0x1000>,
>> >       <0xd10c0000 0x1000>,
>> >       <0xd3000000 0x20000>,
>> >      <0xd0c41000.0x1000>;
>> > reg-names =3D "dbi", "atu", "config", "app";
>=20
> This is also wrong. But the diff of the example shows the old vs. new,
> so there's really no reason for any of this in the commit msg.

Got it. Thanks for pointing that out. I=E2=80=99ve already removed it for=
 the
next cycle for the v4.

--
Florian

>> >
>> > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> > ---
>> >  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>>=20
>> My bot found errors running 'make dt_binding_check' on your patch:
>>=20
>> yamllint warnings/errors:
>>=20
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/pci/intel-gw-pcie.example.dtb:=20
>> pcie@d0e00000 (intel,lgm-pcie): reg-names:1: 'config' was expected
>>         from schema $id:=20
>> http://devicetree.org/schemas/pci/intel-gw-pcie.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/pci/intel-gw-pcie.example.dtb:=20
>> pcie@d0e00000 (intel,lgm-pcie): reg-names:2: 'app' was expected
>>         from schema $id:=20
>> http://devicetree.org/schemas/pci/intel-gw-pcie.yaml
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/binding=
s/pci/intel-gw-pcie.example.dtb:=20
>> pcie@d0e00000 (intel,lgm-pcie): reg-names:3: 'atu' was expected
>>         from schema $id:=20
>> http://devicetree.org/schemas/pci/intel-gw-pcie.yaml
>>=20
>> doc reference errors (make refcheckdocs):
>>=20
>> See=20
>> https://patchwork.kernel.org/project/devicetree/patch/20260401-pcie-in=
tel-gw-v3-7-63b008c5b7b2@dev.tdt.de
>>=20
>> The base for the series is generally the latest rc1. A different=20
>> dependency
>> should be noted in *this* patch.
>>=20
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up=20
>> to
>> date:
>>=20
>> pip3 install dtschema --upgrade
>>=20
>> Please check and re-submit after running the above command yourself.=20
>> Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up=20
>> checking
>> your schema. However, it must be unset to test all examples with your=20
>> schema.
>>=20
>>=20
