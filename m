Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D652FA0C6
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067934; cv=none; b=IFLZG1Bqx0WMkzjewc3ky/kL8LVp2XK31NG70l6ngTHdIcGj9gZZyfE1ZkrCPmlyW3uEFrXTtLNrohQxt4YUxZPKXUvF716ZfrUgyHA9tg2nl4mpSFhGTyG+WVJWhDaL1toLUJdowpUL3KYqoliRNeY2NLrQiRsANbfV9vbafqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067934; c=relaxed/simple;
	bh=PMstPFg1QN7a4XoG9VnKG/9ifAd+dRDq/L+1XKm6iRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O76DsZK0yJKk6wPTeOiy3L00808LHM6IqXV27mYCRb8iUC5tPkReNFxLvqLApgjX/uDPfW4wZzwWPraD0ZYakdBXMt6x3h1ZsPwh41kH8BzGXn9hmXBROV8LpmG4F8crSUopAWJhwrzn8D2XI6mitnRZCo5SAIHtjNn23KPfFcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LPyfvjzV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DqFavM5H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LPyfvjzV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DqFavM5H"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LLagtF3867416
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 07:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6lhG8ds9fGZW56ZjCR5UpZ
	AcAwZrWWFB1JgpuJ3VisA=; b=LPyfvjzV+L6BqiC08W89GS54332xskpIvGSV0y
	ACCzFGBpHZcX67gke9KbCte13YJcs8XKmjfsXPJo/6UzfZTQK2oiOYF5/SY9oOkU
	7klSDmkxSYqpSi6pzMrOwGRhApijVy1b+aMTimxZvvXk9yf+KAcqhW0wmOzxlHgM
	0dRO5CGBejcugzSDkYMnlwjhw1/0I+bI7izT36ALHQRZMgCseX53nDwKCykfPqvA
	F2eEtfTguqIiYvJ5yyDKonYV7+1SheYoUUN7mAB3ivewwSTjs5W2Ww+6sK2sEYlz
	ylgAUc0A/K9wSW7zh+zrDzFeBT4xjBKMBCRPjCpKYdeB+Ilg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btyrpk3yh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 07:45:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b724ff60e6so596934eec.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 23:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769067926; x=1769672726; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lhG8ds9fGZW56ZjCR5UpZAcAwZrWWFB1JgpuJ3VisA=;
        b=DqFavM5HYU851FOd1rWWPO0TOzlX7oRQZxcvzS2UipF0QvwtGAx0aGo8RoB75x9oVG
         c7xjuDiK5w/Q+HVJ1nMwQV3NySp3XkHoZbM9L5XfWjnJsdnEvtIkkeEUCNleTJ3mJS/V
         r/N5Ea/j/KH8bHEb3kkT8yB3x90b6giGUNS3TEEYYPmm1Jtj/48OsCpqDeUTk6O3UDYt
         jwP4vQODxQ1Hsyyqahu7GQ39zWhQwNkFBZByEnj9VgXHEJAdc4fdLRZJOKVnCkhR+jge
         n9A5i2C56j/8IBp+NrD/Skpg6L1jIOGy/+FOSkYNGeP3sCzaaf8D03raKhzdjdmPoC59
         CC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067926; x=1769672726;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lhG8ds9fGZW56ZjCR5UpZAcAwZrWWFB1JgpuJ3VisA=;
        b=rItPrK9rksR7/t6RISAQkZm7CIA4BwwuRVpAUUglR+1Cgo6AIqnCg1YiDiflCPsxdW
         5Bc8PRdDUNp7Ykr9NcOGx2rWrlAeFZ7/oZvhyU4MsFoHBZt4NwlY1fIDGBWxypfDuxu0
         ztSK4eEmlZQ5xZNKlKckqInsDYkFAeFAGCvv7r1cuSaqrBvyH7b4PKZPqOxhfwCKJCuc
         kRNzt3EtRSFvhif6DBXU3gG9FuV+FFSGQi0iCeesLmdrfRQAQLHXHlbBmJR8hH1zTBlr
         wjtDNBdMzOVIl/lRaBPmceQR3mzMwTjgnaQRDsrqhH29AEAuD2tV8vVgvizokP/Pi+pW
         HZpQ==
X-Gm-Message-State: AOJu0YyYF2nqK2OEHOwTgTLvzJUMC0ymSYGdI4zDXhRWEijxTFplTUxc
	fxiD/BK9/2YYQOmlR3CaqNTOgsmYXNULq3l+Tr8WwRoXyuaz8Hfdd2QxqrkHQtU3xC/SnwzkBV7
	NMEJn8ArM4aaKQY3Xs2J04j60s4K8NyHCKLXOLVfHRx+NVZuahrlY69BUzwnsI+bOlB1G4fU=
