Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v2 04/10] PCI, frv: clip firmware assigned resource under parent bridge's
Date: Wed, 14 Jan 2015 20:31:31 -0800
Message-Id: <1421296297-6371-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
References: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some bios put range that is not fully coverred by root bus resources.
Try to clip them and update them in pci bridge bars.

We'd like to fix other arches instead of just x86.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
Reported-by: Marek Kordik <kordikmarek@gmail.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/frv/mb93090-mb00/pci-frv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
index 67b1d16..9e49c3e 100644
--- a/arch/frv/mb93090-mb00/pci-frv.c
+++ b/arch/frv/mb93090-mb00/pci-frv.c
@@ -94,7 +94,7 @@ static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
 				r = &dev->resource[idx];
 				if (!r->start)
 					continue;
-				pci_claim_resource(dev, idx);
+				pci_claim_bridge_resource(dev, idx)
 			}
 		}
 		pcibios_allocate_bus_resources(&bus->children);
-- 
1.8.4.5

