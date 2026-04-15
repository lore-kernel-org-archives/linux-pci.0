Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6426A0B9;
	Wed, 15 Apr 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776255974; cv=none; b=nYBfiMhhhMLVyXXnt/3Qva7tAY4ea1bQ5dqTgeIWtTs6QVdqMVB0yseiGztMlZ3RGqnljcLtoue4TA1a6CKeKPO5eyX5/NRa5EzaXC27kykKncUTvjoCyofypLmBmKWwUykfC4PvFMxX/bV7RMa1j3RWRuIE7CgSkOxccCYfXYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776255974; c=relaxed/simple;
	bh=Li63j71Mljod26r9+ICoxbjyS0KibXjBkSrFkDDhNmw=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=qy1ZfVbN0EthH6H7YX50bIYN9Mj/qj3utfUOlke9mC2Rh4iFjBVHwwxjxYhMrjbm+Az9R5Xmc48MwBfe9Da9N2eSdZjgxHAJqt2cXGZ59edaN5lUf2JB/I0WFkHFJ8WD/uq0YAsuoejBi6CM0mfjg8IY9L7hmpzDxt0YVZOem8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=aEvjZUmV; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="aEvjZUmV"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=657992536b=fe@dev.tdt.de>)
	id 1wCzJq-003mcy-EM; Wed, 15 Apr 2026 14:26:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wCzJp-001aHb-SV; Wed, 15 Apr 2026 14:26:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776255969;
	bh=P9F+Tlb4TGrVTlb8Ne7lydILYvERL367bJz/FgB5ffQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEvjZUmVevov5inqXPlRwb4l1ReAK8H0uJDyDi1swElMLvCBimpdlAu4MInooGzet
	 V/Hrx1BL+xZQFDEZmW5gmwAkrKNIMdhHcl7AkCmAVU63UCAPKxZxETOMvlVGZUAK7u
	 rIBfpyCo6mmHKWB9p0xpMbMWC9mrCvboTGTxpzIwayEV4TRuCVBbe+TWpJWUQXRZyf
	 MubRhC1ia2gGS06pGCo56DmHmeeoSHKBmBpAERMwyUl0OBNEnCdfGLy9Y/pbQzqLkm
	 Rgr2qq2GQYMLod5q6HoeW/FAozEpBC0TX8xrIG0F+M2v+MCuDgp1/CUatJE+oq4fGu
	 0Zr7s/IHTrzkg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 78F18240042;
	Wed, 15 Apr 2026 14:26:09 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 5B894240040;
	Wed, 15 Apr 2026 14:26:09 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id F003E23F75;
	Wed, 15 Apr 2026 14:26:08 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 15 Apr 2026 14:26:08 +0200 (CEST)
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
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
Subject: Re: [PATCH v4 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu
 resource
In-Reply-To: <CAL_JsqJp_s1gH438sCTdOr_kTA3A9E8ch48ann-w-8D3ZH6MmQ@mail.gmail.com>
References: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
 <20260415-pcie-intel-gw-v4-7-ad45d2418c8e@dev.tdt.de>
 <CAL_JsqJp_s1gH438sCTdOr_kTA3A9E8ch48ann-w-8D3ZH6MmQ@mail.gmail.com>
Message-ID: <a7f3fb115256a180741aa817b14fee35@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1776255970-6EEFEC78-9BEA26FC/0/0
X-purgate-type: clean



On 2026-04-15 14:09, Rob Herring wrote:
> On Wed, Apr 15, 2026 at 3:02=E2=80=AFAM Florian Eckert <fe@dev.tdt.de> =
wrote:
>>=20
>> The 'atu' information is already set in the dwc core, if it is=20
>> specified
>> in the devicetree. The driver uses its own default, if not set in the
>> devicetree. This information is hardware specific and should therefore=
=20
>> be
>> maintained in the devicetree rather than in the source.
>>=20
>> To be backward compatible, this field is not mandatory. If 'atu'
>> resource is not specified in the devicetree, the driver=E2=80=99s defa=
ult=20
>> value
>> is used.
>>=20
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml=20
>> b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> index=20
>> 54e2890ae6314ac6847fc23f49440d05d66d87d4..9b7a8ef77585677841c7064c5001=
110bc2b65db1=20
>> 100644
>> --- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>> @@ -27,16 +27,19 @@ properties:
>>        - const: snps,dw-pcie
>>=20
>>    reg:
>> +    minItems: 3
>>      items:
>>        - description: Controller control and status registers.
>>        - description: PCIe configuration registers.
>>        - description: Controller application registers.
>> +      - description: Internal Address Translation Unit (iATU)=20
>> registers.
>>=20
>>    reg-names:
>=20
> Don't you need minItems here?

You're absolutely right, of course!
My fault. Thanks for pointing that out.
I will wait 24 hours to send a v5 with this change.

Just to clarify. How does the creator of DTS know which items are=20
required.
Does that mean, in this case, that the last item is always optional and=20
the
others are absolutely essential?

>=20
>>      items:
>>        - const: dbi
>>        - const: config
>>        - const: app
>> +      - const: atu
>>=20
>>    ranges:
>>      maxItems: 1
>> @@ -95,8 +98,9 @@ examples:
>>        #size-cells =3D <2>;
>>        reg =3D <0xd0e00000 0x1000>,
>>              <0xd2000000 0x800000>,
>> -            <0xd0a41000 0x1000>;
>> -      reg-names =3D "dbi", "config", "app";
>> +            <0xd0a41000 0x1000>,
>> +            <0xd0ec0000 0x1000>;
>> +      reg-names =3D "dbi", config", "app", "atu";
>>        linux,pci-domain =3D <0>;
>>        max-link-speed =3D <4>;
>>        bus-range =3D <0x00 0x08>;
>>=20
>> --
>> 2.47.3
>>=20
