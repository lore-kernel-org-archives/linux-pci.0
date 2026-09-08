Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE5434998
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896151; cv=none; b=AbBSJ57NA2HzmeLk8S8KTEPUbtrpU9pjixQhjobJrT/5iN5gPv0TvxO4eqFW08Nf6lPAZTNEBfez961B8u5HhwAiHieAYhU2P8roT6Xnt1FdrDHNn39uyAKh6aSf+NV6P+pPl0PMCKyTm49hdXfe4SJQjyt7WKFr5JSma3yQQIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896151; c=relaxed/simple;
	bh=HjpkVmKHs9V5uUdpY2nIoxJK7hdjtvB9ivUV6he7Ca8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FiceyBRhoX6cxOvGtgP8+DekJ0RNgSdv2uUBVxc0YT9Do3EalwEk+VmvMzzW5mtvTPTJiJEvI2E7aL8mbelH2IWIKRYmMs/Hsdb42SS5juIWJBhvWGutiUFZaY3V0vZSMc/AK/CY7EDlWDgZa9vm35OYbAsXsHbXbEwOb9U4VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi5lPvHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi5lPvHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B705D1F00A3A;
	Tue,  8 Sep 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788896149;
	bh=HjpkVmKHs9V5uUdpY2nIoxJK7hdjtvB9ivUV6he7Ca8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wi5lPvHVh/MjtbVzr8eDEGNYy6wSrDXW2LJ2O5k9MQKpNviVFQ0cWdoL/FUGitl15
	 GQYneLiL6mu6LPbGYNVsDRstV45GCqRZzqJnfwo0CoWZafVg1uM0o0fbGoERY6l9SX
	 uu60L4l+XuRKlCd6UNZtn7EWNbBzpan2jJR+lj4iL25AGQCu3bMFitLYbCRWRwrSps
	 9f4l67hdKkb0NMgAQ0QgVFsnKaEeAWp0zwCilqYKgrnokj0DZcIiWJtIyzlGpbINDM
	 K9rCgeM6CTuaC0lZ/qSNvZ3VzqVRKj5dzYeSB+oQl8Mlrew5tPgargZzMd8DVWcT/l
	 QbZpR0AOjm1BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: Fix BAR resize for devices on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liz Fong-Jones" <lizf@honeycomb.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io>
References: <20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 19:35:49 +0000
Message-Id: <20260908193549.B705D1F00A3A@smtp.kernel.org>
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
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Reviewed-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-rebar-=
root-bus-v4-1-2780e9c22e08@honeycomb.io?part=3D1

