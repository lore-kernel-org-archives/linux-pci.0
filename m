Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA83BD64A
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803779; cv=none; b=u3pEXjpZ63peecLLpoOYolskKVqOa9TXkagdBrlsxA39ixPSRs3ZT1Y/VLSyvaN0MhcppjdwaFpr6LrpuqSOh8glZvLHLbV30GULL2F9ng0zhn/SiCqWco4kbpMYLW0oGgAvwcxu1jbdRF5AX0+LElirgZ9pjV13HG70K1odtoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803779; c=relaxed/simple;
	bh=Xl68xvB1qdD1+EqTGDV5Ue+Ha5W5pJSPrHGCj8BrTfM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARL0dsZIHCG2tMpPWbsTyOLN55ISu6vm6TpIkKGaHO7LVLM52qbPrIUpMPrQM1rBsE7oCojMy222FU8I2C3d8gpp9utj5JZfc88KlPSbSqFYHuYiuRd7SXcJSOYyeX3/7Q5lGhfiADeifBKoBsANeINEOx+CQgH3CgbDkC7zDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWRaHoQt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWRaHoQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78461F00A3C;
	Tue, 26 May 2026 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803778;
	bh=B4iOXFCinHYvVod83pwPQZL9SsGG0x2fYrvDnsPkofM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWRaHoQtq1oJXEImgpBCVPt4BdtNWG0LTB3/HrdUk9Dd0VyeljdMj7gj0xbCs/KBh
	 Gixm+ETpORlGrrKeaaAn6azrWeAdgbpatdriLoveYOA893K6YSA1UHc2q1h4TzLllP
	 bBxdallts4vP9/ZyqQs1JEoWV+H3n/upa3t5M6b/P/TsObY9o/sZk+Yptg6rxe17Ex
	 52KcgQqcS9mi9H4BxkEzdsyt3U1hsJOqsBgATZhHvJmHrTQpF1okwGBk03x6NNF4Vt
	 mb47kpN8YzdB65YZqWB9D2kJkSgfDHEn5tY8d4dv2+H7ZWV76Js46vuDWngqiybq2B
	 cxgnp3qogeVDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Prevent workqueue code nesting in
 local_pci_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Waiman Long" <longman@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260526133403.1253961-1-longman@redhat.com>
References: <20260526133403.1253961-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:56:17 +0000
Message-Id: <20260526135617.E78461F00A3C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypassing workqueue offloading for nested PCI probes introduces a =
kernel stack exhaustion vulnerability by forcing synchronous recursive exec=
ution.
- [Medium] The wq_kworker() check unconditionally bypasses NUMA-aware drive=
r probing for all devices handled via deferred and asynchronous probing.
--

commit ac533ba29766ca66a46468c481cec06fd7c11e92
Author: Waiman Long <longman@redhat.com>

PCI: Prevent workqueue code nesting in local_pci_probe()

local_pci_probe() and hence pci_call_probe() can be called
recursively. If the recursive calls are done indirectly via workqueue
kworker, a lockdep recursive warning can be produced.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d10ece0889f0f..29f0e5191a545 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
[ ... ]
> @@ -380,10 +388,17 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
>  	cpu_hotplug_disable();
>  	/*
>  	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
> -	 * device is probed from work_on_cpu() of the Physical device.
> +	 * device is probed from work_on_cpu() of the Physical device or when
> +	 * the current task is a workqueue kworker.
> +	 *
> +	 * TODO: With a deeply nested PCIe topology, pci_call_probe() can be
> +	 * recursively called multiple times. If the nesting is deep enough,
> +	 * it may cause exhaustion of the kernel stack. So some additional
> +	 * changes will be needed if such a deeply nested topology is to be
> +	 * supported.
>  	 */
>  	if (node < 0 || node >=3D MAX_NUMNODES || !node_online(node) ||
> -	    pci_physfn_is_probed(dev)) {
> +	    pci_physfn_is_probed(dev) || wq_kworker()) {

[Severity: Medium]
Will this unconditionally bypass NUMA-aware driver probing for all devices
handled via deferred and asynchronous probing?

Since deferred device probing (via deferred_probe_work_func) and asynchrono=
us
probing execute within workqueues, wq_kworker() will evaluate to true for
these devices.

This would cause pci_call_probe() to bypass queue_work_on() and execute
local_pci_probe() synchronously, which might nullify the local NUMA memory
allocation optimization that pci_call_probe() provides. The driver probe
would run on whichever CPU the background workqueue happened to be scheduled
on, potentially leading to suboptimal memory node allocations.


[Severity: High]
Does bypassing workqueue offloading for nested PCI probes introduce a kernel
stack exhaustion vulnerability by forcing synchronous recursive execution?

Prior to this patch, nested PCI probing offloaded to a new workqueue thread,
preventing stack accumulation because each probe ran on a fresh stack while
the parent blocked.

By forcing synchronous execution when wq_kworker() is true, driver probes
that explicitly enumerate children and trigger further probes (such as the
vmd driver) will now recurse on the same task stack.

Since each nesting level consumes stack space (around 792 bytes as mentioned
in the commit), could this allow deterministic stack exhaustion if a deeply
nested hierarchy of VMD devices is encountered (e.g., via a malicious
hotpluggable PCIe device)?

>  		error =3D local_pci_probe(&ddi);
>  	} else {
>  		struct pci_probe_arg arg =3D { .ddi =3D &ddi };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526133403.1253=
961-1-longman@redhat.com?part=3D1
