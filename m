Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8C3BBFD4
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167235; cv=none; b=Xhm+bJZcT/i5xYsOJHEYZQpbIcGjYNBLJOVDHBBufAK04cDZxmpa0gMyO6pX7H56LubFfMN4e0d+awzeGJiq6qF2GqQt/jp9F4veTBwG2g2lAXr3AEI91xLgOptS3wzzCKZRco+RkYB9DikmtKhNZtuqswUcnc7kzzfbY3DhcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167235; c=relaxed/simple;
	bh=43kb05RaUpjRitjlYRocMlxAa/dQVEJYd5sjO46qM7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tn+wSZxrxaFPHMR2Afx4JJSeppWlrDZRiOd5jsq+BbghPmgjccffUAxkUGcUbqw4tC4uPn/FT0q78RT3Y70KuCLPYDBukNfu9q2HXup+cs2dB3frlKFKGTIiehDBrEydoi0P6nPORBH/yzISCJBsAPdOgLMlbu6emLocXRAsVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOytrHkc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=klJfENhi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOytrHkc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="klJfENhi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmAiQ3823666
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=; b=kOytrHkceeeRRyIP
	M6KMNuNHbpM/yEMt5GtmzW17+NOWCFCQg95Q9ruyJXG+QD0dyv4VURmelXqILu5Y
	DfO6sy1jfckW7sNY24bkyYYhDwMN2O/OB99dKWlIudTOPnytw3Y/zP6lcmWyq5eT
	VwXntfwk47wZeJ52V5FN7KCf8A/SlXMOt4P+juxUdVN0y4qrd8AwTOd222baYEEK
	phJauopWD+hn1mnM9Xr4geY4v1pJ5oAd8R7zsPsj+V2yqjZoCcSuGz1rKyV/S+yu
	JJCKKdFawp6AU2AbC7YPKITgKJy5K5p4txnjI50bd8nWBRlL1S2uhNVQn6IUVjPZ
	I4LemQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsk65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 15:47:09 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e8653ad27so65974407b3.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167229; x=1785772029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=;
        b=klJfENhimTfOm3yYxUMV2DQU7038pz9QmONR7YHHrOc9WBozrtPbaBxv0QHd7hSaZX
         YNomTKGrgDQkC5q6mbprWw/WOx+r6c9zeYTvFb9F4iKxyqSDxfyTQUZHVUa/DLrh7MN2
         S5+CbiarzbjqjktD3vMcLXRdgRQ+9BajzrJ7br9d4Ic0iosiVf7saELfAwsOiAmCpSfG
         BnzspgJn4cVSTuJSfH0BRsrFw42R7KLydX3iZHoBJTzueXVrryR3zLdYjK8ULm35oqKC
         yUJjslYaaSunnTbHrUnNH+4I+T5vksUP+0yF3g75si+LI4H7pNO6MqNhMWXspzKkYjKC
         Kc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167229; x=1785772029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=;
        b=rFOHRUf+Etmlia/DAHeZfYvqm6KKOUoM9RudNy1TRXuMf6csML4w3jg02bxLKd/crO
         nsIbRhzKQmJ+PFYYEIyL+jnvko6+6viOB6kjpFVgfCGg2Sk/SADKcXTnJZMEhZ09qiSY
         WM8hkrxsvURV2uq3cP2mb48hwsZzrgeuzwkgwCgaJxOnJ1CHkexVwW54509zhBCQVc4M
         XswL9iVBb4XRgwBsyuKuaFDrolEyyDqH97UJTLbwKcBYiWmHSyvfWMG7eJvmSvmpfuvk
         mqpYYrRTFbKqUaQQQF9eNZKoSZCSot4TfRiI9k2o8x9bQmrtYku5tC2pGg1E8VBsVY1v
         D/fg==
X-Forwarded-Encrypted: i=1; AHgh+RqoF32mj+tVZjrglaZPeKmzsvEO0/HDPGOzF3IQ3zQx5U9FybMKZKXu0d96JgatAiXN81vCDi1T/pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7TrR2SRsDB7UxfDBYSpzknuOV+OFOH7u0nCGmrW8hKawJPztQ
	MCGxe88qJgCkPg+dp45cBug2ZqMk0jmmVw6AW5hBkhjWSVZs7XPGJFtoNoWP37+ov9bM7MkqGYb
	BW+HPCun9yRBvj7vnKy5H4Iis7pFVRCTnzk73H+CKqipn89QKUBrglNZqv5gCYAM=
