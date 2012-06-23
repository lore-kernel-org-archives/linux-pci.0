Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:30785 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab2FWHmI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Jun 2012 03:42:08 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 5/5] PCI: add root bus children dev's res to fail list
Date: Sat, 23 Jun 2012 00:42:05 -0700
Message-Id: <1340437325-29282-6-git-send-email-yinghai@kernel.org>
In-Reply-To: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can stop according to try number now and do not need to use root_bus checking
as stop sign anymore.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 561e41c..bb02b25 100644
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

