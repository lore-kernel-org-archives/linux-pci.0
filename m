Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD9286A4
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785520120; cv=none; b=qw8S0gl8sXr4jJAio0X9a0XwfmlCg7C3rEDsVzTtz2zptnswUmEN+b13oH6ufVS1ck/phRbOyy49CNjL8pAOYuFMBrFkqZBFVx0HR6/tqWaCGgsfC6sr5tIjVkXaSk/I4Eva+/0LM5hvywIP3CGx7DbDix3Cvobhd7tLAk8y2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785520120; c=relaxed/simple;
	bh=Ix2/DCAjg91oorcEnnXrrpy+Tys8kM7XVrvuxG/93dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sIyXkXcR81bcpzfbEphKfA5eU41fqq7HZWjIPnMvEPIqfM8PuO2k7WIPhPIpCqpN7Dh7OhKrdVS9xIuu2QgVh6GAzHDXwZ10gLjIg8z7ku6Akw8eeOO2LLlpSIx7V4lJIt1foWlAHu6oAPAUI+lFOuKsgIurZfwLUcsaLQ1ljfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR8396u1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR8396u1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B871F00AC4;
	Fri, 31 Jul 2026 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785520118;
	bh=Ix2/DCAjg91oorcEnnXrrpy+Tys8kM7XVrvuxG/93dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UR8396u1irNfVwyO6j7EOhFzJpzXmlKvnN1hCZ3RwOpeZFo4mkQKRYcqJXXXK/aRx
	 W/bqLtJefibTkQaFZx+AnGkqDUODtqV6WpY0FBjvGQnbXXcTcDOUzEQzARZ26MeWyz
	 itJXLh5smmKg0gC4sAet2h551guqppcAGP+n/5i6fEMKgoBj3l0FH9ITTQuanjzCqG
	 DK+KLfZDWAaPx9VU633946BfcOwfVwhlnIB3kjpXKkYZoY9PzL0fQsF5PTpSLylzgy
	 89xh7iKJk1TU5r5LQYStv9CEuq6dZThij1ZJD9JIRYD7BcCV8+1Wvo2uSwKHGZxr0a
	 gszMAG+MCcEMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Fix BAR resize for devices on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liz Fong-Jones" <lizf@honeycomb.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260731-pci-rebar-root-bus-v3-1-6732e233fc99@honeycomb.io>
References: <20260731-pci-rebar-root-bus-v3-1-6732e233fc99@honeycomb.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 17:48:38 +0000
Message-Id: <20260731174838.C0B871F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Liz Fong-Jones <lizf@honeycomb.io>
>=20
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
> [ ... ]
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Reviewed-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-pci-rebar-=
root-bus-v3-1-6732e233fc99@honeycomb.io?part=3D1

