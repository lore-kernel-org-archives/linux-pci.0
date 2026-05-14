Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF07083C
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778798476; cv=none; b=ik14iJLhHZpOTPGxwfwM5zzjnTGuGSbrdQeJv09ArwlptLYvItt2BFrZJG2i6aysrjlSRAjd8NKo3gZDQgKJR79u0VLiG93K0GLK/pW526O4VNARQagnlkeJTUR3MXzp9T3aZhPxDdtYBHkdr/rhMR/sZtd/QRurbHL/Lj+QMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778798476; c=relaxed/simple;
	bh=X6eTeVQUXWCPchFDwvoBRECNL7PRArtMlCM4RPgKqdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NevMYa8auI4Ejsl6CqpK2KC3M6uM/hgIRFaXZlWPu3VkeU8Ze5a4QkvbfjCb/NIk6USoQihREaSo6DVKPus3a2KdvH1LkJukcfsULDk7bjC8si76FP5ggOzQl+nFpHXuQqk9uG1pWY/3mIqkdIZaWgU2sNNMUB5AYIMi347Vg8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw+QLDmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw+QLDmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8201C2BCB3;
	Thu, 14 May 2026 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778798475;
	bh=X6eTeVQUXWCPchFDwvoBRECNL7PRArtMlCM4RPgKqdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aw+QLDmMDEtks807YzuO+Ge7rtCv65oItJ+lVEabytmvdhMevvnnI8mSznF1qhje0
	 2tRBW2PugDX8XxniC2/MuDnZJJBEFoKF2vTTeNz/uB3gMJVBJ74sMmHLekBqmXntod
	 qj4C2DVBNHs6G86XpuRQkij2KTXmuJ/QelyJl46OC6FrNTmP0P1vmPHI48TQ7nPJlG
	 DND1cpBqDu6nsODN43hIAOeoexYhpaM4Ohytvuwy5UcxuZSTAfajtBT781tzYboE7+
	 B+bR7GUJ4/rjIlU3gQL6bfiUXQdSzAD68polGq4BMaWuzmSOVhedmcd3YR89/UtviD
	 UPVVtHStVCAmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 3/7] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514180059.1553-4-alifm@linux.ibm.com>
References: <20260514180059.1553-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:41:15 +0000
Message-Id: <20260514224115.C8201C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Logic Error in Reset Capability Probing (Permanent Loss of FLR Sup=
port)
- [High] Un-ratelimited Warning Log Flooding (Denial of Service)
--

commit d8b99b3d5048ef035997beff7b1d31f361be5f9b
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Fail FLR when config space is inaccessible

This commit adds a check to validate if a device's config space is
accessible before performing an FLR reset. If the config space is not
accessible, the reset fails early.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
> =20
> +	if (!pci_dev_config_accessible(dev, "FLR"))

Does this fast-fail path bypass the 60-second blocking timeout previously
enforced by pci_dev_wait() when reading ~0 from an inaccessible config
space?

Looking at pci_dev_config_accessible(), it prints an un-ratelimited warning
if the config space is inaccessible. If an unprivileged user or VM guest
repeatedly triggers a reset on a passed-through PCI device via the
VFIO_DEVICE_RESET ioctl, could this flood the kernel log and overwhelm the
host console?

> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;

If a device is temporarily inaccessible during system initialization or sys=
fs
writes when pcie_reset_flr() is called with probe=3Dtrue, will this falsely
report that the device does not support FLR?

It appears this would cause the PCI subsystem to permanently omit the FLR
method from the device's cached capability list, preventing the device from
ever using FLR even after the link state recovers.

Does this also cause normal lockless capability queries to trigger active P=
CI
config reads and spurious kernel warnings?

Would it be better to move the accessibility check after the probe check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514180059.1553=
-1-alifm@linux.ibm.com?part=3D3
