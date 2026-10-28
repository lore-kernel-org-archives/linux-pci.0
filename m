Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157511;
	b=IQzWO37UyYdfcrPjObw+1jHzOllw76AvTrf4+39c72So8EqdhZTztBsUkNpmlGWbo6hJ
	 cTnDIV6IYfLt0eCtoTC/t39wqHk0Wfqrss6pqmG8n7SzwpS7ncvMr2HYs7ZBAu3UtOX73
	 1msj/xMlgWtrYsxdLsPkWV/xeAg7YqmsXKM97OLDyR+8CJWQZkuM24sD6YeekOpAqJ8xt
	 zrudQ0fzBNIyLzqrG74yAYkMpe0fjI3Tp5pRhAyknh3t6esKGBIPLaC00U0gPsgvFXvOw
	 wWsSdcZCt9yQfCVs7KA68qidX7/060YMxH8ts+70RiqVmx+qhrPunpIwNALHwHXmVkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ce8C9VbrxBgqFheQEBPMbUHZan8CKBwcixqdhE/jVBs=;
	b=0zRo7lzaiuRJ1x2jEL5yRmxLazJYC4r27UHT2SkTsJgx/uBzAYgO3nOb/aUiwpo9g9Wm
	 0DebgO7MXPnATe0mAJrXbCw6Vb6GlTFFMgMwQS803lFjR+L55v3whzVw5Ybc0P4u3/qnE
	 uWTUB3ynoBdqurShkBJ+2lmafALwSt/h1fcq9/iO7oojBdBHcd0Tm+T5lEfElWAAU4ydg
	 gwFLocjH4vhlL+POsVMRxSm9J2WFUFmf7zIcXvxZ8YYRZ1xHl6eORlzej3ogV6b7/Vg1d
	 B5w2ugcmVtB9wfSKsMii1trr26sf+7L2J0EYwyQk27tHZYc4sgWp/EQshdxWn8hH28Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et5LGhoB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA7606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=et5LGhoB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF111F01825;
	Wed, 28 Oct 2026 03:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157510;
	bh=Ce8C9VbrxBgqFheQEBPMbUHZan8CKBwcixqdhE/jVBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=et5LGhoBSBcdjWYC6EPz+AWNSRDZMLSudreHD2XPxSpdw8G8wpSiA7tROi5qkNmQz
	 RbB5Y0CiLXuHuMOQ6L5B7NBAOV79hIqYPP/+0zrck6MFQZuQelCgovBjiS5+gBjP/0
	 L6MLSrWQkY4jxsI1ymz85yzFrTuhApIUMVvzbvW2KEx483XyGgFudWNscM/1NiPfJq
	 L7uy5rUff+VgW17eXAH0t0Aieh7Kq5r9DNdlZ0t1MOgE8VxYER76kYdgsi3gcGxgH4
	 gUeY871j4DVVJFN9j+/t8qFEBqQQ6Y4dRxaVvo+O7vIt3xv7UKkwOkPRSIIwz1hRD/
	 T/C6YNgnvOyrA==
Message-ID: <sashiko-outbox-187411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/16] PCI: dwc: qcom: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-12-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-12-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:18:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) users in the
> Qualcomm host driver to dw_pcie_get_pcie_cap():
>=20
>   qcom_pcie_clear_aspm_l0s()
>   qcom_pcie_set_slot_cap()
>   qcom_pcie_post_init_2_3_3()
>   qcom_pcie_post_init_2_9_0()
>   qcom_pcie_link_up()
>   qcom_pcie_icc_opp_update()
>=20
> Note that the .post_init callbacks of struct qcom_pcie_ops run from
> qcom_pcie_host_init() before qcom_pcie_clear_aspm_l0s(), so relying on
> that function to populate the cache would have left the offset
> uninitialized for them. Doing the lazy lookup inside each function
> makes the ordering irrelevant: the capability is searched exactly where
> the register is accessed, i.e. where the open coded
> dw_pcie_find_capability() call used to be, and every one of these paths
> runs after qcom_pcie_init_*() has enabled clocks, resets and power.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D11

