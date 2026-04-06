Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92913859E3
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775487555; cv=none; b=tmyvtVznYUP17Y0lWmzN6pz5JFGiFGPvx9aek30Y5q9YtScXEx/KkYz/Uixqbd4Lcr0p4DXGPZ6XLCXNxX0iA7DcfqF/5iaJfPuTMMt0iWaKYhpLbxrgio5q0kFtNA3hwhRrY/2bsvW8oG2vth+gM4O4uOJWapFej1i7JjD3d6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775487555; c=relaxed/simple;
	bh=xQ7o66TtbbwulQnJW5l2ZtOfYQA79hhGSfn9VhPlO6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWShkTYwuBIUXK4z4M+EX9aiAMNbu57KHoOBaZXU6WkFUp5qYt/suoiw2/WN7+OgY2G8aeZx+zUmDxQ6AunjFCBtD8craXEIzfwXab6DkBy3A3UwuZ3vydbaggng2/f/3i6F31Ae1g7loBzoUe3xWZzCMt1+5YN093QnGWMA6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLkaENd1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLkaENd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE13DC2BCC9
	for <linux-pci@vger.kernel.org>; Mon,  6 Apr 2026 14:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775487555;
	bh=xQ7o66TtbbwulQnJW5l2ZtOfYQA79hhGSfn9VhPlO6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MLkaENd1y02jG6YsphOhuZTp0iQI96L6WFY5DEmo/DZ6WCfvoSBDZJV2ohYZSu1N9
	 ac4WV6CKVr3vtjWO5PyYEkAdXK0hp0G+RobW161z0dcu3s/VU0gY22kCs+MYXqUHBH
	 Liz1EHAuKjE4fTRx4+YsiI+t4vTTDKeLdDI2YZy0dAHG/YzL3nR/Rt8+yoiTCr6Y7R
	 31IDqYUjMqFbupJ1fx/4xFWsQpHeFVPqQZdMM9fWEudaIkvMRtjafaQw7H2b7xvoYg
	 xYFQlwgI/yUaOmD2NLJlqgiOeQ45VmSMD64YK+4sRFnv7nXs5NX2dbzF574dvLBFqO
	 XtniXv49RXROw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-470145d7e6fso691447b6e.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Apr 2026 07:59:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQJOqsMSJoeRxWkA6aPPkP8ptdAOKJXrs0DpMzyKlUMmUPXiBGpg34Qx7roWSCtaePCLqZzJWE+W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysnRgeKeRAnOmvrfh5MJ0giQe5emjKr7qXysvY1zK37WA3wYFd
	TQO2dGuRmeKVYeT4+IGDOTUitarzaXkN0dIMWp11qKHftAIAwnAtQvyojxaow+qIKmtFwtjsadS
	K8vhIp7mBtX6a1ihcV6VXq9a5BKV8f3w=
X-Received: by 2002:a05:6808:1910:b0:468:776:1ead with SMTP id
 5614622812f47-46ef5af739fmr6450744b6e.21.1775487554002; Mon, 06 Apr 2026
 07:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401081640.26875-1-fengchengwen@huawei.com>
In-Reply-To: <20260401081640.26875-1-fengchengwen@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 16:58:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gE9jLbaGy0yJhNZdpQJTR9stE-ABNQVvP5jqss3LQpFw@mail.gmail.com>
X-Gm-Features: AQROBzDy996ma1a9twY_5lJC3Avr9hchzSyUdEAhSG92k1NHCBaaPp2eIIIoft4
Message-ID: <CAJZ5v0gE9jLbaGy0yJhNZdpQJTR9stE-ABNQVvP5jqss3LQpFw@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 0/8] ACPI: Unify CPU UID interface and fix
 ARM64 TPH steer-tag issue
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Kees Cook <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth <thuth@redhat.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin <kevinloughlin@google.com>, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>, 
	"Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	James Clark <james.clark@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Wei Huang <wei.huang2@amd.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	punit.agrawal@oss.qualcomm.com, guohanjun@huawei.com, suzuki.poulose@arm.com, 
	ryan.roberts@arm.com, chenl311@chinatelecom.cn, masahiroy@kernel.org, 
	wangyuquan1236@phytium.com.cn, anshuman.khandual@arm.com, 
	heinrich.schuchardt@canonical.com, Eric.VanTassell@amd.com, 
	wangzhou1@hisilicon.com, wanghuiqiang@huawei.com, liuyonglong@huawei.com, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 10:16=E2=80=AFAM Chengwen Feng <fengchengwen@huawei.=
