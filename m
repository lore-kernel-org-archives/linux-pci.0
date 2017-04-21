Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425132AbdDUTba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Apr 2017 15:31:30 -0400
Subject: [PATCH 0/9] lspci: AER, PCIe capability updates
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org,
        Jayachandran C <jnair@caviumnetworks.com>
Date: Fri, 21 Apr 2017 14:31:26 -0500
Message-ID: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Martin,

These are some updates to decode more AER registers, decode "Slot
Implemented" for reverse bridges, and drop ASPM exit latencies for
unsupported states.  And a few more cosmetic whitespace, spelling, etc.,
fixes.

These are based on 3.5.4 (9f9e373b17f1).

---

Bjorn Helgaas (9):
      lspci: Decode AER Multiple Header and TLP Prefix Log bits
      lspci: Dump AER Header Log
      lspci: Decode AER Root Error Command, Root Error Status, Error Source
      lspci: Include "ECRC" in the ECRC generate/check labels
      lspci: Indent PCIe Capability DevCap2 & DevCtl2 correctly
      lspci: Decode "Slot Implemented" for PCI/PCI-X to PCIe Bridges
      lspci: Decode only supported ASPM exit latencies
      lspci: Use #defines for greppability
      lspci: Fix "Auxiliary" spelling error


 lib/header.h                 |   21 +
 lib/pci.h                    |    2 
 ls-caps.c                    |   63 +++-
 ls-ecaps.c                   |   53 +++-
 lspci.h                      |    2 
 tests/cap-aer-ecrc-label     |  327 ++++++++++++++++++++++
 tests/cap-aer-hdr            |  322 ++++++++++++++++++++++
 tests/cap-aer-log            |  323 ++++++++++++++++++++++
 tests/cap-aer-root           |  626 ++++++++++++++++++++++++++++++++++++++++++
 tests/cap-exp-aspm-latencies |  327 ++++++++++++++++++++++
 tests/cap-exp-dev2           |  327 ++++++++++++++++++++++
 tests/cap-exp-rev-slot       |  288 +++++++++++++++++++
 12 files changed, 2644 insertions(+), 37 deletions(-)
 create mode 100644 tests/cap-aer-ecrc-label
 create mode 100644 tests/cap-aer-hdr
 create mode 100644 tests/cap-aer-log
 create mode 100644 tests/cap-aer-root
 create mode 100644 tests/cap-exp-aspm-latencies
 create mode 100644 tests/cap-exp-dev2
 create mode 100644 tests/cap-exp-rev-slot
