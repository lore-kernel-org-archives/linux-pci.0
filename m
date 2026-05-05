Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29021255A
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778017949; cv=none; b=acBj2DaWDhJSROizpnlCHlTZUOZnSddrKlIHnFV4f0ZP+BI+e2w8Q1pfjPa7/wVa5MgHOF5IKUdjER2dWZ1U56ST9bdxNRtpS5gQlt1Xt/RgZfCNJRW9tHJNZa/zqXpiIk8sqhrHrrGsy1t/4Y88dzSG3AMZIXmQzskw9MUA2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778017949; c=relaxed/simple;
	bh=QkCArRIELECPz1MzPTUCGcwOmLkdbVvcH6SbNnQVk4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvIJyUBPLURSQ4EkCShQICx3gHbjARyq16jdNiNWCDyMIwNsqocJYbLprjyLQONYgDMvwsL1vsLq9FHXLvglWD6L47G4X9DOVumssK2cxOgzqSEwfc7uQF/UxRC17SrFINU2f3ORtqhOD+jwJ7n0SzVVSC0jgecyyTFoJob6uK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sutITQFK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sutITQFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5B1C2BCB4;
	Tue,  5 May 2026 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778017948;
	bh=QkCArRIELECPz1MzPTUCGcwOmLkdbVvcH6SbNnQVk4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sutITQFKa55HHJgIUMf7xgwPgPYLC+GhW7Uxrf2YCE00LFio1IOthPCB8NyI0rsYw
	 j4nFVxpbiwMfqJxCAyvwIvb0bO7oqKmdTuu4CNwwFhZ/Q/uMJIOABspFjm0UFIqf3X
	 h0PEMKrNfsYybcXh1Hq1gDtaBLoIEhaH5pnQ5qQ5YsmrMrBXdg5TmHcHM72N14Uj2N
	 EuclYIYEOcUkcwGuFolx+mosELFGJfUEHZmGdqv11kJp2L9Q9fHDm9wN7j99lLYtsC
	 T+R8mKXaG+SggVfpprpueKytJQmoKTNpqsV0JiFq1HjusD8iNqYFZ0xGwQTFZybXih
	 b4irP3PyIY+bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/11] cxl: Limit CXL-CPER kfifo registration
 functions scope
Reply-To: sashiko@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260505173029.2718246-6-terry.bowman@amd.com>
References: <20260505173029.2718246-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 21:52:28 +0000
Message-Id: <20260505215228.8E5B1C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deadlock risk in CPER kfifo registration functions due to non-IRQ-=
safe spinlocks.
--

commit 49bcf423cba32ca4c5cff3926588ae3d815744d1
Author: Dan Williams <djbw@kernel.org>

cxl: Limit CXL-CPER kfifo registration functions scope

This commit replaces EXPORT_SYMBOL_NS_GPL with EXPORT_SYMBOL_FOR_MODULES
for CXL-CPER kfifo registration functions to improve access control. It also
changes the register and unregister functions to return void and adds
synchronous cancellation during unregistration.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..dd0a073af93c3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -778,33 +778,34 @@ static void cxl_cper_post_prot_err(struct cxl_cper_=
sec_prot_err *prot_err,
>  #endif
>  }
> =20
> -int cxl_cper_register_prot_err_work(struct work_struct *work)
> +void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	if (cxl_cper_prot_err_work)
> -		return -EINVAL;
> -
>  	guard(spinlock)(&cxl_cper_prot_err_work_lock);

Could this lead to a deadlock with the hardware error interrupt handler?

Looking at cxl_cper_post_prot_err() which is called from GHES error handling
in hard IRQ context, it uses the IRQ-safe variant to acquire the same lock:

	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);

Since guard(spinlock) in cxl_cper_register_prot_err_work() leaves local
interrupts enabled, if a hardware error interrupt occurs on the same CPU
while the lock is held here, the interrupt handler will execute
cxl_cper_post_prot_err() and spin indefinitely waiting for the lock.

Would it be better to use guard(spinlock_irqsave) here and in the unregister
function to prevent this lockup?

> +	WARN_ONCE(cxl_cper_prot_err_work,
> +		  "CPER-CXL kfifo consumer already registered\n");
>  	cxl_cper_prot_err_work =3D work;
> -	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
> =20
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +void cxl_cper_unregister_prot_err_work(void)
>  {
> -	if (cxl_cper_prot_err_work !=3D work)
> -		return -EINVAL;
> +	struct work_struct *work;
> =20
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	spin_lock(&cxl_cper_prot_err_work_lock);

Similarly, does this need to be spin_lock_irqsave() to protect against
the same deadlock scenario?

> +	work =3D cxl_cper_prot_err_work;
>  	cxl_cper_prot_err_work =3D NULL;
> -	return 0;
> +	spin_unlock(&cxl_cper_prot_err_work_lock);
> +
> +	if (work)
> +		cancel_work_sync(work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505173029.2718=
246-1-terry.bowman@amd.com?part=3D5
