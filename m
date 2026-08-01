Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71931356779
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785581698; cv=none; b=uG2EoIsCdjd9Hf53GWLAFGHBuDqwkTPncSNIUYSvgU8xdyniead09PM4zmrYL4h/WadDRUSZx3N4sd5EDnXr77R/Fj6WZJbaC13W8GLomu280dYCZKq5eAyZ4IZrVLMnWyKYVbu5yl+WEGFhD4BJJuk8xgtF6Dwphboq5ROF9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785581698; c=relaxed/simple;
	bh=bQY8mM1D2V0dWnJKSd8etMHtx9KBEvIFBqfka2XLg/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDBriPX+cY6v4/a03H8HMDlFu+1Q2Kjw9MUP9Y0TaUtjN1KTjf9tQargNtLLF/JJ1MybldJLAAra85UCfVYZekvvy/KSHxKX5brNM3bMTMa2A3rqXenG6JbxVjMDW3OEtbtyrEoj5lsVCwEDpbsX5XbkmawIMQpuc4pI9GOQUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0ZDUyrc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0ZDUyrc"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso783725e9.0
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 03:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785581694; x=1786186494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZoYYfXArrGBpjN/+DjIjQ8cogCOGLtf17rgG0aM3WE8=;
        b=P0ZDUyrcp4Dwak9XOB51Irtlok332Am/hQ0cWByp8RY9l28at84Bb0ka/fj5Hr7DGI
         K3IM/OwGLu/0V6iulEfzaiBj0Be/qpkU8xMCELJfdA09lxWcwa6DGOMrJH7YdPHX0Lub
         3c4qn0j7sMFJjjU5ljgKHux+UUzSX6Nlnhowd5UB3uwvbqqxFmwXx+BypMlOcHhK8FDo
         IiI95XZ2fqIQgiqEjKZLzdoZsyILF2PJotN73/opMB2hXTV02FQ4c3m6Y9YpuOfThrmy
         zcnUDR6fp0qgfSrc3vY+TBVRDztG7Bhn78bJt8SKD0xzPwna73GzWocw6Zgx6rTMcS6H
         pxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785581694; x=1786186494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZoYYfXArrGBpjN/+DjIjQ8cogCOGLtf17rgG0aM3WE8=;
        b=cd4slaLqWRvXRjuaWVKryTgrzgtkdoDmSxgIug6LkegKzboDMc9nEufrI91qIeDd6/
         NBko2R9igchk8KayB/IvEGWKkT6No3Uev084Wjq2hwa9Wp35hNAKe+kePCplE7+/87Nv
         ofB8Ox4koWXVTbK4Em5bAtpul8RR7lPiDYC/KH04dVMTJFNzMjGzuPJYSQPCfWTHNHOG
         sUM8VwFEicxB+7CyKHaTNSABgNZCEsZK0DCajl8Obs1PZ11X7bEFi+5LnH8oX0+8nhZA
         DWTlFUO3bp7tcCDJOv4I5Y4CqpZfjCrzUsZT8i997nP5YiCN9OmUg1XdZFZS7lwKQ94V
         BdEQ==
X-Gm-Message-State: AOJu0YwWanOs5eG0kkxC0Tk07/ywonPrnYFKdhw47cFGqwQXRjBQYKT7
	po2ZrzbOZeL5I9ajLOMrwuTJ8vH2EEeCAQ/JrnMYcdN2j6rE3dx/Pxhrp9YAYkFlHiA=
X-Gm-Gg: AR+sD135YdsNhSaoNP+uNL5ilpTaSJdb1m+rRam0AyPAK/9JQgn4dxJpyN/hEA8fymZ
	vxFsfLVXZI1vFZTcP+m2FrKjUpz2EfrsVKmxHoAT9zJXhWpQbDG9ZlVpS18AQBNRSpAvOJ/DZ6Q
	ZgGwJmmC9QScPUnT8s84An24uDIXele6Qjafu/DDU5jCotiN21/YEYzRiEIuWR5SHnCMWBnWcyw
	+rvm95rIxzVr9M6O7IXBbQVnLHIJmJXBMbQFuU+iLwl/PI7YniAUX7kB/KKhs/mTgJVeoMMYJ7m
	jvJOt3XM048RGmuXHr1WZRU34gPJ61Uj4WGV+xwoR2d0i0j3Ub83oRe5fgn5dvetJ8XbJk13pet
	foTtLI9t58js2v1nPaxlUlBFYPJj/tKL+y9DDRtflh/ToKtCIU9gExfvjFFJKPoHkSRitxD3LMr
	1+bKmyZXy/Rhsqv0xbxqv9fvagEpEZJTacl69wYyGKtA4Ji/LwhrhAsYIg11x59rNFN6nvmtIai
	pELDX1F2wNCl38WfIj1+YojXPAusRzlLWiUwfqw6AAW520+8tqTCTlEphXVtzMnHOST9p5FU47b
	9zkQWpFh8oXh9QA7LGID
