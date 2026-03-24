Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0432D0FC
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337988; cv=none; b=oBcUWFRZ1xQFQ5Wi9V1oVJ6S8GDw5jrqjijyjJXdctJh2ShMgru97Vr+5vch5tLbpl+x/5vIpiBglSW+fkZ48xu6MltYai3G3fMdxBJLajqqOuZRWk/Rx6voDb3xYDIormrzd6AO87G9FinNKkoNcefWeCekUAok1oVf7LeLAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337988; c=relaxed/simple;
	bh=JfHnR0kRrE0+9OVj0vyCRPCYRhHUFBZaxZNqpWOcug4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIwniSNGL1s7CpHy6BOCFVetYDvGIJmEJVnS1XYE79CDdMpKodrkzCpi5iRyyKHh2j53e+TTmn3TBGIW9Kz6KzCJ/qqjhrW6aAJYzm3DKUeOtl3GK8qMJO5fc6nGVonvvI+ccSNIEnfYOSHc1rudaIn0kg6jOgyJfTAIS3PhCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A9956lnN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d8mGBxfI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9956lnN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8mGBxfI"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3gSnH362508
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=S/SLGvCH+VZJTWYERgmhUz7ZfJe8c83/NgV
	b81UtaXU=; b=A9956lnNlxZFeNn8sOySHKWOuWLFj4ueEsB4p0bLnzGMFuPHtUh
	AAIUcVc83J5VHPhTetBiaqQQ9yRanBnuWyD3bUnSmSDGiYnLO7p4SVV03nJhMwK+
	bRPwkIM9IT5CLq5QzBEoIfu6PJ91hB3gjTqAkbmMJZu9diQnf1pgu2pw8WCOhbkK
	C5a6j1sBQrepF6YwOZS4+SaMKT/UDRTHcUH1WkmQjqAt9Iik3zHUcnR/IoGUIg0O
	Cgfhbj5/VXEGyYSJiGNlBN1zQukt8myHv3BJvLWZaLk/HvmragcpfJULdZj9nBou
	5x1XFC5SZdzBieuXjCn0uiDX/i60iLRlnFA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k3442x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:39:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b04911610fso5498555ad.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 00:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774337979; x=1774942779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/SLGvCH+VZJTWYERgmhUz7ZfJe8c83/NgVb81UtaXU=;
        b=d8mGBxfIbgnRsWPLQEiClXz1yDfmGuHER6KY0d+UOt3jYMKhafP84Uo6jR954YdR0e
         6SWrpBjHrmsptQ+HG2eMcv7I/XIFjhSDLnHNdhlIH/clKahGPgVkbRlFcGhJl4t7MGWC
         sCuwIsWc/zn2wcGe35X1lSilotgbV5u/fBJzMcWoILSrpeNK2E43shh+2ZPuEfTilKCh
         TAAWsIanIo2KxIgFgR+fGl71ZpbUCXH81CA6R4qF1GGzx2WJ8yowo+wGJiOBDvRFCZjU
         y+L8kBAPUIAwch0VqtY1jhBykP9UwtbZ5pPz9Nw6RS9lQ2hCZ88HSOUGq76h80p782zo
         1/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774337979; x=1774942779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/SLGvCH+VZJTWYERgmhUz7ZfJe8c83/NgVb81UtaXU=;
        b=jfHVVV77eDdaq7gsnsNLOXdTw0bmeJGneMzuda1W7zLRsCKY6BzjEK3BL9wIbwuoXB
         jy2JBjvnTePdFdxUNxsSLBIKFYkOlhosvg7M8TVkL2U3Abpfhapfdv26EcX9v4AWMUOB
         Mh2PuYGXeTSlwGtD2B6gZ+/iOzlKbcscXcC6tsAIUFkNYwECB+F8l/4/npzQ5v9h4fhi
         cWzsHLp9Frs7W99jtTAusnj5yn7U/BJdmSsQHNNasdsQL/JAy7/D2ETy3Yc/rfqQfjOM
         0PI+TGUVq1XMr8GU9pueaiWTcQZtFjlZN9rm8cVpOW6RctoaD8px3EL66bgnYA/mDytP
         PWuA==
