Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760612;
	b=iaHSF8+LOYOB1Zg3RuWWNtWkWL9FBCHNJ0moIGp6QezitMMgQ37MkL4rwO7o7tk5Paw9
	 IFGcQ/VcUo1L8LXKKGSwk9Ct2rInPMgdqeHgf/ebefMZm8DMUuFmTgPM7Q678TtqBrubS
	 LFhfzr3tj4N9K93PEUZOtoGx2TwMt2aPe6T1ibU45jgDoU8BzIvjnuD5U31tV2LZxuseg
	 r6Orl9JRfoNNUlab+7QQmqVGuX92L+hmI6uLuc83TZwdfRdjpV7GtGchh8lafMcsGlAgJ
	 KorHvIaD/H3l4XgmTNaI8i+SR/A8SbRaHvqjRO4umEOn0RYKKNDlp3cUJpoTciwqFgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760612;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=v3tom2/meHzCSXzSyf3WctlUBtWKz6mFCVzRtFGuF2E=;
	b=k3Ia+ow6NuHgnQVJeMZMnImdADHlQorxMzfySIVeWezxGKImboQXYTQmSyBb1rBdzMrB
	 /+v+Jz0zWOmvyINhQVmXYsLfSFpyeat1+BH7GYMvez9QTDNLHe57pqH4UxdTSp0tk9ESh
	 NqI/SpTqv7tZWVbMwQOBqCs75rmxZdOrL2UvzKsBalt4vk7/qNqmcLfqdp2HrwbA7dZ2T
	 28irlV0QR3cScSJLuGCJXrMdWbGw6k0mN2r7lcJrz2MQe0r51pntDuFQ7M/IRv+Y71Fp5
	 z/qNZ+HtLJ2F7i0vUsnVuly7v14OIZOXX3l8dBYlZVuWcToXdHYg4bAQO7OHXij9Smw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOdZMB0X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EA606EEB2;
	Wed,  4 Nov 2026 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOdZMB0X
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760612;
	b=gEy78REI6BZH1eHf2Mgm6srRqJsA6AgmVuaw3yeR8NyJ6wqvBm3xgV7m+iPgaGdnAKS9
	 fKIJITSy3dQIm35Mva1v2lnkR1mMMSXxKq8jDedcg5pg4ArgKfZbvmk6v6fCi2bUYoth7
	 5qNrlRDJylACsk4elCGsMpM83whnmFMlBMJHSuH9ZoQEGvVoBg6qVNOh1IKlTot4R/ui5
	 TlotU3CFu1zPKNM1unWaHiTZYCXcMQEbJMFdTbHeF1p01I5Fc4hkFZM7y5SJ0yxeQbcLM
	 eagRx2K1UMJjGHFM29lkuuxdkRcalsHTKlXUu2rJGUzo6XU6GBLBIj6zQF05tuly2UQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760612;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=v3tom2/meHzCSXzSyf3WctlUBtWKz6mFCVzRtFGuF2E=;
	b=ocz+VSlah7rILLgblKcBFXLMnKTZZHMb6wtJi2YYHfVKanhEfVcCwtSlbBLJeZZuk6gb
	 PWZQLxW6jFrNA56o/Wpw4rzHKdbs2dBZT6085jSC3bf9IWmdY2huXkyEnGnjn7GSLCayh
	 s2rtc2W3VCqxqEnU7Z597RapsJ3f+guSal2aNDY1W4tLw4ekZKyeXZlIp0rQsg4j4tYHR
	 p3xUmkMI10U4c5hn76RUlaW4um7ye2rF8MQ7tBeUUrA+btZ1NhAaeWEAE4WHQQaj3hAav
	 jVHNImV4lXdzZ6YgCV6Sp1RYwo1qYr37k3Mfz2i4ElQzsHMvCBrnCnd6jaIMlencOEQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C03601F00A2C;
	Wed,  4 Nov 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760612;
	bh=v3tom2/meHzCSXzSyf3WctlUBtWKz6mFCVzRtFGuF2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=eOdZMB0XI2v7dG6XQrRFJmCHx3EeF6L6E5FFg6c7GLm41AGkxjlB5ynO8jqWPYn3s
	 BVevWfP1i8aAJHI/I6i8CKmczr89P9mcgSh9G9ZfrAJYG9XfAJF9kkDUqh7hLi2klw
	 +jN0rm4RUzguhMeGrzF8wZgHk72r9JyLi9+yO9l5SMXUMUI3c5f5O28Q8YoSIMTQ+e
	 mErBSoaKaDutVKl3cvXRWjEafFy8Nd8FA+fXYms9691uBjll3OvlcSHlKEvyrHXG6E
	 XlJhjqVWTdq3PXFfe4cLyqFGtA0Uq+IATpogNit2duxzrfK8NqeKnHyLOdXdDqqjmB
	 V0/ZTL5JQJgjw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E87A46C47;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:50:02 -0600
