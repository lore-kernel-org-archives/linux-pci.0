Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB423806C6
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484372; cv=none; b=Lo3jE/DlXniA3VxgHfQvyCTPrJw1aeyJu7C1oy68V0FcKmM7Is7wcqLFyPGUblvKaRndNa2UUPxu+jxPwtFYHskoOLXS1TMglG9lUprnW4vsQlpcqu+oj6AJPVSlsRsW1eb1cH0ynvIdPgJ9kG8PaGiWHkzJL1EaAuDRu4rlNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484372; c=relaxed/simple;
	bh=OIVso6kWZkQJvNF2O9NjSG2Jaux2+AUyYMRQLCpdO1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fl0/k47WykfezcUvsWVEwDn/05wDAzysGuQvhNnmGIQGv6QAyvXDs73y0RimGrkTv+TuXjLuNdHFzexBUN5QgcgKQRAAG7PxvAhe53VdsIXJyuRD2ryuZCjjgReJzv3oNNNhnYsaLIxvF5hT8ci0r5IjfLskuU8HfKvLvW7aHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lgJTcxmJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TlaJjqrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lgJTcxmJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TlaJjqrp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B7A4uN1258479
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RbGeYYCf8ht1gPlSjGhj9XPsZSDF8WslhB2HrHZ0+ZM=; b=lgJTcxmJIuGsF2hb
	LBA2KhTMxmWZelTXNMdlAYNaGW+n8Z7vAQp0RfLwbp36a9hFyb/X/JEG5pvFk/oA
	TluSleToCOiqDhaQuIVATdQ2C1DEwC21WPV9N/5jsQbcF1exXr+aykLPK3k6OnD0
	+QcaP/9M/5RYe45DSlc66pddDI7AgSOquf0oNAuprCAkGaHibdYpsJeSRCtBSlsd
	lEHnLf7kxaV5lrC3YMhxEJM7beyetCpRNbWriMyEv6G1jSfqdpvIVST5w1stQ++9
	cIiYsOatwMD/FeCpsAuV1rZ0UNpVJr4UFldSzKANmHNPTVloE5C3f/OgYSk7P1nH
	rNq3Cw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag201r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:26:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-365faf6006dso4709609a91.1
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778484370; x=1779089170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbGeYYCf8ht1gPlSjGhj9XPsZSDF8WslhB2HrHZ0+ZM=;
        b=TlaJjqrpsY9MGnZsIdxxHIJaAdjW/0hfoiNSx5RKItjtjl9lI/975MCNtWBOYr5/h9
         Mn5tH6+tdgBWcGtG8sIy78jqmY5ityc5IliB013xBAY7PvZX3xZhPYC3wjkFmw6IMtTq
         V0BWHcFGdpsepnEukxqALATlJK86DX3Arh6IdDl9CWAINezGQmkYztZBHQuSoa18VNcU
         cVPEsb3IkiWbfnoDyH3AHtFhS1v4dMFgQTJyJshxxlmnbA8DpnuFnpjICGKJpgCW/Uuu
         EOVRBMrMNEgNiVu170XOuEGDn62TVuCXwwOioTLo8rRXSpBz952HFyH8DbH+ZwMzEP3X
         uxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484370; x=1779089170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RbGeYYCf8ht1gPlSjGhj9XPsZSDF8WslhB2HrHZ0+ZM=;
        b=UwAwdmvVXT0W2prj6bdHT6+8UX9H0hj2QKgablsEsluG6bua8JQObjPbrd1ZC4einw
         wxx861DwSDi9H7ybHZUWs8XVM+C3ac8K5Ez1xXZ1Fs9X8g6fC6o+w/iYbq5iEH62NzvF
         xba+86FUK4QG0t7iAzvZ1kgoJmRusMJncyKK5dpdZUa6t2PEWhVyKO2+KMOkTYyy+lh/
         ZoGGPUDSoCMSgszLcvA+BKqzCEwrj3Ac3J++lf3pQyAsE5JDEehskA8oj1u4HZ9LoOM8
         6d2JVdtnIhBMOsyaQDgYDS+9cH2qIppEOsQCaE/fhOprHm8vkYyiSEMbKya6ZP0GbKzI
         FZbA==
X-Forwarded-Encrypted: i=1; AFNElJ/qOA9ksaZJUWTutb/H4iDx2ZtnKWLsxOAXd4uGaozlP5gH+5x1o3JdSPdlkdjPmjyJhxj6DCvY00M=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBoXycozGtk1tGcrh7r7sHCReMrgGpsJlZ76h7hGrUm1wd1C5
	UWPjAkXxyrJlZzd/Zqn4sopwK07JO29fPm8VWFgvPyPk2JTdPgX7p47NX7LVPv7ESpW4YmnLmqL
	hekwWnpY+6Teb+6fLhml+pz22G623QU2IvozdTFxpLCJvmiV8xTq5W/sqsiItzCQ=
