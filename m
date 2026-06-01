Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD8397B17
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307233; cv=none; b=Ly+E5kaHte/SgSrwLea9VGkefBzXwmqW5A5elmuc4D3Ww/4qa+r/DDRem05ijoY3X0TNWrH322NJtuY09tluY+rXdJZRo9/Tf2x24c86PAJMlKIcVYcZ6Y3yMYrjG3A+gv7WRsUnyeJhgHfRdVeHBTTLk2yDzK4JcTDPMgfPZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307233; c=relaxed/simple;
	bh=i6kjUXsWMMvGZpVkGZgoZuYG86BurQaFVacwcpsLGpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8WNLZTfiFQdEHedLOGyxfyw8o01Qz8+wNUlemXtSqcnYAsCKeVowH5KaCGSi2IKWkAh/FshClSErfuih5Tws1guTFkEGN2bRLab5+gk5F6w05yeWeTEgGKx+uMHEvay2phqfxyYnUfbhLgYlbUKK7eEYYoe230AI6avKZ5RxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OSXPRiVh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tr0zOkBJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OSXPRiVh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tr0zOkBJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65180mJh717642
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jBqAtuuc8EnhubMic9V4p6HI7fal3LjjEneRXtxWqdw=; b=OSXPRiVhNRnIuaFt
	/jcJLl1uTz1vgCteCW2TVILz4LUaqeb78F/8e1kA+LFt9iOriTBRbvnVPMo7S3WD
	EucL4DJ+Q3UeFkKW0OBUIlJIPZ9WIsiCDRhMeuSmLuBTfj93IxkuO5xC2EBPqqKw
	4QSzBa/wUwoL6osegGrgwbeBuQX3vIJKE41C2qhQ6P1wrP2WABBcCS5A6adZWT+4
	In5J08VCcgwDxJYQdNeccZSkdpg+KLjbbKKsR44xK7KvVylkcefk5x4al/5kYyWc
	ZyGe3+7dCSdQG/rgmyUah/PYPc5DUgBoTWmwa+Mg9EvknrnCQ+Qx4dz0ycQiCicW
	9B396w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr98et0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:47:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5175aa1a54bso9050401cf.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307220; x=1780912020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBqAtuuc8EnhubMic9V4p6HI7fal3LjjEneRXtxWqdw=;
        b=Tr0zOkBJeHphvTytgoiYr5qnL3wcr3YRmqPPucMbotR1xxDuN71KHnMxAG4bchNzpt
         NGhIGdR1tsGlqkxghjKoSZhoUP3PpxhHgQQgr/KL2t0PUb5Yn8aQ+zySVhBr/fMOMxbY
         iLHmnv5e1TMaoYVQrmn+UMI+vgEQ9PmIBRi5iWElHq6E5II4bKzyBsK5nQA1fyvSO18H
         loVeArV5E8r++o2XoENHiyMt8iAMJ0N1zYP4cIx/Z4HBsYRX14gHzN1SMzld3MzTGb4Z
         5z2HOrVCPAq1c3t2y/R38FstKF7p2ZY+jO6PMruz8OQ75fka+figlCzeNcHulJ/mKWb/
         A6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307220; x=1780912020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBqAtuuc8EnhubMic9V4p6HI7fal3LjjEneRXtxWqdw=;
        b=PEt1qPumUbUB7zwwWgUwqm5QnTDWUHJK1y//ItVno5GgvXkx3SD3h7ayswGJusOBTy
         OjlpNO4OZQ1I4Iixm5IgrzdhXacWz9pVPkZMb6FRN+U2P/L4Spuv1KEZjrGuI20NbOX/
         rIZKnPFCvWEcPHIti2n2+Fqz63S5hcuVKkwx7wUSKx7USQfeBqDvZap1tJHz+mG3VVxn
         zj59uYD9uYTqiX939wtRr3fkGbvrOJusfdHAEJUfq54K4sDxMQ6nlITOU1iAaB2tmeys
         EH5cC6Ru2TUbI8/A5KUiLDe+WyzTFYvSJMbjBJxI7wcnTN48MdqwfU7XAX6g0EWlN/H7
         MV2g==
X-Forwarded-Encrypted: i=1; AFNElJ/gIPbKc4Wu+YrrzP0vZ76Vt/rTH58LvxbzDmL7bsTx7ou8ISv+Y9tUpB/vR6saFP3py/iwxqyzzqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDZcpjxJ97DJu9VWsEN++zwepOwBNIojSPWTYHwcHSxWbNL1z
	NKE+Iu0NQx+opquDxYHXe4Wp75KDlyqdQq44063VW1XJz92jg0wF17kScW4r417KfW14S218pe1
	Ltcp8N3OWFJ7q8iBHkcPTVWiTEk4Lg4yW4NF3fNOaIkDSJ3jxUFMWtvN15JoMFL4=
