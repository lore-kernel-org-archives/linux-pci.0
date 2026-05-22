Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C43F348875
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438738; cv=none; b=UtT9LTNEby/1e1b2gow8hqfGOm/VfLPwgzMLW1GOHfi8OLygj9Odpr1PXAZrRnyJsqBadGHdcgcL10CZakzaBQ78uoBt7FROvKUWAid4QcZraSbw+BuwvBDCgB6D9XsFOaQ9mBTRRAszWbonqbvR+kR8FOe2Fbz+2Qd0X6T8x8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438738; c=relaxed/simple;
	bh=zygs7Mt5AL5s3NsZMOuGELc3+CZIoXqYnO9v9d3YkvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lNUVQ6JIDpWGgEfHBKqxG1w3yuvN1FqM7c+y0jUGT3BP/Jokbpx6haottFZx9Ro9wCMOsd/pTjpkzi/zhlQUDTkX5Y7Sp/uZlpPF5HYDx80Ua5g4g4FAggwsTDE05xMjmgpuk4muip3+9vV2QpgG8QmIR2Y8um+EJpwG3zkE03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwnCdHHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwnCdHHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904881F000E9;
	Fri, 22 May 2026 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779438735;
	bh=Cl9KVPTDJqQ6x0XJ7gMIf7+ypPV9TaVrwnNA0mipzL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QwnCdHHuec59j/Qz9rd/Ro8j9wntI1qAECvx5WfP2DlpHXPtA4Lzo11Uz6qcXrqMk
	 WaN3ZyYTwGhHAo+mZe49rXT5eYVm02XBnWyfCZEVjSaqtM3lV5uPv2jZ0KRsjN7diO
	 FRbc/Rwk5/80I1PNomwruhowjw2+9gwyZg5FCpA27fnrS8dPESfOZyUxP6DrqeH/3k
	 V30K4iT6tpvnJzK2a+GzqGAlWqmgSs2Qua4gzkJ+0eX99SAsRL5ZAktQHJwb2keoA7
	 RBKAflIv8Yk3WC1qhyvnYxmy67QLMxrOm+nsGk8qBypwTQv3K96HmALVeZ2Rd8cqu7
	 Mvdo0pGz3FNtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Avoid unnecessary cpu_hotplug_disable() for
 non-NUMA devices
Reply-To: sashiko-reviews@lists.linux.dev
To: weipengliang <weipengliang@xiaomi.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522075453.473-1-weipengliang@xiaomi.com>
References: <20260522075453.473-1-weipengliang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 08:32:14 +0000
Message-Id: <20260522083215.904881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch removes CPU hotplug protection during PCI device driver =
probing, exposing drivers to concurrent hotplug races, breaking NUMA locali=
ty, and violating CPU isolation.
--

commit d0d4eccba5faab11b523664a86d8feec90710056
Author: weipengliang <weipengliang@xiaomi.com>

PCI: Avoid unnecessary cpu_hotplug_disable() for non-NUMA devices

This commit avoids taking the CPU hotplug lock when probing non-NUMA PCI
devices or VFs being probed from a PF context. It also adjusts the scope of
the hotplug lock in the NUMA path to cover a smaller region around the targ=
et
CPU selection and work queueing.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0f..8a7da7bf24580 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -377,7 +377,6 @@ static int pci_call_probe(struct pci_driver *drv, str=
uct pci_dev *dev,
>  	node =3D dev_to_node(&dev->dev);
>  	dev->is_probed =3D 1;
> =20
> -	cpu_hotplug_disable();
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>  	 * device is probed from work_on_cpu() of the Physical device.
> @@ -385,10 +384,13 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
>  	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
>  	    pci_physfn_is_probed(dev)) {
>  		error =3D local_pci_probe(&ddi);

[Severity: High]
Does bypassing cpu_hotplug_disable() here expose the driver probe path to
concurrent CPU hotplug events?

Historically, cpu_hotplug_disable() wrapped the entirety of PCI probing to
prevent hotplug events from causing race conditions or deadlocks inside
driver probe functions.

> +		dev->is_probed =3D 0;
> +		return error;
>  	} else {
>  		struct pci_probe_arg arg =3D { .ddi =3D &ddi };
> =20
>  		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
> +		cpu_hotplug_disable();
[ ... ]
> @@ -407,10 +409,12 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
>  				wq =3D system_percpu_wq;
>  			queue_work_on(cpu, wq, &arg.work);
>  			rcu_read_unlock();
> +			cpu_hotplug_enable();
>  			flush_work(&arg.work);

[Severity: High]
Does enabling CPU hotplug before flush_work() defeat the protection for the
actual probe execution?

If the targeted CPU goes offline while flush_work() is waiting, the workque=
ue
core might unbind the worker pool and migrate the pending probe work. Becau=
se
unbound workers fall back to cpu_possible_mask, the probe might execute on =
an
incorrect NUMA node or an isolated CPU, violating the housekeeping_cpumask
constraints evaluated earlier.

>  			error =3D arg.ret;
>  		} else {
>  			rcu_read_unlock();
> +			cpu_hotplug_enable();
>  			error =3D local_pci_probe(&ddi);

[Severity: High]
Similar to the workqueue path, does calling local_pci_probe() after
cpu_hotplug_enable() leave the driver initialization unprotected against
concurrent CPU hotplug events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522075453.473-=
1-weipengliang@xiaomi.com?part=3D1
