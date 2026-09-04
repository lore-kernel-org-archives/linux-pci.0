Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC94A9D56
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536553; cv=none; b=UrjGppuoLf+Vmyow3ST/hKP7lll+ogAtlyl6YB8GC/+WAsbvKZ46liBtSKzqA5118lhfM5FlhOylvdKsqcTGba0Bywq8bSxp2plFZ2hU83iKA9A9a7WOyAMyREpdXZxR3UVzdn+y8A9qqB1fZlY1mgpjuXEr9C+1fad+dPvYRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536553; c=relaxed/simple;
	bh=EV1IQL++muBemnHDLd4zHB8KbYjgmJunDIYzAh6oWWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqonsOwRNZdYez1ksxW95PsaPvCxwC+6lfEIm6MhDpnTKQUDptlc22C7ZwEvv4Q+xsdc8K3xypXWqSw2OT+neJili0HnooTa7hWOLIYp8he7MP0pV0Wf7cQ+1qm36CAzpUrxqZzjAMNw0Pmyhx1My1u7wwWnPpuU3vZh5j1UzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lyPrPgco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwzqHixX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lyPrPgco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwzqHixX"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiSKv195839
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2026 15:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UrNjtqPRiinyny6O8iHF+XsMQr2twrQF5BAL+YJEb04=; b=lyPrPgcoMx6wkJ6J
	96FvB+YbEic6pHI+WXpBScG7OBlwSwg5gl+oE+glnYMaR8d/OH9HEtqgAgP96RS0
	1eAz2CcKr+ua/ZxoNvO5wRVWTIy/8FF/BdSO4HXJR6c9GO03Hq7nWlf4n9DIbQSV
	30T7pmJ7eczFgBKakAAHBdDXJJV6VWNOJfLJvbYGhLTiq1h2pVeHssn8C0CRR+mN
	rmzzDY3ZI9Or+tp5Ugp+wJQLxtG7KZ/uNOVia60BPu9pbuoDYComHudSoFZ9Vvsq
	jJXAKSV93XeBASePLJ8tJyMIzjs0G7ziceWU6pnFvJ3N7fO7T4fGJ92Y4ebtmpe0
	i4NVJw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg0120j43-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:42:26 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-78a59f5ed87so82926137.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536546; x=1789141346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrNjtqPRiinyny6O8iHF+XsMQr2twrQF5BAL+YJEb04=;
        b=WwzqHixXR35YYDJqO5BwtcM/SmyGs3fZz6gtRHEzULi6XjwyHZ2eDkL7UskRNHbdYx
         z+50BVyuvsWwq0GdvlPxUf/RnVevpa3FjtBpB7zkN/aehiiyqk7+u+D8hErh5cEI+eM+
         qffrxJmgWsCq8hIZXQgk+U2DHGrCs8YTB29d9rGzk0qyEEvOOEpRcu7UterEIcGLvv8t
         7IPiWZRIkKen9wN95lZ42qjy5vVF2h6P0eZjmMTwy68RhTcBRMk2rb/64bUAwCzH8mog
         VbveKjHXD/g4ZKlMZx8PvrTzMzD+o//Ays85QshPW5uTXoBEK98GtvcsmlzavNNhWYMV
         GoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536546; x=1789141346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrNjtqPRiinyny6O8iHF+XsMQr2twrQF5BAL+YJEb04=;
        b=NkX7AMKTntDQ768SCsiq504I91Q8bMVktw25QBiigHsPrWmWk8S9eNxnilOP3XQ9IC
         x1dmnIj1wSBA2TpDH+aDXH0NaaKoVea16yZzx+drDoTFh9ONJGxB2f7geO16JaTCO4nj
         glGLiI97YNoUHslgICoGihSwfsqjrqFqrbrspBATRfdmfRXhD/4addVMrGdo41/JuT35
         xlmRky8LA7Lg6ZSx0KfeVYqE4lRY2VF/UfdlJRZWEsDJ000g9USBYziF3AJ81mkHtVue
         abANT5BTu9No6LVyONFm4jGDRRvdYAmA008B+b5TiSvypoz3WuQNd+PXVQoDgwXawKQe
         tXow==
X-Gm-Message-State: AFuF++nkh94L8nSar67yt+LyehcSKxzymD364dqiSSXbvGWwTNyh1AFP
	BRfwrcV3wdLPhvo1+GOBBbL5ocbZRioDsMMrkWzDJri1/zZP3kpvAp7t1F2U54VwpuXBgxY++j8
	tmlP5PxZkaRKLb1/+CbKpbL+Za39de7FQrc3lqrpEubyz0aT+tmgirGFPWcjgkrM=
