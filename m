Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA6365A08
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385743; cv=none; b=YZ8+Lg/0EqXKRgfHiMZ8+/ZI/TdOwOfn/+GZwnVJM/YHg53DDPl0uR0vFawpkQxoQL6JySB2KdxJLwkWgsiAzvJU7rSVKjp24i+b9JkweVoj7HuRgjL4dZWo6rhBhyTP9wwClO+Fwc39+dC3EPK5d6d5Gg5cyH5BX5vzX1+dCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385743; c=relaxed/simple;
	bh=rZiOZBnfnYQhiYHGIxAvJ9diYifTV8qWwPU2z0ofvp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaC9w4M5ub7v6Zwn5j41PDnQVfwgFuA4cKRGSDWADcLDqAQXwRyayKWhtxx4cZ9DCHXRLrF7Wc2HiJ3dCXEFUyRofdlj5EAQzCawiRGm/mCRfSKvHq6pelVqdq+2wQuL00a3zbRwukFdX3NUjw2K1XyTLY92rXkaYzDjMv7fW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VtQZISQ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1PtwJ47; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VtQZISQ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1PtwJ47"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tleY2018424
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcScscqC6ncRDOFK8ujM+tWz/LTHnr7UQ8J+Pxb8j2M=; b=VtQZISQ4gXif4eDM
	f+9MBd27EG8icye0NwvCDGtfeiTqdpiNWJOYCUp7SPKQ6vVIG1K8wx/DJFsNH3Ha
	SUaTCM7ZGEQSt5PlCbDdMyjcT6kHxBq9ZCOsVTXOkOmsl9QA5n32ndJPTnH8sVGf
	Dx6ExBfVyWgS+SwRm4Zbep5GPcAABzlu/WiA2kKv3JTTc45LQ9uDMpW7Dy9ODPvK
	0eldBnWNhzlj5qlq9OniUuY+jczVDFqXkaRpFpIITJh5HPKSfG+63XWuBE4iKyMh
	IVH+3QPVrQu/m5WZKs0xBmJZjT/18lyl3pkQOP8bV0YU6bRuBu9zktQ5K/5Purxu
	w1t8kg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4wvxqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:08:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829bf6406ecso6020490b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 00:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773385738; x=1773990538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcScscqC6ncRDOFK8ujM+tWz/LTHnr7UQ8J+Pxb8j2M=;
        b=V1PtwJ47qsdkSd6FIn01I+/RAX0Nolo2j7qZoBVMjchyOw41yu2owlDpgGF5OSWabY
         +kVLHkiKDLkz5nGlcI0gOTcKKcUNMN8xlY4xfZeZ5Tg57emBgj3TkL19TFB2rxjnj/OA
         KGdoukXKFM5grMUwV2wy0tSdBPZDtrlWI09Twk/GfpvcwJdNbgWDmlmz8+lxpU9k2Fje
         SOb2O6+hckzCpbdXwmIbtia73lFalzExiWw3jIEv54pgu2kR2qYeL282yYr9auyN+EGP
         H/hgujkiEmUD1avGealPxZxtIJheR8mnHHFyuD9F8IdM5QqfpzWXFMhEAHVRlxv8wbNn
         tCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385738; x=1773990538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcScscqC6ncRDOFK8ujM+tWz/LTHnr7UQ8J+Pxb8j2M=;
        b=S0g60T+KVee7sxAn4TL1A1Q9T6c+boLiAXzVJ3HNpv1miWaVyUIhqK7CoNhmDH95Xd
         Ie9dD+wyMIe96+Uf8aN8llNGiZMA8H3PchAOICTVSVKoJ0BSNxFvqMSc7NKGFMZl8wVu
         MXqTBUmDJoNi9dPOKhlmgNf35WygzQ+FxzsEzdK8I+QnuFGRxy2x5W4R2x5u46NKzZxL
         t9M71fGWrxa3TLFrcpMhPfENrBkXKPSgfPJ9p0x8x9i3WksrDzBEkRBGBCFtmpGLEQkL
         y5kzF0IDJFflAeskHhBGp+dVdjEU2Q3b1lV68FYEPxa0sBCY7zFijacbomTB4fFYv2Kp
         7Lfw==
