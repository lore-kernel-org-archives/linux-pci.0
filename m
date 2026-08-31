Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48812329E5D
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181439; cv=none; b=otkMjHE5PFYrvkPx/ynXRIZZGFbvqTnrGxmzso8Bd7COnXYozaxC2lO+2cdp/oLOkOSk96jfqh42TafouOdX/OY37x/dxHU6RR8vHlOzQZZtVouHsvxt6imHb2J77yv5hnsxFCFSbrjmUeoQnsjjeczvlL098ZXduPMiHyQ6aKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181439; c=relaxed/simple;
	bh=4Hin49XJlZ0lLoWqEMqdDZWbMuhWHVSDat0+ikbQ5Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnyVAQDzwvEcwUeIqRyrIgNQcrz/TW6+sSKvtWCUCausVkA7j43cB2YYCwq8Xeo2dCC7VnKVj9wUivhhZl+GppUrIAiQLhUrHIVyoxBNU6Igd8Swswue+WD8BIvjudKyxcP5QP1plNC+xwRLfM01cH2LIEHlSJCpzzNtD3cJICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIvM9j6S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIvM9j6S"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cffd93cdedso2667205ad.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 06:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788181436; x=1788786236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYUzL/NOcSCyj5tsm/2slVASn+9KBY8PpawGtrxxCAE=;
        b=fIvM9j6S8r51AYN8UxuDMnuNJi/V273Ywozx4zNocVyuQSqAJXowJPIdmkG2f95soe
         e5dUYH4cDxnQDPPC8+NaHf0ktgGqil4k+xYp4niLN3SYhdqUPvW1fbtYknsTUgGftFjT
         2He29L1BLmC4MZM0wDbGXqIjphM4sp22gk9wJfS0oAiFS9M6EFO0P5IhRCiKvgZUegUR
         GC96PtSD6Cy8AgtaD11/stxSXuvMs3wbcX7UzNQdj5dmA6oCE5ULAllHrmZjK+r9W8gB
         sJJK/ILEMHu7z2XeInppChxh6I21/IY/z3HI6Lz62B5sgFSeHyxT1rZjepDnLj/ZsKT1
         59CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788181436; x=1788786236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYUzL/NOcSCyj5tsm/2slVASn+9KBY8PpawGtrxxCAE=;
        b=VIiL0obrbpH9qtHLYzUBNWi3Yrq4Nv74cjLt7d4tQhRquyF+sUdSgiekTsvjGe5Kk3
         tw+P/v6KQS0tFg/flo9WDozotoQc1PCNLwelvOrdHMmUsNz57PIEBxkhstOiJ3QAu4lE
         QtOvCJJf736K1pEQxdAR7tN4Hg2UFptLTK7oSFG4FTO4ZZlsNT1CuzJBJ4dR9FVD3mgM
         dx9l/25zDNtmBQ7U/7+FOkPqxyB6t9OErGl8KBSZ8DCQtvApW0bWz3QDIMgVqVfQQLdg
         tDtAtnDPViVUeENp9dE/k1k4xXgM1jzEgDm1NZ94b0h4PeHdQTmoZuoEx0jvfUYOPHKa
         hQBA==
X-Forwarded-Encrypted: i=1; AKwUvBwX//FRm+hbbwajoWJ3UGJyoLa0+t4FX3Q86ZpeBRZP5+YRI0ZQdfFMqsnjFO4W8LCY6PQVqV7Fuzs=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ94WM48sNKTQFWuyKuuwd+k7sTEsMdjT6dQcCZhQkGmWoK705
	wQ4eotyCb758R2JCz8S5w/ZKb6Qf8b+GVPlzgcTOrV1fqqgn9blPLLtcOJljOSKaTJU=
X-Gm-Gg: AYBFou0rKIIpBhTu/KF3OYrujQjlp2wmSngyaIvg5AoJyYzywz8aSRqevTV9iqSRwNn
	0RmduPheM0WYhM9U0QMW1HUTTF5UrM1Pi7zBEaixV81FJdoTVvnsBLo3Gni5NpzWn/pgFCvKnxc
	Dv7dnSsnq/YCYUSU1X0Rvkg0G6+W35NU3TcPOZQKa9zJXeIfc6A+ADokpEBnCJeqvtENHvCtgIM
	jJvnoCsG9IrBbN/071Ztp37qlqlmWhvFj5rc6S6OAZcTz2YrhFEWfdw4cJZHppKqHYEWUuLYGAQ
	jIC8Rwxg8QPhIQH0j6sG1t/WblouPAOhXgzFwAgZLcgFLppBeRbg7QXrIsUl3pLjeltH+N9Fjnh
	BeGq9UGFcVPtHTGljZIFM4UJby71SFs9glWlNPGwZIxh5EE4MKTK9ZZCGzIjoApmAWqiChQnWwE
	MR59V+7bdTfLHvq8gx0jpGIMmA3WMRm3+c5Fxs4GW0NdNmThWn8qtBp45TkJUec/vt7M8TFAeGa
	7JQxk8+SrXW+faQg17UVt6qgkfK