Subject: [PATCH v4 21/25] dmaengine: sdxi: Provide context start and stop
 APIs
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-sdxi-base-v4-21-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
In-Reply-To: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=3502;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=WiX3Tqeldc4IPKX4oqsKJ8nPLPgMYEiqvrHy0gtdIWQ=;
 b=PtTdQnyKMzWBAsxUOJc7gmMZe9bigIh1gKSIz4okf4v0hkrfEmgTIgq13+mcmGN8GsUs3Qx+g
 vvn3qjSRNHyC6ovn7H2hIYLzlOZmmebOMeZoQJK9yxEYv00XSWhWWPM
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

From: Nathan Lynch <nathan.lynch@amd.com>

Implement client context start and stop by submitting administrative
descriptors. Starting waits for the start descriptor to finish; stopping
submits stop followed by synchronization and waits for the latter.

Use the administrative reservation and polling helpers to claim status
blocks before reserving descriptors, release consumed results, and retain
timed-out blocks until context teardown. Expose these operations through
struct sdxi_cxt for clients such as the DMAengine provider.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 drivers/dma/sdxi/context.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sdxi/context.h |  3 +++
 2 files changed, 64 insertions(+)

diff --git a/drivers/dma/sdxi/context.c b/drivers/dma/sdxi/context.c
index 5ca99ac8080c..0979fa35346b 100644
--- a/drivers/dma/sdxi/context.c
+++ b/drivers/dma/sdxi/context.c
@@ -364,6 +364,67 @@ int sdxi_admin_cxt_init(struct sdxi_dev *sdxi)
 	return devm_add_action_or_reset(sdxi->dev, free_admin_cxt, sdxi);
 }
 
+int sdxi_start_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_ring_resv resv;
+	struct sdxi_completion comp;
+	struct sdxi_slot start;
+	int err;
+
+	might_sleep();
+
+	/* Administrative context activation is controlled by the function state. */
+	if (WARN_ON(adm == cxt))
+		return -EINVAL;
+
+	err = sdxi_cxt_reserve(adm, 1, &resv, &comp);
+	if (err)
+		return err;
+
+	start = sdxi_ring_resv_slot(&resv, 0);
+	sdxi_encode_cxt_start(sdxi_slot_desc(start), &(const struct sdxi_cxt_start) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_cxt_submit(adm, start, &comp, SDXI_CXT_SUBMIT_KICK);
+
+	return sdxi_cxt_poll_completion(adm, &comp);
+}
+
+void sdxi_stop_cxt(struct sdxi_cxt *cxt)
+{
+	struct sdxi_cxt *adm = to_admin_cxt(cxt);
+	struct sdxi_slot stop, sync;
+	struct sdxi_ring_resv resv;
+	struct sdxi_completion comp;
+	int err;
+
+	might_sleep();
+
+	/* Administrative context stopping is controlled by the function state. */
+	if (WARN_ON(adm == cxt))
+		return;
+
+	err = sdxi_cxt_reserve(adm, 2, &resv, &comp);
+	if (WARN_ON_ONCE(err))
+		return;
+
+	stop = sdxi_ring_resv_slot(&resv, 0);
+	sync = sdxi_ring_resv_slot(&resv, 1);
+
+	sdxi_encode_cxt_stop(sdxi_slot_desc(stop), &(const struct sdxi_cxt_stop) {
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_encode_sync(sdxi_slot_desc(sync), &(const struct sdxi_sync) {
+			.filter = SDXI_SYNC_FLT_STOP,
+			.range = sdxi_cxt_range_single(cxt->id),
+		});
+	sdxi_cxt_submit(adm, stop, NULL, 0);
+	sdxi_cxt_submit(adm, sync, &comp, SDXI_CXT_SUBMIT_KICK);
+
+	WARN_ON(sdxi_cxt_poll_completion(adm, &comp));
+}
+
 /*
  * Temporary owner for context id until it can be assigned to a
  * context object; enables scope-based cleanup.
diff --git a/drivers/dma/sdxi/context.h b/drivers/dma/sdxi/context.h
index 71eef2c6243b..acf41709c4de 100644
--- a/drivers/dma/sdxi/context.h
+++ b/drivers/dma/sdxi/context.h
@@ -60,6 +60,9 @@ struct sdxi_cxt *sdxi_cxt_new(struct sdxi_dev *sdxi);
 int sdxi_cxt_exit(struct sdxi_cxt *cxt);
 void sdxi_client_cxts_exit(struct sdxi_dev *sdxi);
 
+int sdxi_start_cxt(struct sdxi_cxt *cxt);
+void sdxi_stop_cxt(struct sdxi_cxt *cxt);
+
 enum sdxi_submit_flags {
 	SDXI_CXT_SUBMIT_KICK  = BIT(0),
 	SDXI_CXT_SUBMIT_FENCE = BIT(1),

-- 
2.56.0


