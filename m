Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA5484235
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051123; cv=none; b=Fjk75+7Y7Yj2zSyV2D5pXuL0YnnoQ9cEvUzQzaiV79pF0/lEjb0ClAEEfJiPaOcoS1ybJE0ZFlcnPvlJrGNlPvrH7oxpWvWryu567RMi1eJ0kTdAxT81LCJHY9aiaow0L7X/i/KPMlcGxKgJGQIpm1x8GqMe5o7ZI1UJUB4FDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051123; c=relaxed/simple;
	bh=pNastQJio8atJkxO8pk9uSVpyj6UTuGitW2w5Ienp5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwi9v7ZefaD3ydqjRih95sRexP/zy3daq6jOKeG5I8I6l0kn2RnsW2ATIDiTKscH2xhetyrx9E7e0k8ncqNhCrEW7MPsAxOhwjCa0y3NRv0FPmyVlXqZ2D68YbRuJFbGDKfO8WCxg9fnW5QRqGszgkFx/19BYus4h2OMD6B6ZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpSUopvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpSUopvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C91F00893;
	Thu, 10 Sep 2026 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051122;
	bh=pNastQJio8atJkxO8pk9uSVpyj6UTuGitW2w5Ienp5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TpSUopvsBZquL5pfn+K11TvofQ0NWEQQ9GsvLPkpF7jm+AqXhxTxFFYGi32EHzV0h
	 DNqULvc6Wn/n2Appflc0N0dbjOId42pZ/bzFC7kkfnyrggg5C4kzer+wGCfm//cJeG
	 0v75gj5i/3T7ERjJbLrG7+qlMQ/NcZrXbq2EKpBrpQCNevsdRC3qbP2BQXbnM+d+qC
	 eqaKYaQjHKljhM669hmVYYsH7A+Atn/1B9+LyDqntm6Tdx0GnFgNO3NsguZJFwUwfq
	 PcFJ5PF/vIDG0/6soRF0L4WtBOXcE/tq5Yx/1a9GtOjzBRJWtMTcduca47+3oxO5VM
	 Tt9d8VX9bT67g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] iommu/amd: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910142655.3281464-4-praan@google.com>
References: <20260910142655.3281464-1-praan@google.com>
 <20260910142655.3281464-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:38:41 +0000
Message-Id: <20260910143841.E38C91F00893@smtp.kernel.org>
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
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142655.3281=
464-1-praan@google.com?part=3D3

