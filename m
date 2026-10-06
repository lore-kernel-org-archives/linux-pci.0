Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D63270575;
	Tue,  6 Oct 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316106; cv=none; b=ZsuurnyfTYCvnW4pALgw4gNfzTT7F742M7QSXtYLDTL52BXOR63eekTI0SA1hJD6tkAoeMavRbXxwtliLQ7TwKQwAiyK3ZqRR7m9Jce4JRiKWc758D8LUp5wZByW58JIf8/ImbPYyNVqN57na+6T4eAdoLHzH+Do5dYtJ7Qcn5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316106; c=relaxed/simple;
	bh=nj3394WSvWjO9Ky7954FHH86JHXjkxYr/8u2g+5vpKk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nWK/4Ql/S+itNilCmj2r87Kp6yPDYiPTA6xaAR1jAUbbqB9LLOn4a53vScPk6HJ8B+GY1wQNSZIwb31OX10alYclwOYBzKvMgIK6ERY0uk0lFZOOj820IZItrm8NAoI8KBvyKkPykIvr0nPPce3KToT7qjA4PT9jUytsTzf8xRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfUD5+IL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfUD5+IL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EC21F0089B;
	Tue,  6 Oct 2026 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791316105;
	bh=nj3394WSvWjO9Ky7954FHH86JHXjkxYr/8u2g+5vpKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfUD5+ILpXR8vcSwuOemGZnhdR3JjELT1mUp7xcj34PsVUVCydWbTQqFRqtFd6TeG
	 j8HHLnFgdSwInF9cWc2K6Xt6hsvP6uX6TRAaNRc5YrHu71WHIjQdDhUbBRYcdsSrYx
	 VWfb/VMF1jwBdj3S0bgnDekUV94ZNflsFGxi3mLP5RW1AG9HMqeLS/WkKKdw8iauRl
	 MfJX4qMiuHOkpjR3a/0KpwzIj+Lj50sAocHlR/w10cUwl476apV9YfNmPymcZK7mpF
	 XgIGKBXNdddb6qeYh8/BHCTmPFJVUKm4HAcfuXnWfsGL+vkLV1hkfiJTtwgVA6je+Y
	 QluY72l5ftxvQ==
Message-ID: <sashiko-outbox-162411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/9] vfio/pci: Add a helper to look up PFNs for
 DMABUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20261006193643.76330-5-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-5-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:48:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
>=20
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
>=20
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
>=20
> This move also adds a new member, vma_pgoff_adjust; this is consumed
> by vfio_pci_dma_buf_find_pfn(), but will be set in a future commit.
> Add it now to reduce the number of functions touched by later commits.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D4

