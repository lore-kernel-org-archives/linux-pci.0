Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33934368D73
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785576303; cv=none; b=liApe0dCisiFhTzULUSLWO7XmXK4GQtHkiM0UG/XzYFORmbG2FWahBO3R98AdTLOGQ8jPGz+Mr1AiIOmUzOw/qyddQDEjPsFCgD6AFDi9WFK/pu3V6cxSkUthCRUOnOtYos2Fs1jfFG42Dnwcv27WEmJT5n9OSofOJyVqLdYrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785576303; c=relaxed/simple;
	bh=mJjUtuM5cGLdT5datkeMIEvC997MtJfDQ7lz1Ivbc5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjF86uFgl8U0Fha80vcouaB7SeqRuS2c7/g79iWbd+jGEIrmY+rvHY7Iyo1DHItL3M3dnFo2TJeV5jyxziIuIFcggUvUGqc9KJgozpzliYqXVvRBVJhUFViQI6d3jOSVU1gZMTbDG9NEYjzXXt7Sz1Ca/9M3MDfX/WiU8SjM+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezqWuCil; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezqWuCil"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954aff6088so3842605e9.3
        for <linux-pci@vger.kernel.org>; Sat, 01 Aug 2026 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785576300; x=1786181100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul9RTm+ZX8TYQuR5IepFoZ94EUaI8VfjEMwkK4fYVBE=;
        b=ezqWuCilot+A1liaIE3GeKjDreDMKNqBeACyKunJl3aLEc7NsM5oQSjTU62qJEeXt/
         7PALP7m1AllU+dhW96KaOG+dbvXRmVwW+uiuRFru/lMTNzYt1/7NqwC6g0No3mvCUn50
         UaKYmX5ZmHk5fblswBAnaOWcEaj38nHqwSMGAj1sdS9gJ7A/Q33fDqeoSINwwRLhkdvv
         TeBbnlJV60joHmnr/3HwdbCF7jAcQLJOWGpgJXFZTmTz2AVK8jbIDfi5LoJugUa7GNQv
         1Igo1SD05ZlgnYU93zNHdcI6OGoUbodx2UIhDlqxqd1a7N/nLRSQz/yPNgut5YuwatW7
         oiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785576300; x=1786181100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul9RTm+ZX8TYQuR5IepFoZ94EUaI8VfjEMwkK4fYVBE=;
        b=EyKmcJ5kaFwYh7qDMoIUqPMl0dSDNIHcsq67qPsRNnS6MZzAyGjEb2WNMR7PmOADjs
         svJEdaQnjbZ4HupQQ72WMf/u41hkBRIlqj8NqDpIqz8GC3Gfcr8fQliJx1lZ+juPCxrD
         rGgj55dGippOfGHWSg7NEIM4LM8aLbHBoPByv9JDPet7ho3JIGgcTJTd8Rqcvjp8TYMD
         JDQ4xkaEF/jZK7rjoV7DlWAlosnaHSGj5miuSCvAYofMzkeh5IxZpJtRoNO85R9LSiQ0
         9Wu4Te0muVjbvn9UHrTuE4ku2LH2nYz/u90uO9P//nj8opjpwMd5megkQ/DsfENs9iuq
         T71g==
X-Gm-Message-State: AOJu0YyuEKTYyatjr22q4h3c0VmtOr8p+dJdbmcJYwUkBy3jFZCGOjgC
	AQg/mvQxq8ls5TYt/NxOx/9VOwgEX/8TiVA3ljpqsJ2L85UhEgoHdUlTmWEV1h2PfCY=
