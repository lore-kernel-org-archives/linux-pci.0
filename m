Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087235E940;
	Sun,  5 Jul 2026 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289311; cv=none; b=H8rDp9n07+6PKPqwR7Tj3xeJDAcSWXDkMSSAgDFZQvs9pr9pdP2QAz/aLWlFWjfqRbHJVds2up4jypwD0RDmSaNA7f1fTgshUo2ZROkNsm/GixdEZ0KcKCiauZ5SMn66tRh+AyhLzqBbFQijqkjZ4vr30CSRyfWriJUcceRa22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289311; c=relaxed/simple;
	bh=9IL85OiBzn6Tmu3FYok257FcIrQ4ccSMJ03HCfBMLmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXLQVH9+NhJJa7DWilt+inqA6IV6Mq2AS23yUqexyxC+esL4ZhoGC1P8F2DtJIfzmOHlsYBJ9Und/n3MQyabbmPo3n9Z8w+P0vpHvIB5RtKIiKs5DR5QNZFbpebl07l4P6QFydBakp3rAg7YFqAbN286TYrxq827IHPx4P64qLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGVoMPu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGVoMPu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372141F00A3E;
	Sun,  5 Jul 2026 22:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289309;
	bh=4EJAqnyJ3gwVEsDN294bWudIOzsKViUlyMr3YK6wG/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGVoMPu0hmZaK3K3qtrRd1rlDZZALM1J7TTt+Jt+6+DTd6PUIxHSa84XvVFQg8YmF
	 Kvog+GN7Lt2R6G9G3+tuXVNb43WSZWlWKhQd9U7YD9Xec3emANPZ3CsAIX3QwwBCqv
	 AGQMAOgAoDp3U6sXsAdTwGLvll4wuRTswtdafg7gTJwiWhMZyGREd6fC6ll9Q5RG0y
	 gWsOFfoMaMNEaQju/yWuRvAODnzkonCubo746QohX1LJyiavn2fOmW0j0P1dcdDH0v
	 Ztbctc6U+3JLpg8QGfOBWIGFaH13BufMj++dp5VPpIDbHler17xKS5pYnPDoneS508
	 ISvGcHnPYFXcA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 72FCDF40068;
	Sun,  5 Jul 2026 18:08:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 05 Jul 2026 18:08:28 -0400
X-ME-Sender: <xms:3NVKauWHMQEzYnGT0V_Fl_ZWxHaXvuBXXQghkH0nMPr3jPWNK61fXw>
    <xme:3NVKaitsSQpEn1B7wV_hGJtNnCFqO7GgmgIMBceegZ0bbqfFP67I-slad4CLlGNo8
    P-WpNGIQIXERR-JjDENgG4sQJ3UVXa-aS_Pfg4WyJToeymG_x6PfNo>
X-ME-Received: <xmr:3NVKah6-riM7yaDHyZzD13h6Yrx4XMitqT1oUxtf2jcBaJ1b8Ps990XhbupIVvwtWystK-rvWJkxECS7p3cLlwpAKcIayUsH7YA>
X-ME-Proxy-Cause: dmFkZTGeuuxUOsQK9falD58mOe58PAU0fb4BY3UVa/ZU5fWgqdzCC6mL4jkT4APmcrOadx
    I0LJr8EbblHt/c+XwD49RmYPmQiiab2E3gr/gmNphscEDfG7Lsw7AoFFanuwCARjdH9MKd
    fp77c9TJrBDvAkuKkYEWouWkPOD0cbASE09qM3JXZ07zPRdo3HAipyrRM3XhYxuco8CVWw
    E2KR9PXEW5gaCxRV2J+ibi5MLieLQKq0j5pa7aqJm272LoLumQh0hDhQ5M2MdP8t4CgDwP
    bFd/XKGkj8npVzbCz1D64auUcWLmcQVVPYQVofMkDLKOyy03UoS9hxTxY3Ki7iVRx7U+m/
    rKRUBv5UxGPPn+D6hnFyCW8bI2nq9GlUsy+rtrFlt/8CXOw7Ob4g0xaAbk+rr4SMFiocE6
    AjDaopDdNk8vwijAT8BUYi8KUEEM0Jo21Ex2bYDLvguLzeKOkDx6UzgMdcXNxt2axdqGT3
    QjG0LQjc04FJdmMblszlY1XNJPfKDNpCbM7pUJmgW/q1mk5sTcJdHXj2Pyg0U1l0X9rK0p
    q4SuZW5jQA+xk1PxY67JOf80meCV21eo9QsGiQizhOdddcqtKvU3wn9Y97tPZFVq6+5lUu
    DjwNQ9L4z0Lk+SPwKNl/xNPnFyFMlXkRRubolq8vMUMEaPXRHpT2qkPniGiw
