Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF64360EC0;
	Sun,  5 Jul 2026 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289308; cv=none; b=TaDopSImj+Hm0s5E782tp8DDNZfYS/8d5J5WazzRhTx3FFJRTyC90MEcltg+KbDgIFY8GgWgH8myXbV+B9fRu1/ibKn25PgQ1KkBPQIs5JJtICUWU9OzaMdzEX8SIAd7xKpgwGpPeUHmJAmlpDJFoX7D5bpVvXIyfwL4ooneTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289308; c=relaxed/simple;
	bh=d/uvAt7p9ViCpZFjRxotUP56iOL4IJuGpkD0Imx62nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuWz58E4/QOz12v3LqO3LHdpS/XH8aHg7PlZyqJupgbUiM/f1wegpM7bz1YWMWJ4q0fQ3056ZL4g3/00MRyX242Qt0edS/n4rQGaFuDoCa5ybYazF9DoROav3/NLKLt3tGuCHBppSjxeC2tILu6f1QveXM+PKtqfcRd/P40Kjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES0myYrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES0myYrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BD1F00A3A;
	Sun,  5 Jul 2026 22:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289306;
	bh=nV1LB2wX4l3Zds4hK/BfunzcqpRfA4Wxf5edcMYDhy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ES0myYrG5tbc4LuFQZsf16xU7axyc8ULTRhZyxXVS0X3CywvxbRd/71BXijBvPhOz
	 7JJQzYnkzw2+IDa1+SJERLdqbrrBO+7uWSKW1Rt9MAunBUltFgTRhkjEhraX3ifMVE
	 UvN8kOamy2ND3v8UMnqERlMNIzSWWjxxKN8sezJBUkSs73vWlj537p8ZmleVhkSAE1
	 JAGS1VP51qc76AJ/p9pBLc6lzQoalqMR4tn7NxSpetOYk7WuiP3DAWucNNZosqGByc
	 4fwe4ikus8L3eZ2pg+y3HifFxVXeXxuEey5tOrWTk4jYoWDOX5Cn1/cuafEWkxEn8M
	 aCzb5nZYrcxeQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6ADB6F40068;
	Sun,  5 Jul 2026 18:08:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 18:08:25 -0400
X-ME-Sender: <xms:2dVKalsLajiRr85J2gAGhMNp3FKl9q-oyuYlM9DOn71EtyG_nc-jNw>
    <xme:2dVKau5N4L45-0w8Ddf-yy_Zovl2B6Tv9Z9oKuWmkuOb7gar6cUokjFtF3T6djzQH
    yUo2glyl9VSkw8eeDkLwFHHXMQYAFnmiM7urc4st5RN9Wov3x4DKHca>
X-ME-Received: <xmr:2dVKapf-8885Jgb0fqrFZisV0_o22QbdhMuDBG9QG8lp7Fh-dbP2FuhAV1fvSpJ4Vhe7NKTxT8kSHL8YWG1q-Az8TqRQD0TbAUA>
X-ME-Proxy-Cause: dmFkZTE1Svb0/5bSwQdApfC+U6dL2gZmcrd9ojXibA3ZPjdRULNU5Hv6XcSZAiVmHlblJI
    nRX9hSbKdMc1VBBSNrg666lQ6CcxEKZNgRRhzoR+QVqivDAF8Ujpvq/sfwWeq00eff+oCV
    k+EAKx9dDDvlSNZpJrxsVljQsQMgyQ9RNoP+RhvbatP76z4YPYpVZPU3c+ytqINJzeMlzp
    xdbtMWSzLFkpQclwYZ9oBIV0jcHeGN1huLPXqxMJHBfSwmwIEPRvAZ+RfJoy6strCE5at3
    qN7iLS5baLvWjPcKLAEfU4vGEdxDYPZeXWMso1Wj3vXoiv4p/Pm4UGhQ9Jwx+A5NdM7rVq
    Cxig7IqWh9O4G0g52+BadRCdPmoIRApa4w96TUWjRxU/jkGAetA69oDP9WC/E5oo4vZ9K6
    Hbs4C2MzkhpJS6Wf89xWXJaAS/Lg/ybsP8nDh+hEi1RAmjKI2AwLnlA6I9RSd9K9T6itU8
    q848CvjvNsXN2ILQlEldk5HYWD5hOxhgJ0nEf/onrrEh6Q8g+mHNHehlaKYZmChmSiRf7y
    SrSNHWTNg5gcLTkEOsJr+e0huMJrbvu+ID7cko6iOgKsMKq0aQxL8PVaUzOEOTNFNY0znA
    pqCyz4q/284ifCur1cruT6b/n5riM9d91V5uT+VxfvlJDSULLvAHgUWZKrZw