X-Gm-Gg: AYBFou3IJmkZr5NGqQDZ9vNasKvofvWMiiLXIxyYM+EEf5G07eFQGcvP2u0AulsEyyZ
	3jDlGF1hnvSt8DYBkK0X0942m+p3IDxX4Y5uQ9sWiTx5Y8XEHN7MK9Jcr/ho9UqUlISFBfj9bwn
	n/1RMnm2sSfRhq8dCO6Z6QN4FBxPGorAbE6k1ZZVTGZvhHP0Lm6PW+u3kQ1gFVpiy0OLTd+SogB
	TJDhXyJ09rQCvDA3oCds1q9eHlEFNQ7P6R3HnUJHNWUgDw9ryjkTXDLp34kmXlTK5GRweAMJbS5
	bSFR02dzkT3vGhaburkgWYBNGlGSp743/lwpEu95pPdFy7UeqCrzNgBZdmJBq9jWTZfE5eq3i/b
	66bKKYeio8YX/S0374I+cL/XKXhvvGYdnwo5Ncj94cvF6/LVBy3zzk3RuwdgTeh0kaSeGC2o6xi
	AdBcf/LsTPXe0Rtfn2GwgR7kimeV9pM+gX9VD/PZHZ0nn/tE5OVSk=
X-Received: by 2002:a05:6102:943:b0:782:de7b:eead with SMTP id ada2fe7eead31-78a4a68089bmr2121565137.1.1788536545788;
        Fri, 04 Sep 2026 08:42:25 -0700 (PDT)
X-Received: by 2002:a05:6102:943:b0:782:de7b:eead with SMTP id ada2fe7eead31-78a4a68089bmr2121526137.1.1788536545349;
        Fri, 04 Sep 2026 08:42:25 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:24 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:18 +0200
Subject: [PATCH v6 03/11] power: sequencing: Add pwrseq_is_controllable()
 API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-3-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXyjzz4FhiSVwB
 dIOysBmbWOWyuOfbh+Qzbe9llzuMWgXyFZyf0gQD5SjMLftG2e4xrrP7luLOx68DX3ibg5+6MFZ
 GvUeyEiK1GzougMz2XS0Z2LO5/9jc2k=
X-Proofpoint-GUID: DYCVKwusyGmI-oLMQiOYtBejPf8BNLpR
X-Authority-Analysis: v=2.4 cv=LreiDHdc c=1 sm=1 tr=0 ts=6a9ae6e2 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4a-8Ivk512-2hps7UIkA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: DYCVKwusyGmI-oLMQiOYtBejPf8BNLpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX4f6Zm5DzuI94
 w9rZDJKFDsg/tU897XEZL+SJYu3/AICnca0/Fu18h9f34wmcgOHM5xH8HJjYxIm5ubl6byo63+Z
 5OFhWLjObMQkTeGtU6X4sTRIyToGfvpwT+TAp4Izd6oYqtY2Ry3O6FvJv0vU2UeC/M3LThzCs7D
 M1H58GNdJRswD26deyMnjzZKAaRe9vT0vENh1fQy4NUBdigT+HMKpeMB3UPZS6iOoaI+WyrJ4Dl
 IgXVgbH0nGLTCY5HkX9Djk1mJ1IUKgzc9yPhPhx6j0b4YUvazeqp/atno0fRqyPVIGqJqtl6EL0
 +urX82lBRR5QGcwXyOqtEs3kQNOF20UkRsr0ha8Dbp7iF1vf2eR/NgW4bWemRthRDvtd84gSbLT
 wv7LXSpuXL01OecsBIMmW0vlUiBUSor5K7vOCSdk88w0RXaMrZuaQLwTjfBrkfZA2ftsUY6Ng3+
 Pjcn2Jsw5IB70DuoRPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

On some boards a power sequencing target has no host-controllable enable
for its function, for instance when the enable line is not wired up to a
GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
one such example: when the M.2 connector does not route the W_DISABLE2#
signal to a host GPIO, its enable/disable are no-ops and the consumer
cannot gate the Bluetooth function at all or exclusively.

Add a generic pwrseq_is_controllable() helper. It reports whether the
target's final unit provides a host-controllable dedicated power actuator.
The target can implement a new optional is_controllable() callback,
reporting whether that actuator is effective on this target (for example
depending on GPIO presence). If the target does not provide the callback,
it is assumed to be controllable.

Note this only describes the target's own enable actuator. It does not
imply that a power-off reaches an electrical OFF state, since a target may
have multiple consumers. It also does not mean that power is uncontrolled
for the target's dependencies: those may still be gated on their own. And
it does not restrict consumers from calling pwrseq_power_off() either,
which remains valid to drop this consumer's vote on the (possibly shared)
resources and dependencies of the target.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pwrseq/consumer.h |  7 ++++++
 include/linux/pwrseq/provider.h |  8 +++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 721e888b658d1f254513e126bb72f2d0487a8383..88a507deedda30c2d94ac1ce95151cc300e3a77e 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -182,12 +182,15 @@ static void pwrseq_unit_release(struct kref *ref)
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_controllable: Optional callback reporting whether enabling/disabling
+ *                   this target actually controls power.
  */
 struct pwrseq_target {
 	struct list_head list;
 	const char *name;
 	struct pwrseq_unit *unit;
 	pwrseq_power_state_func post_enable;
+	pwrseq_is_controllable_func is_controllable;
 };
 
 static struct pwrseq_target *