X-ME-Proxy: <xmx:3NVKalRlSMrBXhucuRkEYxMMzY_NxtLbWHGL31bSNQ2pCKnfwIhOxw>
    <xmx:3NVKaku-POrYD8HB9254CAf7gfoQlHs99m-Xj0I7zJsEZ0tn6OVFRQ>
    <xmx:3NVKan8HZiucaypsEE72d44UfuVhgUKjsPiLQ0GFHMGj9K0qRVkRvw>
    <xmx:3NVKatxVK8lL57uTMpqMWyh12o28SgSM_OvSbQ-JDUOTfyndZSufWQ>
    <xmx:3NVKap-CEZNneUpENsCzeKF1yjOIvIF2Verr7fG_W3Nk3k7fGTZjew8y>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:27 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Lukas Wunner <lukas@wunner.de>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH 05/15] device core: Add "device evidence" 'validate' command
Date: Sun,  5 Jul 2026 15:08:09 -0700
Message-ID: <20260705220819.2472765-6-djbw@kernel.org>
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

When DMA is to be enabled for a PCI TDISP device the CC VM passes a digest
of the device evidence used to make the trust decision. Require the CC VM
to ack and not invalidate the evidence before the next DMA enable event.

Each evidence gathering conveys a current "generation" number that rolls
each time the evidence is requested to be refreshed by the CC VM. The
validate command is a debug aid setups that should not be racing evidence
gathering, device RUN state transitions and DMA enable events.

Note that this generation number does count host side events that
invalidate the evidence. That TOCTOU race belongs to the TSM to resolve and
tell the CC VM that the digests it used to enable DMA are stale.

Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Donald Hunter <donald.hunter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Suggested-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 .../netlink/specs/device-evidence.yaml        | 17 ++++++++
 drivers/base/device-evidence-netlink.h        |  2 +
 include/linux/device/evidence.h               |  5 ++-
 include/uapi/linux/device-evidence.h          |  1 +
 drivers/base/device-evidence-netlink.c        | 14 +++++++
 drivers/base/evidence.c                       | 42 +++++++++++++++++++
 6 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/device-evidence.yaml b/Documentation/netlink/specs/device-evidence.yaml
index 44b278bc20e1..65ed0ed87bba 100644
--- a/Documentation/netlink/specs/device-evidence.yaml
+++ b/Documentation/netlink/specs/device-evidence.yaml
@@ -184,3 +184,20 @@ operations:
             - generation
             - length
             - val
+    -
+      name: validate
+      doc: |
+        Assert that userspace accepts the evidence at 'generation' (e.g. as a
+        precondition for enabling DMA). If 'generation' matches the device's
+        current evidence generation the acceptance is recorded; it is
+        implicitly revoked when the evidence is regenerated.
+      attribute-set: object
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - subsys
+            - dev-name
+            - generation
+        reply:
+          attributes: []
diff --git a/drivers/base/device-evidence-netlink.h b/drivers/base/device-evidence-netlink.h
index a7a3110630a6..659a0a2c9c49 100644
--- a/drivers/base/device-evidence-netlink.h
+++ b/drivers/base/device-evidence-netlink.h
@@ -17,6 +17,8 @@ int device_evidence_nl_read_post(struct netlink_callback *cb);
 
 int device_evidence_nl_read_dumpit(struct sk_buff *skb,
 				   struct netlink_callback *cb);
+int device_evidence_nl_validate_doit(struct sk_buff *skb,
+				     struct genl_info *info);
 
 extern struct genl_family device_evidence_nl_family;
 
