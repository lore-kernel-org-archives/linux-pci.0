Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 27 Feb 2016 13:43:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] PCI: hv: potential use after free
Message-ID: <20160227104357.GA14086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we throw away the very last item on the list, then we could end up
with a use after free of "dr".

Fixes: 15ca17645f19 ('PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 9391dee..9b66ffe 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1397,6 +1397,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		/* Throw this away if the list still has stuff in it. */
 		if (!list_empty(&hbus->dr_list)) {
 			kfree(dr);
+			dr = NULL;
 			continue;
 		}
 	}
