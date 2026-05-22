Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A023AB9D
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432569; cv=none; b=pXbLK6mazlf3b1Qk/lagGFTxS+H4uU3tlUZElP8NbbZdi2oYZbbMDxCs0zaHx0owLg3lYYk5nIcyZrw5FPxq2O4cGln6hhy5LVtg3LKXIxQQRFHQo8BcUwioiDDfYWTronmIXwOkTvmO5Cj1ZKpdlR4K2dIpETkVQmKzrtA7fso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432569; c=relaxed/simple;
	bh=aWAoHLoFkoSDKSa4p8g8TyY+x3Nf8boGC071QFYT6hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ILkwHYK9YyaQzdMWIqApf9uLPY/PzwlGAywiekoJw2V9oF57HggWqR23wgu06wRfGlRWCynvlnlSdDdyr5DdNIl9MGdxpseDbEZdN8oKQ4AKDDcgXe5TxHMJF+Tu4kxVabqozR2JSjmO8VjgA+7h5jZf5dNjvslhgcwEzzcIjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owliyhEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owliyhEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B674C1F000E9;
	Fri, 22 May 2026 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779432567;
	bh=2OPC2619RpH8iag5tvjiiNRoi559TC1jMTOv2S+h85Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owliyhEOiW3odI/U5zgePcmLqNLM1MTOb9/MMhm+eBJN+Tf/a4bfpTA9fULVYsx2l
	 yU3CdpEfP7WCuhYlGamLh03jZgbDwec1LirQfr63EKt+d11tcwAttSdg22eV+Hloig
	 GQlDr45Ofo9iAIEoPXERRHjrzgcEp52RuVg9VUupk9h2Rbk8JbNDtw0vuscWH7Gfiv
	 R+WVIq0aakdpQvq9D6Ij2Z78j36jYJxJr1PEApisPzzMhgcvGJONvYLm9q5GG627mo
	 aO9Z69OmWofzouoJ28l6qens8FzeWgXy1YkzzPyy8+sfrs7oqPa6TZeqaw4ApgxGnB
	 V7vVRO3kS7RlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] PCI: endpoint: Add support for DOE
 initialization and setup in EPC core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522052434.802034-4-a-garg7@ti.com>
References: <20260522052434.802034-4-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 06:49:27 +0000
Message-Id: <20260522064927.B674C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Calling `pci_epc_deinit_notify()` before `pci_epc_init_notify(=
)` triggers a kernel panic when destroying an uninitialized xarray.
- [High] Hardcoding Physical Function 0 (PF0) to check capabilities breaks =
endpoints with asymmetric DOE support.
- [High] The `find_ext_capability` controller operation is called without h=
olding the required `epc->lock`.
- [High] Destroying EPC capabilities before notifying EPF drivers creates a=
 Use-After-Free risk.
- [Medium] Repeated invocations of `pci_epc_init_notify()` silently leak ex=
isting DOE mailboxes and corrupt the xarray.
- [Medium] DOE mailboxes on Virtual Functions (VFs) are ignored during disc=
overy and setup.
- [Medium] The `cap` parameter in the `find_ext_capability` op is an 8-bit =
integer, truncating 16-bit PCIe Extended Capability IDs.
--

commit 2d1f89c68bd01b16c5b22686d5e612b5c77a0616
Author: Aksh Garg <a-garg7@ti.com>

PCI: endpoint: Add support for DOE initialization and setup in EPC core

This commit adds pci_epc_init_capabilities() and pci_epc_deinit_capabilitie=
s()
to the EPC core driver to initialize and tear down DOE capabilities. It
discovers DOE mailboxes for physical functions and registers them within the
controller.

> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/p=
ci-epc-core.c
> index 6c3c58185fc5d..af7889b541c05 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
[ ... ]
> @@ -842,6 +844,71 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_linkdown);
> =20
> +/**
> + * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functi=
ons
> + * @epc: the EPC device on which DOE mailboxes has to be setup
> + *
> + * Discover DOE (Data Object Exchange) capabilities for all physical fun=
ctions
> + * in the endpoint controller and register DOE mailboxes.
> + *
> + * Returns: 0 on success, -errno on failure
> + */
> +static int pci_epc_doe_setup(struct pci_epc *epc)
> +{
> +	u16 cap_offset =3D 0;
> +	u8 func_no;
> +	int ret;
> +
> +	if (!epc->ops || !epc->ops->find_ext_capability)
> +		return -EINVAL;
> +
> +	/* Discover DOE capabilities for all functions */
> +	for (func_no =3D 0; func_no < epc->max_functions; func_no++) {
> +		while ((cap_offset =3D epc->ops->find_ext_capability(epc, func_no, 0,

[Severity: Medium]
Does this logic bypass Virtual Functions (VFs)? The loop iterates over
physical functions but passes a hardcoded 0 for vfunc_no to
find_ext_capability(). Since VFs can also possess extended capabilities,
it seems they are excluded from DOE discovery.

[Severity: High]
Is it safe to invoke epc->ops->find_ext_capability() without holding the
epc->lock? Other hardware operations in the PCI endpoint core appear to be
strictly protected by this lock to prevent concurrent accesses to the shared
controller registers.

> +								   cap_offset,
> +								   PCI_EXT_CAP_ID_DOE))) {
> +			/* Register this DOE mailbox */
> +			ret =3D pci_ep_doe_add_mailbox(epc, func_no, cap_offset);
> +			if (ret) {
> +				dev_warn(&epc->dev,
> +					 "[pf%d:offset %x] failed to add DOE mailbox\n",
> +					 func_no, cap_offset);
> +			}
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
> + * Invoke to initialize capabilities supported by the EPC device.
> + */
> +static void pci_epc_init_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +	int ret;
> +
> +	epc_features =3D pci_epc_get_features(epc, 0, 0);

[Severity: High]
Could this hardcoded check of Physical Function 0 (PF0) break endpoints that
have asymmetric DOE support? If PF0 is not doe_capable, the setup is entire=
ly
skipped, even if other physical functions like PF1 support DOE.

> +	if (!epc_features)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
> +		ret =3D pci_ep_doe_init(epc);
> +		if (ret) {
> +			dev_warn(&epc->dev, "DOE initialization failed: %d\n", ret);
> +			return;
> +		}
> +
> +		ret =3D pci_epc_doe_setup(epc);
> +		if (ret)
> +			dev_warn(&epc->dev, "DOE setup failed: %d\n", ret);
> +	}
> +}
> +
>  /**
>   * pci_epc_init_notify() - Notify the EPF device that EPC device initial=
ization
>   *                         is completed.
> @@ -857,6 +924,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
> =20
> +	pci_epc_init_capabilities(epc);
> +

[Severity: Medium]
What happens if pci_epc_init_notify() is invoked multiple times? Without
checking if the EPC is already initialized (e.g. epc->init_complete),
xa_init(&epc->doe_mbs) is called unconditionally. This would overwrite the
xarray head pointer and lock, silently orphaning previously allocated mailb=
ox
elements and their workqueues.

>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
[ ... ]
> @@ -890,6 +959,27 @@ void pci_epc_notify_pending_init(struct pci_epc *epc=
, struct pci_epf *epf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
> =20
> +/**
> + * pci_epc_deinit_capabilities() - Cleanup EPC capabilities
> + * @epc: the EPC device whose capabilities need to be cleaned up
> + *
> + * Invoke to cleanup capabilities supported by the EPC device,
> + * and free the associated resources.
> + */
> +static void pci_epc_deinit_capabilities(struct pci_epc *epc)
> +{
> +	const struct pci_epc_features *epc_features;
> +
> +	epc_features =3D pci_epc_get_features(epc, 0, 0);

[Severity: High]
Similar to the initialization side, is it intentional to hardcode the featu=
re
check to PF0 here?

> +	if (!epc_features)
> +		return;
> +
> +	if (IS_ENABLED(CONFIG_PCI_ENDPOINT_DOE) && epc_features->doe_capable) {
> +		pci_ep_doe_destroy(epc);
> +		dev_dbg(&epc->dev, "DOE mailboxes destroyed\n");
> +	}
> +}
> +
>  /**
>   * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitializ=
ation
>   * @epc: the EPC device whose deinitialization is completed
> @@ -903,6 +993,8 @@ void pci_epc_deinit_notify(struct pci_epc *epc)
>  	if (IS_ERR_OR_NULL(epc))
>  		return;
> =20
> +	pci_epc_deinit_capabilities(epc);
> +

[Severity: Critical]
Can this cause a panic if pci_epc_deinit_notify() is called before
pci_epc_init_notify()?

Some endpoint drivers (like pcie-qcom-ep) explicitly call the deinit notify
on the first PERST deassertion before initialization. Because this
unconditionally calls pci_epc_deinit_capabilities(), it will invoke
xa_destroy() on an uninitialized xarray, potentially triggering a
panic due to bad spinlock magic.

Would it be safer to check epc->init_complete first?

[Severity: High]
Does destroying the EPC capabilities before notifying the EPF drivers creat=
e a
use-after-free risk? The underlying DOE mailboxes and workqueues are freed
here, but the bound EPF drivers are still active and will only be notified
to quiesce in the loop below.

>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
[ ... ]
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index dd26294c8175a..11474e337db33 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
[ ... ]
> @@ -115,6 +117,8 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	u16	(*find_ext_capability)(struct pci_epc *epc, u8 func_no,
> +				       u8 vfunc_no, u16 start, u8 cap);

[Severity: Medium]
Will passing u8 for the cap parameter truncate 16-bit PCIe Extended
Capability IDs? While PCI_EXT_CAP_ID_DOE fits in 8 bits, this API contract
truncates any future standard or vendor-specific capability IDs > 255.
Should the parameter be declared as u16 instead?

>  	struct module *owner;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522052434.8020=
34-1-a-garg7@ti.com?part=3D3
