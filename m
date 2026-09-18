Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586203AAF4E
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723687; cv=none; b=uON1NONn+VUwMqrJQeUHgcqxozA1pDC3vM9jRbwvMAjk/GeuGS4VoO4wrtKehL5aDguUT0AaHFs9R3JhTCmMq7OESxgFwdRCXTSC673vdPTJofPg8ggUod+2scy1r/g3FNTwSkJ/vAuhgsvlqoTidCoZiel6Hti4pEtG4miAttQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723687; c=relaxed/simple;
	bh=NLZDxqXUGsG/YkJL+fo0q07FukPn6nzCRyZl/aQoCm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jUfuTHyLZYg8ezX7ICfoGa5Eg0YLScHKJD90LP2LE4yHMxNwx3IWO7Yxy/NEIfZuXj99vqtcIeTTd98GWxGAlibKrYlAU6udvfq2OIpEY8U5cYfQqhR+gsEOmy5RVW10MV+GVM5O8QW5jljtBcnPE5KLeS3HBCIBisUPKuewO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiZmPbJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiZmPbJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2361F000FF;
	Fri, 18 Sep 2026 09:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723686;
	bh=WRAZJIvYIEidmVbQ20mpHa0cwsnKAg8z3FqHbwDCnew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiZmPbJqvV6Nm4KwHsN7usq+O1iEeb0UTBC0hRb4e4xCrBJT8OanhqRGSgl32vqDy
	 gk5Vx/rK85rR4/nRpM/ZdxiMUhGp79xRK7puxMTWeQYLxaNPSuN1JjbFxZFFUZ3ewp
	 jm7HvlyeTVLy/zehML3ap9fFS55IYUaKkbq65Q4EgtSoTkV+33l+ih+CKpuHShifZg
	 2Hj8FU37rgh8swi/Zf6ytSmMaPR35Xn6mt7ztvphVcdAktxhWQhWvqr3NBvQEYh/hH
	 qqYFLQP99uiiTbwMJt3AiIBVQlFv3eg9UbbHEizWNzWNr4EOpGHIUwm2Mpd/3RdMvr
	 Sq/Dazrdbyzog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Accept AtomicOps already enabled by the
 hypervisor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikola Prica" <nikprica@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918092857.648810-1-nikprica@amd.com>
References: <97aa96e8-b553-47a2-aeea-e5d830ab0184@amd.com>
 <20260918092857.648810-1-nikprica@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 09:28:05 +0000
Message-Id: <20260918092805.DF2361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: atomic capabilities check bypass in headless topologies
--

commit 7a2c6321c34255d72f250ecd35fa5e1846785e21
Author: Nikola Prica <nikola.prica@amd.com>

PCI: Accept AtomicOps already enabled by the hypervisor

In passthrough guests without a visible Root Port, this commit allows
pci_enable_atomic_ops_to_root() to return success if AtomicOps are already
enabled by the hypervisor.

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
Does this bypass the cap_mask size verification in headless topologies?

pci_enable_atomic_ops_to_root() requires a cap_mask parameter (e.g.,
PCI_EXP_DEVCAP2_ATOMIC_COMP64) to verify that the physical Completer suppor=
ts
the specific atomic sizes required by the driver.

In the newly added headless topology path (!root), the function checks if t=
he
PCI_EXP_DEVCTL2_ATOMIC_REQ bit is already set on the endpoint. If the bit is
set, it returns 0 (success), completely discarding the caller's cap_mask si=
ze
requirements.

The ATOMIC_REQ flag is merely a boolean enable bit for initiating atomics; =
it
does not guarantee that the physical Completer supports the specific sizes
requested in cap_mask.

If a hypervisor or host enables Atomics for 32-bit sizes, setting ATOMIC_RE=
Q,
but the guest driver requires 64-bit or 128-bit Atomics, this function will
falsely return success. The guest driver will then issue unsupported 64/128=
-bit
Atomics, which the physical hardware will reject with an Unsupported Request
(UR) fault, potentially triggering an AER and crashing the system.

> +
>  		return -EINVAL;
> +	}
> =20
>  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>  	if ((cap & cap_mask) !=3D cap_mask)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918092857.6488=
10-1-nikprica@amd.com?part=3D1
