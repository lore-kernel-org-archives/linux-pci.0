Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28039C63E
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211067; cv=none; b=Rf8Q53MTrTwfLBUHOzmxILQyhWkx9S7NHsKvTUZ9Oogxh6h1TDZyNALRGr3mctxPQzUCzL0GJEP3S1Nt0okEKswfpClM38Vzvrybga7f/FoVvuQQx3TzpLlfttcpIeHvs5muSVJpDY8WUzINpYzD5CI0xFDQiiUSfFI2bbWAaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211067; c=relaxed/simple;
	bh=oAE/jVCpU8l9YhTllRG9n8cl8JS9qg339eF/62g1soc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UjdXhxv0C/Ad1T75zrirCE3ctzzSGpTx+DSus/tsPL8PJHL93fNG+V1eXjoC9Mw0kDHtzPUYvSreDs1I84AgIDmn9KTPGxn3ZAkg5ovC2pR6mEOvAF3veOcnkKwBq792X66gANYFt3Pw0b+pMAsVdJdNr2cKJPqcKvNqTWx6ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImVXbI7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImVXbI7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30C61F000E9;
	Mon, 31 Aug 2026 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211065;
	bh=oAE/jVCpU8l9YhTllRG9n8cl8JS9qg339eF/62g1soc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImVXbI7RvBcm5VoTiCMIRyESXGNLn7oFR8zHuJYhnKsNNcmqO+vKMz8sCZQZSSBSZ
	 oVwEm767pL2v3xuOO/MK7z6C7FRsDK6y2VO7NuJR+aGb6/pJsLge9rHzBgsz574/nk
	 Tb++xQHT4y6eGr9aXVYCrTjD5c7PyN1U7UbcFjeyvRRLKsVhif5RSGW/ckojw+85OQ
	 6IczG3wppp4SiM94EP9vhCCBEU1nYIvwAr1VsduvF3hYqQkWCQblZwWg7Z5n1qRJTo
	 7Wcl9SsfaP4gtdc2/KOBExqS35OOzpG+tb+JUWqdnWUt2a3jl2GdcFsHObbJ2Qmsdr
	 Vh4ekQAX4EM/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] ACPI: scan: Adjust and rename acpi_bus_attach()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <119223276.nniJfEyVGO@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <119223276.nniJfEyVGO@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:17:45 +0000
Message-Id: <20260831211745.A30C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> After previous changes, the second argument of acpi_bus_attach() is
> ignored and none of its callers checks its return value, so rename
> it to attach_subtree(), add a void wrapper around it called
> acpi_scan_attach(), and adjust its callers to invoke that wrapper.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D6

