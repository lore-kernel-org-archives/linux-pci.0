Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8F352005
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797747; cv=none; b=XJsd/lrA918Wly7fBbdcZrzs8g/1xsaqN/1sSwqHAlab4j+tvY9RZm2NwjxJDcyoWO6dpMw6nm0wSF/QwKMPKLc/EHaguWpgtmXHJHt0uNOI/6qqjRdBHmUgLl6auuDr44QQxr3B+HrQdhMebkEvpL1+W7mf42W+mDW/fPn7vRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797747; c=relaxed/simple;
	bh=CgnBZ0djP+tP3xOKzrDig8C91G5llcyFDbwBzVr8z0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j5MSHv5WFEpjqQILO0/l5i4DPWkL6SXlhlorjl0L46BFUfcU2SUzFsIYXqsm1qJI+hD+QoR6D32CDTBlzLYtBm4YYppBB6hseKvtqZmUqWXKyhZALeBPI9CD3yHN5t6V+urLqxwGxljl9zPlPdwyjSLJC6Ei4yHTs+tz6y20lGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VN0XMXx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VN0XMXx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3471F00A3A;
	Mon,  7 Sep 2026 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788797746;
	bh=5wuODQnqW1Yv2U1Wv/hI+nMBf/nwaexUJAVW9qL3vE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VN0XMXx4YPkFbHrwG0eWP1O9FR4W/Hh8AGb8lE4mS86I3ZZj1E9v4s7iTIExY3Ori
	 EQ0F0mumn3SZjPKvHevGGsYKCcfXySdy8W/rns1pusT0Z3fa/6gWWriHKdThJXdCm3
	 Id8LnSKUpDdyYWzBgohWoy1b3KpiJnVWavK5fqarEgz+HrGJQ28M70Ksw2Kte5l9CW
	 xKgjQFTm5LQNdUJCSoCdrmCI9TDAgIgEGfPoPyoxag+lvhjuCKJGxM24AKkcGIU8m3
	 hDGD3FzuU7yJbvLs9wKl9WL0eukch3kAsHykuVC3vNHHBXBCgeSY5LkqLDviXO6Upy
	 0DM75vWsfOlsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikola Prica" <nikprica@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260907161701.454364-1-nikprica@amd.com>
References: <20260903121217.23F751F000E9@smtp.kernel.org>
 <20260907161701.454364-1-nikprica@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 16:15:45 +0000
Message-Id: <20260907161546.5F3471F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Bypassing the cap_mask capability check blindly assumes all reques=
ted PCIe AtomicOp sizes are supported, risking Unsupported Request (UR) err=
ors.
--

commit 23f7770048aa6bf9d34e0cd8e0687398f5697661
Author: Nikola Prica <nikola.prica@amd.com>

PCI: Accept AtomicOps already enabled by the hypervisor

This patch modifies pci_enable_atomic_ops_to_root() to support passthrough
guests in headless topologies where no root port is visible. If the hypervi=
sor
has already set PCI_EXP_DEVCTL2_ATOMIC_REQ on the device, it treats AtomicO=
ps
as enabled and returns success instead of failing the topology walk.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..62729ade496fc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *=
dev, u32 cap_mask)
>  	}
> =20
>  	root =3D pcie_find_root_port(dev);
> -	if (!root)
> +	if (!root) {
> +		/*
> +		 * A hypervisor may expose a headless topology with no
> +		 * visible root port.  If it has already set AtomicOp
> +		 * Requester Enable, there is nothing more to do.
> +		 */
> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +			return 0;

[Severity: High]
Does unconditionally returning success here bypass the capability mask
validation?

Guest drivers (e.g., bnxt_re, amdgpu, or vfio) call
pci_enable_atomic_ops_to_root() passing a specific cap_mask to probe whether
certain atomic sizes (e.g., 64-bit or 128-bit) are supported by the routing
topology. By returning early, we skip the cap_mask validation against the
root port's DEVCAP2 register that typically happens right after this check.

If the physical root port only supports 32-bit atomics but the driver
believes 64-bit sizes are supported due to this return, could this result in
PCIe Unsupported Request (UR) errors and potentially trigger fatal Advanced
Error Reporting (AER) events that crash the device or VM?

> +
>  		return -EINVAL;
> +	}
> =20
>  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>  	if ((cap & cap_mask) !=3D cap_mask)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907161701.4543=
64-1-nikprica@amd.com?part=3D1
