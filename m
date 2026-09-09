Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E348E0D1;
	Wed,  9 Sep 2026 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941139; cv=none; b=VEtJfolf4X32gn1xzy/OyFEkvV60CDWVomXHEir8n9l/m2pZC2N3EIu0ph24xZnH35GpEoKIbxm3y91JMuz6Cn2omoCa9oEo7iQVEVyYz74uK2Ba1BHsaqWeC0nXCHBru5bT1I8zxK+YBIai2ZX9cvyToWpaYZfIFjYmIRSxLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941139; c=relaxed/simple;
	bh=RRlL2cifENblyHFerMkgprPIfvcDxXUtS6nTRapuMhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dw5EbO4yjtZUpB//FlYWG/deYIWCPsagZwKMDbjledvqO6RGwrrwtPnxCEFCf7F2gq8JozYDFiv9jKAl45ZvE8lsxQXbiIVpzBpCFSU20jDzPc+qNn/8carSXrsT6kRiJrVA1hAbg1qTX8EuAyZycteK+31Uo9eCDz4oPmOicvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xho+BKqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xho+BKqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70DB1F00A3D;
	Wed,  9 Sep 2026 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941137;
	bh=RRlL2cifENblyHFerMkgprPIfvcDxXUtS6nTRapuMhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xho+BKqriz6XN8j181G+DeyK9voLe9Fs6f5QuUx8hcEgGuTSePR98I5PldpaZB/Bf
	 ymxeBJZ6zikIjFaYSxRLqLashrM1kx0yl27AClR1sx0MtOZk3dwQxmZurx02WJwLOE
	 DeMt7SzkM8GElGK+s25hSKD6eYJg7uMxG+V0hpJl5Nbv/fyAOCPziz61Tw9YboHre4
	 TSLPKrTVpzhaMdtRpI/SE3MVTCSq2tMGNDmmpo/RnlpeYK9avEIF5NDV++UjJcXoI1
	 ooZgym4C+LL0kn6MUVm0k1lbeOQRA3Ff4QWYF+u4+l/bLD20+1UruFkL04E/SVE439
	 k8L0fCMU80dbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/10] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260909080114.591938-2-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:05:37 +0000
Message-Id: <20260909080537.A70DB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D1