X-ME-Proxy: <xmx:2dVKajz3nt5Z5CrzU1blxZrRS5GE-glNIdZvsYHONOKFSN6xAic8bw>
    <xmx:2dVKam9lxQJWr1yBxVLoMpGzL5BgEp3NlO5KVRxk7o1Ek76Rt2sfQA>
    <xmx:2dVKapzr9nuZUedq0321GhlDJDCX1KRetJ0pVdfem3_AoxYGZac04Q>
    <xmx:2dVKampRvnebDcDI7e-yJhwY5Nu5xxvr4nylHOPcIeIu9iTqPV1nKg>
    <xmx:2dVKaqpd6Msq52Fd9Sdj8GHzj51sSNSAKXt6GY3eyoH0QnA9CwmxwkUJ>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:24 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Lukas Wunner <lukas@wunner.de>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 03/15] tools: ynl: Teach ynl_gen_c to validate and dump 'blob' attributes
Date: Sun,  5 Jul 2026 15:08:07 -0700
Message-ID: <20260705220819.2472765-4-djbw@kernel.org>
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

Now that blobs are recognized by pyynl and coalesced over successive
netlink messages, do the same for the generated C. Recall that blobs
support large objects for protocols like SPDM.

With blobs the generator can assume that the length of the blob will be
conveyed in the response messages before the blob data message(s). Update
the C generation to:

* Mark when a given operation may have blobs (objects that need more than
  one message to fill) with a new ynl_more_cb_t in the dump state.

* Use @more() determine when to continue filling a partially received
  blob, and check if the end of the message stream is reached without
  receiving all of its data.

* Pre-allocate the blob and parse successive messages into that shared
  object.

This proposal is the follow up to a discussion [1] where an alternative
solution of adding an @offset attribute to make each chunk standalone was
discarded. That approach commits userspace to inefficient attribute
reassembly where it needs to retrieve a series of structures with offset
properties and then reassemble them into the full blob.

Assisted-by: Codex:GPT-5.5
[codex: helped with typing out the code generation]
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h     |  4 ++
 tools/net/ynl/lib/ynl.h          | 14 ++++++
 tools/net/ynl/lib/ynl.c          | 33 +++++++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py | 80 +++++++++++++++++++++++++++++---
 4 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index ced7dce44efb..dba98cf78204 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -41,6 +41,9 @@ enum ynl_parse_result {
 
 typedef int (*ynl_parse_cb_t)(const struct nlmsghdr *nlh,
 			      struct ynl_parse_arg *yarg);
+typedef bool (*ynl_more_cb_t)(void *data);
+
+struct ynl_blob *ynl_blob_alloc(unsigned int len);
 
 struct ynl_policy_attr {
 	enum ynl_policy_type type:8;
@@ -123,6 +126,7 @@ struct ynl_dump_state {
 	struct ynl_dump_list_type *last;
 	size_t alloc_sz;
 	ynl_parse_cb_t cb;
+	ynl_more_cb_t more;
 	__u32 rsp_cmd;
 };
 
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index db7c0591a63f..9c50b068ee83 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -100,6 +100,20 @@ struct ynl_string {
 	char str[];
 };
 
+/**
+ * struct ynl_blob - variable-length blob attribute
+ * @len: length of the blob data
+ * @data: value of the blob attribute
+ *
+ * Parsed binary value. This struct is used for variable-length blob values
+ * that may be built from one or more attributes spanning multiple netlink
+ * messages.
+ */
+struct ynl_blob {
+	unsigned int len;
+	unsigned char data[];
+};
+
 struct ynl_sock *
 ynl_sock_create(const struct ynl_family *yf, struct ynl_error *e);
 void ynl_sock_destroy(struct ynl_sock *ys);
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 2bcd781111d7..933ee0ad2c51 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -1003,6 +1003,27 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 	return err;
 }
 
+struct ynl_blob *ynl_blob_alloc(unsigned int len)
+{
+	size_t size = sizeof(struct ynl_blob) + len;
+	struct ynl_blob *blob;
+
+	if (size < len)
+		return NULL;
+	blob = malloc(size);
+	if (blob)
+		blob->len = len;
+	return blob;
+}
+
+/* continue filling a blob attribute? */
+static bool ynl_check_more(struct ynl_dump_state *ds)
+{
+	struct ynl_dump_list_type *prev = ds->last;
+
+	return prev && ds->more && ds->more(&prev->data);
+}
+
 static int
 ynl_dump_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *data)
 {
@@ -1015,6 +1036,13 @@ ynl_dump_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *data)
 	if (ret)
 		return ret < 0 ? YNL_PARSE_CB_ERROR : YNL_PARSE_CB_OK;
 
