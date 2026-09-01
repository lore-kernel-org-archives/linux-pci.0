Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4E388868;
	Tue,  1 Sep 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255562; cv=none; b=hAIQroHKdoq8WtNmQCAqasR9JnyKb7NSUPs74Jc6T9dI+uicttaGITLVKoKEk/c8/B0SRIhSTkamMD/xg23aZvPC7KAG6W/5lfGizOFApsuN8vqRqNxMCa+v2LvWy1XGLqwjDvq6LkW5wC+gJoPHyTfvETsx6GVhQTkBsqdiWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255562; c=relaxed/simple;
	bh=jIg5491xdBnmLLg2UfkKP4NSN3ej/JMOJ9VFYBy2cEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=olR7qlbCr+YtSTByI7bsxnisZxRFRbnWK4sP2DCHR6B6LO61opvUSQhwCc9buddPP/dqPVv+4jwbgdmOsbpu7UNEafq6lV80bnV8lsFW3PwhwTZO9DN4DXni9dQkGYTdnBIuTmw5X0HdPOKZ9QEn2ezYSsBd7Cz2Z53n6vVWKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWUQmlM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWUQmlM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BBD1F000E9;
	Tue,  1 Sep 2026 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255550;
	bh=jIg5491xdBnmLLg2UfkKP4NSN3ej/JMOJ9VFYBy2cEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWUQmlM8MhAmPZsA7+Hwy+SSBxZhtD3BVma8DIXOHusJnY1zebXM+eqtyh5qu6XNA
	 c+PL2BjqWIreZThFaw6LAU3g+jlmK3g7epL/m/pFJ+PXOEwyKv9duVk5r/X0khhsN7
	 NQOjpNf8YUrn836yzqNyJ2euBuNU0hM8qaC8f9NKqzQelXhMRLuQdSL/ZmaQ8Nue6V
	 PC2QltLGPUyJlf3ASSMZrSoBu9ii+gx+cr6OYG202BH8V9HlDMa/7c8mQAh8o72ZVb
	 GggfXpfSJtGqkneJb8hBuCF5oxeEiqTvqpkRmMSEJq6xE/BIqqJw6b+ZeGs+Kg3M5p
	 1G7vae7IjWmgg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/19] vfio/pci: Add PCI recovery access guards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-4-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:39:10 +0000
Message-Id: <20260901093910.82BBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a pair of helpers to wrap each operation which touches the device.
> access_begin() takes recovery_lock for reading and refuses if the device
> is not open, or if recovery is blocking access. The callers come in later
> patches.
>=20
> access_end() drops the lock without looking at the recovery state, so
> only call it after access_begin() returned 0. On failure the lock is
> already gone. Both helpers key off pci_recovery_supported, which is
> fixed for the lifetime of the device, so the pair stays balanced.
>=20
> The lock is taken even when userspace has not enabled recovery. Enabling
> takes recovery_lock for writing, which waits for anything already in
> flight. Without that, an operation which started before enable could
> still be touching the device when the first error arrives, and there would
> be nothing to wait on.
>=20
> access_blocked is checked either way. Nothing sets it yet, so nothing
> which works today gets rejected.
>=20
> The cost is one rwsem acquire per guarded access on devices that never
> turn recovery on. For BAR traffic that is once per width-sized access,
> alongside the memory_lock read already taken there.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D3

