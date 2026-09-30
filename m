Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A494D4878
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780327; cv=none; b=c1C8enLB9765ksz5Uxg1+5BMqbcpkkXq8DdtNKCcKXkMD3vQ08SwkCxlhSBaW7GKKmrHshP7lk8KTn2DVzeHiU0ygjXiv7WGnFMlKLzjrR+XBZdfK/qGd53sA17A36xikC3qj9c0Is+cABV5gFGzxYslYvSU2vob9vaLumoo+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780327; c=relaxed/simple;
	bh=zIGpFfglAWx5XQSEbAytj6EfDEHszOPr68F0r8Op8Js=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Si6iz2gReJniiQY6l7SY1HztJ9W0HwW9fxbCml6ElVrr0AUH6mI8ZoqNEeucFCWNHQuWi2Re+wbhZ8/YRRjqW4TvguZq+jbat1IMqHNW44K2fdD6OD4B1nJPrGfutKzWo7s8Zq5zdcKBNIdOaYNmM9H4K+uCFJMasW0iM0ZHfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Kzxnux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Kzxnux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A731F000FF;
	Wed, 30 Sep 2026 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780314;
	bh=tFj9yR3EXVaeVdREWg0XI2y3eNg2mzE+ylxexSPDH/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e1KzxnuxG07qlr1S3sfMl02qxZmyyUpZH9fdASTPMCTtXHL+3ctVdE1Vbs3i+yOtb
	 A5msLb1OPELHFxUwAWVfoDyFEpRx8BMxZ2+Fj5t6YFJVbYBWOvTRxJuwRUqhpoXu0L
	 mfYXtidFGtS2vmIVRVgGSnCfVxycRc+qpxA5jKs56/kyjm530a7rogvN3+wKLXyGEM
	 L1c5OlA6FHB+2pO83ER+Uts/5Y67f3XT2Ig2v7AHCxhmfkAL7zitoV+0RgToNyKGHD
	 zYgD7SM63as5/aFrOZdS4DkxzLCEZqKX+Yae/k5ru81JgnER6VucuxQE1REqpeWRFW
	 7RQAAqWskTccg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] PCI: Update saved Max Payload Size in
 pcie_set_mps()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20260930145017.1356088-7-cassel@kernel.org>
References: <20260930145017.1356088-6-cassel@kernel.org>
 <20260930145017.1356088-7-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:58:33 +0000
Message-Id: <20260930145834.92A731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_set_mps() changes the Max Payload Size (MPS) in the Device Control
> register but leaves the copy saved by pci_save_state() alone, so the next
> pci_restore_state() puts back the old value.
>=20
> The PCI core does change the MPS of devices whose state has already been
> saved: pci_configure_mps() reduces a Root Port's MPS when a device with a
> smaller MPS Supported is hot-added directly below it (commit 9f0e89359775
> ("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")), and with
> "pci=3Dpcie_bus_safe", pcie_bus_configure_settings() can do the same when
> pciehp calls it after a hot-add.  The Root Port's state was saved when it
> was added and again when portdrv probed it.
>=20
> Since commit 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root
> Ports in a platform-specific way"), pcibios_reset_secondary_bus() restores
> that saved state, without saving it first, after host->reset_root_port()
> has reset the Root Port, e.g. during AER recovery or on Link Down with the
> qcom and Rockchip DWC drivers.  The Root Port then goes back to the old,
> larger MPS while the device below it is restored to the smaller one, so
> the Root Port may send TLPs that the device treats as Malformed.
>=20
> Update the saved copy of Device Control when pcie_set_mps() changes the
> MPS, like commit 909f7bf9b080 ("PCI: Update saved_config_space upon
> resource assignment") does for BARs.
>=20
> Fixes: 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root Ports i=
n a platform-specific way")
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145017.1356=
088-6-cassel@kernel.org?part=3D1

