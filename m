Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D813909BF
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083388; cv=none; b=arAk5pHzF4EBiwDfaxtZQgaBsobnSUoIqnxX5YhDCcHDUKerGx5ITZbA7QV1TcKu/ZMAfue0uliwR9osg7qKEAp/nYElcaVBO+eb6kaF8ZpF3w9OT4oNV90MA/JPfd/2uYZZ6B2WnRm6gCLgMw0mtcxPBkfxecyPJbHaJXmdHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083388; c=relaxed/simple;
	bh=XytW6IcS26gKhxAViEKUBTSgFsdNDsQ3XNPdZuq61+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FC6Sz5ZsT29iBwdSf1fRs0I7Q6wxpDQYOGVGRvktFV3utGoHsQQckJT3u+BxXnf17iL6VcHR/xIEY8dUYwol7psXXgO+fA3rdC1l1jT4AOJUU2COfAR6h58lR6zYej7CMoiCoHEEZRactdAkkf4c4GA25IfujxiOc5VlmvyErLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGsgV2TD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGsgV2TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF44D1F000FF;
	Thu, 10 Sep 2026 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083380;
	bh=XytW6IcS26gKhxAViEKUBTSgFsdNDsQ3XNPdZuq61+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGsgV2TDPAxa5j8lT9OhkDe7P7zfmxnSYouRVj5zTf/XZqhL2gSrVS3/pSFeSV5CF
	 dLwwo0+HmnV/AZ3w/5EGrokipkeRMMqsnKNxTj8kmmUJkhMSiqPXeG7sugrjVGr9ry
	 Va+XiQiUJIYWjJsiezUUA1KD375537mtSq4hbNTn6jlDFSKG0MHscVbgY0ebvQcYgd
	 IsLH3DtjsvxlOON+l3rk1hoMrhV+j2H7QAKJ+ZsBTNXCzHxTB+crfSJ53b4ni0BOh0
	 toidvj9xODYMZcwAvR6rnQJIJdjyZcPu5sGqhMfrdcSN5SMGfXwutBgUkwERNjtib8
	 ZEjbaGcHW+Mhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/15] iommu/arm-smmu-v3: Enable PRI for PCI device
 in arm_smmu_probe_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <7bab940a52ba306f7199108987fbcc165db92c81.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <7bab940a52ba306f7199108987fbcc165db92c81.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:36:19 +0000
Message-Id: <20260910233620.AF44D1F000FF@smtp.kernel.org>
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
> up for them; keeping PRI enabled would let a PRI request arrive on an ali=
as
> StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
> error-response path.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D15

