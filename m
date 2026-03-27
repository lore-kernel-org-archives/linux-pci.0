Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462C1CAB3
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597359; cv=none; b=XVNr6CnYd+eefIjFM1dhhlUsh4WHvJVlkzHzSdu+eGdlpst7k/9E8NPTbc+xju4vsWu//76Ou4H0e56ITS0JCbLIWFY73AO2f9WHkasUriVQrY10ruT9IcFw0S0Vjsb3K5npk8cibHz/5YjPl1rYChOxb9+EAFI4f6P1uGzXFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597359; c=relaxed/simple;
	bh=XJlK+D21/7efIS07ERGMElEao6HZF1RtPKAC41sHEDY=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=b4RFYY701BNaZPldQV4beS16ZkgiWdf5SR6YQilpj+3BxHieyZnks5afCnVIW42ZuXVwQwcttxD8kBDUOObWZtXfZplJba10YkHI9TZepzxUcA4kpC1+Rw2U7s0qCqKrcZp9g6AvvXlqFgZJKXoUbUfvii1h7dPrH+E8I3ml5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=dnXshSLV; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="dnXshSLV"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6560217375=fe@dev.tdt.de>)
	id 1w61pp-00Crgd-Nn
	for linux-pci@vger.kernel.org; Fri, 27 Mar 2026 08:42:25 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w61pp-00ESAY-9m
	for linux-pci@vger.kernel.org; Fri, 27 Mar 2026 08:42:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774597343;
	bh=7RaolsCunBVTFhZ3LbX7+wICpbiFEhlTeVpC6rsJlR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dnXshSLVa4J1rW9ysfw7KThIBOPGRiXcy2lfthvaTJR8zRlIMI34cu1sATTNDv/iI
	 JwYhuCGNUcdxsnxvaakf4l44C1MRgOZM/bxJPOEfz+vXvX50sXcYo2qfzkIt15P+QO
	 JrQrhdQASk1Bj2tWHHDYAsP09g8CBGNud9XfB49YX6BDvTNQ+Llcerft2EQfOavHu3
	 EHy7rg/bFRJJDKdqv5V5VmD6yzIa38sPJhg9NPyA8whODrqjL0dX+IWfqWL9RX0i1Y
	 lm5FDAnNW6r0bMcWHP/WtUvlOi8QS2eF8DkkGkTtjNARSAkLJ/ngDRueI+9W/A2qeW
	 H6RptgjyWEADQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id AA039240040
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 08:42:23 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 9684D240036;
	Fri, 27 Mar 2026 08:42:23 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id B1A812072D;
	Fri, 27 Mar 2026 08:42:21 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 27 Mar 2026 08:42:21 +0100
From: Florian Eckert <fe@dev.tdt.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: intel-gw: Enable clock before phy init
In-Reply-To: <acem5jvxct2izfwgqdtf52tijntkh6lz2eyeydsmfxzpue744i@nbzoe3ysilo6>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-2-7fe13726ad4f@dev.tdt.de>
 <acem5jvxct2izfwgqdtf52tijntkh6lz2eyeydsmfxzpue744i@nbzoe3ysilo6>
Message-ID: <f8a998cfb826d7b6d4b7a057f9ac6747@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1774597345-072C4842-D7F5E124/0/0
X-purgate-type: clean

Hello Mani,

Thanks for your review.

On 2026-03-26 17:08, Manivannan Sadhasivam wrote:
> On Tue, Mar 17, 2026 at 11:12:50AM +0100, Florian Eckert wrote:
>> To ensure that the boot sequence is correct, the dwc pcie core clock=20
>> must
>> be switched on before phy init call.
>>=20
>> This changes are based on patched kernel sources of the MaxLinear SDK,
>> which can be found at https://github.com/maxlinear/linux
>>=20
>=20
> How can we treat Maxlinear kernel source as a reference for Intel=20
> driver?
> Atleast, you need to provide some info onto why this should be trusted=20
> as a
> reference like used a product etc...

As far as I know, this driver is only used by Maxlinear=E2=80=99s URX851 =
and=20
URX850
SoCs. However, the chip was originally developed by Intel when they
acquired Lantiq=E2=80=99s home networking division in 2015 [1] for this S=
oCs.
In 2020 the home network division was sold to Maxlinear [2].

Since then, Maxlinear has been responsible for the driver. However,=20
their
SDK is outdated and based on kernel 5.15. Other than that, not much is
happening! Even the developers listed as maintainers can no longer be
reached. When it came to the patch set, the email couldn't be delivered=20
to
the responsible developer 'Chuanhua Lei <lchuanhua@maxlinear.com>'=20
either.
The email bounced back.

The company I work for is using the chip and is currently in the process=20
of
extracting the key components from the SDK so that the SoC can work=20
again with
a mainline kernel again.

[1]=20
https://www.intc.com/news-events/press-releases/detail/364/intel-to-acqui=
re-lantiq-advancing-the-connected-home
[2]=20
https://investors.maxlinear.com/press-releases/detail/395/maxlinear-to-ac=
quire-intels-home-gateway-platform

>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  drivers/pci/controller/dwc/pcie-intel-gw.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c=20
>> b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> index=20
>> 3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648..6110a8adb8732dbbd5e9e2db68a0=
606ccf032ae1=20
>> 100644
>> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
>> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> @@ -292,13 +292,9 @@ static int intel_pcie_host_setup(struct=20
>> intel_pcie *pcie)
>>=20
>>  	intel_pcie_core_rst_assert(pcie);
>>  	intel_pcie_device_rst_assert(pcie);
>> -
>> -	ret =3D phy_init(pcie->phy);
>> -	if (ret)
>> -		return ret;
>> -
>>  	intel_pcie_core_rst_deassert(pcie);
>>=20
>> +	/* Controller clock must be provided earlier than PHY */
>>  	ret =3D clk_prepare_enable(pcie->core_clk);
>>  	if (ret) {
>>  		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
>> @@ -307,13 +303,17 @@ static int intel_pcie_host_setup(struct=20
>> intel_pcie *pcie)
>>=20
>>  	pci->atu_base =3D pci->dbi_base + 0xC0000;
>>=20
>> +	ret =3D phy_init(pcie->phy);
>> +	if (ret)
>> +		goto phy_err;
>=20
> You just messed up the whole error path. This one should branch to
> err_disable_core_clk that disables core_clk and deasserts reset.
>=20
>> +
>>  	intel_pcie_ltssm_disable(pcie);
>>  	intel_pcie_link_setup(pcie);
>>  	intel_pcie_init_n_fts(pci);
>>=20
>>  	ret =3D dw_pcie_setup_rc(&pci->pp);
>>  	if (ret)
>> -		goto app_init_err;
>> +		goto phy_err;
>=20
> And this to err_phy_exit that does phy_exit().
>=20
>>=20
>>  	dw_pcie_upconfig_setup(pci);
>>=20
>> @@ -322,13 +322,13 @@ static int intel_pcie_host_setup(struct=20
>> intel_pcie *pcie)
>>=20
>>  	ret =3D dw_pcie_wait_for_link(pci);
>>  	if (ret)
>> -		goto app_init_err;
>> +		goto phy_err;
>>=20
>>  	intel_pcie_core_irq_enable(pcie);
>>=20
>>  	return 0;
>>=20
>=20
> Here, you should add shuffle phy_exit() accordingly.

I'll take another look at that.

Thanks

- Florian
