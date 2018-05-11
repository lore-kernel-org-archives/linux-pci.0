Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org
Cc: joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, liudongdong3@huawei.com,
        shunyong.yang@hxt-semitech.com, nwatters@codeaurora.org,
        okaya@codeaurora.org, jcrouse@codeaurora.org, rfranz@cavium.com,
        dwmw2@infradead.org, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, ashok.raj@intel.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, robdclark@gmail.com,
        christian.koenig@amd.com, bharatku@xilinx.com, rgummal@xilinx.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 12/40] mm: export symbol mmput_async
Date: Fri, 11 May 2018 20:06:13 +0100
Message-Id: <20180511190641.23008-13-jean-philippe.brucker@arm.com>
In-Reply-To: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In some cases releasing a mm bound to a device might invoke an exit
handler, that takes a lock already held by the function calling mmput().
This is the case for VFIO, which needs to call mmput_async to avoid a
deadlock. Other drivers using SVA might follow. Since they can be built as
modules, export the mmput_async symbol.

Cc: akpm@linux-foundation.org
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1062f7450e97..bf05d188c8de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -999,6 +999,7 @@ void mmput_async(struct mm_struct *mm)
 		schedule_work(&mm->async_put_work);
 	}
 }
+EXPORT_SYMBOL_GPL(mmput_async);
 #endif
 
 /**
-- 
2.17.0