diff --git a/include/linux/device/evidence.h b/include/linux/device/evidence.h
index 5036fbe63e30..eea1bda609b0 100644
--- a/include/linux/device/evidence.h
+++ b/include/linux/device/evidence.h
@@ -29,15 +29,18 @@ struct device_evidence_object {
  * struct device_evidence - Retrieved device evidence
  * @slot: certificate slot used by a link TSM for connect
  * @generation: refresh_evidence() invocation detection
+ * @validated_generation: generation last accepted by userspace via "validate"
  * @digest_algo: payload size of DEVICE_EVIDENCE_FLAG_DIGEST requests
  * @lock: synchronize dumps vs refresh_evidence()
  * @obj: array of evidence objects a TSM might populate
  *
- * An increment of @generation causes in flight dumps to fail with -EAGAIN.
+ * An increment of @generation causes in flight dumps to fail with -EAGAIN and
+ * implicitly revokes a prior userspace validation.
  */
 struct device_evidence {
 	int slot;
 	u32 generation;
+	u32 validated_generation;
 	enum hash_algo digest_algo;
 	struct rw_semaphore lock;
 	struct device_evidence_object obj[DEVICE_EVIDENCE_TYPE_MAX + 1];
diff --git a/include/uapi/linux/device-evidence.h b/include/uapi/linux/device-evidence.h
index b184174a695d..180d45fdf6cf 100644
--- a/include/uapi/linux/device-evidence.h
+++ b/include/uapi/linux/device-evidence.h
@@ -102,6 +102,7 @@ enum {
 
 enum {
 	DEVICE_EVIDENCE_CMD_READ = 1,
+	DEVICE_EVIDENCE_CMD_VALIDATE,
 
 	__DEVICE_EVIDENCE_CMD_MAX,
 	DEVICE_EVIDENCE_CMD_MAX = (__DEVICE_EVIDENCE_CMD_MAX - 1)
diff --git a/drivers/base/device-evidence-netlink.c b/drivers/base/device-evidence-netlink.c
index 3a739601f107..3148fc523ed1 100644
--- a/drivers/base/device-evidence-netlink.c
+++ b/drivers/base/device-evidence-netlink.c
@@ -20,6 +20,13 @@ static const struct nla_policy device_evidence_read_nl_policy[DEVICE_EVIDENCE_A_
 	[DEVICE_EVIDENCE_A_OBJECT_NONCE] = NLA_POLICY_MAX_LEN(DEVICE_EVIDENCE_MAX_NONCE_SIZE),
 };
 
+/* DEVICE_EVIDENCE_CMD_VALIDATE - do */
+static const struct nla_policy device_evidence_validate_nl_policy[DEVICE_EVIDENCE_A_OBJECT_GENERATION + 1] = {
+	[DEVICE_EVIDENCE_A_OBJECT_SUBSYS] = { .type = NLA_NUL_STRING, },
+	[DEVICE_EVIDENCE_A_OBJECT_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVICE_EVIDENCE_A_OBJECT_GENERATION] = { .type = NLA_U32, },
+};
+
 /* Ops table for device_evidence */
 static const struct genl_split_ops device_evidence_nl_ops[] = {
 	{
@@ -31,6 +38,13 @@ static const struct genl_split_ops device_evidence_nl_ops[] = {
 		.maxattr	= DEVICE_EVIDENCE_A_OBJECT_NONCE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= DEVICE_EVIDENCE_CMD_VALIDATE,
+		.doit		= device_evidence_nl_validate_doit,
+		.policy		= device_evidence_validate_nl_policy,
+		.maxattr	= DEVICE_EVIDENCE_A_OBJECT_GENERATION,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family device_evidence_nl_family __ro_after_init = {
diff --git a/drivers/base/evidence.c b/drivers/base/evidence.c
index 8e019669db07..3a7942b2362a 100644
--- a/drivers/base/evidence.c
+++ b/drivers/base/evidence.c
@@ -446,6 +446,48 @@ int device_evidence_nl_read_dumpit(struct sk_buff *skb,
 	return device_evidence_read(skb, cb);
 }
 
+int device_evidence_nl_validate_doit(struct sk_buff *skb,
+				     struct genl_info *info)
+{
+	const struct device_evidence_ops *ops;
+	struct device_evidence *evidence;
+	struct device_evidence_ctx _ctx;
+	u32 generation;
+	int rc;
+
+	if (GENL_REQ_ATTR_CHECK(info, DEVICE_EVIDENCE_A_OBJECT_GENERATION)) {
+		NL_SET_ERR_MSG(info->extack, "missing evidence generation");
+		return -EINVAL;
+	}
+	generation = nla_get_u32(info->attrs[DEVICE_EVIDENCE_A_OBJECT_GENERATION]);
+
+	ACQUIRE(mutex_intr, lock)(&device_evidence_lock);
+	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
+		return rc;
+
+	struct device_evidence_ctx *ctx __free(put_ctx) =
+		device_evidence_ctx_setup(info, &_ctx);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ops = ctx->subsys->ops;
+	evidence = ops->evidence_read_begin(ctx->dev);
+	if (IS_ERR(evidence)) {
+		NL_SET_ERR_MSG(info->extack, "failed to acquire evidence context");
+		return PTR_ERR(evidence);
+	}
+
+	if (generation == evidence->generation) {
+		evidence->validated_generation = evidence->generation;
+	} else {
+		NL_SET_ERR_MSG(info->extack, "evidence generation is stale");
+		rc = -ESTALE;
+	}
+
+	ops->evidence_read_end(evidence);
+	return rc;
+}
+
 static int __init device_evidence_nl_init(void)
 {
 	return genl_register_family(&device_evidence_nl_family);
-- 
2.54.0

