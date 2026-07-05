Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597AF37104C;
	Sun,  5 Jul 2026 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289308; cv=none; b=JFvT/0NQ0xlPD4Qya3plkH+xkaiJ+ByD+lvQxdvRChJhpvap0UvZ5IJ/zWUvyD/y9SGYZtb4kvxO+I2HKhLcjjyD0DhVA+baIHzZafFE3tyFV1c/EjKi/GY6oO0RqVCFafLfPJyDZdFPuFJkS8Ecj1fPZVIcqacBDInFgMouzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289308; c=relaxed/simple;
	bh=SLmk+Iz1/m2eWmJv69fQ1oMu2wKbvyAJdigr/UnqJyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svL3b1QnPlMslseMRhQjVnUwEkU1nToxrTmY+91/oIg22izXddTqw0klIj2Zy6rxF3I7AHtxqVZPLko0t4+j48nIGBfB5ac1xmZcGjqav2xufK98P8T8p71aqDK5rWbU9TEc/s6lpoCMBxk/05WT3CHlpkgpD08s70oAuVo9+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxzcO0J+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxzcO0J+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F721F00A3D;
	Sun,  5 Jul 2026 22:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289305;
	bh=p3oDS7c2h61nO4HkxdUHBUVFisb5+8sXX4ESQw3qy6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxzcO0J+1ZXPutEPeJqG4N/6uHPzbfVxcTs79lhSLCMU2d7AFhR+51PxD/e2rqOr7
	 3ieDcVtEXcUIJ05YIjEbUuBFWSpcq6BbWI1UiJ0ZDVZ1bJaAa1QKYCz0m/42TCbG6l
	 Rsd9YcRwJjoMBX2xRMsl+bMZjUZq0CwWT5+aLtlTqJ5pZEP+3kqpHP8Sdt0DwPkJTT
	 EceRN3T4TpHEOI7P6Et9hJFIrBLaifOCCUdgwy56UJr7Pj76gt1ZSgcTaXeSvSTRgr
	 5+1+tlIZW7Qs9/t1jawZQZaxFqKi6KQkuPVQ4zIV2WPwmUmjYTGZDXc5gr8IrRbRLC
	 8kzYlw8fQKCQQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02C4EF40068;
	Sun,  5 Jul 2026 18:08:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:08:24 -0400
X-ME-Sender: <xms:19VKajMUdCyC8e7VlbXSdCFyw-uErzzPab4BZFOtjRjYW2E1eXCAyQ>
    <xme:19VKauYhOCJiP1SqhsbH2sLu90DlErY6L7G6q-_LxlDRDtC7-ORdiVgggR3qWCaV0
    DYmgwWww7RxPNvbAbSs-OYUhUcbfCTKiOgrVGPCm2aSEnJTk7MMtyQ>
X-ME-Received: <xmr:19VKai8Pan0RV5VdrF7FkZefKRIajectjRoGVefDviSrpc6wG_zvdD9FQLyyvy-Z3x86OHbjCvSef8mRVej_3Eoif_v67ZUMa7Y>
X-ME-Proxy-Cause: dmFkZTEytlcHsVvamBeWl0LUYi3rLOxxE9ueqAwgeK++6tDpJzCbB/T5/0uO7CqKuSgynd
    1DUmueIpJnrWsgp/iT25AUXdVWS/Lkc40H4QmZlve15+UteQxPcf1QScrB3YbQy992Vq0m
    /KzXWfH9Rs+mWeQARdT2T3jT+RZzkrrebJnMvIJdUxg+7M7KalPEVVzpcWwqkDY1J0lNlt
    vNsCIo72xVvdhIx/s2HKPbxSRIRi8BPmXl4LBfCNXrB8VDHPzBmIkbknfTJPpfNkaPYY+D
    yCvcgYY7GlQv1nss0zSunxxr7FG9HgCk4BLVPbxAvI2F8i9osH/1ArWtbiprUBIOrbakB2
    chR9kaiLNheyscwTwvvROa2bW52IwXS9GpKS8bnu9r8Ewj6QVbr5QymW3gK3W2dcbHZCUl
    yizBVwwjuGDihB3GPpvlc/kpdUZuanDBpJArRbBWlDiJDZXJAXr1MPpfk6p9B/VyqkbB+/
    Fzy/1YPzokW5Srugx3QWZ6amcHeyLWyFkNDqz/YSwlGTwDtu6o5XyZpFcuKJqqqOFv08Rr
    pL4xPYbFgOJZs+Dv+RnhqvJYPrlY0TzXo5F2NncklvlFnyPTWWXzu2dWKSkmL2S0ZniLb6
    Yjl+JP3tINrpAbQp46qbkMFmtBlP3xXhi/iW9zTlSVIoo52Zhfe4pLMn4AKg
