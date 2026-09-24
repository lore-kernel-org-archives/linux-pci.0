Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1524C67F6
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271314; cv=none; b=a/Q1chLZ7bDRgmmG3qg9cPltvh8fEz36Qpmmf78FQ65Ij3uv08Ih5Qm+WeqyNtrtr1xpzEA8Y+Vkbr+X3z5cFfSaBu56wRyi9u2D8Xm6+coBxxTTugD2jv68RO01p1hb+7QtdliBpZ+QnJ6shhvNHMHj+eQ9nVlbayhCjzpQ5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271314; c=relaxed/simple;
	bh=CYhmyDM5d57uPrze7NCkI7zjat3dpf1yBYGQ+jpeKlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L3BTkZ3ogdY9S0lVAXYISNqYo0Az57xDeiMcMYa3/DLnV/VgcxhjHl7b4opuvar2h+osnv+/G1/tKp5U88hX1JrclyNpABM3Y1nbTR+h2aYZJtYZ3/ZsYU2PUf0BFB+c3c3kw2z7yLIJffST62OV+ffvjcTFXNJdyomZYI9Fbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3CyvU2L; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3CyvU2L"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8538a72b430so97374b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271311; x=1790876111; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACjFFHMgW+Gwh6CM6AIAcR2m9FJl/y1RH2aBBB5Bmwo=;
        b=Y3CyvU2LuGyI6jB69YM/nqNvu1Lt/9pTNlar2G4Auvs5/lr7zK+hRPhPY1KtnH/8OW
         U42WU00br29EMq0FhexrehjsAVuqZ3EUOtnMMXZ6t9thUtg5rHA/usux9XaGagh8Xw+4
         aQab3LctpcK3zDdpsZm1gf1rP3PLbsgt9t++Pj9Vqs+viFwa1i9YfkInp3yemuCb/6Zl
         0TLR85ilzEzHz5kfjd8GPXFfXletCczyEAn6wZ5zkW6qyZ7OE+HIm1Dk5LD2xG+1qB2n
         7isES7mJYwoyxwOynFevNYm8MmcmkM03rgiE5V1iDntcLAL+4RW6ga+WFL5Weq/6c+ON
         l5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271311; x=1790876111;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACjFFHMgW+Gwh6CM6AIAcR2m9FJl/y1RH2aBBB5Bmwo=;
        b=dN6PGpCG70oZksBOPeCvzyw2oJSHsaDUAL4l1a7CPTeaCvfGUjuJOPdaorNPTvr4hT
         vOSviqe97wsvAsiysb0HWpAML3DD4zheCq3tXyVw0t9vu1+egOSQzzyvgnbm9qhAzci6
         h8Fw7b9HJNTQPyrhQGEBrGvizfmJkof10agH+hSZj2/UVttj2OixxsH/eKA82SSaZcQ7
         HtL7RrxGlwjdwQIJ40iQrK0py/TMAoLgXl9aQVzvJwwr5aArU6A2aiabhjyXLw7nPzVl
         bYbsP9EeoT6bhaMuOHDZv0mj3hUvt5pMlTpbFvt75cfIAW/S8EVVJc+5hMQ0td9wA3iH
         rUOQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/SHAf0wjwMAnsFLNmXFARqD4dTrL5Dx5NRf2ayBKTel58YNhE//nTC+5st9h7CIYFat87bT7E0Kw=@vger.kernel.org
X-Gm-Message-State: AFuF++mrN6seTkNPBl+E4r5sFrYtaX/10KlqNAxDELyPD6GqQ/1+7M+K
	ViaPtqwvENInwyr4r0gvCxs0LYgh8b+xc93zTcdNSAgm/Xg7sqX2wfh5JfogncPm12HCmxfbvHO
	70saq3CtjHBAFQA==
X-Received: from pffz27.prod.google.com ([2002:aa7:991b:0:b0:87f:cff9:fb86])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab8d:b0:87c:e6aa:30e4 with SMTP id d2e1a72fcca58-87e9dfaf9c3mr2791493b3a.48.1790271310316;
 Thu, 24 Sep 2026 10:35:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:49 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-4-dmatlack@google.com>
Subject: [PATCH 03/15] PCI: Lay out struct pci_saved_state by configuration
 space offset
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

