Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA628641E
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820044; cv=none; b=JSwmoGuHbHkj/CI2vhFuBfOFmuszQmWdVv0SmN96S1HeVMTaiW387oJDhZsz2OlcF4WscYBoTQGmqTHztIET5CEoWO+xsTqpSH8ssMifO6a33UvY3Q4tX1fOiuP2kSRBPzaAkQrGqPafFatXT2hLmP1NIGxuboVRxS3KLVU88mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820044; c=relaxed/simple;
	bh=wtJ5sds89h9vunDyHdGULTK0X3CA9KCgDtWoMhjzzB4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TPhGKo0Jqbk4ACT9ACpcY/4S3VOjmYmLBpoNfbIDYiwBqTZLXWlrpthq8QYltY7KQWRvf9ppfoAZ2CT3XBMVSBWuYKSf/jKwqvuE36ryYx8nx+b3cJy8V26l8m1Sl4I/YIgdB+blV9uWihe5Jrj46nbRY094arF4ptZEXOiZKQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jl1UgIja; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=anbhQNWb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jl1UgIja";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="anbhQNWb"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ILs3Mh2518862
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2jHq0CHr9j/tqTX87kkQ/2
	iC5qIF9+D+JK9fwz4ysEA=; b=jl1UgIjaKBvj18YaJLBfiCHYUAUrx1kXnoBqo1
	miS5/FxFekIPosUY1OVeWG2NZdJop7+6bXMPYjThY66M6IH63wQ059OSom4FrK2f
	iSEoYY6Fro1jCgwTPfKktrUJXvjrPXfvKo8Mi8sSfSeBOVbobm+Q1VERZeFsxuiS
	GTVEEk9EmKgx4TOkSi0zlIQpoW8FWDdM2WQhtDabFuV+Wz0UUkjfLJkPpqyuEEhZ
	ZBzrekO5kpsT+3GsQOeEsKzpZnhe32hQezCD9d9LDP7iFvO8F4dyJUKYglMk1knP
	UNaZcJExHBUHAp7kBAPUZmtbAqT144kV4ZybuoFP8nU1I15A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm269ga4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 22:00:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bfe262ef0so583329eec.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 15:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781820041; x=1782424841; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jHq0CHr9j/tqTX87kkQ/2iC5qIF9+D+JK9fwz4ysEA=;
        b=anbhQNWb0qhwRUaO4tmnNBTXrhaa2vLA9ZK020Yqq2JoMPKMf+vIu2hXPugChvMNQI
         Ci36kLvl0tka2oqUTKHJuBdCfkrRtqsDdsYzyPEgQxgInJXXgbTxPhv8k+cxv1zbV+68
         B9ohv6VQJvvi7bHePbxBGBo+kLaFaz9ttG6qQK0oBN4VKDorTq9TCcn16e2yveqvZJ88
         9o8F6LtpiMnhxYkjesWVPDBOiooB3x6U4yJMYanDtuqORqVw47qFHv1uBiaSFxu7JmM1
         ANo/K0FdnLX6JPds9YQ4tOiatR+eQmzwPlQt4NAb+TtKpxYsJzkSVopj87ryKon5ZA9i
         zPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781820041; x=1782424841;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jHq0CHr9j/tqTX87kkQ/2iC5qIF9+D+JK9fwz4ysEA=;
        b=iPrUpxcr4pPpHdXU+v2s8jsE//+7aCvmmk5IewUNlWXNmCcmCKTdGrw9ZDnQnolakW
         Jb+vKjZs1PYRhhWrDVGJki9CW+XXe6IEittdlSsJqW8Xy1I9Zh98BHtbkTT3Yj/DiD0/
         +Drkk22C83EggQIx39cegLYw4lSDqiwtu7Qac6sghjBwZxzVlQejvO1aO+6t0Kq/lVJt
         YWSgVlyXIDPN17OIP7UL6eoabDL85LoAKs2dLWTv6q7AAwXQvdg1LUIBElQjqczQRyn+
         qw7XEsRJVEOvhzsQFRCJXf1pWnu0hIS1Hdh1cCAfUQTI/G2KryUWVFFIeGlKZ+3SfMXF
         tf4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8i1pWJEepbdWzzkDFxMtvajBVa0gLDjIUlojzwaXjmUjCX+/TEHdboDh+kW/vjYLTpk5ortfDoaU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyapo8OnSH2gfQPARclWkxNHD3eOvM5bK0ni8sszSLNk9zmjdj9
	EW/KBtuwA7+I2YV7LIfo4GU+pkzYiTNfMJyqBUdrEsOAkOmx6TnWUHvnemuZ9vbT8Z2fl0ejwDB
	PU13CTZPDMRarroTOF9QakcDeFfJ9gYghT/HbkTPvFQb4o/FGL4fr8UsXgX1HZ94=
X-Gm-Gg: AfdE7cknRe61lSyOvHEPLdHJIT227cJVBGnhzcMLyE+L3f6Jf4AQVXkCXiVBQ4uee8P
	qk3wQYeAt/iDV63sqt2hHpjHD/l2voOLuS4x2OmEfX28kdjWfDawXjFh4AF44/9wwmewleVdsXi
	KE2qxUgJA8uf2tz0EATV6KNzzqUfn7wRSmZPu6Ft3dggUnM9cHKjHccdBrRLcV0qYMWOf/PQaMJ
	3LNkdDC0hXafl81+kmUz3T/0zGQTcNZeeJ+H89FSKeGS7zm0FIuEjs//CfrFsm4j5A/+oJOdrjX
	0bL8spW0dHe3/YhnCt6g+ju3E8b3l7YHDE0BkBcOkVHlPd8Fgkl/dBNWcWzw1Uvhd5JiW7JqtyX
	LzEPTUIo3ucy5h5JBnLgBGKI/ghE1dpjQtUHTJ1R1/GUdTY/k
