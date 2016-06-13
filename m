Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Dongdong Liu <liudongdong3@huawei.com>
To: <helgaas@kernel.org>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>,
	<hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
	<okaya@codeaurora.org>, <jchandra@broadcom.com>, <tn@semihalf.com>
CC: <robert.richter@caviumnetworks.com>, <mw@semihalf.com>,
	<Liviu.Dudau@arm.com>, <ddaney@caviumnetworks.com>,
	<wangyijing@huawei.com>, <Suravee.Suthikulpanit@amd.com>,
	<msalter@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jcm@redhat.com>,
	<andrea.gallo@linaro.org>, <dhdang@apm.com>,
	<jeremy.linton@arm.com>, <liudongdong3@huawei.com>,
	<cov@codeaurora.org>, <gabriele.paoloni@huawei.com>,
	<charles.chenxin@huawei.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH V2 0/2] ECAM quirks handling for ARM64 platforms
Date: Mon, 13 Jun 2016 21:02:01 +0800
Message-ID: <1465822923-33599-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series bases on pending ACPI PCI support for ARM64:
https://lkml.org/lkml/2016/6/10/706

Quirk handling relies on an idea of matching MCFG OEM ID and OEM TABLE ID
(the ones from standard header of MCFG table). Linker section is used
so that quirks can be registered using special macro (see patches) and
kept self contained.

v1 -> v2
- use oem_id and oem_table_id to replace oem_id and oem_revision to make 
  a difference between different platforms.
- change pci_cfg_fixup __mcfg_fixup_##system##dom##bus to
  __mcfg_fixup_##oem_id##oem_table_id##dom##bus. With oem_id and oem_table_id
  is to ensure that the object is unique.

Tomasz Nowicki (2):
  ACPI/PCI: Match PCI config space accessors against platfrom specific
    ECAM quirks
  ARM64/PCI: Start using quirks handling for ACPI based PCI host
    controller

 arch/arm64/kernel/pci.c           |  7 ++++---
 drivers/acpi/pci_mcfg.c           | 41 ++++++++++++++++++++++++++++++++++++---
 include/asm-generic/vmlinux.lds.h |  7 +++++++
 include/linux/pci-acpi.h          | 20 +++++++++++++++++++
 4 files changed, 69 insertions(+), 6 deletions(-)

-- 
1.9.1

