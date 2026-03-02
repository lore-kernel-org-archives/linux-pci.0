Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63E37FF79
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436302; cv=none; b=Z3w+NsSFO2Axqs9mZdAnJUnoxbLc40MmsmL0LEZPwJpnjmuftFBER1aMEeIostIuDuvd2bYbY4b5pBPIXLZOBBHVJ0C583oPa+sv1GuFc3FseY7IBxy0gypnPbtecO++pl0IVbuj/feAg5LUSjp//YFB9qcQFQUyvjtuTxRphc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436302; c=relaxed/simple;
	bh=JawkNqvPgA6L48YnMkE2i8AXcdLD0ZKltwCOJu1mDBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fAq0rLg/xmWmpD7yF746ZR1b1QgIl54ahV4MOGGXZVD4x9zm1pmU6jjBAB47IPTytP8z6YOQgRj+pil7ZoWgALvQdtyWf8Lto4pMQf8eOipAUNK6TRksmaxvW8pGF5+yz6A7FAIQ0chz0fxlo6u2NySgn6pV9x5T0CChij14IXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GdT+F0r2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i/lcWKBq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GdT+F0r2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i/lcWKBq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621LDadu056160
	for <linux-pci@vger.kernel.org>; Mon, 2 Mar 2026 07:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aigL+7aewNneka1SiJetymaLQQixRtQuEfW
	bXh3AEG0=; b=GdT+F0r2PDPbLfZo8VKh+y5EVglJinoe6+W++R96uN7JPTR60i+
	mVdZ4CRj6+Fx9NX1PSyHjlNEudpsJvNejhtuDx4bnRiQ7UaD0OH3W0J6d2IrfyYd
	yVQ6aCCDK8yYx/ywZvc8ayXJigbp0pt89eziLHrN1V/ZJ/UyYuW3t2IlWI8q1xvl
	MccpukBOujedZhXKf4Jc4qLiaukQXkUZWCBggdTvUjMEe3yalEuMmWkrew1cN5SO
	UR6c22ML/sq+RJxQFJozpBgp1yiUXz4h1xoRK0IbuWekOrdkl5+cpumoiJYiyAsm
	LSlf+THmoGW6yUhUqpTjeEK+9hhqFs2+6lA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cmw6497j4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 07:24:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8274bb61b5eso1001082b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 23:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772436299; x=1773041099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aigL+7aewNneka1SiJetymaLQQixRtQuEfWbXh3AEG0=;
        b=i/lcWKBq645hJ9KH57AyfPIQeiUj8v7nu8eYkimadUH5H1W+9Ah7MCzypb8wMLLD4+
         jT3xv1pzt9MvTdl5q2QjXDK7j1OfQU70h1/lKCU7Vx5iaCHQ9Of+gNz+lfmvF0yndcGY
         pnssZIckIo88mhWFP/3oaYCFNRzjN4/Atyp/8S7g7NV9SvSnU2e8F6cPD7JCmg617Z2V
         M88Zk0E/0J/e7NETPJwI+C4NeE2wH3FkqXMTlHIFydRPQSmKjRii1DKIAlDtXlgVocQc
         L7uB3WFcinTW3qzhUtGCHzZie3c2eGBgGZhuN2/EdR/rQtblNca6+3N+8kuedLo93Xne
         f9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436299; x=1773041099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aigL+7aewNneka1SiJetymaLQQixRtQuEfWbXh3AEG0=;
        b=YoB395VqfbM8Rd8s+1Zzw6tpl1AuaqFxoTbzKJ6WG0ZNyNlQT2v2dr+xt9FbkIaHoM
         1TUG24rq0rMlvTiIvyVOAqJmyZG/0WO7JcEhvw0oiNQws4Wv1o0n2enwgGW/mzUsecgJ
         jC0v2J2oWGMzO4Sk7LwXpwYDj4WkCZ7j39z/1zr01w9hZGxCDWMfNHJryf3JjI74QNBN
         NUG969TEynrSwcZJWQSU9xB4AxgnJjZcBbCOM5axa9uVYIfnz50YJTcXV3jmtawhEQn4
         EHHcPZZdHa82tlHqWIiFHoTpH/9GmWDP/POi/qGM6uOVRmTRZhvOD1vicXXeVzugfozA
         Ofmg==
X-Gm-Message-State: AOJu0YzQv3WHXb4q7Q0OGNAjXzmkpaBd2cwRJLcAocW0oaZfkp5mEfS+
	lPvJIFtF3uanhUDlg08LBGglR8xj76woCc+eEc6UYvyiy7eWgDQvv8+pURaasXL1TEdaimFFSrP
	L5dyhP1S2Ykll3yfmFUjXPIfOs/fWGsAPAh9vf3TDj3JFdS1MsC65n1zeCv72Pm8=
