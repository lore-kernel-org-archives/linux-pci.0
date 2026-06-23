Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5854774;
	Tue, 23 Jun 2026 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191541; cv=none; b=XX2AiXP1iSZgkZIHMwSHvtKTNQ1m9ZU4WdXphZoZZeXPbZWUywhenoy49D6nRgWfIw+xapGuVJ+EVsG5zDTs2wEjZXB0PlOHAoIceXg5X8gAZd/Y/R2ONipWF3LKiL2gr119/irjT8X5zhsBvLAgAI5zXhTiQerB61LxYJ6/rCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191541; c=relaxed/simple;
	bh=XceX93PmUwKcYbDgQZQF7dhvJ4sHlu7Fgh4Nii0uaHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ef3UZr0M5Zxm1QaHz6L4ZSNCCCw8SfYrpeCPVeAlG3+XzrQDxii5Lzzs9gbfVu3rES4/Lhs4HcuQld8myeVZrUqSFa8zekLx+4iATUIC+ctq/kubwvO4JOEf9woYr0GrQXSnYfWVALG34EHKqI7IUHoQCV9KnZ+LOELb7R8wQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwK5lNXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwK5lNXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C921F000E9;
	Tue, 23 Jun 2026 05:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191540;
	bh=QkKKkt3aKtGx7fvOWdvdbD68eQnN4RWR5RPwAZljTDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XwK5lNXe+UilfB3ir0LpLQ8G0ym6VPXPWT9tScnVoWORZ7g0uMvMErjxAyAxs87Qh
	 EoxSAZPkZ2PCcmgphiOzAVW8P3JJgWHcbTaFOFF1Q/1XFDghtn+zZGLwz+Khvp5MuD
	 sleqGWEGIoR9irVCQQTCRGWGK2kF/bgYObbTMugJseMnNXnyHOmQADJOKBmqVtf5g1
	 0IC45mGAJSbgvTs5wMDbMc7/PGfbc8WiKRtFk9t1RpQE8t4UJyGA+tORA6LVY+4DNi
	 IkZuXEgmv0vVm9oySedixuruz9e5L+uV/zUbhQUDicRokkqJc9SudIOfScZNSPK8mM
	 kULhhjnj6xF5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/21] PCI/TSM: Rename pf0 to host
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-11-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-11-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:12:20 +0000
Message-Id: <20260623051220.66C921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free and freed mutex unlock in `__pci_tsm_disconnect()` =
for hosts on PF > 0.
- [High] Disconnecting any TSM host blindly destroys independent TSM contex=
ts of sibling functions in the same PCI slot.
--

commit 8bf82a17d0ecf2259067413b6fb0b2c2e2bef4d9
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/TSM: Rename pf0 to host

Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
names from pf0 to host) as part of converting pci_tsm_host
to be any device that knows how to speak any of CMA, IDE, or
TDISP.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c

[ ... ]

> @@ -441,19 +441,19 @@ static void __pci_tsm_disconnect(struct pci_dev *pd=
ev)
>  	/*
>  	 * disconnect() is uninterruptible as it may be called for device
>  	 * teardown
>  	 */
> -	guard(mutex)(&tsm_pf0->lock);
> +	guard(mutex)(&tsm_host->lock);
>  	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);

[Severity: High]
Can this lead to a use-after-free and memory corruption when a TSM host
is on a Physical Function > 0?

When disconnecting a host on PF > 0 (such as a CMA host on PF 1),
pci_tsm_walk_fns_reverse() iterates over the slot. The walker skips
the callback only for i =3D=3D 0. When i > 0, it applies the teardown to the
function itself:

drivers/pci/tsm.c:pci_tsm_walk_fns_reverse() {
    ...
    /* on exit, caller will run @cb on function 0 */
    if (i > 0)
        cb(pf, data);
}

This causes remove_fn() to be called on PF 1 itself, which frees the
tsm_host object via pci_tsm_host_destructor() and kfree(). When
__pci_tsm_disconnect() returns, the guard attempts to unlock the destroyed
and freed mutex.

[Severity: High]
Does this unintentionally destroy the TSM contexts of independent
sibling functions?

The call to pci_tsm_walk_fns_reverse() unconditionally applies remove_fn()
to all functions in the slot. If multiple independent TSM hosts exist
within the same PCI slot (for example, PF 0 as a TDISP host and PF 1 as a
CMA host), disconnecting one host will cause the walker to execute
remove_fn() on the other siblings.

drivers/pci/tsm.c:remove_fn() {
    tsm_remove(pdev->tsm);
    link_sysfs_disable(pdev);
    return 0;
}

Since remove_fn() does not verify if the function's TSM context actually
belongs to the specific host being disconnected (the data argument is NULL),
could disconnecting PF 1 silently wipe out the entirely separate host
context of PF 0?

>  	ops->disconnect(pdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D10
