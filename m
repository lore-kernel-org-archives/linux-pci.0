Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH v3 31/32] lib: fix Devres devm_ioremap_* offset parameter
 kerneldoc description
Date: Tue, 11 Apr 2017 13:29:11 +0100
Message-Id: <20170411122923.6285-32-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The offset parameter in Devres devm_ioremap_* functions kerneldoc
entries is erroneously defined as BUS offset whereas it is actually
a resource address.

Since it is actually misleading, fix the Devres devm_ioremap_* offset
parameter kerneldoc entry by replacing BUS offset with a more
suitable description (ie Resource address).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tejun Heo <tj@kernel.org>
---
 lib/devres.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index cb1464c..78eca71 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -17,7 +17,7 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
 /**
  * devm_ioremap - Managed ioremap()
  * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
+ * @offset: Resource address to map
  * @size: Size of map
  *
  * Managed ioremap().  Map is automatically unmapped on driver detach.
@@ -45,7 +45,7 @@ EXPORT_SYMBOL(devm_ioremap);
 /**
  * devm_ioremap_nocache - Managed ioremap_nocache()
  * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
+ * @offset: Resource address to map
  * @size: Size of map
  *
  * Managed ioremap_nocache().  Map is automatically unmapped on driver
@@ -74,7 +74,7 @@ EXPORT_SYMBOL(devm_ioremap_nocache);
 /**
  * devm_ioremap_wc - Managed ioremap_wc()
  * @dev: Generic device to remap IO address for
- * @offset: BUS offset to map
+ * @offset: Resource address to map
  * @size: Size of map
  *
  * Managed ioremap_wc().  Map is automatically unmapped on driver detach.
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
