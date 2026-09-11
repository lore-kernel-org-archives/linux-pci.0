Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA772C235E
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130825; cv=none; b=s8S5EBeVgdG0R4ZP4560RxJFviHg93AgGxhwF9p20sRgpIzAJAHeLr/DzboWOMtIsDL2WskPCTtYAO/FG4VqE6UupKhgPKX9NQz0A4gkU2wRMiMkMyqq8AyzsbluBK/upadHIHFctgT3NbHvF4O8MCyAieLZ9d8bSa6MhfkC4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130825; c=relaxed/simple;
	bh=gv0T/4duhsszsOPGR1nkvEKxK7VVOdr0TLUN3WvczJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mXGrUAPJ02x1n2H+9wA7Uk4QAwa+1W4TfFkTmJkG0DWAu4VXX3yK4oJg9RaQq2uCyKOWn0zXfNV+Q8rJ2EJRI/ti1IhI1LHCY55AK1r6rAUpHKDxQumTmxFPkKoUgEbCDHdv5PsCMEY6TEpm8j10Tjl8P6xoVjzdMhswVRyRn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn5K0oOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn5K0oOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE361F000FF;
	Fri, 11 Sep 2026 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130822;
	bh=gv0T/4duhsszsOPGR1nkvEKxK7VVOdr0TLUN3WvczJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hn5K0oOjmyk9W0C+grbUZ13PsOtQBnMVu/nuCX4VozPq6amAULK4Uz3LSzFqgUUE7
	 k0Lmsi7mufHfoXFWHF6bwEzWHIjTud3NAo/rxP/pT5gct1nMlv1Q+g7pRMV9NiQYGp
	 yspJ0NbgctRvM0ie/AHRamRiNc2/Swk84oApLleAxtlCw+Le9VYce8VxweimAYXRcZ
	 uBpxcUmAfSEZJlPkwO3rBShg40+Y5GlYbgqH3Ws9+a8eJLgQdEk/FEwILoM6gMpGV0
	 2ODxkTxJ4CfMpD86NUHJ7S0CUsKoZ8sNdRBoqHGuZlRvYIRXQM0PZZoPkHf8hGrLcI
	 jHQWnRfx6fVJA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/8] PCI/PM: Serialize pci_bridge_d3_update()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911123052.94884-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911123052.94884-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:47:01 +0000
Message-Id: <20260911124701.CDE361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_bridge_d3_update() does an unlocked read-modify-write of
> bridge->bridge_d3, and its callers are not mutually serialized: the
> d3cold_allowed sysfs write and the driver-context D3cold helpers hold
> neither pci_rescan_remove_lock nor device_lock. A concurrent write can
> lose an update and leave bridge_d3 stale, costing a wrong D3cold decision
> rather than memory safety. An upcoming change runs pci_bus_add_device()
> for sibling VFs concurrently, making sibling additions concurrent callers
> too, so this must land first.
>=20
> Add a mutex around the whole update, taken once for the propagation
> loop. A device with no D3cold-capable port above it returns before the
> mutex, so the common add is not funneled through a global lock, and the
> loop re-evaluates both conditions under it. The mutex serializes the
> updaters against each other only; the d3cold_allowed store itself still
> writes an adjacent bit of the same word unlocked, a pre-existing
> exposure this change neither widens nor closes. The resulting order is
> pci_rescan_remove_lock, device_lock(any) -> pci_bridge_d3_lock ->
> pci_bus_sem (read), so pci_bridge_d3_lock must never be acquired while
> holding pci_bus_sem and no pci_walk_bus() callback may call into this
> path.
>=20
> The race dates back to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into
> D3 during suspend"), is theoretical with no known report, and so
> carries no Fixes: tag and no stable designation; it claims no measured
> performance contribution.
>=20
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D4

