Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285845D90C
	for <linux-pci@vger.kernel.org>; Sun, 11 Oct 2026 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746092; cv=none; b=FvXTbkaoO2cq6r5RPtqWAFVBKEm09V26kTrOfnYWSdKbi0Q8GmAqupMji9koQiYdgC8xEJpkPzcizgtDA+HKumi15WaySiQ123CWQFc6opVZHlY3YB8WPEPhF27781SwjvuxRla0udfERJcIwC4E7lEm804TbGQRyghsYMPRQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746092; c=relaxed/simple;
	bh=gRWAP/HghLRgDVsyK2aY0asp0CIeO7EVDunLIfRxfug=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZL6o/nOTt1CHWTGTpWYJbK4E27VIfQQK9hW3Q32xqH/GbQP5CE+Tfltw5YJKFGKEoez8LKK5qzEE/P5rgdi2fb3ZiP62XqD8c8ofGYm03g9xxmM+yk+b1sLIqaKk7redt/sZe8LJ1OOuwpoJoCTmxKSb0gbfqXCbRyz1yexYrqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyQh+lhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyQh+lhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBA11F0089B;
	Sun, 11 Oct 2026 19:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791746085;
	bh=w+U0iniK+t132LDl+6wtLzKLNSuvkTe5tcwDDD/4JwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyQh+lhynRDTz+UF2h8E23ZPo3/jN9wkc6Xtk5yWUUej+TS18CQPcoiD3rGUu0wZi
	 vMvvY7+pbs0qgLTTXBTdFdG+m+OfBRHapT2CFGePhtOB4FiX+ckmMqkpFS9bO9e1dB
	 bR9H8o817xFFX78kyShD744lJ9l2OEWYUH0h4BKVzTnmofurFJ15i3BYMJP20CpsH7
	 kmTdXMd+mryrFSGDkZSRSTCVYqYIUT8j0pod6NO1PeRQMth0Q06zOKx+Yp8IBZagIf
	 yoT+LJ7czE8zjuIZGg7BO/1A5KtoRn/v6P3yDyDQZvxXPr0Y6fRUXd7qGIrdpo8DSd
	 yHjywIYRcQkjQ==
Message-ID: <sashiko-outbox-167396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Ignore Immediate Readiness on Samsung 990
 PRO NVMe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gruhlke" <gruhlke@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261011190145.23621-2-gruhlke@mailbox.org>
References: <20261011190145.23621-1-gruhlke@mailbox.org>
 <20261011190145.23621-2-gruhlke@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:14:44 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: read-modify-write data race on dev->imm_ready bitfield
--

commit 0139f0dcf6cc99c5e4527404461aefca31dd96e8
Author: Alexander Gruhlke <gruhlke@mailbox.org>

PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe

The Samsung 990 PRO advertises Immediate Readiness, so pcie_flr() doesn't
wait after FLR, but the drive returns ~0 for up to 7 ms. Ignore Immediate
Readiness on this device, so pcie_flr() waits.

Link: https://bbs.archlinux.org/viewtopic.php?id=3D314833
Link: https://lore.kernel.org/r/20261010160529.27974-1-gruhlke@mailbox.org

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 38af25c390867..fc61e1ad9e574 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5747,6 +5747,17 @@ static void quirk_no_flr_snet(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLIDRUN, 0x1000, quirk_no_flr_sne=
t);
> =20
> +/* Samsung 990 PRO advertises Immediate Readiness, but isn't ready after=
 FLR */
> +static void quirk_no_imm_ready(struct pci_dev *dev)
> +{
> +	if (!dev->imm_ready)
> +		return;
> +
> +	pci_info(dev, "Ignoring incorrectly advertised Immediate Readiness supp=
ort\n");
> +	dev->imm_ready =3D 0;

[Severity: Medium]
Could this bitfield update be subject to a read-modify-write data race with
sysfs stores?

Because this quirk is executed via DECLARE_PCI_FIXUP_FINAL, it is invoked by
pci_bus_add_device(). This happens after pci_device_add() has already called
device_add(), exposing the device's sysfs attributes and firing a KOBJ_ADD
uevent.

This leaves a window where userspace (such as udev) might concurrently
write to sysfs attributes. Sysfs store handlers like d3cold_allowed_store()
write to bitfields that share the same underlying word as imm_ready without
locking.

Can this result in a C bitfield data race where either the imm_ready =3D 0
update or the sysfs attribute update is silently lost, potentially breaking
the VFIO passthrough (the bug this patch intended to fix) or corrupting PCI
power management state?

> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_read=
y);
> +
>  static void quirk_no_ext_tags(struct pci_dev *pdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011190145.2362=
1-1-gruhlke@mailbox.org?part=3D1
