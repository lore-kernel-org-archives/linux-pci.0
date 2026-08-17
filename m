Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B13B443F
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998926; cv=none; b=kSusIgxsOT5hxDWr5Kb2k7RyHyR4v9D7fGue2Wqnq2e5OV8Gp3D4bumLys3haBmvslejHz6KIo8S2gzGfqBM6Mbc4jNLGRPFrXaITzyhPIngINRBTwcDGuUnts+8tGBs7o/g0Pg9oIefSgFpJvGq29zOt7QcxF+zKqhyWI0FHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998926; c=relaxed/simple;
	bh=VgK1QGjqXzBHJ1WsVcKuuHt93RtP3a6RYOg02TVuumg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXctgqg7u21JPHv3FPEmyvPbi7pgxVuGZ3LlfJnw9og5gGGJBWikApIK6n4iG+j0imjCB3s8PeUbCJG68BCtyVEOyBYdydyIsKSnOtqJSGic9ji09xripQ0827yRY4UPAPi4N2+VyCP1kybYa4Jom3NIPjWb260MkY2d4vvTmY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSMHtiyv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSMHtiyv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E0F1F000E9;
	Mon, 17 Aug 2026 20:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786998925;
	bh=VgK1QGjqXzBHJ1WsVcKuuHt93RtP3a6RYOg02TVuumg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fSMHtiyv83Eo9QPcTDLLNWE2pIsWVyPpntjRJ2K6j773HajyEtye7O6MxyzARyNCt
	 cEx/zaIw299PpTwxPXDAGwavDLUW/mPrxYgjcLoRghWn0SWlvxeQ5R5+E6rQob2XQ3
	 2pQYZ28cPS3pEMx/4/n5rH7oTuZ16O0P2IrZr1Rgq1ZULl6Jsi0pORYTfwEQnVAQ+3
	 qUPLhyqDfZy/nw8O/1OD7WF8WuKKMSFeS391c6tgg+hQ9P4LsKeynsSS47QsOyA63O
	 ktW8GwzWh15cJCopizhq4vsABS41sZTPBTji4iVESzVPURlCDFRJMr0v25uG3aVH5q
	 IgsrhzK3bA6xA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: Ensure ATS disabled via quirk before notifying
 IOMMU drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817202823.2172548-1-dmatlack@google.com>
References: <20260817202823.2172548-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 20:35:25 +0000
Message-Id: <20260817203525.91E0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Ensure that PCI devices always have ATS disable via quirk before IOMMU
> drivers are notified about the device. Fix this by converting the
> existing quirks from final to header fixups and changing the quirk logic
> to set a new no_ats bit in struct pci_dev that prevents pci_dev.ats_cap
> from ever getting set.
>=20
> Use header fixups instead of early fixups since not enough of struct
> pci_dev is set up in during early fixups: quirk_amd_harvest_no_ats()
> needs subsystem_device and subsystem_vendor to be set.
>=20
> This change ensures that pci_ats_supported() always takes quirks into
> account during iommu_ops.probe_device(), when IOMMU drivers are notified
> about devices, and that pci_ats_supported() returns the same value when
> the device is released in iommu_ops.release_device().
>=20
> [ ... ]
> Fixes: 3f1271b54edc ("PCI: Mark all AMD Navi10 and Navi14 GPU ATS as brok=
en")
> Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Tested-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817202823.2172=
548-1-dmatlack@google.com?part=3D1

