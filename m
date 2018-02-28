Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:35123 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeB1GfR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 01:35:17 -0500
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Benedikt Spranger <b.spranger@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Otavio Pontes <otavio.pontes@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/6] jailhouse: Enhance secondary Jailhouse guest support /wrt PCI
Date: Wed, 28 Feb 2018 07:34:45 +0100
Message-Id: <cover.1519799691.git.jan.kiszka@siemens.com>
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

Changes in v2:
 - adjusted commit log and include ordering in patch 2
 - rebased over Linus master

Jan

[1] https://lkml.org/lkml/2017/11/27/125
[2] http://jailhouse-project.org

CC: Benedikt Spranger <b.spranger@linutronix.de>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Otavio Pontes <otavio.pontes@intel.com>
CC: Rob Herring <robh+dt@kernel.org>

Jan Kiszka (5):
  jailhouse: Provide detection for non-x86 systems
  PCI: Scan all functions when running over Jailhouse
  x86: Consolidate PCI_MMCONFIG configs
  x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
  MAINTAINERS: Add entry for Jailhouse

Otavio Pontes (1):
  x86/jailhouse: Enable PCI mmconfig access in inmates

 Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
 MAINTAINERS                                     |  7 +++++++
 arch/x86/Kconfig                                | 11 ++++++-----
 arch/x86/include/asm/jailhouse_para.h           |  2 +-
 arch/x86/include/asm/pci_x86.h                  |  2 ++
 arch/x86/kernel/Makefile                        |  2 +-
 arch/x86/kernel/cpu/amd.c                       |  2 +-
 arch/x86/kernel/jailhouse.c                     |  7 +++++++
 arch/x86/pci/legacy.c                           |  4 +++-
 arch/x86/pci/mmconfig-shared.c                  |  4 ++--
 drivers/pci/probe.c                             |  4 +++-
 include/linux/hypervisor.h                      | 17 +++++++++++++++--
 12 files changed, 56 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jailhouse.txt

-- 
2.13.6