X-Gm-Gg: AR+sD10No//690jafQIofvmBU2FWUkLF0Wd728Y79XVDyC7mtsxdErJ6eeeo0g+nbGq
	WoajWn8VvPfoPnSUEaMVBYktIGMwEJsyrwqm/gKRkV0vNPoGr3hys6EIyXyiGIr1CnYdmQBhgcx
	rlHG3dcbY/rrKipaBE8P/wYd8XZ7Yy41zmQFTMoNKwE/nBxkcDZ76U/FhY1nTcw7hx4el8RUbMb
	PJw7U0qT8D+HOfEeV7zT+4lkPJC2q4D9soOr73Pqc2SeCFWNJ1zF1Ou1NiU9JaD6coZ/guYwKf3
	j80a5iPMao8QTtwZp/0vyOoeCZhgTE5lMskXVsRR8JkQVvEt3ACgWmtXGEnCL/mnxgHGPHIbnSx
	m6EK6s79v7Ope05/4eMhO1FKy40Z/4w==
X-Received: by 2002:a05:690c:600e:b0:81f:3dab:372f with SMTP id 00721157ae682-81f9391cc77mr412907b3.12.1785167228524;
        Mon, 27 Jul 2026 08:47:08 -0700 (PDT)
X-Received: by 2002:a05:690c:600e:b0:81f:3dab:372f with SMTP id 00721157ae682-81f9391cc77mr412547b3.12.1785167227905;
        Mon, 27 Jul 2026 08:47:07 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:07 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:01 +0530
Subject: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: uPcfAomD1xmdYmUJ2qsvBQBb-YjFf8Ho
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a677d7d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=o7QFpL2tXW9ehrA7-Q0A:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX3qpgsdLvA7eo
 cE9wqtIGEeVqSmlPVH5IBIOIx5u4hT/qYZE3g09WmFMdkyDaDihBu0juzErW85ty/L9DJATEOR3
 ngq+EMtRIZa72/5DoMbz6E8yXPPB028=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXz6fh1KDEZGvk
 85ttpLJ4x0iOJBrCuKn69rZCH8gNuthQ9ieiWfCidL8DkhnTqKDoqK4B2OntoFySoJtOz0hprKV
 S+wjyNfOWEVYo5dJ2xzJT33WpgyeH2oqd6pPrckUptVu7h2WMf1pH/vWGrJoOngDko/E1/d3PxB
 3CwclHNgdsHNY+hJhVtOZUdvw6n0QZ3yH8h3bsweYRtabQGs8w7DOF7Wx0n2z5ywkcT6AR9Ouvk
 P8NKAUvN+C+oUP83FhxML6fZPeNySpJQmI6lRJep/VjqQQLppbXJjK9BQK5nA8/67b9tFCDf7X+
 qPf3OeVVc0nZb5ISh0XbWdbP1GkoY4gsAY7A0DzggERWCoD4O8PlGELcdopG3DRQlMD7ttTYa/I
 WAEo2+jllHb5mmzT5Wep+k6cuEd0oFIb7X0SF/HJetrTUPSExAn4nkc9jfxsYwRhkcXQJHBcOok
 /BbRrm2DQasrcWBwi7g==
X-Proofpoint-GUID: uPcfAomD1xmdYmUJ2qsvBQBb-YjFf8Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148

QCC2072 can be used on M.2 E-key cards where the card power resources are
described by the pcie-m2-e-connector node. In that setup, the M.2 power
sequencing provider creates the Bluetooth serdev child after matching the
QCC2072 PCI function.

Integrated non-M.2 designs need board-specific power resources. Document
only the compatible for now and leave those properties to be added with
matching driver support.

Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
controllers connected over UART.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,qcc2072-bt.yaml    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
new file mode 100644
index 000000000000..e4b281ef261f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qcc2072-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCC2072 Bluetooth
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+description:
+  Qualcomm QCC2072 Bluetooth controller connected over UART.
+
+  QCC2072 can be populated on an M.2 E-key card, where the card power
+  supplies and sideband signals are modeled by the pcie-m2-e-connector node.
+  The M.2 power sequencing provider creates the Bluetooth serdev device and
+  uses this compatible after matching the QCC2072 PCI function.
+
+  Integrated non-M.2 designs require board-specific power resources. Those
+  properties, together with a static devicetree example, should be added when
+  integrated non-M.2 support is added.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcc2072-bt
+
+required:
+  - compatible
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false

-- 
2.34.1

