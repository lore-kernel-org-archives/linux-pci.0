Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/21] PCI: Remove secondary/subordinate in struct ci_bus
Date: Mon,  7 May 2012 13:29:48 -0700
Message-Id: <1336422606-4244-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It is not used anymore, so remove the duplicated secondary/subordinate.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 include/linux/pci.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2b91da0..d588ef4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -427,8 +427,6 @@ struct pci_bus {
 
 	unsigned char	number;		/* bus number */
 	unsigned char	primary;	/* number of primary bridge */
-	unsigned char	secondary;	/* number of secondary bridge */
-	unsigned char	subordinate;	/* max number of subordinate buses */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
 
-- 
1.7.7

