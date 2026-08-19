Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0930566C
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143440; cv=none; b=vD0xVUHbtRAUYNlzIw3Ky8rlXqZwEPa3k5aCuNLABThQLLrYXILbZd6cg7+/EzxoM8+ZIkHj5/HX2JGG5hmId96WLSmk//eojiWEl1XiT7xxjXTkX7Mb3/1fLxqUrm2VM80zfNjY++MLySUiHzJEbJ+0Fdspas/eRZ4mrCuMRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143440; c=relaxed/simple;
	bh=yA4pjtDTrTuCsLf3b7pK2t0nVf64PN9VJJskTkM6KDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AAvnitBAxz4BLc9owx3wZIBSJIzCWaX620hIEaXQtBtPm3G9ocYFarO4S96oQfZLePnwKgPXRL1EceS9Z+8eSYF+kNZZ0O7EotKaHSj50QMW6sVo+r8DpCu5KoETmhuXZrjPq28gGWBE4v1Nfr3DJdNUVwAk7W6fyPcNA1zZ/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDVTfqO6; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDVTfqO6"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so9080255e9.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787143436; x=1787748236; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=13fKMAmOqnBUwt5r75YrAxL9KZ/M6jhE1nqTXhbmCgQ=;
        b=pDVTfqO6qu5cVRCd0yTSo9z5GT9/YwbXAsZahbry3oKBJWX7CEBuymv6yh/Z24Ff0C
         fQJU8dSlP4sF5YhmCZTi83Zh9HpfuiveK/1grghf4B431iui/GbaTN5q2ojpd2lNDu2b
         oGaYNB1HG5mhl2qeXWlyXf6m4Yx7KO+Ij0jjp5A7nuHbBpiKgL9sjJmkT4SwdWmDXHBF
         Enr7rAuHmoas/YsjHotQnrzOCjjelIkMB/Stc4khHV9Rq3YE+LY7Zgi7fgwasir1sbra
         zXFAsicqsKG3zeL5s5ZR2LJmnCqd9nJ3NLJSCiFydwEqpKFK7ceMJ3yJBf9PGWi7T19x
         ho5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787143436; x=1787748236;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13fKMAmOqnBUwt5r75YrAxL9KZ/M6jhE1nqTXhbmCgQ=;
        b=LkZbSs95f/gT6D6MmH3//HeonZbWpJJOZPeTxirujzVfeu3644L7nRJsOLEm1OKisv
         gYTJIkPh/gRrym+wazPwEYDb5Wzi8U1c9XvAv0YG6Zf19oVXW0R7OP3bt3Ayowh5/1fC
         s+eKcyI5xnDMW08/k+zg0qzmZUaNyZ3EdljWo5/b5Ly/HQwPOmU6Sx8nNDdc149rJ8VM
         tmyuOabcGX4cT8lkRI6RcYL7NVHtf6MNj0DQYYfSrovj1+avFkAlYwGRuiCRq7jmLhfK
         vVKIz83q5ERytViQ9AlFu/g6tUdEWS0LJh4WXnm2HzkHiDLHQ8GIm+V9VYfUTGKiaC2H
         LtHg==
X-Forwarded-Encrypted: i=1; AHgh+RrlQ3RJYF/69/e4JAL4tyLgPvdi3HucBdMmnEhvJK3VJDjppR497kTOxsHHETiy67l9VUYVpd9sUi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4utxF6o6g19ZfFuxc9pPlBVvd1X7I/VGLkLNlwD3Hwnxou/2
	VUaIgF7a/oryjpgdAA+d0ku6ZAVhZQjF3Q4EjeqbofeXkDqTKtPn6976vF+Lt74EOkQHnnZhLfO
	Fr1aPrA==
X-Received: from wrzq17.prod.google.com ([2002:a05:6000:1371:b0:47f:c79e:e0e3])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b27:b0:493:c47f:3c55
 with SMTP id 5b1f17b1804b1-499aa199601mr92606105e9.5.1787143436358; Wed, 19
 Aug 2026 05:43:56 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:43:35 +0000
