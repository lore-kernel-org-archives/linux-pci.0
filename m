Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D83C4163
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277128; cv=none; b=XRVMHaQaBur8+EkgNkJ3sWgy8NBs6ekkrLesEjOwDg6NRLnjXrWku0hElm6EhhenJSaulqyYRjLbX/i6allzS1XSzAmAqwGd3GSpj/fB+jmp/K6YsBiKFsr4W3WIYDWBA2PVivhjSHNCEIwVknjkX+IPS5LtN904qpKzgkifjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277128; c=relaxed/simple;
	bh=813t1DR5gLNaZoTZ5myRGb+Y7Pgu4JwNCw1oOUAtvlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lz714RPXVeI/T2QR80lcW6yF1Cpm8M9oesDqpunXOMTyVV/CwuxMQiqqjBFY/AYsstXfl+tmGsy8UXlc7zS7fgBcXUzYFyORhWdCkNBCQywui44pOtkY37VpW1clCAhSpIo37gTaO809vT/kiQYNHo0IoBNuvdtIaqasSBgKRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evXDYAvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evXDYAvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8F71F000E9;
	Tue, 28 Jul 2026 22:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277126;
	bh=813t1DR5gLNaZoTZ5myRGb+Y7Pgu4JwNCw1oOUAtvlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=evXDYAvc0SDwph+PM/4E3FGTkC7Rtz8CBn8LsVqgA8Oev9ZuuUDQIDgJNg+/7CmlC
	 khbliimJS8nN+AQxf6HQr2udR22saSuQXog68VCAyZQrbRmChie+AAUIxGMnHzfcem
	 o16SJA2bP6WWSpkXJxA6DuuBW8iDPDt6WNmiQrAsTQK3oP/4vBHp/KJhBg+/UsEDAp
	 PUnDU5s72xRnQ+2ledZcsIfBs59fVQvk+D45iLZeuMaSNwnbfyBvv16J+2r2XvUfub
	 lMGF8YS7HUCtmdQBQiOYg0FZtANipohbk/RZd+cAS/1GSlhBQCexH7EHyfMC10RqMe
	 waKa5P8FRC/NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/12] PCI: Refactor matching logic for
 pci_dev_acs_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-8-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:18:46 +0000
Message-Id: <20260728221846.9D8F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D7

