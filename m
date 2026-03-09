Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65491364056;
	Mon,  9 Mar 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053989; cv=none; b=rFFGz/KpnsviMWY7nTqGosATO5/uxZMil4vYdei5fAVr507Hk7x2g+oYeoJvsKE+isQYr09tQ21xuWcoBzplNbMJWS8g2G1LGd4erIB9VOEpISDHHhf3pnksud4YVJRYrIQ8eEix2/1M2mJRlaFBaX5B4FX3YNbDqObWMzGcGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053989; c=relaxed/simple;
	bh=mU3WuS90d/NXHU6qT4OYOGJxAioyi0NsU/d4pUdpfrI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCjIhrqVaZ6Bwmn5BvArIlycy7INy85x+Eqb5DLlaHIJ14MWpBfJFqlEArbvXJKIQXFx0SLf/OZnuzpRoi7jTh++71bSHRV/zDH+LCceMvjOLUm4WmcqWNDUFx1LNw9TToxEdyhmQF7JUFwgsAjyV4iEBsor28fNEt0sD26tpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTvC75nN2zJ46p5;
	Mon,  9 Mar 2026 18:58:59 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 97A1940086;
	Mon,  9 Mar 2026 18:59:42 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 10:59:41 +0000
Date: Mon, 9 Mar 2026 10:59:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>, "Eric Van Tassell" <Eric.VanTassell@amd.com>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] PCI/TPH: Fix get cpu steer-tag fail on ARM64
 platform
Message-ID: <20260309105939.0000142b@huawei.com>
In-Reply-To: <20260309041659.18815-3-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
	<20260309041659.18815-1-fengchengwen@huawei.com>
	<20260309041659.18815-3-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 9 Mar 2026 12:16:58 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Currently the pcie_tph_get_cpu_st() has an issue on ARM64 platform:
> 1. The pcie_tph_get_cpu_st() function directly uses cpu_uid as the input
>    parameter to call the PCI ACPI DSM method. According to the DSM
>    definition, the input value should be the ACPI Processor UID (see [1]
>    for details).
> 2. In the Broadcom driver implementation [2] (which invokes
>    pcie_tph_get_cpu_st()), cpu_uid is obtained via
>    cpumask_first(irq->cpu_mask) - this is the logical CPU ID of a CPU
>    core, generated and managed by kernel (e.g., [0,255] for a system
>    with 256 logical CPU cores).
> 3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
>    MADT table, and this UID may not match the kernel's logical CPU ID.
>    As a result, the current implementation fails to retrieve the correct
>    CPU steer-tag in such cases.
> 4. The function works on AMD x86 platforms only because the logical CPU
>    ID is identical to the ACPI Processor UID on those systems.
> 
> This commit fixes it by:
> 1. Add new acpi_get_cpu_acpi_id() implementation on x86 that wraps
>    cpu_acpi_id(), completing the unified ACPI CPU ID retrieval interface
>    across ACPI-enabled platforms.
> 2. Update pcie_tph_get_cpu_st() to use acpi_get_cpu_acpi_id(cpu) to get
>    valid ACPI Processor UID for DSM calls.
> 3. Renaming pcie_tph_get_cpu_st()'s input parameter cpu_uid to cpu for
>    clarity, as the parameter now represents a logical CPU ID (not a
>    UID).
> 
> [1] According to ECN_TPH-ST_Revision_20200924
>     (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
>     is defined as: "If the target is a processor, then this field
>     represents the ACPI Processor UID of the processor as specified in
>     the MADT. If the target is a processor container, then this field
>     represents the ACPI Processor UID of the processor container as
>     specified in the PPTT."
> [2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")
> 
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

If you do respin, might be worth some minor edits to the patch description
just to make it more concise.  If not, I'm fine with current text, just takes
a bit more reading than strictly necessary :)

"
pcie_tph_get_cpu_st() is broken on ARM64:
1. pcie_tph_get_cpu_st() passes cpu_uid to the PCI ACPI DSM method.
   cpu_uid should be the ACPI Processor UID [1].
2. In BNXT, pcie_tph_get_cpu_st() is passed a cpu_uid obtained via
   cpumask_first(irq->cpu_mask) - the logical CPU ID of a CPU core,
   generated and managed by kernel (e.g., [0,255] for a system  with 256
   logical CPU cores).
3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
   MADT table, and this UID may not match the kernel's logical CPU ID.
   When this occurs, the mismatch results in the wrong CPU steer-tag.
4. On AMD x86 the logical CPU ID is identical to the ACPI Processor UID
   so the mismatch is not seen.

Resolution:
1. Implement acpi_get_cpu_acpi_id() for x86, wrapping cpu_acpi_id().
   All ACPI platforms now have an implementation.
2. Use acpi_get_cpu_acpi_id() in pcie_tph_get_cpu_st() to translate from
   logical CPU ID to ACPI Processor UID needed for the DSM call.
3. Rename pcie_tpu_get_cpu_st() parameter from cpu_uid to cpu to
   reflect that it is a logical CPU_ID.
"


The references are fine as is.

Thanks,

Jonathan


> This commit fixes it by:
> 1. Add new acpi_get_cpu_acpi_id() implementation on x86 that wraps
>    cpu_acpi_id(), completing the unified ACPI CPU ID retrieval interface
>    across ACPI-enabled platforms.
> 2. Update pcie_tph_get_cpu_st() to use acpi_get_cpu_acpi_id(cpu) to get
>    valid ACPI Processor UID for DSM calls.
> 3. Renaming pcie_tph_get_cpu_st()'s input parameter cpu_uid to cpu for
>    clarity, as the parameter now represents a logical CPU ID (not a
>    UID).
> 
> [1] According to ECN_TPH-ST_Revision_20200924
>     (https://members.pcisig.com/wg/PCI-SIG/document/15470), the input
>     is defined as: "If the target is a processor, then this field
>     represents the ACPI Processor UID of the processor as specified in
>     the MADT. If the target is a processor container, then this field
>     represents the ACPI Processor UID of the processor container as
>     specified in the PPTT."
> [2] commit c214410c47d6e ("bnxt_en: Add TPH support in BNXT driver")