Store a device's saved state as a bitmap of the configuration space DWORDs
that were saved plus their values, instead of a copy of the configuration
space header followed by a list of pci_cap_saved_data records.

The old layout is described entirely by the kernel: which capabilities have
a record, how large each record is, and what each word within a record
means are all properties of the code that happens to be saving them. That
makes the blob impossible to interpret outside the kernel that produced it,
which is a problem for VFIO, which needs to carry a device's saved state
across a Live Update kexec. The new layout is described by the device: a
value's position is the offset of its register in the device's own
configuration space.

Keep refusing state that the device has nowhere to put in
pci_load_saved_state(), the equivalent of the old check that the
capability existed and its record was the expected size. Use
pci_saved_cap_reserved() to ask the store that question without the WARN
that pci_saved_cap_slot() raises for an offset no capability reserved,
since here an unreserved offset means untrusted input rather than a
kernel bug.

No capability uses the store yet, and the patches that follow move them
into it one at a time, so keep appending the records of the capabilities
that still have their own buffer after the saved DWORDs. The blob
therefore continues to describe all of a device's saved state at every
step; the last patch of the series drops the records once there are none
left.

struct pci_saved_state is opaque to everything outside drivers/pci, so no
caller needs to change.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c        | 89 +++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.h        |  4 ++
 drivers/pci/saved-caps.c | 14 +++++++
 3 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..7be54751a5d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1884,11 +1884,40 @@ void pci_restore_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_restore_state);
 
+/**
+ * struct pci_saved_state - a device's saved configuration space
+ * @dword_map: one bit per DWORD of configuration space, set if that DWORD
+ *	       was saved
+ * @dword_val: saved values, in ascending configuration space offset order
+ *
+ * Laid out so that the position of every value is described by the device's
+ * configuration space rather than by the kernel.
+ *
+ * Capabilities that have not moved to the saved capability store yet keep
+ * their own buffer, and their records trail @dword_val until the last of
+ * those buffers goes away. Both areas vary in length and only one of them
+ * can be a flexible array member, so the records are reached with
+ * pci_saved_state_records() rather than declared here.
+ */
 struct pci_saved_state {
-	u32 config_space[16];
-	struct pci_cap_saved_data cap[];
+	unsigned long	dword_map[BITS_TO_LONGS(PCI_CFG_SPACE_EXP_DWORDS)];
+	u32		dword_val[];
+	/* struct pci_cap_saved_data cap[] follows dword_val */
 };
 
+/*
+ * The records that follow the saved DWORDs, one per capability that still has
+ * its own save buffer, terminated by an empty record.
+ */
+static struct pci_cap_saved_data *
+pci_saved_state_records(struct pci_saved_state *state)
+{
+	unsigned int nr_dwords = bitmap_weight(state->dword_map,
+					       PCI_CFG_SPACE_EXP_DWORDS);
+
+	return (struct pci_cap_saved_data *)&state->dword_val[nr_dwords];
+}
+
 /**
  * pci_store_saved_state - Allocate and return an opaque struct containing
  *			   the device saved state.
@@ -1898,16 +1927,28 @@ struct pci_saved_state {
  */
 struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 {
-	struct pci_saved_state *state;
+	DECLARE_BITMAP(map, PCI_CFG_SPACE_EXP_DWORDS);
+	struct pci_saved_caps *caps = &dev->saved_caps;
 	struct pci_cap_saved_state *tmp;
 	struct pci_cap_saved_data *cap;
+	struct pci_saved_state *state;
+	unsigned int dword, nr_dwords, i = 0;
 	size_t size;
 
 	if (!dev->state_saved)
 		return NULL;
 
-	size = sizeof(*state) + sizeof(struct pci_cap_saved_data);
+	bitmap_zero(map, PCI_CFG_SPACE_EXP_DWORDS);
+	bitmap_set(map, 0, PCI_STD_HEADER_DWORDS);
+	if (caps->dword_val)
+		bitmap_or(map, map, caps->dword_map, PCI_CFG_SPACE_EXP_DWORDS);
+
+	nr_dwords = bitmap_weight(map, PCI_CFG_SPACE_EXP_DWORDS);
+
+	size = struct_size(state, dword_val, nr_dwords);
 
+	/* Room for the buffers that are left, and for the terminator */
+	size += sizeof(struct pci_cap_saved_data);
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next)
 		size += sizeof(struct pci_cap_saved_data) + tmp->cap.size;
 
