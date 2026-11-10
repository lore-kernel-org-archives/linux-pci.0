Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285914;
	b=x4dmN8aQ1immNVJZUAcvpFKI8YaLG5lxo9WLe2/FWcI57BM8zaubT0n0QE8uDMPu/41f
	 aMk7+b/0df7TstQsrMvqkC+tLGpd5Wc+QepueSE6S5Omo7ubNM62Jri7jTLXjAmvbsWMj
	 2q+qzZrT27b5Le6pgWUMRkHqqmW9GpljC2gM1gdwFrbYLLbJ3GFN6egNJqcqeNcCXMGxr
	 Vp/iGav/EwUkPfQUwTv7LwTOpKCDM59CcpUxO/E/lOXAvTwV15x/CE4KoOFTvWGY3eFC+
	 Ri3JWCf00o7Om3lQ4n8sZxrInSkgDvgU+F0GJoN5OtPAxktwRjiA2M5OpkP1OiVLK/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DLUS0ohbY75D3KXKC51AJforq+5TBGMFqeDtpjTEy+c=;
	b=CMvL8Fy7jTvpRhKw5adtOOTk+FIlArx6YgLe1vQ9kYHWcsouikEVod7bcYthpn4ZKD1I
	 Xoq6XGW7p0H1dgvl8Pg1F7oCJ09hcc/xU1RRBpsUQo637h/jizNfIXyvnHur3nKpiED4Y
	 vXiYDp9+L/pj6n4Q47sJ02fPj4FljukdAVrurosFk99cSSONwIPL4P/Pf9ww/TNIVrpb/
	 eQHdi44KWpO1r1WoWgscjEXQjqoHUIJVcQRz5Y/B2uHWf8LMestxTQIWJHWbNlPPAoZ48
	 GtUoGXl42H11EaWv76YgJTO/vTt2ZvEdRCCDZge9/Ax+f8MSbRsR/oVUcRGyZX8sBAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2X28vDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA030606A326;
	Tue, 10 Nov 2026 04:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S2X28vDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E751F0089F;
	Tue, 10 Nov 2026 04:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285912;
	bh=DLUS0ohbY75D3KXKC51AJforq+5TBGMFqeDtpjTEy+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2X28vDtPgW4nDapAQ+wCwlGxCFcFFYWYZ5SRbdkoIcJnyavnUvhEIdF/kdAsuvZj
	 su0AklV6/l5qneZy6Uz8bGWfdQXNCG9o9C65gDrdPPY9Y+iiUqfA9QxMO+vMEe6t5V
	 VYn1CI1nCF1w7um9zcX1+JXHgpHhixQqRoYpWDUxNlt3gIf3URKvduU+tB5uLaIMvb
	 xazaLBmV+vEHcjeVu/DNerPhHOdgHndcsi2RiYjG16b4h8/3Wu5W4E7kTH5MmSspl9
	 srHGK0C1DkcNGbyrMUXr/tZGrWlYhynzYQlhPilnDb5UzSG7YZAIo2w/OU1knsP/tK
	 +OIgt57i3jM6g==
Message-ID: <sashiko-outbox-206234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/25] PCI/TSM: Support connecting to PCIe CMA
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261110041832.1730924-12-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-12-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:45:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] PCI/TSM: find_dsm_dev() treats plain CMA PF0/uport as DSM for
  subfunctions
- [High] PCI/TSM: probe_fn() constructs subordinate pci_tsm_host without
  connect()
- [Medium] PCI/TSM: remove_fn() skips link_sysfs_disable() during
  pci_tsm_unregister()
- [Medium] PCI/TSM: disconnect_store() does not verify is_dsm() under
  pci_tsm_rwsem
--

commit 71288b5ca3a729f150677c17fac34c3e0b86742a
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/TSM: Support connecting to PCIe CMA devices

This commit adds a helper to distinguish DSM devices from general TSM hosts,
caches CMA DOE mailbox presence on struct pci_dev, and updates TSM connect,
disconnect, and lookup paths to support independent CMA-capable PCIe
functions.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 10c9c6696624d..170e53ae4a0a0 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
[ ... ]
> @@ -221,8 +224,13 @@ static int pci_tsm_connect(struct pci_dev *pdev, str=
uct tsm_dev *tsm_dev)
>  	 * is the ultimate arbiter of security state relative to a given
>  	 * interface id, and if it says it can manage TDISP state of a function,
>  	 * let it.
> +	 *
> +	 * Only a function in a valid DSM position (function0 or upstream
> +	 * port) with TEE capability manages subordinate functions. A plain
> +	 * CMA host manages only itself, leaving sibling functions available
> +	 * to be connected independently.
>  	 */
> -	if (has_tee(pdev))
> +	if (has_tee(pdev) && is_pci_tsm_dsm(pdev))
>  		pci_tsm_walk_fns(pdev, probe_fn, pdev);
>  	return 0;
>  }

