Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BB30D3EF;
	Tue, 25 Aug 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625639; cv=none; b=ZCmBru4misxh0nD6S2QYIuuSPy9cE2db/NNrULX0Rlz77hNkOOEidvPJsRZOUQgXBmoUfpZsWraeN7WrkYMFhPS+RXDzpCdWCLkeZUz5/vi2weuoYozExRiGzJ6DmwQvWGs0cNXNTXmI1EyaoF85xkBudYaFhQjpTG+AHgFDi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625639; c=relaxed/simple;
	bh=RY/4bTYe9OzzWcngml23yUbpe8Xun97v36+qXODd61M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J5BwYedkXeiF95psnl05sWtMvLyet8l6TSJUtjfovDPDshc/+KPxLaOw4b1xWroWOApvscRmfRk5UM5wyd1q2Qe8ZZaO7bP7MBs/T1NzPJAasfpa1CQypuZ5KL8Igk4vMh+QmnPAC4jIXBS5RTFY+seWaxbgnDeUexb8zdwfljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHWbe5tu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHWbe5tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDF71F000E9;
	Tue, 25 Aug 2026 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625637;
	bh=ja5KfhSjq2qwMYJJD+qKPR8e8G7q465SrjA10hV7Fss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EHWbe5tulsJ3xXBBF3+rqNn1lR1AB+QoSH89j8EKDx/Lv11ZM0JrspNMZ1NEiqi0e
	 muTIgeqO6Xb5pgF7Hy8u2PPWV5ZpGhkUWB0+eOcGAIQj1EJF8qTiRwGPx/HrLguvVT
	 W6MUW/1tkU3z1aW+n2gZBCN2a69Hx3LAT18XIMxLvNMN0k4pwZ/Y4yX6HTABaQjnEq
	 KPYQI040xqH9PR5rHJNEt+f5Tbt3lyPLzvhjCuQbDy8hPEzwvNDiO/q7rtDrFT9iew
	 Be2CdX5Mhb5ygMPe788wQED1DS37K5g8ZHQvHpMsXuuAtbbRI0RIw3da/D9jvVTR81
	 FGomZ29oWLVsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] drivers/base/memory: Add cxl_offline_memory()
 to offline a physical range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-7-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-7-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:40:37 +0000
Message-Id: <20260825024037.7BDF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_offline_memory() leaves memory blocks partially offlined and p=
ermanently stranded if device_offline() fails midway, lacking a state-track=
ing and rollback mechanism.
--

--- Patch [6]: [PATCH v2 06/13] drivers/base/memory: Add cxl_offline_memory=
() to offline a physical range ---
commit 00648cd16fe5b1311f9ee6c83c16afccf56f6b3d
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

drivers/base/memory: Add cxl_offline_memory() to offline a physical range

A CXL region whose capacity is online as System RAM must be taken
offline before a Secondary Bus Reset of the CXL Downstream Port it is
reached through.

> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index bcfe2d9f4adbd..ce89b251d34ac 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c

[ ... ]

> @@ -1018,6 +1018,42 @@ int walk_memory_blocks(unsigned long start, unsign=
ed long size,
>  	return ret;
>  }
> =20
> +static int cxl_offline_memory_block(struct memory_block *mem, void *arg)
> +{
> +	int rc =3D device_offline(&mem->dev);
> +
> +	/* device_offline() returns a positive value when already offline. */
> +	if (rc > 0)
> +		return 0;
> +
> +	return rc;
> +}
> +
> +/**
> + * cxl_offline_memory - offline the memory blocks spanning a physical ra=
nge

[ ... ]

> +int cxl_offline_memory(u64 start, u64 size)
> +{
> +	int rc;
> +
> +	lock_device_hotplug();
> +	rc =3D walk_memory_blocks(start, size, NULL, cxl_offline_memory_block);

[Severity: High]
If device_offline() fails midway through a range (for example, due to
unmovable or pinned pages), will this leave the system in an inconsistent
state with partially offlined memory ranges and silent capacity loss?

When walk_memory_blocks() aborts on an error from cxl_offline_memory_block(=
),
there doesn't appear to be a rollback mechanism for blocks that were already
successfully offlined.

Additionally, since cxl_offline_memory_block() treats an already-offline
block as a success but doesn't record that state, how could a caller
safely roll back without accidentally onlining a block that was originally
offline before cxl_offline_memory() was called? Core memory hotplug APIs
typically allocate an array to track original states to handle these failur=
es.

> +	unlock_device_hotplug();
> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D6
