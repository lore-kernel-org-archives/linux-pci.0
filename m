Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBF3A7F47
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 04:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731992; cv=none; b=W+dzv6L5BTywb+yF5CG9BeWRRgz7FWzQHtzbJt26ITLgG0xKJJKF2og0Jpl2YIXId9t6kAXczsOT6aEZnPa1Q1qmYOoLtObWea5ohp6WBjWw5QpKuYAHwFqB313GdEEKGmrh0Q1+0tAXBs8rSSEZT5k/AVsSWYBoWgWC5Gl2wIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731992; c=relaxed/simple;
	bh=UCvF5W4Php1eq6KLqSfeXsUXTv1lLN3d9cYyXqBJvHI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mgrhOXJBK6j5febbg5fuB8q3bpCXrqg0+rMXsmokryxLoqlOv/il/mL9HYtU0HkuUQ+mJJjxqlxuLHbMsAYmVFpK0VP1bXU7NvEIM5YWzgCXfIsVPbYLDXw3YBRKFUMg3zHnm33EHF7N2yyOIlvV92A3I24GUqhdd1izH7GadGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fsn3KOPa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4lSQUst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fsn3KOPa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4lSQUst"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E0uWQP3474744
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 04:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Se+XvDLdHFlrKh024A77jn
	O6bIXBjZkbQxOwwc6Wg78=; b=Fsn3KOPayXzjgeP8UurUtOWS7+CkNmB0hf9vjE
	whrOAVvaFGcU9p1kZY6Jy/9uoWIOoM2kBGC47rrW/cZbi4vtJoVbiX39DdVCH8+p
	IA3vOE19xj+EWS8aQpu9YE5cB/hhqdK+PbwBnvgoxlpopj9MckUyhQ11aLpKoF30
	05rbAVj2fmIeezhDB33UPcwfEbQNeg1gRIBFigFAwvc0Z2iCxlkdfroujZB0uluh
	kLQlLuVztU52D8wGIZlxNvwE3zIY0JkCbINo4X96y89hQ8Qv4ik0oq7ofR0JaIgV
	yy+iug8QgM/lvGta/8+r1bL6vftjlT7bKezzgZPO/3kuw6+Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p41bxks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 04:13:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso4778211b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778731989; x=1779336789; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Se+XvDLdHFlrKh024A77jnO6bIXBjZkbQxOwwc6Wg78=;
        b=A4lSQUstu862v6TCwMyQQdb3uLh1W2GrU4HrEe9cqxGsJR6xrYBsGejxM8QaQF8NWv
         TW0Ig1D90ghSItsfgDPpG5dkWn20K4Bq60PteLsSWtpk4pdjHBlcBbCVcU6KuEnagZb/
         qNTePLKYgjUpiqb8JPlzkknKVkkNLoLBhISM8ecCqsrVGU6iXJerCb1Rl7mLIacoj19J
         LgzmW5PW/yCHM+FfGXU1YkS5zL8jDV6oNSFS1n/wYO6MpJ2hL+RAGp9qNqr0el9Sn0D9
         K2X6AlgCLr2sHCxGZvP7JjVi2aYz29SeTURfwQRi/mYfzvgVktL1Cgh21D6F1UvEL7Y7
         1E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731989; x=1779336789;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se+XvDLdHFlrKh024A77jnO6bIXBjZkbQxOwwc6Wg78=;
        b=NoG/fAncWf7QzaUWRVu3QVnNaUyh79DVhDY7LvZy6P4qepqoNApGzIIWZOlS5rNg0D
         +AHdXt5+GIZGByqkO/G31SOjGQfbawoQEv0wU7oGzcvjLqtQjwE6p5F7CI8yYfdRwQOs
         qc56ZXSQTbYFhgaCBA3taZ7zgZZnLZKZrII4wd9gfMLMSie3AnCFhAXRXZDm+ETqGDf3
         iCD7AbQ81sFJzpAgXaq5XJnVz8DCZkH8rF4U/R7EVnckAsIzD8XA/JGWiP09RqcUpjPo
         yNYjRqU/FnkyWLJHGiw1P1eHzO9qKtdgJes9tMeeKEi6ZIB1t46RSKcHEkKrToo81eec
         kEAw==
X-Forwarded-Encrypted: i=1; AFNElJ8lkNrs8naw4M38ISjjU1mhhPEokASFU6J3UA3eB6chnQmp1fTJ22pCz4ty7NPlkhAio0fMvH3xECU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQyN4IgKWS1j0NCfSKVhCPVHBf3SeRqJ30kDONCPyCUE9k8He
	+O8BoKtiB/up/YvawZ0Absxpb3kysMQ7H4LTqYWc660bNnFGOtLTysqT48sSpKrvrnukMHZa0st
	Th+qERdDvl6tyzsI4xeG9o5E+rqXDAKypFzFXI0D/XlzRdIRPVVq9vL9QUPyVeFA=
