Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493813;
	b=07u43DcXYybXg2D7FSJJXPrZJ2cNRjFqb8n81DmZHvjWvcd6ziU1klSse5zp8zIffCVr
	 5e4KoPIBymQT6AWd5BO88O/g3O/5LBtlhjEyy3ZkOHxdB3KxxBNHUZ0sUJdBkow+Dgb/p
	 8JXlcsNMOOrls02r9RbWvb8KqMiKjaP0WgRprIBElFfTa8oh03ehe0+6zO9J3UenF12qU
	 t24rDsMLSB/knW0VnhZN2WwnnZjQR69/wQBHjr0b61W4cuTn9zgkWBSjwbDT6x4Si9TMC
	 SHvy8edpS8vSxZSlMsgs8W9rNWFNxDS8KLLReTDe1md+LEIyCFzO+n7GvmirPqSClbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q8rMGoU05VROAO7tOm42DrC9gyZlu5nMtXLyjJiwfzI=;
	b=sVOgjp8P8vtYQqK+dbT6WluLEiZDJ8zWezI6ssX+3ws+ZfeYcJsLGvAoc1SI6cDGUlZC
	 tRruFvu/k/TZozs2FFRT/GDyz0savLAoPus6aAf+e+7zFpkWXkKMIlPf2PYe4/hnkcpKX
	 aMzj1/8CeSh5lFvwPfFYwevzvQeYEBecjhli7e3oaRztSRq9ry9QqWFNRkg5uBsvcoZrD
	 iKwCEuoq5MBxWWUzB/Uf44eRwEJ93KHRz41Dm9VuldqgTB92hHvZKbF1dz9bKYZhqHi0m
	 AQ8n7Ra3ZN4OWn609sxD6Ak+a3tXggKJH9G42MdEaAtI2IwW4AzjHcxk63nNq0p/wbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBo1wyZG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E4606B09C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBo1wyZG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50AE1F00A05;
	Thu, 12 Nov 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493813;
	bh=q8rMGoU05VROAO7tOm42DrC9gyZlu5nMtXLyjJiwfzI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DBo1wyZGQMkc1oakTIoAZe4ocphIyxMgvRYfIf/sXJ4kbm6YeuLYxi5pA3kYqqR5x
	 bEb7vmY0CxZAQjuDSnzyl1Ui4m5yosvKoPLoxQhnbbjHt432lIPYvqe7AneqjTLSUe
	 rA3djADiEpxYVD/ONvdvnYqI2jd+ui/WnHPmJ3JJjSVVmX52Fau4C/ezF0QMFMu5RD
	 ILbDCx4RFCx4Yj5FoWXoEseMjfa5RFiIiqjicFIr80MuNfSLrYUhAgASS3Zk02jHvz
	 5aYL+xxzzPoVYcBGnvnxg80xqlGyH7hNQMw+IZxaztkFxvNKp1wsXybBa83hyLYxdt
	 O2g9yjF57Zb4w==
Message-ID: <sashiko-outbox-211324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 02/20] PCI/PM: Add a power-state helper that
 tries the bus lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-3-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:30:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI error recovery can hold pci_bus_sem for reading while waiting for a
> lock held by a driver. If that driver also needs the bus read lock to
> bring a device to D0, a queued writer can block it. Recovery, the driver
> and the writer then all wait for each other.
>=20
> Add pci_try_set_power_state(), which returns -EAGAIN if it cannot take
> the bus lock immediately. The caller can then release its locks. Once
> the bus lock is held, use pci_set_power_state_locked() for the transition.
> Keep the existing cases that need no power-state change. The transition
> itself can still sleep.
>=20
> Callers that already hold the bus read lock must use the locked helper
> instead.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D2

