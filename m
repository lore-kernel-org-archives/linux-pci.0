Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927F7318B8F
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402369; cv=none; b=RrXXqUURt5ARVf32V6qOghkbeKBhWUyX1F+CiZGKqXKguxsAbk52eMNYvMSk3VYvnbR0wSSWTbRw2afNwoJCUfCnwJ82r3rAzBFt1KbNBQaz0ARUc9+2p10HDNYL0YrNGwKal0oEmU/phodqqG5yIFuAuLPCd4X7glTZb4SuigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402369; c=relaxed/simple;
	bh=kr27uYpqKnl3/NaFELLNpZzJB0wElVbtKvpi6VqgH1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2dPsB1AgngIPha/aQiJRkve8C2/LEOdZ5Dk+IdzmL5NtCwbUwzPTofZXr2tWPormGIAieigmIhjiHhYJCq7XbC7MeZjJo/a3m9pIqgx6ZnASfnmLYfqAno5uGs/IqNu27PII9Tpyusz7BGLR8nS8k6oOWPoS79uh0UI7Snozkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VIyYDvwG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MkoMn48l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VIyYDvwG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MkoMn48l"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I83pYb1943541
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 08:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iocoITrqzOavAzny70iEVGcoDGpxtUqYXZTgwIQV1KU=; b=VIyYDvwG2NMuEJ8Z
	QqIv6XDRxCwMPB3WoF/mNYBu7FrrxN+zjRq0q3qTETgZfWx5BplPVFnJ7wb1Jjxe
	AHOjVekZN2rd4OHTZyoDWXGq/v10wGiBZlnmW7KiUR9mH36eIAS6WFNEPJvHQcBl
	S5HvO1zYyxy7h1EYYseORgqEyVRulDcv7hKtnA63ZGBnp5vK2xhljplyKpxhN7ja
	hJBx8z5OYSUgVyyPpV/XFgGhiz3hO/9CFcAXuZrjYcppsrHA1QqFzXubWwPyzIA5
	UsPgZ0/caPzaPZjjsJLsKfXd815AT9ueXsNM/meSlAvbAOuw+zew5ExzreGF0xD6
	kvk+OQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccq4g3b5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 08:12:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aaf0dbd073so64302535ad.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 00:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771402365; x=1772007165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iocoITrqzOavAzny70iEVGcoDGpxtUqYXZTgwIQV1KU=;
        b=MkoMn48lut9BGOAJvMPpVAViP+nIHJilfaaTDvPCsZ6MTi7/P20ak5faYjYGl32jbn
         6ZVA6mZmhj/edcdlND33A9x71XTS2hHy2X1KdFVjQFZPUjyHmZ3Du5HNiVVJj7FKLaY5
         aa32wwLp+8dXlV+H6udixDun4fURpmVAfA62gZZwQfubhCnSWo/6WYy+dulC3vq7w3c8
         Moyu9HUdPiQsbBu20WibgOkd36L/OWC6SXql9fewfuyjQ/wfq2DqpG8Y99aUbO7ABNyK
         XcAQXpZt90IoVwZGCIscQlhq+mUWs1dUbeZcft0ZzDthSd6q+dWTH/Zkl85ey2ebxRuI
         DS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771402365; x=1772007165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iocoITrqzOavAzny70iEVGcoDGpxtUqYXZTgwIQV1KU=;
        b=lWHPFr5rfQLHMTqxnFvv2mBk7eT4gBcQvEM2n2Lg5RPzUsgqYQFe0UN7uxKjsuNn8S
         XYYbHi9UAPiya6pBNDs5P3F8uUVJhx6zoO8AJ8EdMnL90gecYjQwB37cy/2Ssq4ex9h0
         OewE2mKjNJ3N4fYmuKwciXZjzAYlNue/iIkwxytcp60rMN9Bg28y560I9doA3iyavOPT
         TFJG230lDRbiPxoO6Yx5apDpSserIFyWRC+VY9xTibW5/YfUsC0xts3J6g646BV/BQRY
         VfTHREv1D6ZVS/ytp5VPXus41roQpbftbXuQGZ4hlPO6XBto1bumTUWO7oi3r7TfcDCU
         /tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZGuZNM2G6Jsx1SLAofanAkjl+c631vyPu8mKQYDw0WpGnJarQNctPvIwzX/o0CIimYWlCn8hr0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhN5998MDUakFyCWYRuu30jdfjGu2kiiHn3wfHBJ3WPFbeoeT2
	7k70vimI5D53CR3Cv/Oy5gM5sEJVi81Z6wjZciDk5gmGxXKYqnp9GwMJALOBJ/hDQQE2ynUV8CR
	UYFk3rIchALQYZ/8JOLbrVVQn9FWh6SiijADnANJvc6bGtUATsUYK9KIXdXwFcD4=
