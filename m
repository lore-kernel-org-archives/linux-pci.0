Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Turquette <mturquette@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Michael Turquette <mturquette@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] pci: xgene: do not use clk-private.h
Date: Fri, 30 Jan 2015 13:25:12 -0800
Message-Id: <1422653113-32688-3-git-send-email-mturquette@linaro.org>
In-Reply-To: <1422653113-32688-1-git-send-email-mturquette@linaro.org>
References: <1422653113-32688-1-git-send-email-mturquette@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The X-Gene PCIe driver consumes clocks and does not provide them.
Replace usage of clk-private.h with clk.h.

Cc: Tanmay Inamdar <tinamdar@apm.com>
Signed-off-by: Michael Turquette <mturquette@linaro.org>
---
Cc: linux-pci@vger.kernel.org
 drivers/pci/host/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index b1d0596..fdb348d 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -16,7 +16,7 @@
  * GNU General Public License for more details.
  *
  */
-#include <linux/clk-private.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
-- 
1.9.1

