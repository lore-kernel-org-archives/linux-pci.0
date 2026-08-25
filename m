Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FC3093CB
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629251; cv=none; b=d0z7z9XQrWwpTJj+SNJx5BuGDoOFFXRgnkKtOfmhzxzU8B+GQyUgMZAbgXozZq9+xG3uSVbCnk+FJJFjGzdGbX1OBj0Re4ZkTE2WEqUhE88kGbU8vXpxKUfuvTDSHOl6BXB1ij1l7f1Dqn04wLuiXdNjmMKYMSGYAx/dPUoEXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629251; c=relaxed/simple;
	bh=YgWcPqpc0Tw7AwiZ7DA7bpWlNDJxbNEfk70+YLHN3IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUa287JCHxPby3E8e88nwJTgcq4olIQ0t1FhYm7gyAlK2NKyEOWCNQpS2KDMN5ge+64kpf5guMwgviB3VHbeWvDZYYum0zrSQepAC1cVB5aJ4aorWYORAIuhPoZwXMIVpvIrFJheqD14XR3uNvuRtWN1cTEwZ7DNwRdWwTHTQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvIDGD7o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=csRjlfju; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvIDGD7o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="csRjlfju"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2RJAI500183
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UKkMnWvHtEU3AJjdFVpOEvwgEQWljpY1f7+4AWt13UQ=; b=LvIDGD7oXM6BuZ+f
	QN+FzLo47JYwr//wpWzAWeh36y4cR+eRp/3KKp9r0U1mx5+dtrsBWflKQl3nDes1
	uFwtV+nPdzPFqFuj7nmap4HgoUrrJT2qJNEMiDycpwv8LK957sbZbpYuqK4IYAvF
	XPIOrqRHEtUAT0e+hGvrVziqEwTH2mET2aKV3Ii6v6QzBjEdbpo7OZ5K5r1vJ5Vf
	vM9KW3ZPr0YJYp5zSgtPRzCzvqC93Mw6ggInH6qjlrr2/kiCxv9Eo4WYKUpHAP9i
	gGTUdeMXnp9Igj56b1P9i1Ia00hZxnuruoI5OWAR7PHWek4RUtFIw+eNQdH7xEzn
	btEGHw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8t1s1vca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:40:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so6393199a91.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 20:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787629247; x=1788234047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKkMnWvHtEU3AJjdFVpOEvwgEQWljpY1f7+4AWt13UQ=;
        b=csRjlfjukRbwVlsdM4MmqvYWmF/bwiAApMaTougBeBVvWxd+HrQq93zS5zf1w1EIT3
         AAAFtKvXyhBNxFnHiJGsHPMpvIpy2WnH6+hUe5cIDJEkqSMATpuSY5nTFbHZ4H1clbxT
         k+odr+wC2409cZBne/LINzCq6GanAROV3HVz9fzz6RH9/9Fq5P1mqjwLXY79TUEMiOwZ
         SD12dURan3N0GDC9+Mv4l179CkLuOX9WP8ZBRhkVQ41p2c2E9HJ5V9D7wylRZTdiN/1X
         lsxNm4XL5JmgaPJgciDb61dmWiLSAsNXY/XbU0m0ucS4YdyEcBEx8mFYJ8qXc2IWIX6k
         VGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787629247; x=1788234047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UKkMnWvHtEU3AJjdFVpOEvwgEQWljpY1f7+4AWt13UQ=;
        b=RlYHaLzyZHxXaRZmKQ33w7HLlM6x/jIYF47UsDvI+vFshdRCJzeouk0tAymrMjJCef
         /Bc+mv1zJ9dwAb93tDHLlTurlxYckUP6SkkbyMdkwKOCwqLmSP8ek2Izjn0xxOmq10L6
         mRz6EGIJyvA+y/0RNq+QjIdTbwYKY+cd0gxzS/60GWm1XJisPhY8YiNGW/8ELkguTbzv
         pSqH9IzEnxgWihzufecKqCINdCKzTT2OxG1C+mQcr8wENEDH33MCdg/OpOnMS4feiKKI
         w6NrMAprzYYSLIHi/sXV0OlwfQOrDSt6B5mDrmHISS/JJtMRjvT3vbhBs9RWlZvC4KRh
         zNwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCvaao1zRhpqIziJGkn6gq8GBMUu4exYMUEz7yTHY0hAz5rY+qzUR0o3zKeWVJFr7NcrJ0B6+3U0o=@vger.kernel.org
X-Gm-Message-State: AFuF++mj+EPMRrK01rZjTJ8OoSYbiif9WgQ0hS7dOdv1IIbqHXELdsTC
	/hbR5x9AtbO953JM0I/hNXEka5YLNjS3zJpp1V/mZjvG+5TFYJI6iykufIupF3ltjPN7F5feKAO
	9ohW+JDe6hCLIAFrYUiz7/HeaekUaRdk72Wgfu/ZR0gSp7D6JOSs6LFR1LRcdBv8=
