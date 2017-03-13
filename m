Return-Path: <SRS0=M0Me=2W=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=M0Me=2W=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V4 0/3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
 <20170313214616.GE8232@bhelgaas-glaptop.roam.corp.google.com>
 <c6b78903-ea09-9719-7073-c679b0b64a05@codeaurora.org>
 <20170313230855.GG8232@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, mayurkumar.patel@intel.com,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b44fa6b3-7db5-bea4-7f2e-7f880362d171@codeaurora.org>
Date: Mon, 13 Mar 2017 19:21:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170313230855.GG8232@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/mixed;
 boundary="------------3ECCC80930E1CA0CF3F6816A"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------3ECCC80930E1CA0CF3F6816A
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 3/13/2017 7:08 PM, Bjorn Helgaas wrote:
> On Mon, Mar 13, 2017 at 06:05:55PM -0400, Sinan Kaya wrote:
>> On 3/13/2017 5:46 PM, Bjorn Helgaas wrote:
>>> What is this series based on?  Unless they depend on other in-flight
>>> patches, I apply patches to branches based on my "master" branch,
>>> which is typically -rc1 or -rc2 (it's currently v4.11-rc1).  These
>>> don't apply to either.
>>
>> It looks like I am on 4.10. I can rebase and post again. 
> 
> Rebasing would be good, but I can give you some comments on your v4,
> now that I can apply it and see what it looks like.
> 

Thanks, 

I'm mostly done with the rebase. I'll have to retest tomorrow morning and
then post.

I had to drop this

   - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
      setup of the link as it currently does.

during rebase.

The reason is that the clock configuration needs to switch to common clock
mode across all the devices before any ASPM latency is read/configured.

Common clock configuration seem to be trying to walk the device list.

Here is the untested version. It might not even compile.
I'll wait until I receive your comments.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------3ECCC80930E1CA0CF3F6816A
Content-Type: text/plain; charset=UTF-8;
 name="0001-PCI-ASPM-move-part-of-ASPM-initialization-to-pci_ini.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-PCI-ASPM-move-part-of-ASPM-initialization-to-pci_ini.pa";
 filename*1="tch"

>From 0ac5e06c99106de612e596398a3add44c54ddf42 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Mon, 13 Mar 2017 19:08:57 -0400
Subject: [PATCH 1/4] PCI/ASPM: move part of ASPM initialization to
 pci_init_capabilities

Call pci_aspm_init() for every device, maybe from pci_init_capabilities()

- for bridges, have pcie_aspm_init_link_state() allocate a
  link_state, regardless of whether it currently has any children,
  and save the ASPM settings done by firmware.

- for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
  setup of the link as it currently does.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 10 ++++++++++
 drivers/pci/probe.c     |  3 +++
 include/linux/pci.h     |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 973472c..74fd7c5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -828,6 +828,16 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 }
 
 /*
+ * pci_aspm_init: Initiate PCI express link state.
+ * It is called from device_add for every single pci device.
+ * @pdev: all pci devices
+ */
+int pci_aspm_init(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+/*
  * pcie_aspm_init_link_state: Initiate PCI express link state.
  * It is called after the pcie and its children devices are scanned.
  * @pdev: the root port or switch downstream port
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dfc9a27..1e19364 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1847,6 +1847,9 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	/* Advanced Error Reporting */
 	pci_aer_init(dev);
+
+	/* Active State Power Management */
+	pci_aspm_init(dev);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index eb3da1a..8828dd7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1396,8 +1396,10 @@ static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
 
 #ifdef CONFIG_PCIEASPM
 bool pcie_aspm_support_enabled(void);
+int pci_aspm_init(struct pci_dev *pdev);
 #else
 static inline bool pcie_aspm_support_enabled(void) { return false; }
+static inline int pci_aspm_init(struct pci_dev *pdev) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_PCIEAER
-- 
1.9.1


--------------3ECCC80930E1CA0CF3F6816A
Content-Type: text/plain; charset=UTF-8;
 name="0002-PCI-ASPM-add-init-hook-to-device_add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-PCI-ASPM-add-init-hook-to-device_add.patch"

>From 36d315a7198bbe90cc5b9a06ddd5cb9ac4ebdd1a Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Mon, 13 Mar 2017 19:00:46 -0400
Subject: [PATCH 2/4] PCI/ASPM: add init hook to device_add

The ASPM capability initialization is done in one pass where both
the current settings such as capable/enable/supported field are set
and also all children are scanned for latencies.

Add a callback from device_add to save the power up values.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 43 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 74fd7c5..7312a37 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -834,7 +834,39 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
  */
 int pci_aspm_init(struct pci_dev *pdev)
 {
-	return 0;
+	int ret;
+	struct pcie_link_state *link;
+	struct aspm_register_info upreg;
+
+	if (!aspm_support_enabled)
+		return 0;
+
+	if (pdev->link_state)
+		return 0;
+
+	/* VIA has a strange chipset, root port is under a bridge */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
+	    pdev->bus->self)
+		return 0;
+
+	if (!pdev->has_secondary_link)
+		return 0;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	link = alloc_pcie_link_state(pdev);
+	WARN_ON(!link);
+	if (!link) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+	ret = 0;
+unlock:
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return ret;
 }
 
 /*
@@ -850,9 +882,11 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 	if (!aspm_support_enabled)
 		return;
 
-	if (pdev->link_state)
+	if (!pdev->link_state)
 		return;
 
+	link = pdev->link_state;
+
 	/*
 	 * We allocate pcie_link_state for the component on the upstream
 	 * end of a Link, so there's nothing to do unless this device has a
@@ -871,9 +905,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		goto out;
 
 	mutex_lock(&aspm_lock);
-	link = alloc_pcie_link_state(pdev);
-	if (!link)
-		goto unlock;
+
 	/*
 	 * Setup initial ASPM state. Note that we need to configure
 	 * upstream links also because capable state of them can be
@@ -898,7 +930,6 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 		pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	}
 
-unlock:
 	mutex_unlock(&aspm_lock);
 out:
 	up_read(&pci_bus_sem);
-- 
1.9.1


--------------3ECCC80930E1CA0CF3F6816A
Content-Type: text/plain; charset=UTF-8;
 name="0003-PCI-ASPM-save-power-on-values-during-bridge-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-PCI-ASPM-save-power-on-values-during-bridge-init.patch"

>From 1e6d3b2856a6ba3f38f67ab9c8286e4bf93f0968 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Sun, 12 Mar 2017 01:08:54 -0500
Subject: [PATCH 3/4] PCI/ASPM: save power on values during bridge init

Now that we added a hook to be called from device_add, save the
default values from the HW registers early in the boot for further
reuse during hot device add/remove operations.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7312a37..7754445 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -521,8 +521,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	 */
 	if (dwreg.support & upreg.support & PCIE_LINK_STATE_L0S)
 		link->aspm_support |= ASPM_STATE_L0S;
