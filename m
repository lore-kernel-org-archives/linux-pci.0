Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA43D410B
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237637; cv=none; b=VdXQ4tiD7wwdbXztB1SulSnuLtMfxF1i3f1qw+gCh2LzMWjP/KTodvCeCLZtihOGojX4eM/bsmPv4pqxZj636esdCriAUTB+AVJtfhUWZw5hVz6oRaGzTEi8SdT7Tg0e8G2IvbBTfmXHOKNphf7wt1/ZO2K2nbBzDs6q4ekmhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237637; c=relaxed/simple;
	bh=rZiOZBnfnYQhiYHGIxAvJ9diYifTV8qWwPU2z0ofvp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xjc3zZyha+IfZzmHjZ0p0r6ylsPz+PaGUZGknXOxoBO9jsMyXckQxxH1IaW0k9WWIfTl84Sn2hnhypvQ2pdvAOhlKOCH27xISCHISMTXIkPPWvx8jHIGjk6pvJrnmyzVFPiP/Fm9Sr6W03DBVS7a12iZJd/hdBmMla7h+Spts3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dqeG9Sey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZbbbTCxU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqeG9Sey";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZbbbTCxU"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633FuxVT258452
	for <linux-pci@vger.kernel.org>; Fri, 3 Apr 2026 17:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vcScscqC6ncRDOFK8ujM+tWz/LTHnr7UQ8J+Pxb8j2M=; b=dqeG9SeyGxu65jgn
	253UAbPLB45tHnHRPFfTb/GgGF91MtPxXdQq9uG9TLgV7Li7MPEnJ+fGGDm19+9D
	LKQzsJSTvzU7HA58w6YY+idGppBEOqgKRjEruPFJ4bx7kubqHIBmV5XUnimaZF1f
	T4G9xk6lruJrqDo4oGpSBeXzde097t0BKCCczSNrJ89+W8ZhHGyiUpFVjMkaL38k
	jWJOxNlqaju4iu1PE/o4wN1CTer43klBXDPb7iV7EJGarsIav29LrGyNKbY/llUa
	nZFcYqhjoUdH0HouloI+Wjp6nUliGgMREX6BV9obnJ1DEeLRt9IeB4LC1pCxob4a
	MPBAMw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dagn20963-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 17:33:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so1423268a12.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775237632; x=1775842432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcScscqC6ncRDOFK8ujM+tWz/LTHnr7UQ8J+Pxb8j2M=;
        b=ZbbbTCxUPux32ouelSa9A+YIR6HQqc4H9hK/BpauqanbAX/jM/19ShdZicY1F0XHYs
         a2v31cWFNqSMFt4/e4qi7sEdJQFjCj1QRo0Ak3alMyoh0b9ReHZXL/ts+I1ecIP/qDAX
         QznienB9+frejc5fv5nzGQMHUy8kNYfXO4cofqlk0AhCwyRxjT1voPvSKaGf6ZJsE1ds
         f+O8+94NTtzjCuAmWjchN8haFj02lCC6PGu0BhNqwOUGRNBYDcwXHg0mLd/a2tQYFgWM
         DA987bXJ795Zwc09Zv9KX1WWEruo02QWPLfNdSc206Bj86cAlTnq3g0+QvDMPHKA803c
         083w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775237632; x=1775842432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcScscqC6ncRDOFK8ujM+tWz/LTHnr7UQ8J+Pxb8j2M=;
        b=HZ+BDMLqQwRKwPuA4C9isOo3RjPAWN3Pi4tljhOrUyOdCxjUb8stvT6tMyo7696MkK
         DOT1JQr7XdJZcxEkN/OozfeFwhdEdT6XCjzRFo494DbbdmAtjMj1Vz8CGKXeRv2qgXFa
         ygbCLYj+8ZciWlyCwvN68zfyGMXVa9puBKSMqsA1UpUjm9uA/DpcKuWlMr3WL4xnOEOi
         pbXXScfIfJHpvfV00hHxCGC/ala7fozgyCPQhSSsbBox2LYJ1JOLab/0nd9+UAk6dUL6
         LNmS+iehx2D0/7gf49NJNgHv25uMcm4tOyR13WR4jjoVWq/7I1cz7N9RYO3mVs7c1IGf
         YO5A==
