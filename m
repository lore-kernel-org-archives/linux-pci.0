Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D694295DA6
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773453405; cv=none; b=iOPfd22Z8h+6ELoihPpQZ7dfAlOm/LeOpeTgrZ4JuFvuKIdsR0holVRyvi5mDIaiGlyJtUuO/MfXztE/PjBFLooGWnUMNRtwLytIBVJQWO7INYNomDe6V0ISqq25o8taXPF28wFOE/ZrOhF4sJ0wbxsu0G/0Bp9iD87EOjk6XnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773453405; c=relaxed/simple;
	bh=2ScFGPmYmss06z8sOf5Eks7Ar9nunEiSn3exz7e1f8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AYFZ9lipuUz86pOKPjFZpMU6+86SrgKm3ZDI5LdXntzkWT5szxvGMWO11N5UccSeHip1sBv+v9xnqrF7exvx8iOOaaJpgOPeisEU71A7LU2XtH+QBCbMk7vBZrwul3/4z6nKlzEz+dAwbu2XR2WxWqPwkrNmj6AQQEuj9lFysZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ll7I4FF9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVPTWV4k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ll7I4FF9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVPTWV4k"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DNH8Ai1436994
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 01:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vFM6F45qzNjkngt1OTK4+Y
	gAMOwKlmATWIoBHfjRvCg=; b=ll7I4FF9OwK+i/k7K8mFzz1bQbqZuTCVn6QbNp
	FTwyd3tNu7BmzGSjGK6zjyj5LYA0bElhJLAusF36Wx9PBl/BM6BRnxdzYtbR5m+u
	2qoFhyg678gjIKNkFgWc7VKrKKiBouFFL7gVfAcH6FyWUVwIcCk1OnrGf+zhf6fX
	NIusYVgNXXA8yQOaexGAw78MmaDhxI6Ku9zMTNGkJ3NzqIidCDrcU2EbdNkM9ypP
	/dtxRyvE/2z8GRtzhaudAOlWYuxrW77/R9gAxYiXlOY67xXsDLBwM5SfHg/t9V0l
	TWL8hXO06CtcxBhdHkXDbNmnUgIvxDa1dDIBEnF+RBCsLccw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvnax9pbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 01:56:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae3badc00dso32793315ad.3
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773453401; x=1774058201; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFM6F45qzNjkngt1OTK4+YgAMOwKlmATWIoBHfjRvCg=;
        b=cVPTWV4kqqq/3jHzJhHW8iWk7UyUJwySgJbZZOm0XOZKiYexX1yYCOpik+vbpWPwlU
         WvtqUdmASMa1p+PsGPjqLE+M5x9lfB43vqgPOwUJCFURN+w5+8FNpUyTsrhiYjjcB7y3
         UevteZW8/r/8/kDym4eOmNNTAyLdEJQ8t/PsgBsxhjjuk6F5wxQzpYGs7zKc4Otoa3n2
         3+PQ1FeSagPkOdaUsQUrveIJix9hexOT/ZJpLfRd9aHaXUdPTKrNohKyUdxm/Zh8m5MR
         QhtYJLxONoDMTJDyXxGgEUSdjCyOgzxtoIWnXk+9viVuQd4AfFxJSMLgTI2gqje6Fk82
         AOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773453401; x=1774058201;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFM6F45qzNjkngt1OTK4+YgAMOwKlmATWIoBHfjRvCg=;
        b=iEsNZVRPiNDBJOkxA8f79wxS03QZiez/ThaCyoN8yJDI/ACoSyaKX9GS45VoWgP/Nr
         yt2MwG3lY2krVky5xKMXqnx3kJwjH+Qx1pMT9hEkrVWz4w2OpekBNAj1Y+aophfQMj3Q
         OMf+xPGdTvvlzlCLIWCi3Z+fNvSSLUdP0wdHddazftdhxoP2i48wG8zfdxfDh1mzGaGN
         ZWqbtTISfYxbrA4O7+aAwDzBTs6/DhKJ6YvpMXVH6Sr18bFMhCzvmXsnDKHC9YeFRuhR
         Cdzta9LIFn+am5/Eju5nQ/2YWiqzHeJ518L2KwvR/PAJy/8DO9o0iiFnUwKxx/ge2u4K
         14eA==
X-Forwarded-Encrypted: i=1; AJvYcCW+H0TrVr2mOabftzlTyXgQ7/FDkt9W63OEMzKt80PUq0DT9nM3HK5itGgkNJCVz0so+6D2cIVs8Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXwzd//sZbg6FhODZXug8HPWg5KCKL0jPURk4XRk0HYScFkr6
	TpBtn16vyfzFQ0atoXTBoTn8f8ZFAnNLhSktqKoQV5ktNh9dalFYuXt0ITAWLWvUUrvh/8SPpZo
	QJuIHzQzQvDqrPUNz64r0KvVKKdCrzLcPdP81xKqMH21iUjs4OZRdI9MuA39Nb9k=
