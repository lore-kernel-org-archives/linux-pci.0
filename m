Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA74B5CC9
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491581; cv=none; b=odL7oryDuYl8hVIG8pzQmQGXR4H7h3YCrJ6y3QB2i9SnCKA2pVeq/AAMqwr1ZvcoWisPCEHmJijOfDiK+7OXvzgNwkoPHZyCqR+Au+PUiOo3LbtP4wjmTF/RwAQ+igIHi70uNSMc6dqj28RPjlGRuNAE28BDzP3sMDeFxUiV5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491581; c=relaxed/simple;
	bh=BEEQ4p1vTy/vWO+q4kDzTO2dEPO8Lr1nb8wlFV5hjHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XgpL58rycqwErRvnXpn+7yOjQmlWkMaGpTnX1bcPMwVMQ6/EOcVROFTh0926jw6L5Ef6g9gzF+gYaZ/dbHmt+yjianCDHsmE/6amjIgZaQ6InitVJNyV0Wp9p+PIXI0qxvRakj/gkvnuPxliNsPe1reWsD7XR9JlcwmG6mkcPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgwQgcmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgwQgcmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37A61F000FF;
	Tue, 15 Sep 2026 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491579;
	bh=BEEQ4p1vTy/vWO+q4kDzTO2dEPO8Lr1nb8wlFV5hjHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MgwQgcmGFFXR4pTfHm+jd61bDSWgNN1eME/gpBgWHlmGRdhN4aIDQF12uaLLQoUab
	 THYWlsPBh7QgaQSOBAaHuZkJBA27goxavd/r/zcRZwsgNjMzK8bMzMq5A/lfuDjW+Q
	 Nscx4bG+DMLLihxepxSGpC+z5kHpFFwhv1blUa+ifvQCDwHELFegcIQ6TNC44sVNXa
	 3gFEMU6X2zd0LNG4m8+KRSsagsbn/BANmyQ3+8SNXm+g6k0YjlNZHOWZ+86EYW6kpY
	 DuF67Dhc+5UtWABgV6r1zUh+Eh3otVfXHRDc25bq0GNa8e9fAoMFmF+mdBInnCADGN
	 4E1pwyCeUs0dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/15] iommu/arm-smmu-v3: Enable PRI for PCI device
 in arm_smmu_probe_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <14fe7844fd493be5edac1846e99fa7f289ed7536.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <14fe7844fd493be5edac1846e99fa7f289ed7536.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:59:39 +0000
Message-Id: <20260915165939.B37A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PRI handling is now ready. Enable PRI when probing a PCI device, and drain
> the PRIQ with the EVTQ when an IOPF-enabled attachment ends. Queued fault
> work may still refer to the old domain when the detach call returns.
>=20
> Note that PRI is enabled at the probe time, while ATS gets toggled by the
> attach/detach routines, so a master could have PRI enabled when its ATS is
> disabled. PCIe (Base 6.3, Table 10-14) sets no ATS precondition on the PRI
> Enable bit. Its only ordering rule is that the interface must have gotten
> successfully Stopped prior to an enabling, which pci_enable_pri() already
> checks using PCI_PRI_STATUS_STOPPED. Also, a PRI-enabled device would not
> issue a page request until it starts to use ATS.
>=20
> Set the per-device outstanding request budget to the full priq depth, same
> as intel-iommu's per-device PRQ_DEPTH choice. A fixed per-device cap won't
> prevent multiple PRI-capable devices from potentially exceeding the priq's
> [ ... ]
> StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
> error-response path.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D15

