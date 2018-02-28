Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH v4 0/3] pci: endpoint: Fix double free in pci_epf_create()
Date: Wed, 28 Feb 2018 14:07:16 +0100
Message-Id: <20180228130719.31218-1-embedded24@evers-fischer.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is version 4 of a patchset to avoid double free in function
'pci_epf_create()'.

When I accidentally created a new endpoint device with an empty name,
the kernel warned about "attempted to be registered with empty name!"
and crashed afterwards.

It turned out that the crash was not caused by the 'device_add()'
function itself, but by a double kfree of 'epf->name' and 'epf'.

The first patch just simplifies the code, while the second patch
fixes the problem. The third patch removes the goto labels.

Thank you Andy and Kishon for your Ack/Review on v3 for patches 1 and 2.
In v4 of these patches only the first lines of the commit messages
have been changed.

Changes in v4:
- s/pci/PCI and s/epf/EPF in the first line of
  recent commit messages (thanks, Bjorn!)
- The new patch #3 removes the goto labels
  in function 'pci_epf_create()' (thanks, Lorenzo!)

Changes in v3:
- Matched to other pending pci endpoint commits (thanks, Bjorn!)
- Added "Fixes" tag in patch 2 (thanks, Andy!)

Changes in v2:
- Based on feedback from Lorenzo, Andy and Kishon (thanks!)
- Change IDs removed
- First patch completely reworked in order to eliminate the
  need for the second 'kstrdup' allocation and the 'kfree' of
  the first allocation.
  It was tested with name="pci_epf_test.0" and name="pci_epb":
  The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).

Rolf Evers-Fischer (3):
  PCI: endpoint: Simplify name allocation for EPF device
  PCI: endpoint: Fix kernel panic after put_device()
  PCI: endpoint: pci_epf_create: remove goto labels

 drivers/pci/endpoint/pci-epf-core.c | 50 +++++++++----------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

-- 
2.16.2
