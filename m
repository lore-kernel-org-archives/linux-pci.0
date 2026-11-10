Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284522;
	b=WJ/597h6nxXXaGoptNkvf80hJac2zaC1H6DOFHJ9yda8Gv4+V+/48/bPKwQEqdqNx4MK
	 Oomx+aKKv81q1IwvlNpygyxv4jCtPZl0fw00Gm3gKnDnZK067T6VoX5DmwfD579hcsGmk
	 Bgrv/iZ47XWBzxoFVB/bPhfVUaLqA1iXB4OuZhMK0zon8PBnKNj1Jrma2OZZ87gxI+KUH
	 RtfWeeIfKQf2GIUawnxQSiZuG9OdWTvu57gAAQppt68vo2sr/XogKs8PlwPEfXAMtzMCZ
	 pN/5BTrh12JntOqvU66ifWtX+s+pSI5a8H5M6sgY4my1NQgM3PSy3O5aJ6UhviiH6kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U4I5SZDyaCY1uRTy13J/8BxFiRq3MLupUvdwxlQnj24=;
	b=C+wsEtgXVUDBXoyl6DcnSZAKZWuLkYUm7Ue4tjMf9bWds8M8FNtEr7iwdDIYipn5OZZ1
	 kNM7b5oXQd7e8MsNMRSZKLyLCnjYSjOOINuWuEl+kkm3vPLVa2tfe4/+e453LS1nqT5d6
	 flNnEZ129woQ7WHSsOiyvduLfvVF0ipOIm99OijjTy/qTYcqPq9wEXqBYXscUY8SPtrA6
	 l/Tkvg8ZAzOgntzCWocOO6uVQOr2Tu8N0VPSon2Q58PkkO7ciK0oNdc6iyVvpvBx/XyBe
	 xqssBKo2Sr9e9zjvtJ706Wo6HLmxO4OUuQR9rZsQsZ/x1OKwae8tAdFy78P0MPXnuXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLT9UBZG;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2160A3804
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A2160A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JLT9UBZG
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b1ce85287aso1644584c88.0
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 20:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794284521; x=1794889321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4I5SZDyaCY1uRTy13J/8BxFiRq3MLupUvdwxlQnj24=;
        b=JLT9UBZGYzReCUbCGKaL26tXCAG3w6CotFr420xFf+b3VCCdat4kZyIMJiGt8xTLYG
         gmvrtwh2yJ3/7+3GDa3dQHsh8KJXFmSXaTYDRzw507iokEbLono9lxtEFtxlerTKv9Br
         S3KJtXUCWThoIoEH6hZzeoTXLl1YKtUXIetnVOLFuR+5N09/nTHo/qbluYF/0mN2RuvS
         DpZq4V1L75DS4apuWy9eKk6nlck3hFviyJX1CXzNJCIGtUW12ggvIPvNr8gsG911iF+F
         N5X8256ZMcQQIWMceqHPsjmw5bIIVS2JcVhCze5NaeGd3xR1Hp9TpKZoo2RAN/umWiXn
         3gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794284521; x=1794889321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4I5SZDyaCY1uRTy13J/8BxFiRq3MLupUvdwxlQnj24=;
        b=sllspw1IpYy4C+dhvu9utcWY8GcysdrwTWXkJ6oAte5+UGOQEg/10F310TF9zD22uf
         gs6t7UktAHW67L7XiqSSJdn3Z0eYnfNDz3aeA8FCBwDsKY2HvJcmUo7OeJvCQCgngpHr
         C4yYwLPAPxnEybJwAXXpTCAPmTazm+XsmPvxEytXjsUb33u88CfH0azhwIA8jhrwBr3A
         +Zu6hw9+B/sHoIIRiwz9nb7/BGBUzkTXJQ+Ou169GOeQv+gxODI4vde5+95Gw3SBR18M
         IyP6rL7BD0kH1Epyw1Rdnh78qr9GKxoUxGEuiEYY/bqudqhlLuROn47GHxsmxXocRx8O
         NEoA==
