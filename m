Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D265360EC2
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340784; cv=none; b=sDCfxdg1j8bk9/dBRJ5btOsBNUCt9KITs4Cw5UyQz7grI8WyinWRKdvLvu9B0LppWWcSuAVXwYRD4jb16RRAG36Lef9qw7HaRDxT4Eg+wNnqmQrMlKzXTl6YZmjF5u9e2kjqccKAYCwV1IWcqqiBDOgRQuTRTVXr1nq2vD3dEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340784; c=relaxed/simple;
	bh=XQjMisD5+yAPpVk3seej5PqD1GHJUHe/24awhYC/1no=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F0sxbBO2brmpTuNT2PizImTG108VT0XE5Kfg/hGxabSWaxEbfAkWJ5hGizsU1QRcEDls83le0ojtxTiWHJCibnT65Ma8yvLM2JQGrLmRfGHXdq3v57fDqjSQ6/iqQOlUafjdLBEzojGvBC8SpAg1KET6d0XRhGnkV99eMt3u4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3rd4Cjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3rd4Cjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F81F00893;
	Mon,  1 Jun 2026 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780340783;
	bh=8KL8l8BHCkygJfW4p1KD0V1xnlQb8EJAruObPiOl6vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3rd4CjxkPAsTfWJfaMoVERk2im4yaDjKgj5xgsEMfckC7HCwa85Qfije5YnXjPMq
	 lysGVLQb98JoOrdBwg3X/E6jh6S9DrD2oUWPSmRYFyMfjrOrP1TrIUaftrWPDZNeFs
	 YzbEpefrvcxbxU6GEwWnjXLEl6O22pG/0cJVmdYt239Vn2C6bfzsIDMwG0ZWXNUD5M
	 Jov+psk+NTG8ZNGywBSOwak4sFOaxl7CKuQWohQ7xoUS4OKAym27CuQejktFvBUDRL
	 LDJpJa7bYhZ7dwHZvB5lkATu7QCUUWldBt6ahE3JHZEqDJd3OXunm5urIt8hDFgGOM
	 oBKnIT9t1xDSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601134204.2150602-7-praan@google.com>
References: <20260601134204.2150602-7-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 19:06:22 +0000
Message-Id: <20260601190623.269F81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Adding a WARN_ON() to pci_prepare_ats() causes spurious kernel war=
nings and potential panics because the ARM SMMUv3 driver does not check pci=
_ats_supported() prior to calling it.
--

commit eaccac64f7c8e00ef695d5c2076021c097520251
Author: Pranjal Shrivastava <praan@google.com>

PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

This commit updates pci_prepare_ats() to wrap the internal
pci_ats_supported() check in a WARN_ON(). It is intended to mandate that
all callers verify ATS support before calling the function.

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -61,7 +63,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
>  {
>  	u16 ctrl;
> =20
> -	if (!pci_ats_supported(dev))
> +	if (WARN_ON(!pci_ats_supported(dev)))

[Severity: High]
Will this trigger spurious warnings or panics for non-ATS PCI devices
on ARM systems?

The arm_smmu_probe_device() function appears to unconditionally invoke
pci_prepare_ats() for all PCI devices without verifying ATS support first:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_probe_device() {
    ...
    if (dev_is_pci(dev)) {
        unsigned int stu =3D __ffs(smmu->pgsize_bitmap);

        pci_prepare_ats(to_pci_dev(dev), stu);
    }
    ...
}

Since this unpatched caller does not check pci_ats_supported() first, any
standard PCI device lacking ATS support might trigger this new WARN_ON()
during IOMMU device probe.

>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601134204.2150=
602-1-praan@google.com?part=3D6