X-Gm-Gg: AZuq6aLtvzlUJIvP63fN+XRNDUJhEw2Me8OqFx3ZOYSM51Iul/4sEV5QUQF8p2CkBCF
	vZfqhgX0Y/FJSJ6R/Tx6H+2ariJYfp9qygfZKqAzrRtlwf4RZ1QobOqoGJIafMGbVbPz5USwbu9
	wCXubE4XVNKvidaJ7hNYDpQQPs9wfiDAdoTzt7PVlUDwDoLSpIr6bZUiGUX5FprBbnQty2OGmeK
	La+u7qnUvZKYASUARZqpd/+c4luJgBgh22Ogy4YpFeEW22djZv9lkRhRiclPDS0m7vNIbRHdNCv
	BDPgS8ZzG0JDg4UE8A3yVktlwxF++QiqvMyaJcjxs4ksHra9cqHzS8aC3VU4gxNWIEthk4Gtd3l
	PZagWizvgCJt1e+cs7j09CJW+/Y/hYY/GpQJxMx0Ix/z05OKpm3KOoJiE
X-Received: by 2002:a17:903:320e:b0:2a9:5c0b:e5f4 with SMTP id d9443c01a7336-2ab505c0e87mr138782815ad.28.1771402365453;
        Wed, 18 Feb 2026 00:12:45 -0800 (PST)
X-Received: by 2002:a17:903:320e:b0:2a9:5c0b:e5f4 with SMTP id d9443c01a7336-2ab505c0e87mr138782615ad.28.1771402364996;
        Wed, 18 Feb 2026 00:12:44 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d624esm118123685ad.49.2026.02.18.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 00:12:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 13:42:24 +0530
Subject: [PATCH v7 2/3] gpio: Add fwnode_gpiod_get() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-wakeirq_support-v7-2-0d4689830207@oss.qualcomm.com>
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
In-Reply-To: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        driver-core@lists.linux.dev,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771402347; l=1194;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kr27uYpqKnl3/NaFELLNpZzJB0wElVbtKvpi6VqgH1k=;
 b=CHIK6Dfv3xgeAdlKFHR8JSiT1167UOJDFNWBSMNuEKKQj5r4d7YEoEK+RMUc/wYwINFP5f56O
 Nubwn8ni7TBC+yld0IihIzYNB+K6wwABaSn5UR9uMig/MvicYBQ3pFu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3MSBTYWx0ZWRfX4LG1+u3yVKav
 QRzp8h6RX64r5Nip6pz2c9PfEHnsLdSAIsnRTpLQ7wFvZwskOHPOjOtLJTLsbiMGqkXJ8sEOfCe
 +3l5tO94akoC36Ew6pGMdIntO6+0B8EeO163Xi8Cxz0aHZOyu9bkAqRYn47v0CIq3WLANiHxrbo
 aqvlFvX6LUPfwUpdsnuMM21bTE6Vr9CPyBzMtLyqvGAC5a2iuBxWuIzK7kvyNxvcjl5nxGNwsZD
 +q0js9BkkRwt1l37syN/izlVgN1Lgh57LC/Xaksc5cDsP/b/3tX/yTLaFaxDeAPdtvC993o3uBB
 BHKniwAJaL6qV/AMWMDOOPbMzB2nvuMZP0mr4EIJe9Cqh+3hnYgy+jHMzE4xK9BhcJZjVQ9VMsv
 CsJQwp/eZlvgOI67FpBNYHXtbfZzKmOZzGiCj8MTi37tp++m4IVLlb4Iwfa5d7ktzCnwRyWoysa
 dzzXN1fqAJ/UvrB4j6w==
X-Proofpoint-ORIG-GUID: 7icq6BDAA2nJd1CfAEH99XDwQk7lmGh0
X-Proofpoint-GUID: 7icq6BDAA2nJd1CfAEH99XDwQk7lmGh0
X-Authority-Analysis: v=2.4 cv=YdiwJgRf c=1 sm=1 tr=0 ts=6995747e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180071

Add fwnode_gpiod_get() as a convenience wrapper around
fwnode_gpiod_get_index() for the common case where only the
first GPIO is required.

This mirrors existing gpiod_get() and devm_gpiod_get() helpers
and avoids open-coding index 0 at call sites.

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

