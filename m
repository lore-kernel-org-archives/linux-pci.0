Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6C33F8C3
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017037; cv=none; b=VMdJL2ILXtLsD75TknxKRIhfKj/Z0WtapPS4/mQFqoB1LO5zcpaEe6x7pZhW0FxvFZO67FMhUJwB5LIs6b8Eq7LfIgq65k6zP17ShN3gcSmeYJoGnT8VI10NThQRU+F7ZbAKIx8LxkwMOpjQOZVs1VKBoSjtFFWUfHdY7IubeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017037; c=relaxed/simple;
	bh=ED17Tu6Boefwx031Ua9Mi1AfjIk4AgqPmRso+e1SoR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UU9DLHLQw8TkBsgkAVVPFrzG7bIEjNrDddCyVCQtxiBMAUviRkEB8/yFaO7tXel/g+Cgw3yEWPtJokF9pQmHCC9c5CdA3veUH4l3id1IZVdt3+yJYNg9EcELZvPt8hgKjH/c6EPDljRyZ08HNNIbPlFq0v/MLlKVhzixs04PZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqI/1pf1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F4bdWn9k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqI/1pf1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F4bdWn9k"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SNwE3c2263570
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 01:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=61flKZ6F2p/mWTtuVMLVmd
	xCIeA9SAxH8x2BNy1Y4qs=; b=SqI/1pf1FmVy8sv7TY0lgA85oqTRo9ZXNGXnRv
	8G9vUvA0kVSdDGgLFKHHr+6et2kWiNdj4M0olyqRrvjMkzRuWJz9BBVJB24mcOz7
	eAp3XdRRvF9AZUQwRtFL1dbD8s4UgsaAVq9hqy81DrSKtYH2uZ3dRVdz/8/yjGD9
	6ggoWHcLCrkIwMrV+FgmA1hQpaYLcxkeROFTn8VYRj+jFeDCyLOBxEdHgZ2zMjmI
	AQMUweC/lWMOVMl76JA5C1lRlW59oyNKkhwopEOC3Emg11QG4xS4pJl/30wjPm1/
	oKhfBS7OQ+Y5AVOIUn/uafagauyePKlctu/o1V6Syj6JZ65A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety51hqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 01:10:35 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304e4636205so889593eec.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780017034; x=1780621834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61flKZ6F2p/mWTtuVMLVmdxCIeA9SAxH8x2BNy1Y4qs=;
        b=F4bdWn9kfrZEqX0kucaGpKfA2kjCCk7PPxHtuJ+p+nBN816K3l05opWxiXuFn05z3J
         CynNihZyfOoxvSIDFJnrQrkE0sqD0ukyPWqOh6l6cycS4sD+Q7IiKDPFcJZzQ//eFKOW
         CKrqqk+WWMeG4oHJ/7u5cubsnX3b0rUs/gN4royaRbqALH3e9Rrl9mGrkYt42y7yuHBH
         /hzS6Il4Pc+kM6rh4x/w7gwlRlJpTRzwjWGgvpCHYXy+8QwK/9mND1R+P6+BQA/glhhW
         ho4+4jZaG8sN4ZuW6ZDtv/TvOYwzplwKdQX/b+Z6MZm9EVOh6bxrkPagU+XX08HdPIJ6
         CcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780017034; x=1780621834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61flKZ6F2p/mWTtuVMLVmdxCIeA9SAxH8x2BNy1Y4qs=;
        b=NVVrz+w4w/8L5qTldqutLXlY2p9K70w0b1tMwQRK+ApJvYWREH+WDyGDxU8kyYG8os
         cLOUKhqqgR9cvMCEvYldz87a3Yz6/crEtsLTvAcIx7UQnUqWAd5cA9vJC9QgoOOwcDmc
         hG42svDOPczuWI6fL9jTxU+7/TaUnR7MqRbwqPGUSuhOJPIW1YSocLBHXAVdCcn0cO4M
         +UGGyroTjGq+LOWWMeJ/pjYt6pwrMoRjUJx+o+EAXvp42f48mm4ml9IMygFRIUr09/jO
         vt7QukCRjrtgfJgVwlE1UX3xUhIBMH2Kk74mITl/+WtTJZqIVIv8grmRPEHribIVJzfr
         R0Nw==
X-Forwarded-Encrypted: i=1; AFNElJ91438x8PG6+l7rCmvSI08dAlo5QxMonQzD61IzowVAQbCfN+j8xl2q7YWyVoSgog5QyXBBIfBgddY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQYqcTLMzpMmxatg9Pxr0KGgs0N2ebRPWF3fIoTf0J+k9oy8t
	mPvMN9pt2f7vvvyhE0OgXzmp6yqeJ+kE0wJwpVFVWPf1XnwexqcE6f3fkaSvX9+BgtaebFvQaEw
	HgYgQNDHtezJZ+ef5m3/qLSGzNTnAg7NMFxVZJHCivQGZj852LGR2VsN98UqSBcqvSacqJ3g=
X-Gm-Gg: Acq92OESK1Mz2YASkaNqMI5wi8/flFAbn0bfr5CPTFD3yBlC83tsHRTkSRmp0GJoZuU
	X5w5IbJI2/nr9HOc1CcFucwgbcHXmJMLoqJcmSHmcN+MsS1jWyTh7bM+7marIYHk5jF3G7dKp5F
	7KJ6VHiWliXmAQ9VaAzTiQ2arn57+Nyy7u2zjn6X9iSUwtpJcwf8L6ytbhgmlEb7HYu4nJjkxI5
	NLMvJCcvc38osg6hnNzJd3RybmEnqm7PF5Plhqclz9DRa0ZtsbAa8OdlGlBemOomBxCzE1nqZPb
	Zs4M3S4ek9sw6qPOInTO6NzjjloKLh5m3qr5G54kLlrVxpv2uY7B7hehDOzvwA9MLQGT37m+xAS
	NoABnAC/RebQhEzQCA3/vPNC5JdaemrxwiWRstgEgR/RGwanCfinK1ZbvJP+k8KzDoZnOBQ==
