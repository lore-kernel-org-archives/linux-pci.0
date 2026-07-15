Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0590399D0B
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129759; cv=none; b=jgOAtTllL5e6VoZ4AYTz0HHG6IbswzX8zGG6TO1OH3DIEEPdlmXKiNwc5Pl1kaccvCWjB80+fCrfkbD34f3zv61/4d051+dr8xs5UkPFKozl/kXPzySDI5ghcs67viQ94nBM8l0Bk7YPjC1sz8/UzRxTT2y9gZAn34csrp0FZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129759; c=relaxed/simple;
	bh=FxweUznUlnzG50zpjlOCovYgZojDKd3loW6xQkOCXAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0ayvVflvm6G8CHORUIK39E3ei1Z+rE0q9b3zCmKOocmALw8Dvt2c6VQ7b0ythSMw9teJHq1ukqj/nrKgTCRK7Bt0unbkJUeQfjKmtmM4OxrmIBRey3M38uQThkOCLc1t1dPTZviXwVG9rNWldLI8eM4vQvWr58gc5QCjz8rjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbipKQ1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbipKQ1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA3B1F000E9;
	Wed, 15 Jul 2026 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129758;
	bh=FxweUznUlnzG50zpjlOCovYgZojDKd3loW6xQkOCXAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbipKQ1mF6XqvSV6orY6lwN+r+dPgvAir7OO+08jKxkRMS76UrQ95142kbfgh8f/a
	 XQPwR+VqhN6kSx8timkPAF/HVyWDCwaqevL9pEO1smBp3DuvhsNO8z6MGrVffCqY8E
	 9yz1aNCkr+4+lv7+1wZoAdI7oInYq7TcPi8iEJTwRsDOtSz0faAi+XqIaiiwkkyVnq
	 RZFgYU4YDPj0dCM7L/LYAiFS8QjDitLA8EGZDxNOwDgCbGKiIvt75II0tQuslDzMNB
	 EKD1vEpCILp9ghnKg35IrDca4etQlWHtsPMOd7m6QNuURpeF2a6bfytSI4+h1lFuXm
	 lJcneCDjVYYVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] ACPI: video: Use acpi_dev_get_pci_dev() instead
 of acpi_get_pci_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <8706171.T7Z3S40VBb@rafael.j.wysocki>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <8706171.T7Z3S40VBb@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:35:57 +0000
Message-Id: <20260715153558.1CA3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> In acpi_video_bus_check() and find_video(), simply replace
> acpi_get_pci_dev() with acpi_dev_get_pci_dev() that can be used
> in both places because the ACPI device needed to do the lookup is
> available.
>=20
> In acpi_video_dev_register_backlight(), instead of doing a parent ACPI
> handle lookup based on the handle of an ACPI device that is already
> available, pass that ACPI device to acpi_dev_parent() which is much
> more straightforward and pass the return value of the latter directly
> to acpi_dev_get_pci_dev() to get the PCI device associated with it.
> That allows local variable acpi_parent to be eliminated.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5115219.31r3eYUQgx@=
rafael.j.wysocki?part=3D4