X-Received: by 2002:a05:600c:6298:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-4980ebc216amr32193405e9.9.1785581694293;
        Sat, 01 Aug 2026 03:54:54 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca72356fc3569cec583d57196.dip0.t-ipconnect.de. [2003:ec:a723:56fc:3569:cec5:83d5:7196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808690ffbsm54559625e9.10.2026.08.01.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:54:54 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	macro@orcam.me.uk,
	linux-kernel@vger.kernel.org,
	Andreas Wild <andiwild@gmail.com>
Subject: [PATCH v2] PCI: Avoid link retraining on empty ports when lifting speed restriction
Date: Sat,  1 Aug 2026 12:54:25 +0200
Message-ID: <20260801105441.6506-1-andiwild@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
failed link retraining") the Target Speed quirk lifts a firmware-imposed
2.5GT/s restriction on any downstream port, without checking whether the
link is up.  Where nothing is plugged in, the retraining that follows can
never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
quirk makes two of them -- the initial one and the restore on the error
path -- adding a fixed 2 s to every boot.

On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
slot, running v7.2-rc5:

 0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restriction
 1.541 pci 0000:00:1c.0: retraining failed
 2.541 pci 0000:00:1c.2: [8086:7aba] type 01 class 0x060400

The kerneldoc above the quirk already contemplates this case ("For a port
that has been left unconnected both bits will be clear") and describes
lifting the restriction where firmware arranged it "and the port reports
its link already being up".  The code stopped checking the latter.

Add pcie_set_target_speed_no_retrain(), which programs the Target Link
Speed exactly as pcie_set_target_speed() does -- same speed selection
through dev->supported_speeds, same pcie_valid_speed() validation, same
bwctrl locking -- but skips the retraining.  Use it from the quirk when
Data Link Layer Link Active is clear.  The restriction is still lifted, so
a device plugged into the port later trains at the full speed the port
supports, which is what the original change set out to ensure.

The decision has to stay with the caller: the ASM2824 workaround earlier in
the same function deliberately retrains a link whose DLLLA is clear, so
pcie_bwctrl_change_speed() cannot simply skip retraining whenever the link
is down.

Measured on v7.2-rc5, same tree and same config with and without the fix:
the interval after the quirk logs drops from 1000 ms to 1 ms, the second
timeout disappears along with "retraining failed", and the systemd "kernel"
boot phase goes from 3.011 s to 1.017 s.  The restriction is still lifted
-- on the still-empty port afterwards:

 LnkCap:  Port #1, Speed 8GT/s, Width x1
 LnkSta:  Speed 2.5GT/s, Width x0
 LnkCtl2: Target Link Speed: 8GT/s

Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Wild <andiwild@gmail.com>
---
v2:
 - Do not write LNKCTL2 directly from the quirk.  v1 derived the Target Link
   Speed from LNKCAP, which ignores LNKCAP2 and any adjustment the core has
   made in dev->supported_speeds, skipped the pcie_valid_speed() check, and
   touched the register without pcie_bwctrl_setspeed_rwsem /
   set_speed_mutex.  Raised by the sashiko review bot.  The missing locking
   is unreachable from the pci_device_add() path used at boot, where
   port->link_bwctrl is still NULL, but the quirk is also called from
   pci_dev_wait() and pcie_wait_for_link_delay() on a live system, where it
   is not.
 - Return -ENOTTY explicitly on the no-retrain path rather than falling
   through with a stale ret, which could have reported success if the
   ASM2824 branch had retrained the link and it dropped immediately after.
 - v1: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail.com/
 drivers/pci/pci.h         |  7 ++++
 drivers/pci/pcie/bwctrl.c | 76 ++++++++++++++++++++++++++++-----------
 drivers/pci/quirks.c      | 15 ++++++++
 3 files changed, 77 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a..b900f7f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1121,8 +1121,15 @@ static inline void pcie_ecrc_get_policy(char *str) { }
 
 #ifdef CONFIG_PCIEPORTBUS
 void pcie_reset_lbms(struct pci_dev *port);
+int pcie_set_target_speed_no_retrain(struct pci_dev *port,
+				     enum pci_bus_speed speed_req);
 #else
 static inline void pcie_reset_lbms(struct pci_dev *port) {}
+static inline int pcie_set_target_speed_no_retrain(struct pci_dev *port,
+						   enum pci_bus_speed speed_req)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 struct pci_dev_reset_methods {
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c4c8d26..b230556 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -108,7 +108,8 @@ static u16 pcie_bwctrl_select_speed(struct pci_dev *port, enum pci_bus_speed spe
 	return pcie_supported_speeds2target_speed(supported_speeds & desired_speeds);
 }
 
-static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool use_lt)
+static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed,
+				    bool use_lt, bool retrain)
 {
 	int ret;
 
@@ -117,28 +118,15 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return pcibios_err_to_errno(ret);
 
+	if (!retrain)
+		return 0;
+
 	return pcie_retrain_link(port, use_lt);
 }
 
-/**
- * pcie_set_target_speed - Set downstream Link Speed for PCIe Port
- * @port:	PCIe Port
- * @speed_req:	Requested PCIe Link Speed
- * @use_lt:	Wait for the LT or DLLLA bit to detect the end of link training
- *
- * Attempt to set PCIe Port Link Speed to @speed_req. @speed_req may be
- * adjusted downwards to the best speed supported by both the Port and PCIe
- * Device underneath it.
- *
- * Return:
- * * 0		- on success
- * * -EINVAL	- @speed_req is not a PCIe Link Speed
- * * -ENODEV	- @port is not controllable
- * * -ETIMEDOUT	- changing Link Speed took too long
- * * -EAGAIN	- Link Speed was changed but @speed_req was not achieved
- */
-int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
-			  bool use_lt)
+static int __pcie_set_target_speed(struct pci_dev *port,
+				   enum pci_bus_speed speed_req,
+				   bool use_lt, bool retrain)
 {
 	struct pci_bus *bus = port->subordinate;
 	u16 target_speed;
@@ -162,7 +150,8 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 		if (data)
 			mutex_lock(&data->set_speed_mutex);
 
-		ret = pcie_bwctrl_change_speed(port, target_speed, use_lt);
+		ret = pcie_bwctrl_change_speed(port, target_speed, use_lt,
+					       retrain);
 
 		if (data)
 			mutex_unlock(&data->set_speed_mutex);
@@ -179,6 +168,51 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 	return ret;
 }
 
