Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CC37E2FC
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223911; cv=none; b=i7DMHREV8DlCa1BHGx4svtOzHPuMwovoDGliaRA5hGsy9wtBVvMV5Vk9gg7DShv2TtMasFcJSkGoucHGgxC+qaTynEAI3PmPDkJUJNfBIqsTIJbZ+nzjZXPb+5uG6wy15FbsotiR6+05axVBPUDtw0ymqxdPxa6HmuggpnoWqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223911; c=relaxed/simple;
	bh=ZqoHuDdq8bxqr9nWz1u4q3e+4FVaLeJ+V0V63ePuhE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Us0Oty2L1OPuGwhzUBTLPjzJ0k28KqPXwW1565SDEup5d046b76J0BF5oZhYjxbLs4B4xcC+mF0kCIsbqpBFgSxM0rHeJ/t8lSlCnw9QiCVuIrJYbyW0arbNvVtb3jfjyksp9mmhZp/WXKRQ1zpTYw7kRZcgPGW8YIAcUM1JPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6D3bVeg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6D3bVeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C4F1F000E9;
	Tue,  1 Sep 2026 00:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223909;
	bh=ZqoHuDdq8bxqr9nWz1u4q3e+4FVaLeJ+V0V63ePuhE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m6D3bVegIlC/7j/WREr8KxaPRmaRmLQdy1ZfQq5L6oZMD+trCwhbJZeTXeI9O/8tX
	 hBQP5FEeI4OHjecYaJ7v5/klEfc1JBUf9gSsSysoNlAfK6dBhBsQu4TX/IDGcXlViW
	 vajJ1yoe4AuExN7SKjTEAR79zk3EMO9A3Pss/YdgdC9D04vSkEXo+J47VimSZwFoX+
	 G0sp+2zki5VPWqsVkwfp1//18SN50xFBnI+1/w4BND+0tm8qDDRK1jT49KmJGiCX6i
	 ssK8tK+hnZMg9q5g2qBKBiINXowNFvAv3IYQnn0DEIZkCRnXMA5Rabh/IMN+zmhheg
	 sZSzUGjMU6rGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] iommu/arm-smmu-v3: Enable PRI for PCI device
 in arm_smmu_probe_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b0442ba9eb1598bf07782b14fbcad284bcefbe40.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <b0442ba9eb1598bf07782b14fbcad284bcefbe40.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:51:49 +0000
Message-Id: <20260901005149.92C4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Now PRI requests can be correctly handled. Enable the PCI cap when probing
> a PCI device. Also flush the priq in arm_smmu_attach_release().
>=20
> Drain the priq for any PRI-enabled master following the same rationale as
> the eventq drain: a stale page request must be answered while it can still
> resolve to the old attach handle, even when the old attachment did not set
> up IOPF, or else the threaded handler could route it to the next domain.
>=20
> Note that PRI is enabled at the probe time, while ATS gets toggled by the
> attach/detach routines, so a master could have PRI enabled when its ATS is
> disabled. PCIe (Base 6.3, Table 10-14) sets no ATS precondition on the PRI
> Enable bit. Its only ordering rule is that the interface must have gotten
> successfully Stopped prior to an enabling, which pci_enable_pri() already
> checks using PCI_PRI_STATUS_STOPPED. Also, a PRI-enabled device would not
> issue a page request until it starts to use ATS.
> [ ... ]
> up for them; keeping PRI enabled would let a PRI request arrive on an ali=
as
> StreamID and get a PRI_RESP_DENY issued against streams[0] by the driver's
> error-response path.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D13

