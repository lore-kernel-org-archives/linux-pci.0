Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36021 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbDCPVF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 11:21:05 -0400
Received: by qcgx3 with SMTP id x3so91108928qcg.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2015 08:21:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <551E825F.9060304@linaro.org>
References: <1426083169-8698-1-git-send-email-tomasz.nowicki@linaro.org> <551E825F.9060304@linaro.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 3 Apr 2015 10:20:44 -0500
Message-ID: <CAErSpo6DVe1U701M5Nqkd_HHPtK54f5odoqsKQ0aSdD4hUtYsA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI: MMCONFIG clean up
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Yijing Wang <wangyijing@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Al Stone <al.stone@linaro.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linaro-acpi@lists.linaro.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 3, 2015 at 7:06 AM, Tomasz Nowicki
<tomasz.nowicki@linaro.org> wrote:
> Hi Bjorn,
>
> Any comments before I post next version ?

Nope.  I've been on vacation for a week and am just trying to catch
up.  Haven't had time to do any more than build-test your v4 series.

Bjorn

> On 11.03.2015 15:12, Tomasz Nowicki wrote:
>>
>> MCFG ACPI table and PCI ECAM standard have no arch dependencies so it can
>> be
>> used across all architectures. Currently MMCONFIG related code resides in
>> arch/x86 directories. This patch set is going to isolate non-architecture
>> specific code and make it accessible for all architectures.
>>
>> v3 -> v4 changes:
>> - bug fixes after kbuild test robot report
>>      - add asm/io.h header for ecam.c
>>      - rename mmcfg -> ecam for drivers/xen/pci.c and
>> arch/x86/pci/numachip.c
>> - rework Kconfig logic
>>
>> v2 -> v3 changes:
>> - rebase patch set v2 to v4.0-rc1
>>
>> v1 -> v2 changes:
>> - use generic readb/readw etc. accessors instead of AMD Fam10h workaround
>> - separate ACPI and ECAM code
>> - improve ECAM code naming
>>
>> Tomasz Nowicki (9):
>>    x86, pci: Clean up comment about buggy MMIO config space access for
>>      AMD Fam10h CPUs.
>>    x86, pci: Abstract PCI config accessors and use AMD Fam10h workaround
>>      exclusively.
>>    x86, pci: Reorder logic of pci_mmconfig_insert() function
>>    x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
>>      out of arch/x86/ directory
>>    pci, acpi, mcfg: Provide generic implementation of MCFG code
>>      initialization.
>>    x86, pci: mmconfig_{32,64}.c code refactoring - remove code
>>      duplication.
>>    x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
>>      driver.
>>    pci, acpi, mcfg: Share ACPI PCI config space accessors.
>>    pci, ecam: Improve naming for ecam.c content and areas where it is
>>      used.
>>
>>   arch/x86/Kconfig               |   4 +
>>   arch/x86/include/asm/pci_x86.h |  34 +---
>>   arch/x86/pci/Makefile          |   5 +-
>>   arch/x86/pci/acpi.c            |   3 +-
>>   arch/x86/pci/mmconfig-shared.c | 346
>> +++++++++++----------------------------
>>   arch/x86/pci/mmconfig_32.c     |  47 ++----
>>   arch/x86/pci/mmconfig_64.c     | 153 ------------------
>>   arch/x86/pci/numachip.c        |  29 +---
>>   drivers/acpi/Makefile          |   1 +
>>   drivers/acpi/mcfg.c            | 121 ++++++++++++++
>>   drivers/pci/Kconfig            |  10 ++
>>   drivers/pci/Makefile           |   5 +
>>   drivers/pci/ecam.c             | 358
>> +++++++++++++++++++++++++++++++++++++++++
>>   drivers/xen/pci.c              |   7 +-
>>   include/linux/ecam.h           |  56 +++++++
>>   15 files changed, 679 insertions(+), 500 deletions(-)
>>   delete mode 100644 arch/x86/pci/mmconfig_64.c
>>   create mode 100644 drivers/acpi/mcfg.c
>>   create mode 100644 drivers/pci/ecam.c
>>   create mode 100644 include/linux/ecam.h
>>
>