X-Gm-Gg: AR+sD10ke1wuT53NlxpskcZKDS7nUNGT/8lne+x2MSBmYsXhbcpsACYykqwaWfEVfZi
	0w9ybjjr04lgm/HLvIuMKV33IZWwts7udi8BbvF+ROH66H0GVHUEd4iRt7wIqLjiuLvlq6rzXEy
	qGbBwJCONrqr2iI/Yfp3Zyiw3oj9fJ224ApOJx6HDdQVtiNN6JNTi41c+kURISmrfCiEPMY0KA/
	BAJkinrAOL2QMCSn5TYmFl6e9VEOz1saqCI+h39YSINK+VMUCzfcIWGVAVUHERJbrdNRpX5pu6H
	YBHXS2kZNvgPrLN9UMwHD8PflO9Igp7T5EhAFHUS+qQ9vs4+5yz901UG7DcPU0l7pNbyb6C63A1
	PuLEoDVkgyUkstp2ZW26FSQkOSHysLwENaBg=
X-Received: by 2002:a17:902:e552:b0:2d1:1f73:3667 with SMTP id d9443c01a7336-2d64ae3b141mr463741075ad.1.1787629246474;
        Mon, 24 Aug 2026 20:40:46 -0700 (PDT)
X-Received: by 2002:a17:902:e552:b0:2d1:1f73:3667 with SMTP id d9443c01a7336-2d64ae3b141mr463740505ad.1.1787629246082;
        Mon, 24 Aug 2026 20:40:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d36f9sm46440083eec.16.2026.08.24.20.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 20:40:45 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 09:10:23 +0530
Subject: [PATCH 2/4] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-nord-v1-2-7c02f2b8765a@oss.qualcomm.com>
References: <20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com>
In-Reply-To: <20260825-nord-v1-0-7c02f2b8765a@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787629229; l=947;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=YgWcPqpc0Tw7AwiZ7DA7bpWlNDJxbNEfk70+YLHN3IM=;
 b=FgWOWKoZqFMIeDM9s3u2DQ1/HwQCn4fnPEBelR3iZCOLdX5yJicTe3SRleJLsI5RGWTaneI8p
 vd/fr2IeVxYDi0IwjPe0J4/+FLJ/omLcj9r2e4rNZuUidLXjPqGjkz8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: C6e3SVda2KiXTS3aYUC8UDZ9gdhrZmVx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDAyOCBTYWx0ZWRfX17GkdiloLQH3
 8W7j9fIRoguukQ53jGYfPPLL7m2ka21+C4kZHnS+GfziLOXGilDl8KFvCsiwaIArHL8Gs/h2wlT
 INa+swUnzGwCO3v9CRCSY0aJ4FLC57wa16EwxGbRI3szl25KA7g1XwLDIsUyQjqhMpt0qo+Zc5n
 o3GZ8H3IOFWxfzwyil56Q3L0guS39KzaimG2V0EysTsdNblC6K6q+qJ0OLjkCI+lbon0uOD/6tz
 7amo7wOsbAvs8ZXEAAJ9J7bo5U58witHNRXWG+qC3OOPCKE2P1nkS2OOXBTsxqS1+azdPoQtbRL
 Gi+czgOgO+JiNHHHSALC2C1KRwg19QBgc26s0pUOOewmyiUQAvYZ/SLRPTEld3HCPG8tsz7T6b0
 macCprbFulSs3DtLmBvhA5tllb0XZt47fpge4QDZk/YR7gPka5kdOJG9MQsmY3U62nINEfEcWBz
 I7apHNX722DNCfVG5eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDAyOCBTYWx0ZWRfXx5uAbat/3888
 3wmAi0ZOzmkvk4ShXuN7D+uWVuq2qoDWUTBE4uAiru/CsKVSX4Zx8FZ+u1utwn3IeDDxFWYqPoX
 voQenc4IstiPa5JjzKPsw68XvGGYYio=
X-Authority-Analysis: v=2.4 cv=L7ItheT8 c=1 sm=1 tr=0 ts=6a8d0ec0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ly1VyIkaSgMpB_u5KqwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: C6e3SVda2KiXTS3aYUC8UDZ9gdhrZmVx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250028

Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
controller binding.

The Nord PCIe controller is compatible with the SA8775P PCIe
controller implementation and reuses the same binding definition.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
index 63630a814f28..b8ba2c4449b7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
@@ -20,6 +20,7 @@ properties:
       - const: qcom,pcie-sa8775p
       - items:
           - enum:
+              - qcom,nord-pcie
               - qcom,pcie-qcs8300
           - const: qcom,pcie-sa8775p
 

-- 
2.34.1

