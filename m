Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7932F740;
	Wed,  1 Apr 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031773; cv=none; b=Wt49u9NKds2+Iz/JQSkErXvo9Bg/urV4dR9jnlIdSP75R1mFyx3SlXgYsHs1vRi09JNHPI3yr8bPoVQgNTZ3CZDYolfRT1hVsiKp1eL18TTTgGkeVIdQWXqUplIuSDkqvARYfMyxQxINqupmAH5IP6TzLQUSIvL+MRCjsqCSowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031773; c=relaxed/simple;
	bh=OM/5KN+8jtiSBVhOTr2FyDR++jU2kqIl3x0xZYpcebs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t4TFOyvzz1M73P1sIVlPoRs2Jp+1WoRxul/pZpLFFdvUb9kr3kzjzeHlmHJ+zwq2cuL1rbM0oNiWJWHD2clvB49rjh54EmentLry6jzAJ0QzVJ7SEspfS15BsTu3ZTh+kV7r8vjmhpLv3urfzQr7AkYTSGvWNvmGigzy1/NRnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zfVqdZWZ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zfVqdZWZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MTNaVMsdonTBgQUg0Ejtg6uI8JOpWHbQuBn8i2Muytk=;
	b=zfVqdZWZzivpJLTuZeEYbETVgUbpjxcc6vmJiz9VmBmGK7+p3ocbi7KhRl4SW1imGIWS+H+/S
	GEL7RNT6jhEzLuaPxUUhmMIjHBiCm2o5aipjEt5QgHPSsV8YAFhEn4y9speX8o0Hs3CLk5Jp28M
	LXlEaI+zkFwl4t8bQIqGT9w=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4flyW63nb4z1K9VW;
	Wed,  1 Apr 2026 16:16:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 071664056C;
	Wed,  1 Apr 2026 16:22:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 1 Apr 2026 16:22:40 +0800
Message-ID: <504b43e1-fa7d-4694-b8af-fe4975823db3@huawei.com>
Date: Wed, 1 Apr 2026 16:22:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] ACPI: Unify CPU UID interface and fix ARM64 TPH
 steer-tag issue
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Palmer Dabbelt <palmer@dabbelt.com>, Borislav Petkov
	<bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Juergen Gross
	<jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Sunil V L
	<sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
	<wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <punit.agrawal@oss.qualcomm.com>,
	<guohanjun@huawei.com>, <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
	<chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
	<wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
	<heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260320031737.35048-1-fengchengwen@huawei.com>
 <CAJZ5v0gO1VSPs58JeupaiTZBkP3i_-H2bEQpfU-6k2TXjdiaOQ@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAJZ5v0gO1VSPs58JeupaiTZBkP3i_-H2bEQpfU-6k2TXjdiaOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 3/31/2026 8:24 PM, Rafael J. Wysocki wrote:
> On Fri, Mar 20, 2026 at 4:17 AM Chengwen Feng <fengchengwen@huawei.com> wrote:
>>
>> This patchset unifies ACPI Processor UID retrieval across
>> arm64/loongarch/riscv/x86 via acpi_get_cpu_uid() (with input validation)
>> and fixes ARM64 CPU steer-tag retrieval failure in PCI/TPH:
>>
>> 1-4: Add acpi_get_cpu_uid() for arm64/loongarch/riscv/x86 (update
>>      respective users)
>> 5: Centralize acpi_get_cpu_uid() declaration in include/linux/acpi.h
>> 6: Clean up perf/arm_cspmu
>> 7: Clean up ACPI/PPTT and remove unused get_acpi_id_for_cpu()
>> 8: Pass ACPI Processor UID to Cache Locality _DSM
>>
>> The interface refactor ensures consistent CPU UID retrieval across
>> architectures (no functional changes for valid inputs) and provides the
>> unified interface required for the ARM64 TPH fix.
>>
>> ---
>> Changes in v10:
>> - Refine commit header&log according to Punit's and Bjorn's review
>> - Split perf/arm_cspmu as a separate commit which address Punit's
>>   review
>>
>> Changes in v9:
>> - Address Bjorn's review: split commits to each platform so that make
>>   them easy to review
>>
>> Changes in v8:
>> - Moving arm64's get_cpu_for_acpi_id() to kernel/acpi.c which address
>>   Jeremy's review
>>
>> Chengwen Feng (8):
>>   arm64: acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>>   LoongArch: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>>   RISC-V: ACPI: Add acpi_get_cpu_uid() for unified ACPI CPU UID
>>     retrieval
>>   x86/acpi: Add acpi_get_cpu_uid() for unified ACPI CPU UID retrieval
>>   ACPI: Centralize acpi_get_cpu_uid() declaration in
>>     include/linux/acpi.h
>>   perf: arm_cspmu: Switch to acpi_get_cpu_uid() from
>>     get_acpi_id_for_cpu()
>>   ACPI: PPTT: Use acpi_get_cpu_uid() and remove get_acpi_id_for_cpu()
>>   PCI/TPH: Pass ACPI Processor UID to Cache Locality _DSM
>>
>>  Documentation/PCI/tph.rst          |  4 +--
>>  arch/arm64/include/asm/acpi.h      | 17 +---------
>>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++
>>  arch/loongarch/include/asm/acpi.h  |  5 ---
>>  arch/loongarch/kernel/acpi.c       |  9 ++++++
>>  arch/riscv/include/asm/acpi.h      |  4 ---
>>  arch/riscv/kernel/acpi.c           | 16 ++++++++++
>>  arch/riscv/kernel/acpi_numa.c      |  9 ++++--
>>  arch/x86/include/asm/cpu.h         |  1 -
>>  arch/x86/include/asm/smp.h         |  1 -
>>  arch/x86/kernel/acpi/boot.c        | 20 ++++++++++++
>>  arch/x86/xen/enlighten_hvm.c       |  5 +--
>>  drivers/acpi/pptt.c                | 50 ++++++++++++++++++++++--------
>>  drivers/acpi/riscv/rhct.c          |  7 ++++-
>>  drivers/pci/tph.c                  | 16 +++++++---
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
>>  include/linux/acpi.h               | 11 +++++++
>>  include/linux/pci-tph.h            |  4 +--
>>  18 files changed, 158 insertions(+), 57 deletions(-)
>>
>> --
> 
> It doesn't look like anyone has a particular heartburn related to this
> series, so I could apply it in principle, but I'd appreciate some ACKs
> from arch maintainers.
> 
> Why don't you resend it with all of the tags collected so far (and
> please add x86@kernel.org to the CC list)?

done for resend v10 which with all the review/ack tag, add add x86@kernel.org to CC list

Thanks