[Severity: High]
Can pci_tsm_walk_fns() here still construct a subordinate struct
pci_tsm_host via probe_fn() without ever calling ops->connect()?

When PF0 of a multi-function device (or an upstream switch port) has
PCI_EXP_DEVCAP_TEE set, pci_tsm_connect() walks all sibling or downstream
functions and calls probe_fn() -> ops->probe().  Because
pci_tsm_host_constructor() delegates to pci_tsm_link_constructor() ->
find_dsm_dev() without requiring dsm_dev =3D=3D pdev, any TSM driver whose
probe() allocates a struct pci_tsm_host for matching devices (such as a CMA
TSM driver matching pdev->doe_cma on PF1, or dsm_probe() in sev-dev-tsm.c
matching is_pci_tsm_dsm() on a downstream endpoint PF0 below an upstream
port DSM) succeeds in probe_fn() with base_tsm.dsm_dev set to the parent DSM
and without ops->connect() running.

For a sibling CMA function, sysfs then reports it as connected and
authenticated while hiding tsm/connect and tsm/disconnect, preventing
userspace from authenticating it.  Should pci_tsm_host_constructor() reject
subordinate probing when find_dsm_dev() does not return pdev (or should
subordinate probing be skipped for TSM drivers that only manage self-hosted
connections)?

> @@ -287,6 +295,19 @@ static DEVICE_ATTR_RW(connect);
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

[Severity: Medium]
Does returning early on !pdev->tsm skip link_sysfs_disable() for subordinate
functions during pci_tsm_unregister()?

pci_tsm_unregister() walks PCI devices in reverse order via
for_each_pci_dev_reverse(), visiting VFs and higher-numbered PFs before PF0.
On each subordinate function, __pci_tsm_destroy() only calls
link_sysfs_disable() when is_pci_tsm_host(pdev) && !pci_tsm_link_count, and
then calls pci_tsm_fn_exit() -> tsm_remove(), which clears pdev->tsm to
NULL:

drivers/pci/tsm.c:__pci_tsm_destroy() {
	if (is_link_tsm(tsm_dev) && is_pci_tsm_host(pdev) && !pci_tsm_link_count)
		link_sysfs_disable(pdev);
	...
	if (is_link_tsm(tsm_dev) && is_dsm(pdev))
		pci_tsm_disconnect(pdev);
	else
		pci_tsm_fn_exit(pdev);
}

When __pci_tsm_destroy() later reaches the DSM and runs
pci_tsm_disconnect() -> pci_tsm_walk_fns_reverse(pdev, remove_fn, pdev),
pdev->tsm is already NULL on those subordinates, so remove_fn() now returns
early before calling link_sysfs_disable(pdev).  That leaves stale sysfs
attribute visibility on VFs and non-host PFs (or on subordinate CMA PFs when
another link TSM remains registered).  Calling link_sysfs_disable(pdev) in
pci_tsm_fn_exit() would ensure subordinate sysfs groups are updated before
pdev->tsm is cleared.

[ ... ]

> @@ -587,8 +618,17 @@ static umode_t pci_tsm_attr_visible(struct kobject *=
kobj,
> =20
>  		if (attr =3D=3D &dev_attr_connect.attr ||
>  		    attr =3D=3D &dev_attr_disconnect.attr) {
> -			if (is_pci_tsm_host(pdev))
> +			if (is_pci_tsm_host(pdev)) {
> +				/*
> +				 * Hide while the function is managed by
> +				 * another DSM, so userspace cannot connect()
> +				 * it independently or disconnect() a context
> +				 * that connect() never established.
> +				 */
> +				if (pdev->tsm && !is_dsm(pdev))
> +					return 0;
>  				return attr->mode;
> +			}
>  		}
>  	}

[Severity: Medium]
Should disconnect_store() also verify is_dsm(pdev) while holding
pci_tsm_rwsem?

pci_tsm_attr_visible() hides tsm/disconnect when pdev->tsm && !is_dsm(pdev),
but if userspace opens a subordinate host-capable function's tsm/disconnect
attribute before its DSM connects and writes to it afterwards,
disconnect_store() only checks !pdev->tsm:

