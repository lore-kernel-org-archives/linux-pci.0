Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175B019CCFC;
	Mon,  9 Mar 2026 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029837; cv=none; b=VPDU35DmugGUOe5Q15ls/Z2NcGAcF1eUWdjU7CUdCzsaKKAOXL8D4Y6I3u7MFeEMKDNR/ywP2CMBe1AwA1QCiINl0+Xk9UIc73MZronimUo0iQO90OmnYBr9nfSRI+xnuBPu+amSfl7AJvSRvjMzTD3XLq27GaXJuoLtEFZvGVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029837; c=relaxed/simple;
	bh=SIDkl90WZTmlDYk+psd8PeVOHu2uQ6QXyTJ65iI60Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkPUTP2hMxIWAS+N/3pUZNfhnWwp4ogtQ7Zs9xnHYzZ1T5YUEXyWiqWXMp1+FmMQvyTkjE/E6FBHpnXR0hOrsegyVsjl23Qf+owo2Zdfn/wBbbVKwOmaIdOd3BIc7OjpNbVqjOWnGIoUwerGByWKslwcVNdwWmSWmSlDXi2szRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kmGTZOZ+; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kmGTZOZ+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zb0eE+ABbIztFz17I9xJEIXO/NgQFVL9CzG3OvGn4TQ=;
	b=kmGTZOZ+f4KHMGUbkvEcncnAlAymW/Z07WbkXN8FvRpuLaTyuRb2nSEhH/M04VIb9sA7nUtY5
	v0MubPK9yw+wKfb35tNjKakWZ+5aCu2BIzvHOhr0JQnAV7vlPJjTTPGrgC+yn43FQj6V07z6Eo3
	7B+YZFGra9na5nZCkNbtBlM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fTk9T2xKTz1T4Fc;
	Mon,  9 Mar 2026 12:11:57 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B732140561;
	Mon,  9 Mar 2026 12:17:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 12:17:04 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
CC: <linux-acpi@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<wei.huang2@amd.com>, <Eric.VanTassell@amd.com>,
	<jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@ventanamicro.com>, <sunilvl@oss.qualcomm.com>,
	<chenhuacai@loongson.cn>, <wangliupu@loongson.cn>, Chengwen Feng
	<fengchengwen@huawei.com>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 0/2] Fix get cpu steer-tag fail on ARM64 platform
Date: Mon, 9 Mar 2026 12:16:56 +0800
Message-ID: <20260309041659.18815-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260303003625.39035-1-fengchengwen@huawei.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

This patchset addresses the issue where retrieving the CPU steer-tag
fails on ARM64 platforms. The first commit is a pure renaming of the
ACPI CPU ID retrieval interface (no functional changes), which serves
as preparation for the second commit that implements the core fix for
the steer-tag retrieval logic.

---
Changes in v4:
- Split the rename into a separate commit.

Changes in v3:
- Rename existing get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() other
  than add one new API.

Changes in v2:
- Add ECN _DSM reference doc name and its URL.
- Separate implement acpi_get_cpu_acpi_id() in each arch which supports
  ACPI.
- Refine commit-log.

Chengwen Feng (2):
  ACPI: Rename get_acpi_id_for_cpu() to acpi_get_cpu_acpi_id() on
    non-x86
  PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform

 Documentation/PCI/tph.rst          |  4 ++--
 arch/arm64/include/asm/acpi.h      |  4 ++--
 arch/loongarch/include/asm/acpi.h  |  2 +-
 arch/riscv/include/asm/acpi.h      |  2 +-
 arch/riscv/kernel/acpi_numa.c      |  2 +-
 arch/x86/include/asm/acpi.h        |  2 ++
 arch/x86/kernel/cpu/common.c       |  8 ++++++++
 drivers/acpi/pptt.c                | 16 ++++++++--------
 drivers/acpi/riscv/rhct.c          |  2 +-
 drivers/pci/tph.c                  | 11 ++++++-----
 drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
 include/linux/pci-tph.h            |  4 ++--
 12 files changed, 35 insertions(+), 24 deletions(-)

-- 
2.17.1

