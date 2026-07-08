Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C63DD521;
	Wed,  8 Jul 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520340; cv=none; b=AdlrI44jof3Ii7Djb1RAVcpyfaD2EpogR+ca3epZBx8t+JfNYJbVxI8SJx1HzOTGaGpMnzivSeGd/0m9CyL+f0WyY5UnO7uG1suINgJ9heiwJiKbk7JlRPCNGlVdUzJnmpoL9UF2d1g+EPBSQgxcR39oadDiJAlT9ae97O/5P/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520340; c=relaxed/simple;
	bh=fOzJkjxDbOrRAvTsGerqLHWP8Cz+Hrn0BW/bvNZZMHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OvF4JGJms3PeLBVFdY0Vuf1bhABWS8bK52InmIuvkhzZIl32cJCblqedJY4VeUSZUP3BBFdxBDTMlXXDR2d7AjoMr+OgwAwucirWt1dxVsrzMRAtDpoLPXOcZFkkQMVN7vxu6ATfcaShw50H0ELH5cDw7AVEIe+i9RCC0w8fAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4V7dn7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4V7dn7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA971F000E9;
	Wed,  8 Jul 2026 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520339;
	bh=NwNT0QCjvrCLZjfXZ5TBdKmomGeKfZSve40+9Ja4lnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4V7dn7giEM4vozaZvTqhVHC96PgceOONxQ7WLZb5V4IrNeXbEzhn60N2FVk2A+zE
	 bJoK+WLiYNE+PoPdyBDmfaXHjKb5fz2QKj3ozOSKeBK2S5fgEe8NApl6VZtrYV4Dj5
	 Qo5PXTtI6aYeJwFDUhvoegLq1q/YO18RnJUaPEarlNwVfmV08Sbz+fidYaw/Qgub3W
	 BZX9Qsj+XfnIvNxGNVkr2LRVUmGginCFCYPYIWivYJE7PXa1EcgIbHQKgs7Mb5DoYW
	 8eqXFbov8950fzgxadf45N5REfPgpYhSr1RVRFnXgd/7K9XeiABNmti7kEmLQCdDUg
	 iS/BWE6LnBcgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] ACPI: APEI: GHES: share macros via a private
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-1-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-1-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:18:58 +0000
Message-Id: <20260708141859.0FA971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unmapping GHES error status memory races with NMI/SEA handlers rea=
ding it locklessly under RCU.
- [High] Lockless iteration of `ghes_devs` in `ghes_edac` races with `ghes_=
remove`.
--

--- Patch [1]: [PATCH v7 01/10] ACPI: APEI: GHES: share macros via a privat=
e header ---
commit cfd79e83a33cc5873f3f8f572468468d4d6a93f1
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: share macros via a private header

Carve the CPER helper macros out of ghes.c and place them in a private
header so they can be shared with upcoming helper files. Move the vendor
record entry declaration and the prototypes for the CPER read and clear
helpers along with ghes_new() and ghes_fini() into the same header. This
requires dropping their local static visibility in ghes.c. Also synchronize
ghes_proc_irq_work during ghes_remove() to avoid a use-after-free.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..c73a316644e8a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -313,7 +255,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic=
 *generic)
>  	return ERR_PTR(rc);
>  }
> =20
> -static void ghes_fini(struct ghes *ghes)
> +void ghes_fini(struct ghes *ghes)
>  {
>  	kfree(ghes->estatus);
>  	apei_unmap_generic_address(&ghes->generic->error_status_address);

[Severity: High]
This isn't a bug introduced by this patch, but does unmapping the error
status memory here race with NMI/SEA handlers reading it locklessly
under RCU?

If a root user unbinds the GHES driver (triggering ghes_nmi_remove() or
ghes_sea_remove()), those functions call ghes_unmap_error_status() and
unmap the I/O memory before synchronize_rcu() completes.

For example, an NMI/SEA handler locklessly iterating the list under
guard(rcu)() in ghes_has_active_errors() could concurrently access
ghes->error_status_vaddr and execute readl() on the unmapped pointer:

drivers/acpi/apei/ghes.c:ghes_has_active_errors() {
    ...
    if (ghes->error_status_vaddr &&
        readl(ghes->error_status_vaddr))
    ...
}

Could this trigger a kernel panic due to a fatal page fault or data abort?

[ ... ]
> @@ -1852,6 +1794,7 @@ static void ghes_remove(struct platform_device *ghe=
s_dev)
>  		break;
>  	}
> =20
> +	irq_work_sync(&ghes_proc_irq_work);
>  	ghes_fini(ghes);
> =20
>  	mutex_lock(&ghes_devs_mutex);

[Severity: High]
This is a pre-existing issue, but is it safe for ghes_remove() to lock
ghes_devs_mutex, remove devices from the list, and free them with
kfree(ghes) while ghes_edac_init() iterates this list locklessly?

If an administrator loads the ghes_edac module while concurrently unbinding
a GHES device via sysfs, ghes_edac_init() iterates over the global
ghes_devs list without acquiring ghes_devs_mutex:

drivers/edac/ghes_edac.c:ghes_edac_init() {
    ...
    list_for_each_entry_safe(g, g_tmp, ghes_devs, elist) {
        ghes_edac_register(g->dev);
    }
    ...
}

Since list_for_each_entry_safe() does not protect against concurrent
deletions by other threads, could this lead to a use-after-free or list
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D1
