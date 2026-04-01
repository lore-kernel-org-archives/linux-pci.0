Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF27336606C
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027275; cv=none; b=C5YUGKkxHtrKOEXn6Gl8MsdKgCgMKMEd/3o7i+Ub5KBQBpY6P5QsnO+jDm2ekXl4+K6vux7/WGhuLtkQArUjxws8gn7RtQgOEQyYdSUZMEC5r+j2bf4N8flPxQZ/JmbpeFO/uqGoJrutfGOw6aTfa5eLoNKiYLlKieZ5EFqoFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027275; c=relaxed/simple;
	bh=T+IWKxfeCPkpA1AnDHhXeuS/tHjUqOlcH1i0llq8gp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQVMZfIMJ4RiMnum51P+7nDSJ1QEQcUjjqWYWLODBxw54KSb5yMm/Bhbc2Qt08kFFsM8OUkVC2i8nbfoTa5tP/mozLTXd+Qm931E8aQ5NqSzdxdM3nWvbOTxhNiqt5tidk089o+YaW12pqBBchPxu8YcOt04uk/42qSAx9TlCj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W5mzHLnK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bK2a5bS3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W5mzHLnK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bK2a5bS3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63171cl31285917
	for <linux-pci@vger.kernel.org>; Wed, 1 Apr 2026 07:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o3ofgjDB/Fu
	qgWrFRH0SxfEDOyGzS/rdc4+8I6d2b2I=; b=W5mzHLnK4o5YZdk5oEXDbVUe9Hz
	heEeXKtoMp8rsi7hzoovX/6hdI+U0f3ubcjRMvUKatBi+OPF/Uu5WoP7kdD6ZX6E
	2z4TVl08VMC/Oj+84lnAoo1jsQdbVdTEtu7L8PzrPLHrpFxx9EKGzRS9G4nkOFTb
	jzUQncKypB8NkwyVNSoi9k2HLHX/BSpGQaJRFOesdX1hCkqvEBKcofwKbCCBe8CT
	x8HfDV0dAcgd+GWsVJQOXjHuwQzcRedzQvwVYxR5FRKVhs7L+lBtIfFD4R1u4kmv
	JkYgvK5bHslndswUGYEXfizOr4T1Z22xEqDeI6H73Tb4wzS8mJlu7hKTv3Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3r106-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 07:07:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so18895162a91.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 00:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027272; x=1775632072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3ofgjDB/FuqgWrFRH0SxfEDOyGzS/rdc4+8I6d2b2I=;
        b=bK2a5bS3uZseaP0N5j/IyN4hTCBl7dVRek7rSV7ptkahqv6PbtkCo/g1PP6H3GmRn6
         vCEB4RndA6CD1ZWrzthwa8FnqAJEJYCPrDvrN8/SQ6etySb4W5GDlLL0ToNFNZvr1AYv
         SZBGWowNqEjTChkby+6/Q2pUJA7gDDdGzfhR9hmNeGa5PnvCl8Vo3q9O1lID5dqEz/qS
         B5P3nk4LpIc1nRAUzbP/3wliBTTbLSWThRJ/NJjukflkrI3GOqpzpXlXgpmkQCknPct2
         L+WUz32s1npLyCledLtNf5qXW/s+aNFAgoxiC6/XVx/l06Z5GRRhYKjAdLByTaqiQi4n
         o6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027272; x=1775632072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3ofgjDB/FuqgWrFRH0SxfEDOyGzS/rdc4+8I6d2b2I=;
        b=g3B2n2utUaznaLVR33vB+TJ8VukCd+8QYl4ar1gbzdIXZ2qC9nAZWwZu3KnttsIAK8
         m6v9/nFOvsFHbTL+ZwmsZZ65oYrsA2UzlPpYo6tGTkQ4k2j2405SUVRuxN7RBv/lRfyx
         AksxrP8jWvPcA7L5OMEZ/jzVozgbgaFQ9gjqhOY75cUQbhq9Oqi9mXSTiLlmiJcZAIB7
         bcBt/aLkQbgoYQ+kvRf8yy9BHf+xMchhcamvmAUFf81Dw/aoWko9XtuJMk+WkbhBUIp6
         MB/2zllr2U7T9zZmKB8OIjuF+CrnK+JaKHumcb6wMNuQ9lSWdkEBvkawVnZfP1Wtr5Uv
         U1eQ==
X-Gm-Message-State: AOJu0Yyc4HyxCzIgTzq4MOulLI2vR55lOtGujPRAbEKk39264XaWJIy0
	ksS2BJ/mxQZtZJeLQJVsZZ77T1Wwy09jGDWnn7wRgbVherAlAmMJY0BpZ8oeRdK+hf7eCjkLoKa
	SVHs54SzC7OksDMjFcu2hz76qQISbBnAKUD3Gkv/coe730uB9yJywvefCYf+C8Fc=
X-Gm-Gg: ATEYQzyWUOkmlgj41cXM2Wk9DnAvjqwov5OMeRgEOV7uWdF/Q4pnvdA/Cf3LvMB8O2Y
	KEqLRV6R5TzZWuGBVxNgLWzkc48YsG4c38+tUPVizJ2Rw/5/mBAUeEjbMrM6K4Vf5qeTE2F08bU
	lLL4eowUwmIvnYI0rrelwH9ktfJlG/4+N3GdUt/sCKcXB8MpQM1Q6KZFTDkrromoTJlnJvX/bib
	hCWhuohHV9QvB0DvB4GJ02PSmx+aeHW8IeOr9apbs8Erptf4ztwL484ew5uJxooAvxQOWFDfBAu
	ov16GWfTUHTZD0fWFCPdva1AbUPmkM5xs0QJ9jH6eZyNckXsUWEza2Ee2sJBfEQXC4DS+wgO0UF
	Nhda6vPTXx4GtxMJkcvemwDzwKPSvXkEwf1xp
