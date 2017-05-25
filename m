Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: <catalin.marinas@arm.com>, <will.deacon@arm.com>, <robh+dt@kernel.org>,
 <frowand.list@gmail.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
 <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 7/7] MANTAINERS: Add maintainer for HiSilicon LPC driver
Date: Thu, 25 May 2017 12:37:28 +0100
Message-ID: <1495712248-5232-8-git-send-email-gabriele.paoloni@huawei.com>
In-Reply-To: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, minyard@acm.org, gabriele.paoloni@huawei.com,
 benh@kernel.crashing.org, john.garry@huawei.com, linux-kernel@vger.kernel.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e98464..8fb9006 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6061,6 +6061,14 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON LPC BUS DRIVER
+M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
+L:	linux-arm-kernel@lists.infradead.org
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
2.7.4



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
