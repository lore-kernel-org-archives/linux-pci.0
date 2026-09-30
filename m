Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48D51EE1C
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777988; cv=none; b=ZKKiaZ6e6NtQRkDFd7wIQkaDehCH30zg/RM68TYUuindt4KZkdFlzsAuqT7m/vZurMXp0NqVcC5SHMrr4CXQrZqXIqYb4niLiVLIVuPG+KEPeNACEgBE7zNL3WaP9HBBIIhhYIqHuwiBj09F9hRAOIU7tRFaa1Bu4vuJmoD5Mkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777988; c=relaxed/simple;
	bh=yUHWtEgkE8SNdRJwGODRT7SvV8pdrTHVh0q86Pd+8t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2fBvFlUT5nflwAioCUwl9TdHS1nFe1+EG5NT0BikPokF1FvDWFVfKjOZE1AYNFqLpY5SyyDfkchw9P3Y4/OJkuzmet7SD0TXao161dRAV7XkyNJ5Q+XezmfBy1IoYz3tpejV017DAGRkKpFBvyexLMu7DskzrjXpZvMl50Voys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz/S4dbV; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz/S4dbV"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ac5b4011a4so3299665137.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777971; x=1791382771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z73kz9yWTyFv6L75BByVAffIP7W5SI44w1Nri5Q0shQ=;
        b=Rz/S4dbVqyVTUhyaZhYRKj38uBPCT5DMZ3zo17MG+jy5YANP9w/djTL0lH/D70zU5T
         0zZLYkkXWKq0la9pYs91X5Lne+9dabNB1a8sAqPfW3UHk4X8sGS//zjaJeGwI5KCHL8a
         EG87gIiaNj+RXvCJOoWvzFIsePiE/kJCMt4826t5PaeoWsRehnYTd5Q+EMxoYivN2qqG
         DEKdcCphAQkslTHw+gCh20ZDTY8Uv2wR60+MZ0rA06k+yM/sh9O667F0S7z8szEoYCyj
         H33LgmIwm3WajgKpT4bKduvmytB9SPk0GKWkHhHUT6Y/pu5+nX0GWPMLqS83A/JezsMO
         diFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777971; x=1791382771;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z73kz9yWTyFv6L75BByVAffIP7W5SI44w1Nri5Q0shQ=;
        b=c0dFiowAqKMj6cDOXYRKg9mF6DarPpWqWCs6bOvN522ZjO2d9rYcC3SBzzY97qoW1t
         tyV7TaUu7L2v8iIqTgHTD2/vlJG8mxKuOjgRf7Q6I2HrMzEKMmUGcSiqpHpR4e00hvym
         ESNhtLRhXN4KjydqXlmey9c7TCRwWFynMeae/+phfS1jRFFwsWNc79VSlZWhTdwIBNtI
         U6PHzziHLBCNR67EMMJC6t5euCB8D43M8RjeHoJOACRbvZqqSCHOaRTnTrJBZ7PwRYuh
         5eqErZvP59Q4LV1PH0Q5TXS7Wg5CCP5UjOedPJj9g8d+y+rgF1XilQOBDtkZFIwXXmWV
         tyqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxefANEDYDTsaQbAZ4dQVPr2cxP9CHuprDQG/QgGoMUTAVZjUJeAa9ZSY9NPKX3IX151TrXyGQD+BE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI57dYRseozgoOE0kgP04dMapQ+zXUSDLOlCG0Z83vl28D42oLN
	4vcIoesyiiEpRSwuJlnuSGNJg7FIeeQfJKdn6Xq8KPuzygKH5Cfd03cr5mgUUg==
