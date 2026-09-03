Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03A4A014C
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437539; cv=none; b=j3yGhqFw1AzEdI8yVSXRBxmY0hEqMa9An0X9NAnzZAfWuMsav2mnHxZLV7jp6omcKHoTbBjS86OcwjgwRnVsTpjvwpPudv5Iui7wnFyRfkbapRRmnbVQR/HvXAftupAiie/Lpe/1KKrdSmpDkqwZmAZ+p43py4bATOJWo3XUWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437539; c=relaxed/simple;
	bh=XNOJmVBAZooA9/H8JYjqR8zcaw317pitu3RPAfZVmx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qxcUbx4gnl2RCcM1QTppDWBUI/mcb9TUAD8JzRXql4QPcQI/NqcKdtds8+na1T5v4UB1h0Gtmwt6dxqmTMsqVm+obtjq73RTwK3a0CWEWXqmFCY7Bo9JTvz4I4gkhddT33tB4wxI8fGQs7MXf8CNTdhHmk0wNbzxcNnl9BfSu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi+9FHgq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi+9FHgq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F751F000E9;
	Thu,  3 Sep 2026 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788437537;
	bh=VUWT1BqPFcXoXMXmI/RuEISLl7HnUHas2YCwLYFjjmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xi+9FHgql94GUndI+48TOXXoxnRbKCahMChF50nnsIL0CP6DOaatMcS+See7KA0T/
	 Eyp36IVoeSB520rnH3oxmFGXULo90h8y8QBdJQ/UVW+JxzTza13wUAhCZBizisFJr2
	 cab/UPCs5abrgjbQ1Ti01NH+ikdf6nRGdL2R9xZqhin9eQuEnWkoE53pbv0oDsYrhm
	 3MKU1fdp2D7V2IcYxKjLUs8Jirry/bVYk6MdpGLidis5WK8zbhg8Us6oiPKBpfGw2v
	 68ilA6lcndA4hmxzNHxi1aMCWanvz0PtkrvUkBxBUkBsWhn5EMAaGhv8JXTSeBcfxw
	 fQnYman+ei7LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Accept AtomicOps already enabled by the hypervisor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikola Prica" <nikprica@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260903121218.4955-1-nikprica@amd.com>
References: <20260903121218.4955-1-nikprica@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 12:12:16 +0000
Message-Id: <20260903121217.23F751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally returning success when ATOMIC_REQ is already set b=
ypasses root port and bridge capability validation.
--

commit 174dddecfad7749ccba344bb23492b342569e86c
Author: Nikola Prica <nikola.prica@amd.com>

PCI: Accept AtomicOps already enabled by the hypervisor

This commit modifies pci_enable_atomic_ops_to_root() to check if the
PCI_EXP_DEVCTL2_ATOMIC_REQ bit is already set by a hypervisor. If it is, the
function returns success early to avoid failing in passthrough topologies
without a visible Root Port.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..7c62c7f317572 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3768,6 +3768,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *=
dev, u32 cap_mask)
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * Some hypervisors already set AtomicOp Requester Enable.  If it
> +	 * is already set, there is nothing more to do.
> +	 */
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +	if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +		return 0;

[Severity: High]
Will this unconditional early return bypass the capability validation for n=
ewly
requested atomic sizes?

When drivers or subsystems sequentially check for atomic support, they call
pci_enable_atomic_ops_to_root() for different sizes. For example, in
drivers/vfio/pci/vfio_pci_core.c:vfio_pci_info_atomic_cap() (around line
1059), the code sequentially checks for 32-bit and 64-bit atomic support:

vfio_pci_core.c:vfio_pci_info_atomic_cap() {
    ...
    if ((devcap2 & PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
        !pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64))
        cap.flags |=3D VFIO_PCI_ATOMIC_COMP64;
    ...
}

A similar sequential check occurs in
drivers/infiniband/hw/bnxt_re/qplib_res.c:bnxt_qplib_determine_atomics()
(around line 1001).

The first successful call (e.g., for COMP32) validates the topology and sets
the ATOMIC_REQ bit on the endpoint. If a subsequent call is made for a larg=
er
size (like COMP64), this new logic sees the ATOMIC_REQ bit is already set a=
nd
instantly returns success.

By returning early, doesn't this bypass the cap_mask checks on the root port
and bridges for the larger atomic size?

Could this cause the kernel to incorrectly advertise 64-bit or 128-bit atom=
ic
support to VMs or drivers when the root port only supports 32-bit? If a dri=
ver
or VM attempts to use these unsupported sizes, the root port would treat th=
em
as an Unsupported Request (UR), potentially triggering a fatal AER error and
crashing the system or terminating the VM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903121218.4955=
-1-nikprica@amd.com?part=3D1