+/**
+ * pcie_set_target_speed - Set downstream Link Speed for PCIe Port
+ * @port:	PCIe Port
+ * @speed_req:	Requested PCIe Link Speed
+ * @use_lt:	Wait for the LT or DLLLA bit to detect the end of link training
+ *
+ * Attempt to set PCIe Port Link Speed to @speed_req. @speed_req may be
+ * adjusted downwards to the best speed supported by both the Port and PCIe
+ * Device underneath it.
+ *
+ * Return:
+ * * 0		- on success
+ * * -EINVAL	- @speed_req is not a PCIe Link Speed
+ * * -ENODEV	- @port is not controllable
+ * * -ETIMEDOUT	- changing Link Speed took too long
+ * * -EAGAIN	- Link Speed was changed but @speed_req was not achieved
+ */
+int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
+			  bool use_lt)
+{
+	return __pcie_set_target_speed(port, speed_req, use_lt, true);
+}
+
+/**
+ * pcie_set_target_speed_no_retrain - Program Target Link Speed, skip retraining
+ * @port:	PCIe Port
+ * @speed_req:	Requested PCIe Link Speed
+ *
+ * Program the Target Link Speed of @port as pcie_set_target_speed() does, but
+ * do not request Link retraining afterwards.  Intended for Ports with no Link
+ * partner, where retraining cannot succeed and each attempt costs
+ * PCIE_LINK_RETRAIN_TIMEOUT_MS.  The Link trains at the programmed speed once
+ * a Device appears.
+ *
+ * Return:
+ * * 0		- on success
+ * * -EINVAL	- @speed_req is not a PCIe Link Speed
+ * * -ENODEV	- @port is not controllable
+ */
+int pcie_set_target_speed_no_retrain(struct pci_dev *port,
+				     enum pci_bus_speed speed_req)
+{
+	return __pcie_set_target_speed(port, speed_req, false, false);
+}
+
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
 	struct pci_dev *port = srv->port;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f..efb6d2d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -115,9 +115,24 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 			goto err;
 	}
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
+
+		/*
+		 * With no Link partner the retraining can never complete and
+		 * each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  Program the
+		 * Target Link Speed and skip the retraining; the Link trains at
+		 * that speed once a Device shows up.
+		 */
+		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
+			ret = pcie_set_target_speed_no_retrain(dev, speed_cap);
+			if (!ret)
+				ret = -ENOTTY;	/* nothing was retrained */
+			return ret;
+		}
+
 		ret = pcie_set_target_speed(dev, speed_cap, false);
 		if (ret)
 			goto err;
-- 
2.55.0

