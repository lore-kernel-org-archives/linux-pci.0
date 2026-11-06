Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925791;
	b=FLj8czztg2DeyjxySwRSNPxnG/zgB/pSXzGVl1Ye4g9nXzT93HsmufKiru9mgJn6PBsZ
	 NCdgI8H5Z9iXoi/2G+FDXSOXKefgLuFrhyirfW5TndRSaWZxlKsBa1Xr8ur6WJBr8dB65
	 7z9Qq9d36An01TnC6Ay1S3rQj0C9xL4NzHXN+bEnGAKZoCWIU4vVJjUGwXpcx6jbsL4dr
	 V3hcMr2zqz6FK5n0ip7+skIMDTP8Uz28AEgQorFSlK3sUib2wGBCV7sBm6ea72eKYF0Js
	 2sqvS6pjwjd4TcCJMcNE9HIuYRYSGhLZrDAk1hR9YGD5MKgQ5T0V+Cdv4UZ2Qm+8p3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7sjq9VdN6W+I9NBwFH2LvF9xugKaVKfSc0OTWV+x1HY=;
	b=G9A99blImU2kExtdaVSzHOQPwpEgDkoZqrsTnyzt0fNwljf/Ffpdp8hR6y0Pi+eFnqwP
	 +XkdIzD2fzZWaKR6r4+L34+mR9cgUgzMvwLR/WcobPwHydBmapXNY5jrSnH1IVkZdyneQ
	 TY3ZufD0cGnTYB0KeT7mYmxgHTAC0NkK94J/tK8zIocqeYM5xVqPfxUbZWX4WfQpE5Zo2
	 x0xFXQmZmHmMRt29eaGCFw7NMl0KZ/u1MJ97ALzPCIdeZ/3hF9XEBEzyZk+QdOFPNAYPC
	 xbHMAJ65Xghllc0eKTNRyhpLOxMFGRBpITQlfnv2Mc1YJZOfMDWnzDtBojLfQUC8HZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809BF606D809
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 00:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809BF606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-8437834ad7eso274840a34.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 16:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925780; x=1794530580; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sjq9VdN6W+I9NBwFH2LvF9xugKaVKfSc0OTWV+x1HY=;
        b=e3fgR/SKD7ZyBVYRl7Ae0tV/CpkJ3uQsY9YcR2LfwSQAFQCFPjqLB1c/fT6Gqbadmt
         ULYEUQfX6JH+Ek7RAlk+Zqx1a/KjaBwGVFNrtWMzcUdTjxUjrIheTV9GXEmfkhMLUVPn
         qTA7HLoyNb7MV3jDquhCnQqNVlEbfcvgJtI/SFMbzYfIKur+ef+6kHbgQsdcX0Ub7j5U
         OXbgf2YmSVAgE2EWqFjJ3p4xqN/vZYO69UghPLfQCXDYCeh/VIOSdo4OnFsvvna+wYKY
         kZqF/M61lpwmhFlX64o3SvBtrtHTSxU9OJEqN77aix0KR0KM+7JOc3bGKCa0BaphVgay
         MRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925780; x=1794530580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7sjq9VdN6W+I9NBwFH2LvF9xugKaVKfSc0OTWV+x1HY=;
        b=ufkKIfvNB3FqDzUktQyiDTuN5Kgz5614lHyLyQGSO1wHLVkuIBnP33v3ZpzZ3LGJ1i
         hm+Iu7Ufo1PYG8OMfNVvGUB+vswZz9eMP18i5/oLXKHJM4Fsao0R3YzUaRr1VgM1O0Ae
         n71Ohr8fHvxLltLfPECIMudvRxVcCUBSHFMVxtJ4YPjTfzcmsmtlmAOH68XFvoDCqlz8
         fY6tIbmFxIzjc5hyl4W5Xn6R7ql0kp6JDaGbfxA9UnY94A3GExn1VybpXrsDqpXPlFM/
         85LrNpqQx/KS+TVZpJW6pMYDFPfJGxOFKA2RRIbhmh/anqm6WaOUMhytCokajNkV/vdc
         V29Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmSTt7wlu1VtOkwy8rD2hefa8dYdWsCoY7/a7SSyWEdEuer8SAJT7i5dsq3I806zE2Sqy7Ja/oK8o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9stdOeLp6AvzLwslGY/YIZ74cIiYb+iZhVKqkcRMXbCPQ+ylNq
	mvPCL3Q3g707YAna1JzIcH9mNSoV186OFGUvhIbKmWYWCvlmGTWNlsTE5P4/Sw3/3FOC87IKlH+
	8ZsJngIbT/MS1aA==
X-Received: from jaan3-n1.prod.google.com ([2002:a05:6638:aac3:10b0:61c:f758:dde6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6f92:b0:55c:6ea:3e3f with SMTP id 5614622812f47-567e1038164mr750724b6e.28.1793925780223;
 Thu, 05 Nov 2026 16:43:00 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:04 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-4-dmatlack@google.com>
Subject: [PATCH v2 03/17] PCI: Lay out struct pci_saved_state by configuration
 space offset
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Store a device's saved state as a bitmap of the configuration space DWORDs
that were saved plus their values, instead of a copy of the configuration
space header followed by a list of pci_cap_saved_data records.

The old layout is described entirely by the kernel: which capabilities have
a record, how large each record is, and what each word within a record
means are all properties of the code that happens to be saving them. That
ties the blob to the kernel that produced it, so VFIO cannot carry a
device's saved state across a Live Update. The new layout is
described by the device: a value's position is the offset of its
register in the device's own configuration space.

Keep refusing state that the device has nowhere to put in
pci_load_saved_state(), the equivalent of the old check that the
capability existed and its record was the expected size. Use
pci_saved_cap_reserved() for the check, since state saved from another
device or kernel can legitimately name an offset that this device did
not reserve.

No capability uses the store yet, and the patches that follow move them
into it one at a time, so keep appending the records of the capabilities
that still have their own buffer after the saved DWORDs. The blob
therefore continues to describe all of a device's saved state at every
step; a later patch drops the records once there are none left.

struct pci_saved_state is opaque to everything outside drivers/pci, so no
caller needs to change.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c        | 89 +++++++++++++++++++++++++++++++++++-----
 drivers/pci/pci.h        |  4 ++
 drivers/pci/saved-caps.c | 14 +++++++
 3 files changed, 96 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5b960ca26e6..007f9bb289d5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2032,11 +2032,40 @@ void pci_restore_state(struct pci_dev *dev)
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
@@ -2046,16 +2075,28 @@ struct pci_saved_state {
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
 
@@ -2063,16 +2104,25 @@ struct pci_saved_state *pci_store_saved_state(struct pci_dev *dev)
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
@@ -2087,16 +2137,33 @@ int pci_load_saved_state(struct pci_dev *dev,
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
index 6676177706ba..206e0d04e06e 100644
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
index 92865891514e..4647ce59ce74 100644
--- a/drivers/pci/saved-caps.c
+++ b/drivers/pci/saved-caps.c
@@ -211,6 +211,20 @@ void pci_write_saved_cap_word(struct pci_dev *dev, unsigned int off, u16 val)
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
2.56.0.455.g6c5a503b38-goog

