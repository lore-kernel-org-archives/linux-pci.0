Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFD244675
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091723; cv=none; b=NFStSFBrAKqM7TwBhc53Ltrk1bduMQA5Hjghs/Fy3X6IETTaA8RMT25iA/daXAr5XWpNXjoiXLIgXNa4Bsi7FJnTR3qh3+JxGForrMAybgmPjtW9QxcW3WyJ9YISVET6lM4Fha56fplMwxb0S64QMSaT6viKiVdfVpeago5KPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091723; c=relaxed/simple;
	bh=kensKWCx1079dK6q4s2cQiqL/xVqNqLSGweqziBg2Iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q0gt9MxuRx9ApWvIT2cWzuj7jS+pq8Lo84rwp1cjH3ccWCts/Nqg79Fq+F04ZG5wZ664Rjm1nZwt8MRn8tIjdXu0xXDsAOi0wHNgPha9fSIgdQQnZwp/VfNqVpey3WLz8jixO4qHLbbTyMjHZr6AGuqnru0719CF/dS/R9e4DE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO0IMOBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO0IMOBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD061F000E9;
	Mon, 22 Jun 2026 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782091721;
	bh=zVbZQiSvSIXJhG6cyGbrsXGD0YywIynq5PmWrLWY2Mg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RO0IMOBXM0QVwAVJVLjMqkdAURoZKkNV7V3m+vR7SGmCTXpPz1WV/PivrzxX6QZQN
	 /JLa/sKlKcvRV+OEZGckwR5QxQMEVlsB3iC1eUQhK2usrMJ8zcrxAH6v89N287eVsH
	 b7PA2jzNM1VHfb4zrk5bVohnyvbSxFrBZ4Z8b293bwMFh6YPtDqVpBXnoQAa3GAErh
	 jxFk9HOMXQBlY+EBAtSZUa/MdjYkrDVCn+F/q7h/J3iMJnJphnNUPzRhrN7liECDE+
	 3x2fjtFaSKGDQGJ3U6RQIoZAu4Ia3Iu4TQlBY2IaSanMTJU6vS6+t01HQYqwQ+k8uZ
	 433GFfGgs+q5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nvme-pci: fix CMB mapping when CMBSZ Size field is
 zero
Reply-To: sashiko-reviews@lists.linux.dev
To: kangfenglong <kangfenglong@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260622012147.40600-1-kangfenglong@huawei.com>
References: <20260622012147.40600-1-kangfenglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 01:28:40 +0000
Message-Id: <20260622012841.3BD061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning 0 from `nvme_cmb_size_unit()` to reject invalid SZU valu=
es evaluates to a size of 0, bypassing the rejection and triggering the exa=
ct bug the patch attempts to fix.
--

commit efcd71708003c14038a1fdc79b6233cc4b6a8192
Author: kangfenglong <kangfenglong@huawei.com>

nvme-pci: fix CMB mapping when CMBSZ Size field is zero

This commit restores the check for a zero SZ field in the CMBSZ register,
limits the Size Units (SZU) to valid values, and adds an overflow check
when calculating the CMB size to avoid mapping errors.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e6267a6aa3801..2794298aa9e66 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1814,6 +1814,9 @@ static u64 nvme_cmb_size_unit(struct nvme_dev *dev)
>  {
>  	u8 szu =3D (dev->cmbsz >> NVME_CMBSZ_SZU_SHIFT) & NVME_CMBSZ_SZU_MASK;
> =20
> +	if (szu > 6)
> +		return 0;
> +

[Severity: High]
If this boundary check returns 0 to reject an invalid SZU value, will this
0 value be used in subsequent calculations rather than triggering an abort?

>  	return 1ULL << (12 + 4 * szu);
>  }
> =20
> @@ -1838,9 +1841,12 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>  	dev->cmbsz =3D readl(dev->bar + NVME_REG_CMBSZ);
>  	if (!dev->cmbsz)
>  		return;
> +	if (!nvme_cmb_size(dev))
> +		return;
>  	dev->cmbloc =3D readl(dev->bar + NVME_REG_CMBLOC);
> =20
> -	size =3D nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
> +	if (check_mul_overflow(nvme_cmb_size_unit(dev), nvme_cmb_size(dev), &si=
ze))
> +		return;
>  	offset =3D nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);
>  	bar =3D NVME_CMB_BIR(dev->cmbloc);
>  	bar_size =3D pci_resource_len(pdev, bar);

[Severity: High]
If nvme_cmb_size_unit() returned 0, won't check_mul_overflow() compute
0 * sz =3D 0, return false (no overflow), and set size =3D 0 without return=
ing
early?

Because size evaluates to 0, execution continues, and later in the function
pci_p2pdma_add_resource() will be called with size=3D0 and offset=3D0.

As noted in the commit message, calling pci_p2pdma_add_resource() with size=
=3D0
causes the P2PDMA subsystem to default to mapping the entire remaining BAR.
Does this defeat the SZU boundary check above and re-trigger the exact memo=
ry
mapping warning this patch is attempting to fix?

Should nvme_map_cmb() explicitly check if nvme_cmb_size_unit() =3D=3D 0 or =
if the
resulting size =3D=3D 0 before continuing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622012147.4060=
0-1-kangfenglong@huawei.com?part=3D1
