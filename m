Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286938;
	b=jSExCESvcW+DRv8kJkxOAtW5vXKccceKFa8EeB1ZdPH+iOoqT3s0RX8AVz9UI1kVeuZM
	 b+9RQ0YVnXqIOkkkeI+z/VBTSuw4OUkDByXjPzkuKjRTCHVwHV/BnneQ5TE/dt1ZqnMCV
	 RE2B1WRx9Rll81SkbdXTIJqBXxrcXyHPULIhblLrBrseB88F+25cwQF1xT3F2Qr1K0ook
	 7f89nUf55tjfGeeDV0BafB60Bb0Y0T+X88aqYcym1sgIDUc2By7l4DnsZQZxR52L/a/4J
	 zZ+gJbepaS6cr8MwVkL3umOkGuHKuE+FoG1YhiG7wWvaXDhoHyaKsAfXDsNyBtsIThQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=QH3sulygYhhWPnxKAIiCVfW20U0EPZtpLbJ/h67Rp6Y=;
	b=VoOQivnLmXrGi4JtVhguutNnOW5eqEcnV0kgswJqjd1JUFjJfwPYNjSMweD8fIIJSeaD
	 Tf67O0Vb2r7bHDGAFaYag1JSmtAhZ1v03O3inAjzSDcpqvws2oNWCrlj5no/rWbJgtKJl
	 v08oy4LcW1+IChoah1d8Xy29F0/Ir0HyNUDAW+F74TxOTBScrFAkrsciufF5f3bL7ZJ/E
	 KPt3bKf2P0qzGaTbxWEhglbu8DC4S1UtJ3Aq5UYJatYODfmquWqnHTfIlzfNX2datD9wI
	 DPzZ55G2NiG3T6NHJpRFSY6EBQgR+N7TOe/t9bWrgjn1uQdhlKbp146tVIISm4J/yBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZsmBlEoE;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7296606B0A9
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 05:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7296606B0A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZsmBlEoE
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so11744035e9.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Nov 2026 21:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286936; x=1794891736; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH3sulygYhhWPnxKAIiCVfW20U0EPZtpLbJ/h67Rp6Y=;
        b=ZsmBlEoEGABLfHdoklEfimEeGrwDA0ApsG2hu2K/k3P5Sz6q5wztASFujjeK/5f5+y
         IjvAgxWEBmoS0u15lQaMyFzvvdZDCMDsrIK/+70RHvf4b3C0izK+BXYx1B0cMxYed9iU
         v13Jsac9kEWoDDvebVnYgO5DzAjDv8WBhZFxMgpxUugUH28OMOmlr/oiDtwM/yUVhkDZ
         VGe9Uy+wD4Ef71SP6taGhYxiL6k+BpCLkXG3oFvch/QKNlZ43PAvUWPqDTizx3zYTJ1o
         QqI2a+aKQdhk9UJiejPO89a4DnKPmlPkTPmwJ4deMrZX3yb0XqTzUxFNERmRnESp+D9T
         8XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286936; x=1794891736;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH3sulygYhhWPnxKAIiCVfW20U0EPZtpLbJ/h67Rp6Y=;
        b=E0KDCKC8o2I7GKe6hMbJHUEDjTVSmdg+xBXzOy2/N+kySuEc9ZLFbnVQHOBCrYBRA6
         H+64a7R66JHv5uEgOrprRN8pUkNukjifpjVuQXsoWUhYQzmEZzutW5PCsrzFSM/4m0po
         rHDAvWFMHOCh7MIonkUQsdo4hytJraqCTEsqQutibX5fVyPHYWAapzNlS1kyuJse8l1g
         siWEU75uh71l0wDuEuCcyWHbKqIuZQIv7+JmgFxf4Q+Kckzs4IrZtTCmGmT4+9KH4IUW
         GFI6GEH65q/tqasEUD/wfRBY0pkkCKLTDeFGeOnC+ksN/MfODBIG4I4mnjzl+uWZ1M8s
         YvnQ==
X-Forwarded-Encrypted: i=1; AL+hErHGHQWp0tg9Zsz62r6kyksa0I4INgu1nGemQkneE9XZThStjewudGWhfNuIFBs3r/yKPhbuBqid1Tc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sOu+9XykGfReqpRydZFAsqCRPZUwDwLT2nE6WPZODRlUMHymd
	lgOSQNU5BTV1Db6CzG6NUZ4xn+O5YWFBeF9lioxoaTE3ff7UhElmmVHSLoY+r512QCyZvZ1tvqc
	IBz1shjtvhUu5H1icCw==
X-Received: from wrvd15.prod.google.com ([2002:a5d:538f:0:b0:48e:1449:1f6c])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b9b:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ba023577bfmr24128895e9.30.1794286936085;
 Mon, 09 Nov 2026 21:02:16 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:53 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-11-tarunsahu@google.com>
Subject: [PATCH v4 10/19] liveupdate: Add feature header to struct luo_session_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Precede each serialized session entry in the LUO session KHO block set
with struct kho_ser_hdr via DECLARE_KHO_SER so future session features can
append fields to struct luo_session_ser without breaking compatibility
between adjacent kernels.

