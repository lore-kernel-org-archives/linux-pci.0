Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8BDF59
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781568183; cv=none; b=kaUJn/6bwdEWUPabFOyRqB0aUqvGIUXyFC20ULjnf09GzZAvMzU10qK362EX84SGIs2MDMqOZNKq09svp3WJGNb34SCHjqbBuiq6geTpO8Im+k2H+YXb/11fLvioDiXuMT6KjvnZwew8o13SV652USCNFAN141xY2ssr0N9hmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781568183; c=relaxed/simple;
	bh=Ojkpc4t5L1PwboFiD8BMmPBM+TPHHmoEJTKy+VibzXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bQcKzuiAGBCDQnE1eloaWxszoYv8GRIM5PvuF5FdUnxnqSrNGZ1OWasME94y0+jce9lrs76wlUVW0REqU/gujy//vUiA9G3i8bEy7cnHgLkWivM6IzQOQnonTkLsqsVqcVr3ScfjcxX9kFWS2OosS/SvII3vPyaocJ2A9+dwmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIGohnMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIGohnMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B621F000E9;
	Tue, 16 Jun 2026 00:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781568182;
	bh=Ojkpc4t5L1PwboFiD8BMmPBM+TPHHmoEJTKy+VibzXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIGohnMKE7QTJDCnxDtYLCF8IG2P+noSImPMwgpws2/FtC0y+kmyY1o4D+jgSfckD
	 y0w6EK2hJL6rV2MLxkQlJ2/7fegvT/UQDF4+tj3LY+n3cC5TAhn30T366m4ONgfSek
	 jQcHLI/awSJb7l5ZsbcyV5QxWXjxdyVfLAi69CsmpY7aqSsTzreHBnU07GbeIdVdNf
	 LBYYxpv3O1V/jDMD0cyJa9ci8j8svjghUcfFEye7/kNKZZBtKCA09r1B1ZMok09lLD
	 zYWMlCw8usYyEFf2heWs7hXtbPnE93vivkYiJN7vdxhbXce3K/LccMY3V1iuFFh9Ag
	 hPSD6gqGWF3bQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260615235037.259909-2-praan@google.com>
References: <20260615235037.259909-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 00:03:01 +0000
Message-Id: <20260616000302.01B621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Update pci_ats_supported() to additionally check the associated PF's
> status when called on a VF. This ensures that PF-level quirks and
> untrusted status are correctly propagated to VFs, providing a robust
> support check that aligns with the kernel's PF-centric ATS configuration
> model and is immune to the timing of VF-specific fixups.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615235037.2599=
09-1-praan@google.com?part=3D1

