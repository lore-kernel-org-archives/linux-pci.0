Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79894A499A
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183812; cv=none; b=cGnzQjbWXtvKIzN0lfCrNax/wwLnf9lvBbKV+ajGXMlomPtE2ID7Xvd+Ldtjjk1vH6h4mi/Njye35TEl0I5IB8F9Q5bZwuEdgnboaK9halAax50f7igOt/qacnAGl54HjmkdkKIoAE+u2wVmjUqOLrxfBIGqWezN9/rLzCaOJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183812; c=relaxed/simple;
	bh=ii2i5n6GbsLHg3ZBl0GOlxCNkl8bjl8ZsjZ5+wBS1so=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xf9bJ39csge/u4ZPLnwr2Tf5MuloKrg25iGwX+7ANYGUj4EUEfPzUw1MvsJuNcZBl6Pwaf28UqLlt14aaN8MfRsXi0JHn66ZIaMkyD0mqCuu5CJVg0ZIEvvnV6AToj/Mb/fCE0Rk1gf3QCQBb+hRZiOgMyxiJ8no6Roccr+RjCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8vfOold; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8vfOold"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAE51F00A3F;
	Mon, 31 Aug 2026 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788183809;
	bh=6weoIsAZbWKI35bjycS1wgLGpu2omyIPea7OaZu2hkk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8vfOoldo8daZPjxI7ureRQpEvDe8KiQhZYIDyrLmvw1bgWF/GA+QvwRZJySwcZVI
	 blUmZJLsmKb1BmI4v9y6VUdlHdTF2eysoKINSL4awlFVYEVs4KFrDKCWVEKElnQ1o9
	 qWI5lubVIAhe8M/o4bDhv9gU8INoMvX7TeNZPDFrWD3s5pniopYHO7fySa55QDQdfX
	 vlY8grOYqfmiWEnuw2yAVd6bYtGxQXgqU/3WIBYCJgEfxonlaPdEQPVqd1KfqaoJwy
	 qTeiFrlxHZd01vqRjUcLhdLxWemfQ4gntVqnRvWnyLzok9A31srOvymjKXqqwsjTzB
	 reOLRR+zkLgxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.12] PCI: plda: Protect root bus removal
 with rescan lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-4-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-4-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:43:29 +0000
Message-Id: <20260831134329.9FAE51F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Premature runtime PM suspend during device removal in starfive_pci=
e_remove() risks system crash.
--

commit deb27e1c30d66425178af3188e74b7f9e994d90f
Author: Hans Zhang <18255117159@163.com>

PCI: plda: Protect root bus removal with rescan lock

This commit adds the pci_rescan_remove_lock around pci_stop_root_bus() and
pci_remove_root_bus() during driver teardown to prevent races with sysfs
rescan or hotplug operations.

Link: https://patch.msgid.link/20260521161822.132996-10-18255117159@163.com

> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/c=
ontroller/plda/pcie-plda-host.c
> index 3c2f683830107..f9a34f323ad8c 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -640,8 +640,10 @@ EXPORT_SYMBOL_GPL(plda_pcie_host_init);
> =20
>  void plda_pcie_host_deinit(struct plda_pcie_rp *port)
>  {
> +	pci_lock_rescan_remove();
>  	pci_stop_root_bus(port->bridge->bus);

[Severity: High]
This is a pre-existing issue, but does dropping the runtime PM references
in starfive_pcie_remove() before calling plda_pcie_host_deinit() risk a
system crash?

When the pcie-starfive driver is removed, starfive_pcie_remove() is
executed. This function drops the runtime PM usage count and disables
runtime PM before fully tearing down the child PCI devices:

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_remove() {
        ...
        pm_runtime_put(&pdev->dev);
        pm_runtime_disable(&pdev->dev);
        plda_pcie_host_deinit(&pcie->plda);
        ...
}

If child PCI devices are already runtime-suspended, dropping the host
controller's PM reference allows the PM domain to suspend the controller
(e.g., via clock or power gating). Because pm_runtime_disable() is also
called, the controller cannot be runtime-resumed.

Subsequently, plda_pcie_host_deinit() calls pci_stop_root_bus(), which
unbinds the endpoint drivers. When the endpoint drivers' remove callbacks
execute and attempt to access PCI configuration or MMIO space, the accesses
will hit a powered-down bus, which can result in a synchronous external
abort (SError) and a kernel panic.

Should plda_pcie_host_deinit() be called before dropping the runtime PM
references to avoid this?

>  	pci_remove_root_bus(port->bridge->bus);
> +	pci_unlock_rescan_remove();
> =20
>  	plda_pcie_irq_domain_deinit(port);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-4-sashal@kernel.org?part=3D1