drivers/pci/tsm.c:disconnect_store() {
	...
	if (!pdev->tsm)
		return -ENXIO;
	...
	pci_tsm_disconnect(pdev);
}

That calls ops->disconnect() and tsm_remove() on a subordinate context that
was never established via ops->connect().  Checking !is_dsm(pdev) in
disconnect_store() prevents this race.

> @@ -662,14 +702,15 @@ static struct pci_dev *find_dsm_dev(struct pci_dev =
*pdev)
>  	struct device *grandparent;
>  	struct pci_dev *uport;
> =20
> -	if (is_pci_tsm_host(pdev))
> -		return pdev;
> -
>  	struct pci_dev *pf0 __free(pci_dev_put) =3D pf0_dev_get(pdev);
> -	if (!pf0)
> -		return NULL;
> =20
> -	if (is_dsm(pf0))
> +	/*
> +	 * Functions subordinate to an active DSM are managed by that DSM,
> +	 * even if the function itself has a CMA DOE mailbox. Check for the
> +	 * DSM context before considering this function to be its own TSM
> +	 * host.
> +	 */
> +	if (pf0 && pf0 !=3D pdev && is_dsm(pf0))
>  		return pf0;
> =20
>  	/*
> @@ -677,20 +718,24 @@ static struct pci_dev *find_dsm_dev(struct pci_dev =
*pdev)
>  	 * downstream devices, check the first upstream port relative to this
>  	 * endpoint.
>  	 */
> -	if (!pdev->dev.parent)
> -		return NULL;
> -	grandparent =3D pdev->dev.parent->parent;
> -	if (!grandparent)
> -		return NULL;
> -	if (!dev_is_pci(grandparent))
> -		return NULL;
> -	uport =3D to_pci_dev(grandparent);
> -	if (!pci_is_pcie(uport) ||
> -	    pci_pcie_type(uport) !=3D PCI_EXP_TYPE_UPSTREAM)
> -		return NULL;
> +	if (pdev->dev.parent) {
> +		grandparent =3D pdev->dev.parent->parent;
> +		if (grandparent && dev_is_pci(grandparent)) {
> +			uport =3D to_pci_dev(grandparent);
> +			if (pci_is_pcie(uport) &&
> +			    pci_pcie_type(uport) =3D=3D PCI_EXP_TYPE_UPSTREAM &&
> +			    is_dsm(uport))
> +				return uport;
> +		}
> +	}
> +
> +	/*
> +	 * With no DSM context above it, a TSM host capable function (e.g.
> +	 * one with a CMA DOE mailbox) is its own host.
> +	 */
> +	if (is_pci_tsm_host(pdev))
> +		return pdev;
> =20
> -	if (is_dsm(uport))
> -		return uport;
>  	return NULL;
>  }

[Severity: High]
Does find_dsm_dev() misidentify a plain CMA host on PF0 (or on an upstream
port) as the DSM for sibling or downstream functions?

is_dsm() only checks pdev->tsm && pdev->tsm->dsm_dev =3D=3D pdev, which is =
true
for any self-hosted connected function, including a plain CMA host without
PCI_EXP_DEVCAP_TEE.  When PF0 on a multi-function CMA device is connected
first, pci_tsm_connect() skips subordinate probing because has_tee(pf0) is
false, leaving PF1 to be connected independently.  However, when PF1 is
later connected via pci_tsm_connect() -> pci_tsm_host_constructor() ->
pci_tsm_link_constructor() -> find_dsm_dev(pf1), is_dsm(pf0) is true, so
find_dsm_dev(pf1) returns pf0 instead of pf1.

That sets pf1->tsm->dsm_dev =3D pf0 on PF1's own struct pci_tsm_host:
to_pci_tsm_host(pf1->tsm) then resolves to pf0's pci_tsm_host (using pf0's
lock and DOE mailbox in pci_tsm_doe_transfer()), is_dsm(pf1) becomes false
(hiding PF1's connect and disconnect sysfs attributes), and disconnecting
pf0 or destroying pf1 tears down pf1->tsm via remove_fn() or
pci_tsm_fn_exit() without calling ops->disconnect(pf1).

Should find_dsm_dev() (and pci_tsm_init()) also require has_tee() and
is_pci_tsm_dsm() on pf0 and uport, matching the check in pci_tsm_connect()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D11
