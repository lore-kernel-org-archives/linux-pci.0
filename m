Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE2214A84
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108739; cv=none; b=LtRtIW+ICILNhfFi0nc5gL9BglD61F7pOBe7JQflPxLm2LoMdNgvhoePHHTw7new7VmZgY7OYavbaI6jWF41EkHP0eTxGi0HpbA4ZcivTa81SCdhnOfzol50NWrQaOLA+cPztF02x5ODV1yTznj367hOR1ataYawMmSL3lhGU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108739; c=relaxed/simple;
	bh=QRU0NMupGZ9A/on6onvDqr7/kFxxIyzT5cX3o7UnINA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VXEV7tdKPQ3wm4kwIs1pR72gWdUmt0YpREblSt88ERV+74Ps4qda2zYLJo37+2TvKpnXbtgEkwYBosYyWJgoYhYEeXb3sm4nAtmBlRvWNNvvDJuRvrsnCKwDH8qesZPJpqDBWWBJgfcmXe8M2hwBdMVSU9ld+FVqHW2iow2j22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvgWI1je; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvgWI1je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1257EC2BCB0;
	Wed,  6 May 2026 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778108739;
	bh=QRU0NMupGZ9A/on6onvDqr7/kFxxIyzT5cX3o7UnINA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cvgWI1jee/cYzi8s0OonKX53LwQDUV7Rw7T7Q6ZAIQNEjKvjyHqjGZk14rt1hRAaf
	 qjE3Z2efgESuHhj49lRa6mbAcZDk/Xwb9WX/JFxoOy3Xguxp37IkQKnfCdGpDqCxmQ
	 OOqJbJU/Bf4hV4p9cJxxeSGzCxj4BTam8Or39aExrC6TNXtE01Xj6QI8LdPzSzemPj
	 GuCiTZwFnTCWMK11d23kmxB9pqF4riiYVr0+cewoa0X7XqcxQ6pX0uJHxTm7Tgpv/I
	 Y6qB3jhPm+s3J/JoYXOfeix6qgRjvrOdGkuFl2g87xySGYh9BtaNE/zs0f7Jp4UOpw
	 GH0L73+VvP4SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] nvmet: pci-epf: Use
 dmaengine_prep_config_single_safe() API
Reply-To: sashiko@lists.linux.dev
To: "Frank Li" <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-7-85b3d22babff@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 23:05:38 +0000
Message-Id: <20260506230539.1257EC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removing the mutex introduces a severe concurrency bug, leading to=
 spurious channel-wide termination of DMA transfers and CPU starvation.
- [Low] The local variable `lock` is assigned but never used, resulting in =
a compiler warning.
--

commit 36bcfc6ae688edc18d4bf05e641f168d44b9db2c
Author: Frank Li <Frank.Li@nxp.com>

nvmet: pci-epf: Use dmaengine_prep_config_single_safe() API

This commit updates the driver to use the new
dmaengine_prep_config_single_safe() API, combining configuration and
descriptor preparation into a single call. It also removes the mutex lock
used during the transfer since the combined preparation is atomic.

> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index 2afe8f4d0e461..04d8f48d69503 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -388,22 +388,15 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_=
pci_epf *nvme_epf,
>  		return -EINVAL;
>  	}
> =20
> -	mutex_lock(lock);
> -

Is the local variable lock still needed here? Since the mutex_lock() and
mutex_unlock() calls are removed, the earlier assignments of this variable
in the switch statement appear to be unused and might trigger a compiler
warning.

[ ... ]

> @@ -426,9 +419,6 @@ static int nvmet_pci_epf_dma_transfer(struct nvmet_pc=
i_epf *nvme_epf,
>  unmap:
>  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> =20
> -unlock:
> -	mutex_unlock(lock);
> -
>  	return ret;
>  }

Does removing this lock introduce concurrency issues with dma_sync_wait()
and the error handling path?

Looking at the remainder of nvmet_pci_epf_dma_transfer(), it calls:

    if (dma_sync_wait(chan, cookie) !=3D DMA_COMPLETE) {
        dev_err(dev, "DMA transfer failed\n");
        ret =3D -EIO;
        dmaengine_terminate_sync(chan);
    }

If the mutex is removed, multiple threads could concurrently submit
transfers to the same DMA channel and enter dma_sync_wait(). Since
dma_sync_wait() polls for completion, could this lead to CPU starvation
from multiple threads busy-spinning concurrently?

Additionally, if one thread fails or times out in dma_sync_wait(), it
will call dmaengine_terminate_sync(chan). Will this indiscriminately
abort the in-flight transfers of all other concurrently executing threads
on the same channel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-dma_prep_c=
onfig-v4-0-85b3d22babff@nxp.com?part=3D7