X-Gm-Gg: Acq92OHAXGOTTABUY5y9YZ/4huxIXfmCTeAzw+1yyZInywvZsRUHDC8eg27qzO5j0VM
	WaN/4YptGNdMJVTIuQOfATU1C3hADVcfeQv7lD1B72YZEX5yvIAGil7QtxL9iV1YDDR83u9iayT
	gwCugZrW4mjHsuzcYsH5QyW1xxWbCHCje7+3Pytl2lU6DBqFQmxobItQFSJyR8J0iHJEhRgyY8/
	L2tb9Qe3QyU+OQ7gpdM9qhb2sbdGdKFe1eCJwRq483dxm55szoP3+zAkS4UNBcs85feH1syqemz
	y98hmvWn668GO4o6Wg1ft6QUG/IOO3cIqMyQYByQWvfP+7Qb+qZOZSx2fUjV7mD7mRxrehxvJi7
	PyfmHCLUMlgBWTUD0zPJY4dSGUp5mHiRTMRrBYaUAXfTzCVIfyDyEYkH3svG8b+V9MZ/AEWzqOW
	1dVrLbc+UoB9SolQk3f5K2QLhDtQbpFDcIA0VRBb6X1Y94e4lzKjFDdvrwtdY1iw==
X-Received: by 2002:a05:6a00:4004:b0:82f:70a7:4a25 with SMTP id d2e1a72fcca58-83f042caa00mr5624651b3a.35.1778731989380;
        Wed, 13 May 2026 21:13:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:4004:b0:82f:70a7:4a25 with SMTP id d2e1a72fcca58-83f042caa00mr5624617b3a.35.1778731988787;
        Wed, 13 May 2026 21:13:08 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5be71sm1075432b3a.39.2026.05.13.21.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 21:13:08 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH 0/2] Enable PCIe controllers present in Qualcomm ipq5210
Date: Thu, 14 May 2026 09:43:00 +0530
Message-Id: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxLBWoC/1WOSw7CMAxEr1JlTSQ7pmnTqyAWieOAF0BpCwIh7
 k4FiM/yjWae5mZGGVRG01U3M8hZRz3sZ8BFZXgb9xuxmmc2DpyHGpe2Z7XaH2uHYEPT+MYljtk
 7My/6QYpenrbV+sWDHE+zdHqFX2dX/Rn77dVSKxwSch0DdGc0vxd+6sr8OQAxARWKJC29JymOY
 vmw2+nUVRLa7JCxgQSYsxTyvoCjlAoXnwhrCCW2ZNb3+wPk1NWtCwEAAA==
X-Change-ID: 20260514-pci-ipq5210-977672bcad62
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a054bd6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wNaPFhMNx_1Hpoq_LpsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzOCBTYWx0ZWRfXx8N0IySLkVH+
 h7QqScunel6su9nNGqUwWe5Tj9HyxTmu/ZzKLwyQPjUq0mT/XnxOY0zyk0ReAdLmNv/hhMI712L
 MimtTLagieVwyxjEeIECTzsTwTcJlA4AOGtJR3lWmJd7di1eBlBumSJjnsCIuire/yQOlbxJ76r
 ypmr1tMqI9nRkef0H+47725LibGC2fJcDj7xzooJSf/QVoKnW1WV2IFboET7wRjmAfw3M0Kmwcw
 ruzqH6NRnaImu2jCkr9jtLEHkPvTNgsM67MqsatMLS04ZUhuxRcgnoNVKHONHRtnM/pU8GgaS2N
 2x5LkpE4PEvBPR2/N2slksWMBxtrYPHY7JwIH04WnsgKQ6ND8wVf81FEAsf8p3YXGGAA0xUOl1v
 JpH4ZP7vR9YU9GKQBKqHfFdTdA7WZ6dKVto7uaNaX7GPeElZ1KQNUsFNSdLCu/5YdQvZdgOrYXI
 8iVxatn8YWHgOETTryQ==
X-Proofpoint-GUID: 1dhE8vRhhu5LCCa46zwpWzBppNcqI48u
X-Proofpoint-ORIG-GUID: 1dhE8vRhhu5LCCa46zwpWzBppNcqI48u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140038

Update the relevant bindings and DT files to enable support
for the PCIe phy and controller.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Varadarajan Narayanan (2):
      dt-bindings: PCI: qcom,pcie-ipq9574: Document the ipq5210 pcie controller
      arm64: dts: qcom: ipq5210: Enable PCIe support

 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml |   1 +
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts        |  43 ++++
 arch/arm64/boot/dts/qcom/ipq5210.dtsi              | 261 ++++++++++++++++++++-
 3 files changed, 303 insertions(+), 2 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260514-pci-ipq5210-977672bcad62
prerequisite-change-id: 20260514-pci-phy-38ec9b1c5a90:v1
prerequisite-patch-id: aea0d856b804b879fd5f24ea02f809b4dec84a30
prerequisite-patch-id: 26fb9a62b5ba0fc6275c0b081c7a16348d5a4fd1
prerequisite-change-id: 20260514-icc-ipq5210-0ab03f3a3e83:v1
prerequisite-patch-id: 0b6145b6635b18fe79fbbff5815041b43778c5ed
prerequisite-patch-id: 924c6ff7baf4283ac7991ee94c803a00fc5cece4
prerequisite-patch-id: c2fe1800fe769dccd37f94c19860a07f979e3c4c

Best regards,
-- 
Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

