Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2930FC1A
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210366; cv=none; b=u/iF486Uug4FUAPZYgL0A5dnleJpSuWadQDREsTfkUIs3RzmAbpy9SZc+E3YaBp9bf+i1E5xm6rqH2W9NEX0rYZvD2vjPQ9EQYcnpond2RvCgkT4e8dERny+wb+ILMtcJPtQSfpAXZ3/BcgIIRyPX72QRfMAVoCUtvVRhptSvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210366; c=relaxed/simple;
	bh=q9J06bxDr2w+m1apTO1ZVdf/ov6RslPYWBs92GaXEUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mC0BSDKasymklyDlVUCOBrf6tmxSj6ZxfkALgZV+k2heku/r8fWWPjVFnLwxZDHMCNdo0FfeP56SJJzyOViMbiF1Hn08YNBJYPt+ihHgoZQjo67n98E8mjc8xlqRzX7x2629x6j+BcXDX1doF983fBTI7X0iOzhBYbK8XIsHhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnGtF3ln; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnGtF3ln"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso14658315ad.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210364; x=1778815164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAyFv2zvkihNKJLa3E0b/381Ywpzx1UIj7t6rujOZAw=;
        b=EnGtF3lnPaXxK3DaWsQkkHEhJ/OA3hQZv4FJg7yDR0nwMvuKVId2ESl9XDTGHL4JqF
         VKUtGWE6R5L6f4B7hibNw5xwYr6s7cfIUIvnEzF2jXoyx5xLwmNfyY9TJ3mCPL1CzXXs
         ZfU89H3Udu3pl2QLf2fP7eMwHOzy9DsvJOPzcJyqFhkIU8hhoJn+FFl58K7EVcCJLssU
         u4h2jciyekadqqxfLfVUfsKePdBXGNdlgX/6k6Gr384ROoxC9bl6FEK9F6pLQWmJdn0s
         VTW+e8IdTP9gfAdmlrtKyArw8Nvf9iK7H+H1QPc4L3c6Y8A8W+FXfodVjHQDA88Df8lN
         yOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210364; x=1778815164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAyFv2zvkihNKJLa3E0b/381Ywpzx1UIj7t6rujOZAw=;
        b=LmkBOFDjzERNckFDtfFl5CrDSQ4N31auK9V8UWXA+F8TB/b9TpWgn2tch7d9R8EBRQ
         93Q5qrOHVL2NtBA2FjIW/ARhPRoEhjJYgr8RElrEurQlnWPQDUqM/mB74WRHDZlyDsc/
         1pGEU497ZKeLw/380CuC/HyNWsE6ewzhq1mJkEYHQB1eh1HLtnixinFogm9wOuy/qdtF
         iQcrtIarSw7zmDjfRHpoNxUsDTcZJ6Nt9NPuuaVe8jE+qL9rN/i8UFa/gNXUeVm6YxJK
         z3mZvv4+MKiCcXaSn2mhZRwgdRFWx3uy+CSUrCAgGcnCoEnpgS8qdmOsirPHvuDW93Dr
         WoqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OLGIfRhdbrgSG2MbTUH3afWAh8pBVSaT5nu08X03R96sJ3vY25hZ+A4BbpmvBpTcVoqIsz8Subg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZywzKbunkuLIwq1MbebDbUJnE92g/PTy6vXcxCV0ilW6CCvUn
	0awzvk7shREglOrF6eCcc7P1b/u67WkVZbFVMHqFS0PhV60cNXqlU2d2
X-Gm-Gg: Acq92OE2kqKcCOPRLs1kSRUWgmb5adaaOBM0OfQJH7e7EKJDiE7x+bkG0SL2s5gOqnq
	NWXnHlz1cUkwe07foHF1nF4WxeiVF0h7XZ9z7YFJGZP9N6wJc+v8IAjdX5mY6IqW4xYraC6K705
	45oyWceichE0Nb2LUHDahRMLrhMPmaTOtPErbkB8gEE9Tp7qhzcJ5is9BQd/L2x8cv9dE0SXxUb
	asWWFn9WS6LDxjL6GtJCGKTrksFQxeyduYFhKs4JTp6zeeZlNJzF1wqmld37vuBwEIioQWiGsor
	RLDZj35lfPN1OFIVkjj5egudWZC5sdtgZvYw1xSGNNjdPcH+yVqg2+c+ElTEPsEHKLq3l/xJ2kP
	kihX0MBQvkT2pOAMnNx+pmGSgHTQV45X35DtZ2o0IXsrQ7gAYo+Y5RO/gXlOY09JP+66Cdv1mdA
	eo5i7CAy8TlLwmNII4NquxemyHi/M7sQuA5a/CPlgb
