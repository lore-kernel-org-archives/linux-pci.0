Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED13B2FC7
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578602; cv=none; b=fVFyPxdA9DosWGwFcW0yA1JUoxNHKbG9HMkZf56buXtneJ60l3F76TIN3SpgrMlhIyoyay4OkWgys+rmJpf43mMI0iWqxLJOvEur7QVLMyZnoyS8h4r/7al5uMakNB5fuA76jeqr0F10J4muNBXdrfe/k9cGB1sjguXPnyyMEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578602; c=relaxed/simple;
	bh=dRdbHwD0Hrrdp0c4gtwcp4PWR0mHfX7lHE/RwCL+5wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M87DkgbJNtRGzOsVF2bcYlgFc2bQa9g29MDIUSg9yhDug9GYktkXEt2IvqSdZ1h9PmLPxoBtQpPRkTkK2X6CVvQAjf+nlJcpBYos8YXyEGaDfwBVnsRNuM88W0WBGn7Nz8XAx+/S1j3+C5rYtKGukVgdlns+F+KSfgOK+Sj6+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sr7hlphR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dOWb57FO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sr7hlphR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOWb57FO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xhgW2271129
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 02:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Vl5jutfVhvm
	E1lQtUR6YUJHSF2kbL7j9memnIYnr3u4=; b=Sr7hlphRNJftrgiZGYM+USTj2AE
	Cpb9P0G7H66y3b9SUptmFIhkrnVFig63u6kq14kQEy12mhS+ONXE6BEvzBVgGc0W
	/1dMGJLL0984Kk2jj+tKtJov2rKVdYD+cwls5laUSyBNP3fDEvjx79VWkfyFaKC7
	BQ3aFfEyAUXBbiNGhuljVoKg+plcXPhITJyQ3qEjk+5/m3LXGS3QDQfjO8NIWizB
	bgdjNL2Z1ZimIjzTPe37MHORu2jze44R5rn1T0X8UGiteGhLQD2jjvHYvS7Vph/5
	lYLlt8dXIs1iTJZh1YUugXkjFMGGmDPNTiWM/Fg1angWoUizxFINcuHfgLw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteguvepc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 02:56:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304e9f2579eso522378eec.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781578599; x=1782183399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl5jutfVhvmE1lQtUR6YUJHSF2kbL7j9memnIYnr3u4=;
        b=dOWb57FOGIul+gpT7pd3rYiPWFsgt1JkWsjRb8GklHg3iNNC/jnlH2nBFQSp4PRSWk
         /U/lGNUwDtxHUuuqrTWBm74Fds32P8vtSwz3hP7+CABNYDZF5gdQytxHy+YRM8NpFPNn
         zaGVt284DwIK0lTJcsLKGHdP/gyVZZIKcFF9mt2U8fE9RXTGpsvfZ6WVgC1as9XEEnK+
         f83d3K8NhXRtyMo1vil77WK6U991brmVf3exQjWbEisJ/XFOAsc7dqG1yv0Lmg123Zgk
         reFMeSJBrTaBfxw0Y/QViRw5rqvt3cM4fgwX7RYw90fqRZlcHvq9x4RcsAakqNXA/HjD
         4Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781578599; x=1782183399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vl5jutfVhvmE1lQtUR6YUJHSF2kbL7j9memnIYnr3u4=;
        b=iftB723WeXMcbw5RnX3Cn3xQFuDZKhzZgVEit8me3txaCkR51yRJnWS3/OKr+f45KP
         Y7KpJMd05fd/hXSl1hyIp1n78qVyUBommUDurNbHcxuuznpW47zwhxg/BMrsg8bm3eHB
         hEK6gSb8ezzr255C1X0XZYB+pbuu7wdWFX5qZU6HVSBTomaapPiq10wFaoUL+Kublpu5
         TdihiP7tPmb+WSq0QXFpuBT4onE/QDofNyfNt56/gYV+XnGmSuVzZoFpaO70g7xeKV1i
         7Q9z8SDgeYl45KrYG68vKXb5yTtQBK3byuQkWz2l+QTMVQ7VQ4tpheXlp8fKdHlau0vc
         yPbw==
