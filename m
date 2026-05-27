Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896A3F6612;
	Wed, 27 May 2026 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882926; cv=none; b=rRVSFtgh0Hi91lAfpthmBjf/HRhbG7mTKB7KSfdZXAyHKj0kCdfkBzexLZzSDMOWBuEBDDx8zAi4INLl6xBOWai2/Y+Ad078PmCECburt285f5xRCQTJn4by30XSOmR7EgLYWTBoDU2vXDRn9nFkFCvZMx6TGy4mA8MhMhfw3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882926; c=relaxed/simple;
	bh=YOxq85BhoK+UeFka8Zxzm7yB2mOJp2IBDAa3h85nUxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SZ3X4SOoFe0IEG8lIy7cZ3NXm4tpBJED3dCEQ5KaXqOVV18PdBrizDYrdcamVCpZnYDpRpbdatSWOcM5+qIN9XJS1+e9rx29JTykkrKxyPS69g0leZxWMGIvcdlx93Wui5QfC9ugCvO7yo2tdqdZqvyjDpptXBnbh9Tzpr4hyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCaFa/qD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCaFa/qD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807C01F000E9;
	Wed, 27 May 2026 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882924;
	bh=rwYv4TseoI1EneuWWYSVd5SVs3X9jXRq/3Su1LCmXYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCaFa/qDRf4IJ+5AkAnS+HaKC5Z9K+BxSmtKWTVAkgwhQ4mMz7+qq/m+7deBlemr9
	 yfwjwLKoyZ+lhkWuuw6kw8mVWvuLK2dmi2DvdL+wnqlYQJQ7Yzs/hJb8qlKWi4kmkM
	 FJjX7znGJ1sBZQgPNRHVReRBGgL4VFBin8Kz95REE9h4fYkLzhVWZBPYF3gi5EIClv
	 9dKw6++5+2elpvUWIRwkWWayib1RRnIzZGeutGDvzI5vE4/ZH/e+LLWQvr6/GLRAFq
	 FCGlc9TX5er09Ag2QeO+hNWoV5rKZYLuFl9BcLnTypoyD0uocMemQ61US8p57aain7
	 Yjxyd1QdK4g1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/8] PCI/TPH: Add requester policy to
 pcie_tph_get_cpu_st()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260527094719.43886-5-fengchengwen@huawei.com>
References: <20260527094719.43886-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 11:55:23 +0000
Message-Id: <20260527115524.807C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free of `irq->cpu_mask` in `bnxt_free_irq()` because=
 it frees the CPU mask before cancelling the asynchronous IRQ affinity noti=
fication work.
- [High] Lockless read-modify-write on the shared `PCI_TPH_CTRL` register i=
n `pcie_tph_set_st_entry()` leads to state corruption and hardware instabil=
ity.
--

commit e83a9eff13ffcc47efd9212a157c144fb33f5bdc
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add requester policy to pcie_tph_get_cpu_st()

This commit extends pcie_tph_get_cpu_st() to accept a requester policy
argument. It allows callers to explicitly retrieve steering tags for standa=
rd
or extended TPH explicitly. The patch updates driver call sites and=20
documentation to pass the new TPH_REQ_AUTO argument.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -11734,6 +11734,7 @@ static void bnxt_irq_affinity_notify(struct irq_a=
ffinity_notify *notify,
>  		return;
> =20
>  	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +				TPH_REQ_AUTO,
>  				cpumask_first(irq->cpu_mask), &tag))

[Severity: Critical]
This is a pre-existing issue, but could this lead to a use-after-free of
irq->cpu_mask?

If bnxt_free_irq() frees the CPU mask (which happens via free_cpumask_var()
when CONFIG_CPUMASK_OFFSTACK is enabled) before cancelling the pending
affinity notification work, could the asynchronous execution of
bnxt_irq_affinity_notify() access the freed memory when evaluating
cpumask_first(irq->cpu_mask)?

[Severity: High]
This is also a pre-existing issue, but is it safe to update the steering
tag without any locking?

Since bnxt_irq_affinity_notify() executes asynchronously in a workqueue,
multiple instances can run concurrently if several IRQs change affinity
at once.

Does calling pcie_tph_set_st_entry() after this block cause a race condition
on the shared PCI_TPH_CTRL register during the lockless read-modify-write
cycle? Could one thread re-enable TPH while another is still writing to the
ST table?

>  		return;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527094719.4388=
6-1-fengchengwen@huawei.com?part=3D4