X-Forwarded-Encrypted: i=1; AJvYcCWbglESAkOX6y6IjzGD2w/H7QObraA5BVWj0veLfIvCaoG+fjvetqWClz6uqmT4K/TvoPpE5fQ9gtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzswkOtQJFUKQAr8D6IMkYunDBDENvXo45K+8o55RByIlywMyu
	075MI9TYcu3AAGjCETYN15B/rWrbwkKCxXvBh4Kk7NNp87JtOgfCS92rOWIdPNSK5K2ykXX0vjd
	IgosNvcjYdN4GWJK5714KoQ2mRIrJ7QH59HeFxdTvWuocEbJx5QK8k8DKHZKxpfo=
X-Gm-Gg: ATEYQzzUSrSSTS8ddG3VyNKEGZJkArkh8XOgKtE4G5Q+EpzvPjOCJ1OXngcLaVQ8GUw
	JC1gZxBVcr9SOHSeKMau0Rs2zok1NXMp4+1Ofqoed/eH/7rArl5n/kvmelWWE64Bm98p4w5MdgS
	8lmDJsr8Zst7QWXkxxnDsU59cx0E2WRt42DAcqbEjFQzD4llWsgNvxNceV0cm8nZJ803Tb0eSRG
	VuW2cFb94HTzkcVAcJB5y8TDGPgOEnCyx/aQw0rUhISjp3xkTo6qIVyj9gePtQMKKu3BYxPdR+U
	k12quxo3a8ainO2PKUiycj34bD1MEyyM/LezssTwytQ5doYIyI9vNo0UDpcsN2y4kRqEoprj42z
	7sZ8MDIShX1E7JPtQlpWJOgDXp/T0cI2+ovE6iCQ=
X-Received: by 2002:a17:902:e802:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b0827ff69dmr139327125ad.45.1774337978539;
        Tue, 24 Mar 2026 00:39:38 -0700 (PDT)
X-Received: by 2002:a17:902:e802:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b0827ff69dmr139326825ad.45.1774337978049;
        Tue, 24 Mar 2026 00:39:38 -0700 (PDT)
Received: from work ([117.193.214.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083549f63sm132738835ad.30.2026.03.24.00.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:39:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bjorn.andersson@oss.qualcomm.com, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, wenst@chromium.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] arm64: defconfig: Enable Pwrctrl and Pwrseq drivers for PCI
Date: Tue, 24 Mar 2026 13:09:31 +0530
Message-ID: <20260324073931.23739-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c23fbb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=13ILl30Z8QjaXWZz8Pan+w==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=L_M1a_yadS0eYkiDDjUA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA2MCBTYWx0ZWRfX7b+6Uy8+wv5p
 swhGMNWykCY68SKWowiSkDl8qjOuaM8xJnghIk0yJOsFCnLn5/l9BWOSzi8GtUOPXCvw982hAN0
 TRlaI2lj+wmyX+b9GQz+dLr6mQp2K2rx7Tsg59cLY6mu1XDxnpGSAek2nzp3XLFRdF3U6DbMjt5
 iYiDgHLv5sjbWI9eZhceAAL60OBtd6Vke0V7OgNnP+cZ2fPvKCgzsw6i83gV20wXSP82D7P/K4v
 G8ToTkGevMR9YqDFNY84HXhwfpyp0PnPHdKUIC4L50T6gcuJC7sGBTh05iPWxBQqpd+yItT3kV7
 uJ/c4xNv1Hxdp/LV+a3w2joiNGjDpekFYgq5ItaVeJ1yLu/jflxj4jp5tVU54npiZq3uSYV/d0I
 z1bilm0ilFqkLsQUwp7Kj3rRztWxBU3YDmncOB/D71fdlhyJd0K6qGCzTLMN2dGB9FCjicI/mko
 eVSarNoxZZypbUjQSPg==
X-Proofpoint-GUID: _zOrViUef0r32Z_ceuN3-KwFOxQXbQUS
X-Proofpoint-ORIG-GUID: _zOrViUef0r32Z_ceuN3-KwFOxQXbQUS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240060

PWRCTRL_GENERIC driver handles the power supply to the PCI slots and simple
endpoint devices and POWER_SEQUENCING_PCIE_M2 handles the power supply to
the PCIe M.2 connectors.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Note that CONFIG_PCI_PWRCTRL_SLOT is renamed to CONFIG_PCI_PWRCTRL_GENERIC in
pci tree. But I presume no conflict since the PCI controller drivers themselves
select this symbol as of now. I plan to drop those selections from controller
drivers after v7.1-rc1.

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8a5309bb2029..597e013f709d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -259,6 +259,8 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_GENERIC=m
+CONFIG_POWER_SEQUENCING_PCIE_M2=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-- 
2.51.0

