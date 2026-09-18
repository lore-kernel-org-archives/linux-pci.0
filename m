Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBE54707D
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704210; cv=none; b=oUL+tlKGm/BXMh5QwzCE65OJqYVFJrHkAOQoQ4XeowU/4kJIxx1p+gFySYUi5/nONmA5s68aHSMfovOF6ZqmBEvliGtwUWeXSsxjFR5R+0f5xd317V/rJuouKnVwTIGQHu/g2D5iGjcq/t4UjDzMfM6tAjjr3ynMrfi35/Bekyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704210; c=relaxed/simple;
	bh=OEM678j0FB9lq/rNtKlWZ3CzV0h4/jI9l7jCben3uAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBeHZnDaSBGmJmGPso2FsGSfDLQzpep06S0xWhPp5XXKtXdwvrQP+6le5QdyPusAaRG+xIbADs65CAk78D+FBTOxogov+pqbf/wqsSqSSlkWgvUDfDcjb6QEwatdjhpwDulXh2RXzE4lZQgac0zWBaHv4DxB/9ZXV0mvn40Uezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5XtErbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5XtErbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E232E1F000FF;
	Fri, 18 Sep 2026 04:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789704209;
	bh=OEM678j0FB9lq/rNtKlWZ3CzV0h4/jI9l7jCben3uAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S5XtErbrm60cUTRKwkqCkKL1QmSbarOAapemEl6bj6Z1X5l+bTNjJnKIcNqgekYFI
	 4X1rJvHwnK7YdxC22X3+LdbqEMDDJJAkwRZ+N3XuazHmUh2PKz6Klmo+sB4AWdNM3F
	 sQxv9Wd4xFLf8uWFSkPVP5RUOInin3sHIEo5fceRvIeGeVZR5N9Bz9KB5bVVR11Pa0
	 Si3BkYCTT8On3u0yjNuzot51WEzpQA88KgXKt9hsBbtdrn/gvXpYKaePquHQLsmEQB
	 dsVN4tfIqDu9X5p6uYN/e0tLHSCV5W8DNrgtjW2ttiCYPkthRAvHnLduylUwKeX42M
	 05NEeeNNbF44A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI: Fix BAR resize for devices on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liz Fong-Jones" <lizf@honeycomb.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918035633.566823-1-lizf@honeycomb.io>
References: <20260918035633.566823-1-lizf@honeycomb.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 04:03:28 +0000
Message-Id: <20260918040328.E232E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_do_resource_release_and_resize() releases the device BARs that
> share a bridge window with the BAR being resized, but when the device
> sits directly on a root bus (pdev->bus->self =3D=3D NULL) it then skips
> resource assignment entirely and returns success, leaving the BARs it
> just released unassigned (IORESOURCE_UNSET).
>=20
> Skipping pbus_reassign_bridge_resources() is correct in that case --
> there is no bridge window to adjust -- but the device BARs still have
> to be reassigned. Before the BAR release was consolidated into the PCI
> core, this case worked for amdgpu because the driver released the BARs
> itself and then called pci_assign_unassigned_bus_resources()
> unconditionally after the resize, which assigns unassigned device BARs
> also on a root bus. Commit db92e3fef53e ("drm/amdgpu: Remove driver
> side BAR release before resize") removed that call, so nothing assigns
> the released BARs anymore.
> [ ... ]
> Suggested-by: Ilpo J=EF=BF=BDrvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Ilpo J=EF=BF=BDrvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918035633.5668=
23-1-lizf@honeycomb.io?part=3D1

