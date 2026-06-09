Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C06374A17;
	Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033922; cv=none; b=kdGWjVzP7ljY2a/uj4lN1UEvweQE97G6CHt6nqzHseQYI1CVdyFeRmkzA4UQ07UoX05KWtcuCiu1vTxvcZ6kX4hfj42HGzVF27CuPmgssSiRO865EVXQYU+8nTPW21p76dWLyqiGJ6529QtJ2xiPyrLktjBV21xjSP2vYpHS49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033922; c=relaxed/simple;
	bh=KzCD4pxnCky75Uqu48ikPWI9PF35rT1V6rEExawYcXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bXhPrKR5rMiU+UUi7zRxqOpD1Yl3bi4UHYyOem/FRl1JnmYilCF29FDHwMZEtwneMpwIlmhcbNpSm+PAD65CjhYW0NXjbC0VfA+oprZ5m1LzkVrFrTuiu9YohyEafYvDa3VflzlGe6v/Ku02/bsaHK1XVUrLxcMy7JLiFJF5JNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW9tKv2v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW9tKv2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD6E1F00893;
	Tue,  9 Jun 2026 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033921;
	bh=4Qkz6DOqkZ66VvYidaGJY4/KLC76NW7muVqfZU+Lc7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UW9tKv2vw1OtbIp9Mxj8gliwX96xJ8QbbhwChY8mCQyZlaiuB0Ts1DjsPGCOVoQL0
	 y9zoCSgfJl3wjtPUJ7QM5VB2C79FB+Uk7ppPIaLdGPUhgKgDZ2a11rgG07bSinlJzJ
	 SW+EEnImQa1gTEcS3dKYGZYrSGFoic7rEHrsOuMjmA2mW4gmfJpCc0YpKvq0aoLkHg
	 ffozoAywS/XMgHZjFLtmlbSKgXNiwtqxeSg0lHjo/PvJPr2EXa3HIlYL+XePhznfG/
	 9jYJYm7mq/WkVmS1ml6nf6GFek1bbgrPWmI4ZhRGLguD+9CRU3C0O3g3oGmoS/JCG0
	 ZeGkdx1BhdF4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260608185646.4085127-6-zhipingz@meta.com>
References: <20260608185646.4085127-6-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:38:40 +0000
Message-Id: <20260609193841.0DD6E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `mlx5r_creat=
e_mkeys` error rollback loop contains an off-by-one error. It leaks the suc=
cessfully created hardware mkey at `handles[0]` and improperly attempts to =
destroy the uninitialized failed handle at `handles[i]`, which translates t=
o destroying the reserved hardware mkey index 0.
--

commit 37ae7395b661b5e14306aec55bedd4ae96943e49
Author: Zhiping Zhang <zhipingz@meta.com>

RDMA/mlx5: get tph for p2p access when registering dma-buf mr

Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
peer access and translate the returned steering tag into an mlx5 ST
index. Keep the DMAH path as the first priority and only fall back to
DMA-buf metadata when no DMAH is supplied.

[ ... ]

> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index 254e6aa4ccafb..7b0a883e04048 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c

[ ... ]

> @@ -299,7 +331,8 @@ static int mlx5r_create_mkeys(struct ib_device *devic=
e, struct ib_frmr_key *key,
>  	return err;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the changes
in mlx5r_create_mkeys(), I noticed an off-by-one error in the error
rollback loop right above this return statement.

The error rollback loop is written as:

	if (err)
		for (; i > 0; i--)
			mlx5_core_destroy_mkey(dev->mdev, handles[i]);

Since the loop body operates on handles[i] and decrements afterward, doesn't
this terminate before i =3D=3D 0, thereby skipping handles[0] and leaking t=
he
first successfully created hardware mkey?

Additionally, is it safe to call mlx5_core_destroy_mkey() on the failed
handles[i] where the error occurred?

Because handles[i] only received an 8-bit variant via assign_mkey_variant()
and the firmware failed to populate its hardware index, its upper 24 bits
are zeroed. When mlx5_mkey_to_idx() extracts the upper 24 bits, it yields 0.

Could this cause the driver to inadvertently destroy mkey index 0, which is
a reserved hardware resource?

> =20
> -static void mlx5r_destroy_mkeys(struct ib_device *device, u32 *handles,
> +static void mlx5r_destroy_mkeys(struct ib_device *device,
> +				const struct ib_frmr_key *key, u32 *handles,
>  				unsigned int count)
>  {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608185646.4085=
127-1-zhipingz@meta.com?part=3D5