X-Forwarded-Encrypted: i=1; AJvYcCWeCLC31p4ZY0/8gUd3ZgK371/xn9SuE4YAtYV+cB06armMjZr/krOAE8e++JkucW6C4gr0BkniQ2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxKoGGlUCAqwIJLvMLLAxjaMM4VW80mRCf3kSKfjowBTpmQmn
	KAUlXfX5XVKLNqOlMP+r9foc9Kyk4NK5XUpkqlqAtRfcK9YxXdWEZLvR69lDIcAJnc8dpqvxvq/
	UMsgfmgzkVwX7xvUj0STRtWWUX36xNt16AjltSnhKemI4xSSHAfd1p8c0fHaBT9k=
X-Gm-Gg: ATEYQzwh+Hs9C9MasSGXsT0nFlC3kU5b/uWBp7L6JgTqU2mSUOBDXX/u6ZIfSmND/mF
	7xB73SRZfMctd/PwclHftDE0DcbyVOMa1v1vaaxssRKcQZ+WGflyGQ6P6ocL5u88kf0RIbcyjyF
	q5gNPF54l/InBN0l66PdsR/EI7i3FE1k8h1/cfWDL7eOzZULmZi9byYTBV1hlmvrNGQ9YjE7BCB
	93eFuN3lHJ3S57vlkH0bMRoYRiCHexoYTkPKj7MKlSraldqa0SvUc+juRru5ApSNT68kC7O6A7p
	/PtPHTfsoLLtSs2sJIX/OakAv1o8YeYkhL+9Kp8bSpJaoYdIzAHU0OrrxE47ewqxu5GpyS9cR/j
	r2looZDHjEJnpbS89fWnj9bJ1wLnFpFODy70GSQSVbkPE0XopaP3xLpvj
X-Received: by 2002:a05:6a00:2d0b:b0:829:7553:afbe with SMTP id d2e1a72fcca58-82a19952539mr1970552b3a.57.1773385738496;
        Fri, 13 Mar 2026 00:08:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d0b:b0:829:7553:afbe with SMTP id d2e1a72fcca58-82a19952539mr1970522b3a.57.1773385738021;
        Fri, 13 Mar 2026 00:08:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340518sm5148536b3a.34.2026.03.13.00.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:08:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:38:40 +0530
Subject: [PATCH v8 1/3] PM: sleep: wakeirq: Add support for dedicated
 shared wake IRQ setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wakeirq_support-v8-1-48a0a702518a@oss.qualcomm.com>
References: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
In-Reply-To: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773385725; l=4919;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rZiOZBnfnYQhiYHGIxAvJ9diYifTV8qWwPU2z0ofvp8=;
 b=sK1VrvyBMnRqI17H0rZDdjGA2MW67ilKN3wCvOiI+I1r7BhnpKu8+OppiMuh1kfZPziuvlf4j
 840DYh/TkB1CtDnzPkpYqpPHl5+uafsLEr8iVy+8k4GhAvdc4Fm88jV
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=GcoaXAXL c=1 sm=1 tr=0 ts=69b3b80b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=GqrSgIjjxmp09zFQf4gA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: EVE6NgIRZ69K17bz-KoSMsgs_0Kd90hE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NiBTYWx0ZWRfX/9xgfVjV+/rq
 YVZWECpULt1zeAXMiJ0V2jgfTHu4rSFtb6pZ4Fi2+Z7VFaY8vuH5MZGbSqddxgLomuuczLI3aWQ
 wR7kqY/7zafSLqQhb3yd04t9PeqzXhph7uBs+EYMTn6+1YNs/3mDmLCirqoLP/PWoeCoFUwF3KO
 AXxJekCTGlQ9XZxss7ox5XTMQ+qKYwuIjvj9ayiw8mr8t7joD634GoB/Qza+T+R9LBuwECGMFl8
 hPBhepJ1tdmEmbBjNQ7iiyrVtfH9xeY5+nIWaUainJLMZhBIZX+aJzmGbbeITQTQm8VFugs8Z7s
 J7BkggvuMZ2G3H5Syqfzgc3/BYdCvME1bwWZwoWr03GVkTvTESWVvWuXrUwlRJf1ZfJRAUD8PDE
 Uip9gzwpfWFo5T5LlQfwkwKvCB400KY3eJgSZ/TXb9jNtrMy5UyRS/3SZi1hkUvucJ1rHSOD3D+
 efBHnf3NIHw0aiZ9H1w==
