Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073332939C
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780870837; cv=none; b=UQb9NV7Cxxhp7R7RK47dvzZBWJKOAS69MKF5B1Hlps5awpsRH45AiXHu4CNS/7rFU3lKA5Wy03AwwSQHReT39eF/BHtV7uThfcy32T+TdZO8rKPRRjxx5YGi0lVOpKEGNZYbolyrrVCiY9UtuB50elfZVEDLUKaTksaHUReMbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780870837; c=relaxed/simple;
	bh=50ARFbbk03W0cqnSEDECZD4MblY/TbXSOloLynzkW78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GB/dVeUnL7BaJAr+BheGMAW2IKEWEHPZHQWn1j0BPHr23bWDFatFQzW/Y49WnQadqQA9NqI7kvZYJUFnrr5yjGNVYPpIzU0CDYb637C8F3pEdhVRbzykO5Fnjk6qlicAgLHCQ1c66YIWpDzbTD0/Cv56d1oV/mMO1edOWbS/G0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnd7fNzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnd7fNzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05961F00893;
	Sun,  7 Jun 2026 22:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780870836;
	bh=CoPxCUP6hJgi4IQMNjN3cUUpYf7zUg6xpedKOzftyyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gnd7fNzxwmInkBTBvRB7QbYjga2d7Y+iPZtkb0QuC5FwK9kebNSF8ig9fdVnJ9m+n
	 8vUhPIdlixEqFYh2mIXsnst9Xieet838TTzoztVUjaP55OtJHtMaaNbWa1ue3Dv2l9
	 vBE+MVmOgh56dV2hGygmkEKx0Up/OW9EE7x9TUj8fsGBatl73UOlxy5Yi48Mmr5/I8
	 gsgnXzVq+sAZ5BJNOSvCz0rL/WrppMXR0eHEvslENy6eQDYQc9KftucxA/qNEYDZdG
	 OvzoOwTbaCC+58TN4XoxIev3EW6Jqh6fnZB2d9KFJl8TuemyXmme6oLAUKArxpmmO4
	 osdPPWaBHHmzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Call local_pci_probe() directly if current CPU
 is in the right node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waiman Long" <longman@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260607221103.703133-1-longman@redhat.com>
References: <20260607221103.703133-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 22:20:35 +0000
Message-Id: <20260607222035.E05961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for workqueue recursive locking deadlock hazard due=
 to conflating NUMA affinity optimization with deadlock avoidance.
--

commit 00ce8bc63ea5f4dc858bb9687e393f23de7912a4
Author: Waiman Long <longman@redhat.com>

PCI: Call local_pci_probe() directly if current CPU is in the right node

This commit attempts to fix a lockdep recursive warning in pci_call_probe()
by directly calling local_pci_probe() when the current task is a kworker
executing on the desired NUMA node.

> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c

[ ... ]

> @@ -376,14 +378,27 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
>  	 */
>  	node =3D dev_to_node(&dev->dev);
>  	dev->is_probed =3D 1;
> +	node_invalid =3D node < 0 || node >=3D MAX_NUMNODES || !node_online(nod=
e);
> +	node_cpus =3D node_invalid ? cpu_online_mask : cpumask_of_node(node);
> +
> +	/*
> +	 * If the current task is a wq kworker activated by queue_work_on()
> +	 * below, the kworker is affined to a designated CPU and won't be
> +	 * switched to another one. So the current CPU can be checked to see
> +	 * if it is in the right node.
> +	 */
> +	if (current->flags & PF_WQ_WORKER) {
> +		cpu_in_node =3D cpumask_test_cpu(get_cpu(), node_cpus);
> +		put_cpu();
> +	}
> =20
>  	cpu_hotplug_disable();
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
> -	 * device is probed from work_on_cpu() of the Physical device.
> +	 * device is probed from work_on_cpu() of the Physical device or when
> +	 * the current CPU is in the desired node.
>  	 */
> -	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
> -	    pci_physfn_is_probed(dev)) {
> +	if (node_invalid || cpu_in_node || pci_physfn_is_probed(dev)) {

[Severity: High]
This is a pre-existing issue, but does using NUMA locality as a proxy for
deadlock avoidance provide an incomplete fix for the workqueue recursive
locking hazard?

While this suppresses the lockdep warning for typical setups where a parent
and child share the same NUMA node, what happens if a nested probe occurs
for a device assigned to a different NUMA node?

If cpu_in_node evaluates to false during a cross-node nested probe, it
appears the code will fall through to the else block, queue a new work item
to pci_probe_wq, and call flush_work() on it.

If this nested probe is initiated from a work item already executing on
pci_probe_wq, wouldn't waiting on a new work item queued to the same
workqueue trigger the exact same recursive lockdep warning, and potentially
deadlock if the workqueue's max_active workers are exhausted?

>  		error =3D local_pci_probe(&ddi);
>  	} else {
>  		struct pci_probe_arg arg =3D { .ddi =3D &ddi };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607221103.7031=
33-1-longman@redhat.com?part=3D1
