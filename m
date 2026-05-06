Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A0369972;
	Wed,  6 May 2026 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051020; cv=none; b=sInlQitY+2t5cveA+caI9LVWYGt6wD1lh+o1NKiSh1OteM5CGQKaeU7CsuQcjS4M3nr4K7CrNQeuxubK09e2JX3bhdCyAmWOWC85jVbIc6xWsU6OUxwcKvjepqPs6eE6chGDAJRewn+jmcDvWPmup3xIEZsCSO/IVpwymkHvz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051020; c=relaxed/simple;
	bh=GQQ4tLKaodjP8OXQAc//QWaL9kDZOgafjgUyva4+Mys=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=BY+gc/dg/fQPOlr/cNREGJEg7x5FjjPUVUH/Dk5QpVTMZ9m1je+MoeqXbQp5M+xY+x9hn0AVaQwwlWX2ElJYo60H8NaDonJ8EUvJjrdGmH2mKCw/zVQY2aRcbDEezpYxTAPFTFFVFRaEjwr0otmtGcj/630G+imP5pnWzs9Vfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=JeRvSI3C; arc=none smtp.client-ip=91.198.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="JeRvSI3C"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=76004fd39a=fe@dev.tdt.de>)
	id 1wKW0g-006cbg-9V; Wed, 06 May 2026 08:45:30 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wKW0f-000f1P-Ka; Wed, 06 May 2026 08:45:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1778049926;
	bh=q8jnMdC7S4lRdaod9kLw6q0kgekMN7xuH/EWnvr0Mfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JeRvSI3C6m2dSQlia4vsFf2YGeKlxn0JmFInBJXbwS/+aZjrNsotc0Otg02T+kVCO
	 pVaATOzb+n0UV8dcaTXWSLb/ZPKIVns72GeXgSy5qEYXn7w2dgmuMSW01Lx1wQ5Zuf
	 yKoJIuGC5I2pEzKJFI7dnLyg7+aGk2c6CBiqjT+m5ZP+G5xENji6uK8xTTUrjeBMDf
	 BCguBtu/4RZ2LBCxJlGZxEXRN37jr/f6X2kDrGk5kNTs5jCgEzaiC4LjcLCt4qcYPx
	 AeB8kXWbKVBlOYTNQYrowOZWmQ95UlrJlrB8c8moUecivwSJ9M4NSk5j9/con58win
	 OTjSjApJyIUtw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id CAB80240042;
	Wed,  6 May 2026 08:45:26 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id AD89C240040;
	Wed,  6 May 2026 08:45:26 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 2ECC8248D2;
	Wed,  6 May 2026 08:45:26 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 6 May 2026 08:45:26 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Eckert.Florian@googlemail.com,
	ms@dev.tdt.de
Subject: Re: [PATCH v5 0/7] PCI: intel-gw: Fixes to make the driver working
 again
In-Reply-To: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
References: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
Message-ID: <6f483189ec993e3e5f89bccec11cc02a@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1778049930-A141CF85-AE22F8A8/0/0
X-purgate-type: clean
X-purgate: clean

Just a friendly reminder. I hope I=E2=80=99ve incorporated all your comme=
nts.
If there=E2=80=99s anything else you=E2=80=99d like me to do, please let =
me know.

On 2026-04-17 10:35, Florian Eckert wrote:
> This series fixes and improve the 'intel-gw' driver to work again with
> the current dwc pcie framework. The following changes are:
>=20
> * Move interrupt 'enable' to its own function to improve readability,
>   and add additional register writes just as the Maxlinear kernel does=20
> in
>   their SDK.
> * Enable clock for the PHY before PHY init call.
> * Add missing 'start_link' callback. That was added to the PCIe dwc
>   framework.
> * Move ATU base address assignment to the probe function and also add=20
> the
>   the possibility to read it from the devicetree by dwc core.
> * Update devicetree documentation for intel-gw-pcie.yaml
> * Remove unused preprocessor define.
> * Mark driver as orphaned as the maitainer's email no longer works
>=20
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> Changes in v5:
> - Also add the DTS 'minItems' option for 'reg-names'.
> - Add missing quotation marks to the DTS example change to make the DTS
>   bot hopefully happy.
> - Link to v4:
> https://lore.kernel.org/r/20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.=
tdt.de
>=20
> Changes in v4:
> - Add 'atu' to the end of the resource definition to ensure backwords
>   compatibility.
> - Updated the commit description to explain why the MaxLinear SDK is=20
> used
>   as a reference.
> - Remove 'Rahul Tanwar <rtanwar@maxlinear.com>' out of the loop, as the=
=20
> email
>   address is no longer valid and is being rejected.
> - Link to v3:
> https://lore.kernel.org/r/20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.=
tdt.de
>=20
> Changes in v3:
> - Update commit messages.
> - Correct the sample code for dt bindings by adding the missing=20
> quotation
>   marks. Add 'minItems: 3' to avoid ABI issues.
> - Move driver atu base assignment to probe function and keep backward
>   compatibility.
> - Link to v2:
> https://lore.kernel.org/r/20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.=
tdt.de
>=20
> Changes in v2:
> - Added additional information to the commit descriptions
> - Add additional patch to mark driver as orphaned as the maintainer's
>   email no longer works.
> - Fix wrong error path for enable clock before phy init.
> - Add new patch to update the devicetree documentation for the 'atu'
>   resource
> - Add additional recipients responsible for documenting the dervicetree
>   bindings.
> - Link to v1:
> https://lore.kernel.org/r/20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.=
tdt.de
>=20
> ---
> Florian Eckert (7):
>       MAINTAINERS: Remove bouncing intel-gw maintainer
>       PCI: intel-gw: Remove unused define
>       PCI: intel-gw: Move interrupt enable to own function
>       PCI: intel-gw: Enable clock before phy init
>       PCI: intel-gw: Add start_link callback function
>       PCI: intel-gw: Move driver atu base assignment to probe function
>       dt-bindings: PCI: intel,lgm-pcie: Add atu resource
>=20
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     |  9 ++-
>  MAINTAINERS                                        |  3 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c         | 73=20
> +++++++++++++++-------
>  3 files changed, 58 insertions(+), 27 deletions(-)
> ---
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> change-id: 20260317-pcie-intel-gw-50902113f9e1
>=20
> Best regards,