X-Gm-Gg: AZuq6aJv8sn4rO14rYMGTS8BOsCA5z0ue4cHwvUhmuvUBA8vmz+gM65fWnXAAU5P3vs
	5LO7MWTiDO0+ItikVBbZuD5z+rXmD4pMWHD4d8hnAnVYD8HyLFUC47zYUB81TwW851W81uhvLGb
	8fy0hp2UXuHPRkeiFyGfsBpP6NP6pxt0ALw5I5q0AJAqIXFNFXc7o9rBmc8fce2+D8U45iXtmwd
	bjywLVY/K9xrTRf47mDRRGu1eAZi58tFnYNEH+9BpfFAE1IC0Et+HNvfPcKwmCdQni+wsnV69kE
	al0RDari/K0awTJLfMxc0CjH60ExzTydqu6+SFqkf740f36eAFBwFkGLiDtzBdi4mqUfIK6E8+2
	9Wr+u234bcZiA126obzoO76163IfRZmSeedRDfFiuuxMQ5xlwzKVE3Cua
X-Received: by 2002:a05:7300:1489:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b6fd7905c1mr5388083eec.27.1769067926043;
        Wed, 21 Jan 2026 23:45:26 -0800 (PST)
X-Received: by 2002:a05:7300:1489:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b6fd7905c1mr5388071eec.27.1769067925498;
        Wed, 21 Jan 2026 23:45:25 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm24875278eec.25.2026.01.21.23.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:45:24 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH 0/2] PCI: dwc: Code clean up and formatting improvements
Date: Wed, 21 Jan 2026 23:45:17 -0800
Message-Id: <20260121-remove_cap_clean_up-v1-0-e78115e5d467@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3VcWkC/x3MQQqAIBBA0avErBNUsKirRIjZVAOloiRBePek5
 Vv8/0LCSJhgbF6ImCmRdxWibcAexu3IaK0GyWXHhRQs4uUzamuCticap+/Ahp4vHbebGpSBWoa
 IGz3/dZpL+QCjpR2iZQAAAA==
X-Change-ID: 20260121-remove_cap_clean_up-970b60cf595a
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769067924; l=1237;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=PMstPFg1QN7a4XoG9VnKG/9ifAd+dRDq/L+1XKm6iRc=;
 b=nyhpBvhNqaf9xnsUAmzmG2COrkUEmNi7pENUEklDiiz7lSmjc85aMlR7DpjlEt2akzqVKqUAa
 FcWoLbmSjbVBIR07L1gLfICrCsXmhDDued2jLqJZH6fDIn1z+pfIlo1
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: IqhKpzsOOArlx-ARtidEG_50DTpN1uZW
X-Proofpoint-GUID: IqhKpzsOOArlx-ARtidEG_50DTpN1uZW
X-Authority-Analysis: v=2.4 cv=KpdAGGWN c=1 sm=1 tr=0 ts=6971d596 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=y6s2foKJdXeFtfApewsA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MCBTYWx0ZWRfX8GIBU4tnxc8e
 CqRNpXcfR6KzPg1xqkdK7jThjNFGAE1UrDZ1KduPNH3JYnmqvLSQqV6u/7o9y929EC//BScDsLA
 FzthrKNlOHEm0U3U+dZaAxf80BwUs+QaZdUA/XDiQLRZS08AhYN2PW5jvQHaEfUoA2AxLPx8Zvv
 iA9jhK6pFYO70jctMUo4ocJhe3mv+MxY0mVckzqUpWM5/b+sjFHlNgnDM/9K80Iivff+guqyP/g
 KbAy5z019UJ62X62UTuU1+28JLNmPqWw/UUo3NP0Jnl2kv9OvndiDsvIJaExfh8A58wlfCZNHyY
 4MnnUZ8B0FXtoBuhpZEeK0gS/RMnZEONKOFycPBRBwjrTlQmFBvV1iM3eVGNTGqu+JWsavK3L5B
 TVduaFmc04j7KEgoyUICylRghzCE6pQOgcrt0koczdBpqVIgvBbi5UyTEaQxZU99Z1YKVquSQjn
 ummdE3AsOYpuDZt6Ymw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220050

This series contains two cleanup patches for the PCI DWC subsystem that
improve code readability and maintainability without any functional
changes.

The first patch addresses a naming issue where the "has_msi_ctrl" flag
name was misleading. The flag specifically indicates when a platform uses
the iMSI-RX module for MSI handling, rather than having any generic MSI
controller. Renaming it to "uses_imsi_rx" makes the code's intent much
clearer.

The second patch fixes a grammatical error and improves code formatting.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Qiang Yu (2):
      PCI: dwc: Fix grammar and formatting in dw_pcie_remove_ext_capability()
      PCI: dwc: Rename has_msi_ctrl to uses_imsi_rx for clarity

 drivers/pci/controller/dwc/pcie-designware-host.c | 16 ++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ++-
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c            |  4 ++--
 4 files changed, 13 insertions(+), 12 deletions(-)
---
base-commit: 86291f774fe8524178446cb2c792939640b4970c
change-id: 20260121-remove_cap_clean_up-970b60cf595a

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>