In-Reply-To: <20260819124341.4185621-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260819124341.4185621-1-lrizzo@google.com>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
Message-ID: <20260819124341.4185621-2-lrizzo@google.com>
Subject: [PATCH v5 1/7] genirq: Add flags for software interrupt moderation.
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two flags to support software interrupt moderation:

- IRQ_MODERATABLE is an irqdesc flag indicating that an interrupt supports
  moderation. This is a capability that can be set for eligible sources.

- IRQD_MODERATED is an internal irqdata flag indicating that the
  interrupt is currently being moderated. This is a state flag.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/irq.h   | 11 ++++++++++-
 kernel/irq/debugfs.c  |  3 +++
 kernel/irq/settings.h | 17 +++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index f485369b1b4f7..232df18af1b66 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -76,6 +76,7 @@ enum irqchip_irq_state;
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
  * IRQ_NO_DEBUG			- Exclude from note_interrupt() debugging
+ * IRQ_MODERATABLE		- Can do software interrupt moderation
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -104,13 +105,14 @@ enum {
 	IRQ_HIDDEN		= (1 << 20),
 	IRQ_NO_DEBUG		= (1 << 21),
 	IRQ_RESERVED		= (1 << 22),
+	IRQ_MODERATABLE		= (1 << 23),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_MODERATABLE)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
@@ -224,6 +226,7 @@ struct irq_data {
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
  * IRQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progress in which
  *				  case it must be resent at the next available opportunity.
+ * IRQD_MODERATED		- Interrupt is currently moderated.
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -249,6 +252,7 @@ enum {
 	IRQD_AFFINITY_ON_ACTIVATE	= BIT(28),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(29),
 	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(30),
+	IRQD_MODERATED			= BIT(31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -438,6 +442,11 @@ static inline bool irqd_needs_resend_when_in_progress(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
 }
 
+static inline bool irqd_is_moderated(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_MODERATED;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 5c5ebaee35f2c..634f00c0f0f59 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -128,6 +128,8 @@ static const struct irq_bit_descr irqdata_states[] = {
 	BIT_MASK_DESCR(IRQD_IRQ_ENABLED_ON_SUSPEND),
 
 	BIT_MASK_DESCR(IRQD_RESEND_WHEN_IN_PROGRESS),
+
+	BIT_MASK_DESCR(IRQD_MODERATED),
 };
 
 static const struct irq_bit_descr irqdesc_states[] = {
@@ -140,6 +142,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
 	BIT_MASK_DESCR(_IRQ_HIDDEN),
+	BIT_MASK_DESCR(_IRQ_MODERATABLE),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 0a0c027a5d342..1663bb46d3a99 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -19,6 +19,7 @@ enum {
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
 	_IRQ_NO_DEBUG		= IRQ_NO_DEBUG,
 	_IRQ_PROC_VALID		= IRQ_RESERVED,
+	_IRQ_MODERATABLE	= IRQ_MODERATABLE,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -36,6 +37,7 @@ enum {
 #define IRQ_HIDDEN		GOT_YOU_MORON
 #define IRQ_NO_DEBUG		GOT_YOU_MORON
 #define IRQ_RESERVED		GOT_YOU_MORON
+#define IRQ_MODERATABLE		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -193,3 +195,18 @@ static inline void irq_settings_update_proc_valid(struct irq_desc *desc, u32 set
 	desc->status_use_accessors &= ~_IRQ_PROC_VALID;
 	desc->status_use_accessors |= (set & _IRQ_PROC_VALID);
 }
+
+static inline bool irq_settings_moderatable(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_MODERATABLE;
+}
+
+static inline void irq_settings_set_moderatable(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_MODERATABLE;
+}
+
+static inline void irq_settings_clr_moderatable(struct irq_desc *desc)
+{
+	desc->status_use_accessors &= ~_IRQ_MODERATABLE;
+}
-- 
2.55.0.737.g08866a6d13-goog

