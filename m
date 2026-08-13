Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EF235C6A9;
	Thu, 13 Aug 2026 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663593; cv=none; b=GTjJKwTd3pun5R6CLYoL7LS7VNr1xNA9IYcVusYnfoNsntAaij/BTHpkjRAFraimzEELZNx3J7n9jR5zINZ92zXFULCixLEnl4ZPmUuD/Fx7RFwsT+1LLu+nizHOVSl5YZn3fCg5QnZQiKCk94AOyvJH0ARo/mFvbHedJ9yAISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663593; c=relaxed/simple;
	bh=FOdsv0T6tna6jX2s3430Y1k5X79rCGiFdnTAwrd8TDE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S/lFUNPgqhGe7O56YHIF8Udbl6z6On/k+8tM5k9ydOFVDMvAL6uI+7vyPyC2ZgvdOUEKdYi9XiDuhv0ItDp47dI8K10aG7B3MmYn0peWrLRaTzkeiPKg4EczC3mJeeD3v/DLFb7gE9/AuOS0qMLHVlbdp/T8w9kO8QRWSIiuvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTBlh7oa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTBlh7oa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F001F000E9;
	Thu, 13 Aug 2026 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663591;
	bh=qV5p4gtZT2z1Hkd6GtPMesYurodCH4YxhFo0bPvv/Ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nTBlh7oavSC9m9ntSJxHmAoEAHzG6kc61xNTSMoE7gU5y++91x9iucZiE0mVna/Q4
	 UvktB02Y4sWKh4ley2Wy0+fAU9UHtEbgbqlrU6yy1o/le22qmWDKBEwFIYIsy7bpIF
	 7nxYqykFksRt7BNAs+Z1l3MOxFNtVXfLMRxtdx2KFdwTU9VrCUd5PkuRsexj3JAoqa
	 lPEUWkV6Hp3uEg+5t1Zivq3lcuam2JHospOtDD0ocT302YjPtk/jPzrDhpQienOt55
	 6vTnUfRckyIzvragnKQ9otWwn3TPKf5Vruh9Z103DChrWUUDTCPmb66t0fJaA08J7P
	 lxON2dXm26/6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v10 5/8] ACPI: Centralize acpi_get_cpu_uid()
 declaration in include/linux/acpi.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260401081640.26875-6-fengchengwen@huawei.com>
References: <20260401081640.26875-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:26:26 +0000
Message-Id: <20260813232631.89F001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build breakage when CONFIG_ACPI is disabled due to missing acpi_get=
_cpu_uid() stub.
--

--- Patch [5]: [PATCH RESEND v10 5/8] ACPI: Centralize acpi_get_cpu_uid() d=
eclaration in include/linux/acpi.h ---
commit f99931b839a856d11d22796fd0c23424af139915
Author: Chengwen Feng <fengchengwen@huawei.com>

ACPI: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h

This commit centralizes the acpi_get_cpu_uid() declaration into the global
scope in include/linux/acpi.h and removes the architecture-specific
declarations. This unifies the interface and eliminates duplicate prototype=
s.

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index fbf0c3a65f598..f7e50e9cfb224 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
[ ... ]
> @@ -323,6 +323,17 @@ int acpi_unmap_cpu(int cpu);
> =20
>  acpi_handle acpi_get_processor_handle(int cpu);
> =20
> +/**
> + * acpi_get_cpu_uid() - Get ACPI Processor UID of from MADT table
> + * @cpu: Logical CPU number (0-based)
> + * @uid: Pointer to store ACPI Processor UID
> + *
> + * Return: 0 on success (ACPI Processor ID stored in *uid);
> + *         -EINVAL if CPU number is invalid or out of range;
> + *         -ENODEV if ACPI Processor UID for the CPU is not found.
> + */
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
> +

[Severity: Low]
Does this cause a build failure when CONFIG_ACPI is disabled? The declarati=
on
is added here, but it appears there is no static inline stub provided in the
!CONFIG_ACPI section of the header.

Callers outside of ACPI-specific code seem to use this function
unconditionally. For example, in arch/x86/xen/enlighten_hvm.c within
xen_cpu_up_prepare_hvm():

    if (acpi_get_cpu_uid(cpu, &cpu_uid) =3D=3D 0)

Without a static inline stub returning an error code (like -ENODEV) when
CONFIG_ACPI is not set, does compiling x86 with CONFIG_XEN_PVHVM enabled and
CONFIG_ACPI disabled result in an implicit function declaration and undefin=
ed
reference linker error?

>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>  int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260401081640.2687=
5-1-fengchengwen@huawei.com?part=3D5
