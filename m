Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA233AFCE6;
	Fri, 17 Jul 2026 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328563; cv=none; b=jfyqc2I7EWFrgZ4+OzP82DXfGcuVvoS9C20CcFL4xebC6CgemfFqyywZ4xJfyG5PnTDEcdkiHKZ6cQZO+F3tGl8Jvf/U1Jdpc2FBhQeMtlcF2XiHbBJmDVW9qhUufvAYTqb8rJNO/g9jjsz3i7g8YrLkX8NkM/Lo3xUnoB1ydfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328563; c=relaxed/simple;
	bh=0zX6OjndRwjWmaPjtDOZXzvBrYSwf2Nbut174NhKfMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i5PeCz4xidEhK7WZjFrtn2kJBuxvvxeX3En+Q9sf+HrcrncL4bGI0GmkPvky1EvvcF6l9mTnPhUkbgTDquB2fTIcthnPmdue3qXJhyI9L1qWh8+/+3pZkoPXE7I+zqUt16Z1BvC2O1X/MIWaqVwWqFgz+Q0iNayvHhwtVxjfiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwidc+1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwidc+1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F80E1F000E9;
	Fri, 17 Jul 2026 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328559;
	bh=5ITxKwozjUA8fiHKe2g0+otGlLvixu4Xvel3MNKRdfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vwidc+1i3XJLMDwDjzIeB/lh21F2HzKXL0T/iI2r2Hplvga6Nv7v6u3hHNa/ZgYb+
	 5QR+OrajbxWRqYxlONI7h20cIpkSfjrq22fBUzAFn63/6uGE/0gwTwoJHELjFuhlyk
	 UYR2vGt2JKCYeQiwVQ0TwkWczHZDr4DQ0/wHqGRRz7HXpU0t3hbvlks8lG2UnCz+kQ
	 IDo2EVLRNgtAb+z9/P2ILjXkweI9JftzSALTmiDUiX/BFGZoQ8zrhe7d7oVoi5vtoC
	 D0hIJ2m6WaLrlsf3Jk4y+YZJ8HviyBPzJEOKObZQhvtgwvoA1r8csD7/3eXyYp8Mir
	 fPLMb0k8HySXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL
 CPER work locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-3-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:49:19 +0000
Message-Id: <20260717224919.9F80E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The patch adds internal cancellation to both unregister functions b=
ut misses removing the redundant `cancel_work_sync()` for the protocol erro=
r work in `cxl_ras_exit()`.

Pre-existing issues:
- [High] Fixed-size memcpy in cxl_cper_post_event causes an out-of-bounds r=
ead if the provided GHES CPER payload is smaller than sizeof(*rec).
- [High] Missing bounds check on untrusted dvsec_len in cxl_cper_setup_prot=
_err_work_data leads to an out-of-bounds read.
--

--- Patch [2]: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL=
 CPER work locks ---
commit 70fa064ce36bd35723148aab9a91c80d0fbef760
Author: Terry Bowman <terry.bowman@amd.com>

acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

This commit converts cxl_cper_work_lock and cxl_cper_prot_err_work_lock from
spinlock_t to raw_spinlock_t to prevent a deadlock between IRQ and process
contexts. It also restructures registration functions to warn on double
registration and clear work pointers before cancelling them. Redundant
cancel_work_sync() calls are removed since quiescing is handled internally.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..ca7a138c1ff2e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_se=
c_prot_err *prot_err,
>  	if (cxl_cper_sec_prot_err_valid(prot_err))
>  		return;
> =20
> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> =20
>  	if (!cxl_cper_prot_err_work)
>  		return;

[Severity: High]
This is a pre-existing issue, but does cxl_cper_setup_prot_err_work_data()
lack bounds checking on the untrusted dvsec_len?

If firmware provides a CXL protocol error record with a maliciously large
dvsec_len, could this lead to an out-of-bounds read when calculating
cap_start?

drivers/acpi/apei/ghes_helpers.c:cxl_cper_setup_prot_err_work_data() {
    ...
    dvsec_start =3D (u8 *)(prot_err + 1);
    cap_start =3D dvsec_start + prot_err->dvsec_len;

    memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
    ...
}

[ ... ]
> @@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type e=
vent_type,
>  		return;
>  	}
> =20
> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
> =20
>  	if (!cxl_cper_work)
>  		return;

[Severity: High]
This is a pre-existing issue, but does cxl_cper_post_event() have an
out-of-bounds read if the provided GHES CPER payload is smaller than
sizeof(*rec)?

If firmware provides a CXL event record where gdata->error_data_length is
smaller than sizeof(struct cxl_cper_event_rec), this fixed-size memcpy
could exceed the bounds of the error status block:

drivers/acpi/apei/ghes.c:cxl_cper_post_event() {
    ...
    wd.event_type =3D event_type;
    memcpy(&wd.rec, rec, sizeof(wd.rec));
    ...
}

[ ... ]
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c2..7c6faee7f85ed 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
>  static void __exit cxl_pci_driver_exit(void)
>  {
>  	cxl_cper_unregister_work(&cxl_cper_work);
> -	cancel_work_sync(&cxl_cper_work);
>  	pci_unregister_driver(&cxl_pci_driver);
>  }

[Severity: Low]
Is there a missed redundant cancel_work_sync() call in cxl_ras_exit()
that should also be removed?

Since internal cancellation was added to the unregister functions,
cxl_ras_exit() now has redundant synchronization:

drivers/cxl/core/ras.c:cxl_ras_exit() {
    ...
    cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
    cancel_work_sync(&cxl_cper_prot_err_work);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D2
