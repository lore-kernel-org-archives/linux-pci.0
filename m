Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6533E367
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848742; cv=none; b=g1UQ3tUYetDtfr3K6S+PcJd2TJQlwfKmjhH0WD/vwTUbmwUdpIEwDOKED/YdMeIrq04xj1tCqyPto+Ze/UazqWuIShztW97aN6yHkizI+fXfGKMOLcybpbO2SN7gyvyMk9Xidn8jstaqlK+rIT/cgztZjuozn/4Dh/Lvh2TgQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848742; c=relaxed/simple;
	bh=u8vTQBBDKI9QDM3bfM4fcJTC2oUv0buHBN0sDbg880w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=splUKFLDQOU0T4TE7o8qPSqeh4sq7B7oCKsqnMhEycRcgyESP34T9KRL/FXq7Ic6gjCr7J+SLAdtHluIcnIqF2ytEjutkTjD8IuRJ8fz3/rmSr/qw2hoUjR7M4ZR9omXT9jqLVfX837SILsSArrOO5D2MQwTD0ArQt8wOYPvhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdP6jHe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdP6jHe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E381F00A3D;
	Tue,  8 Sep 2026 06:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788848740;
	bh=u8vTQBBDKI9QDM3bfM4fcJTC2oUv0buHBN0sDbg880w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EdP6jHe043IPIsKsHdSiGj0CxZTikcx7KgL+jMsUwWCwyoFvGP2AkmjvlFnskmDKi
	 wWHOJGXryhQY80ig92uR3KzgvI8AaLyFyjZ7zBuAQDBmwzV48H+8AZUXp0Ulm3xBfy
	 iJ+/fgkFo9TmTkL6QbBU0MHolaYLB8gZU85XUgJA++oV2E+ngJEM1cJuWeGSemyRW1
	 nP1cZ27lOt1HlFa5SgCcapA/0zIkg6UIDhOmefE76WjcA6oi0miQX5brBg4xRv5Tsh
	 QfGMuudNP0msn63sptghdO8cGTe/jKdKYp+dgkbJT/AVbv7kAcyqvUnv58pL7GhuV4
	 3TUO8/ur/btSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sumit Kumar" <sumit.kumar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:25:40 +0000
Message-Id: <20260908062540.81E381F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An outbound iATU region matches any local (AXI/application-side)
> address that falls within its Base/Limit window and rewrites it to
> the PCIe-side address programmed in that region's Target Address
> Registers before the transaction goes out on the link. This matching
> does not distinguish CPU-initiated transactions from ones issued by
> the internal DMA engine (eDMA/HDMA).
>=20
> Example: outbound region 0 is programmed with Base/Limit covering
> local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> CPU-initiated accesses. The DMA engine is later given a descriptor
> whose destination is the host address 0x8000_0080, which happens to
> fall inside region 0's Base/Limit range. The iATU matches the DMA
> transaction against region 0 too and rewrites it to 0x1_0000_0080
> instead of passing 0x8000_0080 through unchanged. The transaction
> then lands on the wrong host address, causing data corruption or an
> IOMMU fault when the rewritten address has no valid mapping.
>=20
> Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> programming outbound iATU regions so only CPU/AXI-initiated
> transactions are matched against the region; DMA engine transactions
> bypass the translation and go out on the PCIe link with their
> original address.
>=20
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-dma_bypass=
-v2-1-c3c81d408c0c@oss.qualcomm.com?part=3D1

