Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3ACDF59;
	Tue, 25 Aug 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625863; cv=none; b=Ysu2WoWW9nQuIPQxCR+JAn9Phzdbu6yblbUt3nnHy3vBxZgzO/MWtqWPN7+s4X/xHppPHlC2iKc1jMnqN1vn91VentI7eGVpk77fDF1JnSQxSn0tMYDxKOnux/KRkn+uOXEoSNEZcLO2KPh62sA43uRgYt+WERDqHXMKciGvSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625863; c=relaxed/simple;
	bh=Gbph5VkgrKWEcTFaySAkqx7Pyko4HEm1uRz8L5RtJI4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a38ibB1ZSu8/uPq27L9ARRC375+62MspyYlAFyfjqau4sgphebxbhxUXmWfC6gRo1hFLJJo166I87rfBs0wGfK/S4rxEvqknuEEbSb6e1fzbXApLljxtJdnPoifs/ZLl8GaHzA9ibme09mVPWJliVkVgHc4RwqOvoHSOBju3B90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE+F00Ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE+F00Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7204C1F000E9;
	Tue, 25 Aug 2026 02:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625861;
	bh=zSGy3ZEBCeqNyaJhMQdzSK1VjkH2Yip98GqDyOvrc00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jE+F00PsZXZJ18XVrMbVrG3uN89HEUxeC5A9KQXqIwfEjahVfq5QUreNEVl8z+nyE
	 lohDxLf4sFHgGtZVfv07Cp3/Nq11zu3bx2WXs8FVfWDJ988kXVszpiisnh1OmiBsmb
	 CthJYuucGvmne6KtkJxaQxyHsmo3hI+0Hp/oHrSu5qO0UQaC5gTTJzt0TZ1wie6wow
	 WtIKmaeMyeHXQoPJIgU2HWR3jq9Bgob5XTWKpY4wfBcAmjre6/ohHyKVy3k5GuvC6h
	 mUYdpbU2piXcZN+sZ3vAr2mMamqJfqa1hZ+CrfMyv0Smsq+AotLCy2d5qTGobbBTf+
	 gwrLI8ErsOv0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] cxl/core: Add region disable and enable for a
 DPort SBR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-8-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-8-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:44:21 +0000
Message-Id: <20260825024421.7204C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] CPU caches are invalidated before the DAX region is unbound, l=
eaving a TOCTOU window where caches can be re-dirtied, leading to fatal Mac=
hine Check Exceptions.
- [High] `cxl_region_disable()` blindly dereferences `p->res` before verify=
ing that the region has an assigned resource, causing a guaranteed kernel p=
anic on unconfigured regions.
- [Medium] `cxl_region_disable` offlines System RAM before checking if CPU =
cache invalidation is supported, leading to unnecessary and permanent memor=
y loss on unsupported architectures.
- [Low] `cxl_region_enable()` misinterprets the return value of `device_att=
ach()`, treating a failure to bind as a success.
--

--- Patch [7]: [PATCH v2 07/13] cxl/core: Add region disable and enable for=
 a DPort SBR ---
commit d35a413a3760382cbad793ba438fa85c779b3677
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

cxl/core: Add region disable and enable for a DPort SBR

A Secondary Bus Reset of a CXL Downstream Port removes the downstream
component from the bus, so a CXL region reached through that Port has to
be disabled while the reset runs.

> diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
> index 55c35386d0cb1..0f398ab0d3a41 100644
> --- a/drivers/cxl/core/dport_sbr.c
> +++ b/drivers/cxl/core/dport_sbr.c
> @@ -1,11 +1,90 @@

[ ... ]

> +int cxl_region_disable(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +	unsigned long block_size;
> +	u64 start, end;
> +	int rc;
> +
> +	/*
> +	 * Per CXL r4.0 sec 9.13.1 an Interleave Set has a Base HPA and a Size
> +	 * that are multiples of 256 MB, while a memory block spans up to 2 GB.
> +	 * A block overlapping either end of the range therefore also covers
> +	 * memory outside this region, so round the range inward to block
> +	 * granularity as dax_kmem did when it onlined the range. Offlining a
> +	 * straddling block would migrate pages that the reset does not affect.
> +	 */
> +	block_size =3D memory_block_size_bytes();
> +	start =3D ALIGN(p->res->start, block_size);
> +	end =3D ALIGN_DOWN(p->res->end + 1, block_size);

[Severity: High]
If a region is partially configured, such as when an administrator clears i=
ts
size via sysfs (free_hpa()), p->res can be NULL.=20

SBR can still collect this region if it has endpoints attached.

Would dereferencing p->res->start and p->res->end here unconditionally caus=
e a
kernel panic for unconfigured regions?

> +	if (start >=3D end) {
> +		dev_dbg(&cxlr->dev, "%s: HPA %pr spans no whole memory block, no Syste=
m RAM to offline\n",
> +			__func__, p->res);
> +	} else {
> +		rc =3D cxl_offline_memory(start, end - start);
> +		if (rc) {
> +			dev_warn(&cxlr->dev, "offline System RAM failed before reset: %d\n",
> +				 rc);
> +			return rc;
> +		}
> +	}
> +
> +	rc =3D cxl_region_invalidate_memregion(cxlr);

[Severity: Medium]
Could this sequence permanently strand System RAM?

If the system lacks CPU cache invalidation support,
cxl_region_invalidate_memregion() will fail and return -ENXIO.

Because cxl_offline_memory() has already succeeded at this point, the memory
is left offline indefinitely. When the SBR is aborted, the subsequent
cxl_region_enable() will only rebind the driver and won't bring the memory
back online.

> +	if (rc) {
> +		dev_warn(&cxlr->dev, "CPU cache invalidate failed before reset: %d\n",
> +			 rc);
> +		return rc;
> +	}
> +
> +	device_release_driver(&cxlr->dev);

[Severity: Critical]
Is it safe to invalidate the CPU cache before unbinding the DAX driver?

Since cxl_offline_memory() is a no-op for DAX regions, userspace PTE mappin=
gs
remain fully active. By invalidating the cache before calling
device_release_driver(), a TOCTOU window is opened where an unprivileged
process could dirty cachelines again.=20

If this happens, when the downstream port is reset via SBR, any CPU eviction
of those dirty cachelines will trigger a PCIe Unsupported Request and escal=
ate
into a fatal Machine Check Exception, crashing the host.

> +	dev_dbg(&cxlr->dev, "%s: System RAM offline, region disabled before res=
et, HPA %pr\n",
> +		__func__, p->res);
> +
> +	return 0;
> +}
> +

[ ... ]

> +void cxl_region_enable(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p =3D &cxlr->params;
> +
> +	if (device_attach(&cxlr->dev) < 0) {

[Severity: Low]
Does this correctly handle the case when no driver was found?=20

device_attach() returns 0 when no driver was found, 1 on success, and < 0 on
error. Checking for < 0 here effectively treats 0 as a success.

This could lead to a misleading debug log that says the region was successf=
ully
re-enabled even when it failed to bind a driver.

> +		dev_dbg(&cxlr->dev, "driver re-attach failed after reset\n");
> +		return;
> +	}
> +
> +	dev_dbg(&cxlr->dev, "%s: region re-enabled after reset, HPA %pr, IW %d,=
 IG %d\n",
> +		__func__, p->res, p->interleave_ways, p->interleave_granularity);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D7
