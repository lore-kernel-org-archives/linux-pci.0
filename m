Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAC35F18A
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482642; cv=none; b=ZMA1gSBGRCyuni+9iqRhJK+DZejMvxDAnOl4ldKCrAR+KlFfqWLimdKkwV5MEe5AAIwVlrzepZOtAMNwIdz7EBIEBy2/iraOAujyxEM0XknVE5EKvB5PHQd2zL8mvdA2Z4DRPAqA2Wl6+F5HPyE4f+ffV8knxHd/C2JcD57gaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482642; c=relaxed/simple;
	bh=NshEbc87u5tA6V5/wF7DaQweenvoTz8daD3dejarfs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KnGdqMbZ+ru4Njf793Tv/I1KmF6RHv/fy3vcuWy2MiG8Fb1/cCR7GznxiwucfoJQtphvR/64isavyjg6gp0jR/uMMxW+mSTN+4CYcA8WBTfRLeHxLSV3OFcTQDfUjBgo5N+kRJcJ3H+QcN4YZp2YfXrcyEBADkUAxsacnGZc6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS8lhqhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS8lhqhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7A1F00A3D;
	Fri, 22 May 2026 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779482641;
	bh=GtPBw0ZMSB+J2pBz+2ZozLDYVl/cK2UKZrm0WBTZOOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DS8lhqhOLzeV5a3+M+sSCqoTs5u2heKmMxi+6qVr46I5aFwaBOcu8ux5o2Jfaf+Qt
	 Y9LKy/8e2R67vIDS9GUCI6TKy1yIJtJ/+dxuLCTmJWjezCto6/27/QZBAcHtwS53G8
	 8XA7n+PHgxwOMFbJypCBQHODcNH3oZGED+36fzqfUou9dNOsRrfgj76TiuCm3WUBtW
	 QjBfemC+Opkprh8iMSTh8L/T9rWhFb2lHlzwaE5CdHM+x8vCEQ6EUcay+AafeegROz
	 ZSikJ6L+sHBjXJwxe42KapKw2BLYQuZa6VdtDx9geqmxH8e27P9mOQZg+m0UeUwUUp
	 UZ/0MWNOkwMVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Prevent workqueue code nesting in pci_call_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waiman Long" <longman@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522201406.1057431-1-longman@redhat.com>
References: <20260522201406.1057431-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 20:44:00 +0000
Message-Id: <20260522204400.D0A7A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypassing the workqueue context switch for tasks identified as kwo=
rkers enables a deterministic kernel stack overflow through unbounded recur=
sion when probing nested PCI topologies.
- [Low] The `wq_kworker()` helper uses an inefficient and brittle string se=
arch (`strstr`) on `current->comm` instead of the standard task flag.
--

commit ccb28447ef5f5ccb4af61ff521cadbec5879d906
Author: Waiman Long <longman@redhat.com>

PCI: Prevent workqueue code nesting in pci_call_probe()

This commit attempts to prevent lockdep recursive warnings caused by
nested workqueue calls in pci_call_probe(). It introduces a helper to
check if the current task is a kworker and, if so, executes
local_pci_probe() synchronously instead of recursively calling into
workqueue code.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0f..268ac59ad49a1 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -363,6 +363,14 @@ static bool pci_physfn_is_probed(struct pci_dev *dev)
>  #endif
>  }
> =20
> +/*
> + * Return true if current task is a workqueue kworker
> + */
> +static bool wq_kworker(void)
> +{
> +	return (current->flags & PF_KTHREAD) && strstr(current->comm, "kworker"=
);
> +}

[Severity: Low]
Is there a reason to use a string comparison on current->comm instead of
checking current->flags & PF_WQ_WORKER?

Other kernel threads might coincidentally contain "kworker" in their name,
leading to false positives that skip queue_work_on() and defeat the NUMA
optimization in pci_call_probe().

> +
>  static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  			  const struct pci_device_id *id)
>  {
> @@ -380,10 +388,11 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
>  	cpu_hotplug_disable();
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
> -	 * device is probed from work_on_cpu() of the Physical device.
> +	 * device is probed from work_on_cpu() of the Physical device or when
> +	 * the current task is a workqueue kworker.
>  	 */
>  	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
> -	    pci_physfn_is_probed(dev)) {
> +	    pci_physfn_is_probed(dev) || wq_kworker()) {
>  		error =3D local_pci_probe(&ddi);

[Severity: High]
Does bypassing the workqueue context switch here expose us to a kernel stack
overflow when probing nested PCI topologies?

Because the initial probe runs in a kworker, wq_kworker() will evaluate to
true, causing any nested probes to execute synchronously on the same stack.

If a deeply nested PCIe topology is presented (e.g., via Thunderbolt with
chained VMD endpoints), could the recursive synchronous calls to
pci_call_probe() exhaust the 16KB kernel stack and trigger a system panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522201406.1057=
431-1-longman@redhat.com?part=3D1
