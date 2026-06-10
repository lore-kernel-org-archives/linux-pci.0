Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72929C328;
	Wed, 10 Jun 2026 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134857; cv=none; b=QC4DLREYjRI9kdcKoimftelSY9VDPszBXDxHZ1IhnA6oFeMPW/NXmTtvEVwxU04uWHlDX9Uqzv2a20G84vYwVp4s7LUGYxuNgfUH9t5fBb3nRXmQA7rEFxB8s4fNYMoLb0qaCk0m7jFpEBa9XcqKpO2uzDW+WOcwj4+QoLJ+vhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134857; c=relaxed/simple;
	bh=sVPLZELC1PoBEGXx46p9LvteI62tJ3s8nH3QK5JfNnE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9/txqPOY0a60o9kbyZFoxglLRUbxyPmhM3ewRYwbWVWN7CHMUNzX7E1cw44RIZDj3hzXYDzB2Lr3q9D3g87iu92gxr3Oyw0RnZG+Z1YqDCpoA1oNRmXmeTqwL9JQp2/wCoSFwbhPwIzCIv5Qf2QX74g3Py+mMPtydZYimZ/8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Ffx6YIf7; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Ffx6YIf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1781134848;
	bh=U1isU/Mjec0vZk6UMMGTWf7R7yQl0VtWPS2hoMTvoxE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Ffx6YIf7yj2YQcesRHQUAPsALp2RjktNgatHUFsD/imGLEu+SycLZfoQnY8lyJGHJ
	 AjUD/AV1oVH4ret1ZYWSUptWuCIZRcQCSTFJmbVWOpAhNljqTZB9vdVm4oXaYAjsHb
	 MVsjW/q8vbCw3i6LcVVjdQAUudnje0j8RSkDP/GQ=
Received: from [IPv6:2409:8a4c:e12:98c1::376] (unknown [IPv6:2409:8a4c:e12:98c1::376])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id E1A2565982;
	Wed, 10 Jun 2026 19:40:44 -0400 (EDT)
Message-ID: <2dbb12fcdebf6c7f375cce56cceb113746a92c4b.camel@xry111.site>
Subject: Re: [PATCH] pci: loongson: Avoid L0s on LS7A1000 PCIe x8
 [0014:7a29] Root Ports rev2
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
 <mani@kernel.org>,  Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?gb2312?Q?Wilczy=A8=BDski?= <kwilczynski@kernel.org>, Rob Herring
 <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingcong Bai	 <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>, Han Gao
 <gaohan@iscas.ac.cn>,  Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 11 Jun 2026 07:40:39 +0800
In-Reply-To: <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>
References: <20260609152511.753760-1-xry111@xry111.site>
	 <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 16:21 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Tue, Jun 9, 2026 at 11:26=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wr=
ote:
> >=20
> > Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
> > server with an Intel 750 Series SSD.=C2=A0 We also found a Loongson 3A5=
000
> > board using the same 7A1000 bridge chip exhibiting the same issue with
> > pcie_aspm=3Dforce and pcie_aspm.policy=3Dpowersave (ASPM is not enabled=
 by
> > default on the 3A5000 board because it's based on ACPI and the _OSC
> > method has not been implemented in its DSDT/SSDT yet).
> >=20
> > This seems only affecting the 7A1000 chips shipping the revision 2 of
> > the PCIe x8 Root Port: on other two boards with a (persumably older)
> > LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> > issue does not reproduce.
> Is that confirmed by chip designers?

I don't have their contact.  This is based on our experiments on 5
boards (two 3B4000 x 2 with rev2, one with rev1, one 3A4000 with rev1,
one 3A5000 with rev2).

> > Cc: Mingcong Bai <jeffbai@aosc.io>
> > Cc: Henry Chen <chenx97@aosc.io>
> > Cc: Han Gao <gaohan@iscas.ac.cn>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for =
devicetree platforms")
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
> > =C2=A01 file changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/contro=
ller/pci-loongson.c
> > index a4250d7af1bf..dc7cee10643e 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -212,6 +212,19 @@ static void loongson_pci_bridge_speed_quirk(struct=
 pci_dev *pdev)
> > =C2=A0DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson=
_pci_bridge_speed_quirk);
> > =C2=A0DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson=
_pci_bridge_speed_quirk);
> >=20
> > +/*
> > + * Some devices, for example Intel 750 Series SSD, experiences data lo=
ss
> > + * (read timeout) on LS7A1000 PCIe x8 Root Port when ASPM L0s is enabl=
ed.
> > + * This seems only affecting the revision 2.
> > + */
> > +static void ls7a_pcie_port2_aspm_quirk(struct pci_dev *pdev)
> It is better to follow the namings in this file, i.e.
> loongson_pcie_port2_aspm_quirk, or loongson_pcie_aspm_quirk for short.

I'd keep "7a" in the name so in case another ASPM quirk is needed for
future products we'll not get a name clash.  Maybe
loongson_7a_port2_aspm_quirk (I don't think _pcie_ is so useful here as
the entire source file is for PCIe anyway).


--=20
Xi Ruoyao <xry111@xry111.site>
