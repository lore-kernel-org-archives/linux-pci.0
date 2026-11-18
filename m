Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004866;
	b=TrL2g8FaXKiaSAFnwlDTMVs27SvKNj2r7II+uPRjodU70AnPY6Ls9F5rZ7UtVGPcQqDo
	 hGCxhw+1Ib7fzYaeVjLnBtM8Oqjptvlrq1Ip6E21hNgo/Txwc2hW6sTNTAv0u0ilQHY5Z
	 vcUPN1A5fLJ5j1jyZ4XA3POxqlr9dZs8rYWRcm4ktN1JIbSutj7XV/hyCS5XYOfAsXx8d
	 i7mHKz4tOnpJXuBkFEi9KJAH2rn75zZjDNEj8wl3S6cAhwKQaz+lJ2ms4SH4cgXfDE63S
	 Yy1xt7mPTP5+i33gyRTUUnisTw3iHnAXt7ac3zQ8UstsUefHrGMyI8auEF2qQ+HcnXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wccYq8TQk+hE4q8MsMUW4rj7ktsqrbzNqWmV5gv1hAA=;
	b=1vmwOa4Sr5pTdAuYW9jHuBylhTarodOKr3eNFa6uKJaphbuRPerATL0eXMZaiso6RYJG
	 kK9pZZX4ovOjWYZmbV2KMT9yB0eq/6WpzG32brKlOK/w5Fq/keAtAYbMmKzdFowkdZp3O
	 4q/o8EJeKlXRe/sf88QTr5Af61quhyNE9eIbLSIF9gRpRZ0+IvX7OTbvjJ5pjA+XFS4qx
	 xvSMslNUDRiDq/dLIn1jyyAIEKM+oguS2Z233+Vd6OYINDU4YKUfq4ah0AWqNQbs6xfJn
	 mRAgtDRhh50HYhuDRU+CCmjy6N5hHCWHuozGaUFrr2wTI5HHLwZMrQZaoqXUWlMbeDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jc/D6tWT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AF606A32F;
	Wed, 18 Nov 2026 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jc/D6tWT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EA81F000CB;
	Wed, 18 Nov 2026 12:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795004866;
	bh=wccYq8TQk+hE4q8MsMUW4rj7ktsqrbzNqWmV5gv1hAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jc/D6tWTtQzXalyV1vTCctcrqQ6TYIuTgl8a5XF7aE/Yuek+HxM4cY6hbkLOYPIlV
	 /XXm/Eo+wSKK1XkGN3ji/7N4FaCsLGYWkbFt4JbUt8OAuXVOe3s7RZUk5WDUbWeecP
	 cq2d3C4XK437rOIIeXiZHg+0Iw2jKgILrgY788gHiRjyzaPfzPkXkbPGnFGKDTuUZM
	 pC9c2v4KjkOluaydiywVcbbDcw51lGYfJctFKyBuWTJgjTbSqtOT7lKqZYuBiOnqD2
	 Td+tBngjiAn/PBjjTDzY1qNe010pJkBr8vPbej02uxuFgb4xrN8OltIZNq7ZOKaomM
	 0Bj0A5zPhMhEw==
Message-ID: <sashiko-outbox-220913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 13/13] vfio/pci: Expose per-device TPH state via
 debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-14-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-14-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:27:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] vfio/pci: stale tph_opt_in and tph_vcap reported in
  vfio_pci_core_debugfs_tph()
--

commit 7e557b3e2af5cdc6c9056a9f2dd3cbe532f029c5
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Expose per-device TPH state via debugfs

This commit adds a read-only "tph" debugfs file under the per-device pci
debugfs directory to report the device's TPH policy, virtual capability
value, and user opt-in state.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 8d3d532cd51ab..a9cdcb0f95a01 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -130,10 +130,20 @@ static int vfio_pci_core_debugfs_disable_idle_d3(st=
ruct seq_file *seq,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_debugfs_tph(struct seq_file *seq,
> +					    void *data)
> +{
> +	struct vfio_pci_core_device *vdev =3D vfio_pci_core_debugfs_private(seq=
);
> +
> +	seq_printf(seq, "policy=3D%u cap-virt=3D0x%x opt-in=3D%u\n",
> +		vdev->tph_policy, vdev->tph_vcap, vdev->tph_opt_in);
> +	return 0;
> +}

[Severity: Low]
Can vfio_pci_core_debugfs_tph() report stale vdev->tph_vcap and
vdev->tph_opt_in values after the device is closed?

The debugfs entry is created during device registration, but tph_vcap and
tph_opt_in are only initialized when the device is opened in
vfio_pci_core_enable() and are not cleared by vfio_pci_tph_dev_deinit() or
vfio_config_free() during vfio_pci_core_disable().  After a session that
enabled TPH via VFIO_DEVICE_FEATURE_TPH closes the device, reading the tph
debugfs file continues to report opt-in=3D1 and the previous session's
cap-virt value even though virtual config space has been freed and PCIe
TPH is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D13
