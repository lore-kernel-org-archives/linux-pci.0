Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B13414411
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941367; cv=none; b=HfE+s28KV7Uag5rwrALqxjLAUEximbqZpqO7U0GogbYusa67y4wZZSSEcdxNlYfv8tmfBVXFqyEHYjqKVR07uAzneYM4tuKH21SNE8BafnaACSFfBIxkHOHVse2AG+Mth7auSmRA8Th9cLX2B8mv0f8v1b+cEij+4hRWxHvnkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941367; c=relaxed/simple;
	bh=3TqCIOzkvA8Ee7grMmnh/RoirwtqO+1p33TA9gou3ic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XCn7Up+F4ssVfL5i8au37ovyoaRrXs6NHJ+Ubm2HCcJFbCdGlEDrDXtdb0ewynbKsAJoW/EfoxgKeFAYCwkL/SDXoWPTs//Avf1Oc4p23sCLdBIG+p2WDQXMXcYF/qP3h+EHZWARgVzuc/I5HQd1vROzfseKgCYcpR0VQnCluzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1B6HnFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1B6HnFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481C01F000FF;
	Fri,  2 Oct 2026 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790941366;
	bh=3TqCIOzkvA8Ee7grMmnh/RoirwtqO+1p33TA9gou3ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n1B6HnFMpRa6LSfPDIuU3QabSSiIe3rmu4iFhS59TB0/6V+/PK6GBI9t3fIZNzyho
	 vYOTJhX7eMMIVVlQuS0qrXJTqNzTCeskCW4UHTIsUx3YiZuT2hy6w1jNaS1EjYIlGB
	 FEuu4lYjInJIf8yIA/KLwTFtYf6O6AAiglbMdpviBXlNS7ENDtFxhRMFSl2FRHgR4k
	 4Smuyk/p47Mhq9lVXppGAO/fMXdXernECCOeK+u8YwdW9lnQxfcwRRZeiUiygNn7vT
	 /1hePUfHk2CshrZV7gLaLqMDtL/FOZYBcQ8asURZA5TgYlPIFRrwIMA7G2SsM0L3pR
	 bUodNrMCa1Aig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] PCI: Fix nesting windows with remainder at the
 left edge
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002113319.6652-5-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:42:45 +0000
Message-Id: <20261002114246.481C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> If a bridge window has its non-aligning remainder at the left edge of
> the window, assigning a nested bridge window of same size will fail
> because resource side code will only allow starting a candicate range
> from an aligning address. In such case, aligned address is somewhere in
> the middle, not at the left edge of the window. Since the entire
> available space is required for full-sized nested bridge window,
> resource side code rejects the free space.
>=20
> To solve this problem, PCI side code has to bypass the resource side
> alignment code by giving a smaller alignment and must check the
> aligment requirement itself. This allows resource side code to consider
> the entire available space as candidate to fit the required size.
>=20
> Wrap pcibios_align_resource() with PCI core function that performs the
> alignment checks and left edge recalculation if needed. As the
> alignment given for the resource side code is artificially small, the
> real alignment has to be passed through alignf_data.
>=20
> Fixes: 9036bd0efcb6 ("PCI: Align head space better")
> Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002113319.6652=
-1-ilpo.jarvinen@linux.intel.com?part=3D4

