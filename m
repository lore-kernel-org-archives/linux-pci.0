Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AA3ABD80
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212793; cv=none; b=D6p2O06pmVbW+RaVdx+ZJ6st5Sb5mgTZFE3evAIhnDhOGJv/O5GINF65ty5icQAf24TQPNy+FBtyscMMFu5Y5NaA7nvIc1dgh78XCrdcUzljjt8JacNifr72tQi1xo/Nr5bAKC18Ll/zbt9jNRgYCX7X/k+IhbR8+JlUrpe13So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212793; c=relaxed/simple;
	bh=MDWKUqF5P0YI6KgXOB2iPYzISYAdjrtU/JTRIQf5Wag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fAo3KYIrel5lZS1XL+nCDFEt2Mp++KnvA30GlRB1RMbWnzhdzTFaXnWq6ORuhcQCJKazU9trxaxQz/oodC35Df13G7aUbPopbjCooSYfyCCFcqTlyF4mFoekcsXaCsvD78tDFGPi8aGkwpLcEiKnHRm1FMlqhBsrNKgsJt2K8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEmV8ai9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEmV8ai9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD5E1F000E9;
	Mon, 31 Aug 2026 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212791;
	bh=DDM7nAWwUF21ho6KpdxtNYwGxYCw0lv2vTxH0ihI4v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEmV8ai9ij2+gvhlUq81Watz1QNb19FZkfo6DIJATux+ngU7DWsRu+rfvz74r87zF
	 M/OENo2+cj69o02CoXtih+GUIa/woW/snvFTVmLWmFsUIDDT6/mcoF2uNh8p4tZWEP
	 iY4CWEPju9hIY92+QG7bT+2p9Lkz9h5/uh0wGPlKlkCqoRRSFKoGAGm5ZFr+Ep9Niz
	 1XXfkTk/ocV/wTtEwE3Rsk8xEuiVWYnhHTt66M8gWM1DjTqYo08yG7TB9O1I94EYgb
	 PM4DcicqFr3soMyYdFf2gjqq49iMGjDIaAt9YoroJ/Wi/9YqkGTNUV07FDeUtlMyz2
	 N6eqcEx22s3Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add pcie_get_link_endpoints() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com>
References: <20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:46:31 +0000
Message-Id: <20260831214631.7CD5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A race condition between `pcie_get_link_endpoints()` and `pci_remo=
ve_bus_device()` can lead to a Use-After-Free when accessing `pdev->subordi=
nate`.
- [High] `pcie_get_link_endpoints()` returns success (0) even when it fails=
 to find both ends of the PCIe link, leaving output pointers as NULL.
- [Medium] `pcie_get_link_endpoints()` does not guarantee returning Functio=
n 0 for multi-function devices, and resolves Virtual Functions improperly.
--

commit f96df0f9857c01cf8b72af2e93119c328134d9e0
Author: Priyank Rathod <rathodpriyank@google.com>

PCI: Add pcie_get_link_endpoints() helper

In PCIe topologies, physical links are point-to-point connections
between an upstream component and a downstream component. This patch
introduces pcie_get_link_endpoints() in the PCI core to provide a
standardized, symmetric helper to identify both ends of a PCIe link.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..7bdfe7e5ab3a4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -4618,6 +4618,56 @@ int pcie_retrain_link(struct pci_dev *pdev, bool u=
se_lt)
>  	return rc;
>  }
> =20
> +/**
> + * pcie_get_link_endpoints - Identify Upstream and Downstream ends of a =
PCIe link
> + * @pdev: Any PCIe device on the link (Downstream Port or Endpoint)
> + * @downstream_port: Output pointer to Downstream Port (Upstream Compone=
nt)
> + * @upstream_port: Output pointer to Upstream Port (Downstream Component)
> + *
> + * Identifies both ends of a point-to-point PCIe link. Increments refere=
nce count
> + * on @upstream_port if dynamically discovered on a downstream port. Cal=
lers must
> + * release with pcie_put_link_endpoints().
> + *
> + * Return: 0 on success, or -EINVAL if @pdev is NULL or not PCIe.
> + */
> +int pcie_get_link_endpoints(struct pci_dev *pdev,
> +			    struct pci_dev **downstream_port,
> +			    struct pci_dev **upstream_port)
> +{
> +	if (!pdev || !pci_is_pcie(pdev))
> +		return -EINVAL;
> +
> +	if (pcie_downstream_port(pdev)) {
> +		*downstream_port =3D pdev;
> +		down_read(&pci_bus_sem);
> +		*upstream_port =3D pdev->subordinate ?
> +			pci_dev_get(list_first_entry_or_null(&pdev->subordinate->devices,
> +							     struct pci_dev, bus_list)) : NULL;

[Severity: High]
Can this result in a use-after-free regression if a concurrent hot-unplug
occurs?

In pci_remove_bus_device(), the subordinate bus is removed by calling
pci_remove_bus(bus). This takes pci_bus_sem for write, removes the bus
from lists, drops the lock, and calls device_unregister(&bus->dev) which
frees the struct pci_bus memory.

Crucially, dev->subordinate is cleared only after pci_remove_bus() returns,
completely outside of pci_bus_sem:

drivers/pci/remove.c:pci_remove_bus_device() {
    ...
    pci_remove_bus(bus);
    dev->subordinate =3D NULL;
    ...
}

If pcie_get_link_endpoints() acquires pci_bus_sem in this narrow window,
will it observe a dangling pdev->subordinate pointer and cause a
use-after-free read when dereferencing &pdev->subordinate->devices?

[Severity: Medium]
Will this grab the wrong function if function 0 of a multi-function device
has been removed?

The commit message mentions standardizing aspm logic, which explicitly
resolves subordinate function 0. By using list_first_entry_or_null() here,
if function 0 is hot-removed, function 1 or later becomes the first entry.

Since the PCIe base specification requires link capabilities and control
registers to be implemented in function 0 (while others may hardwire them
to 0), could returning a non-zero function cause feature drivers to fail
when configuring the link?

> +		up_read(&pci_bus_sem);
> +	} else {
> +		*downstream_port =3D pci_upstream_bridge(pdev);
> +		*upstream_port =3D pdev;

[Severity: Medium]
Does this improperly set the link endpoint if pdev is a virtual function?

If this is called on a virtual function, it returns the device directly
without resolving its physical function. Like non-zero functions, virtual
functions may hardwire link capabilities to 0, which could break drivers
relying on this helper to read valid link states.

> +	}
> +
> +	return 0;

[Severity: High]
Will callers encounter a NULL pointer dereference regression when this
returns success but fails to resolve the endpoints?

If this helper is called on an empty downstream port,
list_first_entry_or_null() returns NULL, leaving *upstream_port =3D NULL.

Similarly, if called on a root complex integrated endpoint,
pci_upstream_bridge(pdev) returns NULL, leaving *downstream_port =3D NULL.

In both scenarios, the function unconditionally returns 0 (success). Since
callers expect valid pointers on success, won't they blindly dereference
these NULL pointers? Should this return an error code like -ENODEV if
either endpoint cannot be resolved?

> +}
> +EXPORT_SYMBOL_GPL(pcie_get_link_endpoints);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-pcie-link-=
endpoints-v1-1-32c2fd893e9e@google.com?part=3D1
