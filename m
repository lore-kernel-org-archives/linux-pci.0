Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] PCI/ASPM: use permission-specific DEVICE_ATTR variants
Date: Sat, 29 Oct 2016 21:37:07 +0200
Message-Id: <1477769829-22230-14-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use DEVICE_ATTR_RW for read-write attributes.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@rw@
declarer name DEVICE_ATTR;
identifier x,x_show,x_store;
@@

DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);

@script:ocaml@
x << rw.x;
x_show << rw.x_show;
x_store << rw.x_store;
@@

if not (x^"_show" = x_show && x^"_store" = x_store)
then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RW;
identifier rw.x,rw.x_show,rw.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pci/pcie/aspm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0ec649d..3b14d9e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -886,8 +886,8 @@ static ssize_t clk_ctl_store(struct device *dev,
 	return n;
 }
 
-static DEVICE_ATTR(link_state, 0644, link_state_show, link_state_store);
-static DEVICE_ATTR(clk_ctl, 0644, clk_ctl_show, clk_ctl_store);
+static DEVICE_ATTR_RW(link_state);
+static DEVICE_ATTR_RW(clk_ctl);
 
 static char power_group[] = "power";
 void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