X-Forwarded-Encrypted: i=1; AL+hErHLuPQyW/Rz24EYF0oZpYuNzJYItkBYbvwEBZHgkZFEL3WlVKdmjAmSuOAN52K5vOQyCdsMhpsqbAs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8V3G3kdr1LuPeyPv03LVGbUcFf+JS4OrQtE51HplULKCDq6iEX
	95BQk+UPgFKLHvVmafZMGz8qmxChhPbZnI+2q4cn+DotrG+Vw4yDwL1I
X-Gm-Gg: AYBFou2VVGb7NmgtCxnRJMQ7KKv7llUcFREQbyZ9PcWENHIVY5hK+D8WC2qizMmPAEx
	+6yDwHaTjynfS/UOlldLLih4XVhQUXgGtOqk/ELF7R8pQnSXxLvrZkUrpIH9/wFKkuyeaBP20df
	OVmRQbryMBg7bV7i3IgVPvZDj221xXpHwHll5zBPaBmO/Wr1fwO6CcWvw7RXeTdFcoDd7dPOcHf
	/6J+Y1WzQCwUwFUIkmR4xT3j4LInDp6A7OQUAY1d7TBRfpkUphIpvElujZN5HKIeXy5BEifO1Kf
	3MnvCsBCWxSTmAuaIoXR+nblB4cyxe7l2xG9kGne4+KvwycjeeRmp78KH8Re8QVfF2wsR/jOB3q
	PZciYCyk8d2Nr0yHdcJlRrGPIZRaAdxOrsPOXtfjapOLTbqO8Qdc/yTR2l2CHC685dXdy8e2nqI
	o2SlBLFQBolVGzWivNhuv133LivrQ4KQ8VcDLsYCOoIECbNERUVQvKl5KYcx1znh5/AL3JV1y+W
	w8cdOYwudrBt8lYr2Cc3VfXy5UEBVRP1v2xca8rqeHvEC3BegKH0Gy0IvKa8Va0aKo+qtl2+TZy
	/YmwealCREZwso11nmLdqViyWE95ZEyw67CM1VtoH9u92a6OQVzj8BOvneFpjelmY/YF
X-Received: by 2002:a05:7022:b90a:b0:1b2:6cba:7f88 with SMTP id a92af1059eb24-1b3b619ab8emr2013609c88.44.1794284520534;
        Mon, 09 Nov 2026 20:22:00 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b7ba88sm3540459c88.22.2026.11.09.20.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:21:59 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	bvanassche@acm.org,
	linux-pci@vger.kernel.org,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	rust-for-linux@vger.kernel.org,
	jgg@nvidia.com,
	akpm@linux-foundation.org
Cc: gary@garyguo.net,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	alistair23@gmail.com,
	gregkh@linuxfoundation.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	alex.gaynor@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 23/25] lib: rspdm: Support SPDM certificate validation
Date: Tue, 10 Nov 2026 14:18:30 +1000
Message-ID: <20261110041832.1730924-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110041832.1730924-1-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Support validating the SPDM certificate chain. This only performs basic
sanity checks on the chain before we continue on. This does not ensure
that the root CA is trusted, we leave that for userspace to check and
enforce. Instead we just make sure that the chain is correct, uses
supported signatures and that it isn't blacklisted in the kernel.

We then store the first leaf certificate for use later.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 lib/rspdm/lib.rs   |  12 ++++
 lib/rspdm/state.rs | 172 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/lib/rspdm/lib.rs b/lib/rspdm/lib.rs
index 440589ff66b5f..44fab9caf1877 100644
--- a/lib/rspdm/lib.rs
+++ b/lib/rspdm/lib.rs
@@ -295,6 +295,18 @@ fn from(code: SpdmErrorCode) -> Self {
         provisioned_slots &= !(1 << slot);
     }
 
+    let mut provisioned_slots = state.provisioned_slots;
+    while (provisioned_slots as usize) > 0 {
+        let slot = provisioned_slots.trailing_zeros() as u8;
+
+        if let Err(e) = state.validate_cert_chain(slot) {
+            pr_err!("Certificate in slot {slot} failed to verify: {e:?}\n");
+            return e.to_errno() as c_int;
+        }
+
+        provisioned_slots &= !(1 << slot);
+    }
+
     -(EPROTONOSUPPORT as i32)
 }
 
