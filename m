Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722593;
	b=tqx5xSqAADLb0GaiNIiCX/toONcCQfy5c5Ae9bxlQldw6ztPDIJa7LS5xUUgaQeo0omr
	 XDDY8VebjaopJ0f6KGVoTYtbq9lV4lJrNZWjzeXkEQ/AKjbw/zC5kJbTqpCPOJN0f8Zep
	 BeRkFVBydA9gHoIryr3JOPVh1uiqtNXq69xDS20XPQxB3vcU+uYashR1/Ro3bb8+g0qfM
	 VNsACE4Br8LwfdJ2qUF4jBn7wynrRBzeYQRjduZA3EguqlpyKmU7q8u3hxgOt1kdKR1HI
	 LzmYNVs74+Y8egbLHiyg8R62HQJvZK9nMPKQayONWx2Gp7jkV8LGWr+3uJCWWW/+9Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rvqJFQhhP2eJIIL5cBhMSWeOSyW96/e+Yw4GFV+hVwg=;
	b=AmFffL5qk6aYo4UIWpjdkn38AQxm2ZGnUEMLFO45pZIHzO5xJFJQOlxGXlwcJSO1C8Y7
	 V8k+B9nxzuRj4I1m31uc7druRT8zjlOmYQEGBaWvqSm2uw2mRKeW9KKnBBJhdzi2YUHLa
	 5KZ7S98c0zMglNH6cHxzY23d7KCb6hhjlWJxkBk0CO6+qzOWVOPTS10Lr/n2ARKx4QpWo
	 05y8hy4QfRIbvtntJTlKxTzV8ZaF3eR8fVlpdIU4rGI1RTwgodX5xT5994GJcb0F4Z/yN
	 XDcSAAzkRWdBRJMyMYKHDDLddfZnKloZJALkMs2mUaD42mwFYB2HKe39HXgAWBIgP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NdLbYgHW;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0000606D804
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0000606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NdLbYgHW
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14f0e9c6543so90694c88.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2026 08:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722592; x=1794327392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvqJFQhhP2eJIIL5cBhMSWeOSyW96/e+Yw4GFV+hVwg=;
        b=NdLbYgHW/+hMjvLv3LdxUrNGHC4n//oDccfXbwOdfIVB+tdx1syxMlf8yFFZw/KS6b
         RyJpd4R1zDexJd2P4Mj4eztg0sP29VqtrndIRIuMpsNJPa4XZ/aAacAUBTw/8XMJzvYp
         DRvjuVATxI1MBwNj3nJ7TNLXtCPzFhikXlxGNIp5WYyxq2WJ1BFMAWaCdT8N5zs9PVtZ
         hUDcSd2IqdGz767uzrSOPMIE4YvuV70RWgGKf+esFoxtBOGFXpBAvgZSR3s1ftsQxiGC
         NDbhDVKInOaMXyIon3IbAutun66wv37rCrlnX0Pm+P+4C9rD2S1wYbdDCzb9VPtrSvkn
         xbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722592; x=1794327392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rvqJFQhhP2eJIIL5cBhMSWeOSyW96/e+Yw4GFV+hVwg=;
        b=1xsi+7C7Qcfb0hVo/FZQEORX5mixOIlHPD3DSSLOVhJTThNefslJHOfXprsTD+7ugK
         2Y8q7LPa4QCGGnOU3n4J0oU2y2/1XZ8tv4Kg3PUYZlAVhZHisKy6WKGgZSTehmAnol1i
         q3ux+HIZDW5UQtu/uk6xuWy8Y6x712vgxgLYNstOnKTKbVfNQr6pi7lO/7JiTu3kJsce
         opIxkgPmMML2ZfZUSu4qAPm/PykhmiFYeFLFT109Hgogb/lkENodFRRPIaCiy5dgR38g
         EP+AfwZYWHab1l2RDoJSQRCct1TwUeq5ukNzpnLy9LHlkURGuoRQP3Mi71E7ft5bZv8x
         HxIg==
