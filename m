Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7E329E55
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676708; cv=none; b=gIJdsAPN/JD/1FXow47CR4w6MR98XqKm53ue4RAvDLWakUEDSIV2X43D0N7DvxKZpQ2xVADBrKdPQJkM+AWb6dMBBkL53PVryRX503SRzoOHM1Tq/eOLzfiNdd/1PgGpBRLdKPgX0kZQxCiDYqOBOA4pczBzwBT43+W1X5zq/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676708; c=relaxed/simple;
	bh=Wz/gN4dJJwORhekhHvB/+H7WVrtHpg8sbBEIRVrTVeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mW6JtdKyv/COllbmgEZZq7U880g/SUlKc5T2Um8EBRL3CI4mjQSYYQr/GgQmaymRm60qlFj9Wh0Y6Xf7YtbLjc78nqvxPHFdEMOSgqNPYax/6XN3ZS+u+fbJMGclZIzPClFPmm6BebrI3WQIO7GHsNeB/+18mxvrCFUhO1mPkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/iRboay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/iRboay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA611F000E9;
	Fri, 14 Aug 2026 03:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786676707;
	bh=Wz/gN4dJJwORhekhHvB/+H7WVrtHpg8sbBEIRVrTVeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q/iRboayd/tla24xEXPIg+aa9rg0lDbKu/s0Jpl+bV6H9AxF4+8YTT3miFNvkNune
	 1sO6989Vffq8FHbp765piBNmeMs85jNxyZjYNEQNszb1dJyoybLBRI80jSAKZT87iN
	 OYqvYh9Le/nbQebWztseyhTva1YcnYsMpJ4R6s3EcjvnOhd+li+YL8hmw/kQnjpZXV
	 A/vrm0gqFnyDE7pen3FPMvkhMrdxqs9M6W6y6ztmG46iJ4CkpC51Iekp7o7s+MpjWL
	 b7LG/QyMEU9O2pwrOkF2EyBoGK/E/Nh3WQQhsmxQeKoQCPCOMttEJb9RbkWP/gbPNx
	 IfqCT8dgYNYvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] iommu/amd: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814015647.3370124-5-praan@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 03:05:02 +0000
Message-Id: <20260814030507.3EA611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Update the driver to call pci_prepare_ats() after checking if
> pci_ats_supported() and fail the probe_device if pci_prepare_ats()
> returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
> a failure in pci_enable_ats().
>=20
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814015647.3370=
124-1-praan@google.com?part=3D4

