Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH NEXT 5/6] PCI/AER: Clear correctable status bits in device register
Date: Thu,  7 Jun 2018 02:00:33 -0400
Message-Id: <1528351234-26914-5-git-send-email-poza@codeaurora.org>
In-Reply-To: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
References: <1528351234-26914-1-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In case of correctable error Device Status Register sets
Correctable Error Detected, which should be cleared after handling
the error

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 95e9828..0e4e99a 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -271,6 +271,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 		if (pos)
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
+		pci_cleanup_aer_error_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
 		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-- 
2.7.4
