Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CD36B05A
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385749; cv=none; b=PfSwGcu47L091HXT/izupsSts+fj4H9gi68V21nKDxSMl/og9SRgs43vgMefKatjo7358x7Abtj/ft1sOFBgWOVXrrF5z+L093vIxq7NQQsbzDy92QFG4PPWRjIWtTcJDF1SLobtr8JAUII1l0iO7K0zCjQRfPuHsgAzlofXwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385749; c=relaxed/simple;
	bh=RJyJVigQaOLM0F29T8s/4IhVwmKqS4ZNXPoeDAhzrkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRMjRdWYyL71DM7J/E2DuNUH52+fMMYqkAWz9LOraycrjYvmt/CXhPSPPSFFduN4X6c8H3QxKgLrVlpL+KQ3egShGgMX6R7vGE6hgfhmKX71i1OEI5zKsLznjdY5F7gfR6bGPxHwMKhg8Cw1i+eJuD8tq6+OIf0bKIDGcBW7UrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnBwfq7R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VI7/5gM5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnBwfq7R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VI7/5gM5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tYnI3229721
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZBGna102s7UxMKQ9bLg8nid6z7Q/g4WSEiY00RCl3L0=; b=QnBwfq7RRGsS3fGU
	Js0PO1nYVjvfiAJCG45vb7H4EMdm7X/FyaN9eqS2/9BUbqjcOMG1Orztb2eyy0JD
	bTcegnnN4N1BK1c0OAbWET1IivwkcjZZ6tdluibyaEZjn0Eh92Z8s5AgTGZlBek0
	gB0SA/7CQe6KWMRHn4tUjqDSb/2ledeWJiAmcFsxkCR7jVGuz6LNAWYA4dR7NYQz
	LJ8c5PQf7HGm5yOHBztsbdNZ12NIPDBYk4Ue8C96LEcyxjCtZjIsZILdK/jlHDi3
	OOMQJFcz4ZXarzx7S0e1TlcapeluhzVe5+CmWxRfxZm/l5yqQ/JPVUL3gCiclzI5
	YAOl9g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7gynu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 07:09:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829b6b22dabso781780b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773385745; x=1773990545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBGna102s7UxMKQ9bLg8nid6z7Q/g4WSEiY00RCl3L0=;
        b=VI7/5gM5MVJcJXXboli4yxn8NlPLbkuV2Mfq7hNgu32Ud3k5mxzcm/Ny8nruVr+0YI
         ipt8GNnC6/eqx+PpY1rzwxreoai/Mqx+HtVQCUPVii/6Vhbj+/9PyYB/6XGzYB2+wyQf
         Ea7jAcjeGqFXeECrESA2Xf9Hg9Sj6A1mE+EWUDf+WwNY54Cd6J6Yo3Ql5IYRW6EfXe0J
         L6onM+0sMW4YT2t/9mKWW4iccupQ+Z7QLyXvwbl+REb3aTVym4aoHY0R66axSnOkZl44
         kBgHUnNEOrSeYmxsXG3Wl9WEz9AXVFPAXjuAUTCnt73w7Pqwf4KtdwoSiJboLE++smAM
         dioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773385745; x=1773990545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZBGna102s7UxMKQ9bLg8nid6z7Q/g4WSEiY00RCl3L0=;
        b=UyFoMIrruM2IPvOxqyywD0NMnfQ/eUUQginQ0mjjyjA53AdUGvtQQe4vOgOmWftdvh
         6a2St5dGNCep9ZtOTe8sOaAnwKAA5A3w+Xkw7BL+uc+VFGPin5ehF5fQ/ys+VshXJ+ju
         spQoMAYdD8N2RSGqGlTSeBRsVqpXKcdUUppUUYlBtsn03YcPCnQKHZJj8DofmF9p5L5I
         gvGKcDIWPcZGF7YNYNJG2dkdsO6zZMww7/EBAP0B0m74hIE9eHOs4VyC0f2xEx1qPIWr
         iIXwn8+CUuJm7ru6/ZpLyFwR4PcXjUi/PP1Jyhk1puANnm8956jyUC3dpffvIEWmbsOt
         Bo7w==
X-Forwarded-Encrypted: i=1; AJvYcCWrIMEkl3yTMb8bphaMgP1sKnKioL3OLXzzw/PzOmiqCOXNyJK5SjH0NKR0bPLiE69rdvhh/rLBSqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/aiKyUuGmcluESgaoWawxf4ZkDwiWO9fLvxSXPBUs8aUqeT9
	ZEjkIf1tHjs199n6OgSaX+vKZ/O2ynKCqMUfetzK1LUVeZ4dkED2HJ9PVx8WUTg4SPKSeeC7378
	5zTYrXMUjaQxq6zDqWA9U7YqqdzRD9KaiAfWoFEhyyznrkAxj2BSy7fj20J+VJmU=
