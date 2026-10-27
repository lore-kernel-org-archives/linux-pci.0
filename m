Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080220;
	b=R+XeemmHPbRYuftwQ5sMUcEAMkXzE+SZhWIwxtLUGxaYB9CRj3GAj0KrbFxA5Ma0P9BU
	 3KZvDqbsww9PGzVWlQ1NN+c+QI7LWLgupGQgpgpTgbsvvNmq9Ka5vZTm3ifIKrFw42acQ
	 X59Fco/9n10Iwn53X4WMhY8nEkWEB5rbdNA+5p0POc31BmYvCWPOe0fjnXY5+PqpBxibR
	 PDCczbQD8WZMtt2X+l8E6vX7SeZVqjoHMQ/rcLLrKR/ODnGOm6/I+ZvavenpByK5uwgHJ
	 pRGgiuWupj4E9ocmKfcjkcPBuBw4s4UURP3PpVJSiHTESnRnjcFjY4OsWd+C6l/ckMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080220;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bp/NpC8jw369vCBYFA4u1VB+cfJNBcVkx7EFvqmV6cg=;
	b=jdcCEyt1Bd8CBSXDvABR5j7PvvDlsIC9Jx2bB23R0koeBN45klyJM0bfsgU8XE6Glcza
	 crnaFO82tdxB4e3/VoNEFAT/Zhk8tVBCWtAmmDqzhewb6zSYJamhMsKdEKO8I+P1YvNds
	 YCL7dW3NOPbCxT574kuwgZN6INNkaQT+yF+k7nfgD36oSpYf6/joEl3nV64FgQWLUcSpX
	 KuLEPJCgDc9joo04b3zlvCH8TloY78AFyf3MINq2Gcda5lpBb/84KUid1bFbpks4WKgB+
	 AD1Q5yZA9H3CtRCi32O7yQ80KnTP2B0o584tZD6IwPU+L9uzFuImcDihxwIFxE6Q0Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEpmvB+L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0387606A31D;
	Tue, 27 Oct 2026 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEpmvB+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EB61F031E0;
	Tue, 27 Oct 2026 05:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793080219;
	bh=Bp/NpC8jw369vCBYFA4u1VB+cfJNBcVkx7EFvqmV6cg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UEpmvB+Lh9zWOHeqYyqS/GRBi09BLBG/I8DLslcoNupSr4dxJjcgXD6p2SgkrGbIL
	 UrhlcaN1Kt00RWQOLq0ueBVYQkXimqwUCGdN+uLyxSlRxYAM+2eNRplH6IuprUEFZW
	 2v8q9ePXMtmT0Wy9d49QKvdCjq+qWcTZ/WjxW7rdIu3OpEMGECmQaHYjsVMWIiYWaZ
	 ALRKPUlJbVVlaLP1DiRWr2wKNetipGLS3gGg1msyh9xI8lAq4kQypt57fn3gQyl0G3
	 mXvTaXasZZh5X4tge/xy5Lb3PWw++N9cdyQejBKCXZRK2eMcGA3wbf5l/X3/9QWS89
	 H+Z0w8NMVPZKQ==
Message-ID: <sashiko-outbox-186143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/23] PCI/TSM: Support connecting to PCIe CMA
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261027052536.1722081-12-alistair.francis@wdc.com>
References: <20261027052536.1722081-1-alistair.francis@wdc.com>
 <20261027052536.1722081-12-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 05:50:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI/TSM: probe_fn() probes sibling TSM hosts without calling conne=
ct()
- [High] PCI/TSM: find_dsm_dev() misidentifies CMA subfunctions as their ow=
n DSM
--

commit 42f160df056909252113f2ee2453b7fc4a07f4ab
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/TSM: Support connecting to PCIe CMA devices