X-Forwarded-Encrypted: i=1; AJvYcCUNirfW2BTrkLNitnv8SbJTEBrXz3uaWdoYGyNkdWQdDPJ/lMz9RmNk4MA3uZWOB3QFJLCwm6ZiPmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnKB1ru/FKkgGKK6KcSZXwWZ0qLXZ25nBvJWdW9Fvisss/+Gl
	gWm+6Q888Y3rQmvW2K6XR/Tu9972LlSqEuHmj8hiwityeFS9pNJBMruNPyyzJz7xSXK1WsArPWa
	6ftkAnMghiti0IlK/Mym/J9F+rpM9iBc+OjnJdW9vUujP6bLLDy6loaujch210rk=
X-Gm-Gg: AeBDievEDYhFPlRW0KlOlo4gkSNcIV1Whe/JeRZMBXNV6pHIJVfz/bMsHQk7gisS1yY
	9wzMCbTBxY/fMTCIWuYisl7ohifaRCbmM2TwkspfnUMGxWRv3Nx6zIhIueFpbXAt19Efgto4+4o
	QaGS1alje0C7yEqWG7f2oAP5wM5IblLELiayDFHBDl6Quj1B7+fIkxEZmv3Qgp5aGcvK4IwEFrJ
	8ChKDmVq7HbK6NJ0CYBDh+5rM0Nm8B4NqmPIz6XdAybz3MSBQfcRr2J1scT84ImXxXPRfiCghqK
	IWJqs3poK17XmwRSsxi/v5ymJoMG5/vX38G+BWvHtkSgITeiyzDOb49F4v8DQYVl5ijo4RE6KJm
	UKbzh7UZl7iRtHat2ZI+HR5i6Zf8tgxWMFqq9nslLd+HoeQhJcxrBYVtr
X-Received: by 2002:a05:6a00:4513:b0:824:a0b9:64ee with SMTP id d2e1a72fcca58-82d0da6701bmr3354486b3a.17.1775237632104;
        Fri, 03 Apr 2026 10:33:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:4513:b0:824:a0b9:64ee with SMTP id d2e1a72fcca58-82d0da6701bmr3354465b3a.17.1775237631551;
        Fri, 03 Apr 2026 10:33:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm6359125b3a.18.2026.04.03.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:33:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 03 Apr 2026 23:03:33 +0530
Subject: [PATCH v9 1/3] PM: sleep: wakeirq: Add support for dedicated
 shared wake IRQ setup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wakeirq_support-v9-1-1cbecf3b58d7@oss.qualcomm.com>
References: <20260403-wakeirq_support-v9-0-1cbecf3b58d7@oss.qualcomm.com>
In-Reply-To: <20260403-wakeirq_support-v9-0-1cbecf3b58d7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775237619; l=4919;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rZiOZBnfnYQhiYHGIxAvJ9diYifTV8qWwPU2z0ofvp8=;
 b=AtVe7Za3lH9ooZtSOFwQ+ddqgaaMkLKTsqDn9qYDBQyyFK+dX9FjNqWehwfP9dUX65Fmih+Dq
 T8CyWBsudwtARHgL1Bug5or/c6NzndI5Bwt1VErpm+i0QrfSWhK0PlH
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDE1NiBTYWx0ZWRfX2YR6Z6zcEJqu
 9MG5JAvFYmNspNobstOLgDpMh9fu1Q2r08ExDB5OspPLgtEej7xD7AyAu60KF3HePuA/KJucj11
 RML5MAX254BnLR5s46ehHtAcU9GvDO7lE6AWxb70mS0Raal6m0e2r5amTiFReOgVfQ69VhjGy4o
 VBkwA77oag5XTJ/zwkeD6xDkA0mC/QU98pc86SiX0zMEfmp/WsnEs+8eyVN4WtXbRyxHo6SocK5
 IlyKNqoIhdk8i4rScXHODWpXPrEUwgw8b5V7xy+MMoX4D6Itgu5OlunbHpdMJjVEivu1CWqP0Bf
 KWjz8UawbedqVlI/DwHmiaXnxyEN3YW6xzjKqHVeTkYRFhfUYsnvMKpKsZzICN4Jb6anKBx30HM
 W+LGw+Jhqd9gwYyatKhLRpPFbiBHNy6XvSpSU4/y1CB+XRjlYDgnb5J7fvWzSeLtqOzpRt9BrEf
 FnoqL3gjkWrs5q4pHdw==
X-Authority-Analysis: v=2.4 cv=Cc4FJbrl c=1 sm=1 tr=0 ts=69cffa02 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=GqrSgIjjxmp09zFQf4gA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 8EblrXf41g2qFVlaMRq8y5oteSHAErH3
X-Proofpoint-ORIG-GUID: 8EblrXf41g2qFVlaMRq8y5oteSHAErH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604030156

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