X-Gm-Gg: Acq92OHZVaKQc0MHlR2gCVGy4WeQm6qdLLQrapTLZkFyDMRXvPyS0S22zJHlNv/6byv
	iWROkajGxa3ZHJmdHCiLwBmNkTskMPk8SSXjEt334vMM05VGoFAC2Lo9C2bybF6cs2xwLDRhNYB
	DRuCvVDy1iutp/XoZ5cwEwSAQLTCWU/I7FvlhrqxJYVZnw4/lSSwWUFJLC074VU/i0+aajxcjvQ
	pmDByQy3vbfnppZHPBZid3pScRnliIwvxK/0sFErRGTjPBPHabbn1r/OlAw6W99OsHilZPRBmNm
	WePU//VhPgV1CwwEf4BTFdLA448KHv0An2gR3RvcKrpxKZxIm4NeKZDJKzdIrFhnSfpHuBgB2ir
	BkU8kLUIePRUcwUT3SyXRs7U0Yul5RyoCTFbzp1R4CHzTsPAKBJpsKolfWtjDqPPxNTs=
X-Received: by 2002:a17:90b:578d:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-365ac47b367mr22785788a91.19.1778484369654;
        Mon, 11 May 2026 00:26:09 -0700 (PDT)
X-Received: by 2002:a17:90b:578d:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-365ac47b367mr22785751a91.19.1778484369189;
        Mon, 11 May 2026 00:26:09 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367beac2c7dsm3314306a91.5.2026.05.11.00.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:26:08 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:55:37 +0530
Subject: [PATCH v10 1/2] gpio: Add fwnode_gpiod_get() helper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-wakeirq_support-v10-1-c10af9c9eb8c@oss.qualcomm.com>
References: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
In-Reply-To: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
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
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778484355; l=1362;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=OIVso6kWZkQJvNF2O9NjSG2Jaux2+AUyYMRQLCpdO1Y=;
 b=XFdAtRZMzFR+THosoBwQeZxYToTdCzQYhelBf3Jq0YIvKT+wMt7DAzEXogwgPnpVglW06nLiI
 VpNcQwOF8/gC1RFuTGFgDi0TBkBMjhT1VHRnR23XzEeqyXL5aBfnQ0B
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 2XOTCfQCGuhVhinvI3uk_hVHYdxrW0Fu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MSBTYWx0ZWRfX2WiQ1TGJt6rs
 YXT/QfSF2FJF51H6S9FmJO1s9N9SsPg0o3O7Q0L4TVHC+agb0x+QhX7j3Yn+9ghJVI0YHRFaD8g
 W393QwOUSaA2qps0tsDB76MnbmM4LH0ttG+vIREUbiPlBQlMjzKlkZCd6/f9n2WRYrK+9OntMYt
 18rLwUJqHjORlLtTSxiWBZY+TvZCcxuvq6KFjY6cwdV0uSTSx38ATs/FkRMn9J0AJ1AEBlUlUWi
 6gL12zv10kq7NJpvSzSDiZ43uf6xJ9A+eIctJrwHXSwku+G/FRSaGTxnlivfOKouJ/VcRkm+rVF
 i0HZwq4LEAtGXZ3hGV1dRjO/kVShffker+7bogSw78CI9hmR3Vq2jKKd8R4PT6FvijkZzt5KRqa
 8tR+3evVZfuEWguIFN3gXXstsC/HoofKPdtA6JLy/69WMWVHaSTNmT9RO8rSz33ilN11V3vlyWG
 90D7aTezhP0mxQp7IkA==
X-Proofpoint-GUID: 2XOTCfQCGuhVhinvI3uk_hVHYdxrW0Fu
X-Authority-Analysis: v=2.4 cv=NODlPU6g c=1 sm=1 tr=0 ts=6a018492 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ocqi7cVID08-S0eeb-IA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110081

Add fwnode_gpiod_get() as a convenience wrapper around
fwnode_gpiod_get_index() for the common case where only the
first GPIO is required.

This mirrors existing gpiod_get() and devm_gpiod_get() helpers
and avoids open-coding index 0 at call sites.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 include/linux/gpio/consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 3efb5cb1e1d1..e2601217a71d 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -598,6 +598,15 @@ static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
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

