Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH 0/2] pci: endpoint: Fix double free in pci_epf_create()
Date: Wed, 21 Feb 2018 13:47:05 +0100
Message-Id: <20180221124707.26308-1-embedded24@evers-fischer.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When I accidentally created a new endpoint device with an empty name,
the kernel warned about "attempted to be registered with empty name!"
and crashed afterwards.

It turned out that the crash was not caused by the 'device_add()'
function itself, but by a double kfree of 'epf->name' and 'epf'.

The first patch just simplifies the code, while the second patch
fixes the problem.

Rolf Evers-Fischer (2):
  pci: endpoint: Free func_name after last usage
  pci: endpoint: Fix kernel panic after put_device()

 drivers/pci/endpoint/pci-epf-core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.16.2