+	if (ynl_check_more(ds)) {
+		yarg = ds->yarg;
+		yarg.data = &ds->last->data;
+
+		return ds->cb(nlh, &yarg);
+	}
+
 	obj = calloc(1, ds->alloc_sz);
 	if (!obj)
 		return YNL_PARSE_CB_ERROR;
@@ -1059,6 +1087,11 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 			goto err_close_list;
 	} while (err > 0);
 
+	if (ynl_check_more(yds)) {
+		yerr(ys, YNL_ERROR_ATTR_MISSING, "Dump ended with an incomplete blob");
+		goto err_close_list;
+	}
+
 	yds->first = ynl_dump_end(yds);
 	return 0;
 
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index cdc3646f2642..f0387004b7cc 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -727,14 +727,20 @@ class TypeMultiAttr(Type):
     def is_multi_val(self):
         return True
 
+    def is_blob(self):
+        return bool(self.bloblen)
+
     def presence_type(self):
-        return 'count'
+        return 'len' if self.is_blob() else 'count'
 
     def _complex_member_type(self, ri):
         if 'type' not in self.attr or self.attr['type'] == 'nest':
             return self.nested_struct_type
-        if self.attr['type'] == 'binary' and 'struct' in self.attr:
-            return None  # use arg_member()
+        if self.attr['type'] == 'binary':
+            if 'struct' in self.attr:
+                return None  # use arg_member()
+            if self.is_blob():
+                return 'struct ynl_blob'
         if self.attr['type'] == 'string':
             return 'struct ynl_string *'
         if self.attr['type'] in scalars:
@@ -747,9 +753,12 @@ class TypeMultiAttr(Type):
         raise Exception(f"Sub-type {self.attr['type']} not supported yet")
 
     def arg_member(self, ri):
-        if self.type == 'binary' and 'struct' in self.attr:
-            return [f'struct {c_lower(self.attr["struct"])} *{self.c_name}',
-                    f'unsigned int n_{self.c_name}']
+        if self.type == 'binary':
+            if 'struct' in self.attr:
+                return [f'struct {c_lower(self.attr["struct"])} *{self.c_name}',
+                        f'unsigned int n_{self.c_name}']
+            if self.is_blob():
+                return [f'struct ynl_blob *{self.c_name}']
         return super().arg_member(ri)
 
     def free_needs_iter(self):
@@ -784,6 +793,24 @@ class TypeMultiAttr(Type):
         return self.base_type._attr_typol()
 
     def _attr_get(self, ri, var):
+        if self.is_blob():
+            length = self.attr_set[self.bloblen]
+            return [
+                f"if (!{var}->{self.c_name})",
+                f"{var}->{self.c_name} = ynl_blob_alloc({var}->{length.c_name});",
+                f"if (!{var}->{self.c_name})",
+                "return YNL_PARSE_CB_ERROR;",
+                f"if ({var}->_len.{self.c_name} > {var}->{self.c_name}->len || " +
+                f"len > {var}->{self.c_name}->len - {var}->_len.{self.c_name})",
+                f'return ynl_error_parse(yarg, "blob data exceeds length '
+                f'({self.attr_set.name}.{self.name})");',
+                f"memcpy({var}->{self.c_name}->data + {var}->_len.{self.c_name}, " +
+                "ynl_attr_data(attr), len);",
+                f"{var}->_len.{self.c_name} += len;"], \
+                ['if (ynl_attr_validate(yarg, attr))', 'return YNL_PARSE_CB_ERROR;',
+                 'len = ynl_attr_data_len(attr);'], \
+                ['unsigned int len;']
+
         return f'n_{self.c_name}++;', None, None
 
     def attr_put(self, ri, var):
