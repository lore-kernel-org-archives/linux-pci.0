Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A8380FD3
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 05:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790659898; cv=none; b=FWp5+mbhCYG/60U/6spKwiSMt2oOSQjkv8KqmQvHdBrQeQ8sJgFKmCqYqIeMzNssFM+8U5fbNAs7ERk1UIiKjAOuvVgHdXcf3xvffqFLaWtGRgpCwLd9Ma1bLSzREu2ONJweaT61IfjRtSDjcA5jK5y6wTQM5hK9WJjDvyipclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790659898; c=relaxed/simple;
	bh=JlzJ4v7M9jMwOfDTinY8LxaFBAdx8wqkPCSvhzaBhdA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FZYVGTSOWXt4oNhsrJYpzk7SaOLbA1lHRm9HfFjQo357rGJ1SJvhzK2LJ6/EVQtANwOGCbI88N9KrgJBWw1tnYH7uBAs6Mib3V2wUdfuvCy8MSy3Zuot6Y8mP/Q+/UY36sldbYHlWG4x7UDEzkIy1HjWbJIIwj5YbGsL/Si4QSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFne0Bp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFne0Bp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D0B1F000FF;
	Tue, 29 Sep 2026 05:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790659896;
	bh=jzldCaAQxd9AZura6rMMVNkZLPL71SE3a2rm+70KZaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XFne0Bp0uCywPD8aM1Zc3fbTNTBI/sgez4fhBCb6FZ2lKtKUoUL85yY04FXoZ2HWZ
	 w8ihbfSW2/FwuQK7zVe4krSdpjcGCey8BJ0TKaPimx3kwcD+9yyhD4lvsecQfgDIuT
	 zH/iSW8zp8VU4K6sl2pqy8gOVm/q4aYRaWdbUlXHIuuMl8XX3/xXQd2qHo0aIXKZZ0
	 mYlvi7d36zhu1kMp76ODbcegO++H8746itBHDCPXQxpb+9ITBBhTGszaJiCxWGCs5o
	 h8vtTUZ7ikaJXMQXAr/UipMyHnqyeIuuvmHUtKb+fW5VX0hmTMA9/qB0kmg8snvh4s
	 SsHKKcm3ZA0CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/16] iommu/arm-smmu-v3: Restore MSI config on
 resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-10-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-10-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:31:36 +0000
Message-Id: <20260929053136.93D0B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] arm-smmu-v3: Meaningful code and commit message mismatch for ARM=
_SMMU_FEAT_MSI
--

commit 1bda20db5a1330cc7b28d06643bb07428e7318f4
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Restore MSI config on resume

The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
address, data and memory attributes lose their state when the SMMU is
powered down. This commit introduces arm_smmu_resume_msis() to zero the
registers and restore cached MSI messages. It also states it clears
ARM_SMMU_FEAT_MSI on setup failure to prevent spurious resume attempts.

> In addition, clear ARM_SMMU_FEAT_MSI if MSI setup fails and the driver
> falls back to wired IRQs, preventing spurious MSI resume attempts.

[Severity: Medium]
The commit message mentions clearing ARM_SMMU_FEAT_MSI on MSI setup failure,
but the code to do this appears to be missing from the patch.

Looking at arm_smmu_setup_msis(), the flag is left set when falling back to
wired IRQs:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_setup_msis() {
    ...
	if (!dev->msi.domain) {
		dev_info(smmu->dev, "msi_domain absent - falling back to wired irqs\n");
		return;
	}
    ...
	ret =3D platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_=
msi_msg);
	if (ret) {
		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
		return;
	}
    ...
}

Was the code to clear ARM_SMMU_FEAT_MSI accidentally dropped from this patc=
h?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D9