X-Gm-Gg: AR+sD10EtDUDo1eAaSwjgbKNuZLFWBOEs83NhDQm0GeNuPOR8prAxCL4L+STmaN9rXD
	4NCxDGTp8WKqrH0J2+Lkj1Hnh1J1SdsSVATIVBYpIPhnO/phZsfeza4SkFLNQV5AYFJIW1Ad/5j
	3wvHVSwLxWB2l4P3NA2o2plW2HuIoXBiFQIqcQ02JlAs2XUOp+rSzUs3gncul0SIG5cSGa/aM3b
	TeGyb+6Ey7foe1jOn3kkeouWqfd1icYgUNNXKE24JlRtKaQ9uAYAxXS9Nd6JHsyVvv39pgLl2F7
	C7II8gg1C4snmqJHSokPxqoxgG7OZ3mx20xAGLpeQwTu5rJZHDz680iQUa/6Hpic6ujbcyi1pH3
	7aw3MZAr9A2RPNY5vvcu2ZbaCwmwb13mu9YTDaAyxCFYw4+YSQnEpTL2xOZmBhyzF2xf2v1n3OF
	g2fKqjlmUXWGkEm6aBerBB8126/hxIv02JRPZsX9qPrGWBSuVo7EKML6cKp/JlAzt3k4A6pC2Ii
	tE01INzeE/usrOwrG9i9hBnB64GoNGAy9+MLdbpc8MWiDjDFFs0JSG9y1RBkT74+zLbaUmNsP5v
	TOBj4Dgq3l9TW2MJRUsM
X-Received: by 2002:a05:600c:19cf:b0:496:bbce:fd with SMTP id 5b1f17b1804b1-4980c66c73amr35608955e9.6.1785576300244;
        Sat, 01 Aug 2026 02:25:00 -0700 (PDT)
Received: from corecachy.localdomain (p200300eca72356fc3569cec583d57196.dip0.t-ipconnect.de. [2003:ec:a723:56fc:3569:cec5:83d5:7196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a68sm27831105e9.4.2026.08.01.02.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:24:59 -0700 (PDT)
From: Andreas Wild <andiwild@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	macro@orcam.me.uk,
	linux-kernel@vger.kernel.org,
	Andreas Wild <andiwild@gmail.com>
Subject: [PATCH] PCI: Avoid link retraining on empty ports when lifting speed restriction
Date: Sat,  1 Aug 2026 11:21:33 +0200
Message-ID: <20260801092152.5643-1-andiwild@gmail.com>
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

Program the Target Link Speed directly when Data Link Layer Link Active
is clear, and skip the retraining.  The restriction is still lifted, so a
device plugged into the port later trains at the full speed the port
supports, which is what the original change set out to ensure.

The check cannot be hoisted down into pcie_bwctrl_change_speed(): the
ASM2824 workaround earlier in this function deliberately retrains a link
whose DLLLA is clear, and would break.

Measured on v7.2-rc5, same tree and same config with and without this
patch: the interval after the quirk logs drops from 1000 ms to 3 ms, the
second timeout disappears along with "retraining failed", and the systemd
"kernel" boot phase goes from 3.011 s to 1.024 s.  The restriction is
still lifted -- on the still-empty port afterwards:

 LnkCap:  Port #1, Speed 8GT/s, Width x1
 LnkSta:  Speed 2.5GT/s, Width x0
 LnkCtl2: Target Link Speed: 8GT/s

Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining")
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Wild <andiwild@gmail.com>
---
 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f..d0c8b09 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -97,6 +97,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	u16 lnksta, lnkctl2, oldlnkctl2;
 	enum pci_bus_speed speed_cap;
 	int ret = -ENOTTY;
+	u32 lnkcap;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -115,9 +116,25 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 			goto err;
 	}
 
+	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
+
+		/*
+		 * With no link partner the retraining can never complete and
+		 * every attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  Program
+		 * the Target Link Speed directly and skip the retraining; the
+		 * link will train at that speed once a device shows up.
+		 */
+		if (!(lnksta & PCI_EXP_LNKSTA_DLLLA)) {
+			pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+			pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL2,
+							   PCI_EXP_LNKCTL2_TLS,
+							   lnkcap & PCI_EXP_LNKCAP_SLS);
+			return ret;
+		}
+
 		ret = pcie_set_target_speed(dev, speed_cap, false);
 		if (ret)
 			goto err;
-- 
2.55.0

