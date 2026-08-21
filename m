Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D71A6829
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787350593; cv=none; b=roXFxlGRlpgXrAeL8Q0qBcRhrJ4qF6pDg+DvjVREIKYOFZvll/vdGPBjWlZZ3bEMuvxfh/m/M+2lKguBY0x/mX+/T6ObjNNsFTv9g+fnTh3c9VrRXQtoPD8JdqSOcFzSki8IjcRyGoFqosCYxJPu/61NrxGeCwckrcan1JESX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787350593; c=relaxed/simple;
	bh=9cK+9qTql37QYIz37WDsRcw/7LQHtdTltaYK46f9BPY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=h9YAbNo0AdT53xUoVgJiFoiXoHfaPpLemCGRCviAAuyNPipxNEckIFwKT6KNieTHUeMZqtyCni9EESFbLnZ45brR+/cp2EanP5HT1Pxqmk8PpWnQy67THhKXiuKhdYjN/rZN8rkFvHia5H0wv2fO9HPiRBLzwuJxGTANw4YPzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W7OBsQNU; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W7OBsQNU"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so19229665ad.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787350591; x=1787955391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nGzjUGYctwJSzkPPOCCVrXKRANqiQHkPBAJGCUzWsl0=;
        b=W7OBsQNUbxIvV78WgdGbo+iV3yFsojiG1m9gx5+fWwXkSWSozCA1LGP+WNHoDxmX3g
         wniytQEciIoYL6/BUc3mumDVXe41wI4n9yVI8qwJedXFxxvmdped9gq9ab1ViDr0NeOC
         xVEVoLfLVVeHy5y+WxyJ8drhVzzQQqXOZGi47/CxwOadwrri9aXTOTShn1lwEexdz9mx
         J1cTrzqpFvCv+ZCd3MVvLb3iDx95JoJhtycMHM9fKDSmg0TkPJcBQSPfJOvdKMn2v9wd
         jhnGOIOPlAk+fKS/N4rOoLVpn08awV4IyZvDHm+Q+wRUgUbZl/yrSMdc155D0Q6aMUex
         +4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787350591; x=1787955391;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nGzjUGYctwJSzkPPOCCVrXKRANqiQHkPBAJGCUzWsl0=;
        b=TlncjbZgP/h2TlQh93t4B8a+D4EkRJUfHiKbZa+oemY1C6o7JZk/5cf3c0aQg/O59B
         GV5o20OdgF/LZrGCx73HgAftTpUJ4BDsqbIH/JSIUkYEe1VtTqJnzAXcZYu/BIdjQooQ
         p8qI8ueymmDS7XHMAL0FjhyA+qZObiC575PanswKjEv6OU1zCNr78P1czEWC6DFTlkRa
         S1WdXll0xJZQ6xniutS7R25eDHeKTMOLt/4XOtNnp7kcQXWACpaEteJwuupmDRlKWKzz
         7+4G0jhWQxQ8lrBrbXVi49j5kfzSSxDzgJZQ6bNfs3/p+O/5FEw9ULHt6IoMWh4KdLhl
         A4GA==
X-Forwarded-Encrypted: i=1; AHgh+Rol1wxM3deNtp6V1QENHCKWtM5gTCYjyurRxeqj1B6SJzqQBiP027lss4Eodwr5LMg10aYaSKDwFh4=@vger.kernel.org
X-Gm-Message-State: AFuF++n/AY5duntTSqdNbYibNQGcopv28Xk4mRAr7ktcD4eg7xsgvpy7
	kEGuOb6WQcFci6+zQXF5c1GxFziz3mUKdAU82JumiTpOwiv8BzbonO52kTL6zvwP7byMTUEbvUo
	6o2qd7p5ZZ9ctWw==