X-Forwarded-Encrypted: i=1; AFNElJ9DKMGNCj601bcSg+oPzJdQ0vAf7HAu9wpSYnQaA68nc5d8J/fmZAzKtKs635ZBr1+lzcl5ayG2WBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+r6fMHk7v5McRKmF8jpftVtESVbbvyyc5MUZij6N1+CZ0LEGC
	4iHbzkGa53mB5H5vt6CdRMG5IdDqneCWlylFSkYxQNszFk4CxFwa61Zh5PNFc2kv03j4waptXLI
	fNowu3HSFGG+iAbTMd4LkWew6mYoSJzdPbrJnbLrWzYRrWRaRVG/1pTgYlQSGEpk=
X-Gm-Gg: Acq92OHYCpR+UJBSlo8gffPhVMjsxOmqFDiqxaiATzHZmnw9LaL38kD9C1Oj/oGZsli
	RTT8SyTlra12SofN61aRKIIbGbAL71cYDFZG4BFxw5tO3UvORPbMMDdb2kV5IjMvSnL2+IKpyvo
	sEmFZZR5P3Pda7ZQw41RgfwNMT+aOG031Gz0qea5NMbZu2CEqfbbjq2ND+cCu9Y8dMSZeeFU3qm
	QSI2ewOrUKKR4mZN1NwmX+5hC03pYWkVeH2DjrhPucQ+/+vxdaZkJq2dgJN8XCqcBWAUTN129EN
	TTTybdpGgyBPpCRObFFP0MLir9sj9QYcqI+RoOuYRuRWecvxzgt+9NCnj+y6jzfUR07hQam8RXx
	3f+m/Ym9QX0gvD25TLvPG9n0Ih9qcUT8kqdijDJcTOK7VqMFoVEhoUTgIYwU7cR/PcmE0H++S
X-Received: by 2002:a05:693c:63c2:b0:30b:ab02:9e5d with SMTP id 5a478bee46e88-30bab02bea3mr164652eec.6.1781578598825;
        Mon, 15 Jun 2026 19:56:38 -0700 (PDT)
X-Received: by 2002:a05:693c:63c2:b0:30b:ab02:9e5d with SMTP id 5a478bee46e88-30bab02bea3mr164640eec.6.1781578598278;
        Mon, 15 Jun 2026 19:56:38 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm19050507eec.7.2026.06.15.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:56:37 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
Date: Tue, 16 Jun 2026 08:26:32 +0530
Message-Id: <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
References: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyNiBTYWx0ZWRfX1GPbyCK/mCzV
 WBHVDBas2Lrs+SPIZvSu314dsNtB3oMaCkpt6HldcaVf07RAEPKvqncSI48npYe0bxa/Olo8o2L
 TTjSph9FrOw1l0q9JwqskRMe6YZLLGh4bOql/169k2UjTbmIVHsmlMMkhgcHQtEZWZiWu+Q6n2H
 tWe69lAUpeeajw7obTM1ADfT+air8skF3Q/Wx4ce1wLgL9iCy2Wtv+GJL2bLTwEtj08+gpUZXGk
 QZfd7+Z6fVGyn/BcpNmfzzQab1ui0+X3xbghg45n4xkOuGI9kTtuGSkMmHaO2tUKlJuwtjjbFwi
 LzSd9dnnN3pjCqZNt/iz/isZK9HHPO/d+uEpg3DyA41Sv1LsfjRNtBzHfCF1XeOBGLIyHgYm6cy
 57xNKUWZ2WfesRTBu4HcP4gyx/sAyiv9Wuq8ovvLk+d9v8JVlm8lquvX71CGergTKlHdNE/GQJP
 ulXtlvmDeiWsxl85PTw==
X-Proofpoint-ORIG-GUID: TWCWP9_Xa7BiekisAShP3GGeqvqsLUUE
X-Authority-Analysis: v=2.4 cv=HMvz0Itv c=1 sm=1 tr=0 ts=6a30bb67 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=EF50nfIsKRdRTP-bws8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyNiBTYWx0ZWRfX+JCJ9X39chAo
 fW1CgReLyKekbq8FCYe5g1wPt12RpK2iWrgooCNJt2Se2VlSuprhtvfyrnifyd9hiJpOkGD3Mb7
 sTJwefnwtx0PU56OXuZnKSjS1uyz8wU=
X-Proofpoint-GUID: TWCWP9_Xa7BiekisAShP3GGeqvqsLUUE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160026

Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
0x1103 (WCN6855) before 0x1107 (WCN7850).

Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth")
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 94c3f4b7ee36..b5ed80d03953 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -186,10 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 }
 
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.34.1