X-Gm-Gg: Acq92OEUS96tjmlVDauJJjRaTqYKfPaF6ctHOfRTbfJoCRfjHKiP2YYS9TBr2EVsO8T
	oawQiNjUUh6/HoVHLdN1j3p9JQU/bLW6npzsRcJMJsSWBIMx2OzM/NytyssMNi2rT/H9OGWGlgj
	ElPnSBbtZt0ja5DvVSuKbTX2e2uQOLHzNGLpW9FlSgRdxGcioLNeyHN9eU3R+Zi5ewVTXsOgD9/
	Yme3+0uMLCdSU0NcGJ/KrAIBiKtRakHqF3E5SW01kwIcupvksy5rzwH5d0i/io1cBQzZcBp9Cut
	ivd/a/YsH9gOuwYsXMzU4+tROVyfbPWicbPi+WfOSJtsQPVvm7QkAis7/W5r8JPAIjt6t4Cy51M
	mMM26OaP4ymOkShxu/vltHBoOCWsUVlvWh4Ma6OOcUwm9TlDLQTPXGh9sVQ+xu5Qw9ikuC4/KYR
	ULhDd8LRRdv9jfwReFNSs1ByLyVgJ9Jt6oiFMJruLSnnZwKA==
X-Received: by 2002:a05:622a:a887:b0:517:61d5:2f85 with SMTP id d75a77b69052e-51761d53795mr1967871cf.33.1780307220286;
        Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
X-Received: by 2002:a05:622a:a887:b0:517:61d5:2f85 with SMTP id d75a77b69052e-51761d53795mr1967561cf.33.1780307219912;
        Mon, 01 Jun 2026 02:46:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:46:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:51 +0300
Subject: [PATCH 3/7] regulator: dt-bindings: qcom,qca6390-pmu: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-3-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=i6kjUXsWMMvGZpVkGZgoZuYG86BurQaFVacwcpsLGpY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUKv+ohTcsEMq/gMqjLvJIpmvW0bhyzz1rra
 Zau+IHCLCKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1bnUB/wLeiJktyGGPY4RKsuvLJcAoQGkQZ2y6YnS6kBfDk+PqAEP4E9tvABS87UPQNzBkz7dswi
 1QqhKybyLK+mnYwrtDDXhsvf2VoRJmi5aB++NIpfdGVEHiXdMxUF5AS1W+rDHHufWgpaGnu7tjC
 2z6jdD19j21jrbDJXNugJ0vqMTREb4DJdU4F6XwHn+fZug/DND9RTLR3Rwdp+Y/b4odBDze3n9z
 N0qozm1xPRUodqPHVrA57id/TE3sI4sVSYd+L+fCoW+Mae04ma3v7GSg9jH4uQviowH1dAZjaaL
 zY+PMnTjXfiKTspjputgXGs/F9wRj0j5XIQxm5Af+X8X8qq3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1d5514 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=NEHNw5bNxon9FmZXvbQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: FpygUtucjVibFFuckLlI9e7fMZR2U6EN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX0cRMsKUabsri
 ZnG2g6M1eT1xWvkO6HNZwKkA/6dPUevmvT03YzmxpemI5FpXIoHV8MRcWUscKEbVWpous2JRRMO
 TshWB3KEiCD2k6owHPH/fXnmHO/H47RkLig62GDUjC6eb0Bg/PkUMqs0hzudtXe69ewIon6hSrr
 Kj48Z80Ad710vEBVjUq7NwiXCxmDoiLnzk87REs3XDoaDtuNd2DABwdf2vuvqaEtTx/l4z3K5zq
 o5J9NSn6YdaNhMnwL+OaQvNxEeBNB5fIrsqbwyChrCjAaAuCP8I7yp8qKZWP32oZ1e64B119rfJ
 KlLfNCGwfcxcVk3wIbQ29XJt+lJZ8Y2JN8a7/9yDkntXqEpyQLNu7235E9lUY74K7CxEl+6561h
 vzCn/v1oXbq7QtX0+JwQcaQQ/+y3263LfjeWhd+hhzAelN9H+HcbD99k2UMHRZhZBA2+EpfTDN9
 WMPbwJ/vuoRtTkMpxXA==
X-Proofpoint-ORIG-GUID: FpygUtucjVibFFuckLlI9e7fMZR2U6EN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 105174df7df2..3d3c6fa7ecbc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -21,6 +21,10 @@ properties:
           - enum:
               - qcom,wcn6755-pmu
           - const: qcom,wcn6750-pmu
+      - items:
+          - enum:
+              - qcom,wcn6851-pmu
+          - const: qcom,wcn6855-pmu
 
       - enum:
           - qcom,qca6390-pmu

-- 
2.47.3