X-Gm-Gg: ATEYQzzEsQMkaMhPWndOQiR/mbNYtC1ORTuQTgm7L7O12bY5hxvnWu6Gh5GqtOeqUdM
	5z5ItImJJ8K1B+7mbfU+sQJ9yXYS2zzaeSwV0RHGPL1lG6O19pA3vY66U28F5pto3d2nVegN5BJ
	pMnBqwZNoLc4ad3L2p/PDRaPFPPs88NO3ym9C5sebuyXKneVLU2PLgkNxaWVxyfKlo7dw6trobQ
	1O7noIrgCXldFyFe93qONpL5uvNq7X/+CEIZOKkDJb2k447CYSrGGbKiCejXEEGawnzf1LGKWa5
	EsicdCwnI+Tm6ZJ0myzwiqdfXRValJ3UPkaKUb18/hTnF6X7FmSrbZGzEkLm0cD2aSCGH/uezwA
	33J9b3SS8MW83LNDxuFoZ9QoxZDWky6bOzoLeqKrI5H1Dwac=
X-Received: by 2002:a05:6a00:1f12:b0:81f:b97:14a with SMTP id d2e1a72fcca58-8274da5ff83mr10851203b3a.61.1772436298860;
        Sun, 01 Mar 2026 23:24:58 -0800 (PST)
X-Received: by 2002:a05:6a00:1f12:b0:81f:b97:14a with SMTP id d2e1a72fcca58-8274da5ff83mr10851186b3a.61.1772436298311;
        Sun, 01 Mar 2026 23:24:58 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:40ee:341f:1665:8aed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8bb9fsm12624368b3a.14.2026.03.01.23.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:24:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        krishna.chundru@oss.qualcomm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH] PCI: Add quirk to set class code for Qcom modems
Date: Mon,  2 Mar 2026 12:54:49 +0530
Message-ID: <20260302072449.13584-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5DFZSAbbP1icDgnwh7aXqaK2Lh7ot8Ai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA2NCBTYWx0ZWRfX7xTqGs7W+nVd
 3Tu2r9gr1zFh81GcOKFE5ZFnc8/VL2h5wszGU397F2spHk+hJsH1sIFF3xphtIJeT/At4txUfO/
 UoXqdixdndE8SQ67vFcw2mbRO+LW0ICONFSsy9SJ/xPegz22UwgXVy9EJVKyGbrkS1R0bmYg93K
 Otu9HQVN62d9vntt9amGD0GHk5Dr3mjsq+QBk4pfyio0HpsnnsmfO5KHxlIEE90wvy2hjjQBMan
 fEzt3IH7dzCMKM1PAN7iV5mZcjqZnEC8mAXWc706JsJOQLMurxcHyHsIXO8FXgKEryyHBzZQ+7A
 kV4vvcJen46TJsGjpQYePHgi+kbEvxApxONUtPwKJULV5rxYe0ROKCrRaGG2rbQ5TZpQ5s4TvsA
 Llq+kvdtWLcGiUF4SeKEsgAwlsK1IQr3qWmIKXGNK44VGtxRqrxTEUWCO7RLt8EBaiMdv7cfRNv
 w1AWKKfgk/PcMZZ5E/w==
X-Proofpoint-ORIG-GUID: 5DFZSAbbP1icDgnwh7aXqaK2Lh7ot8Ai
X-Authority-Analysis: v=2.4 cv=I5Vohdgg c=1 sm=1 tr=0 ts=69a53b4b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=F8cDX84aWdxn-ZvipzEA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020064

Some Qcom PCIe modems do not set the class code. This leads to kernel
displaying the device class as 'Unassigned' as below:

01:00.0 Unassigned class [ff00]: Qualcomm Device 011a
            Subsystem: Qualcomm Device 011a

Hence, add a quirk to set the class code for some known broken devices.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Closes: https://lore.kernel.org/mhi/4c552f50-a712-49e1-addf-7f0950495496@oss.qualcomm.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Note: I cannot confirm if prog-if is always 0x00. So to be on the safe side, I
just preserved it.

 drivers/pci/quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 48946cca4be7..2e49d8a3ea52 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6380,3 +6380,12 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
 #endif
+
+static void quirk_qcom_modem_class(struct pci_dev *pdev)
+{
+	pdev->class = (PCI_CLASS_COMMUNICATION_MODEM << 8) | pdev->class;
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x011a, PCI_CLASS_NOT_DEFINED,
+			      8, quirk_qcom_modem_class);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0306, PCI_CLASS_NOT_DEFINED,
+			      8, quirk_qcom_modem_class);
-- 
2.51.0

