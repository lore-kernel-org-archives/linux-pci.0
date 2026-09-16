Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC913449B3D
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546170; cv=none; b=JuQbVnYhXdf+ksRURgxNQ3Wr0D1ea2aTbkE+0UhnICKdJBoRM+z9RnBc1qnlNeql79UkgkPHC/DlXMDR4txhq38Pemrh97dQ7qhbeuIHTmA74vVO3ZAV1ZXFDkFQ2WSJyepq+/eHN0JnLHzpyDUjFOfYB1PQRO/wC+SzgH52o+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546170; c=relaxed/simple;
	bh=24QgA5wCY6OAX4hC/N7VXZvx4ugE1NVCDxIExAP+Hsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UGMa38w6vVZqh56Blu0TTuWGaoMm+BqFB2YtHv4K4d7wYMuCiGcMrOHrxUtix4EHbb0OFwEALnTndgZccJAGM1erE4EKxkz1wsc6ms6kGP3irO8e0tKpY3dvNPUZRQe8SyFAmmMw6VeKC135lNvhfMG811aqpUnNM5WMLt7f1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1kfErnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1kfErnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C88C1F000FF;
	Wed, 16 Sep 2026 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546152;
	bh=24QgA5wCY6OAX4hC/N7VXZvx4ugE1NVCDxIExAP+Hsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1kfErnxXQWtyhNGr4ob80m4El17fvnMxzhMcexXzEcxJhqXgAroLlMxg4/pvfgU0
	 +WIteB2MweIA3wI1R3LnnS9JjjP+P+lQmNb3ZzLwQgKktTP6AxfM+qWDa1kumxjQaV
	 lsK4zr/VguImePuZeDYC0xWUAIiLAIcjRI4WShptnXa15vIbnKgpDNnp55/zNkvAwv
	 5ODKFsxk6ZsMWGZNti2MQ11IQnIcAdiOwutEFpgbnQD/iJrETMnn1AkaPGy51wdIvy
	 jFTeTzWHpqjbtkmuc48tXyWrde0rEvwwYH2j7RA4ptdPTFtsojkcsnNRb90M/kTJwk
	 XDaSoRmzKFCog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: keystone: deinitialize endpoint on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916080030.2960608-1-lgs201920130244@gmail.com>
References: <20260916080030.2960608-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:09:11 +0000
Message-Id: <20260916080912.0C88C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> ks_pcie_probe() initializes the DesignWare PCIe endpoint with
> dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
> when endpoint register initialization fails, but the remove path does
> not perform the corresponding endpoint teardown after a successful
> probe.
>=20
> The successful endpoint initialization also calls pci_epc_init_notify().
> Without the matching teardown on removal, the EPC initialization state
> and resources allocated by the DesignWare endpoint core are left
> active after the driver is removed.
>=20
> Notify the endpoint framework about deinitialization and call
> dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Pl=
atforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916080030.2960=
608-1-lgs201920130244@gmail.com?part=3D1

