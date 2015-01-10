Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	linux-am33-list@redhat.com
Subject: [PATCH 03/16] mn10300: add struct pci_ops member names to initialization
Date: Fri,  9 Jan 2015 20:34:37 -0600
Message-Id: <1420857290-8373-4-git-send-email-robh@kernel.org>
In-Reply-To: <1420857290-8373-1-git-send-email-robh@kernel.org>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some instances of pci_ops initialization rely on the read/write members'
location in the struct. This is fragile and may break when adding new
members to the beginning of the struct.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Cc: linux-am33-list@redhat.com
---
 arch/mn10300/unit-asb2305/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mn10300/unit-asb2305/pci.c b/arch/mn10300/unit-asb2305/pci.c
index 6b4339f..406cbe0 100644
--- a/arch/mn10300/unit-asb2305/pci.c
+++ b/arch/mn10300/unit-asb2305/pci.c
@@ -228,8 +228,8 @@ static int pci_ampci_write_config(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops pci_direct_ampci = {
-	pci_ampci_read_config,
-	pci_ampci_write_config,
+	.read = pci_ampci_read_config,
+	.write = pci_ampci_write_config,
 };
 
 /*
-- 
2.1.0