X-ME-Proxy: <xmx:19VKavSX7Ojsk6cO44cptfoPujzvD9klg_hfFnrKAjjP_wYfyLXiSA>
    <xmx:19VKascj2N1iS-EEMoH-CLBKBnRa8SyXcUbzoWIhe1DQk2IzF8wtug>
    <xmx:19VKahQHFWP5h8v4Lb5ofuK4DiSlUIK3GAsaT_E7igGp-DJ4OZX4HQ>
    <xmx:19VKaoLT3U4IlW_m08XOorVXqVZk6YRDNTrmVK9S8qskZCSLzqf61w>
    <xmx:2NVKauJRVHEEz-ApfXdfnPSHbgAY7cQX152iz15IySwo3o4y9S2dism5>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:23 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Lukas Wunner <lukas@wunner.de>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 02/15] tools: ynl: Teach pyynl to handle blobs
Date: Sun,  5 Jul 2026 15:08:06 -0700
Message-ID: <20260705220819.2472765-3-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic "device evidence" facility wants to convey large objects
(certificate chains, measurements) and support various security commands
relative to that evidence (like validate) [1].

Update pyynl to understand the "bloblen" property indicates:
* the associated attribute is a variable length byte array
* it is multi-attr where each message with the same attribute represents
  chunks of the byte array
* the byte array's size is conveyed in a scalar attribute named by the
  "bloblen" property.
* the attribute identified by "bloblen" always arrives in a message before
  the first chunk of the associated blob

A "multi-attr" without "bloblen" retains the legacy behavior where repeated
reception of the same attribute across messages results in a new instance
of the object. The new behavior causes repeated reception of an
attribute to be treated as filling consecutive bytes of an array.

Assisted-by: Codex:GPT-5
[codex: drafted initial python changes]
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 tools/net/ynl/pyynl/lib/nlspec.py | 12 ++++++
 tools/net/ynl/pyynl/lib/ynl.py    | 62 ++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 0469a0e270d0..4764263968ea 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -172,6 +172,7 @@ class SpecAttr(SpecElement):
         selector      string, name of attribute used to select
                       sub-message type
 
+        bloblen       string, name of attr which reports the blob length
         is_auto_scalar bool, attr is a variable-size scalar
     """
     def __init__(self, family, attr_set, yaml, value):
@@ -181,6 +182,7 @@ class SpecAttr(SpecElement):
         self.value = value
         self.attr_set = attr_set
         self.is_multi = yaml.get('multi-attr', False)
+        self.bloblen = yaml.get('bloblen')
         self.struct_name = yaml.get('struct')
         self.sub_type = yaml.get('sub-type')
         self.byte_order = yaml.get('byte-order')
@@ -191,6 +193,10 @@ class SpecAttr(SpecElement):
 
         self.is_auto_scalar = self.type in ("sint", "uint")
 
+        if self.bloblen and not self.is_multi:
+            raise SpecException(
+                f"Attribute '{attr_set.name}.{self.name}' has bloblen without multi-attr")
+
 
 class SpecAttrSet(SpecElement):
     """ Netlink Attribute Set class.
@@ -355,6 +361,8 @@ class SpecOperation(SpecElement):
         attr_set        attribute set name
         fixed_header    string, optional name of fixed header struct
 
