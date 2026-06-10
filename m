Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC33750AD
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086674; cv=none; b=niPTDxqBYaMrApEU9Z+E2FjXBHnwts8rXGFYp2/3znlpkJ8etstRyuMpm8OAD2s2lGgPQStT7lh+G1n4Pf7Iojs3bT6Iqt6Ag4qBpvQ/jMyMqm+lqUenUT7GNEeaQmn5k3hGzgWj8qXuA/jxkUx6GZoTfSO7pcMIY83lLgH41dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086674; c=relaxed/simple;
	bh=oQY+gyuLbB6p2xD+i9KrjBOmSELgm6fyMfyOWPlT5DY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPjNOyYqTTy9FXV3cEPCqITvHA0yA8u3kywCCCZ5ZVGgEuf/cxfm8SEpMs96iiWUJRG8Ve7wRhqIz8xJfOVN0MYPBW25KcLSqHkrkRtIRAsTa1Uhqfm9nuK1+sTmq4T+JmTWRQc/KnZGp7AAe/+JUj9JrjILJMcWT/KjN6bu/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUbRRkus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUbRRkus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8E21F00893;
	Wed, 10 Jun 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781086672;
	bh=JJozKJMmo3fpIDZCGzSqhpxfGV9QcSwzaq+2xQxP4e0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUbRRkusIqlaCa6a6SvwUeRwl8DL/oq8dswzr1XnbHW+m3gKdVus8WQvNsvu8IOcA
	 4bnhpZHMpg/6QGoK0dgO5AIzmMjsjzVEtl8IhC20jgGNMA9a3lObEUJn0+1urXgfD+
	 63d7CLGLQHwDYEwpdoj5/JqwiK20IaoTMWOti4g/dn7rW0zlb8/l3iNdLYkeyBZlOK
	 Z9XsPJk2sj32/Iqzu0Sqw2J1sK6FvxtXkb8hbgJfKc/U9JK+v/vUhXCD5cdeH3FAzG
	 ZQpsNMPD1LFpHUOoS0o3TtZLP6iOPNEbh+2Rmt70sMZCuqjrAXlqac1vUTNEN+/qL0
	 2PmtGRkFLUXLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] PCI: endpoint: Add support for DOE
 initialization and setup in EPC core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260610100256.1889111-4-a-garg7@ti.com>
References: <20260610100256.1889111-4-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 10:17:51 +0000
Message-Id: <20260610101752.5A8E21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Lockless check of `epc->init_complete` in `pci_epc_init_notify()` =
and `pci_epc_deinit_notify()` creates a race condition leading to double in=
itialization or double destruction of DOE mailboxes.
- [High] Queueing a task on a mailbox's workqueue races with workqueue dest=
ruction.
- [Medium] DOE capability discovery completely skips Virtual Functions (VFs=
).
- [Medium] Inconsistent capability check assumes Physical Function 0 (PF0) =
dictates controller-wide DOE features.
- [Medium] DOE mailboxes and workqueues are leaked if the endpoint controll=
er is destroyed without a prior `pci_epc_deinit_notify()` call.
--

commit f40c46636c83315eee171f04597bcd6e1bbbedab
Author: Aksh Garg <a-garg7@ti.com>

PCI: endpoint: Add support for DOE initialization and setup in EPC core

This commit adds pci_epc_init_capabilities() and pci_epc_deinit_capabilitie=
s()
to the EPC core driver to initialize and tear down DOE capabilities. It
discovers and registers DOE mailboxes for the functions in the endpoint
controller.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 6c3c58185fc5d..e48f40eeed290 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c

[ ... ]

> @@ -842,6 +844,81 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkdown);
> =20
> +/**
> + * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functi=
ons

[ ... ]

> +static int pci_epc_doe_setup(struct pci_epc *epc)
> +{
> +	u8 func_no, vfunc_no =3D 0;
> +	u16 cap_offset;
> +	int ret;
> +
> +	if (!epc->ops || !epc->ops->find_ext_capability)
> +		return -EINVAL;
> +
> +	/* Discover DOE capabilities for all functions */
> +	for (func_no =3D 0; func_no < epc->max_functions; func_no++) {
> +		mutex_lock(&epc->lock);
> +		cap_offset =3D epc->ops->find_ext_capability(epc, func_no,
> +							   vfunc_no, 0,
> +							   PCI_EXT_CAP_ID_DOE);

[Severity: Medium]
Will this skip Virtual Functions during DOE capability discovery?

The loop iterates over physical functions, but vfunc_no is permanently
hardcoded to 0 here. VFs that advertise DOE capabilities won't be processed.

> +		mutex_unlock(&epc->lock);

[ ... ]

> +static void pci_epc_init_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +	int ret;
> +
> +	epc_features =3D pci_epc_get_features(epc, 0, 0);

[Severity: Medium]
Is it intentional to check capability features exclusively against Physical
Function 0 (PF0)?

If the controller implements DOE on a non-zero function but not PF0, it
seems initialization and cleanup will be skipped entirely. Capability
checks might need to be dynamically evaluated per-function.

> +	if (!epc_features)
> +		return;

[ ... ]

> @@ -857,6 +934,9 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
> =20
> +	if (!epc->init_complete)
> +		pci_epc_init_capabilities(epc);
> +

[Severity: High]
Could checking epc->init_complete without acquiring epc->list_lock lead to
a data race?

If pci_epc_init_notify() is invoked concurrently by different threads,
both might see !epc->init_complete and execute pci_epc_init_capabilities(),
which calls pci_ep_doe_init() twice. This overwrites the xarray internal
lock and leaks previously registered mailboxes.

>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {

[ ... ]

> @@ -890,6 +970,27 @@ void pci_epc_notify_pending_init(struct pci_epc *epc=
, struct pci_epf *epf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
> =20
> +/**
> + * pci_epc_deinit_capabilities() - Cleanup EPC capabilities

[ ... ]

> +static void pci_epc_deinit_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +
> +	epc_features =3D pci_epc_get_features(epc, 0, 0);
> +	if (!epc_features)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
> +		pci_ep_doe_destroy(epc);

[Severity: High]
Does destroying the workqueue here race with task queueing?

When pci_ep_doe_destroy() is called, it eventually destroys the workqueue.
However, in pci_ep_doe_submit_task(), there's a lockless test_bit() check:

    if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
        return -EIO;

    ... queue_work(doe_mb->work_queue, &task->work);

If the workqueue is destroyed right after test_bit() passes, the submission
thread might attempt to queue work on the freed workqueue, leading to a
use-after-free.

[Severity: Medium]
What happens to the DOE mailboxes and workqueues if the endpoint
controller is destroyed without a prior pci_epc_deinit_notify() call?

If the controller driver unbinds and calls pci_epc_destroy() directly,
these resources might be leaked since pci_epc_destroy() does not have a
fallback to clean up dynamically allocated DOE capabilities.

> +		dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
> +	}
> +}

[ ... ]

> @@ -903,6 +1004,9 @@ void pci_epc_deinit_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
> =20
> +	if (epc->init_complete)
> +		pci_epc_deinit_capabilities(epc);
> +

[Severity: High]
Can this lockless check of epc->init_complete race similarly to the one in
pci_epc_init_notify()?

A concurrent call could cause double destruction of DOE mailboxes and
corrupt the xarray.

>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610100256.1889=
111-1-a-garg7@ti.com?part=3D3