com> wrote:
>
> This patchset unifies ACPI Processor UID retrieval across
> arm64/loongarch/riscv/x86 via acpi_get_cpu_uid() (with input validation)
> and fixes ARM64 CPU steer-tag retrieval failure in PCI/TPH:
>
> 1-4: Add acpi_get_cpu_uid() for arm64/loongarch/riscv/x86 (update
>      respective users)
> 5: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
> 6: Clean up perf/arm_cspmu
> 7: Clean up ACPI/PPTT and remove unused get_acpi_id_for_cpu()
> 8: Pass ACPI Processor UID to Cache Locality _DSM
>
> The interface refactor ensures consistent CPU UID retrieval across
> architectures (no functional changes for valid inputs) and provides the
> unified interface required for the ARM64 TPH fix
>
> ---
> Changes in v10-resend:
> - Add Catalin's ack-by for arm64 commit
> - Add CC to x86@kernel.org
>
> Changes in v10:
> - Refine commit header&log according to Punit's and Bjorn's review
> - Split perf/arm_cspmu as a separate commit which address Punit's
>   review
>
> Changes in v9:
> - Address Bjorn's review: split commits to each platform so that make
>   them easy to review
>
> Changes in v8:
> - Moving arm64's get_cpu_for_acpi_id() to kernel/acpi.c which address
>   Jeremy's review
>
> Chengwen Feng (8):
>   arm64: acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>   LoongArch: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>   RISC-V: ACPI: Add acpi_get_cpu_uid() for unified ACPI CPU UID
>     retrieval
>   x86/acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>   ACPI: Centralize acpi_get_cpu_uid() declaration in
>     include/linux/acpi.h
>   perf: arm_cspmu: Switch to acpi_get_cpu_uid() from
>     get_acpi_id_for_cpu()
>   ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
>   PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM
>
>  Documentation/PCI/tph.rst          |  4 +--
>  arch/arm64/include/asm/acpi.h      | 17 +---------
>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++
>  arch/loongarch/include/asm/acpi.h  |  5 ---
>  arch/loongarch/kernel/acpi.c       |  9 ++++++
>  arch/riscv/include/asm/acpi.h      |  4 ---
>  arch/riscv/kernel/acpi.c           | 16 ++++++++++
>  arch/riscv/kernel/acpi_numa.c      |  9 ++++--
>  arch/x86/include/asm/cpu.h         |  1 -
>  arch/x86/include/asm/smp.h         |  1 -
>  arch/x86/kernel/acpi/boot.c        | 20 ++++++++++++
>  arch/x86/xen/enlighten_hvm.c       |  5 +--
>  drivers/acpi/pptt.c                | 50 ++++++++++++++++++++++--------
>  drivers/acpi/riscv/rhct.c          |  7 ++++-
>  drivers/pci/tph.c                  | 16 +++++++---
>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
>  include/linux/acpi.h               | 11 +++++++
>  include/linux/pci-tph.h            |  4 +--
>  18 files changed, 158 insertions(+), 57 deletions(-)
>
> --

Applied as 7.1 material, but please note that I haven't tagged it
explicitly for "stable".

The last patch carries a Fixes: tag which should be suitable for
"stable" to pick it up and you may as well request the whole series to
be picked up by "stable" when it hits the mainline.

Thanks!
