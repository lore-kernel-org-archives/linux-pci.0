Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE942E88A4
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685171; cv=none; b=jmnPHehoMYOlMRBKmXu8PgZ1laKhX8yHu0Q0vCce3JP3mtYFxf9aIqEACxavn/G6eq69TEk60I5QrQittiEiAGEw0Tvf/StGl/WrCzjtpgL0SEy5Dn2pDb7xRlH3hbtRkTobyuUzdkq9QhKC58n8zrrPO9lCGn3ZmX6VQTvWFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685171; c=relaxed/simple;
	bh=8rhksUpFfqowCKeWMFIjqYjSvLgQXGrGnN5BF/cjadE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mb+4Wg51F5x+PLsZ6ZxaPelMiz4+b8Ciy5A7Let5Zf7YODm7YCa+FtY+zeyYFgYUhRGI39Uk+PlzYs8r0MptFbS6DBx5pE5KJTUB/s5y7Itor4i4G3tSo3MDEm1rxF5qYPbfm/fbzYVVA/myhwQ+SJJxP7dUQ0LAnKkz60G6QEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPKYCgeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPKYCgeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9256C1F000E9;
	Sun,  2 Aug 2026 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785685169;
	bh=8rhksUpFfqowCKeWMFIjqYjSvLgQXGrGnN5BF/cjadE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPKYCgeQiGaevjDvITIoDJLlNOajxWFAAVYeDKSzWDOok3g0a8ZEAdmgK9nPvJQ3B
	 HMjC/rSPqQ4+Y16HmOJgWTmG1mJLVteoC19rAUIhlXBmxlOpeLHnG4MC58hZi70XbA
	 A7cdGp65RI52NLuB8iqKxN7zkSXoxokn7FaY8dAKKqcDCLiERNKEMwMZqy+fHA8YUo
	 6RFXcZT0pPQMNfXg+ZTsx6mZUCYadrGzJM9hG7gLlvUiYW+7EFxIq2dGvAp0AbGat2
	 O8o97sK1zas9TuV6MCTqohoTwq6E6/74Y46lQqXy2FhGtgnegPFBNNEAyQAgkT1UbI
	 UDW5aLZFZ42ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] PCI: Add ACS egress control vector accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-5-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-5-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:39:29 +0000
Message-Id: <20260802153929.9256C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Whether ACS P2P Egress Control routes, redirects, or blocks a peer-to-peer
> request depends on the Egress Control Vector bit for the target port, not
> on the enable bit alone (PCIe r7.0, sec 6.12.3).
>=20
> Provide a helper to read that bit for a peer Root or Switch Downstream
> Port. Report an unreadable or uncovered vector as an error rather than as
> a clear bit, so callers do not mistake it for permission to route
> directly.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D5