X-Received: by 2002:a17:902:d2d0:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2d74dc08a13mr234387445ad.1.1788181435321;
        Mon, 31 Aug 2026 06:03:55 -0700 (PDT)
Received: from cachyos-aura ([45.112.149.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f7bf283sm32567749eec.8.2026.08.31.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:03:54 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Nika Krasnova <nika@nikableh.moe>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mark Pearson <markpearson@lenovo.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH wireless v2 3/3] wifi: iwlwifi: pcie: recover a device that lost power in D3cold
Date: Mon, 31 Aug 2026 18:33:32 +0530
Message-ID: <20260831130332.323549-4-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831130332.323549-1-navonjohnlukose@gmail.com>
References: <20260831130332.323549-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a Lenovo Yoga Pro 7 14IAH10 (Arrow Lake-H) with a discrete BE200
(8086:272b), D3cold removes the module's power rail and the device does
not restart when the rail and PERST# are restored. After _ON the
power-enable and PERST# GPIO pad registers read correct and the link
still never trains; config space reads all ones until reboot.

The platform can recover it, with a WLAN-specific reset line driven by
the object _PRR returns - which is exactly the product reset the driver
already implements. The problem is ordering: AML only dispatches the
vendor DSM that selects that mode after reading the device's PCI ID back
out of config space,

    Method (WIST) { Switch (ToInteger (VDID)) { Case (0x272B8086) {...} } }
    Method (_DSM) { ... If (WIST ()) { ... Return (IFUN (...)) } ... }

so once the device is off the bus acpi_check_dsm() fails and the mode
stays deselected. iwl_trans_pcie_removal_wk() is the only place that
selects it today, and by then it is too late: _RST takes its other
branch and issues a function level reset to a device that is not there.

So arm the mode in .suspend, while the device still answers, and disarm
it again in .resume. Treat the device as gone only when two independent
signals agree: the mode we armed can no longer be disarmed (so the
platform cannot see the device either) and CSR_HW_REV reads all ones (so
neither can we). Either alone is not enough - a DSM can fail for
transient ACPI reasons on a healthy adapter, and a false positive costs a
remove, a platform reset and a rescan on every resume. The order of the
terms is load bearing: a device in D3hot answers config cycles but does
not decode its BARs, so the DSM would still work while CSR_HW_REV read
all ones. The disarm has to short-circuit.

Recovery goes through the existing iwl_trans_pcie_reset() path, which
only queues a work item, so the remove, the _RST and the rescan happen
after .resume has returned and the PM core has dropped the device lock.
The op_mode is not notified beyond the STATUS_TRANS_DEAD that
iwl_trans_pcie_reset() sets; as today, it finds out by having its own
resume fail against the dead device. Taking this path also skips the
handshake timeouts and the bogus ADVANCED_SYSASSERT dump the driver
otherwise produces against absent hardware, which on this machine cost
about two seconds on every failed resume.

Arming is confined to discrete modules: on integrated CNVi parts
iwl_trans_pcie_set_product_reset() sends EN_PROD_RESET on its own, which
lands in \_SB.PC00.CNVW.RSTT and is what the CNVi _RST branches on before
killing Bluetooth and issuing the PLDR. Arming that from .suspend on
hardware I cannot test is not worth it, so the integrated mask stays as
unexercised as it is today.

iwl_trans_pcie_set_product_reset() now reports whether the DSM took, and
its error on failure becomes a debug message: .suspend would otherwise log
an error on every suspend on every discrete machine without this DSM. So
iwl_trans_pcie_removal_wk() no longer logs at error level when it cannot
arm, which on the recovery path is every time, since the device is off the
bus by then. The cost is that a genuine product reset on a live device
with no DSM support is now silent at error level too.

One known limitation: where me_present is not 0, iwl_trans_pcie_reset()
downgrades the request to IWL_RESET_MODE_FUNC_RESET. The device still
comes back, because the mode is already armed and _RST does the product
reset regardless, but the Bluetooth function is not torn down first.

Cc: stable+noautosel@kernel.org # new suspend/resume behaviour, one machine
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221695
Link: https://lore.kernel.org/all/20260722021321.68902-1-nika@nikableh.moe/
Link: https://lore.kernel.org/all/20260829093922.37103-1-navonjohnlukose@gmail.com/
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
The bugzilla and the first lore Link: are other BE200/GL reports of the
same 0xffffffff-until-reboot, on machines I do not have; neither is
claimed as fixed, hence Link: and not Closes:. The assert in the bugzilla
report is the dump against absent hardware this patch skips, not a
firmware bug it fixes. The second lore Link: is my own analysis of this
machine's AML.

Lenovo Yoga Pro 7 14IAH10 (Arrow Lake-H, Core Ultra 9 285H), BIOS
QGCN35WW, discrete BE200 SUBSYS_00F48086, Bluetooth on USB, no CSME,
stock ACPI tables.

This machine ships a udev rule forcing d3cold_allowed to 0, which would
have made the test vacuous. It was moved aside for the whole run and
d3cold_allowed written back to 1 before every cycle, so the device really
did reach D3cold: detection fired on all five cycles, which cannot happen
otherwise. Before the patch every cycle left the device dead until reboot;
with it the device recovered on all five, four with wifi connected at
suspend and one with the radio down, the case where .suspend runs with no
op_mode. With the reset skipped and nothing else changed it stayed absent,
so it is the reset that recovers it and not the remove/rescan.

With debug=0x100 one cycle logs the intended path end to end:

    iwl_trans_pcie_set_product_reset Enabled product reset via DSM
    iwl_trans_pcie_check_product_reset_mode product reset mode is 0x1
    iwl_trans_pcie_set_product_reset can't disable product reset via DSM (-19)
    device not responding after resume
    scheduling reset (mode=6)
    iwl_trans_pcie_set_product_reset can't enable product reset via DSM (-19)
    iwl_trans_pcie_call_reset called _RST on _PRR object

mode=6 is IWL_RESET_MODE_PROD_RESET, so the request was not downgraded.
The link trained in 64-76 ms and the interface was usable 5.00-5.05 s after
.resume returned; end to end it is closer to 7 s, because the PCI core
spends ~2 s retraining a link that cannot train before .resume is called.
4.365 s of the rest is one _RST evaluation against a 4.320 s floor computed
from the Sleep() operators in the AML, so essentially all of it is platform
AML, and asking for a product reset is not what costs it: both arms of _RST
fall through to the same two 2000 ms sleeps and the product arm adds only
2 x RDLY (160 ms each here).

What is untested or untestable with one machine:

- .suspend and .resume are untouched on integrated/CNVi: the arming helper
  returns early there, so prod_reset_set is never set. (The error-level
  demotion does apply to integrated parts on the removal_wk() path.)
  Getting the CNVi case working needs someone with the hardware.
- Where me_present is non-zero - including the permanent -1 that
  iwl_pcie_check_me_status() leaves on everything below
  IWL_DEVICE_FAMILY_BZ, which is four of the five Intel IDs this AML
  accepts - the request is downgraded to IWL_RESET_MODE_FUNC_RESET. The
  device still comes back, because the mode is armed and _RST does the
  product reset anyway, but Bluetooth is not torn down first. That is the
  pre-existing hazard the previous patch describes, now reachable from
  resume. me_present is a real 0 here, so this is reasoned, not observed.
- If the disarm fails transiently on a live device, the code clears
  prod_reset_set and carries on while the platform's mode stays selected
  until the next probe, which re-opens that same hazard. Retrying the
  disarm would narrow it; I did not, because a retry loop around an AML
  method on the resume path needs a bound I cannot justify from one
  machine.
- Only s2idle was tested. The same callback is .freeze and .poweroff, so
  hibernate arms too and the image is snapshotted while armed, meaning a
  restore kernel disarms a mode a previous boot selected. Harmless as far
  as I can reason it, but unexercised. A device that dies at runtime is
  still unrecoverable; that needs the same thing on runtime PM, which
  iwlwifi does not implement.
- Only one BIOS. On mine the reset method branches solely on the mode
  variable, never on WIST()/VDID, which is what makes the downgrade above
  survivable. I cannot claim that for every implementation.
- On a platform with the arming DSM but no usable _PRR,
  iwl_trans_pcie_call_reset() falls back to pci_reset_function() against a
  device that is gone, and pci_dev_wait() polls config space for up to
  ~65 s per reset method with pci_lock_rescan_remove() held. That is the
  cost of a true positive, not a false one: a false positive still answers
  config cycles, so pci_dev_wait() returns on its first read.
- iwl_trans_pcie_removal_wk() holds pci_lock_rescan_remove() across the
  whole reset, so it is now held for ~4.3 s during system resume on a
  machine that also has Thunderbolt wanting it. Pre-existing, but this
  patch is what puts it on the resume path.

The arming mask is heavier than the recovery needs - only EN_PROD_RESET
drives the GPIO - but I kept it so the reset armed from .suspend is bit for
bit the one iwl_trans_pcie_removal_wk() already arms. Narrowing it is an
easy follow-up.

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 24 +++++++++++++++++++
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  4 ++++
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 24 ++++++++++++++-----
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7a7b101..5d01a4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1203,11 +1203,19 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 
 static int iwl_pci_suspend(struct device *device)
 {
+	struct iwl_trans *trans = pci_get_drvdata(to_pci_dev(device));
+
 	/* Before you put code here, think about WoWLAN. You cannot check here
 	 * whether WoWLAN is enabled or not, and your code will run even if
 	 * WoWLAN is enabled - don't kill the NIC, someone may need it in Sx.
 	 */
 
+	/* Has to be here, while the device still answers: AML gates this DSM
+	 * on reading the device's PCI ID out of config space. It doesn't touch
+	 * the NIC.
+	 */
+	iwl_trans_pcie_arm_product_reset(trans, true);
+
 	return 0;
 }
 
@@ -1229,6 +1237,22 @@ static int _iwl_pci_resume(struct device *device, bool restore)
 	 */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
 
+	/* Two signals that it didn't come back from D3cold: the platform can't
+	 * deselect the mode armed in .suspend (so it can't see the device
+	 * either), and the device doesn't answer. Before the op_mode test: the
+	 * firmware may never have been loaded.
+	 */
+	if (trans_pcie->prod_reset_set) {
+		iwl_trans_pcie_arm_product_reset(trans, false);
+		if (trans_pcie->prod_reset_set &&
+		    iwl_read32(trans, CSR_HW_REV) == ~0U) {
+			IWL_ERR(trans, "device not responding after resume\n");
+			iwl_trans_pcie_reset(trans, IWL_RESET_MODE_PROD_RESET);
+			return 0;
+		}
+		trans_pcie->prod_reset_set = false;
+	}
+
 	if (!trans->op_mode)
 		return 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index d84c7c1..1caaff9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -495,6 +495,8 @@ struct iwl_pcie_txqs {
  * @isr_stats: interrupt statistics
  * @napi_dev: (fake) netdev for NAPI registration
  * @txqs: transport tx queues data.
+ * @prod_reset_set: the product reset mode is selected in the platform;
+ *	system suspend/resume only, so process context only
  * @me_present: WiAMT/CSME is detected as present (1), not present (0)
  *	or unknown (-1, so can still use it as a boolean safely)
  * @me_recheck_wk: worker to recheck WiAMT/CSME presence
@@ -605,6 +607,7 @@ struct iwl_trans_pcie {
 
 	struct iwl_pcie_txqs txqs;
 
+	bool prod_reset_set;
 	s8 me_present;
 	struct delayed_work me_recheck_wk;
 
@@ -657,6 +660,7 @@ bool _iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
 
 void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev);
 void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev);
+void iwl_trans_pcie_arm_product_reset(struct iwl_trans *trans, bool arm);
 
 /*****************************************************
 * RX
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index df89fb3..56eb35d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2075,7 +2075,7 @@ void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev)
 	ACPI_FREE(res);
 }
 
-static void iwl_trans_pcie_set_product_reset(struct pci_dev *pdev, bool enable,
+static bool iwl_trans_pcie_set_product_reset(struct pci_dev *pdev, bool enable,
 					     bool integrated)
 {
 	union acpi_object *res;
@@ -2089,17 +2089,29 @@ static void iwl_trans_pcie_set_product_reset(struct pci_dev *pdev, bool enable,
 						 DSM_INTERNAL_PLDR_CMD_SET_MODE,
 						 mode);
 	if (IS_ERR(res)) {
-		if (enable)
-			IWL_ERR_DEV(&pdev->dev,
-				    "ACPI _DSM not available (%d), cannot do product reset\n",
-				    (int)PTR_ERR(res));
-		return;
+		IWL_DEBUG_DEV_POWER(&pdev->dev,
+				    "can't %sable product reset via DSM (%d)\n",
+				    enable ? "en" : "dis", (int)PTR_ERR(res));
+		return false;
 	}
 
 	ACPI_FREE(res);
 	IWL_DEBUG_DEV_POWER(&pdev->dev, "%sabled product reset via DSM\n",
 			    enable ? "En" : "Dis");
 	iwl_trans_pcie_check_product_reset_mode(pdev);
+	return true;
+}
+
+void iwl_trans_pcie_arm_product_reset(struct iwl_trans *trans, bool arm)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	/* discrete only: the integrated arming mask is untested */
+	if (trans->mac_cfg->integrated)
+		return;
+
+	if (iwl_trans_pcie_set_product_reset(trans_pcie->pci_dev, arm, false))
+		trans_pcie->prod_reset_set = arm;
 }
 
 void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev)
-- 
2.55.0

