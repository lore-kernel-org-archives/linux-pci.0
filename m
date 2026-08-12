Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF71279DC2;
	Wed, 12 Aug 2026 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510857; cv=none; b=h8JIrw8O1rywT7ch+IvdvnZ9ymn12vyzzkXRkUxM/HaHpHnimDhXSsaqnJc1rnin1HM3bkQ74WPkOk41kYbNKH0mGq5sB2THkKhjYbzLonjPe8JXQqQuDGgYD3WiTIyzPurvbsRthi5DWOH0bAh6DAqoSM8GfHEJa1/WRuB/9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510857; c=relaxed/simple;
	bh=vL/MAdcs5I2oLYjxdR/Edz374iL2fj9cldpYpnaNOK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dWslxJA8sxsLUXnGNTjRaXyPTqI4HgldIT6d5qknT+Th0plklU8m0OhtanWNsABniHwv33zeCgAcyOzHJWLzfkmjD8FkAvySfxBGKFYP4qnBgmepqh0lBKKblIZarD81f4xtqHu6PBOVQoRrZsU0lZh9k4/uoDoa0s1+Gsj8EOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6lE2u1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6lE2u1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE6C1F000E9;
	Wed, 12 Aug 2026 05:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786510856;
	bh=QeMCpcnmCrAMflgi2D7tQ+typ8+KUO8S0LK/VbsOWak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6lE2u1M0VGDVf8ZYCkF3bWmuMItpuNN7b+oSEMGCW9z5evIZfDA3iHl+CVvSKMdL
	 RFArITDzBBmjhbqQeDLnNmADZTTaCxP6kRri5FsW45scN99eJXV/Rg3PtJ5b4sxohZ
	 tEEKJgZK9h1QFtybR3cc7yIAG4ffaME/CVC3WBgwJScmSw9tsHu6/1aDTTgvzCpAdb
	 4TKiSSI/xDHn2osgDB9c9iLMP0QzLvQUvG5Bg2zIxQoQgfAM7OetaFVBhwrISvXteD
	 TQyvwE1zN03LMA9QKA2twYqjCNRZEdu8vdI2i/l1d55URglqeBrZJyX4CfUsDbQ2Rq
	 FJnPRLQlKVaow==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] PCI: Add pci_reset_bus_cond() for a
 caller-gated slot or bus reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Williamson" <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260812045325.2733631-3-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-3-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 05:00:55 +0000
Message-Id: <20260812050056.3CE6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_reset_bus() locks every device affected by a slot or bus reset,
> performs the reset, and unlocks the devices, all internally.  A caller
> has no way to evaluate what the reset would actually touch.
>=20
> Add pci_reset_bus_cond(), which takes a callback invoked on each
> affected device once they are all locked.  A nonzero return value from
> the callback aborts the reset and the value is returned to the caller.
> This allows, for instance, the caller to validate that SR-IOV is not
> enabled on any affected device under device_lock, where the value is
> known stable across the reset.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812045325.2733=
631-1-alex.williamson@nvidia.com?part=3D2

