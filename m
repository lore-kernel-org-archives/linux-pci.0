Return-Path: <linux-acpi-owner@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
To: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <hanjun.guo@linaro.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <arnd@arndb.de>, <mark.rutland@arm.com>,
        <olof@lixom.net>, <dann.frazier@canonical.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <andriy.shevchenko@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <minyard@acm.org>, <devicetree@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <frowand.list@gmail.com>, <agraf@suse.de>
Subject: [PATCH v15 9/9] MAINTAINERS: Add maintainer for HiSilicon LPC driver
Date: Tue, 27 Feb 2018 00:40:49 +0800
Message-ID: <1519663249-9850-10-git-send-email-john.garry@huawei.com>
In-Reply-To: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Added maintainer for drivers/bus/hisi_lpc.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c2320e1..ef5c38a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6401,6 +6401,13 @@ W:	http://www.hisilicon.com
 S:	Maintained
 F:	drivers/net/ethernet/hisilicon/hns3/
 
+HISILICON LPC BUS DRIVER
+M:	john.garry@huawei.com
+W:	http://www.hisilicon.com
+S:	Maintained
+F:	drivers/bus/hisi_lpc.c
+F:	Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
+
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Yisen Zhuang <yisen.zhuang@huawei.com>
 M:	Salil Mehta <salil.mehta@huawei.com>
-- 
1.9.1

