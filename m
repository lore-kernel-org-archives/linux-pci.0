Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51B48097B;
	Thu,  2 Jul 2026 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996907; cv=none; b=TMJNgCOnotTFx0zuK3J6rwc4g64M9oMYP0dJG2sIYJHOCWsM9s2VqwKEgXxJNdOCteTgZhz+ITFc6FhULhBTCNVxwgj96EhdCTrbcNfiqiTeWGeba8akg1VkLsxgrlb8gdJUW3aolW+LVGcVUecCnVVFmq6iaHpjsiD8QA+Q+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996907; c=relaxed/simple;
	bh=KVGpk5sh0ToLg9bvAI59wkHdkpmQa0eYP9vXDW5cBN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HcvjtkVBhN/WRfcWp278BjeobaKQvChfcKep2c85kS100LoSmy+4xzDccDBrpuvKEA3M4nxeyUSu93a/BlRXLERVulBa/tqo07+hWvRS14QRRpOA1Y17Ofjdi7ULinohJ3DO20QcBoTXTLlUTVCZh+wOl2MuTnoyVPeDWVy7xvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emUEjGMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emUEjGMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29371F000E9;
	Thu,  2 Jul 2026 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996906;
	bh=UoEYEmolHNVZx3sF6KLgGteXug29fB+KajBAizhLAF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=emUEjGMgwtGZLWrmcgQRZ+kot1W/CVHRf1+rc1ZOgf+6y7AYE7vLQFvUU82R8YI08
	 X3M2nmOuiC3Z0rIVLn9mHouOIjmwELhuMupgDQkGNHWdTQndV9S+Ds8dvdMFdl01x3
	 Epx1j0Pm/BaSOOOxE7b5o9UajnqMKmIvvRR64N6BxUdbMzsAjy3XSP1pwyxyHVh8oU
	 teELmVI/zq/ezKWr9QGUvdxRMW/QhhZsbvot1N3A3NHhLPhiFdfu5xD9TX9FJyncAk
	 V33FZgbRzI3zgZUVc/q9lYCn+CcZJHMMcR9Iz5q6zYLC79H64JFS437T+Zr8LPL47i
	 /B2xdR3397EMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/18] PCI/TPH: Cache TPH requester capability at
 probe time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-4-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:55:05 +0000
Message-Id: <20260702125505.D29371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `idx_data` in `mlx5_st_dealloc_index` when refcount=
 drops to zero.
--

commit 2d469f948c634c33afd2be55f065a0101647132f
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Cache TPH requester capability at probe time

Calculate the negotiated TPH requester type from device and root port
capabilities once in pci_tph_init().

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 489487158b99e..4097787ea98a1 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does mlx5_st_dealloc_index() leak memory
when the reference count drops to zero?

drivers/net/ethernet/mellanox/mlx5/core/lib/st.c:mlx5_st_dealloc_index() {
...
	if (refcount_dec_and_test(&idx_data->usecount)) {
		xa_erase(&st->idx_xa, st_index);
		/* We leave PCI config space as was before, no mkey will refer to it */
	}
...
}

xa_erase() removes the entry from the XArray and returns its pointer, but t=
he
returned pointer is ignored and the idx_data object is never freed. Can this
accumulate leaked memory over time with repeated steering tag allocations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D3
