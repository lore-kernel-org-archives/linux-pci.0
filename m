Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321634753B
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310010; cv=none; b=ZQPVUAmEd9RS0h34+20k4FBRpKXnP6Nk44UhW5oqa4UlS7SRD4yy15yQ1ecrstEjhqwLsKnEiTOOJoABzClBx3tNeNW/weU/R//tb9PxYbq12vANnwjHyY2YgSwYio3kn/Fd+yKg7i172/GWpxTsTXJRzwPwtE9VY/yrgepVD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310010; c=relaxed/simple;
	bh=hia9Q/wpeUVhf//Xqeiw/fgPXTtwhipsXxxRjVB9Xnw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QL4qRLY6VDMK1xITRDTiO3BX3YSHXXkrWMjU8UX3FOR7oqiVB06C7vIY18m1CFqEhg4CqGQWrULVhrPSP8qnbq4VGPr9DM7EK8a/8ifv3URXkdFLDtynSNwU+8pZt+Ny6ytQEUm/6aa6BM432XzxTJAYoL9XUje2YmJ8DKK0cuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvPMwehi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvPMwehi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615B91F00A39;
	Wed, 20 May 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779310008;
	bh=zzYCKE/yqWjoqahm8cuU82hRqncaUTGH/z0556tax2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gvPMwehiKZD/Sv4KAdYaBadVqbTnHCYxCiarVT5y5OkMlJEHxPp6w97hhDvfTsxNt
	 11RoF3UdMUt4AgASdpomD0iwH997reTI8sPviRpzgbkS7Y/iTjiNPggWcqfmL2EMD7
	 DZjfCC+MNqg1/DOpMIDGxLyAojzW/jFP5obvyAfVb0HIoNVx999UeSz+lCSIZQH2oR
	 kSg4zhe8ad220HfYKT+AkilCRvJI0ObDKVYGv7XSlbRkTPTRg0YjMNx4i9G2vTTa3w
	 cDLrZ2KvB0vZfzZAJygTVtqFSDkxewwERvDEs2m3CcpZ3XSnpmo6aSNwX/5VgoMKQF
	 GXiuOb/U9el2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] PCI: Allow ATS to be always on for pre-CXL
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <35e75bf0abfa48f76bc87d73a772a3faf6271a9f.1779304390.git.nicolinc@nvidia.com>
References: <35e75bf0abfa48f76bc87d73a772a3faf6271a9f.1779304390.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 20:46:47 +0000
Message-Id: <20260520204648.615B91F00A39@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The matching logic in `pci_dev_specific_ats_required()` is flawe=
d: it ignores the `device` field when a callback is provided and fails to h=
andle `PCI_ANY_ID` wildcards when a callback is absent.
--

commit fb36e847666c196ca64ced94fef31e14f46cf42d
Author: Nicolin Chen <nicolinc@nvidia.com>

PCI: Allow ATS to be always on for pre-CXL devices

This commit introduces a pci_dev_specific_ats_required() quirk function to
allow certain pre-CXL devices to keep ATS always on. It adds a list of IDs
for these devices and integrates the quirk into pci_ats_required().

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..c0242f3e9f063 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
[ ... ]
> +bool pci_dev_specific_ats_required(struct pci_dev *pdev)
> +{
> +	const struct pci_dev_ats_required *i;
> +
> +	for (i =3D pci_dev_ats_required; i->vendor; i++) {
> +		if (i->vendor !=3D pdev->vendor)
> +			continue;
> +		if (i->ats_required && i->ats_required(pdev))
> +			return true;
> +		if (!i->ats_required && i->device =3D=3D pdev->device)
> +			return true;
> +	}
> +
> +	return false;
> +}

[Severity: Medium]
Does this matching logic inadvertently ignore the device field when a
callback is provided, and miss handling PCI_ANY_ID when a callback is absen=
t?

If a future entry specifies a precise device ID along with a callback (e.g.,
{ VENDOR, 0x1234, my_quirk }), the specific device ID will be ignored, and
the callback will execute for all devices from that vendor.

Alternatively, if a callback is absent, a catch-all definition like
{ VENDOR, PCI_ANY_ID, NULL } would literally compare pdev->device against
0xFFFF and silently fail to match because it lacks a PCI_ANY_ID check.

While this functionally works for the two currently defined table entries in
the patch, could this be updated to mirror standard PCI quirk parsing
behavior (like pci_dev_specific_reset()) to prevent issues for future
additions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779304390.gi=
t.nicolinc@nvidia.com?part=3D2
