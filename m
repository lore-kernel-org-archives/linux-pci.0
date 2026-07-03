Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49527FD4F
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052979; cv=none; b=Rf7yp7LISESSJlWFLPpEw1kcDJpLVRc3GqQOaUUncIt4OV4+aYyqIUbSjxcexpQWyHWat3p9OoqaWs3A3QXomd0tWxyeoq6lJzvzwLqfllByYSJQNTWVYLFNLXVknhrSjAmjLGcAboyZtrpuCsw/3cfLYJzezGUoowQskRpmJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052979; c=relaxed/simple;
	bh=DXorQXUl2Twy2jZPY7Yg0n2QCEeA4KT78avvw4+ShfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZSzRQNn9E5L7MFVSyuvxMpOMdTayuw6okk3Szv4ewA2GApOEfKvd/Wrukl9ZfF7z2hT+nofaPbTMu2ISkKM1+ikLJTQPeTUl6sCsxoPvzIM0L5I8mwCD+5F9zNu370vWusNDdwUTu3wu2PY/B3cIaL5GNRm5Nz1E3P5qdRKNQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPwP+W7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPwP+W7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D11F00A3A;
	Fri,  3 Jul 2026 04:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052970;
	bh=82RnVNR4peE1vkVpF1HYIXj3BKhkoY2uCxRqXOIvCbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lPwP+W7vkNBt8ExY/nAr3gZ2/dccxEE5/7OZYjKzjvyjwYDerrxWFQrMmqklV/BEs
	 zQy0kTJWgi8iF0VfEAZkMF8tqL49KTLu5+6x9VpUJDIDS1hnZHISqi3Dib+qMGfdWP
	 a4PKINfInB/SEi4emcDTftTTKWP3zYPzU7ePQyc9FcF1wgmrwt/lPy2GWT5MbJKW1f
	 nngKOdq0PsrI0cI2o6hybckP87F0Nl6C/k3QoJjYxHfLbc08MgQFv8mx+YTUJ4sisi
	 WZTwn+g/IkJgKLpzm4N4gPPp7T3pp5aiTYjAaWQFH9dIY25HBLSqWWhkdrDFYAOQVw
	 tBRpSpqs7Nqgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/18] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:29:29 +0000
Message-Id: <20260703042930.3D6D11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless traversal of the PCI bus devices list without holding `pc=
i_bus_sem`.
--

commit fc0e8d0d4aa1ff4a78d2d50fab18bdedb164b4ae
Author: Nicolin Chen <nicolinc@nvidia.com>
Subject: PCI/CXL: Probe the underlying bus reset in cxl_reset_bus_function()

This commit updates cxl_reset_bus_function() to properly probe for an
underlying bus reset rather than assuming it is supported. By explicitly
calling pci_dev_reset_slot_function() and pci_parent_bus_reset() on the
probe path, it ensures the sysfs node correctly reflects supported reset
methods. It also passes PCI_RESET_DO_RESET to the actual reset execution
instead of relying on the probe parameter.

> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -4947,8 +4947,16 @@ static int cxl_reset_bus_function(struct pci_dev *=
dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
> =20
> -	if (probe)
> -		return 0;
> +	/*
> +	 * Do not probe via pci_reset_bus_function(), which would reject a
> +	 * masked SBR that the do-reset path below unmasks before resetting.
> +	 */
> +	if (probe) {
> +		rc =3D pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
> +		if (rc !=3D -ENOTTY)
> +			return rc;
> +		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
pci_parent_bus_reset() here expose us to a lockless list traversal race?

Looking at pci_parent_bus_reset(), it iterates over dev->bus->devices witho=
ut
holding pci_bus_sem:

drivers/pci/pci.c:pci_parent_bus_reset() {
	...
	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
		if (pdev !=3D dev)
			return -ENOTTY;
	...
}

If a concurrent PCI hotplug operation modifies the bus->devices list under
down_write(&pci_bus_sem), could this lockless iteration dereference poisoned
list pointers? Writing to the reset_method sysfs node triggers this probe
path, which seems to propagate the vulnerability to this new execution path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D2
