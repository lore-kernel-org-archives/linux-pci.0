Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09047987F
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276640; cv=none; b=PdLZ4H6vcn/OK5hxPYMKJAI117B+SKrzRMfKVmxazYNaaFMnGQ6szDn5LcTchAY8DwF8gGOUSmjKFt+XU50L2YuRabMdi2rhQBQ95t2cnnQd87HOJZfNY2wPYGg81QnjGZY8FKmQN/YpVh0GTN7yDHaXCWy9dRNGMnbtVL3svk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276640; c=relaxed/simple;
	bh=Id2EXN7u2JnUsjGrJCRWIUKTzOIUMuw+FP7kXvrtnNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJyygvZjLvMqRSsmHLgTcDtC/Igc8QxlxWpuPCY/YyO823UanEXPRGv3ZCCj1ypyWQp4/WdC4K4TQ+lEoXMPieDxCrk+zzyd6GPCHGHXOLUjGVPxQRaEyNvcZuM+3GFbpVMK6xIHpUGGlOs/z6A0GVS77/ApkSo9xvhn4fA4I3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRCnojzg; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRCnojzg"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c860544c077so462458a12.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785276630; x=1785881430; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kK9fmvYx94bqGyeMgzsYcbMKuj2faWTY3fQuvgNhZiw=;
        b=dRCnojzgIDKPrUZUb36s/nqtCtg/XYVHuwMDW6N1zz2WK866dkOkDVZIfgrfTiK4PC
         /5LiL9YsdwxeyDewRtyOHZ8rir5ZqhWb7YXMUcAqQ2jzkxHZ/0eKryTsCIAkrEJoSZz1
         asNC3zafr3wFITPIfDhNCcUOClJPAygW8Am0z42jbKcP4LFOlT/tzw2lA4tpBokiya0p
         ZXznd0prnqxeSFL/TE7K/nZmV+MrTqhAG1A7Qc9fhTTWRNsxUul7QZYG25vZwsHc5HuQ
         4oYtwpYKDcUreWsG/hzSXbNlHew1kd75CE6ksitCcbCX3VGISSIJDvTTa3ZA51y5FsU/
         n4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276630; x=1785881430;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kK9fmvYx94bqGyeMgzsYcbMKuj2faWTY3fQuvgNhZiw=;
        b=DnMv9FA85kr3NJ2CDtg4bH4A/t5MspsFD6zfghQ9SnfS+9dTr+F5gLHZZuiQTTBZ6e
         0Lspb8I7lDpA5Pwm7oJ0hb2lPNj4oaG4wVtFq1dowGxr7s1F/CzMleLORa1F32B3l7zn
         21543HBYS5cAEpTutJbca1qpkHxTM+4vTXyO4qqiM1MnwvulGpMkKNtgqhplGchwyYDM
         wxODyu8FINxAABgpazPmmpUevsNQAqvuvAxULR8l1y/QyxaG1Wu9SQ8JZAUxH5BpNmx3
         11bqJJU78aj7y4L+3StpnWelGGp0e/1Ov6cd0uoxMd5Sk9CcQFWOqFcvf3yDFaZzQ/zb
         75bA==
X-Forwarded-Encrypted: i=1; AHgh+RroA7NBsYrRyoSzBPL9PjE4s1G+qzGsAsJv4kPpovfUOIN+/w2ojlkAW5xBLY4RzQPxOZh64ZpQq1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdvjEVr/6ue68yd6IYSbpFtjreD0A00RvABS6apxub7O+wIY1
	vYLufZ3vuH8uihE8FqgPy9FlQcO5kqfbmMMzp/JXmZpwmAcT/h0JVA9DR7OhuvaMxtk5MYtPwN6
	CG5Jw/N+MnL2u9w==
X-Received: from pfik11.prod.google.com ([2002:aa7:820b:0:b0:84e:40d2:2e74])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:39a9:b0:845:3914:f039 with SMTP id d2e1a72fcca58-84e93203c18mr4669411b3a.26.1785276630227;
 Tue, 28 Jul 2026 15:10:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:10:05 +0000
In-Reply-To: <20260728221007.2098560-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728221007.2098560-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728221007.2098560-12-dmatlack@google.com>
Subject: [PATCH v8 11/12] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Do not disable bus mastering on outgoing preserved devices during
pci_device_shutdown() for kexec.

Preserved devices must be allowed to perform memory transactions during
a Live Update to ensure continuous operation.  Clearing the bus
mastering bit would prevent these devices from issuing any memory
requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. This is critical because clearing bus mastering on an upstream
bridge prevents the bridge from forwarding memory requests upstream (i.e.
it would prevent the endpoint device from accessing system RAM and doing
peer-to-peer transactions with devices not downstream of the bridge).

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 11 +++++++++++
 drivers/pci/liveupdate.h |  6 ++++++
 drivers/pci/pci-driver.c |  7 +++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 65bcecb1b64e..32b73ebf71f7 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *  * The PCI core adopts ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outgoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
@@ -879,6 +883,13 @@ int pci_liveupdate_adopt_ari(struct pci_dev *dev)
 	return 0;
 }
 
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	guard(rwsem_read)(&pci_liveupdate.rwsem);
+	pci_WARN_ONCE(dev, !dev->liveupdate.frozen, "Preservation status is unstable!\n");
+	return dev->liveupdate.outgoing;
+}
+
 /**
  * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
  * @dev: The PCI device to check
diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
index 49d07fd02132..9c31fb60207d 100644
--- a/drivers/pci/liveupdate.h
+++ b/drivers/pci/liveupdate.h
@@ -20,6 +20,7 @@ void pci_liveupdate_scan_bridge_end(struct pci_dev *dev);
 void pci_liveupdate_cache_adopted_acs_controls(struct pci_dev *dev);
 int pci_liveupdate_enable_adopted_acs_controls(struct pci_dev *dev);
 int pci_liveupdate_adopt_ari(struct pci_dev *dev);
+bool pci_liveupdate_is_outgoing(struct pci_dev *dev);
 #else
 static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
 {
@@ -55,6 +56,11 @@ static inline int pci_liveupdate_adopt_ari(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+
+static inline bool pci_liveupdate_is_outgoing(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_LIVEUPDATE_H */
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 51616e4327d3..47cb3dcaa927 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -546,11 +546,14 @@ static void pci_device_shutdown(struct device *dev)
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
+	 * devices being preserved for Live Update or in D3cold or
+	 * unknown states.
+	 *
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
+	if (kexec_in_progress && !pci_liveupdate_is_outgoing(pci_dev) &&
+	    pci_dev->current_state <= PCI_D3hot)
 		pci_clear_master(pci_dev);
 }
 
-- 
2.55.0.487.gaf234c4eb3-goog