@@ -206,6 +209,7 @@ pwrseq_target_new(const struct pwrseq_target_data *data)
 	}
 
 	target->post_enable = data->post_enable;
+	target->is_controllable = data->is_controllable;
 
 	return target;
 }
@@ -991,6 +995,51 @@ struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(pwrseq_to_device);
 
+/**
+ * pwrseq_is_controllable() - Check whether the target provides a
+ *                            host-controllable power actuator.
+ * @desc: Descriptor referencing the power sequencer.
+ *
+ * Some power sequencing targets provide no host-controllable enable for their
+ * function on a given board, for instance when the enable line is not wired up
+ * and is instead hardwired to an always-on level. For such targets a call to
+ * pwrseq_power_off() is still allowed, so that the consumer can drop its vote
+ * on the (possibly shared) resources, but the host cannot gate the function
+ * on its own.
+ *
+ * Returns:
+ * True if the target provides a host-controllable power actuator, false
+ * otherwise. Also returns false if @desc is NULL.
+ */
+bool pwrseq_is_controllable(struct pwrseq_desc *desc)
+{
+	struct pwrseq_device *pwrseq;
+	struct pwrseq_target *target;
+	struct pwrseq_unit *unit;
+
+	might_sleep();
+
+	if (!desc)
+		return false;
+
+	pwrseq = desc->pwrseq;
+	target = desc->target;
+	unit = target->unit;
+
+	guard(rwsem_read)(&pwrseq->rw_lock);
+	if (!device_is_registered(&pwrseq->dev))
+		return false;
+
+	if (!unit->enable && !unit->disable)
+		return false;
+
+	if (!target->is_controllable)
+		return true;
+
+	return target->is_controllable(pwrseq);
+}
+EXPORT_SYMBOL_GPL(pwrseq_is_controllable);
+
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct pwrseq_debugfs_count_ctx {
diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index 16fad5f3e3ab563110598f733e4a6c10a7b13f2d..b69117ad3fa72aa46ea1f6adc0d4ea3bdd1cf695 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -25,6 +25,8 @@ int pwrseq_disable(struct pwrseq_desc *desc);
 
 struct device *pwrseq_to_device(struct pwrseq_desc *desc);
 
+bool pwrseq_is_controllable(struct pwrseq_desc *desc);
+
 #else /* CONFIG_POWER_SEQUENCING */
 
 static inline struct pwrseq_desc * __must_check
@@ -58,6 +60,11 @@ static inline struct device *pwrseq_to_device(struct pwrseq_desc *desc)
 	return NULL;
 }
 
+static inline bool pwrseq_is_controllable(struct pwrseq_desc *desc)
+{
+	return false;
+}
+
 #endif /* CONFIG_POWER_SEQUENCING */
 
 #endif /* __POWER_SEQUENCING_CONSUMER_H__ */
diff --git a/include/linux/pwrseq/provider.h b/include/linux/pwrseq/provider.h
index 33b3d2c2e39decafac6c6fca9254ad4329d90e94..7285ad94a2214070a1c27f25c783f51105705b36 100644
--- a/include/linux/pwrseq/provider.h
+++ b/include/linux/pwrseq/provider.h
@@ -6,12 +6,15 @@
 #ifndef __POWER_SEQUENCING_PROVIDER_H__
 #define __POWER_SEQUENCING_PROVIDER_H__
 
+#include <linux/types.h>
+
 struct device;
 struct module;
 struct pwrseq_device;
 
 typedef int (*pwrseq_power_state_func)(struct pwrseq_device *);
 typedef int (*pwrseq_match_func)(struct pwrseq_device *, struct device *);
+typedef bool (*pwrseq_is_controllable_func)(struct pwrseq_device *);
 
 #define PWRSEQ_NO_MATCH 0
 #define PWRSEQ_MATCH_OK 1
@@ -43,11 +46,16 @@ struct pwrseq_unit_data {
  *               the state lock has been released. It's useful for implementing
  *               boot-up delays without blocking other users from powering up
  *               using the same power sequencer.
+ * @is_controllable: Optional callback checking whether enabling/disabling this
+ *                   target actually controls power (for example when the
+ *                   controlling GPIO is wired up). If not provided, the
+ *                   target's power is assumed to be always controllable.
  */
 struct pwrseq_target_data {
 	const char *name;
 	const struct pwrseq_unit_data *unit;
 	pwrseq_power_state_func post_enable;
+	pwrseq_is_controllable_func is_controllable;
 };
 
 /**

-- 
2.34.1