X-Gm-Message-State: APuU4Z/S99ZXSPMm3jawwSfCYy5CA01AVIXwcL2tkzg6aKxPsPFF7sHk
	Gn8c6KDvXV1sUYguX/oZIdMXOEKlyDS7aWozjUdPGEyCCOZJu6pyrUBv
X-Gm-Gg: AYBFou2t2HB+yKfkJO7RZVuXlYja43WawHcP+3wrVm43ZAxshKxFRqF2zgRn/cpJnQX
	UABTBV0XR6g/CwEFMtltRZNusRgg2U3i5kBgQWWdl3YZ3p5YDI7CxFxG2esZ3FPIjy9NPFlDgfZ
	32Aw9FnoS6ItYaobvMOzUp/yZOAiDEW+7670g3Y+rMejG3ip6dkIcP1Z/ponynrJxCPTOd3obQX
	TJFTu1n+ZRDN/rMfx1/SgRjiIDSNI6Bmh4HY1gN9Ug8Y7gWBlk92WPZNXObXb+eklH2PfaS6Int
	hL7Oz7UwCeNvLjS6ZTWIPvfV6MaRKlGFd3jgkfhQemPUDvaPK0BQvDyVZlxFbSwPhPzp1wwE5lQ
	dIQVj8iBo6UirE0M7oHEd8K62TXx4yd/OE5KJzj1V+KYdaTcglzho2ywmqNi0fVaT0LlZvl3BK8
	rI0Wko8WVN1D6hnR4Nq/aOhmNgFWwm/YnXL6efe4kH1ddIiG/ODRtpvfFwnMH8CSRgIPHrHm1g4
	g/RYy5x7GFn7VGOm97oh0OLqaKD4GrlfuvCBjN0AKQwU9J1/jW4WMXuQQEhUK+AiIz+WrGNbhLq
	214Uchd7RPVNiYWEInXuAJ1qQS2RAUp/Gy5vFU4hW1Po4o5ELsPYSuFQPaAD3ho=
X-Received: by 2002:a05:7022:eb46:10b0:14b:edb2:c3bc with SMTP id a92af1059eb24-1ac4fd01362mr32106647c88.0.1793722591674;
        Tue, 03 Nov 2026 08:16:31 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1a136537sm43758375c88.18.2026.11.03.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:16:31 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: mani@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-ntb@googlegroups.com,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-ntb: cancel cmd_handler synchronously on cleanup
Date: Wed,  4 Nov 2026 00:16:22 +0800
Message-Id: <20261103161622.1597925-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

epf_ntb_cmd_handler() re-arms itself unconditionally every 5ms at
reset_handler, with no guard at all.  epf_ntb_epc_cleanup_interface()
uses cancel_delayed_work(), which cannot stop a running callback: if
the cleanup (configfs unbind) happens while the handler is mid-flight,
the handler re-arms, and the delayed work fires after the devm-managed
ntb_epc - and the devm_ioremap'd ntb_epc->reg it dereferences - have
been released.  Use-after-free.

The per-attempt race window is small (sub-microsecond callback vs a 5ms
period), but configfs bind/unbind cycles can simply be repeated (root)
until the race is won.

Use cancel_delayed_work_sync(), which waits for a running callback and
prevents its re-arm from taking effect.