diff --git a/lib/rspdm/state.rs b/lib/rspdm/state.rs
index f1a55da1f1cfa..dfe2f8becfb74 100644
--- a/lib/rspdm/state.rs
+++ b/lib/rspdm/state.rs
@@ -11,12 +11,17 @@
 use kernel::{
     bindings,
     device::Device,
-    error::Error,
+    error::{
+        to_result,
+        Error, //
+    },
     hash::Shash,
     page::PAGE_SIZE,
+    public_key::PublicKey,
     str::CStr,
     sync::aref::ARef,
-    validate::Untrusted, //
+    validate::Untrusted,
+    x509::Certificate, //
 };
 
 use crate::consts::{
@@ -102,7 +107,6 @@ pub(crate) trait Transport {
 /// it does not need to stay bound to its driver. `T` is data and an
 /// exchange function owned by the caller, so the borrow checker enforces
 /// that the transport data outlives `SpdmState`.
-#[expect(dead_code)]
 pub(crate) struct SpdmState<T: Transport> {
     /// Responder device (reference counted). Used for error reporting and
     /// passed to `transport`.
@@ -161,6 +165,9 @@ pub(crate) struct SpdmState<T: Transport> {
     /// Hash of each slot's certificate chain, as reported by the DIGESTS
     /// response. Empty `KVec` if a slot is not provisioned.
     pub(crate) digests: [KVec<u8>; SPDM_SLOTS],
+    /// Public key portion of leaf certificate against which to check
+    /// responder's signatures.
+    pub(crate) leaf_key: Option<PublicKey>,
 }
 
 impl<T: Transport> SpdmState<T> {
@@ -193,6 +200,7 @@ pub(crate) fn new(
             crypto: None,
             certs: [const { KVec::new() }; SPDM_SLOTS],
             digests: [const { KVec::new() }; SPDM_SLOTS],
+            leaf_key: None,
         }
     }
 
@@ -268,6 +276,9 @@ pub(crate) fn get_version(&mut self) -> Result<(), Error> {
             digest.clear();
         }
 
+        // Clear the leaf cert as we are re-authenticating
+        self.leaf_key = None;
+
         let mut request_buf = request.to_bytes()?;
 
         let response_vec: KVec<u8> = KVec::from_elem(0u8, SPDM_GET_VERSION_LEN, GFP_KERNEL)?;
@@ -593,9 +604,164 @@ pub(crate) fn get_certificate(&mut self, slot: u8) -> Result<(), Error> {
             return Err(EPROTO);
         }
 
+        // The chain must match the digest reported for this slot by the
+        // DIGESTS response (DSP0274 "GET_CERTIFICATE" certificates).
+        self.verify_slot_digest(slot, &certs_buf)?;
+
+        // Verify the RootHash embedded in the chain header against the root
+        // certificate it contains (DSP0274 "SpdmCertChain" table).
+        self.verify_root_hash(&certs_buf)?;
+
         self.certs[slot as usize].clear();
         self.certs[slot as usize].extend_from_slice(&certs_buf, GFP_KERNEL)?;
 
         Ok(())
     }
+
+    /// Hash `data` with the negotiated base hash algorithm.
+    fn digest_data(&mut self, data: &[u8]) -> Result<KVec<u8>, Error> {
+        let crypto = self.crypto.as_mut().ok_or(EPROTO)?;
+
+        let mut digest: KVec<u8> = KVec::new();
+        digest.extend_with(crypto.hash_len(), 0, GFP_KERNEL)?;
+        crypto.digest(data, digest.as_mut_slice())?;
+
+        Ok(digest)
+    }
+
+    /// Verify that the digest of `chain` matches the digest reported for
+    /// `slot` by the DIGESTS response.
+    fn verify_slot_digest(&mut self, slot: u8, chain: &[u8]) -> Result<(), Error> {
+        let digest = self.digest_data(chain)?;
+        let expected = &self.digests[slot as usize];
+
+        if expected.is_empty() {
+            dev_err!(&self.dev, "No digest reported for slot {slot}\n");
+            return Err(EPROTO);
+        }
+
+        if digest.as_slice() != expected.as_slice() {
+            dev_err!(
+                &self.dev,
+                "Certificate chain of slot {slot} does not match its digest\n"
+            );
+            return Err(EKEYREJECTED);
+        }
+
+        Ok(())
+    }
+
+    /// Verify that the RootHash field in the chain header is the hash of
+    /// the root certificate contained in `chain`.
+    fn verify_root_hash(&mut self, chain: &[u8]) -> Result<(), Error> {
+        let root_hash = chain
+            .get(SPDM_CERT_CHAIN_HDR_SZ..SPDM_CERT_CHAIN_HDR_SZ + self.hash_len())
+            .ok_or(EPROTO)?;
+        let certs_start = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len();
+
+        // SAFETY: `chain[certs_start..]` is a valid slice; the function
+        // reads at most the DER certificate length within it.
+        let root_len = unsafe {
+            bindings::x509_get_certificate_length(
+                chain.get(certs_start..).ok_or(EPROTO)?.as_ptr(),
+                chain.len() - certs_start,
+            )
+        };
+        let root_len = usize::try_from(root_len).map_err(|_| EPROTO)?;
+
+        let root = chain
+            .get(certs_start..certs_start + root_len)
+            .ok_or(EPROTO)?;
+
+        if self.digest_data(root)?.as_slice() != root_hash {
+            dev_err!(&self.dev, "RootHash does not match the root certificate\n");
+            return Err(EKEYREJECTED);
+        }
+
+        Ok(())
+    }
+
+    pub(crate) fn validate_cert_chain(&mut self, slot: u8) -> Result<(), Error> {
+        let cert_chain_buf = &self.certs[slot as usize];
+        let cert_chain_len = cert_chain_buf.len();
+        // We skip over the RootHash
+        let mut offset = SPDM_CERT_CHAIN_HDR_SZ + self.hash_len();
+
+        if offset >= cert_chain_len {
+            return Err(EPROTO);
+        }
+
+        let mut prev_cert: Option<Certificate<'_>> = None;
+        let mut cert_count = 0;
+
+        while offset < cert_chain_len {
+            let (cert, cert_len) = Certificate::parse(&cert_chain_buf[offset..])?;
+            cert.check_accepted()?;
+
+            if let Some(prev) = &prev_cert {
+                // Every issuer in the chain must be a CA allowed to sign
+                // certificates, and the signed certificate's issuer must
+                // match the issuer's subject (RFC 5280). An absent keyUsage
+                // extension places no restriction on the key's usage.
+                let flags = prev.key_ext_flags()?;
+                if !flags.is_ca() {
+                    dev_err!(
+                        &self.dev,
+                        "Certificate issuer lacks the CA basic constraint\n"
+                    );
+                    return Err(EKEYREJECTED);
+                }
+
+                if prev.raw_subject() != cert.raw_issuer() {
+                    dev_err!(
+                        &self.dev,
+                        "Certificate issuer does not match the previous subject\n"
+                    );
+                    return Err(EKEYREJECTED);
+                }
+
+                prev.verify_signed(&cert)?;
+            }
+
+            let _ = prev_cert.replace(cert);
+            offset += cert_len;
+            cert_count += 1;
+        }
+
+        // A chain must contain at least a root CA and a leaf certificate;
+        // a single certificate would receive no signature verification.
+        if cert_count < 2 {
+            dev_err!(
+                &self.dev,
+                "Certificate chain must contain at least a root and a leaf\n"
+            );
+            return Err(EKEYREJECTED);
+        }
+
+        let Some(mut leaf) = prev_cert.take() else {
+            return Err(EPROTO);
+        };
+
+        let flags = leaf.key_ext_flags()?;
+        if flags.is_ca() || !flags.digital_signature() {
+            dev_err!(&self.dev, "Invalid leaf certificate constraints\n");
+            return Err(EKEYREJECTED);
+        }
+
+        // The leaf key is the same for all slots (MULT_KEY_CAP == 0),
+        // so just store the first one.
+        if self.leaf_key.is_none() {
+            self.leaf_key = leaf.take_public_key();
+        }
+
+        if let Some(validate) = self.validate {
+            // SAFETY: Call the `validate` function provided with a valid
+            // certificate pointer, which the callback must not modify or
+            // free.
+            let rc = unsafe { validate(self.dev.as_raw(), slot, leaf.as_raw()) };
+            to_result(rc)?;
+        }
+
+        Ok(())
+    }
 }
-- 
2.56.0