-	if (dwreg.enabled & PCIE_LINK_STATE_L0S)
+	if (dwreg.enabled & PCIE_LINK_STATE_L0S) {
 		link->aspm_enabled |= ASPM_STATE_L0S_UP;
+		link->aspm_default |= ASPM_STATE_L0S_UP;
+	}
 	if (upreg.enabled & PCIE_LINK_STATE_L0S)
 		link->aspm_enabled |= ASPM_STATE_L0S_DW;
 	link->latency_up.l0s = calc_l0s_latency(upreg.latency_encoding_l0s);
@@ -558,9 +560,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	if (link->aspm_support & ASPM_STATE_L1SS)
 		aspm_calc_l1ss_info(link, &upreg, &dwreg);
 
-	/* Save default state */
-	link->aspm_default = link->aspm_enabled;
-
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
 	/*
@@ -860,7 +859,21 @@ int pci_aspm_init(struct pci_dev *pdev)
 	if (!link) {
 		ret = -ENOMEM;
 		goto unlock;
-	}
+
+	pcie_get_aspm_reg(pdev, &upreg);
+	if (upreg.enabled & PCIE_LINK_STATE_L0S)
+		link->aspm_default |= ASPM_STATE_L0S_DW;
+	if (upreg.enabled & PCIE_LINK_STATE_L1)
+		link->aspm_default |= ASPM_STATE_L1;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_1)
+		link->aspm_default |= ASPM_STATE_L1_1;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_ASPM_L1_2)
+		link->aspm_default |= ASPM_STATE_L1_2;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_1)
+		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
+	if (upreg.l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
+		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+
 	ret = 0;
 unlock:
 	mutex_unlock(&aspm_lock);
-- 
1.9.1


--------------3ECCC80930E1CA0CF3F6816A
Content-Type: text/plain; charset=UTF-8;
 name="0004-PCI-ASPM-move-link_state-cleanup-to-bridge-remove.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-PCI-ASPM-move-link_state-cleanup-to-bridge-remove.patch"

>From e54d1b44f6701c5423ff8aa3501164352f57e37f Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Mon, 13 Mar 2017 18:43:35 -0400
Subject: [PATCH 4/4] PCI/ASPM: move link_state cleanup to bridge remove

For endpoints, change pcie_aspm_exit_link_state() so it cleans up
the device's own state and disables ASPM if necessary, but doesn't
remove the parent's link_state.

For bridges, change pcie_aspm_exit_link_state() so it frees the
bridge's own link_state.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pcie/aspm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7754445..e1a1b47 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -996,10 +996,12 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
-	list_del(&link->sibling);
-	list_del(&link->link);
-	/* Clock PM is for endpoint device */
-	free_link_state(link);
+	if (pdev->has_secondary_link) {
+		list_del(&link->sibling);
+		list_del(&link->link);
+		/* Clock PM is for endpoint device */
+		free_link_state(link);
+	}
 
 	/* Recheck latencies and configure upstream links */
 	if (parent_link) {
-- 
1.9.1


--------------3ECCC80930E1CA0CF3F6816A--