X-Received: by 2002:a05:7301:4b18:b0:304:eaa8:11ea with SMTP id 5a478bee46e88-304eb2add39mr428449eec.34.1780017034459;
        Thu, 28 May 2026 18:10:34 -0700 (PDT)
X-Received: by 2002:a05:7301:4b18:b0:304:eaa8:11ea with SMTP id 5a478bee46e88-304eb2add39mr428427eec.34.1780017033742;
        Thu, 28 May 2026 18:10:33 -0700 (PDT)
Received: from [169.254.0.3] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a114dsm173785eec.24.2026.05.28.18.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:10:33 -0700 (PDT)
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
Date: Fri, 29 May 2026 01:10:07 +0000
Message-Id: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG/nGGoC/02OQQ6CMBBFr0K6tmRaoQor72FY1DrIGKHQAmoId
 7egRjeT/J+X/2ZiHh2hZ3k0MYcjebJNCHITMVPp5oKcziEzCVJBCopX+k68NYS8VCLZpkYnEgw
 LfOuwpMe6dSze2Q+nK5p+GfgQDrshSPofVpHvrXuuH4xiab+y/Z9sFBw4mExABqrcYXqw3sfdo
 G/G1nUcDivmeX4Bi0AmstAAAAA=
X-Change-ID: 20260506-hawi-pcie-f61435ca420c
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Leung <matthew.leung@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780017033; l=2408;
 i=matthew.leung@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=ED17Tu6Boefwx031Ua9Mi1AfjIk4AgqPmRso+e1SoR4=;
 b=qX9j/g+3hKFXSNVcgPVdVlt+uHxKf7x0HKJdOyPwo+StTrtj2hC6N9/CdAVEvMl6xvrR3uMAg
 7kBCUg2XbbKAamVDziGBv7tdn7XjHXiDObZYknx/PpDf/ZMdbrmTl3y
X-Developer-Key: i=matthew.leung@oss.qualcomm.com; a=ed25519;
 pk=aT25ggJo5PMHLN9N+TsZ3s/BVU++kEYuiFebPWe21+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAwOCBTYWx0ZWRfX4JzvqDP00fFj
 kvyn/DCPuTxiApX9YuEqsixIXGdSJeaDcvFidn14Z/iW/Ornt5F74JgrsKuGIkgy8cE3j+tIA9z
 LaCVOc72CMtBbaq7ueEfRixLn8DzKj90fyVVw72Vh6A46oLh5c/eOrMD44x+nEUXE37saoArHTE
 VpW9Mz6TMR/1u4orjerlOJ6V+RLeZOQRJo+d77gfs/KyPQpjECHX5IN3zgaK60uxMpq50RUsbq1
 rv9f3vM5xDKzpBbuPo7cjSXQ7xywKJkf8IPFyMm+aatTGqHXvQwaKrSrrJ2UjqG3ABk+Fq5S2KG
 xwNBZYsvGDYGMfmY6MuuwShqex1HTsGfrIF7ueGd8AlMLvwg/Z+q6+q0RkLuvrsygLXCfOcphGS
 vbZ8TFpgOg7Bi17cqNESVC98znpxx/s1wQGboeEQug/Jnf588qmv7jCI7BJtdLjqqXIDMaWeK07
 HW1P5PmJy8ybvn6+UTA==
X-Proofpoint-GUID: lHzJkqU6u1C1F369mpc_WbRTe6oVBkLB
X-Authority-Analysis: v=2.4 cv=WaM8rUhX c=1 sm=1 tr=0 ts=6a18e78b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=7C53p0e5iIXEOqMNOosA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: lHzJkqU6u1C1F369mpc_WbRTe6oVBkLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290008

This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
platform features two PCIe controllers: one capable of Gen3 x2 operation
and one capable of Gen4 x1 operation. The first patch adds the device
tree bindings documentation for the Hawi PCIe controller, and the second
patch adds driver support by enabling the Hawi compatible string in the
existing qcom PCIe driver.

This series depends on the following series queued on linux-next:
- [PATCH v3 0/7] clk: qcom: Add initial clock controllers for the
  upcoming Hawi SoC (Change-ID: 20260316-clk-hawi-1ad4cad36d6a:v3)
- [PATCH v4 0/2] interconnect: qcom: Add support for upcoming Hawi SoC
  (Change-ID: 20260311-icc-hawi-d6dc165f8935:v4)

These provide the necessary headers for running dt_binding_check.

This series was rebased onto linux-next and applies cleanly without
additional prerequisites.

Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
---
Changes in v2:
- Rebased onto a newer linux-next snapshot
- Previously required dependency series are now queued on linux-next
- Added minItems constraint for clocks
- Moved description comments for clock-names, reg-names, and reset-names
  into 'description' entries in the devicetree bindings.
- Removed maxItems constraint for clocks, regs, resets for the fixed
  size 'items' list
- Link to v1: https://patch.msgid.link/20260508-hawi-pcie-v1-0-0c910906f7e5@oss.qualcomm.com

To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Matthew Leung (2):
      dt-bindings: PCI: qcom: Document the Hawi PCIe Controller
      PCI: qcom: Add support for Hawi

 .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 204 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 2 files changed, 205 insertions(+)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260506-hawi-pcie-f61435ca420c

Best regards,
--  
Matthew Leung <matthew.leung@oss.qualcomm.com>