This commit caches PCIe CMA DOE mailbox support in struct pci_dev, splits
the existing DSM check into is_pci_tsm_dsm(), and updates is_pci_tsm_host()
and function walks in drivers/pci/tsm.c so PCIe CMA devices can connect to
a TSM driver.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 10c9c6696624d..03a84630bd69d 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -88,8 +88,8 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
>  		if (!pf)
>  			continue;
> =20
> -		/* on entry function 0 has already run @cb */
> -		if (i > 0)
> +		/* the caller is responsible for running @cb on the host itself */
> +		if (pf !=3D pdev)
>  			cb(pf, data);
> =20
>  		/* walk virtual functions of each pf */

[ ... ]

> @@ -175,6 +175,9 @@ static int probe_fn(struct pci_dev *pdev, void *dsm)
>  	struct pci_dev *dsm_dev =3D dsm;
>  	const struct pci_tsm_ops *ops =3D to_pci_tsm_ops(dsm_dev->tsm);
> =20
> +	if (pdev->tsm)
> +		return 0;
> +
>  	pdev->tsm =3D ops->probe(dsm_dev->tsm->tsm_dev, pdev);
>  	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
>  		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
> @@ -287,6 +290,19 @@ static DEVICE_ATTR_RW(connect);
> =20
>  static int remove_fn(struct pci_dev *pdev, void *data)
>  {
> +	struct pci_dev *host =3D data;
> +	struct pci_tsm_host *tsm_host;
> +
> +	/*
> +	 * Only teardown the security context of functions that belong to the
> +	 * DSM being disconnected, leaving any sibling DSM in the same slot
> +	 * untouched.
> +	 */
> +	if (!pdev->tsm || pdev->tsm->dsm_dev !=3D host)
> +		return 0;
> +
> +	tsm_host =3D to_pci_tsm_host(pdev->tsm);
> +	guard(mutex)(&tsm_host->lock);
>  	tsm_remove(pdev->tsm);
>  	link_sysfs_disable(pdev);
>  	return 0;

[Severity: High]
When connecting a function that has PCI_EXP_DEVCAP_TEE set, can
pci_tsm_connect() -> pci_tsm_walk_fns() -> probe_fn() end up probing
unconnected sibling TSM hosts without calling ops->connect()?

In pci_tsm_connect(), pci_tsm_walk_fns() is invoked whenever has_tee(pdev)
is true:

drivers/pci/tsm.c:pci_tsm_connect() {
	...
	if (has_tee(pdev))
		pci_tsm_walk_fns(pdev, probe_fn, pdev);
	return 0;
}

Because is_pci_tsm_host() now returns true for any non-VF PCIe function with
pdev->doe_cma set, and pci_tsm_walk_fns() visits every physical function in
the slot where pf !=3D pdev, connecting either PF0 to a CMA TSM driver or
connecting a non-PF0 CMA host that has PCI_EXP_DEVCAP_TEE set will call
probe_fn(pf, pdev) on all other physical functions in the slot (as well as
downstream devices when pdev is an upstream port DSM).

In probe_fn(), only functions with pdev->tsm already set are skipped. For an
unconnected sibling host (pf->tsm =3D=3D NULL), ops->probe() is called and
initializes a struct pci_tsm_host via:

  pci_tsm_host_constructor()
    -> pci_tsm_link_constructor()
      -> find_dsm_dev(pf)

Because is_pci_tsm_host(pf) is true, find_dsm_dev(pf) returns pf itself, so
pf->tsm->dsm_dev is set to pf without ops->connect(pf) ever being called.

Wouldn't this leave the sibling function with a populated pf->tsm where:

1. authenticated_show() and connect_show() report the sibling function as
   authenticated and connected without an established SPDM session, and
   connect_store() rejects subsequent connection attempts with -EBUSY.
2. Disconnecting the original host skips the sibling in remove_fn() because
   pf->tsm->dsm_dev !=3D host, leaking pf->tsm.
3. Later disconnecting or removing the sibling invokes
   __pci_tsm_disconnect() -> ops->disconnect() on a device where
   ops->connect() was never called.

Should pci_tsm_connect() only walk subordinate functions when the connected
device is acting as a TDISP DSM, and should probe_fn() avoid probing
independent TSM hosts as subordinate functions?

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 950e2c36a4cae..ddaec2168c7e9 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h

[ ... ]

> @@ -163,6 +167,30 @@ static inline bool is_pci_tsm_host(struct pci_dev *p=
dev)
>  	return PCI_FUNC(pdev->devfn) =3D=3D 0;
>  }
> =20
> +/* device is a TSM host and capable of 'connect' */
> +static inline bool is_pci_tsm_host(struct pci_dev *pdev)
> +{
> +	if (!pdev)
> +		return false;
> +
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	/*
> +	 * Report capable if CMA is supported, which can be supported on any PC=
Ie
> +	 * device.
> +	 */
> +#ifdef CONFIG_PCI_DOE
> +	if (pdev->doe_cma)
> +		return true;
> +#endif
> +
> +	return is_pci_tsm_dsm(pdev);
> +}

