Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E72E35E94E
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206674; cv=none; b=SjRsvHINW+Te7w6hD8yYLeqYOUPTzYTkao1IRAIuyFqDSHpzZrMdCX73lQfktpDWElCLLgmssvQJjWqDUOG/bIjzwGyEqJULZf1Iggz6EzUoYR8s2u6CVDCapCkRe1RGczMl3AhYITXvWxHXWZltd8tfCeGqz4EXrJ4vYUT/oTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206674; c=relaxed/simple;
	bh=uEFb8b+UDEYFV3ka7FBQ4buQauQNx3FoZGtThWGCFqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fKIWHfX1ePzVUqIDHxYPn+74KN7ztNX1iMv1VBpDqKC6Tyd0/RLQ29Y53rb96vMODz3zv0g6EOl0IKbaYOYC9ctZKeRfFJif/NZFX3yxz/kGooSOF8M53wqYbcsb7iBeTa0FNbGyBMKWkp9/3XKmUFXhi2K40q9X95HUSi9rsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRvpYjr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRvpYjr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1728C1F000E9;
	Tue, 23 Jun 2026 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206673;
	bh=2owstU9mBjp28N+P0R/yRhuH5bcJdfAtAOZ+MeBmifE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WRvpYjr717sppUaZLKdmf85rFtcAmW1F6FCvpqPU/EVBoDhpJYUb1Tq8GQgYynWhR
	 rmdRTwpanIVCEz7PLu4V/+YGP6WoeLxmHT5XDxT/uWMjNjH+JYVEtCYYILVMUzafe3
	 RVOFGVpPs1aQkdDu9dULd+2/A6/J1s63fvyWlihOJCBqdiIr6iZG0oJd/4eoE5/ruR
	 gCLfdLxE3DN119bVdBoxc7tISo3ys71mjcbBxbDzEgywIajcWtdhT6TF7YvgdUib68
	 200bA1R8mIh7eAc+jodUiIOAJ34iuL7DCSOlPD41spuIVDnY0UEWfF1xwSlAGVdEDY
	 TTPsgVFbJpf+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] PCI: endpoint: Add support for DOE
 initialization and setup in EPC core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623090737.711656-4-a-garg7@ti.com>
References: <20260623090737.711656-1-a-garg7@ti.com>
 <20260623090737.711656-4-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:24:32 +0000
Message-Id: <20260623092433.1728C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unprotected check of epc->init_complete causes a TOCTOU race in pc=
i_epc_init_notify() and pci_epc_deinit_notify(), leading to double initiali=
zation, memory leaks, and xarray corruption.
- [High] Logic Flaw: DOE mailboxes are never initialized because pci_epc_in=
it_notify() is called before functions are bound.
- [High] Incorrect teardown ordering in pci_epc_deinit_notify() causes a Us=
e-After-Free during shutdown.

Pre-existing issues:
- [High] TOCTOU data race in pci_epc_notify_pending_init() sends spurious e=
pc_init events after deinitialization.
--

commit 1a369cd1d0a1ffe8ebc7c7242501b1fde9e422c9
Author: Aksh Garg <a-garg7@ti.com>

PCI: endpoint: Add support for DOE initialization and setup in EPC core
   =20
Add pci_epc_init_capabilities() in EPC core driver to initialize and setup
capabilities supported by the EPC driver. This calls pci_epc_doe_setup() to
setup the DOE framework for an endpoint controller, which discovers DOE
capabilities and registers mailboxes. It also adds cleanup.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 6c3c58185fc5d..96bd624559f2a 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
[ ... ]
> @@ -842,6 +844,78 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkdown);
> =20
> +/**
> + * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functi=
ons
> + * @epc: the EPC device on which DOE mailboxes has to be setup
> + *
> + * Discover DOE (Data Object Exchange) capabilities for all physical
> + * functions in the endpoint controller and register DOE mailboxes.
> + *
> + * Return: 0 on success, -errno on failure
> + */
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

[Severity: High]
Does hardcoding vfunc_no to 0 completely omit DOE mailbox discovery and
initialization for SR-IOV virtual functions?

> +		mutex_unlock(&epc->lock);
> +
> +		while (cap_offset) {
[ ... ]
> +		}
> +	}
> +
> +	dev_dbg(&epc->dev, "DOE mailboxes setup complete\n");
> +	return 0;
> +}
> +
> +/**
> + * pci_epc_init_capabilities() - Initialize EPC capabilities
> + * @epc: the EPC device whose capabilities need to be initialized
> + *
> + * Initialize capabilities supported by the EPC device.
> + */
> +static void pci_epc_init_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +	int ret;
> +
> +	epc_features =3D pci_epc_get_features(epc, 0, 0);
> +	if (!epc_features)
> +		return;

[Severity: High]
Could pci_epc_get_features() return NULL here and silently bypass DOE
initialization?

If pci_epc_init_notify() is invoked during controller probe before any
Endpoint Function (EPF) drivers are bound, pci_epc_get_features() may fail.

Since the functions are not bound yet, the function_num_map could be 0,
causing the initialization to abort immediately without setting up the
mailboxes.

> +
> +	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
[ ... ]
> +	}
> +}
> +
>  /**
>   * pci_epc_init_notify() - Notify the EPF device that EPC device initial=
ization
>   *                         is completed.
> @@ -857,6 +931,9 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
> =20
> +	if (!epc->init_complete)
> +		pci_epc_init_capabilities(epc);
> +

[Severity: High]
Can a concurrent caller hit this unprotected check, bypassing the intended
protection?

Because the epc->init_complete condition is evaluated locklessly outside
epc->list_lock, multiple threads could proceed to initialize the
capabilities.

This double initialization might lead to memory leaks, as xa_init() would
reset the xarray pointers without freeing the already allocated elements.

>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
[ ... ]
> @@ -890,6 +967,27 @@ void pci_epc_notify_pending_init(struct pci_epc *epc=
, struct pci_epf *epf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);

[Severity: High]
This isn't a bug introduced by this patch, but does the lockless check of
init_complete in pci_epc_notify_pending_init() allow a race condition
with deinitialization?

If a hardware link-down event triggers pci_epc_deinit_notify()
concurrently, pci_epc_notify_pending_init() could read the flag before it
is cleared, and subsequently send spurious epc_init events after the
hardware has been stopped.

> +
> +/**
> + * pci_epc_deinit_capabilities() - Clean up EPC capabilities
[ ... ]
> @@ -903,6 +1001,9 @@ void pci_epc_deinit_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
> =20
> +	if (epc->init_complete)
> +		pci_epc_deinit_capabilities(epc);
> +

[Severity: High]
Does this unprotected check of init_complete allow multiple threads to
concurrently destroy the mailboxes, potentially leading to double-free
crashes?

>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
>  		if (epf->event_ops && epf->event_ops->epc_deinit)
>  			epf->event_ops->epc_deinit(epf);
>  		mutex_unlock(&epf->lock);
>  	}

[Severity: High]
Does freeing the capability before iterating over the EPF list to send
the epc_deinit notification cause a use-after-free?

If an EPF driver attempts to flush or interact with a DOE mailbox during
its shutdown callback, it would access already freed memory. Teardown
generally needs to be the exact reverse of initialization, notifying EPFs
to stop using the hardware before destroying the underlying capabilities.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623090737.7116=
56-1-a-garg7@ti.com?part=3D3
