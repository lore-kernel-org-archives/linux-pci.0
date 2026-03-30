Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF23BED71;
	Mon, 30 Mar 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867944; cv=none; b=or9KQsGEMOjfzFDkPAxsosvolkraPX2rPaStNxBBpZ6oJn/1ufg11SAAnZBdf4dsRyg3oWyzUlq68hqrnctfErVgmaA4AGbtTcTS2pBzMlOnxCQuls/s9krzJ7LxDo2rP8dk4uhBold9aPkSc5J291Ca/B/46ENbpDsyKznyYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867944; c=relaxed/simple;
	bh=D+SiK0i5DF0AJ/XycJ8nhWu794AmX3HCGFp0PoPZ3SA=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=rsvBAti0GZg5IiZ4edfmguiG1XSLd4aK5S1sl16qnWsCt0Irof6HK24i6tbsSC0ApAPQXlLNIk4FUkF9WqcbJoj+M2RD7WkM1Lk8bNOEm3CxDnDLwKnCvvdc35RJf/nZ8+pUtB74H29CvrQrY/j6JRw58o4MMK9bEkWK+S9zM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=UFzUkFRI; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="UFzUkFRI"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65635f912b=fe@dev.tdt.de>)
	id 1w7AEF-00ABA7-HW; Mon, 30 Mar 2026 12:52:19 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7AEE-00AIuC-Sb; Mon, 30 Mar 2026 12:52:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774867937;
	bh=HvbWi47gqlNyI9kHp+KSuG7Ib+pQMoiDcb2Hu3VVp+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFzUkFRIsYeB+K42ZjrXWJIFJj6sM+dL3YOGvbWYbn6rpJbvYNzUeId9LNYo23mZU
	 hIxVPfJ9OReYNJGZx9kT35B7cpNzO71kvYkgd61fQhs2qb/fEqXY2EbkhlI+E3c7CO
	 5++mqj5prJqraa0766xfttwzOwKdRI3Q1ZU6gvpWB90+6l7bmikuSz6q1wTGetvSOE
	 TXkiQ6FhXbwuscTQcCEW+5XjSCO2aAs/zomBPwmt16BsuImcIjCT7/3lXFvk6wGQ6G
	 /WYBtxuqEwYkLeRTHppFk3OCPc4BKdC53YpKBQ1Xk4toliDUSo/+g8KJbalQ5CUcqJ
	 7IYnIl3hblzkg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 27565240041;
	Mon, 30 Mar 2026 12:52:17 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0B7C5240036;
	Mon, 30 Mar 2026 12:52:17 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 5BCFC206DD;
	Mon, 30 Mar 2026 12:52:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 30 Mar 2026 12:52:16 +0200
From: Florian Eckert <fe@dev.tdt.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
Subject: Re: [PATCH v2 6/7] dt-bindings: PCI: intel,lgm-pcie: Make atu
 resource mandatory
In-Reply-To: <b8c60db1-7b72-410e-95a1-f13052af7256@kernel.org>
References: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
 <20260330-pcie-intel-gw-v2-6-8bd07367a298@dev.tdt.de>
 <b8c60db1-7b72-410e-95a1-f13052af7256@kernel.org>
Message-ID: <34a5e88249cf895cfa1132a29343ab90@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1774867939-5CFFFF63-00344717/0/0



On 2026-03-30 11:50, Krzysztof Kozlowski wrote:
> On 30/03/2026 11:07, Florian Eckert wrote:
>> The ATU information is already set in the dwc core if it is specified=20
>> in
>> the DTS. The driver uses its own value here [1]. This information is
>> hardware specific and should therefore be maintained in the DTS rather
>> than in the source.
>>=20
>> Backwards compatibility is not an issue here [5], as the driver is
>> exclusively used by Maxlinear.
>=20
> What does that mean exactly? It is not used outside of Maxlinear
> company, so it is purely internal device and no one outside of=20
> Maxlinear
> has it?

Background information:

The PCIe IP core is only available for Maxlinear=E2=80=99s URX851 and
URX850 SoCs. However, the chip was originally developed by Intel when
they acquired Lantiq=E2=80=99s home networking division in 2015 [1] for t=
his
SoCs. In 2020 the home network division was sold to Maxlinear [2].

Since then, Maxlinear has been responsible for the driver. However,
their SDK is outdated and based on kernel 5.15. Other than that, not
much is happening! Even the developers listed as maintainers can no
longer be reached. When it came to the patch set, the email couldn't
be delivered  to the responsible developer
'Chuanhua Lei <lchuanhua@maxlinear.com>' either. The email bounced
back.

The company I work for is using the chip and is currently in the
process  of extracting the key components from the SDK so that the
SoC URX851/URX850 can work again with a mainline kernel again.

[1]=20
https://www.intc.com/news-events/press-releases/detail/364/intel-to-acqui=
re-lantiq-advancing-the-connected-home
[2]=20
https://investors.maxlinear.com/press-releases/detail/395/maxlinear-to-ac=
quire-intels-home-gateway-platform

> Then we can as well remove it and I don't quite get why you are working
> on this (since no one can use it outside of Maxlinear...).

Maxlinear continues to sell that SoC. They are *not' EOL.
It=E2=80=99s just that their Board Support Package (SDK) is no longer
up to date.

>>=20
>> Old DTS entry for PCIe:
>>=20
>> reg =3D <0xd1000000 0x1000>,
>>       <0xd3000000 0x20000>,
>>       <0xd0c41000.0x1000>;
>> reg-names =3D "dbi", "config", "app";
>>=20
>> New DTS entry for PCIe:
>>=20
>> reg =3D <0xd1000000 0x1000>,
>>       <0xd10c0000 0x1000>,
>>       <0xd3000000 0x20000>,
>>      <0xd0c41000.0x1000>;
>> reg-names =3D "dbi", "atu", "config", "app";
>=20
> Drop, irrelevant. You still break all users of this binding.

As noted in link [3], a Maxlinear developer has stated that
backwards compatibility is not necessary here, as the IP core
is used exclusively by Maxlinear`s URX851 and URX850 SoC`s.

We use these SoCs in our Produkt for internet home gateway
routers.

[3]=20
https://lore.kernel.org/all/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3PR1=
9MB5076.namprd19.prod.outlook.com/

> Best regards,
> Krzysztof
