Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:49659 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeCGHjs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 02:39:48 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Otavio Pontes <otavio.pontes@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 0/7] jailhouse: Enhance secondary Jailhouse guest support /wrt PCI
Date: Wed,  7 Mar 2018 08:39:11 +0100
Message-Id: <cover.1520408357.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Basic x86 support [1] for running Linux as secondary Jailhouse [2] guest
is currently pending in the tip tree. This builds on top and enhances
the PCI support for x86 and also ARM guests (ARM[64] does not require
platform patches and works already).

Key elements of this series are:
 - detection of Jailhouse via device tree hypervisor node
 - function-level PCI scan if Jailhouse is detected
 - MMCONFIG support for x86 guests

As most changes affect x86, I would suggest to route the series also via
tip after the necessary acks are collected.

Changes in v5:
 - fix build breakage of patch 6 on i386

Changes in v4:
 - slit up Kconfig changes
 - respect pcibios_last_bus during mmconfig setup
 - cosmetic changes requested by Andy

Changes in v3:
 - avoided duplicate scans of PCI functions under Jailhouse
 - reformated PCI_MMCONFIG condition and rephrase related commit log

Changes in v2:
 - adjusted commit log and include ordering in patch 2
 - rebased over Linus master

Jan

[1] https://lkml.org/lkml/2017/11/27/125
[2] http://jailhouse-project.org

CC: Benedikt Spranger <b.spranger@linutronix.de>
CC: Juergen Gross <jgross@suse.com>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Otavio Pontes <otavio.pontes@intel.com>
CC: Rob Herring <robh+dt@kernel.org>

Jan Kiszka (6):
  jailhouse: Provide detection for non-x86 systems
  PCI: Scan all functions when running over Jailhouse
  x86: Align x86_64 PCI_MMCONFIG with 32-bit variant
  x86: Consolidate PCI_MMCONFIG configs
  x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
  MAINTAINERS: Add entry for Jailhouse

Otavio Pontes (1):
  x86/jailhouse: Enable PCI mmconfig access in inmates

 Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
 MAINTAINERS                                     |  7 +++++++
 arch/x86/Kconfig                                | 12 +++++++-----
 arch/x86/include/asm/jailhouse_para.h           |  2 +-
 arch/x86/include/asm/pci_x86.h                  |  2 ++
 arch/x86/kernel/Makefile                        |  2 +-
 arch/x86/kernel/cpu/amd.c                       |  2 +-
 arch/x86/kernel/jailhouse.c                     |  8 ++++++++
 arch/x86/pci/legacy.c                           |  4 +++-
 arch/x86/pci/mmconfig-shared.c                  |  4 ++--
 drivers/pci/probe.c                             | 22 +++++++++++++++++++---
 include/linux/hypervisor.h                      | 17 +++++++++++++++--
 12 files changed, 74 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jailhouse.txt

-- 
2.13.6
