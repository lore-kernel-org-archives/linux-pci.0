Return-Path: <SRS0=XN0A=QS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F2C282CE
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52D1218A1
	for <linux-pci@archiver.kernel.org>; Mon, 11 Feb 2019 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549925749;
	bh=Y0njGnl61OeTB9QnGN215mmGplKAnxdWOuj/aYkR+m0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=jnUj+wD5TIYztcoGBiAe8sSYz5Lkpsg/Q8RvOO+V7AjyQtrnTIylTmGO8YNNH7gMR
	 rAAcfpOpb5VmNjlS4D4EY33Exd9lvP5HRj6GSWVaIzkKyD11+12Sx3LPwsA98ikOcO
	 AShtDXJJciyzkbgNWly6gzsNBLB/HD3lRFQoj9iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfBKWzs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfBKWzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Feb 2019 17:55:47 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE242083B;
        Mon, 11 Feb 2019 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549925746;
        bh=Y0njGnl61OeTB9QnGN215mmGplKAnxdWOuj/aYkR+m0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BUsmEuIyAlU5JO3MQ5UI3OQD5ji6l79XEyDo70noPBY90ZYTzroJ265H02jciNj5k
         qGsKYZMzaCXDY0Yjnzc3/qxsWU7HqMCNrRNbiYQ8QPFXRnDbxSKkTAu2O72EJYx2rZ
         L0kVZISlX4i5pxpuQ3kGeEP0ICRT9EbZUnh2yEAo=
Subject: [PATCH v1 2/2] PCI/ASPM: Save LTR Capability for suspend/resume
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     RussianNeuroMancer <russianneuromancer@ya.ru>,
        David Ward <david.ward@ll.mit.edu>,
        Frederick Lawler <fred@fredlawl.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 16:55:45 -0600
Message-ID: <154992574559.7864.8459750458248568194.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154992561743.7864.14353823538864422094.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Latency Tolerance Reporting (LTR) allows Endpoints and Switch Upstream
Ports to report their latency requirements to upstream components.  If ASPM
L1 PM substates are enabled, the LTR information helps determine when a
Link enters L1.2 [1].

Software must set the maximum latency values in the LTR Capability based on
characteristics of the platform, then set LTR Mechanism Enable in the
Device Control 2 register in the PCIe Capability.  The device can then use
LTR to report its latency tolerance.

If the device reports a maximum latency value of zero, that means the
device requires the highest possible performance and the ASPM L1.2 substate
is effectively disabled.

We put devices in D3 for suspend, and we assume their internal state is
lost.  On resume, previously we did not restore the LTR Capability, but we
did restore the LTR Mechanism Enable bit, so devices would request the
highest possible performance and ASPM L1.2 wouldn't be used.

[1] PCIe r4.0, sec 5.5.1
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201469
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9d8e3c837de..13d65991c77b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1233,7 +1233,6 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
 }
 
-
 static int pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
@@ -1270,6 +1269,45 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
 }
 
+static void pci_save_ltr_state(struct pci_dev *dev)
+{
+	int ltr;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
+		return;
+	}
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
+}
+
+static void pci_restore_ltr_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int ltr;
+	u16 *cap;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!save_state || !ltr)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
+	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
+}
 
 /**
  * pci_save_state - save the PCI configuration space of a device before suspending
@@ -1291,6 +1329,7 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	return pci_save_vc_state(dev);
 }
@@ -1390,7 +1429,12 @@ void pci_restore_state(struct pci_dev *dev)
 	if (!dev->state_saved)
 		return;
 
-	/* PCI Express register must be restored first */
+	/*
+	 * Restore max latencies (in the LTR capability) before enabling
+	 * LTR itself (in the PCIe capability).
+	 */
+	pci_restore_ltr_state(dev);
+
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
@@ -2998,6 +3042,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to preallocate PCI-X save buffer\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
+					    2 * sizeof(u16));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 

