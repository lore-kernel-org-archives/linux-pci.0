Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917A3CF213;
	Tue, 23 Jun 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205208; cv=none; b=lMVb+7xnzg01E52QHhgRzlvNRaUrGN/0vYirpVb/3JSpx3b92p5hKwb3zK/Vkd3Zg/MZGHWvmeVGY5z7TbOgf/8UxFmkrA5GHDbUW4quVnt9z5irQYK30teTpDxhaCprJ5x9UbRxqJpkBgOY01VsoMD00QQxLEK9EGkgu2PZm7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205208; c=relaxed/simple;
	bh=VI+cychbU6a8m20qQBzsJlL7dc5v159G9AlpbM/3m+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PW5JfoUId4gj1I+g5aSG/MirHarPgOGg2w+Cmz6EJ8/gqNUImuA4Y2rpUC7+b+xNQYhnsnkBTYyUe/FmUODA6DcoAkihBL9ZGPBT41UDAuPLBW55XYrreCMWgU5vXQWCIxe4XzKYz+wL/4n3V1NvAZyqOLqrwExnHj6+hEnmhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFm5sKSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFm5sKSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BC1F000E9;
	Tue, 23 Jun 2026 09:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205207;
	bh=VI+cychbU6a8m20qQBzsJlL7dc5v159G9AlpbM/3m+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFm5sKSs7oh/hd2AmoL9MwTVKbvNvbje4q/uKT1kKNzFMHXBYrmle7XeFFrB6RpEv
	 2JYUETzwW8MeMvJDEyp/3Rz/Sf+0GBXX5pjjAa831F8ncX9T7rwVm6v4iEeJo1UTEw
	 F9CRpm7LK/Gn6F/n6qSmazVFd5zHoaYWPk6Tue2yHdzjoCXL+g1IB+WwPHY8qRTQDf
	 F07cBuHvGQQfUTvA5SRE+M5py+8XP60z3v8xgsXEUjoUvMWttydBmGefruHUO27odb
	 Xf0P2htT1AOgE5TqOruzA4wxBmniEv76C6Ts0Knsxx+8EH8JXtcLkaRL1CiN2SjPeV
	 nsg4YUSjm/w+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 02/12] PCI/TPH: Fix tph_enabled concurrent
 update race by bitfield packing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623085048.51139-3-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:00:06 +0000
Message-Id: <20260623090007.045BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
> u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
> 1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
> highlighted by Sashiko after VFIO TPH exposure. No functional changes.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D2

