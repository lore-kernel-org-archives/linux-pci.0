Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843179;
	b=Wb+9w8OK9UO7mve6hAu1yHcijt7BOwqsx4ihQu8DtjsWbfsA+iVsjhVL6CSQuTONPvCM
	 uAi0+MXdIQ+/1+srq7xkfAV9/pGUy5g/n1xpAVU9OFVk1E1ZFSFXIawAjODZh+jpD2sA9
	 cNipsisZVZ5x4DFGDzWsxLXmCEBAbX56iAhUKH4F9c83vQsw37t/DNnKWmdTaKetNI5x0
	 u7eVjoDUox8rvyJDIRrhghLvTj90Bc7/bOn5UZZC9hV17KBIJ5oGuFA2NulV6K3/SjEZ8
	 8WYUs5CcprqzPmJl7mxRK3+/20oZ7gNLJfvHhlFQ3Zus6FJrpH74Lyxm4GU8pSmFb5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843179;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qGWDJDMNQDqGSZJ7ymUDUjuApl99s+5eMx26rOV4RL4=;
	b=GGNmrNDCDOT3oAmLwzKrWC6l73DPKCMtT2qOyaNXLVFPFuHpM8EsADDr8teE/RHe0JDQ
	 99QNEGQ0EBQbmX7D630F862WYR3mNecj1hg2fcmr5O/ICHgTLHQZiq75BPlBinZp6p3O7
	 lxwcWtToWr0Xv4hsu/snqJRKf8tRbAKAq5P8DdiPyv2ThK5GLaBneWXak8VzssUYSk6RH
	 WFI3IousraRDrCeO2Vm1vy/PnNUorMEfZiQlUMdyAwqgaHQartQecaVg2cyaOZB/6s5fc
	 6PeVxslam5xTtoeNR9eC5F56CZl4O8oCL7VtqYfhZXy/hZlz9K05MRx7K29Z3mtLQXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TLz/Gilp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F3606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLz/Gilp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67131F000C4;
	Mon, 16 Nov 2026 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843179;
	bh=qGWDJDMNQDqGSZJ7ymUDUjuApl99s+5eMx26rOV4RL4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TLz/Gilp0+SuaK+5eovhuF7u9HU9G3jAUG2CXawLdFV+qD+J7TN1JHDS+R6ue4/bY
	 kTMYhoztTB9CKu4+jl7mMDCc2ZYimqGNNCWl9Cg3wLEJevnNdSXcmP9QZLpOb2SYzX
	 KjdTP8sYv9LUs5IcnBFDcp6xMWukkHeVYoYEhTeOYySdYkDaJR/wD4oAk9xD3rBtWS
	 B9SFklFoTK49xNtiyugpv53mU/qO0hEcguD+URCt/AEwAwW2sryNOoIYywV5662YuR
	 o7ndm9ojgDMkTkZ/ip8uCSWX9horaOrBbOF07Tv/UielnBaVbC25HpAMznU0rtiQsT
	 duJ+X3V2R1ZYA==
Message-ID: <sashiko-outbox-217288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] PCI: Use guard(&pci_bus_sem) in
 pci_do_resource_release_and_resize()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-4-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:32:58 +0000
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
- [Low] PCI: guard() mixed with goto cleanup in
  pci_do_resource_release_and_resize()
--

commit 07aa8866ad5508b25df182c6f66b51bc1b05efd3
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Use guard(&pci_bus_sem) in pci_do_resource_release_and_resize()

This commit replaces the manual down_read() and up_read() calls on
pci_bus_sem in pci_do_resource_release_and_resize() with
guard(rwsem_read).

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 29ec9ba59d928..f95f217f94e69 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2398,7 +2398,7 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>  	if (ret)
>  		return ret;
> =20
> -	down_read(&pci_bus_sem);
> +	guard(rwsem_read)(&pci_bus_sem);
> =20
>  	pci_dev_for_each_resource(pdev, r, i) {
>  		if (i >=3D PCI_BRIDGE_RESOURCES)
> @@ -2435,7 +2435,6 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>  	}
> =20
>  out:
> -	up_read(&pci_bus_sem);
>  	pci_dev_res_free_list(&saved);
>  	return ret;
> =20

[Severity: Low]
This isn't a bug, but using guard(rwsem_read) here mixes scope-based
cleanup with the existing goto restore and goto out unwind paths in
pci_do_resource_release_and_resize(), contrary to the include/linux/cleanup=
.h
guidelines against mixing guard() and goto error handling in the same
function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D3
