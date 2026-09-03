Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6344EC646
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455641; cv=none; b=c2Pakidw1PqBVX4nzmnLXhxE5YLIHed7MrufDj1uK5I5rpj2kHsAisytj6c3jc5xdBTzoxqRYMSjpBNDD0mopdStvHuJRNDUWNUBJOd/rKHhF6DV7KBCIVjpFDOwbRrcb4sSIOs6dmRm27gLeVVmozSgWyNW13STX+/FNLr6XMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455641; c=relaxed/simple;
	bh=dKGvAXbccmEUHKyisZ2wabrm0BZkUiAyZRyJyah/jEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P3SFrV1r2l1Q1xtzjJJAzqwha5b1iLlDzyugoCMlekLe+y1T1Advl/X0TrAkr4XLbANBCds0HdFW+WKLMGFxt3yG0scu3pmtrtzUz1SRJftvg1KOPRSpmeAJfB0oIUjbNukmOe1SIQetxB5WcrE8jvd7bBPIYx65Yj5kpZKJNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjOrrw+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjOrrw+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10321F00A3D;
	Thu,  3 Sep 2026 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455640;
	bh=dKGvAXbccmEUHKyisZ2wabrm0BZkUiAyZRyJyah/jEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjOrrw+Lvl0wwbXihjDNXhJJIZnljAvG6zOg202BaM17TnmdcoLXg4dso2SbHer0n
	 cso/UbsTAXP406vUrUA62aeclJFOrIT//752WzgCpX9wgNMFZ57TP9qvjt5mAAQAEQ
	 JXflubGl2kYabe0ABNmgBp9q1WeNPY1CxAAk0W2mEkYBXVXMdL/1JhZ1uBCqLkfp4f
	 vfdQSbHUyeOzT8+JstPWxZZciIj9puaVNS5bwhT4UaH5G43ZfZA/16j9XwaG/GWZyL
	 xrgIRwI+PVJOLXv7jsWbIz2Uzc8QEDS5qOhJdrYmo/hBBTBJ/lJgOeobZtjn13oTIb
	 EGkjIXiXBv81A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] ACPI: PM: Move acpi_bus_init_power() declaration
 to internal header file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3079955.e9J7NaK4W3@rafael.j.wysocki>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
 <3079955.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 17:13:59 +0000
Message-Id: <20260903171359.F10321F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Since acpi_bus_init_power() is only used internally in the core ACPI
> device enumeration and power management code, it need not be visible
> outside, so move its declaration to an internal header file.
>=20
> No functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6044499.DvuYhMxLoT@=
rafael.j.wysocki?part=3D3