Found by static analysis.  The race was reproduced on a KASAN build
with a small module exercising this exact arm/cancel/free pattern
(no NTB hardware available); PoC and splat are below.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Reproducer notes (PoC source below; a module parameter selects the
shape): mode=2 (cancel_delayed_work + unconditional re-arm, this bug's shape) produces

    [    1.95] BUG: KASAN: slab-use-after-free in queue_delayed_work_on+0x27/0x70
    [    1.95] Workqueue: events pm_td_cb [pm_flush_poc]

after the teardown frees the container; mode=1
(cancel_delayed_work_sync, i.e. this fix) stays clean.

---------------------------- reproducer: pm_flush_poc.c ----------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * pm_teardown_poc - mechanism PoC for the drv-teardown-sync C/D variants
 * (F-026 ipoib / F-028 epf-ntb / F-029 habanalabs).
 *
 * Modes (module parameter):
 *   0  F-029 vuln shape:  flush_delayed_work + lockless guard
 *   1  control:           cancel_delayed_work_sync (>=6.9 swallows re-arm)
 *   2  F-028 vuln shape:  cancel_delayed_work (non-sync) + unconditional re-arm
 *   3  F-026 vuln shape:  cancel_delayed_work (non-sync) + guard check/queue
 *                         race window (test passes, teardown slips in before
 *                         the queue_delayed_work)
 *
 * Every vuln mode must produce KASAN slab-use-after-free when the orphaned
 * work fires after kfree; the control mode must stay clean.
 */
#include <linux/module.h>
#include <linux/workqueue.h>
#include <linux/slab.h>
#include <linux/delay.h>

static int mode;
module_param(mode, int, 0444);
MODULE_PARM_DESC(mode, "0=flush(F-029) 1=cancel_sync(ctrl) 2=cancel_nosync(F-028) 3=cancel_nosync+guard-race(F-026)");

struct pm_td_ctx {
	bool			fini_pending;
	struct delayed_work	work;
};

static struct pm_td_ctx *ctx;

static void pm_td_cb(struct work_struct *w)
{
	struct pm_td_ctx *c = container_of(to_delayed_work(w),
					   struct pm_td_ctx, work);

	pr_info("PM-POC: cb running, fini_pending=%d\n", c->fini_pending);

	switch (mode) {
	case 0:		/* F-029: lockless guard then long body then re-arm */
		if (c->fini_pending)
			return;
		msleep(300);
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed (flush shape)\n");
		break;
	case 2:		/* F-028: unconditional re-arm, cancel must catch running cb */
		msleep(300);	/* long body so cancel lands mid-run */
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed (no guard)\n");
		break;
	case 3:		/* F-026: guard check passes, THEN teardown slips in */
		if (c->fini_pending)
			return;
		/* widen the check->queue race window like ipoib's 724->725 */
		msleep(300);
		schedule_delayed_work(&c->work, HZ / 10);
		pr_info("PM-POC: re-armed past guard (test-queue race)\n");
		break;
	default:
		break;
	}
}

static int __init pm_poc_init(void)
{
	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
	if (!ctx)
		return -ENOMEM;
	ctx->fini_pending = false;
	INIT_DELAYED_WORK(&ctx->work, pm_td_cb);

	pr_info("PM-POC: arming, mode=%d\n", mode);
	schedule_delayed_work(&ctx->work, 0);

	msleep(50);	/* callback is mid-run now */

	/* teardown sequence for the selected variant */
	ctx->fini_pending = true;
	switch (mode) {
	case 1:
		cancel_delayed_work_sync(&ctx->work);
		break;
	case 0:
		flush_delayed_work(&ctx->work);
		break;
	default:
		cancel_delayed_work(&ctx->work);	/* non-sync: C variants */
		break;
	}

	pr_info("PM-POC: teardown done, freeing ctx\n");
	kfree(ctx);

	msleep(600);
	pr_info("PM-POC: SURVIVED (no KASAN splat)\n");
	return 0;
}

static void __exit pm_poc_exit(void) { }

module_init(pm_poc_init);
module_exit(pm_poc_exit);
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("drv-teardown-sync C/D variant mechanism PoC (F-026/028/029)");

 drivers/pci/endpoint/functions/pci-epf-ntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 5314aca218..a0f0c8eb48 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1754,7 +1754,7 @@ static void epf_ntb_epc_cleanup_interface(struct epf_ntb *ntb,
 		return;
 
 	ntb_epc = ntb->epc[type];
-	cancel_delayed_work(&ntb_epc->cmd_handler);
+	cancel_delayed_work_sync(&ntb_epc->cmd_handler);
 	epf_ntb_db_mw_bar_cleanup(ntb, type);
 	epf_ntb_peer_spad_bar_clear(ntb_epc);
 	epf_ntb_config_sspad_bar_clear(ntb_epc);
-- 
2.25.1