X-Received: from plbms11.prod.google.com ([2002:a17:903:acb:b0:2cc:e88e:423c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef47:b0:2d6:7409:7145 with SMTP id d9443c01a7336-2d674097a77mr9729445ad.1.1787350591303;
 Fri, 21 Aug 2026 15:16:31 -0700 (PDT)
Date: Fri, 21 Aug 2026 22:15:59 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821221610.3570722-1-dmatlack@google.com>
Subject: [pciutils PATCH v2] lspci: Determine bridge window address size from bridge_flags
From: David Matlack <dmatlack@google.com>
To: Martin Mares <mj@ucw.cz>
Cc: "=?UTF-8?q?Pali=20Roh=C3=A1r?=" <pali@kernel.org>, David Matlack <dmatlack@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Use bridge_flags to determine address size bits (16- vs 32-bit for I/O,
32- vs 64-bit for prefetchable memory) when displaying bridge ranges
populated via PCI_FILL_BRIDGE_BASES.

Commit ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if
range behind bridge is disabled or unsupported") introduced code in
show_htype1() that reads PCI_IO_RANGE_TYPE_MASK and
PCI_MEMORY_RANGE_TYPE_MASK from bridge_base_addr[]. However,
bridge_base_addr[] holds base addresses without flags, as documented in
lib/pci.h and implemented across backends like sysfs.c and
win32-cfgmgr32.c.

Because bridge_base_addr[] does not contain configuration register flag
bits, masking the lower bits evaluates to zero. As a result, 32-bit I/O
windows are mislabeled as "[16-bit]" and 64-bit prefetchable memory
windows are mislabeled as "[32-bit]" when using PCI_FILL_BRIDGE_BASES.

Fixes: ccf68033a452 ("lspci: Use PCI_FILL_BRIDGE_BASES to detect if range b=
ehind bridge is disabled or unsupported")
Signed-off-by: David Matlack <dmatlack@google.com>
---
v2:
 - Fix lspci.c to use bridge_flags[], per lib/pci.h, rather than
   changing the behavior of just the sysfs backend (Pali Roh=C3=A1r)

v1: https://lore.kernel.org/linux-pci/20260626213047.189951-1-bhelgaas@goog=
le.com/

 lspci.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lspci.c b/lspci.c
index 2a14303e74f6..52fd9247aefb 100644
--- a/lspci.c
+++ b/lspci.c
@@ -571,10 +571,9 @@ show_htype1(struct device *d)
=20
   if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !io_disabled)
     {
-      io_base =3D p->bridge_base_addr[0] & PCI_IO_RANGE_MASK;
+      io_base =3D p->bridge_base_addr[0];
       io_limit =3D io_base + p->bridge_size[0] - 1;
-      io_type =3D p->bridge_base_addr[0] & PCI_IO_RANGE_TYPE_MASK;
-      io_bits =3D (io_type =3D=3D PCI_IO_RANGE_TYPE_32) ? 32 : 16;
+      io_bits =3D (p->bridge_flags[0] & PCI_IORESOURCE_IO_16BIT_ADDR) ? 16=
 : 32;
       show_range("\tI/O behind bridge", io_base, io_limit, io_bits, io_dis=
abled);
     }
   else if (io_type !=3D (io_limit & PCI_IO_RANGE_TYPE_MASK) ||
@@ -600,7 +599,7 @@ show_htype1(struct device *d)
=20
   if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !mem_disabled)
     {
-      mem_base =3D p->bridge_base_addr[1] & PCI_MEMORY_RANGE_MASK;
+      mem_base =3D p->bridge_base_addr[1];
       mem_limit =3D mem_base + p->bridge_size[1] - 1;
       show_range("\tMemory behind bridge", mem_base, mem_limit, 32, mem_di=
sabled);
     }
@@ -616,10 +615,9 @@ show_htype1(struct device *d)
=20
   if ((p->known_fields & PCI_FILL_BRIDGE_BASES) && !pref_disabled)
     {
-      u64 pref_base_64 =3D p->bridge_base_addr[2] & PCI_MEMORY_RANGE_MASK;
+      u64 pref_base_64 =3D p->bridge_base_addr[2];
       u64 pref_limit_64 =3D pref_base_64 + p->bridge_size[2] - 1;
-      pref_type =3D p->bridge_base_addr[2] & PCI_MEMORY_RANGE_TYPE_MASK;
-      pref_bits =3D (pref_type =3D=3D PCI_PREF_RANGE_TYPE_64) ? 64 : 32;
+      pref_bits =3D (p->bridge_flags[2] & PCI_IORESOURCE_MEM_64) ? 64 : 32=
;
       show_range("\tPrefetchable memory behind bridge", pref_base_64, pref=
_limit_64, pref_bits, pref_disabled);
     }
   else if (pref_type !=3D (pref_limit & PCI_PREF_RANGE_TYPE_MASK) ||

base-commit: b41ce14da749fb44ca7940ba9797027bfa62c23e
--=20
2.55.0.766.g2966f0265a-goog