@@ -1915,16 +1956,25 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
 	if (!state)
 		return NULL;
 
-	memcpy(state->config_space, dev->saved_config_space,
-	       sizeof(state->config_space));
+	bitmap_copy(state->dword_map, map, PCI_CFG_SPACE_EXP_DWORDS);
 
-	cap = state->cap;
+	for_each_set_bit(dword, state->dword_map, PCI_CFG_SPACE_EXP_DWORDS) {
+		u32 *val = &state->dword_val[i++];
+
+		if (dword < PCI_STD_HEADER_DWORDS)
+			*val = dev->saved_config_space[dword];
+		else
+			pci_read_saved_cap_dword(dev, dword * sizeof(u32), val);
+	}
+
+	cap = pci_saved_state_records(state);
 	hlist_for_each_entry(tmp, &dev->saved_cap_space, next) {
 		size_t len = sizeof(struct pci_cap_saved_data) + tmp->cap.size;
+
 		memcpy(cap, &tmp->cap, len);
 		cap = (struct pci_cap_saved_data *)((u8 *)cap + len);
 	}
-	/* Empty cap_save terminates list */
+	/* Empty record terminates the list */
 
 	return state;
 }
@@ -1939,16 +1989,33 @@ int pci_load_saved_state(struct pci_dev *dev,
 			 struct pci_saved_state *state)
 {
 	struct pci_cap_saved_data *cap;
+	unsigned int dword, i = 0;
 
 	dev->state_saved = false;
 
 	if (!state)
 		return 0;
 
-	memcpy(dev->saved_config_space, state->config_space,
-	       sizeof(state->config_space));
+	for_each_set_bit(dword, state->dword_map, PCI_CFG_SPACE_EXP_DWORDS) {
+		unsigned int off = dword * sizeof(u32);
+		u32 val = state->dword_val[i++];
+
+		if (dword < PCI_STD_HEADER_DWORDS) {
+			dev->saved_config_space[dword] = val;
+			continue;
+		}
+
+		/*
+		 * Refuse state that the device has nowhere to put, e.g.
+		 * because it was saved from a different device.
+		 */
+		if (!pci_saved_cap_reserved(dev, off))
+			return -EINVAL;
+
+		pci_write_saved_cap_dword(dev, off, val);
+	}
 
-	cap = state->cap;
+	cap = pci_saved_state_records(state);
 	while (cap->size) {
 		struct pci_cap_saved_state *tmp;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 93916b0cdd21..e8e7bc8a63e7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -258,6 +258,9 @@ struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
 struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev,
 						   u16 cap);
 
+/* DWORDs of the configuration space header, i.e. pci_dev.saved_config_space */
+#define PCI_STD_HEADER_DWORDS	(PCI_STD_HEADER_SIZEOF / sizeof(u32))
+
 void pci_saved_caps_finalize(struct pci_dev *dev);
 void pci_saved_caps_release(struct pci_dev *dev);
 int pci_reserve_saved_cap(struct pci_dev *dev, unsigned int off, unsigned int len);
@@ -269,6 +272,7 @@ void pci_restore_cap_dword(struct pci_dev *dev, unsigned int off);
 bool pci_read_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 *val);
 bool pci_read_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 *val);
 void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val);
+void pci_write_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 val);
 
 #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
diff --git a/drivers/pci/saved-caps.c b/drivers/pci/saved-caps.c
index 649d2cd09e81..eaacc3b3ea74 100644
--- a/drivers/pci/saved-caps.c
+++ b/drivers/pci/saved-caps.c
@@ -218,6 +218,20 @@ void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val)
 	*slot |= (u32)val << shift;
 }
 
+/**
+ * pci_write_saved_cap_dword - change the saved value of a 32-bit register
+ * @dev: the PCI device
+ * @off: offset of the register in configuration space
+ * @val: value to save
+ */
+void pci_write_saved_cap_dword(struct pci_dev *dev, unsigned int off, u32 val)
+{
+	u32 *slot = pci_saved_cap_slot(dev, off);
+
+	if (slot)
+		*slot = val;
+}
+
 /**
  * pci_restore_cap_dword - restore a 32-bit capability register
  * @dev: the PCI device
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

