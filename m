Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFE2E266C
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257870; cv=none; b=s26Xg3Bjk8Iy2HmHGXtgLe2mqKYWfuH3SS974pORuYIR8lNkbpbiv36tnZlZPEVSQav2fzxuzpnLCs5CqEi8bsynOkD1AaJRWtjf3ZHMfEH3bOnAyvA4C+VZKRgVVVh9oMWifJTBhEC1FWgrIRZoVncW3FeoGvLCtdx6PlPXAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257870; c=relaxed/simple;
	bh=T0cMt33b79qhCp0TY6MyisX9DsQ0/RudzCMipjMje50=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=KcUUqIzGFDwacPrzMcI/7HTHJrKyKXXSKpykEiWQCuyY3Qc3rN4c6ivm2TkJe47oB+T6Q8VhSzLSRKGhfGvaMZjXViNMV1GYvDfmV0KJkNifgY/uPXleG95gXIJ29xleQqgC8BZ/390xXBNargOrTart2cBUIl2bdFuOVEEZFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlGHqrO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlGHqrO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92641F000C4;
	Sat, 17 Oct 2026 17:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257869;
	bh=T0cMt33b79qhCp0TY6MyisX9DsQ0/RudzCMipjMje50=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=UlGHqrO79ZEJflsGvsKBjTV/0InjhkRG7gcvovWZO+javt+bi3wHX3UNCByG0bt5J
	 ELg3Yy0Ab81SYNrGmo5thj90kvYKUDTpYx9Z+0c2vSY4o7/LfNT1TB37NOgah10woh
	 R8HrYncunK+Jcz9lBkUJaVEaom8Z0r7xsnMVWlEtfJIeuc6++fUHgi47Gioh5VGhab
	 FkizluMzT3mWIkVqOcrFEKlo/2QvOurksqVJttuvAGOOyV4c8oTbrRkFo7km2CiXmO
	 61kJMOadwA5ynwjMuDGkq8P+U89AY6LaGt64SbdRRRT6aSTpCAbfnTDxKi38NygN6J
	 2nvJdBUuNS9Gg==
Message-ID: <sashiko-outbox-175701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rcar-host: Free MSI IRQs on error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
In-Reply-To: <20261017172122.225861-1-marek.vasut+renesas@mailbox.org>
References: <20261017172122.225861-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 17:24:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The rcar_pcie_get_resources() calls irq_of_parse_and_map() on both IRQs.
> The rcar_pcie_enable_msi() called afterward calls devm_request_irq() on
> both IRQs. In case a failure occurs after rcar_pcie_enable_msi() was
> already called, the invocation of irq_dispose_mapping() on those two
> IRQs triggers a WARNING:
>=20
> remove_proc_entry: removing non-empty directory 'irq/96', leaking at leas=
t 'R-Car MSI'
>=20
> Fix this by calling devm_free_irq() on those two IRQs before invocation
> of irq_dispose_mapping(), this way the IRQ is free'd before it is
> unmapped. Fix matching issue in rcar_pcie_enable_msi() fail path too.
>=20
> Fixes: 290c1fb35860 ("PCI: rcar: Add MSI support for PCIe")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017172122.2258=
61-1-marek.vasut+renesas@mailbox.org?part=3D1