X-Received: by 2002:a05:7300:6d23:b0:304:bd90:b88f with SMTP id 5a478bee46e88-30c0798b7ddmr712903eec.9.1781820040042;
        Thu, 18 Jun 2026 15:00:40 -0700 (PDT)
X-Received: by 2002:a05:7300:6d23:b0:304:bd90:b88f with SMTP id 5a478bee46e88-30c0798b7ddmr712888eec.9.1781820039527;
        Thu, 18 Jun 2026 15:00:39 -0700 (PDT)
Received: from [169.254.0.3] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c0670a1b4sm628436eec.8.2026.06.18.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 15:00:39 -0700 (PDT)
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
Subject: [PATCH v3 0/2] PCI: qcom: Add PCIe support for upcoming Hawi SoC
Date: Thu, 18 Jun 2026 22:00:31 +0000
Message-Id: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH9qNGoC/23OQQ6CMBAF0KuQri0ZChRw5T2MCxwGqREKLaCGc
 HcLamThpsmf/LzfiVkyiizbexMzNCqrdONCuPMYVnlzIa4Kl5kAISEGyav8rniLingpgyiMMY8
 EIHP91lCpHqt1PL2zHc5Xwn4BPg1D3eBG+l+tUrbX5rn+YAyW63cs3YyNAQcOmAWQgSwTig/aW
 r8b8hvquvbdwxZsFBtAZFtAOKCgNEGJKELAP8A8zy+Nq/WpEQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781820038; l=2115;
 i=matthew.leung@oss.qualcomm.com; s=20260428; h=from:subject:message-id;
 bh=wtJ5sds89h9vunDyHdGULTK0X3CA9KCgDtWoMhjzzB4=;
 b=THQMROGvn3zO2lI+WjghsHrIg0PhfJx1T5KYyRt2m+AUXA7gB8pFKhoEM5HItpxlWzOE6du3D
 3rnzBbt1VDoAWECjgxEUL72uYA6PmvrascK1HxGS0yXK5DddzjVLq8H
X-Developer-Key: i=matthew.leung@oss.qualcomm.com; a=ed25519;
 pk=aT25ggJo5PMHLN9N+TsZ3s/BVU++kEYuiFebPWe21+o=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX+MsNPoGfXFi5
 gocbMXoMzwW6LRTV9DoFKuHjCSAU0ritRCbCW+Q5zX496b7vHSUp8hGJI2QWsI4Ctjp1mqCLMp4
 kC/FgSDzWd+romOArdDpBKqPaDbekno=
X-Proofpoint-ORIG-GUID: 7EKO3hPyy1qANbyAhzFoCUB5_rVi6DPC
X-Authority-Analysis: v=2.4 cv=dL2WXuZb c=1 sm=1 tr=0 ts=6a346a8a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=yFGAn9Q8HXAzXJEDlGEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 7EKO3hPyy1qANbyAhzFoCUB5_rVi6DPC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDIwMCBTYWx0ZWRfX6flpnT+tiHTU
 UIsE/+3U6G0qVG8tXlwB6v5h94pi0Ytbu4i9anMb1g/KxTS6fHu6q9rdoWJJ1j2Hk0HDjCdtU87
 gedAKcYkaGzrXDBb52cuDXGlv13y0Rnpz4qeRw2L8+4fzQmf3moGu7YsbHJTFXdPzzguA0SBQZD
 BpRso0KquX1tzOZNTG1/7WZbBNCXFtrkE1LPiCMwNsrO4WmioqZ6qhhh6whUavp2jBii+OKeMMN
 l+d3h+n6w8fHSDd8/NFOBO39MmdF2i6uuIIv2ROmXKFE6klVRfv0kZZOYfkTLzmAnX9h/tZGfCD
 AJEbEDgQ5rVx9NXwvr1mZV7mVTaJDj9lvmY0msY9CNcX1Gdfxl+OwlylJ2R3jHZ++Y1I1iPqy9X
 RbCpS/qhlpjZZLsbJQM3Tt7IbalkUSucTccSY6nWnoNBBE5IkL+K34lmNDKoxP/q0d4YKHuc+ol
 l9jJC1zVxn2zmAbFmgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180200

This series adds PCIe support for the Qualcomm Hawi SoC. The Hawi
platform features two PCIe controllers: one capable of Gen3 x2 operation
and one capable of Gen4 x1 operation. The first patch adds the device
tree bindings documentation for the Hawi PCIe controller, and the second
patch adds driver support by enabling the Hawi compatible string in the
existing qcom PCIe driver.

Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
---
Changes in v3:
- Updated binding example to use ephemeral values, removing cross-tree
  dependencies
- Link to v2: https://patch.msgid.link/20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com

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

 .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 202 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c             |   1 +
 2 files changed, 203 insertions(+)
---
base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
change-id: 20260506-hawi-pcie-f61435ca420c

Best regards,
--  
Matthew Leung <matthew.leung@oss.qualcomm.com>

