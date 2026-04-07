Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DF3B3C15
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565883; cv=none; b=R/JjBIBxDDequTaUdzYgiJgX1qsYgw+RX++ZC6O6n6ibA6S5DqBn8P7aIquKST4yDnqIofCAewIVsbJpz/j5O2wgjl/rQCNvSvM9oyQDhS4jlEbfHKFIZ8E5D2XFhOGSPP8WUvPmeNPxbRS8wJaXUO94BqqUJGuJrnsCC3sP/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565883; c=relaxed/simple;
	bh=3B81r1M14XQ+V5E+RnqWoEbPxyxw5JHTMY7/853xVX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1OWW8VSupjgqlNcM91+S3+5hDOVRk4mH6CsRi4rNjEue8q8njV5TjxpmybkDmQo+kZccEqC7IinGPYNLwHMPRiXuotU9MRlImoSt3bupGL/356wCMDKLdpBB85+pohb03a6teK4cU3RqWFOrEbnSXvGFUt/BKPosbvarzXamUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6mVp4Lt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+yw09Cp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6mVp4Lt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U+yw09Cp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CiZXi1403543
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 12:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5V1zC2+FvV/denccPne23gyNwCVf6IbVkgd
	zSRYJRIg=; b=n6mVp4Lt6F1mJVa5szK/N0sT9M2HvlBsC/4xkfrUZxRSeIUDa8E
	4ac6BFgLhSsoYLogUcvC2+uZmVd0hY9Gwz4HO6agY2c0gcH75gm1AMzN8UbgrDYv
	PIiQWBswVbKBlsb76DLM5Vka9jFswQrO4ecd+9z9sRqFlb6yX5F5oClf6/79YTFJ
	UMd1fEG/MqpRmoX9UqeZQqvmgqapdA4eyxTOU+CrZlomhRrVneYg5WHxutp0PHx1
	5fIa8j9WJZ3Wld+SPXWPm1LoQRqWReFzXeL5VUSkBRc9tXQa6blNAUZgVvYmOqPh
	J4bnwbjwD+QNEC1laHowhs+7OfDoBxvT0tw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8arnr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 12:44:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so3209113a12.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775565879; x=1776170679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5V1zC2+FvV/denccPne23gyNwCVf6IbVkgdzSRYJRIg=;
        b=U+yw09CptwRPv8sWuUv4uFnyipgobY/aXmp3rcVqbeBYbwoa7RtY5iXI3Y8BsADfrk
         kSdGjHpZSU/ACqUl604EKCFe2KN3DtVZ33J++Hm9EnrkcdaBDWQxBmwzTdFL3wrP08F7
         0xTvK4ZsAWI7fs3q9UaPwGyhbvvcqtKXpGxgqH0gPWuMDp5X0mUups+oFSV5A7QoaujU
         YW+N/h5u/zQPM578ME4+xaLe5XlrdgEtCZI+SGoZ+47rROM+WbMaqk1fdYU+50g4YMxn
         c8KiuIT14dLnt5oQ05fgHrl/+tRgurA+Usqy5nFU9uwT+6YXG851F/+ZNjyV9ybnHQUI
         pWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565879; x=1776170679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V1zC2+FvV/denccPne23gyNwCVf6IbVkgdzSRYJRIg=;
        b=icz6u1ynv2NBy8LuMFBEAgwo5ErfgoYtpM3Nvsq03Bu+7UgaEptVzhh1ALCyH3ZXxq
         Dx+Ci+KgOpa5REc8qz8oCP0qKddqrsGlF0+zw354W50vvC6izME0FGLZc3ZXGRvL8J0X
         JN87czx9NS2QoR5UdHsIVRk+2VGav1H88DH3cLzHNo91Vewn0loaynAx57sLCmFwv4Jl
         ozU2kM2Ty5h0fWUIm59WV2Btzc+/czzo0X+j7uUL9KrBaoGJ+Q2wvQrrH6GZFzSdBM7H
         I5u5IFLI2PaPcPgM9U3UowYpaParzGmkZZnF+3dcOeF4Wa82euHpOjTtFRIv/7h1R3tI
         iz3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBgkhIf5IH2cULAO0n4SofIDZMdz8cdetAh4UjsACmmD/tC1/LTp8I8b/+ycV+9KrOC6FZ5kygASs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJw0+tW0Eu+D3QxQL9jx+kLJVJmTh2dvNM0wWJ8eYUMIlWRpgk
	YqCM+pfooQWXDTPbMIqbkGkXrua52TjxQ7u3B83slDGf1bYIDVsAHsdYwzUYwphelWuz+vNUFcN
	rM0pu3dp+xpQ086qQ9bfJduIeXLRg4kiNSdFIHIkCy6Za27IGBAeCLcchERMjyuw=
