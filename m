Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF800459AC4
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015548; cv=none; b=cvCN1RcSFZTXjv+gf60CMiPKpaIMdOLqDUcg4oAdC6KZxqOBDgwT5yVoSX1DNSj6cnYDhE7oVIrURCYpgfe1SFmw44hP3B9JTGxgFF3ER6RYZYxGc+zPSeRDsRu3pB4lDyb5AoLalS4YDlJ3/R6Wszil4RFGYOyNQU6eTH/MHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015548; c=relaxed/simple;
	bh=0kqEdtleUV8bptHpkGnDfQjR+w1TQQweYFSdMpLf/v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hKmGJJWn7gM1/53cULSCyorAQoHDCH29o40BZ5140ul/R7dJylG4AF9uip7R+gnoHA6USa3GvHZRCpAqnKia0Gpu4MTBNdeV/Ac6fBQqqbHFlu9Obfiu60LsxdBlrOSt051fK8qZDN/AL1Cu+UWc7/zEkq4fcfgNo8f5QXMjnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrFhRaG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrFhRaG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA881F000E9;
	Thu,  6 Aug 2026 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015547;
	bh=dGc50x6E10FAVLNTUiodv1rLFDLqkNND2GwJ57ec1+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XrFhRaG+MzHLvChcuYSjltETCPuTbSi88eQfDEeBVypgdt9JH7mZyr4xOywOohtWW
	 j0wtdKvdm8SsP22jSte7PLOqcfnBAYVrQUtOx9WGZu5/Tmipnb4RqUjloVnYFVS/z7
	 qQfwpOcsITwTH6XJ3iHvsyuZuVCu15/moL85GJ3IBgTQV/Q+NPuGJA0B3W0qgsJ1r6
	 Fays80uRE+jbZw1gX7O9pPdIwasVBtHKQeBaFzybpeaJ/RH9GnyHuXiRcKqb0wRbGf
	 P1/jbS0sP6N7pwZCTQE6VX/C9ukcFizp9N5j7940Mxashuj4iBFLlr10Rk5AMHWytF
	 jCws1e0DhNgVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ACPI: PCI: Avoid misleading _OSC messages for
 non-PCIe host bridges without _OSC
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?= <kazuma-kondo@nec.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806112052.857684-1-kazuma-kondo@nec.com>
References: <20260806112052.857684-1-kazuma-kondo@nec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:25:46 +0000
Message-Id: <20260806112547.4EA881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After commit 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of
> acpi_run_osc()"), the _OSC evaluation path now returns AE_ERROR to
> negotiate_os_control() instead of propagating AE_NOT_FOUND from
> acpi_evaluate_object().
>=20
> This has not caused any functional issues so far, but it produces
> additional misleading messages for non-PCIe host bridges without _OSC on
> some Intel servers:
>=20
>     kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
>     kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
>     kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Clock=
PM Segments MSI EDR HPX-Type3]
>   + kernel: acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug SHPCHotplug =
PME AER PCIeCapability LTR DPC]
>   + kernel: acpi PNP0A03:00: _OSC: platform willing to grant [PCIeHotplug=
 SHPCHotplug PME AER PCIeCapability LTR DPC]
>   + kernel: acpi PNP0A03:00: _OSC: platform retains control of PCIe featu=
res (AE_ERROR)
> [ ... ]
>=20
> Fixes: 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of acpi_run_os=
c()")
> Link: https://lore.kernel.org/linux-acpi/d0be949d-0e21-472e-a44b-cedb1dd8=
695d@nec.com/
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806112052.8576=
84-1-kazuma-kondo@nec.com?part=3D1

