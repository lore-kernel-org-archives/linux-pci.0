Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9BF5326C7
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271317; cv=none; b=gmihtL30dHNeF4XpBxT7juuDBeRtcjoIADMtF3yek/YCYI/kdL4HiXlbmnnntSxzG8UTX4bPeUa5xTmBt0SupYugiJdhiqwSggFafMc/vuwRJ6dRMM1CC7gtWOHQPK7N8Zttx4cOnnuIVX/qGjwJECwmbNr7kzAGt2AHgXZoNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271317; c=relaxed/simple;
	bh=42HZykLu1fdko6HtVS6V2zN5Rp/brQ1pPyYBjphQlKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iPGJ2qlktorBME46C91QwcfrWlOOwgzm6cIa1QnHShhkvpHevHVPNsu1mOx9Ao2ffCa94OwOHv4Wzcw9kpUltNBhvJRv3eWT3sX1KRh7qZPa04BxcaHGw3VDsv9FuLEmVU6k419PBjHh+UAtJSlRNkltLrNFx7qAA5h+h5b+XrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVY5viZv; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVY5viZv"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc51591102fso11880a12.1
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271313; x=1790876113; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44zkx5wXiPoFVTiEc5KY1Ag9ipCGGabDIfpXco19T3Q=;
        b=fVY5viZvNJwhWXTGOvhQqZPhuMIVibY1HUZyTgTCn/bi5pQPvRCg4IVoMxhM9zo+1E
         sNCdQ3rQijRAvaTA/VmP0YyLaWTuY0kJA8wdXflLEWZX52nep1UnGXl4FOLauz8oDyRn
         7/cPlfd2dc0tKGxyH5v3BkKt8gS7hmdTEfoxTpcQTovGja9MgA3zotyRgjK82FgEDBI7
         VgDTDTI1RwwNkuLzgFmIY84I4nSEa8a9JRgZmO9zkAMAaQA0oQztosE1fu5YUK4LKejj
         /RKNdDSRihCB5Q3hhecW36Svm3kUsgTyD6g9UOOIl4UJK1jVQ/+eRVb/6ugC68HM0N+9
         jQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271313; x=1790876113;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44zkx5wXiPoFVTiEc5KY1Ag9ipCGGabDIfpXco19T3Q=;
        b=YHT6i3gydhyr+a14z+x/UTiurYQ3epF/ggaUcZ6GpGOIyWabOVhVgEHRW4U/f0xvrm
         99gcGmofPMTqGes6aNh41SmRjKuOiZtHKzZkra+WKww85mDwttffFolNN8EJVNWsSFCb
         xZRAOzBPkdp0rfhzLdG/2bzs2cv0KStEJyOXql6NnGUodrimtLZzNzI/oS5Z7EuueR/k
         Qk3fHWR2T7adyRL3FFyERH70zvZpEKjDqoJQIYFTdN3RaZKZP0l2/qTA9mj+pm0RpdYv
         fxO1McJavf0S+fv00Dib20NnryLa3orJ5wuzVWSWJf6uo0knzPWEO0kJ9QbFQ34J+Dm8
         DqMw==
X-Forwarded-Encrypted: i=1; AKwUvBzSBl7PxrVDByKndmiWuAIIEfWRRi4nDzMZ3IDGeCUI+1V4I6Zat/Cdq5hxhMhAvZ8xTO/uTzKvNoI=@vger.kernel.org
X-Gm-Message-State: AFuF++lgxf5epyESmNhcnw+P3jiayyPb7D7ZRzd4alBeU9bERNUXcSSk
	Q9pl5N7tPVsUmDcc0yVPSp05maBzx6hVgM/5/3IHxQUEX7ZWxIp4kz4E7JVIOMAHazhhxu5fDpX
	D81CunrRCqo2Fzw==
X-Received: from pgbfq21.prod.google.com ([2002:a05:6a02:2995:b0:c88:e5cb:265])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:3d09:b0:3dd:a196:906f with SMTP id adf61e73a8af0-3de0e942ae3mr2935846637.57.1790271312798;
 Thu, 24 Sep 2026 10:35:12 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:52 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-7-dmatlack@google.com>
Subject: [PATCH 06/15] PCI/ASPM: Save LTR state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Save and restore the LTR maximum latency registers through the per-device
saved capability store instead of a private pci_cap_saved_state buffer.

Reserve the DWORD by its configuration space offset during device setup,
and keep accessing the registers a DWORD at a time because some devices
only support DWORD access to them.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c       | 12 ++++++++----
 drivers/pci/pcie/aspm.c | 19 +++----------------
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e49806c6891..e53bca1cb50f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3580,10 +3580,14 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 			pci_err(dev, "unable to reserve PCI-X save state\n");
 	}
 
-	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
-					    2 * sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (pos) {
+		unsigned int off = pos + PCI_LTR_MAX_SNOOP_LAT;
+
+		error = pci_reserve_saved_cap(dev, off, sizeof(u32));
+		if (error)
+			pci_err(dev, "unable to reserve LTR save state\n");
+	}
 
 	pci_allocate_vc_save_buffers(dev);
 }
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 02922b887ec6..16f22af98686 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -30,8 +30,6 @@
 void pci_save_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -40,31 +38,20 @@ void pci_save_ltr_state(struct pci_dev *dev)
 	if (!ltr)
 		return;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state) {
-		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
-		return;
-	}
-
 	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
+	pci_save_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
 }
 
 void pci_restore_ltr_state(struct pci_dev *dev)
 {
-	struct pci_cap_saved_state *save_state;
 	int ltr;
-	u32 *cap;
 
-	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
 	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
-	if (!save_state || !ltr)
+	if (!ltr)
 		return;
 
 	/* Some broken devices only support dword access to LTR */
-	cap = &save_state->cap.data[0];
-	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
+	pci_restore_cap_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT);
 }
 
 void pci_configure_aspm_l1ss(struct pci_dev *pdev)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

