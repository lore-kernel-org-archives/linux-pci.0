Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86306466B01
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131141; cv=none; b=kjdv4w+YRCpbNFByTECUMOjye4lc4uLdFCOKJYXOQ2V91toYDur8B6feOeR1mkoMO9wM2JggXlE8EJ9u1A8Q+P93UbnlCSUQiJQY25E/yNeIBusBK3Bpb8sxhwYU0vdz0ChrHVUWTuRRtmZ8ZZ1J/4r0+QJMxtdjOlOi8/aDAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131141; c=relaxed/simple;
	bh=+QxAlE+sqTEf5XcXfgw7Knmpt+2qhD2yqtty5THzweY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=buIV3XhpquNe3guoUoRfiurjEF75ONcaJu5u6EHx2b4S0C3YLldInQGg6InbPHxVJHWM75JAeAby90YA8NPDmK8JVRh4A7S3uIrlDMPRqQBjtsECp+qGWkTg465gflUMiVJRb0yqdrMpHJPw/cDtGueISQ6xNaLdzpAyWd1fFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcwBBeuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcwBBeuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018B61F000FF;
	Fri, 11 Sep 2026 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131140;
	bh=SBKgCsLy2la0qKdsLhuM2LAFVvOEDwzxHmufYsei++8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcwBBeukPn/hXrjrLoFtOiDSaxO+eNIcsRqCLuCkDe4IL1hxdv3P57Oq8AJUuqWcO
	 osCsdX4F8ZN3xYIMTpPBquRL4xgHMFJOU4JuT+GiaxLGW9hBzQDrhPCXEpCwuiOZ04
	 Av8f4yRqB/aWDJG1buWHrAH10wo9YT7QlBpYQP/w1i65JvhC/345tlG6cmnLJtdfP9
	 j3Qfa+ge466dD1Ccfk3R8bdznSuAysy5OKuDSWmc2sMK1geBO7RMnjoHpCa4a4Pv/X
	 LpELEKjgcPpXi2Dk2kxWw7YExLBzpaNaH+XnoaZbK3owUTW54rxAI0GnTFRmcqSJxW
	 W4D91TPYzs7XA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] PCI/IOV: Let sriov_add_vfs() own the failure
 unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911123241.3312-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911123241.3312-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:52:19 +0000
Message-Id: <20260911125220.018B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Signed integer overflow in pci_iov_virtfn_bus() and pci_iov_virtfn=
_devfn() when computing the routing ID for a virtual function.
- [High] Preexisting lockdep assertion failure when EEH driver removes a Vi=
rtual Function without holding the pci_rescan_remove_lock.
--

commit b6383e6825acdb6d59417c0f87bde1ecfbf1a2b6
Author: Pavol Sakac <sakacpav@amazon.de>

PCI/IOV: Let sriov_add_vfs() own the failure unwind

This commit modifies the PCI/IOV virtualization code to handle VF addition
failures gracefully without requiring the pci_rescan_remove_lock in async
workers. It pushes the failure unwind responsibility to the callers using
pci_iov_remove_virtfn().

> Leave __pci_iov_add_virtfn() reporting only and let each caller unwind
> through pci_iov_remove_virtfn(), whose lookup-based design is correct at
> every failure stage. sriov_add_vfs() unwinds ids 0..i inclusive on
> failure of VF i, since VF i may be registered but not yet linked. The
> wrapper unwinds fully before returning, because its EEH caller discards
> the return code: the VF is removed through pci_iov_remove_virtfn(),

[Severity: High]
This isn't a bug introduced by this patch, but does this EEH caller
invocation violate core kernel locking rules?

Looking at the EEH driver, it calls pci_iov_remove_virtfn() to tear down
a VF without holding pci_rescan_remove_lock:

arch/powerpc/kernel/eeh_driver.c:eeh_rmv_device() {
    ...
    if (edev->physfn) {
        ...
        pci_iov_remove_virtfn(edev->physfn, edev->vf_index);
        ...
    }
    ...
}

However, pci_iov_remove_virtfn() calls pci_stop_and_remove_bus_device(),
which explicitly requires pci_rescan_remove_lock to be held, as verified by
lockdep_assert_held(&pci_rescan_remove_lock). Removing a device without
this lock risks concurrent PCI hotplug operations, which could lead to race
conditions and use-after-free bugs during EEH error recovery.

> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index dda9303516f5d..a32b2c2959223 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
[ ... ]
> @@ -394,8 +397,9 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  {
>  	struct pci_bus *bus;
> +	bool created;
>  	int rc;
> =20
> -	bus =3D virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), NULL);
> +	bus =3D virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id), &created);

[Severity: High]
This is a pre-existing issue, but is there a signed integer overflow
vulnerability in the pci_iov_virtfn_bus() offset calculation?

Looking at pci_iov_virtfn_bus(), the calculation relies on multiplying
stride and vf_id:

drivers/pci/iov.c:pci_iov_virtfn_bus() {
    ...
    return dev->bus->number + ((dev->devfn + dev->sriov->offset +
                                dev->sriov->stride * vf_id) >> 8);
}

The dev->sriov->stride is a u16 and vf_id is an int. This evaluates to a
32-bit signed integer. If a malicious or misconfigured PCI device
advertises a large total_VFs and stride in its SR-IOV Extended Capability
structure, couldn't the multiplication overflow and produce a negative bus
offset?

This could underflow the bus number and cause the kernel to insert the new
bus with an out-of-bounds or corrupted identifier, resulting in memory
corruption in the PCI resource tree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D6