@@ -791,6 +818,10 @@ class TypeMultiAttr(Type):
             put_type = self.type
             ri.cw.p(f"for (i = 0; i < {var}->_count.{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
+        elif self.attr['type'] == 'binary' and self.is_blob():
+            ri.cw.p(f"if ({var}->{self.c_name})")
+            ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, " +
+                    f"{var}->{self.c_name}->data, {var}->{self.c_name}->len);")
         elif self.attr['type'] == 'binary' and 'struct' in self.attr:
             ri.cw.p(f"for (i = 0; i < {var}->_count.{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, &{var}->{self.c_name}[i], sizeof(struct {c_lower(self.attr['struct'])}));")
@@ -805,6 +836,10 @@ class TypeMultiAttr(Type):
             raise Exception(f"Put of MultiAttr sub-type {self.attr['type']} not supported yet")
 
     def _setter_lines(self, ri, member, presence):
+        if self.is_blob():
+            return [f"{presence} = {self.c_name}->len;",
+                    f"{member} = malloc(sizeof(*{member}) + {presence});",
+                    f"memcpy({member}, {self.c_name}, sizeof(*{member}) + {presence});"]
         return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
@@ -2164,7 +2199,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             else:
                 raise Exception(f'Not supported sub-type {aspec["sub-type"]}')
         if 'multi-attr' in aspec:
-            multi_attrs.add(arg)
+            if not aspec.bloblen:
+                multi_attrs.add(arg)
         needs_parg |= 'nested-attributes' in aspec
         needs_parg |= 'sub-message' in aspec
 
@@ -2388,6 +2424,33 @@ def parse_rsp_msg(ri, deref=False):
         ri.cw.nl()
 
 
+def _blob_attrs(ri):
+    return [attr for _, attr in ri.struct['reply'].member_list() if attr.bloblen]
+
+
+def print_rsp_more(ri):
+    blob_attrs = _blob_attrs(ri)
+    if not blob_attrs:
+        return
+
+    local_vars = [f'{type_name(ri, "reply", deref=True)} *rsp = data;']
+
+    ri.cw.write_func_prot('static bool',
+                          f'{op_prefix(ri, "reply", deref=True)}_more',
+                          ['void *data'], suffix='')
+    ri.cw.block_start()
+    ri.cw.write_func_lvar(local_vars)
+
+    for attr in blob_attrs:
+        ri.cw.p(f"if (rsp->{attr.c_name} && " +
+                f"rsp->_len.{attr.c_name} < rsp->{attr.c_name}->len)")
+        ri.cw.p('return true;')
+
+    ri.cw.p('return false;')
+    ri.cw.block_end()
+    ri.cw.nl()
+
+
 def print_req(ri):
     ret_ok = '0'
     ret_err = '-1'
@@ -2482,6 +2545,8 @@ def print_dump(ri):
     ri.cw.p("yds.yarg.data = NULL;")
     ri.cw.p(f"yds.alloc_sz = sizeof({type_name(ri, rdir(direction))});")
     ri.cw.p(f"yds.cb = {op_prefix(ri, 'reply', deref=True)}_parse;")
+    if _blob_attrs(ri):
+        ri.cw.p(f"yds.more = {op_prefix(ri, 'reply', deref=True)}_more;")
     if ri.op.value is not None:
         ri.cw.p(f'yds.rsp_cmd = {ri.op.enum_name};')
     else:
@@ -3731,6 +3796,7 @@ def main():
                         parse_rsp_msg(ri, deref=True)
                     print_req_free(ri)
                     print_dump_type_free(ri)
+                    print_rsp_more(ri)
                     print_dump(ri)
                     cw.nl()
 
-- 
2.54.0

