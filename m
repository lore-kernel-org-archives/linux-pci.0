Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 01/11] PCI: Should add children device res to fail list
Date: Tue, 22 May 2012 23:34:27 -0700
Message-Id: <1337754877-19759-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1337754877-19759-1-git-send-email-yinghai@kernel.org>
References: <1337754877-19759-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can stop according to try number now. So do need that as stop sign.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 192172c..64d478f 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -283,7 +283,7 @@ static void assign_requested_resources_sorted(struct list_head *head,
 		idx = res - &dev_res->dev->resource[0];
 		if (resource_size(res) &&
 		    pci_assign_resource(dev_res->dev, idx)) {
-			if (fail_head && !pci_is_root_bus(dev_res->dev->bus)) {
+			if (fail_head) {
 				/*
 				 * if the failed res is for ROM BAR, and it will
 				 * be enabled later, don't add it to the list
-- 
1.7.7

