Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E733B970
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835705; cv=none; b=evOTy0cdpwcRMhR6/MlYjzSvgNwcxu/qQGVb4SUqjgL/sNPFrKqGI44eiMIabtFqGfqGUJWPDdQZKrYQa7DwEn4CSdueLMf0YNfHayh48BySl10QhdmHhEN+m1XRILa/Ga2vDem13Aewl+imF55eps0bf5sGYnDOrqObfFvwQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835705; c=relaxed/simple;
	bh=v+MzpgHHML0aV//Q1LySHYVAAgx+ezzK7gyJDza2jRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vipvuot0rz01lHbb0Lxdic9BIBqgW0BNRHVywMPCQZHyPZrrMufymZD2dIE0UxF5rw3OLQH/Ov85VWrYuqS5PBLDA8pDi+SFaTPBkAe9LhmU6FMjYOucg4ajRcb1VBvvpCHtcrUf8WfIj1i/MtUviZlkuxQ9V79tOalKtnPpMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmWbh6rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmWbh6rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6D01F000FF;
	Sat, 19 Sep 2026 16:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789835704;
	bh=CnEK4L6zrNNDKCmrq3QJJtl5DQsBF4aFRbwilWJAcMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmWbh6rnH6nTFqxp2WUo/46giSY725GsorMtOHKiEIihpJoUh7XxC21Jc0o0WVdJo
	 SYEtTJEp/R373u3w/Ajj7KCBunWj50jg+SPAY+Qi81DzjRanqdDQTcbfpYK05QWqnb
	 g67DCimDbEoUYrXy4OrcW6Sj4yA324H35iiAPR0BOt30Hor1WkVYxiBhWt/pipArcr
	 SjZmpRWhR4oiQnvWnmHawnrpXxImbm/hYtLfKuSPiYXGnKOhlsGgq2yqKdGAC5sgPv
	 +jZ/T6cY9nNU5C7YL+igPdFfLyzgIYa1VTe6lrMD7YKgjOCerEvJg23j53Egd5pddc
	 J339fSgvWRq3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/5] PCI/DPC: Ignore devices with no AER Capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260919162655.3499010-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 16:35:04 +0000
Message-Id: <20260919163504.9C6D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Downstream Ports may support DPC regardless of whether they support AER
> (see PCIe r7.0, sec 6.2.11.2).  Previously, if the user booted with
> "pcie_ports=3Ddpc-native", it was possible for dpc_probe() to succeed eve=
n if
> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
> depends on the AER Capability.
>=20
> dpc_probe() previously failed if:
>=20
>   !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
>   !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law
>=20
> so it succeeded if:
>=20
>   pcie_aer_is_native() || pcie_ports_dpc_native
>=20
> Fail dpc_probe() if the device has no AER Capability.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919162655.3499=
010-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D1

