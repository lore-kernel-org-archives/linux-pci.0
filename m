Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AD3314D2
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611882; cv=none; b=FqLHiE/DYJs7a7Q5gJ0AsEDytBDOmM7fQSWL/MEG4mnbLdVOMWWsQMIljgjrGSWxnzENEyMwlFORwAgAW1tBAHAKDUbuOfT/haZRssF2EaOyZ+rQeH30aHejn/ReV9SAu+7pqst8U6YOvz3cbYAcSiYyE0HlxUegeC50plIpV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611882; c=relaxed/simple;
	bh=4D/kZeewpzn4zOovfW8JUpPIYDYTqAEPpCC85jXHm/Y=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=hnHemfGlMY4sc83+88oiQRUvxnGuqrDa9oHnHcdgI0mKH7Yb7tgto34SW2C2Fq6Vgt6c44s70dHWjkLhbr50RyKnazH2krufxX3h+RIGEOERykFbJvvbugthm/LToS9hAOsDw/1SbhhXRjKZwU5tTHC/RlrXvNEqCOflNadA93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=wLEIbWdF; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="wLEIbWdF"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6560217375=fe@dev.tdt.de>)
	id 1w65cE-00Dyi1-Cx
	for linux-pci@vger.kernel.org; Fri, 27 Mar 2026 12:44:38 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w65cD-003nVS-VZ
	for linux-pci@vger.kernel.org; Fri, 27 Mar 2026 12:44:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774611875;
	bh=zeLPVeK1p8gUPFy9rd03JeCEtujAj1OdYPOzqrPErkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wLEIbWdFmU6kElgt39umvFIMF+CTfEFrMhYi/NzP/FZegvnODa4JwUYip30AZEmS9
	 Bu3rMVnYYkUYNAcklaTBt8R/Tr7Q4ov02LgXQH19bDUBGSU7cLynQGYH1mzDcgNJBI
	 LOF9vMJkj6uX3mEdA7ktBWbONIsnJ+BQ2lPwzw7/qquBvZk2Zf2dF9Qu+Glb8xR9/k
	 vuh2PSEEUiCm6NnPuFW1dDVqr9pTO6Qz0Gc46MQtyMCX45Khzcf7RjshCtAxH6V8rW
	 rXoaKYG0pJu2hZlj8GdSe3yemUBpP316Q4xfv/r1h7rJkkSdvyc+6B5euBqiTredz3
	 cueIGnE+GEunQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2B42B240041
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 12:44:35 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 19A12240036;
	Fri, 27 Mar 2026 12:44:35 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 7184D23B12;
	Fri, 27 Mar 2026 12:44:34 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 27 Mar 2026 12:44:34 +0100
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
Subject: Re: [PATCH 4/5] PCI: intel-gw: Remove atu base assignment
In-Reply-To: <eu7z775hpux7vo4p2nzzmyqw6fpvehpuabxs7zfjqhhv4hcsnu@d4dns7uuwu2d>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-4-7fe13726ad4f@dev.tdt.de>
 <eu7z775hpux7vo4p2nzzmyqw6fpvehpuabxs7zfjqhhv4hcsnu@d4dns7uuwu2d>
Message-ID: <55d7a2bee58cc44ca162072b0762b3ac@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1774611878-05AC9842-AF735EA4/0/0
X-purgate: clean
X-purgate-type: clean

On 2026-03-26 17:15, Manivannan Sadhasivam wrote:
> On Tue, Mar 17, 2026 at 11:12:52AM +0100, Florian Eckert wrote:
>> In the current implementation, only one PCIe bridge is recognised.=20
>> This
>> change removes the assignment of the ATU base address during host=20
>> setup.
>> Instead, the ATU base address is read from the device tree. To do=20
>> this,
>> the 'atu' range of the DTS entry must be changed for PCIe.
>>=20
>> Old DTS entry for PCIe:
>> reg =3D <0xd1000000 0x1000>,
>> 	<0xd3000000 0x20000>,
>> 	<0xd0c41000.0x1000>;
>> reg-names =3D "dbi", "config", "app";
>>=20
>> New DTS entry for PCIe
>> reg =3D <0xd1000000 0x1000>,
>> 	<0xd10c0000 0x1000>,
>> 	<0xd3000000 0x20000>,
>> 	<0xd0c41000.0x1000>;
>> reg-names =3D "dbi", "atu", "config", "app";
>>=20
>=20
> You just broke the DT backwards compatibility here. What if the driver=20
> is used
> with an old DT that doesn't provide this 'atu' entry? The driver will=20
> break.
> Moreover, this entry should be added to the DT binding first before any=
=20
> driver
> change.

When I looked at the driver=E2=80=99s history, I found a note in a commit=
 that=20
the driver
is only used internally by Maxlinear [1]. The maintainer
'Lei Chuan Hua <lchuanhua@maxlinear.com>' from Maxlinear was still=20
active at
that time. He mentioned this on the LKML [2].

Therefore, backward compatibility shouldn=E2=80=99t be necessary.

Unfortunately, it=E2=80=99s already been three months since I last looked=
 into=20
this issue.
But as far as I can remember I have to read the 'atu' resource from DTS=20
and so have
to remove this line so the driver does work again.

Because the resource is already initialized by the dwc core during the=20
function
call 'dw_pcie_get_resources()'on line 141 [3]. This function is called=20
in the DWC
host core [4]. This raises the question of why the driver is doing this=20
itself at
all, when the core already handles it for us.

Additional, I have noticed that it seems to be bad practice to include=20
this
resource information in the source code. This information should instead=20
be
loaded via the DTS see commit [5].

If backwards compatibility isn't an issue, then the DWC core should=20
handle
loading the 'atu' resource from the DTS.

Is that how you see it too?


Thanks for your time and review

- Florian

[1]=20
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/d=
rivers/pci/controller/dwc?h=3Dmaster&id=3D07ae413e169da3697e633dd4489db0d=
681a04460
[2]=20
https://lore.kernel.org/all/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY3PR1=
9MB5076.namprd19.prod.outlook.com/
[3]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/dwc/pcie-designware.c#n141
[4]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/pci/controller/dwc/pcie-designware-host.c#n544
[5]=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/Documentation/devicetree/bindings/pci?id=3Df500a2f1282750fb344ce535d7807=
1cf1493efd1

>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>>  drivers/pci/controller/dwc/pcie-intel-gw.c | 2 --
>>  1 file changed, 2 deletions(-)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c=20
>> b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> index=20
>> 6bd25f8da605032bfdb97596fb3a1f6a03e88bfc..cec972d5aa9107d4708338bd7349=
415a31f0e688=20
>> 100644
>> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
>> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> @@ -311,8 +311,6 @@ static int intel_pcie_host_setup(struct intel_pcie=
=20
>> *pcie)
>>  		goto clk_err;
>>  	}
>>=20
>> -	pci->atu_base =3D pci->dbi_base + 0xC0000;
>> -
>>  	ret =3D phy_init(pcie->phy);
>>  	if (ret)
>>  		goto phy_err;
>>=20
>> --
>> 2.47.3
>>=20
