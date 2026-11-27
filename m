Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754701;
	b=NOw4eEdwAv54SA4LyF8aNuO7ML018cKm5vFpqwBoQ2HrRnslfEPofZuWLFRuWnjDKYS9
	 /4WLbi5Et80JJ7i9f29MGPBNzpRXAakp6F8rXFXtri4CI6lmfuYp/3bNxl876EM2pmbsy
	 RqXVpYRggfTMA9LCh4J0q+zeD1c2jh8Pe2Xdn3povWy59qaKntS0bgSwk3d3s+624/aVw
	 TYzzWMLkNpD0yvQgfMKMD9TGMKwgJBl9Jodl00a79bkSE/s4eLigrjNcSaAlPwBrVeWmf
	 VtQy9CSQTGEZm0+c6dWtzE+d4BdJSUXi+Jp83LSoCNJjQjrUaG+Mh0zGOr1RDd8zSiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=up2JUVBVe7IxMJqAJpnFfm9YSUDx0gfYrWA7gUrFC20=;
	b=KMntYGhnH7r58lY1TS5pdE2+BukqyclSZT+UxhdfWfrs1uzkGbP8L8b/I3JQv0fctqUF
	 qSrYt2UVLMqlf2+TNJ+YLBaWcR8l8/AEPxxwU41BCNoQkUQrZkBg+wnpNYhFeyJN11i0O
	 LzuTf0NpML70zTKprFoi7YAkeUndzrcEvJqFlInUIgl5gWXmzdht/ceqARAyI9UQJrMs3
	 JEbjLXsNkxRljyp6O+eblqjWtkllml/zvX4XldwrYk6oDrG4QPXEiCHAGfnntJ+nQYy5C
	 dHnMmm6ziZduFbUJWqFaXgHPHUb8suR9xBT6Zb28EX0GHMz3UUd1NGrzb2Q6vOzaj3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O5Bz3vNk;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D95606A321
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 04:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68D95606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O5Bz3vNk
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd66551e02cso6964809a12.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 20:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795754701; x=1796359501; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=up2JUVBVe7IxMJqAJpnFfm9YSUDx0gfYrWA7gUrFC20=;
        b=O5Bz3vNkQhd/sRzDiaSbLoeBk9Qm9UZFhKjlP0p0uS5g0CknVx4S/Zmw+RnfRQv7lm
         3xXs4JZxv/nLBoFeNwIqyjm2GnV78olgulj5mRshrWiuyVvDfWU5vqSX+I6vXqvuZE++
         wg/pEV+BjkTMBU6qkRuciObZmzK/IrIPo/PYsy3yFqASF7jU37Qk3m7pkAgAP32jApP0
         IB1Dt9wIhprQk3hlWixTG+Dai6qg/Bb8N3LI1Qci0E1Q2WvZ4yFSzwrHEQLVrfE6V8CH
         frM0FZbeYcmvc/AyvPH6VDcLjDtjKKtgmtDdp2hJLhvpnQV3ftPKt17bzGFjUxDMJkva
         Jh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754701; x=1796359501;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=up2JUVBVe7IxMJqAJpnFfm9YSUDx0gfYrWA7gUrFC20=;
        b=lyHxn0dMHYZu8CnwjKxR9SM58DDZ0dR7QIu3zH2bI05UpVGm1dAvsmo0nZZgeidmCN
         ClfgGh6011S4E36getUgphyfbX7CSQ/nK/dEYeL68MnsG2l2dfZ6SCI1HXpQ8vV1ECuH
         BAwOh6oUrjLC9Q1/yc9AeyoUqPCDMOul4GrEjR0iqGSWaDxvp0O21EHUCjkWydmrgPCF
         9dT4XcwoWRGnMmZPXQFtVFOhMoOkUwKlqZhEFJzVBbnqX3iKvNz7N/G2xNEjHaEgm7qB
         p3kf3tpykGkElabivtO85q1L/iOrMkMRouE2x3Bf0f8eNIljJ1UBNPEEBTOZktDHTdLs
         v8Aw==
X-Forwarded-Encrypted: i=1; AL+hErH5xD5DmzUxdmOfl+Dj/f8SkuwbEFA8LXJxSOutVgRG3bmFyz6Ca1azv9a/WDblIv1t11zIsz0ad7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4R3OjORkyJrNeULOwef5XgLVHQbLywJfe+6oN7bAa61gGw/Hr
	VRCzTh0zEMQabk3FBFwpxlyaRck8Z39oYJiqFkcrio/onBeSL90K+iW1S/9Rr9P4rNdoz6hf0L7
	uSxkaPJtR2Ci5Rw==
X-Received: from pjbpc5.prod.google.com ([2002:a17:90b:3b85:b0:3b5:361e:87b9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e8c:b0:3b3:b373:6a6a with SMTP id 98e67ed59e1d1-3b41c9e45c3mr23219110a91.28.1795754700474;
 Thu, 26 Nov 2026 20:45:00 -0800 (PST)
Date: Fri, 27 Nov 2026 04:44:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127044458.2757857-1-skhawaja@google.com>
Subject: [PATCH] PCI: Don't reset a VF through its hotplug slot
From: Samiullah Khawaja <skhawaja@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pci_dev_reset_slot_function() doesn't do a slot reset of a multifunction
device, because the reset would also reset the other functions. A VF is
not marked as multifunction, so this check doesn't catch it.

A VF on the same bus as its PF gets the PF's hotplug slot, so behind a
pciehp port the VF has the "bus" reset method. A slot reset of the VF
also resets the PF and all other VFs, and only the VF's state is
restored afterwards.

Fixes: 10791141a6cf ("PCI: Simplify pci_dev_reset_slot_function()")
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
Tested in QEMU with an igb PF behind a pciehp root port, bound to
vfio-pci with two VFs. Without this patch the VFs have "flr bus" in
reset_method, and a bus reset of one VF also resets the PF and the other
VF. With it the VFs only have "flr".
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..16e970d26b51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4994,7 +4994,8 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 {
 	if (dev->subordinate || !dev->slot ||
 	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
-	    (dev->multifunction && !dev->slot->per_func_slot))
+	    ((dev->multifunction || dev->is_virtfn) &&
+	     !dev->slot->per_func_slot))
 		return -ENOTTY;
 
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.1.839.g22a8290db9-goog

