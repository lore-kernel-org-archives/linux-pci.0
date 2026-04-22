Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7373C060B;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857112; cv=none; b=jRq9S/5SoSVJCNg09Sm5NVF321/1cx9FQxT382k3f8sI9+/T9kwzRta+RvYP1vOynMWTEc2tBahhx4/zu+BZeIPcMzzr6oUTuc8upPZbVHaUcVB9WdoYNQgaNAwdXr6yb3Nes1JZGXfpQ87Cm6DY5Ov81pszz8RWoDoJH5aW9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857112; c=relaxed/simple;
	bh=jonb0+BbdQ6Gol/gdLqxrtYurK7jeakTSV7+fWf3c6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCRWGXpYyJUMiU5BG4fQYPWjPIG2M4N6b31z4rHYY3bP9tHXiryfpoBwpOZjlfnTWqyk3TXd1mR5O6kcAZGPBUimEIbrrPShT0ZdKxHseg83jVkd10R5pLHBWmdkJx3xp4D4v7lyXHAVqobK1esmSh8meg0dDN8M201u6LCd+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiGKdSPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiGKdSPi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 781D3C2BCB6;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776857112;
	bh=jonb0+BbdQ6Gol/gdLqxrtYurK7jeakTSV7+fWf3c6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GiGKdSPigLO1yfzW/xEabv0WclGB2h92UJ9qop9tk/cubFn7e1vXplJiAcP5obESB
	 qbIYJ/dK5czrglGIC+pqfluS3aEbli3m/75oP/+jQE+xsfCX4Dl9RY1PPtqy/rj2OQ
	 xOGFt+9xaB4qX2FkWqm6M4nB1qOUNlAVcVM3vNF+gBAAOMau35RS04wQlPBveSDvto
	 6hKwPQXZojouyHWZWcwedSfz8sUN0BKa32GzCA6kJ8kCMzx/Ve9gueeyz4c/JATdqx
	 EOAZAlrELyRBVP3NrEUeq/pV7gBT1wp0Ke23F8WhUZwvn9Ai2TSPcz8JX3BiNyUgFR
	 FgfINDiUH9QTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66593F55811;
	Wed, 22 Apr 2026 11:25:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 22 Apr 2026 16:54:42 +0530
Subject: [PATCH 01/12] power: sequencing: Introduce an API to check whether
 the pwrseq is fixed or controllable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4155;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=mBT4+PCQBlLr0gKZw68+7oeiwkEcbJwlfBn1pAauZ/w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp6LAUAs/ZvcRX0EUgj9C0brPvG0qUgrCiwiCL+
 Vr8UZyf8b2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaeiwFAAKCRBVnxHm/pHO
 9QzxB/9wBZR66v/P3IP9cDkWqPsdxvV+9r6eMk4nkoOxLgBBFjaOJk9fUo+KSq9rhp0vPPaqVYx
 fxdlj96TMLLr5/iFuJrUIH2IuAMLKdc3OnLMV+k4VeiM+/2/XHWTif+x6GDbfGWNDJQAkamBf6W
 b0e6hGk1dIhQi4lFzYRwAbOW+mg6nv/+7EF/5AMeC+kKLC17CnIR+hEbWxmqYpcTw5pif9Subx9
 mb1PpSFhoG63VAcWsc9D2UPjilHT7mBTp5uOTdRH3ENq9h8ZZneiXxBWmuNOyuU6jErn/7sQ+VR
 Pfo+rLejqNWFROaSf0lknjfgXSW3D2MbuY49j4BXxLKRPWbD
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Introduce an API pwrseq_is_fixed() so that the consumers can check whether
the given power sequencer is fixed or controllable. This will come handy
in situations where the consumers need to know whether the specific power
sequencer like 'Bluetooth' can be controllable using properties like BT_EN.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h |  6 ++++++
 include/linux/pwrseq/provider.h |  2 ++
 3 files changed, 41 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 4dff71be11b6..20af9643f1ac 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -182,12 +182,14 @@ static void pwrseq_unit_release(struct kref *ref)
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_fixed: Check whether this target is fixed or not.
  */
 struct pwrseq_target {
 	struct list_head list;
 	const char *name;
 	struct pwrseq_unit *unit;
 	pwrseq_power_state_func post_enable;
+	bool (*is_fixed)(struct pwrseq_device *pwrseq);
 };
 
 static struct pwrseq_target *
@@ -206,6 +208,7 @@ pwrseq_target_new(const struct pwrseq_target_data *data)
 	}
 
 	target->post_enable = data->post_enable;
+	target->is_fixed = data->is_fixed;
 
 	return target;
 }
@@ -965,6 +968,36 @@ int pwrseq_power_off(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
+/**
+ * pwrseq_is_fixed() - Check whether the power sequencer is fixed or
+ * controllable.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * This API can be used to check whether a specific power sequencer like
+ * 'Bluetooth' is fixed or controllable through properties like 'BT_EN' GPIO.
+ *
+ * Returns: true if fixed, false if controllable.
+ */
+bool pwrseq_is_fixed(struct pwrseq_desc *desc)
+{
+	/*
+	 * If there is no power sequencer, then the consumer cannot control
+	 * the power, so it is effectively fixed.
+	 */
+	if (!desc)
+		return true;
+
+	/*
+	 * If the provider hasn't implemented the callback, assume it acts
+	 * like a controllable power sequencer (for backward compatibility).
+	 */
+	if (!desc->target->is_fixed)
+		return false;
+
+	return desc->target->is_fixed(desc->pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_is_fixed);
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct pwrseq_debugfs_count_ctx {
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 7d583b4f266e..7c24958880d7 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -22,6 +22,7 @@ devm_pwrseq_get(struct device *dev, const char *target);
 
 int pwrseq_power_on(struct pwrseq_desc *desc);
 int pwrseq_power_off(struct pwrseq_desc *desc);
+bool pwrseq_is_fixed(struct pwrseq_desc *desc);
 
 #else /* CONFIG_POWER_SEQUENCING */
 
@@ -51,6 +52,11 @@ static inline int pwrseq_power_off(struct pwrseq_desc *desc)
 	return -ENOSYS;
 }
 
+static inline bool pwrseq_is_fixed(struct pwrseq_desc *desc)
+{
+	return true;
+}
+
 #endif /* CONFIG_POWER_SEQUENCING */
 
 #endif /* __POWER_SEQUENCING_CONSUMER_H__ */
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
index 33b3d2c2e39d..11165e98cde0 100644
--- a/include/linux/pwrseq/provider.h
+++ b/include/linux/pwrseq/provider.h
@@ -43,11 +43,13 @@ struct pwrseq_unit_data {
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_fixed: Callback to check whether this power sequencer is fixed or not.
  */
 struct pwrseq_target_data {
 	const char *name;
 	const struct pwrseq_unit_data *unit;
 	pwrseq_power_state_func post_enable;
+	bool (*is_fixed)(struct pwrseq_device *pwrseq);
 };
 
 /**

-- 
2.51.0


