Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E23C13F2
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776979425; cv=none; b=Zl+k0PajiBWxcFLiTaU6Q5DkX54kESUFhlbgSWiuK7roD5F4LdooUboLCKAaz041O4hGTy3NDffAAfd1k0VupHc+BpzSIrYameDx4VzNKnUYDUxZnyxSpRzFlYDzDz3O8neb/G4ta5vod3HrewooLIhJzd+aP3D0D3YagYiR3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776979425; c=relaxed/simple;
	bh=Oe8MwOihG5BzjH99EK3y2Iy4j4M/3j0maoUzCe5H9s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hIrcHQI9mQiKcwPZGhGotVhxF91uJhnYnZX9ObBiA+8XPdvlJu0Gz2q2I4RpjtHwgI969idRj9KhoKqHPPyxYbF2V/sO9LNBFgKOUnXT4O96ucmu/yX5Rfv272QDso0ikmi7hiPatSIWG0agaKASLQX140LSY10I2o6lUfLez8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6Yg/35I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6Yg/35I"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adef9d486bso65247445ad.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776979418; x=1777584218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=;
        b=S6Yg/35I+BOb4hlpM7fzMitlnY4VsnIm8RupHp0/S0Bs1Bi9GhkNJoPAuow9rzY+vH
         ustao6je+FQe+CEwUTr/JgUaCeehxRbwLbaVcupthpdSpZ4L7kOgB0UTvQvU5etRR3HD
         QCsLDtGOo1VZs8zLzhUlPdHdPb1ZnbqF59ZDdaYRnQ8Iaa7TT7t/ZPAkjoVqxbSrPbaH
         oyCaNehedELWVERJ+buwkQvhjc5g4shwm4F3SHsZ/z/RPjcn778jZ6amThx8037XTcGD
         wQrcfJUCLw8Ej5pzHTOhkTLs+9H/Rwet4hCqtrsK+HFlyKW24P2T2BzKgGGYE++mGss+
         uQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776979418; x=1777584218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDSmr3KzvFf45fqXLLacm4Nig+LS/n/kl38OHtIvfGo=;
        b=bPmcYcP+v/X7g+0MXCYjLQDHe4yVS7gYpEwvm6wiqzZ6xYfDnp3GYc5nDtSO6WvDKD
         NHxDQrr42AD/4FB/7LyxQAyRN7XvuE0nFlNdTOH3661pVpYAtPBEGv5gGCAdRjJebVTC
         qOOTTRIPyAYzKg44WRBZPLlBLn4DlG8Eigq8FeJKn1UMrnmeSUd6gJQNiVhk0geVggWY
         E83jjB14x6UBfnifKbECG3HUv9kSLMFOgTyetXhagWUSJVo0MoGzZ9HawOUFd5/OItQ8
         2FgCwW7j9i6NWo9Vn73jY3vIQuAIfKu0xCvi+5vPMhlLrAP4VYLRmygt09z9A3rz3Rph
         DOwA==
X-Forwarded-Encrypted: i=1; AFNElJ9iIZ7iQGA+7H5Vc/ddvpkneaJ/ttSn+8sWkIHB/FYTrgjPHIjw+FPW5BkiXHquUMRsPaDeXM7CtJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuY1E1L7fgfgN+vYIAafSsxqAdQE+GUNcYnL9JBZ395nvzF38F
	YQD6WW54KFnrIb7MmVscZjaJmOIQlwBZbLdCWZDe7N9Mx9aJMC6dVVkD+aERZnb9wCQEXMuEIDa
	MegbA6pmaR6VSdw==
X-Received: from plov1.prod.google.com ([2002:a17:902:8d81:b0:2ae:c54f:d5ad])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ba94:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b5f9f83342mr210260195ad.38.1776979417788;
 Thu, 23 Apr 2026 14:23:37 -0700 (PDT)
Date: Thu, 23 Apr 2026 21:23:14 +0000
In-Reply-To: <20260423212316.3431746-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423212316.3431746-11-dmatlack@google.com>
Subject: [PATCH v4 10/11] PCI: liveupdate: Do not disable bus mastering on
 preserved devices during kexec
From: David Matlack <dmatlack@google.com>
To: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Do not disable bus mastering on outgoing preserved devices during
pci_device_shutdown() for kexec.

Preserved devices must be allowed to perform memory transactions during
a Live Update to minimize downtime and ensure continuous operation.
Clearing the bus mastering bit would prevent these devices from issuing
any memory requests while the new kernel boots.

Because bridges upstream of preserved endpoint devices are also
automatically preserved, this change also avoids clearing bus mastering
on them. This is critical because clearing bus mastering on an upstream
bridge prevents the bridge from forwarding memory requests upstream (i.e.
it would prevent the endpoint device from accessing system RAM and doing
peer-to-peer transactions with devices not downstream of the bridge).

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c |  4 ++++
 drivers/pci/pci-driver.c | 31 ++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 25c86cd4c173..2a4a139623a6 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -132,6 +132,10 @@
  *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
  *    preserved devices to ensure that all preserved devices on the bridge's
  *    secondary bus are addressable after the Live Update.
+ *
+ *  * The PCI core does not disable bus mastering on outoing preserved devices
+ *    during kexec. This allows preserved devices to issue memory transactions
+ *    throughout the Live Update.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..05584bc76332 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -531,6 +531,27 @@ static void pci_device_remove(struct device *dev)
 	pci_dev_put(pci_dev);
 }
 
+/*
+ * Disable bus mastering on the device so that it does not perform memory
+ * transactions during kexec.
+ *
+ * Don't touch devices that are being preserved across kexec for Live
+ * Update or that are in D3cold or unknown states.
+ */
+static void pci_clear_master_for_shutdown(struct pci_dev *pci_dev)
+{
+	if (!kexec_in_progress)
+		return;
+
+	if (pci_liveupdate_outgoing(pci_dev))
+		return;
+
+	if (pci_dev->current_state > PCI_D3hot)
+		return;
+
+	pci_clear_master(pci_dev);
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -541,15 +562,7 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
-	/*
-	 * If this is a kexec reboot, turn off Bus Master bit on the
-	 * device to tell it to not continue to do DMA. Don't touch
-	 * devices in D3cold or unknown states.
-	 * If it is not a kexec reboot, firmware will hit the PCI
-	 * devices with big hammer and stop their DMA any way.
-	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
-		pci_clear_master(pci_dev);
+	pci_clear_master_for_shutdown(pci_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