X-Received: by 2002:a17:90b:268f:b0:35d:a9bb:1e33 with SMTP id 98e67ed59e1d1-35dc6eb9dd7mr2548379a91.11.1775027271486;
        Wed, 01 Apr 2026 00:07:51 -0700 (PDT)
X-Received: by 2002:a17:90b:268f:b0:35d:a9bb:1e33 with SMTP id 98e67ed59e1d1-35dc6eb9dd7mr2548336a91.11.1775027270961;
        Wed, 01 Apr 2026 00:07:50 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:50 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] serdev: Add missing stubs for serdev APIs when CONFIG_SERIAL_DEV_BUS is not selected
Date: Wed,  1 Apr 2026 12:37:33 +0530
Message-ID: <20260401070735.107162-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69ccc448 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=JxTtsak3BgR7EskHxGAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 8IlrgyMabUqrwjBMSA02ABmJgZs5NNLz
X-Proofpoint-GUID: 8IlrgyMabUqrwjBMSA02ABmJgZs5NNLz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MCBTYWx0ZWRfX923t/ZDxQeKL
 Y4o+sg4ahMn0o3wrbO9Yy51p7guAlHEZgj7Ro7cmF5iAoSERBg/RAqI0RvnPFrrflIBpafWZ1a7
 7hWiRJOANQEtFMAOr0pWyNyO5fHuvm3hyGqex1AXXZapHPfj+zDYG2fsLkXnvrm+hDCgxQs1aTK
 Akub6FB/obcXN8g/yPXKnca2loUAew0DXWe6GNG1+Lbs9FOwJB8IDBQVSlaDOa82VT6zwPxIWXO
 lqbOTwrYHWzL0g+wTfvDsc42AVDFE9xgomPjb6q4j5XZ9F3TkXGGd1oNO9oRvPQP/O2TGoFWF7W
 VjjpNfs7Fv/PkqNQP1A/oVk2IvYzNGjA6OknO/h8sTJDRrajbSISO58OxT0LX+RAogLi7BuzfqM
 hW4sN+O3ZztNLpgdi1r/CckNPFIfkJfcLkNv+rQLB6coIuPZF/8p/JG0wpzKJhR8rgemNU8uOdQ
 iGT+EJA0lORzBuvE9fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010060

Some of the serdev APIs are not guarded by CONFIG_SERIAL_DEV_BUS and also
missing the stubs when the symbol is not selected. This leads to the below
build errors:

   drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_pcie_m2_remove_serdev':
>> pwrseq-pcie-m2.c:(.text+0x260): undefined reference to `serdev_device_remove'
   powerpc64-linux-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_m2_pcie_notify':
>> powerpc64-linux-ld: pwrseq-pcie-m2.c:(.text+0x9c8): undefined reference to `serdev_device_alloc'
>> powerpc64-linux-ld: pwrseq-pcie-m2.c:(.text+0xc00): undefined reference to `serdev_device_add'

Fix these issues by adding the CONFIG_SERIAL_DEV_BUS guard to function
prototypes and stubs when the symbol is not selected.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604011226.KGNn5974-lkp@intel.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 188c0ba62d50..0de261a26284 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -156,16 +156,6 @@ static inline void serdev_controller_put(struct serdev_controller *ctrl)
 		put_device(&ctrl->dev);
 }
 
-struct serdev_device *serdev_device_alloc(struct serdev_controller *);
-int serdev_device_add(struct serdev_device *);
-void serdev_device_remove(struct serdev_device *);
-
-struct serdev_controller *serdev_controller_alloc(struct device *host,
-						  struct device *parent,
-						  size_t size);
-int serdev_controller_add(struct serdev_controller *);
-void serdev_controller_remove(struct serdev_controller *);
-
 static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl)
 {
 	struct serdev_device *serdev = ctrl->serdev;
@@ -204,6 +194,16 @@ void serdev_device_write_wakeup(struct serdev_device *);
 ssize_t serdev_device_write(struct serdev_device *, const u8 *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
 
+struct serdev_device *serdev_device_alloc(struct serdev_controller *);
+int serdev_device_add(struct serdev_device *);
+void serdev_device_remove(struct serdev_device *);
+
+struct serdev_controller *serdev_controller_alloc(struct device *host,
+						  struct device *parent,
+						  size_t size);
+int serdev_controller_add(struct serdev_controller *);
+void serdev_controller_remove(struct serdev_controller *);
+
 /*
  * serdev device driver functions
  */
@@ -264,6 +264,28 @@ static inline ssize_t serdev_device_write(struct serdev_device *sdev,
 }
 static inline void serdev_device_write_flush(struct serdev_device *sdev) {}
 
+static inline struct serdev_device *serdev_device_alloc(struct serdev_controller *)
+{
+	return NULL;
+}
+static inline int serdev_device_add(struct serdev_device *)
+{
+	return -ENODEV;
+}
+static inline void serdev_device_remove(struct serdev_device *) {}
+
+static inline struct serdev_controller *serdev_controller_alloc(struct device *host,
+						  struct device *parent,
+						  size_t size)
+{
+	return NULL;
+}
+static inline int serdev_controller_add(struct serdev_controller *)
+{
+	return -ENODEV;
+}
+static inline void serdev_controller_remove(struct serdev_controller *) {}
+
 #define serdev_device_driver_register(x)
 #define serdev_device_driver_unregister(x)
 
-- 
2.51.0