X-Gm-Gg: AeBDieuwkKJ/dxoIQDBIwtAHa0Dnut2wFZfncObnRanO2fLhdP0aFxaQ5pEH++uYrwy
	zwHRmdcbTj6AeeHcYlCX8x510yFoRf/ko4YZNldekD11PHqhgNTadujdfCrUZw1cnJU4ud7G3rc
	NEE4UmQqCXJ8T4v3Qa6D3HL2ZR3WdytyIpkHNvWFBPs/YKrtRxNZthfd9cOyiJHNBbznli2h6Z1
	rH/99PT9pc3UPt/3l76JcrJzlWLP1ykNKH4KNzKYd0H/hrKfJjvgORIMNeJZp28ncFhVDHRcMjC
	WUY/ee982cq1Ny1OX1GQ11d6oap534Y+bdOJmtPYBg9qrG5mF6BSnbGB57MY2K+g37x7Ig1qWtW
	0Gxf+YQ==
X-Received: by 2002:a05:6a00:3d13:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82d0dbbfe39mr17185858b3a.48.1775565879184;
        Tue, 07 Apr 2026 05:44:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d13:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82d0dbbfe39mr17185821b3a.48.1775565878588;
        Tue, 07 Apr 2026 05:44:38 -0700 (PDT)
Received: from work ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm18262551b3a.38.2026.04.07.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:44:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
        bhelgaas@google.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com
Subject: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Date: Tue,  7 Apr 2026 18:14:19 +0530
Message-ID: <20260407124421.282766-1-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kMIqpsmgbbB0k9TArDYr0cHKe5ZN33yS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOSBTYWx0ZWRfXyeQPXlRLtfD/
 8F19DADn5wFsgAf35+GY3tJyOsdOjyRid1wneyRd4PtwxbCkjMdt49ts28lNHiyKtojJPgxxpPy
 1V72jkExZGpH1UabiqzmOKF4NiHGKyv+0urdjn1fbCLaOkUpa67mKMU1Z1hGelYx/s5eeaVM/Ei
 vw84vaouAlaYfos65c88KVumc18sU/xUF3UBq4mSMxExO0oXauz+W1710jzOZP+eGYu2v4M0+vb
 wW0cBRslg2CEAY6TFPoPVNwmzE3U41qRQ0d5sfuGwpMINMc9CyW+zcE2NypPyBWnwcBnWT9SK5B
 hYwaW2Ynxd+5oIoADIOx6/0iuPnZAuOZg6hVh0GYrdU7GyrzZnu7TJasZmp9rt3YLOP70W6j1Qb
 uX9ZuRXzXxFPAWQRqZiYXyt5grSyKjy4k4SAic+nrdHZoHv5Yjj6BtR4Momj1uQXJuDIDv0Bp9y
 FQ+pjvX6EjUlvkGs1MA==
X-Proofpoint-GUID: kMIqpsmgbbB0k9TArDYr0cHKe5ZN33yS
X-Authority-Analysis: v=2.4 cv=A/hc+aWG c=1 sm=1 tr=0 ts=69d4fc38 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=c92rfblmAAAA:8
 a=_0vWFD2-Lp1ycs6A3ncA:9 a=x9snwWr2DeNwDh03kgHS:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070119

Hi,

These two fixes are flagged by Sashiko during the review of doorbell series:
https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp

Manivannan Sadhasivam (2):
  PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
  PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0

 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 15 +++++++++------
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  9 +++------
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.51.0

