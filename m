Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBC3A4539
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207915; cv=none; b=gbw0ZwyLr3r6Bb0V0E6kOVgDE0EE1MPgN1o02g1XEw2cAGwIxApYICeB3jowcEGe2h/2cc08dD4MmRRHTVp0UW71cVBMSNe21d49Eqi+c4+3OrK1Leh1nKNmOqIzKneDwWRyOckOzxi3gx1xEswhuRWHxsP60nBlVN2mFOtEfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207915; c=relaxed/simple;
	bh=itGXS/9wIJLd92FC8pYXnMppREA9f877Ya6esiB7+k4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tWnx3tgBE6zZJWurLHh2egdHhKyz2s1p/IcEptjEvcrnpP8S2eBhc1Yi8l6fep6dBIoZLlN6HdlhgGQ2FugG7QWqQ2cFFYE1itEmRM1nctWLemdt/rM4jhFyG6uHnDnW0+E1Ni90ZW/GIG3jyjatA47U4lzn0Wpc7RrVLtO8ZhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFvOWIU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFvOWIU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5857C1F00A3E;
	Mon, 31 Aug 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207913;
	bh=itGXS/9wIJLd92FC8pYXnMppREA9f877Ya6esiB7+k4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFvOWIU2cDhbp6X9CymXQ5DYZrr5+rhfJyrlu8RG5YHvcDBsSCDBbloPYdqr6BDKa
	 PMl+bKBq7GcqAXNlaFzwaWO57rH2HfnFGCTzufpksiCUpVk8AkWGRIgyRBuIJzp+ZY
	 wnaUmB+3FqbnagXBW+XvBfXPO+s51eDpAzpygb8LiJu3iUQo+OzfUUqfBq2it4iZYp
	 YPvGozuBUF+IPoS4dSa3idLTWkwO1a5AxbsoI7ZgUiPMljbg/olMXMOIJb3n3f63PQ
	 rpb1ucY0ibR6LWn+cPUF4UFdntgDg6W7228QpwUoU4/IOnD7hR+r2BTWuvqFScAUtN
	 u2IF7kPs/EVlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] ACPI: PM: Introduce acpi_device_init_power()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2055986.PYKUYFuaPT@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <2055986.PYKUYFuaPT@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:25:13 +0000
Message-Id: <20260831202513.5857C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Two out of three callers of acpi_bus_init_power() need to clear
> flags.power_manageable for the target device on errors, which
> is somewhat cumbersome, so rename the function to
> __acpi_device_init_power(), add a wrapper called
> acpi_device_init_power() around it that will take care
> of the flags.power_manageable clearing, and make the two
> callers of acpi_bus_init_power() in question invoke that
> wrapper.
>=20
> While at it, clean up the declaration of local variables
> in __acpi_device_init_power().
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D2