X-Received: by 2002:a17:903:b0d:b0:2b4:5ddf:24f with SMTP id d9443c01a7336-2ba793bf9fbmr121352905ad.10.1778210363900;
        Thu, 07 May 2026 20:19:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:19:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com
Subject: [PATCH 16/18] lib: rspdm: Support SPDM certificate validation
Date: Fri,  8 May 2026 13:17:08 +1000
Message-ID: <20260508031710.514574-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair@alistair23.me>

Support validating the SPDM certificate chain. This only performs basic
sanity checks on the chain before we continue on. This does not ensure
that the root CA is trusted, we leave that for userspace to check and
enforce. Instead we just make sure that the chain is correct, uses
supported signatures and that it isn't blacklisted in the kernel.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 lib/rspdm/lib.rs                | 17 ++++++++
 lib/rspdm/state.rs              | 69 ++++++++++++++++++++++++++++++++-
 rust/bindings/bindings_helper.h |  2 +
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index d5aee761003a..d6421b2fab7d 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -135,6 +135,17 @@
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     0
 }
 
@@ -145,6 +156,12 @@
 pub unsafe extern "C" fn spdm_destroy(state_ptr: *mut spdm_state) {
     let state: &mut SpdmState = unsafe { &mut (*(state_ptr as *mut SpdmState)) };
 
+    if let Some(leaf_key) = &mut state.leaf_key {
+        unsafe {
+            bindings::public_key_free(*leaf_key);
+        }
+    }
+
     if let Some(desc) = &mut state.desc {
         unsafe {
             bindings::kfree(*desc as *mut _ as *mut c_void);
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index 69b6f67a6ef5..4c8ee553bb69 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -106,7 +106,8 @@
 ///  H in SPDM specification.
 /// @certs: Certificate chain in each of the 8 slots. Empty KVec if a slot is
 ///  not populated. Prefixed by the 4 + H header per SPDM 1.0.0 table 15.
-#[expect(dead_code)]
+/// @leaf_key: Public key portion of leaf certificate against which to check
+///  responder's signatures.
 pub struct SpdmState {
     pub(crate) dev: *mut bindings::device,
     pub(crate) transport: bindings::spdm_transport,
@@ -135,6 +136,7 @@ pub struct SpdmState {
 
     // Certificates
     pub(crate) certs: [KVec<u8>; SPDM_SLOTS],
+    pub(crate) leaf_key: Option<*mut bindings::public_key>,
 }
 
 #[repr(C, packed)]
@@ -173,6 +175,7 @@ pub(crate) fn new(
             desc: None,
             hash_len: 0,
             certs: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -786,4 +789,68 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
 
         Ok(())
     }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = &self.certs[slot as usize];
+        let cert_chain_len = cert_chain_buf.len();
+        let header_len = 4 + self.hash_len;
+
+        let mut offset = header_len;
+        let mut prev_cert: Option<*mut bindings::x509_certificate> = None;
+
+        while offset < cert_chain_len {
+            let cert_len = unsafe {
+                bindings::x509_get_certificate_length(
+                    &cert_chain_buf[offset..] as *const _ as *const u8,
+                    cert_chain_len - offset,
+                )
+            };
+
+            if cert_len < 0 {
+                pr_err!("Invalid certificate length\n");
+                to_result(cert_len as i32)?;
+            }
+
+            let cert_ptr = unsafe {
+                from_err_ptr(bindings::x509_cert_parse(
+                    &cert_chain_buf[offset..] as *const _ as *const c_void,
+                    cert_len as usize,
+                ))?
+            };
+            let cert = unsafe { *cert_ptr };
+
+            if cert.unsupported_sig || cert.blacklisted {
+                pr_err!("Certificate was rejected\n");
+                to_result(-(bindings::EKEYREJECTED as i32))?;
+            }
+
+            if let Some(prev) = prev_cert {
+                // Check against previous certificate
+                let rc = unsafe { bindings::public_key_verify_signature((*prev).pub_, cert.sig) };
+
+                if rc < 0 {
+                    pr_err!("Signature validation error\n");
+                    to_result(rc)?;
+                }
+            }
+
+            if let Some(prev) = prev_cert {
+                unsafe { bindings::x509_free_certificate(prev) };
+            }
+
+            prev_cert = Some(cert_ptr);
+            offset += cert_len as usize;
+        }
+
+        if let Some(prev) = prev_cert {
+            if let Some(validate) = self.validate {
+                let rc = unsafe { validate(self.dev, slot, prev) };
+                to_result(rc)?;
+            }
+
+            self.leaf_key = unsafe { Some((*prev).pub_) };
+        }
+
+        Ok(())
+    }
 }
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0231e4f87f20..4e1519b2382d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -69,6 +69,8 @@
 #include <linux/iosys-map.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <keys/asymmetric-type.h>
+#include <keys/x509-parser.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
-- 
2.52.0