X-Gm-Gg: ATEYQzwg2fO94xO8i/5+kOm5BwPLLeyQZiRZJye18qEFlX+Vo4o28GppRKDssepAs5z
	WbWDj0VdyGficGn0C8fsUAubxQLvP8vU7l0Akz2nOsDAXvlHAuh1WTIcJK31XTpePw9bM0KESw3
	k2wpfaVwbK1oL9WvDniqzUxEQqoNPUGgmIPm0GbLZDZ1GCyS3Kp7PXajINfeObix5pYomVim6qe
	qxa0q0GveaGTAatAbOEb4xtHgi9jrUlB0w6SmSdCHTA8Sc+r5vFgXbxEY9hsR0Co9M+0XzkpdWQ
	tmb1x4Fl3r/zQsxaj+gCQcXN3WLM4Uyjzg5l8HXljl9berE7M6nEh4l1vg3ipPDscem1URqI58p
	SMm8w+lzlOG8hH+Udf/HXCOEiSnEYguIAVaucPUtGPvYWrAawwMzwXpVl
X-Received: by 2002:a17:903:8c3:b0:2ae:5eab:1338 with SMTP id d9443c01a7336-2aeca92df9amr47754065ad.8.1773453401461;
        Fri, 13 Mar 2026 18:56:41 -0700 (PDT)
X-Received: by 2002:a17:903:8c3:b0:2ae:5eab:1338 with SMTP id d9443c01a7336-2aeca92df9amr47753865ad.8.1773453400950;
        Fri, 13 Mar 2026 18:56:40 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c23esm46732815ad.1.2026.03.13.18.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:56:40 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 07:26:34 +0530
Subject: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFHAtGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nj3Yz8koKc0nRdk2QjSzNTS9Mk0yQLJaDqgqLUtMwKsEnRsbW1ABS
 8PyhZAAAA
X-Change-ID: 20260313-hotplug-4c296595b5b8
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773453397; l=1869;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2ScFGPmYmss06z8sOf5Eks7Ar9nunEiSn3exz7e1f8g=;
 b=bjj9xZTttgB+qK7+ccnya3jBVKEd1or4JbvtK0XASfDv4TjTu8tQ1QCfQtk3+lmrcFlp0ZLvW
 kbvyTSD63XiBGETQEKQEaLjd293NJV2dQ4MkgIJItGiJs8m5nkD5DDg
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 5nHnqS44kzJIwwxKySu0afPLs5ZOeY0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAxMyBTYWx0ZWRfXw2ODa7OinaCW
 J81zeUeOJzXZLMDyLYTFxxdhrm+8/jbVS2TJndEgNeyliCtZ9ZCUeP0+s4giwmxH8nrfZAqiPK6
 jO8PCIN1EoDYh+pOMuvB5hUYNLfIZhwrBwpQ2nehbphn3tyEpWC7okCTp6RqBSxzdgh3eB9h7nf
 116WuNhlLKszpwEriWCT30vuD36QZDWfs0IjjxWu2R1as1yq9GnKsfnYRuiOW/rGpKCRSUiIVYc
 bV4NrcUGqPE4F8Ql4svUWWcrSr/efwZJdQct6DlbkgPG6IbRzhp+h7vOF32r/QNEj0wsOJ+bWNo
 WYy07dm5G0fwNJyqgUeRDQ1oYY/wnlQhU/RokvA8bA/XJrEcpxK2Afonjmk0Gd47H3zDbaRIy1+
 Y71c0fQS9c2SaQbH7gwl5tL0bb+QyUESUL9JAsgs/+ykOvxTU7OzO98cTBstvlZvb16HIcG8qWq
 eO5u258U4XoqSJznS6w==
X-Authority-Analysis: v=2.4 cv=X5Ff6WTe c=1 sm=1 tr=0 ts=69b4c05a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=yYIiXX6wkvhfn-NU2jAA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 5nHnqS44kzJIwwxKySu0afPLs5ZOeY0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140013

QCOM PCIe controller advertise hotplug capability in hardware but do not
support hotplug command completion. As a result, the PCI core registers
the pciehp service and issues hotplug commands that never gets completions,
leading to repeated timeout warnings and multi-second delays during boot
and suspend/resume.

Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
Capability bit entirely, which also disabled all hotplug functionality.

Instead of disabling hotplug, mark these controllers as not supporting
command completion by setting the No Command Completed Support (NCCS) bit
in the Slot Capabilities register. This prevents the PCI hotplug driver
from waiting for commands completion while still allowing hotplug-related
functionality such as Data Link Layer state change events.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_en(pci);
 
 	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
-	val &= ~PCI_EXP_SLTCAP_HPC;
+	val |= PCI_EXP_SLTCAP_NCCS;
 	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);

---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20260313-hotplug-4c296595b5b8

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