+        dump_blob_attrs set, reply blob attribute names which may span messages
+
         yaml            raw spec as loaded from the spec file
     """
     def __init__(self, family, yaml, req_value, rsp_value):
@@ -369,6 +377,7 @@ class SpecOperation(SpecElement):
         self.is_async = 'notify' in yaml or 'event' in yaml
         self.is_resv = not self.is_async and not self.is_call
         self.fixed_header = self.yaml.get('fixed-header', family.fixed_header)
+        self.dump_blob_attrs = frozenset()
 
         # Added by resolve:
         self.attr_set = None
@@ -388,6 +397,9 @@ class SpecOperation(SpecElement):
             raise SpecException(f"Can't resolve attribute set for op '{self.name}'")
         if attr_set_name:
             self.attr_set = self.family.attr_sets[attr_set_name]
+            reply_attrs = self.yaml.get('dump', {}).get('reply', {}).get('attributes', ())
+            self.dump_blob_attrs = frozenset(
+                name for name in reply_attrs if self.attr_set[name].bloblen)
 
 
 class SpecMcastGroup(SpecElement):
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 092d132edec1..f21b68043bd3 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -998,6 +998,47 @@ class YnlFamily(SpecFamily):
         else:
             rsp[name] = [decoded]
 
+    def _blob_fill(self, buf, off, chunks, name):
+        for chunk in chunks:
+            end = off + len(chunk)
+            if end > len(buf):
+                raise YnlException(f"Blob '{name}' data exceeds reported length")
+            buf[off:end] = chunk
+            off = end
+        return off
+
+    def _blob_init(self, op, rsp, blob_attrs):
+        """
+        Start a new blob object. Preallocate each blob payload using the
+        length carried ahead of the data and copy in the first chunk(s).
+        Return the per-attribute write offsets for any following messages.
+        """
+        offsets = {}
+        for name in blob_attrs:
+            if name not in rsp:
+                continue
+            length = rsp.get(op.attr_set[name].bloblen, 0)
+            buf = bytearray(length)
+            offsets[name] = self._blob_fill(buf, 0, rsp[name], name)
+            rsp[name] = buf
+        return offsets
+
+    def _blob_extend(self, rsp, update, blob_attrs, offsets):
+        """
+        Continue filling the previous object's blob(s) when the current
+        message carries only blob continuation attributes.
+        """
+        if any(name in rsp and name not in blob_attrs for name in update):
+            return False
+
+        for name, value in update.items():
+            if name in blob_attrs and name in rsp:
+                offsets[name] = self._blob_fill(rsp[name], offsets.get(name, 0),
+                                                value, name)
+            else:
+                rsp[name] = value
+        return True
+
     def _resolve_selector(self, attr_spec, search_attrs):
         sub_msg = attr_spec.sub_message
         if sub_msg not in self.sub_msgs:
@@ -1356,7 +1397,10 @@ class YnlFamily(SpecFamily):
         for (method, vals, flags) in ops:
             op = self.ops[method]
             msg = self._encode_message(op, vals, flags, req_seq)
-            reqs_by_seq[req_seq] = (op, vals, msg, flags)
+            blob_attrs = None
+            if Netlink.NLM_F_DUMP in flags:
+                blob_attrs = op.dump_blob_attrs or None
+            reqs_by_seq[req_seq] = (op, vals, msg, flags, blob_attrs)
             payload += msg
             req_seq += 1
 
@@ -1365,6 +1409,7 @@ class YnlFamily(SpecFamily):
         done = False
         rsp = []
         op_rsp = []
+        blob_off = {}
         while not done:
             reply, ancdata = self._recvmsg()
             nsid = self._decode_nsid(ancdata)
@@ -1372,13 +1417,14 @@ class YnlFamily(SpecFamily):
             self._recv_dbg_print(reply, nms)
             for nl_msg in nms:
                 if nl_msg.nl_seq in reqs_by_seq:
-                    (op, vals, req_msg, req_flags) = reqs_by_seq[nl_msg.nl_seq]
+                    (op, vals, req_msg, req_flags, blob_attrs) = reqs_by_seq[nl_msg.nl_seq]
                     if nl_msg.extack:
                         nl_msg.annotate_extack(op.attr_set)
                         self._decode_extack(req_msg, op, nl_msg.extack, vals)
                 else:
                     op = None
                     req_flags = []
+                    blob_attrs = None
 
                 if nl_msg.error:
                     raise NlError(nl_msg)
@@ -1388,6 +1434,11 @@ class YnlFamily(SpecFamily):
                         print(nl_msg)
 
                     if Netlink.NLM_F_DUMP in req_flags:
+                        if blob_attrs:
+                            for obj in op_rsp:
+                                for name in blob_attrs:
+                                    if isinstance(obj.get(name), bytearray):
+                                        obj[name] = bytes(obj[name])
                         rsp.append(op_rsp)
                     elif not op_rsp:
                         rsp.append(None)
@@ -1414,6 +1465,13 @@ class YnlFamily(SpecFamily):
                 rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
                 if op.fixed_header:
                     rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
+
+                if blob_attrs:
+                    if op_rsp and self._blob_extend(op_rsp[-1], rsp_msg,
+                                                    blob_attrs, blob_off):
+                        continue
+                    blob_off = self._blob_init(op, rsp_msg, blob_attrs)
+
                 op_rsp.append(rsp_msg)
 
         return rsp
-- 
2.54.0

