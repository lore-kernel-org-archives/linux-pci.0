Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27093CFF7D;
	Wed,  1 Apr 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042438; cv=none; b=GTSaEtX7uJndEnNrNIHhKxb3uzKZS2fiMh3BP/OeHbqfChLKxhBgj8wnF/Nkfee4MtpWK6cLxekQQpnMuW+m6gG8SMCffgn1N0bU42RQ5iFMCz/L0+wICR67ADMmvPBol1UHXnsTFKgfa5dBu9GtXb89e5ceZxaT4UBmrJZQ9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042438; c=relaxed/simple;
	bh=GWtFWKdF+YszG7aC8RKUvSNFBjj0WT658bI2dthyM5g=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=KZPu3V5dQtl7KIOqLFIpA07NX7MRjerAfsQkJBCCB7dXTgLvnNtZo95lFtP+VYmuS1c2VFqMvQ7CLHTvtPdMe4dtOTG69gYgHb7Ne6uc08SLof73Qm0dl6vy4PBWDJ/Fgr2cXDLpZdyCmOOklAKbpnhc9bUcowl70xUYKnAnH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=XVw6zmtL; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="XVw6zmtL"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7tce-003IKr-8Q; Wed, 01 Apr 2026 13:20:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7tcd-005ZHF-Kd; Wed, 01 Apr 2026 13:20:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775042431;
	bh=bU4u4xZq/1fIavHC9cY1ibRZmoOu/6c2ktOUp5DQouA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XVw6zmtL08IZf0EfwqPy7b6QY646o4vXl3U2b1nKPJHeGLTIzZdYCWzyhaMGgTwNX
	 LDAu1z8fJ859nPvPVaaz8rEOqXhMUg5ZlSs6Y1OaE8VceJxJc1eJdhrC5UtRS4/pI2
	 r/WgeQdHgmvAd5yxZGQW0zdrtCWU/LdxAxGEt9AajIUMr+TYhQPcqXNkAdCYtRgiQd
	 47ifvyXn2SXrBF/QkkL2ZmfxiVVotN2Nai9yjJ/E1Y3nSOn9ey2GZfL260FBiUXD+u
	 Bx7RmUmvXnl1lgCGGVi3KRwvKcKBtL2gKWtah8aGGnXo5a66IbyGZW7QqPIKNmtRVu
	 WGyBnbtH3zM7Q==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 32647240041;
	Wed,  1 Apr 2026 13:20:31 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 04BE1240036;
	Wed,  1 Apr 2026 13:20:31 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 9AEAB2331F;
	Wed,  1 Apr 2026 13:20:30 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 1 Apr 2026 13:20:30 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
In-Reply-To: <20260331152150.GA1255126-robh@kernel.org>
References: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
 <20260330-pcie-intel-gw-v2-6-8bd07367a298@dev.tdt.de>
 <20260331152150.GA1255126-robh@kernel.org>
Message-ID: <a729a0bf82f38a65a6df4e000a3ad90a@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1775042432-C2F7E7AC-FDDF49AC/0/0
X-purgate-type: clean



On 2026-03-31 17:21, Rob Herring wrote:
> On Mon, Mar 30, 2026 at 11:07:16AM +0200, Florian Eckert wrote:
>> The ATU information is already set in the dwc core if it is specified=20
>> in
>> the DTS. The driver uses its own value here [1]. This information is
>> hardware specific and should therefore be maintained in the DTS rather
>> than in the source.
>>=20
>> Backwards compatibility is not an issue here [5], as the driver is
>> exclusively used by Maxlinear.
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
>>=20
>> [1]=20
>> https://elixir.bootlin.com/linux/v6.19.10/source/drivers/pci/controlle=
r/dwc/pcie-intel-gw.c#L301
>> [2]=20
>> https://lore.kernel.org/all/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3=
PR19MB5076.namprd19.prod.outlook.com/
>>=20
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml=20
>> b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> index=20
>> 54e2890ae6314ac6847fc23f49440d05d66d87d4..e4b781f57e8ae84a3ffc33635a42=
1e1a5761587e=20
>> 100644
>> --- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> @@ -29,12 +29,14 @@ properties:
>>    reg:
>>      items:
>>        - description: Controller control and status registers.
>> +      - description: Internal Address Translation Unit (iATU)=20
>> registers.
>>        - description: PCIe configuration registers.
>>        - description: Controller application registers.
>>=20
>>    reg-names:
>>      items:
>>        - const: dbi
>> +      - const: atu
>=20
> Put this at the end and add 'minItems: 3' and you avoid any ABI issues.

Unfortunately, I misunderstood what you meant. This is still wrong in v3=20
[1]
I send to day. I=E2=80=99ve only changed it in the documentation. I forgo=
t to do
that in the example, as I didn=E2=80=99t realize that we can not always a=
ccess
resources by name, but also by index. That=E2=80=99s why the order matter=
s. I=E2=80=99ve=20
got
it now.

Thanks!

My mistake =E2=80=93 I=E2=80=99ll change that in v4 tomorrow so that your=
 bot is happy=20
too.

--
Florian

[1]=20
https://lore.kernel.org/all/20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.=
tdt.de/T/#t

>=20
>>        - const: config
>>        - const: app
>>=20
