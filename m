Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C1384CEB
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843391; cv=none; b=R4d4l9JZGtCjUr2cI5DM8RwgEqY/Ukpi5IxsuY70BUzWwscEVcI7wJ4e4Z6zjDzNCcCs0dgMnlOnZ/BgcHw3p5sVLpDzddLKZpzPJ+Olnw5PIaK3kwlrGmiFI0liHuZKg5kwvL5zRw9CFupM5FEfJQGG8zRYeEbFqr3H1tv2wUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843391; c=relaxed/simple;
	bh=9MZL8PXjLnQMwK3czv4/GrvilQeQzf/I5Yv+/6KFgNg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=M8cN6Oy44iSw6LSUe0TG3Tgja9ngB8HofN6LLkPpSegC0iOXEQh5kM/PxNQDNNIXIv+G+ScD8l6U7vPy2ACwaCLF3yKTY4dFkbbNzAA8fJaJm9hiiE9cId2PkfGtVEzskr2k6kEnG2CrIRjujKPvajD5fKZjs5LYDkMpxSWkvJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFY9FeJT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFY9FeJT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2451F0089B;
	Mon, 12 Oct 2026 22:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843389;
	bh=3FsudeWmmlDV4VJhFboQG7gqT3xQkwZTZSwU0meo0Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hFY9FeJT9Ng5/rgDf5s5gVWFmYSNwDhEzcfzHg9v6+KlF0hjV2vhI21BfwDHeFkkA
	 9FmYRw24lzFm1LKmIsepmeI50wDzefFgaxz/2WrKa+Xyf7tx4cMk+DhqT/OvLlINQW
	 j/rnJ4KHI5EuPvkg7VrMCLrgYS5VbwUzLVzyU6NlCshQ+bI2abL1pnFSdffxD2HW1g
	 1LTjgponYODqoiAUbHy/22pV9hPJRkxyIcHbtXIRsxckhHiogH5O0Q/KzrHUnVmwJO
	 2I1KNOCzj5IpTIdCehaI9XmL/SwGT/3gsieKMbrDeQsEhzF+DwlBhglGUG/XLlLTnK
	 fIPILWMRYJVLA==
Message-ID: <sashiko-outbox-168676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pciehp: Fix NULL pointer dereference in
 pciehp_configure_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com>
References: <20261012-pcie-hotplug-nullref-v1-1-6e21c2e89ea4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 22:16:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pciehp: spurious device teardown on resume for devices lacking F=
unction 0
--

commit 26f6592be4bd1ee27e178fdf85798fa2b65a389a
Author: Priyank Rathod <rathodpriyank@google.com>

PCI: pciehp: Fix NULL pointer dereference in pciehp_configure_device()

This commit fixes a NULL pointer dereference in pciehp_configure_device()
when attempting to read the DSN of a newly hot-added device. By guarding the
pci_get_dsn() call against a missing Function 0, it allows devices lacking
Function 0 (such as those under hypervisor isolation) to be successfully
hot-added.

> diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pcieh=
p_pci.c
> index 65e50bee1a8c0..5f9e8044ea5be 100644
> --- a/drivers/pci/hotplug/pciehp_pci.c
> +++ b/drivers/pci/hotplug/pciehp_pci.c
> @@ -73,7 +73,7 @@ int pciehp_configure_device(struct controller *ctrl)
>  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> =20
>  	dev =3D pci_get_slot(parent, PCI_DEVFN(0, 0));
> -	ctrl->dsn =3D pci_get_dsn(dev);
> +	ctrl->dsn =3D dev ? pci_get_dsn(dev) : 0;

[Severity: Medium]
While this allows devices without Function 0 to be successfully hot-added,
will it lead to spurious teardowns upon system resume?

When the system resumes, pciehp_resume_noirq() calls pciehp_device_replaced=
().

If a device legitimately lacks Function 0, pci_get_slot() for PCI_DEVFN(0, =
0)
will return NULL:

drivers/pci/hotplug/pciehp_hpc.c:pciehp_device_replaced() {
    ...
	pdev =3D pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
	if (!pdev)
		return true;
    ...
}

Because it unconditionally returns true when Function 0 is absent, this fal=
se
replacement signal will trigger pci_walk_bus() to set the disconnected state
and queue a teardown request.

Could this spurious teardown issue be avoided by modifying
pciehp_device_replaced() to handle missing Function 0 devices correctly?

>  	pci_dev_put(dev);
> =20
>   out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-pcie-hotpl=
ug-nullref-v1-1-6e21c2e89ea4@google.com?part=3D1
