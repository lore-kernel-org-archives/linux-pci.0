Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FF371076
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223672; cv=none; b=WPZ2ASodjPPA67sXkPc9ixeauEnTOufyoftBKHJUE0Ii/aV1+qPP1rquIiyghLj54tF3ziFFg7v+5iXiyV+PbT9r5GHpoVtZmJq+nb+lD29fq715qpmJhFGdOKEYoIoI5h2j7CMbrknKuzAtTzGtruAL345eBCe63o6wzHf0Lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223672; c=relaxed/simple;
	bh=hi22p/xcPonsjDCHQ2d4Kko7BcOgS+xTftqZl6PbI38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8S30vuLbn4go63c3pFr5cGL4Jw6CU+/JOMAfY4dZz7d/m+VU8QF2kdhJOOvBKXbYFBlXucd0sfKMxRSynatJmiOXBg4h+o1kG5qyVQTZYg2fGQYtXrRnahxrPSlAni+dIOYETvhjQjW7MT2IN0JksYcC9Zi6Hff3rwvVIeCJLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdlxFUnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdlxFUnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F221F000E9;
	Tue,  1 Sep 2026 00:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223671;
	bh=hi22p/xcPonsjDCHQ2d4Kko7BcOgS+xTftqZl6PbI38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MdlxFUnEuARmByU+pe4vBpGVS+7uce6UPrFdcgIW6dUOSRV6gL0j4HG2g3e0cbMJA
	 1v32rjYP2W+N61yvHcWhX+oYU0r5OMsOytNdLHf9nvSjyHTJXs3IP4+AmIj0C3Scuz
	 IGfmMdz/YRaPnSo+x3Vn1mcBUreXCOcCRsZYNh52eVwGzFKD0pDV+C9GI8QcWJ/GW/
	 wwpeme7k/FCWResy1E3wh6BGBCLgWDtg32JHCYEILrg37FymzpcAI3BLx2CgWe+K19
	 ShytonvVOJ4GtuIZtzYqpthDkrJkcJqVTMrzmqLIFZOW/gRPx2sI3nn79AQdK9QSMT
	 JJChnSzrt/TPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:47:50 +0000
Message-Id: <20260901004751.33F221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> arm_smmu_setup_irqs() has three failure paths that leave the priq without
> a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
> the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
> Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.
>=20
> With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
> against a handler that does not exist, and a later change would then have
> arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
> them to issue PRI Page Requests that pile up in the priq with no drainer.
> Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
> it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
> regardless of what setup_irqs decides.
>=20
> Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent co=
de
> treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> returns.
>=20
> A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
> features, so downstream PRI setup is skipped.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D8