[Severity: High]
How does find_dsm_dev() behave when a subordinate physical function
(PF1..PF7) or a downstream endpoint has a CMA DOE mailbox (pdev->doe_cma =
=3D=3D
true), while PF0 or an upstream switch port is acting as the TDISP DSM?

In drivers/pci/tsm.c, find_dsm_dev() checks is_pci_tsm_host(pdev) first:

drivers/pci/tsm.c:find_dsm_dev() {
	if (is_pci_tsm_host(pdev))
		return pdev;

	struct pci_dev *pf0 __free(pci_dev_put) =3D pf0_dev_get(pdev);
	if (!pf0)
		return NULL;

	if (is_dsm(pf0))
		return pf0;
	...
}

Because is_pci_tsm_host(pdev) now returns true for any non-VF PCIe function
with pdev->doe_cma, find_dsm_dev(pdev) will unconditionally return pdev
itself before checking whether PF0 or an upstream port has an active DSM
context (is_dsm(pf0) or is_dsm(uport)):

1. In pci_tsm_init(pdev), dsm =3D find_dsm_dev(pdev) returns pdev instead of
   PF0 or uport, so if (!dsm->tsm) returns early and fails to attach the
   subfunction to the connected DSM.
2. When a TDISP DSM driver probes a subordinate function via probe_fn() ->
   ops->probe() -> pci_tsm_link_constructor(pdev, tsm, tsm_dev), where tsm
   is a base struct pci_tsm rather than a struct pci_tsm_host,
   find_dsm_dev(pdev) sets tsm->dsm_dev =3D pdev. That makes both
   is_dsm(pdev) and is_pci_tsm_host(pdev) true, causing to_pci_tsm_host()
   to perform an invalid container_of(host->tsm, struct pci_tsm_host,
   base_tsm) on a non-host struct pci_tsm and access out-of-bounds memory
   when acquiring &tsm_host->lock in remove_fn(), __pci_tsm_unbind(),
   pci_tsm_bind(), pci_tsm_guest_req(), and bound_show().
3. During DSM disconnect, remove_fn() and __pci_tsm_unbind() skip the
   subordinate function because pdev->tsm->dsm_dev !=3D host, leaking its T=
SM
   context.
4. In __pci_tsm_destroy(), the check:

	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev))
		pci_tsm_disconnect(pdev);
	else
		pci_tsm_fn_exit(pdev);

   will call pci_tsm_disconnect(pdev) -> ops->disconnect(pdev) instead of
   pci_tsm_fn_exit(pdev) on a subordinate function just because it has
   pdev->doe_cma set.

Should find_dsm_dev() and __pci_tsm_destroy() distinguish between a device
that was actually initialized as a host/DSM (such as via is_dsm()) versus a
subordinate function that happens to have a CMA DOE mailbox?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027052536.1722=
081-1-alistair.francis@wdc.com?part=3D11
