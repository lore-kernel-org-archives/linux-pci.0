Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD60842DA37
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525129; cv=none; b=VvwVR/1dDBaHSt76Go9FY4+TcwdqCqbPgldOudDx9HID83XKJKZfIAh0UjIFkyLwz6Odiqny2nAZvR1gSGjgDhxPUFqEnhvmwVrXbm1JXCnyEYx2TUaS3ZFgLrF9YLhjdjAtS304J4AYxa/uzt/2ebiIDOuddW66zBg3Xxs+uCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525129; c=relaxed/simple;
	bh=wdk9XRPTKB2glI1lMEYARKLoBtHdJ8qFqxrd8eMN1uM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t/lQzbI1axrRPbW5NuULl9XZ2ggke2aZBTIYsDWdpmPJbQnntTBFp9hg7/2/Znm1jHhlCB6Iw29q4neeF/fCcFLpk4Fg2Fi9r9fhakdnxZ+OKCZFfphPvMol1ayQbggGruUTwTWv6pwFJ7DvUpuPVw6WEJQ5Fzma65iXogVJjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdFvmEGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdFvmEGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934511F00ACA;
	Wed,  8 Jul 2026 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525128;
	bh=ILwKUW+5jKWVLwszVa73GnXAVhb0UDGEn8WiJiIQ/e8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VdFvmEGOQu60lHgFYwegh/6XPDfpZbBg7zI99Irbv75JvZT8ZuRnIRuCqT/aZjFO6
	 sBhNreW1QEUIvXHCnybHah+JMhROdmogNs077nWK6ahXm23nExvLi6gIwcqyc8Bfrs
	 LWebUc/ud0XgitvTOcpEAJ7IwuCHxOA0dYwmrIw9GQ0cCpa6MBSyk14JZ+hcA0Ia2a
	 XCghIYHDSUasfEtvl/Lpc9cKqFBFmICYrjhcn4OJ6ouCuWM8DY0OzfeRNYZ7tNtQVj
	 UBGr3bdzEV7AWfljN29P+/LxmAw+xDqXDEI7QE8M+f2nc1X68brGXSYJnC/cNCvvwL
	 CP17oWk+FgLAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Apply mandatory recovery delay on return from
 D3cold
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708152650.536604-2-mario.limonciello@amd.com>
References: <20260708152650.536604-1-mario.limonciello@amd.com>
 <20260708152650.536604-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:38:48 +0000
Message-Id: <20260708153848.934511F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Per the "PCI Bus Power Management Interface Specification", rev. 1.2,
> sec. 5.4, there is a minimum recovery time between programming a function
> from D3 to D0 and accessing it.  The spec does not limit this to D3hot; it
> applies to the D3cold to D0 transition as well.
>=20
> pci_power_up() only honors this delay on the D3hot branch.  When a device
> returns from D3cold, platform_pci_set_power_state() has already restored
> main power before PCI_PM_CTRL is read, so the state read from the register
> is D0 and the transition delay block is skipped by the
>=20
> 	if (state =3D=3D PCI_D0)
> 		goto end;
>=20
> early return.  The register value is masked with PCI_PM_CTRL_STATE_MASK
> and cannot represent D3cold, so only dev->current_state still reflects the
> D3cold origin at this point.
>=20
> Apply the delay based on dev->current_state, ahead of the early return, so
> it takes effect on the D3cold to D0 path before the device is accessed.
> Use the device's d3cold_delay, which the platform may tune via _DSM and
> quirks may raise, rather than the D3hot delay.
>=20
> To keep the existing D3hot callers unchanged, pci_dev_d3_sleep() now takes
> the delay in milliseconds and a pci_dev_d3hot_sleep() wrapper supplies the
> D3hot delay as before.
>=20
> Reported-by: mrh@frame.work
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708152650.5366=
04-2-mario.limonciello@amd.com?part=3D1