X-Gm-Gg: AYBFou0QF2W7lrlPy21NWksMk/fMvmptjAvBiXKYycG73kt6xAClLoXNPGv6p7DuH+R
	eHnAJX+aLv5bHXwedWQBeN+2sMPKttCBP9eJuRRnPQG5UEfPCSIB7TxrwKodUIRIqKkL871Lnib
	NnufJAUizh94RXL9LfTi/3WT94CRyjIE3QLat7n4hLzHVRXHUWUr5pm7KBEecIqFApt7CmaSrYd
	nd1PQnpuUzxl/5nJondNerhu3HujDu1j4vlXKzTDWJlUytIRWfX7bpQJYIbjdn1rG8TNg24iMTy
	3BwiGkGhKsS07RG3GiW9LAw+LvzkeRFHgnIrt5EYFooCI9zkyQL9dJi2MvapmPx3xaAb1WcO6pT
	FES4Au1i3jXY3b7IVrnR3kkx7izEFZMLrDRpcUwnmuHveLbYQZdUrZVUaIvdE9g+pD9df40hNTm
	xodLe7US4exYr9hsEVjuAMt6rZxKsOTnsbAJf+VW/Lan4j54whUPjYeicVO9JZHIUHbqqEu3UyF
	Re5B1R6
X-Received: by 2002:a05:6102:cca:b0:7b4:b196:f632 with SMTP id ada2fe7eead31-7be73c89aa8mr401228137.30.1790777970958;
        Wed, 30 Sep 2026 07:19:30 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-988d909c4cbsm1793220241.1.2026.09.30.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:19:30 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] usb: hcd-pci: Honour pci_save_state() failure
Date: Wed, 30 Sep 2026 11:19:12 -0300
Message-ID: <20260930141914.6678-2-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
References: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hcd_pci_suspend_noirq() ignores the return value of pci_save_state() and
goes on to pci_prepare_to_sleep().

The next patch makes pci_save_state() fail, without marking the state as
saved, when the config space of the device is not accessible.  For such
a controller pci_prepare_to_sleep() does not work either:
pci_set_low_power_state() reads the PM control register as all ones and
marks the device D3cold.  pci_pm_suspend_noirq() then finds a device
whose power state changed without its state being saved, and warns.
With an earlier version of the next patch on a MacBookPro14,3, whose
Thunderbolt xHCI controllers can be inaccessible at this point:

  xhci_hcd 0000:7d:00.0: PCI PM: State of device not saved by hcd_pci_suspend_noirq+0x0/0x180
  WARNING: CPU: 7 PID: 96793 at drivers/pci/pci-driver.c:888 pci_pm_suspend_noirq+0x2f4/0x300

Check the return value and, if the state could not be saved, return 0
without putting the controller into a low-power state.  The PCI core
then handles it as it handles a driver without a suspend_noirq callback:
it tries to save the state and to put the device into a low-power state
itself, which fails in the same way, but without the warning, as the
power state did not change inside the driver callback.

Move the check that disables wakeup for a dead root hub ahead of it, so
that it is not skipped.

Today pci_save_state() only fails if a capability save buffer is missing
or the VC state cannot be saved.  In that case the controller is now left
in D0 instead of being put into a low-power state with an incomplete
saved state.

Assisted-by: LLM
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
v2:
- Rewrote the commit message: the failure handled here comes from the
  next patch, not from pci_save_state() as it is today.
- Disable wakeup for a dead root hub before the early return.
- Dropped Alan's Acked-by because of both changes.

 drivers/usb/core/hcd-pci.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index cd2234759..7f8a56425 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -541,8 +541,6 @@ static int hcd_pci_suspend_noirq(struct device *dev)
 	if (retval)
 		return retval;
 
-	pci_save_state(pci_dev);
-
 	/* If the root hub is dead rather than suspended, disallow remote
 	 * wakeup.  usb_hc_died() should ensure that both hosts are marked as
 	 * dying, so we only need to check the primary roothub.
@@ -551,6 +549,19 @@ static int hcd_pci_suspend_noirq(struct device *dev)
 		device_set_wakeup_enable(dev, 0);
 	dev_dbg(dev, "wakeup: %d\n", device_may_wakeup(dev));
 
+	/*
+	 * If the state could not be saved, most likely because the controller
+	 * is no longer accessible, putting it into a low-power state would
+	 * fail as well and leave it marked as D3cold, and the PCI core would
+	 * then warn that its state was not saved.  Leave it to the PCI core
+	 * instead, as for a driver without a suspend_noirq callback.
+	 */
+	retval = pci_save_state(pci_dev);
+	if (retval) {
+		dev_dbg(dev, "--> not suspending, state not saved\n");
+		return 0;
+	}
+
 	/* Possibly enable remote wakeup,
 	 * choose the appropriate low-power state, and go to that state.
 	 */
