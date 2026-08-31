Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063F37F304
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210852; cv=none; b=V/td55SKcguyX7HSwqTlIePSdadlMJgOFMw/a5RsL5y48JWJuXtlB/WCFhixb45tmW1M7i9nzi8hmL5y3rLVyrw8Qqrl/YVHhEcDVAgmD8mxiFTuL3qVdagT9D3Lc8CSpQVIv/AkqseG8daLYO5JXk65kIymVvcjtkE7Zre5+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210852; c=relaxed/simple;
	bh=1QlQECTAseObBIusJW9ebnpc9lQuSF9jdxI7MtnOVg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jprqbz0kuuKCN/1LlPPXU/7S5QoFkZKMSICJpO6A318mPsD+MpYszby5i0+j/7jyiMGhFzzMMR58/RpDLXssAetdknsTmZH/KFkw307Idn9rFszeb0zI0XPk2xPD2s1/Ipuo1k4AcscQEXIvaUEADhfhLAyi764vyG/KekJ+FeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecw9b+HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecw9b+HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B3E1F00A3D;
	Mon, 31 Aug 2026 21:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210850;
	bh=6Abo0en1qajQT1UOv5NoM395d076OvOw+6hHG1Ab7fk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ecw9b+HS5BgDkH3RrAHkGRDigjoFw4L/m7ZLgB0INC8Sv+d9PfWTPQqP5HPT96vQn
	 UdZMqJPDC0yCEZw3RQZ9cWDVVhXDC55K6wFa6GLd6eWVcrMz8RIhlKBBbLCo7YPnv5
	 cSgDkjUG1PQfS5bCh8HQG/QZ0mf8NQ1x/M4s+qEGbnILs3dihw9plUnWzqtMPbCjXI
	 S+2wfb7XH6z1c992Zl4T183hBxha3W8/pGXun7toRhN2q1YlQrpDICD3GZ54Fqee+C
	 yuL5+hokc9y8ZLU/iPqZG3Wfp/G3bHu7BYQWOd5RYdFNIBtdwx5sMty7npbuyzdZfd
	 R1tDtNF/g+jnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/7] ACPI: scan: Add ACPI device "enumerated" marker
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <48339705.fMDQidcC6G@rafael.j.wysocki>
References: <3435655.aeNJFYEL58@rafael.j.wysocki>
 <48339705.fMDQidcC6G@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:14:10 +0000
Message-Id: <20260831211410.B4B3E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Currently, the "visited" flag of ACPI device objects has two roles.
> One of them is to indicate that the given ACPI device object has been
> enumerated, which basically means that either it has been associated
> with a "physical" device representation, or there is no matching
> "physical" device representation for it.  The other one is to
> indicate that acpi_bus_attach() has processed the device.  That dual
> purpose leads to some confusion regarding when that flag should be set
> and cleared and by whom.
>=20
> To address that confusion, add a new bool field called "enumerated"
> to struct acpi_device for the purpose of indicating whether or not
> the given ACPI device object has been enumerated.  Accordingly, switch
> over acpi_device_enumerated() and acpi_device_set/clear_enumerated() to
> [ ... ]
>=20
> This allows a couple of checks to be dropped from acpi_bus_attach()
> and its first_pass argument is not needed any more.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3435655.aeNJFYEL58@=
rafael.j.wysocki?part=3D5

