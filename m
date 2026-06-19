Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192A35EDA4
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860133; cv=none; b=tZ4D3UBvaxNW3tmCE6FZfoKtQYvJAyO4Prp8OG6xr+JXbHJFJMjG6vrtuv9ble7ZIi/RcED5Z0XscOVQa/TJ+cokFdqCHwLgHgRljS2N6SmLhvT5Zbl0dM91EAQqBtcYLJZ83bXJz6zOG8ucO9WZpVjplT3XXHHdyZHn1zD8LkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860133; c=relaxed/simple;
	bh=FhXvhDSucXwQ4+iNFThpzgiyHRQsZLzNFXlxaE7dVM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TwtIY9JQNZX+n9ICULFuK4Wiqqc4/RHkkRJaiXZz9rMFnwHGdR0OSP+tj7qeEfOP6iseEEFUvPU8HQdF4N3jACjJDr74C9buMx8SGXuP/J94CHg8jPJIc7S/ztmkZ45wVcFC2lxZDhoUeBxrDeFHwWXylilNnFPmi3ZurBjLjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYyKNHrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYyKNHrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7CC1F000E9;
	Fri, 19 Jun 2026 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860132;
	bh=oXLLHNudBvxicm3gWDwkVYKG8jihg7X7irvW2DaZtxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYyKNHrUgwxxCK4gXL3XMPylZC0T28J/CKGW0JUHpJrpz4+gCMAl6NvEugiXJAXX0
	 7uiZS7OhcmpWalPT3wxmAmR0wi7Pv8m1Xsu5jRl5JoFOcQZeSoRAgPg79/26M9Fp5m
	 Wnk+P0iw+58FHoH2ii7/JJqhhZ2jlxyo+KamabWektmu5gZ57OR/KSTAvTMWUCSyQl
	 4BkYZxGcZBl77vMzIhF5VCpxt+Vz58Ojix53J7GxKgwHGV3Bo+GwB0uOpJQmpRDIDd
	 u644+eO0EFekWnxCLjJvd/OwUF/nuqJWfL0PXgh2Z+J7BNXfVs6pRTkZBbuUWMYWSb
	 ynOQBYf+7sF4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/25] PCI/sysfs: Convert PCI resource files to
 static attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-8-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-8-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:08:52 +0000
Message-Id: <20260619090852.5C7CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the PCI resource files (resourceN, resourceN_wc) are
> dynamically created by pci_create_sysfs_dev_files(), called from
> both pci_bus_add_device() and the pci_sysfs_init() late_initcall,
> with only a sysfs_initialized flag for synchronisation.  This has
> caused "duplicate filename" warnings and boot panics when both
> paths race on the same device.
>=20
> This is especially likely on Devicetree-based platforms, where the
> PCI host controllers are platform drivers that probe via the driver
> model, which can happen during or after the late_initcall.  As such,
> pci_bus_add_device() and pci_sysfs_init() are more likely to overlap.
>=20
> Thus, convert to static const attributes with three attribute groups
> (I/O, UC, WC), each with an .is_bin_visible callback that checks
> resource flags, BAR length, and non_mappable_bars.  A .bin_size
> [ ... ]
> The write-combine support was added in commit 45aec1ae72fc ("x86: PAT
> export resource_wc in pci sysfs").
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D7

