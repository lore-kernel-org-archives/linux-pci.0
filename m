Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5E2C21FF
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236659; cv=none; b=RfWUgswVBrj2V1GwdoTSyHmxih/Y3zfXPIzanLL0x1bbt6baCC5kKFiUe6t0ChoV09qzTM8sNnwg9dUBnqbz1J8EGr6KaEBeOEExl/FlUEtXrkN1jdr6A9krucJzGeVL3FhRRBvrIvfgKt6tzyxnTlSmMQvXndk69u/YtTr+mno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236659; c=relaxed/simple;
	bh=loBIbwnin6vq3iOuUyAukP+btAA3e5iBNetl2E7Svio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NGfqvIs3lr/THBVs4gM+AczYyWkV0DPc9WJF9jLb/qnj0XBz03sHQOnXBqv1OcbpBVn5GMQtZgS2HWyIhKA6N5nxiWW1GJRWnucKxwfycYZ+3MO1SJ+gppPUoU8gNyDX+SQy6hB5Y/PyuoXNEZ/EEKOZCObxssozwqr4JPYY3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8F9s3jG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8F9s3jG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D431F000E9;
	Tue, 23 Jun 2026 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236658;
	bh=ONxEeX/LCzLH0CBHs5FsT+4aYc2qbE4Il+x8GNR07lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8F9s3jG5ZBjUuIH36jJCIe3qi72Dq83gn/XbTFA5z5Um/APJIUI/45qGXmOAcKBe
	 R+NhSbtBagZR/A5Rzi/+YRRYleDT/Riwov9WjscSoKo7f2oyY5UFXBt3OWOYmepZlL
	 1xbrKMAgVwKIME/WwOagEmaHd/mcY4FNxCOVhddQ0x9h5H6rLnz2yiEeGpYWwLKdMr
	 QUfWi7lFWTiAq09I98dcLST1choraDzAIKDoOFpkOrOlogMfCwtlRpqabrU8Z5A78X
	 zDxd8tSACK0P9uScmfqO6eY9/QVMXfEb6Ehwi16v+Eb5qqRrYTQtycx3VyQzMsrAxU
	 +jTOwn/KpY8lA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pci: loongson: Avoid L0s on LS7A1000 PCIe x8
 [0014:7a29] Root Ports rev2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xi Ruoyao" <xry111@xry111.site>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623173648.222922-1-xry111@xry111.site>
References: <20260623173648.222922-1-xry111@xry111.site>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:44:17 +0000
Message-Id: <20260623174417.F0D431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms") has broke booting of a Loongson 3B4000 + 7A1000
> server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
> board using the same 7A1000 bridge chip exhibiting the same issue with
> pcie_aspm=3Dforce and pcie_aspm.policy=3Dpowersave (ASPM is not enabled by
> default on the 3A5000 board because it's based on ACPI and the _OSC
> method has not been implemented in its DSDT/SSDT yet).
>=20
> This seems only affecting the 7A1000 chips shipping the revision 2 of
> the PCIe x8 Root Port: on other two boards with a (persumably older)
> LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> issue does not reproduce.
>=20
> Cc: Mingcong Bai <jeffbai@aosc.io>
> Cc: Henry Chen <chenx97@aosc.io>
> Cc: Han Gao <gaohan@iscas.ac.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for de=
vicetree platforms")
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623173648.2229=
22-1-xry111@xry111.site?part=3D1

