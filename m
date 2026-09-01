Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B63343889
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223810; cv=none; b=l1wJtYwpYi/vGqIPJI1Mh58WnvETcqSjeeQTJS/UtSDshoFiEExRzZM22MvxeDURLkbQBrA78zG0AOoNboPaZnIWQZTJUlKHCMF/fdcQ3j9KLcbdgpTFk7NS2Xx5EkiRE69tm5TMvk0EH2DLBkAdlJZko87MFWDSUYjtTleenKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223810; c=relaxed/simple;
	bh=t3QToh7QfUF6qgMBi/wMpvldii5xZ+t87qfpYeihnxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NddJ7gx34xeQVUDpPjTq6NQFBYuKLVOcptnanNv3vAiBx5hEUjQ5fzl1LWZRUagW/Rs49aUz4XmQFsTqc202sMtdTEeRmqvHzt/he/UABNXlFaVNClY2aMwt6mKAo0VNY1nmPTEZMPrByuXufXHo2wHPmEzHjHow7O8/K5/ioDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR/FpV3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR/FpV3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972611F000E9;
	Tue,  1 Sep 2026 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223808;
	bh=t3QToh7QfUF6qgMBi/wMpvldii5xZ+t87qfpYeihnxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GR/FpV3tuASQz35Piz90WUdw6nAzd/f0yUosk04s+FN3obrqbnH3u0MRFJumUXtfP
	 dB0lyqcGaVorrJpr5HdDgq0a4t/NuB9SdNLb9dGaAYqugDM1KttQTSZ1q10R1WJVfB
	 XQsk/w/whg4USLBacRMmS0J25DcpkAq1jFaN1wjw6AXck1Fpks3vJSUhPPUoEBTbwz
	 XEpDdtqd2C0/mebFK7dh2HbOjKq0yQ2cKBHo13c2OLAQ+muvzKSt2A/Qkm+br6uHqa
	 cZLroh4CSscWjCfU5cqbabo24c0Y4yQjPnNulYQI9hBE33uWh5467xGpr12FWbsbvL
	 6TT30bEi/s00A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/13] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0fe5f381aae307045e4cab97f8000c575f34a9ee.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <0fe5f381aae307045e4cab97f8000c575f34a9ee.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:50:08 +0000
Message-Id: <20260901005008.972611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Now, arm_smmu_page_response() can issue CMDQ_OP_PRI_RESP for page requests
> from the IOPF infrastructure. Forward PRI requests from the priq into the
> IOPF infrastructure for PRI-enabled masters by building an iopf_fault from
> the priq entry and calling iommu_report_device_fault().
>=20
> For an unrecognised StreamID or a master without master->pri_enabled, fall
> through to the existing "unexpected PRI request" log + LAST-page DENY path
> to release the credit per the PCIe PRI spec. Merge its two info prints in
> the path into one single ratelimited line, as a malfunctioning device can
> spam unrecognised requests and easily flood the kernel log.
>=20
> Discard any PASID Stop Marker (LRW =3D 0b100) prior to the fault report a=
nd
> the DENY fallback both, because a Stop Marker does not expect a response.
> The IOPF infrastructure requires the driver to discard it, as per the doc
> at iommu_report_device_fault(). This also matches the intel-iommu code.
> [ ... ]
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D9

