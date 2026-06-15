Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B136DA03
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567934; cv=none; b=n/iMdNd2py+IjyO+szft3Llu+qoaYWXL6L4UpTmYV+IqQ7mDXxZJL4OH/gz2RE/va+MUhbtF13HUUPVFMrtYBgmkVXBpurw6ueA1H2oMK/EAc6apbgN8sQXpMZDXuD65QfgSDN4A0rKmLppp/XrWF0/70RnvMt/O8dQaQQKkt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567934; c=relaxed/simple;
	bh=DS3qLlHNchKvQz95hrnuEsXX/35ktkkziinPwZ7QDto=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m/ZYYNj4ZcZW7XQZ++/P3UWW/I0xE21Uzir4LpHpy8+GjegBU6EpAeotJ3eMyq8moSB4kOrBv1DwuYxaDFQzN7UyxvOxIoOaAgMWL2+Df9GkaGcpkrfMTqwH2aeju+RtvR/Ovp4oPZpK/Rppf9jhY7mhvftpddP4rXTT7arcy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWasMV1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWasMV1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404C51F000E9;
	Mon, 15 Jun 2026 23:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781567933;
	bh=DS3qLlHNchKvQz95hrnuEsXX/35ktkkziinPwZ7QDto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWasMV1SaC7XY14FQenru3H5cuCmPDOZHyY8JtgSJseCNcD6JHml608g5XFbKsBPG
	 euOAmZMew2Hn4gcjCI4ECaHQkFIoBBLSN0RyVYlLK3AgRIpXtHE3CG3HyWHxBvbcEA
	 N8IuUGbRfVKapOfFP7BqKVBG0pKNUgumwPzGS7opwDB7OQS9Ije0pEeaSSWH2MidjZ
	 EAoKC3PwasTndIJPQS5A3f9RXJ3uRNtsuzT6K7kua0aq17zULaCx+rXYNEm+ivXEmJ
	 NdED75LOU+jbzoZ8TZqaKKtuMFOOZi9gTzTFhqxki8dIm11u9NxG00PWnzKPZT31d5
	 FENb455/Ng4xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] iommu/vt-d: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260615235037.259909-5-praan@google.com>
References: <20260615235037.259909-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:58:52 +0000
Message-Id: <20260615235853.404C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Update the Intel VT-d driver to handle ATS configuration and enablement
> more strictly. Specifically, update the device probe to fail if
> pci_prepare_ats() returns an error. This ensures that any ATS-capable
> master reaching the attach phase is guaranteed to have a valid config.
>=20
> Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
> fails. Since earlier checks in the probe phase preclude config-related
> failures, any failure during hardware enablement is considered a kernel
> bug.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615235037.2599=
09-1-praan@google.com?part=3D4

