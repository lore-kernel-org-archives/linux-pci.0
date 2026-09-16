Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFE54D794B
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573961; cv=none; b=EE4kJeJlxPgJF7iEsaqZ/J3KEKI+tCZ4trMYvHoCpGI+y8X9fUlfdhW2v6tQT7+eyouINp1Ckdhv3K1WuVR2WUeHku0oBtDLxrYNLAoQ5/ZgyxKafmBAEvtfoB2Csc8dSXMbGOJaEVBb/y1ay73PsIGu6TiwUTThNtyMnxat+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573961; c=relaxed/simple;
	bh=fOAspE1CTdKey+KPov10VSHTd4hdQHWIHpj/EbyfoNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oKOLKMfGuEb1Zb66GvlyYEU2xnlviwouyTD5iXUjUU1G+JrMFbABuTq+SBSBCUUl5GTDDA3LRs+VwGM7Iuf3FcYXPR2qQ07n4YhKN++rmAr7o6eFqfpe1JdEyEozlpRnjhhyvRYkvyfhlSeNABg/ChLHllX/ulZOv6LUr9gd9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjWFbOQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjWFbOQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ECC1F000FF;
	Wed, 16 Sep 2026 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573959;
	bh=p6JLHCg3/+VxrjTUSCA53JBCA/2IquWEQoLTEkkv7vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VjWFbOQu4Ujr6dkRXTZP1aqZm0HFYfDQDIeRBiAfesCFxhxJ58QbnMl+uUcGquaFQ
	 CDHKqXa640HNzv6jphuzXDqJU+TrB1PpDIpqQRhxqd0P434uEWRa02WQLRPFvq8IL/
	 15xKPzn1s1oq7wLmAJtiasd26OQW1at5MmPSE8vUCJOE6EL/UV8itoIx4aYBFSALsc
	 mbTYLNcLfUf9Pk3x6eU+v7jc1tWmoulM1vnrYWGpEBcf4NmXaBDu8sNFwODBKRuD4p
	 swZjPSOY6Qe16C9wo6pgcm+eOvwz+zKigkU7O8hZD1ckXGogqtEHOZd7sj4K1bMhLJ
	 6DCTkXwXsS/ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] PCI: Match the hierarchy's MPS to a device's
 MPSS as necessary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260916153907.60344-2-18255117159@163.com>
References: <20260916153907.60344-1-18255117159@163.com>
 <20260916153907.60344-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:52:38 +0000
Message-Id: <20260916155239.06ECC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] pci: pci_walk_bus() modifies MPS of active devices causing Mal=
formed TLPs
- [High] pci: dynamically modified MPS in pcie_set_mps() is lost on system =
resume
- [High] pci: unlocked RMW of PCI_EXP_DEVCTL in pcie_set_mps() causes data =
races
--

commit 5af1f52d57f95fe2335fa9124a2d504949bbc917
Author: Hans Zhang <18255117159@163.com>

PCI: Match the hierarchy's MPS to a device's MPSS as necessary

When a device's MPSS is too small to match the upstream bridge,=20
pci_configure_mps() now walks the hierarchy from the Root Port down
and reduces every device that is above the new value to avoid
Malformed TLPs on Switch egress ports.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..232bce2819f06 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2200,9 +2200,28 @@ int pci_setup_device(struct pci_dev *dev)
>  	return 0;
>  }
> =20
> +static int pcie_reduce_mps(struct pci_dev *dev, void *data)
> +{
> +	int mps =3D *(int *)data;
> +	int ret;
> +
> +	/* MPS is of type 'RsvdP' for VFs */
> +	if (!pci_is_pcie(dev) || dev->is_virtfn)
> +		return 0;
> +
> +	if (pcie_get_mps(dev) > mps) {
> +		ret =3D pcie_set_mps(dev, mps);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
Does bypassing the PM software save state here cause the dynamically modifi=
ed
MPS to be lost on system resume?

If the sibling driver previously called pci_save_state() during its probe,
dev->state_saved becomes true. During the next suspend, the PM core skips
saving the new hardware state. On resume, the old, larger MPS would be
restored, potentially desynchronizing the hierarchy.

[Severity: High]
Also, does modifying the hardware MPS of active third-party endpoints using
an unlocked Read-Modify-Write of PCI_EXP_DEVCTL cause data races?

pcie_set_mps() performs an unlocked RMW of PCI_EXP_DEVCTL. If the sibling
driver or userspace (via VFIO) modifies the same register concurrently
(e.g., via pcie_set_readrq()), could it corrupt the configuration state of
active endpoints?

> +		if (ret)
> +			dev_warn(&dev->dev, "failed to set MPS\n");
> +	}
> +
> +	return 0;
> +}
> +
>  static void pci_configure_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge =3D pci_upstream_bridge(dev);

[ ... ]

> @@ -2252,10 +2271,21 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
> =20
>  	mpss =3D 128 << dev->pcie_mpss;
> -	if (mpss < p_mps && pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT=
) {
> -		pcie_set_mps(bridge, mpss);
> -		pci_info(dev, "Upstream bridge's Max Payload Size set to %d (was %d, m=
ax %d)\n",
> -			 mpss, p_mps, 128 << bridge->pcie_mpss);
> +	rp =3D pcie_find_root_port(bridge);
> +	if (mpss < p_mps && rp) {
> +		/*
> +		 * dev cannot be programmed to the MPS already in use above
> +		 * it, so reduce the hierarchy to what dev supports.  A Switch
> +		 * may not repackage TLPs, so reducing only the upstream
> +		 * bridge is not enough: every port up to the Root Port has to
> +		 * come down as well, and so do the devices already programmed
> +		 * below that Root Port, which would otherwise be left sending
> +		 * TLPs too large for their egress port.
> +		 */
> +		pcie_reduce_mps(rp, &mpss);
> +		pci_walk_bus(rp->subordinate, pcie_reduce_mps, &mpss);
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Critical]
Does unconditionally walking the bus and dynamically reducing the MPS of ac=
tive
siblings cause Malformed TLPs?

PCIe specifications prohibit changing MPS while a device is active. Active
devices will continue generating TLPs based on their driver's internal state
(or previously negotiated packet sizes). When these larger TLPs hit the
dynamically reduced upstream bridge, won't they be dropped as Malformed
TLPs, potentially leading to a system crash or bus reset?

> +		pci_info(dev, "Max Payload Size of %s hierarchy set to %d (was %d)\n",
> +			 pci_name(rp), mpss, p_mps);
>  		p_mps =3D pcie_get_mps(bridge);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916153907.6034=
4-1-18255117159@163.com?part=3D1
