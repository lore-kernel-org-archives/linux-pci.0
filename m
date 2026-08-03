Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15F2D5436;
	Mon,  3 Aug 2026 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796797; cv=none; b=UWmhsO3xEryRdc+BpHbfGBptYglEACuZAMtmL2vlPdeVNu5Ug7qjNkiyr46ZwqZJDIH3TkINZjan+8ksY+fE8CI10+/5erA1A/g3qgVF++EY/tJgsYZA8jB7xOSJsIZNthEnQL2okrMZlW1uK0fpbq/t4cLgO7vTpOZjxporljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796797; c=relaxed/simple;
	bh=7Wr7WhA2bUmxxPUiu7/qrcBvEazwQoeY/17x32MZ3ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lUOmwc93vjzhhuTyaLUNX+WoUH0Ka669Cv3gGDRbRa2SsXAg1go1XNOox6z4jXJr3vMpsUx+Jc9KSQ6mXT6+dCiGa0urs3uZJMfm6AsXThazoxzR8rneqrXEXtwgz+XNPXZqNyK151sG7pEBYBPYOtbh91rWnPvtzME2tVVN0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EST7ILV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EST7ILV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D011F000E9;
	Mon,  3 Aug 2026 22:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796795;
	bh=YFTyjyQdt+2r//OMfB5UfsSLev1R36F0/Vh6XFw/328=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EST7ILV+pQTw8QsZRmxkqbLTtuGppqM4WDzllkatzKRdah44ThZGadtXkx/nC1Cxm
	 HJCFWdAcUwiQ4ZauSR7ontajdvarsgei4VHU/AMnsGPleP/FhcNHumYm3Kho5m26VI
	 TVc87tpfmylY5YqBen35piU0cbeJRWO+VZTwl3gWhcIy8ra9B2MIBrE0IqISyIz/0J
	 WPRgwqevWHoYwUzIM1dWI6y9RE4rxQEL+FDYOeGDYo0CnWoLc1hSrR+7lueiK9peZ+
	 NSNOL7bXt/cLXts5xCPcdRlOfhQI0t23+3fGsxL6fq9Y6h2VgaKiDEh/iX77tjKa/M
	 LxEiEFJrVsGsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 03/14] acpi/apei/ghes: Use raw_spinlock_t for CXL
 CPER work locks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-4-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:39:53 +0000
Message-Id: <20260803223955.54D011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds checks on CPER CXL event and protocol error payload=
s can cause out-of-bounds reads, potentially leaking kernel memory via trac=
e events or crashing the kernel.
--

--- Patch [3]: [PATCH v19 03/14] acpi/apei/ghes: Use raw_spinlock_t for CXL=
 CPER work locks ---
commit 9ad943c529c38ff6736192a1064f09367d33c360
Author: Terry Bowman <terry.bowman@amd.com>

acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

The CXL CPER work registration and unregistration helpers acquire
cxl_cper_work_lock and cxl_cper_prot_err_work_lock with a spinlock
guard(), which leaves local interrupts enabled. This commit converts
both locks from spinlock_t to raw_spinlock_t to prevent deadlocks with
the GHES error notification path executing in hard IRQ context.

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
This isn't a bug introduced by this patch, but is it possible for this code
to read out of bounds?

In cxl_cper_post_prot_err(), it subsequently calls
cxl_cper_setup_prot_err_work_data() (in ghes_helpers.c) which does the
following:

	memcpy(&wd->prot_err, prot_err, sizeof(wd->prot_err));

	dvsec_start =3D (u8 *)(prot_err + 1);
	cap_start =3D dvsec_start + prot_err->dvsec_len;

	memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));

Could an untrusted or overly large dvsec_len cause cap_start to point
to unmapped memory, resulting in a page fault during the memcpy?

If it reads adjacent mapped memory, could that out-of-bounds data be leaked
to userspace via trace events when the workqueue processes the struct?

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
This is a similar pre-existing issue. In cxl_cper_post_event() (just below
this quoted hunk), the code copies the payload using a fixed size:

	wd.event_type =3D event_type;
	memcpy(&wd.rec, rec, sizeof(wd.rec));

Could this copy out-of-bounds memory if the firmware provided a payload
where the outer envelope (gdata->error_data_length) is smaller than
sizeof(wd.rec)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D3