X-Proofpoint-ORIG-GUID: EVE6NgIRZ69K17bz-KoSMsgs_0Kd90hE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130056

Some devices require more flexibility when configuring their dedicated
wake-up interrupts, such as support for IRQF_SHARED or other IRQ flags.
This is particularly useful in PCIe systems where multiple endpoints
(e.g., Wi-Fi and Bluetooth controllers) share a common WAKE# signal
line which requests platform to re-establish power and reference clocks
to the components. In such cases, drivers can use this new API
dev_pm_set_dedicated_shared_wake_irq() to register a shared wake IRQ.

Update the internal helper __dev_pm_set_dedicated_wake_irq() to accept an
irq_flags argument. Modify the existing dev_pm_set_dedicated_wake_irq()
and dev_pm_set_dedicated_wake_irq_reverse() to preserve current behavior.

When IRQ registered with IRQF_SHARED we can't use IRQF_NO_AUTOEN flag,
so after registering for irq, disable it explicitly.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
---
 drivers/base/power/wakeirq.c | 39 ++++++++++++++++++++++++++++++++++-----
 include/linux/pm_wakeirq.h   |  6 ++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index ad23f0fa5d1a5a9eb49b1af2288ee4908082b13e..b7b106f55559a7c85cb35d9e5ed22fe37970662d 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -171,7 +171,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	return IRQ_HANDLED;
 }
 
-static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
+static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag,
+					   unsigned int irq_flags)
 {
 	struct wake_irq *wirq;
 	int err;
@@ -200,8 +201,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
 	 * so we use a threaded irq.
 	 */
 	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-				   IRQF_ONESHOT | IRQF_NO_AUTOEN,
-				   wirq->name, wirq);
+				   IRQF_ONESHOT | irq_flags, wirq->name, wirq);
 	if (err)
 		goto err_free_name;
 
@@ -237,7 +237,7 @@ static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned
  */
 int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 {
-	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_NO_AUTOEN);
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
@@ -258,10 +258,39 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
  */
 int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
 {
-	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE,
+					       IRQF_NO_AUTOEN);
 }
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
 
+/**
+ * dev_pm_set_dedicated_shared_wake_irq - Request a dedicated shared wake-up interrupt
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ * @flags: Custom IRQ flags (e.g., IRQ_TYPE_EDGE_FALLING)
+ *
+ * This API sets up a threaded interrupt handler for a device that has
+ * a shared wake-up interrupt in addition to the device IO interrupt. It also
+ * sets IRQ flags like IRQ_TYPE_EDGE_FALLING passed by the caller.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq, unsigned long flags)
+{
+	struct wake_irq *wirq;
+	int ret;
+
+	ret =  __dev_pm_set_dedicated_wake_irq(dev, irq, 0, IRQF_SHARED | flags);
+	if (ret)
+		return ret;
+
+	wirq = dev->power.wakeirq;
+	disable_irq_nosync(wirq->irq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_shared_wake_irq);
+
 /**
  * dev_pm_enable_wake_irq_check - Checks and enables wake-up interrupt
  * @dev: Device
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index 25b63ed51b765c2c6919f259668a12675330835e..61f1e840745b56baa57db37563e450cb2d757a85 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -11,6 +11,7 @@ extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
 extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern int devm_pm_set_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_shared_wake_irq(struct device *dev, int irq, unsigned long flags);
 
 #else	/* !CONFIG_PM */
 
@@ -38,5 +39,10 @@ static inline int devm_pm_set_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int dev_pm_set_dedicated_shared_wake_irq(struct device *dev,
+						       int irq, unsigned long flags)
+{
+	return 0;
+}
 #endif	/* CONFIG_PM */
 #endif	/* _LINUX_PM_WAKEIRQ_H */

-- 
2.34.1