X-Gm-Gg: ATEYQzw3O5D0jPlV1kfUMM14f7iq1QtBA3N/vN84xTbm78vl6F5c8t7AseOBkm4y145
	W0MeOXBOlFuHZhu5ZhEk64JIQt23w07e8U/f5w/7OYWMvLWwwViQAgEmPUQyWQbYtKM9Wg8Mh5+
	ZA7xLie0LepfxTc+NZ5+or1vhewFkujpp5THuLZf+Ne6J2B8CjAtnPfBGMjQJph3LsYQbfNlie7
	zJ0HnII+4s/e4QMh3tj31vRX4/73qvbdy1VgK+qSB+IUJypvqbh2JYJt4TTRgUojLtWzrv0pzCJ
	udhPPqSpXcfxkGX5XQK733lGRrsz2+GBYFHYoMNUhNx2t20apGjsH8DHB/0e1ACBqQv4nc4P3N1
	QeUsixbjNnLorRxWbzMcfuRKQBn8Nxv2CZvT+UGLLOo7UmPkiNCtdS2aW
X-Received: by 2002:a05:6a00:928a:b0:81e:4476:f67c with SMTP id d2e1a72fcca58-82a196d976emr1922406b3a.3.1773385744780;
        Fri, 13 Mar 2026 00:09:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:928a:b0:81e:4476:f67c with SMTP id d2e1a72fcca58-82a196d976emr1922376b3a.3.1773385744317;
        Fri, 13 Mar 2026 00:09:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340518sm5148536b3a.34.2026.03.13.00.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:09:03 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:38:41 +0530
Subject: [PATCH v8 2/3] gpio: Add fwnode_gpiod_get() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-wakeirq_support-v8-2-48a0a702518a@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773385725; l=1348;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=RJyJVigQaOLM0F29T8s/4IhVwmKqS4ZNXPoeDAhzrkA=;
 b=D8zrgRQtWArQCv0Zo1sugUcPcd6RMCLTFZxMCAirCh1759Ub3bZFRNHVBFJlIJBo9VhI1BjAH
 n+15tflY2ABAjeEzI0mPp3HJ+vk9sBQ+glRmAnvJ+fcrsp15205EQG5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: zd4hd92RiyG1LlGI3wEErD-Lg8L0Qdmd
X-Proofpoint-GUID: zd4hd92RiyG1LlGI3wEErD-Lg8L0Qdmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1NiBTYWx0ZWRfXxvtacrCI1BSl
 E7g8zVsh52a7LVfWiLfJ5bgKKkpx82F5EdPhyAfsQtj822DAuG228sxjb0wZXMfumSgFh2Tmcsj
 np5RwJpsmt2we+CAA6BScRBvV+z8bhv8uJuHnhKqTDczng6FKVt2iDWg2O51j8V0F9GNgWae8+R
 YB+zYLsRUD/0xpXUU+S4ri0YTuS9Y5n55kog8SAM1bOGvUNYxtUWL1yjmNAn1rJ6FgXx33EpAog
 hRrjqDP66ff8VZ2F8ArhvXI+L2oR9CHizhCYW50XLjE4nAiTpF3ogfN6q6d0ImEDF6omAoT+SuK
 Zy0/VeCk8bmgXeA1A2QdLSiTFurndWKUl2b6jm3SWdz5ue7c2TIUnBImZ1b/OpPUGL1hr3HoWM2
 UWwdSAE7bxin345apZaw2pfl8efe+ewHKRdN6kDulHhqsfLu1PdYkfAdpTzg1ECqREnH9xMBe7U
 NQvkCUKO3fXxHh4e8yw==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3b811 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130056

Add fwnode_gpiod_get() as a convenience wrapper around
fwnode_gpiod_get_index() for the common case where only the
first GPIO is required.

This mirrors existing gpiod_get() and devm_gpiod_get() helpers
and avoids open-coding index 0 at call sites.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/gpio/consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0d8408582918680bfea6a04ccedfc0c75211907a..fee926c0262ce9dc4b9a3c151e74f2cf37470a49 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -596,6 +596,15 @@ static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
 }
 #endif /* CONFIG_GPIOLIB && CONFIG_HTE */
 
+static inline
+struct gpio_desc *fwnode_gpiod_get(struct fwnode_handle *fwnode,
+				   const char *con_id,
+				   enum gpiod_flags flags,
+				   const char *label)
+{
+	return fwnode_gpiod_get_index(fwnode, con_id, 0, flags, label);
+}
+
 static inline
 struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
 					struct fwnode_handle *fwnode,

-- 
2.34.1

