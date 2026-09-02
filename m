Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D134432E60;
	Wed,  2 Sep 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356836; cv=none; b=GtkgXpOWVs1OqCRs53RH06BGijpo+yktGd9vHJTvXb/ZEv+8YXGmh+ObxlSvmveP6jN7PtSTKHpBhWWA1jcYnHZsTxgzX9kYzRDrYxcvDVgMnT+ltQQ4B4yeES52WsiPpGdZf+60MChzojM06MMS2nsfJ6EfsKhfJI0hJ6Q+xsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356836; c=relaxed/simple;
	bh=m3r8g/lLrllHLAWWIK74lteR+CnCLXECgss8nLnZg1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XjPZ5hAst5SKk6LRdM3o27DSEYdoCvWqE7cz1r4nDGHBD6WGKnkouJExD7Lh8CgyXLvcW2tudNjEsefUkfwWOzOQGbsaD2+vDni3dDGeeTkFu3L1nP8Sc11XOfzCasrXUV3Yo5RXYbc/rxUxVus+Oz67eSqfyMSsvTMvPqDXj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYOmpKAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYOmpKAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8941F000E9;
	Wed,  2 Sep 2026 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356835;
	bh=m3r8g/lLrllHLAWWIK74lteR+CnCLXECgss8nLnZg1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iYOmpKAmPSDMFNJMZ4y0Cf7AwbsvpBldthXd9pmhuLWIA+ft24sxBuKcC3xXNi81E
	 lx4CSt7w3wvUj0swAr8xUy3lNbqvQAsbSDmzhAYH80kMhd9TKScoZEl6ZH+DtaSdCk
	 zjP/bvga5gi67O0Mib+j4PI4HfKFpFXmjRdQRxuidINDHixC3/oiWCZuQA6LtT6zrB
	 ZxWZjNdbqTdvOLV2HrkNenlD0LUQtjg+sydgwvQF9n+a50AiMjjJgm2V54acFZ9KEh
	 +ST86w35zYLVeu/V5vlTbGMqVj4cwAl8rB18mxoxAjxXl26BPtJU/+DbxwUSYJYdOp
	 TUcDr5BVQoDOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 6/9] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902133933.2992457-7-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-7-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:47:14 +0000
Message-Id: <20260902134714.EB8941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Subsequent CXL error-reporting code paths need to log the PCI Device
> Serial Number (DSN) as part of trace events emitted from interrupt or
> panic context. Computing the DSN there via pci_get_dsn() requires PCI
> configuration space reads, which are slow, can fail when the link is
> down or frozen, and may not be safe in some contexts.
>=20
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'
>=20
> Remove the now-redundant dsn member from the pciehp struct controller
> along with its kernel-doc. Drop the pci_get_slot()/pci_dev_put() pairs
> in pciehp_configure_device() and pcie_init() that existed solely to
> read the DSN into ctrl->dsn. Use pdev->dsn in pciehp_device_replaced()
> for the device-replacement comparison.
>=20
> pci_get_dsn() is not modified because it remains a pure config-space read
> with no side effects on pci_dev. The cache is written exclusively by
> pci_dsn_init() at probe time.
>=20
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902133933.2992=
457-1-terry.bowman@amd.com?part=3D6

