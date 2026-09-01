Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DF369D4A;
	Tue,  1 Sep 2026 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255925; cv=none; b=m538ZNe9wCTpRofkJ7WZwX+BBne4r6GBvQD3ZqbBStGN3SCXD6z2QEKVLGU7jwPJABCuyRIfg1JfWKE0V8YAw3SWgXqi7ERn5sROFnKlsXKSn5FAYUHQ8JCldgaWJQ+jkQNvV5GUXvHYRy6hl/Bfvzlq3irUF4lnTFvW/JtClDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255925; c=relaxed/simple;
	bh=scxntiwBSyZ4Bmfst+EywtXRoiFYMnE2Gu71lCWTcP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gEwYIUyeHookEbprrzRqAxutpsAGDVDXCTYIiBxqN5TpKm8x6e6kYFdPIIOLrGbnXFPUih/QLurbo9yqW75FaMdVUyEWZPGI8hkmx1Hc5niapBz/Jh/D8rMLhvVl0eCIxSwgAUbmyoQ/i5LgGE9P8tGukqmhB/sS8Hc5Xd5Dckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdBVxy2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdBVxy2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D651F00A3D;
	Tue,  1 Sep 2026 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255923;
	bh=scxntiwBSyZ4Bmfst+EywtXRoiFYMnE2Gu71lCWTcP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VdBVxy2aJlJ3c9OY3mCV5buv2buoOTIn9lPhkMMBfoUzw6ZgIm4GlKZ0m/DwnTkr+
	 +XzHDr3ekOua4IeABCg+n4ZbZJz+30+dwcODYKZjMzmP+E94N7IkVWyR/NVizB6vlc
	 wPbiwE9qIMdJSF6oGMEypt4m+6BPB6LYZ3NoXOmBBjk/eokxBWbDn/uAWu8i4c/dmZ
	 B/Hh0zTxWtkmzuKfL2jLdaaJfbgeC+s/kYF5tqA8Ftd+1O4QbWY40SFrVPYEWbHd6X
	 c+5csITKo7/7oF8aZz5Z15kaTp/mw5PDlH9cVndUkXBvT/RSVCF6Ooc5Du9aqYZ6wF
	 ZVCsKeMKNH+Fg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/19] vfio/pci: Serialize function reset with
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-5-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-5-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:45:22 +0000
Message-Id: <20260901094523.37D651F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a function reset helper and use it for VFIO_DEVICE_RESET. A later
> patch routes the guest triggered config space FLR through it as well.
> That path never did the power state transition, so make it optional.
>=20
> With recovery enabled, take recovery_lock for writing, refuse the reset
> with -EBUSY if access is already blocked, otherwise block access and drop
> the lock again before revoking mappings or running the reset.
> recovery_lock cannot be held across the reset because a reset method can
> take pci_bus_sem, and the PCI error callbacks take recovery_lock from
> under it.
>=20
> Dropping it is safe in both directions. The error callbacks hold
> recovery_lock for their whole body, so one already running has finished
> before the reset starts. One which arrives while the lock is down runs
> its own event, and the PCI core calls it with the device lock held, which
> [ ... ]
> fault path, which waits there rather than failing the fault while a
> reset is in flight.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D4