Size session block-set entries using kho_ser_size(luo_session_ser),
initialize each entry feature header during luo_session_serialize(), and
validate the incoming feature header in luo_session_deserialize_one()
before accessing the struct luo_session_ser payload.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h     |  6 +++---
 kernel/liveupdate/luo_session.c | 38 ++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index dfa7ea434d0d..425c52c494f1 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -132,15 +132,15 @@ static_assert(!IS_ENABLED(CONFIG_64BIT) ||
  * between kernels via Kexec Handover. An array of these structures (one per
  * session) is created and passed to the target kernel, allowing it to
  * reconstruct the session context.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_session_ser {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	DECLARE_KHOSER_PTR(file_set_ser, struct luo_file_set_ser *);
 };
 
-static_assert(sizeof(struct luo_session_ser) == 72);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_session_ser) == 8);
+DECLARE_KHO_SER(luo_session_ser, 72, 0, 0);
 
 /* The max size is set so it can be reliably used during in serialization */
 #define LIVEUPDATE_FLB_COMPAT_LENGTH	48
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index df667fe15fb2..641bd67ce76e 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -131,7 +131,7 @@ struct luo_session_global {
 	struct luo_session_header outgoing;
 };
 
-#define LUO_SESSION_SER_SIZE (sizeof(struct luo_session_ser) + \
+#define LUO_SESSION_SER_SIZE (kho_ser_size(luo_session_ser) + \
 			      sizeof(struct luo_file_set_ser))
 
 static struct luo_session_global luo_session_global = {
@@ -557,23 +557,33 @@ int __init luo_session_setup_incoming(u64 sessions_pa)
 	return 0;
 }
 
-static struct luo_session_ser *luo_session_ser_init(void *mem)
+static struct luo_session_ser *
+luo_session_ser_init(DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr))
 {
 	struct luo_file_set_ser *file_set_ser;
-	struct luo_session_ser *ser = mem;
+	struct luo_session_ser *ser;
+
+	kho_ser_init(fhdr, luo_session_ser);
+	file_set_ser = (void *)fhdr + kho_ser_size(luo_session_ser);
 
-	file_set_ser = mem + sizeof(struct luo_session_ser);
+	ser = kho_ser_payload(fhdr, luo_session_ser);
 	KHOSER_STORE_PTR(ser->file_set_ser, file_set_ser);
 
 	return ser;
 }
 
 static int luo_session_deserialize_one(struct luo_session_header *sh,
-				       struct luo_session_ser *ser)
+				       DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr))
 {
+	struct luo_session_ser *ser;
 	struct luo_session *session;
 	int err;
 
+	err = kho_ser_validate(fhdr, luo_session_ser);
+	if (err)
+		return err;
+
+	ser = kho_ser_payload(fhdr, luo_session_ser);
 	session = luo_session_alloc(ser->name);
 	if (IS_ERR(session)) {
 		pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
@@ -606,7 +616,7 @@ int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
 	static bool is_deserialized;
-	struct luo_session_ser *ser;
+	DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr);
 	struct kho_block_set_it it;
 	static int saved_err;
 	int err;
@@ -635,8 +645,8 @@ int luo_session_deserialize(void)
 	 * reliably reset devices and reclaim memory.
 	 */
 	kho_block_set_it_init(&it, &sh->block_set);
-	while ((ser = kho_block_set_it_read_entry(&it))) {
-		err = luo_session_deserialize_one(sh, ser);
+	while ((fhdr = kho_block_set_it_read_entry(&it))) {
+		err = luo_session_deserialize_one(sh, fhdr);
 		if (err)
 			goto save_err;
 	}
@@ -665,15 +675,17 @@ int luo_session_serialize(void)
 	kho_block_set_it_init(&it, &sh->block_set);
 
 	list_for_each_entry(session, &sh->list, list) {
-		struct luo_session_ser *ser = kho_block_set_it_reserve_entry(&it);
+		DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr) =
+			kho_block_set_it_reserve_entry(&it);
+		struct luo_session_ser *ser;
 
 		/* This should not fail normally as blocks were pre-allocated */
-		if (WARN_ON_ONCE(!ser)) {
+		if (WARN_ON_ONCE(!fhdr)) {
 			err = -ENOSPC;
 			goto err_undo;
 		}
 
-		ser = luo_session_ser_init(ser);
+		ser = luo_session_ser_init(fhdr);
 		err = luo_session_freeze_one(session, ser);
 		if (err) {
 			kho_block_set_it_prev(&it);
@@ -691,7 +703,9 @@ int luo_session_serialize(void)
 
 err_undo:
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
+		DECLARE_KHO_SER_HDR(luo_session_ser, *fhdr) =
+			kho_block_set_it_prev(&it);
+		struct luo_session_ser *ser = kho_ser_payload(fhdr, luo_session_ser);
 
 		luo_session_unfreeze_one(session, ser);
 		memset(ser->name, 0, sizeof(ser->name));
-- 
2.56.0.506.g506a7eabc5-goog

