Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907287;
	b=5QHeCWXh4ViFgiqBqva7tvIB3tsahISYs4hRqDulyutdXJo44N6bYve0dgL8zU3IQ0BP
	 8nuqjrPmdNz//4vyzFCvslQQwEHu3Btk8xkwwX4GOxKHah5yyLPTdCg2VvBdMSvcdk5B/
	 bNQe+R7ed97kvuORWhzzDzGc65qsjk53JkHtg7AhGQhE0kki0V0i2If5JzeN0PQWfWord
	 9mVE08LsobVqdEOJi/FE/Fz5/oFVKe4VprHbhCjV0kb9tafwabsX3HVGc5jqjurPsDWfe
	 FAkXkDwbIJMntdKGm4Eu4OAAc84vw6jWI1a2BLLtR+Ep0yXA19+vyeuTQYp+lZbtqPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AUrMrHtWoIGyCWfCQQZab5O0fQHAFIVDTlEEoBDLbIs=;
	b=NqGJpZgEqv+hrl7yUbcHi0paiWu+lqj+dGcdJqmiu2ATbX5vd6vMJeJ3fsSdt7CWSTPH
	 COEHMST86N265pfY69bwdyoQj+fhC7WWW1jC+nuvh2LXDDIAFRS6TrNzb6nn46pTfONUa
	 g0tv2cST00JeNiT53z2prZ8E9UFqM042hBT8Cqe5NLYfIgwvTb0C0BYa84jEptgMFyu//
	 Zp5Ajz7ns8RQkymA32xbEDqbYayVxVDWktBSsZRzk3NYRvzMGILNW8APpKTMomAq4B7Np
	 Gf4+NttNMLaGKG9Czytr3fPrd+JlrslSIGzybenso0okC4LlxZypcTFU3uZMbheZrWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLFg1cmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B792606D52A;
	Thu,  5 Nov 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLFg1cmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C60F1F0089E;
	Thu,  5 Nov 2026 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907286;
	bh=AUrMrHtWoIGyCWfCQQZab5O0fQHAFIVDTlEEoBDLbIs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oLFg1cmz5UeGxXk/xMOWx409jmNDbUQPIFpZFfCX/yq3fk8EKxsuBpwC7bLrwx/bS
	 p3+6oFcjeDmPws+Nen2xo27uIXeliSCX+zobBFEHvj/b383Cno6M2hpAD8RfU/5O6K
	 4YXcMU2K7Q03XbkBicwHkvtJtzMeBsmMbKCXTwyMuMyNtb1T+Bvl7MiGUTScLlWxHl
	 0pAzH3B1tKQLknw8gdP/wAx+iU0dYiB5HklSbjVletj7M1DWsOcDJcfLfj2/NRcau5
	 JuuX2g6qyCzZ45BKen/hbIi21syTG/L7tjQI7uX6Ixjw/IWavjt3ypMsPlxEkAkhHM
	 gXasuic/jU/cA==
Message-ID: <sashiko-outbox-199929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 15/19] PCI/CXL: Restore CXL state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-16-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-16-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:34:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI/CXL: cxl_reset_quiesced() skips disabling device if cache re=
store fails
--

commit 0833e3bda8d31d8ddf0c1310990a9ee4b81a1760
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Restore CXL state after PCI reset

This commit restores PCI configuration, cached HDM decoder settings, and CXL
Device DVSEC control state after a CXL device reset. If any restoration step
fails, it disables the device and updates the saved PCI command state so the
outer PCI reset flow does not re-enable memory decoding or bus mastering.

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index c07266ab01336..77d0e30841d9f 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c

[ ... ]

> @@ -415,7 +572,9 @@ static int cxl_clear_memory(struct pci_dev *pdev, int=
 dvsec, bool initiate)
>  }
> =20
>  static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap,
> -			      struct cxl_hdm_quiesce *q)
> +			      const struct cxl_hdm_info *snapshot,
> +			      struct cxl_hdm_quiesce *q,
> +			      u16 *command)
>  	__must_hold(cxl_region_quiesce)
>  {
>  	int rc, rc2;
> @@ -441,10 +600,15 @@ static int __cxl_reset_execute(struct pci_dev *pdev=
, int dvsec, u16 cap,
>  		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
>  	rc =3D rc ?: rc2;
> =20
> +	if (!rc)
> +		rc =3D pci_cxl_restore_state(pdev, snapshot, command);
> +
>  	rc2 =3D cxl_hdm_quiesce_flush(q);
>  	if (rc2)
>  		pci_err(pdev, "failed to invalidate CPU cache after CXL reset: %d\n", =
rc2);
>  	rc =3D rc ?: rc2;
> +	if (rc)
> +		cxl_reset_save_disabled_state(pdev);
> =20
>  	pci_dev_reset_iommu_done(pdev);
>  	return rc;
> @@ -455,6 +619,7 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, i=
nt dvsec, u16 cap)
>  {
>  	struct cxl_hdm_info *snapshot __free(kfree) =3D NULL;
>  	struct cxl_pci_cache cache =3D {};
> +	u16 command;
>  	int rc, rc2;
> =20
>  	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2,
> @@ -478,11 +643,19 @@ static int cxl_reset_quiesced(struct pci_dev *pdev,=
 int dvsec, u16 cap)
>  		return rc;
>  	}
>  	if (!rc)
> -		rc =3D __cxl_reset_execute(pdev, dvsec, cap, &cache.quiesce);
> +		rc =3D __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
> +					 &command);
>  	/* Restore cache policy after any attempt to disable caching. */
>  	rc2 =3D cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
>  	cxl_hdm_quiesce_destroy(&cache.quiesce);
> -	return rc ?: rc2;
> +	if (rc)
> +		return rc;
> +	if (rc2) {
> +		cxl_reset_save_disabled_state(pdev);
> +		return rc2;
> +	}

[Severity: Medium]
In drivers/pci/cxl.c:cxl_reset_quiesced(), can returning early on if (rc)
before checking if (rc2) skip calling cxl_reset_save_disabled_state(pdev) w=
hen
restoring the CXL cache policy also fails?

Specifically, rc can be non-zero before cxl_reset_save_disabled_state(pdev)=
 is
reached in two cases after CXL caching has been disabled:

1. cxl_reset_cache_prepare() sets cache.cache_disabled =3D true and disables
   caching via cxl_reset_disable_cache(), but cxl_reset_wait_cache_wbi() th=
en
   fails.

2. cxl_reset_cache_prepare() succeeds, and __cxl_reset_execute() returns ea=
rly
   from pci_wait_for_pending_transaction() or pci_dev_reset_iommu_prepare()
   before reaching cxl_reset_save_disabled_state(pdev) at the end of
   __cxl_reset_execute():

drivers/pci/cxl.c:__cxl_reset_execute() {
	if (!pci_wait_for_pending_transaction(pdev)) {
		pci_err(pdev, "timed out waiting for pending transactions\n");
		return -ETIMEDOUT;
	}

	rc =3D pci_dev_reset_iommu_prepare(pdev);
	if (rc) {
		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
		return rc;
	}
	...
}

In either case, pdev->saved_config_space[PCI_COMMAND / 4] still holds the
pre-reset MSE and BME bits. If cxl_reset_restore_cache_policy() then fails
(rc2 !=3D 0), checking if (rc) first returns without calling
cxl_reset_save_disabled_state(pdev), allowing the outer PCI reset path to
re-enable memory decoding and bus mastering on a device whose CXL cache pol=
icy
in PCI_DVSEC_CXL_CTRL2 was not restored.

Should the if (rc2) check call cxl_reset_save_disabled_state(pdev) before
returning rc?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D15
