Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329964;
	b=HEK+rKKtApQXh9A1b0/3nnmLhDIsTm/TUNW0/t380xfOPDu3nNC5Lre3YtgzMPrp2lIL
	 tFeekmFOMlkgdbmzKQme2hYMCYgbAG/kllHAZmuAZ5/EvL7HLH0G1vrPmS3QR7W8gb65e
	 c+2wHGvIAFxeLJezTrXx52KWJQuzKRUIZqZo8aiRmBPlu1Hzg1T+WkrI/Jf8yxQnLMtXD
	 UY+RB24soFlBH7BN5IQSN3saOYtQhnIAYG9nMpip5TVbJhOcwYdlY7cZx1cPpqId1bOYy
	 1ekl0dFakKdccsSHZagvCbYh0FPA1xOMdhSUjqqGtCHCEmx7PFvmvNX6xpwkTC3IXAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329964;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tuiQQpowNDqgIViUd3V9zwNZ82lxLYXnJLlZHlSUB8g=;
	b=W49abrs41t6HHjy1wMSLLOe4zux/8imaEeoqtsB4+5ykiK+gjOsBRMP6vdBfpQV0oMK3
	 KeRq1OOEsmEBxcWKjWfziiUQlFgwbc5GAu/9/R8yUqXq4GSwm94n4pRI+6PyNLCI60iPL
	 gmi0Wreyzbf/hi7Oc2jwL1hPe9m/eiw+0ww0JBl7ufmegCTV852M0ZGh6yfsm27EuHMuR
	 Zx/cgXxuNxBn7XVsgqt28jFkFGIQM7thsKa0XwNepurnWt/rX6FDoTqbPa6JA7QH18Wll
	 VeuSOsrL8wDB5q2nI/6oKFnCSYOygGTGi6fDpjjCOEgCsOqn69/QCplsWsYEIZAVysg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AV0WbZ7v;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iVMZWAu3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C8606A333
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF1C8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AV0WbZ7v;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iVMZWAu3
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3kd2h2085254
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tuiQQpowNDqgIViUd3V9zw
	NZ82lxLYXnJLlZHlSUB8g=; b=AV0WbZ7vT2NcAG5tkq4+5Wq87eEDHO/50r6Dmv
	tskHEeXHI49aFcGrDi7gBYrBQNmx2gtvJtDzfz9RSCq+vIkZGfBpoe34ipds3vSq
	xnxnRAKCwrw/YXiMjIR2MDJiz8aYFMNWGvmzbD+tfzxt+c0yWzoHGkV3ziD+MrXr
	lficYUvYtHjM9q+wQozxwth0lAa5CGkkY5LrmZOS7VTrrq4DXnXTlyB8CdOB8xHX
	Ookk7wJu5TFrrYx7kluPWtLIKmWxqmx3zD8XMsLJmjVMm5RmfrSGSyRATQCDWHxQ
	wExjQJcJx30Wa1wHAOy7b077t1zsA2Mq1s1/Uy0Lt8rQ3/NA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32mgaxga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3846d5f54c1so2974651eec.1
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 22:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795329961; x=1795934761; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tuiQQpowNDqgIViUd3V9zwNZ82lxLYXnJLlZHlSUB8g=;
        b=iVMZWAu3/MXg8/uzA1lhXlf0Fxwcu54+TU7BUKXF+oFqNUk72uHm8g5oW5IFw14wVg
         98eZyUgX24Fm4YQi0o2T/0tMJIXx5x84Hbo6tNHV65L1S9XxoVNnJY11l6YOloYG8D1U
         DeJ/Ws6DwQoG3g3XJYrK75/GCIkdVccw4IBYI0b/8f69BgLSB4Mlgqu4UEQHfgDm5CVd
         m84c4wmPwTgkkpeRSUtr/2e4DzRqbvrt0EGAoRJahgG348dHQ5EZBzTvlGwElOlYDv7u
         quaaws1VRcfKfAibcsEjc7ZXnhn3XiWqp+yHH24PMmDpT2/CAuLG54yPZbPm2cbcpL8U
         YYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329961; x=1795934761;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tuiQQpowNDqgIViUd3V9zwNZ82lxLYXnJLlZHlSUB8g=;
        b=dqMdKjNHIvIpdgRe+g2pPe6L/p7kWDP75Y4ZjqNzZy8wx3gai7PvhhFOa6v19HC3Rg
         zGcbKB97my57v+Ey4hh1bs93ULhshRmsth5o0SoanyUMTOaRu+V4NX8eVHmIoQLxRV39
         Jlb+F63USZ1i31MXks12FDrQ2YzqjcL1P0OFTC1sW6HDndNYeL8ksFILAE+UwRXZzaji
         N81LiTUmhvqk4CjaYc0MQh01dePi7WUq4QA5w7bFpU4fp85yL+t8wJYxQ7EXDO9Y3zel
         1LUQQtyCg2bihbnmabzodoPjQHL3nFIKOjWMS36zMdHA3yEA3jc2Xqpv4KTLjSg1RrtC
         SADg==
X-Forwarded-Encrypted: i=1; AL+hErFuwOkDorjYpo0zYxpQjzkmjuwoNqIdvobII4z9CgZfTHnBHGCJDC6Kdx8c7fgxnKeZGDkwbBw/NAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z//54bY9Z4KhZ07QiFKuL5GBem5f8750pjbunWIsu1l0fxec+AL
	HpUGbXjkVfSGhmrJsh9LayQ8hb8wLNIq7JrNG5eFZlsYKyTaSgcdRVZqAe0Mktn182/PE7LFHRy
	9yPxVg4Orb//QIclL65e/p3y8DAUUDxVSlsR9bBHk5BUTWSbx6P1UDWfmSGSnlH5dixfEWAs=
X-Gm-Gg: AZFdTZdmOAwoDzxuczIUfkSMnQNBWnW2XH4jYYV4XMQGwVZ23z4Dai3KdnwTbEoDK2j
	63rO2eojmXOK9ryNwAwGTnPcxF6+b3qd9gJVdmxdnghig4B9sxhKho9a+6tyOlJ6O8pRW/1KmH+
	fea6rTXXKezHNk/cwussg2023H26dIwUIbg52EiQ5vcslrCuo2YtgHDVUMr+QEKualCSezfO0eE
	V4OM9oNfvN1botdoqEyH8yYkSQgEq06dUoVR5SU7iTrf5HJRouendjwzYn8tzyJNX0O0zLjWMmw
	6PrcbJlH+0eaIPI+iuFMtVRK+F2qEhrtZ219Ui4Rl94hrTSlcfH/4ufVi6fZ3q+tDLArMkD0575
	okxUU/9I1R1ndal4Vb1BRW+DjOY3Ba56JuSaN+vUg/Z2OzTuo26+XabnD+CbY0jbX8Pc568mhky
	EkGUFxdPtL
X-Received: by 2002:a05:693c:638d:20b0:375:c862:31c with SMTP id 5a478bee46e88-38571816d35mr8055975eec.40.1795329961338;
        Sat, 21 Nov 2026 22:46:01 -0800 (PST)
X-Received: by 2002:a05:693c:638d:20b0:375:c862:31c with SMTP id 5a478bee46e88-38571816d35mr8055938eec.40.1795329960649;
        Sat, 21 Nov 2026 22:46:00 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm27598615eec.10.2026.11.21.22.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:46:00 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/4] power: sequencing: pcie-m2: Add PCIe M.2 Key B
 connector support
Date: Sun, 22 Nov 2026 12:15:50 +0530
Message-Id: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ6PAmsC/22NQQ6CMBBFr2JmbQltsRBX3sMQU8ogY4RiB4iGc
 HcLbt1M8n5e3izAGAgZzocFAs7E5PsI6ngA19r+joLqyKBSZWSqpBgcobk19BauMabJqqLSRQ7
 RHwLGeW9dyx/zVD3QjVtgM1ri0YfP/myWm/evO0uRClvrXOrM6ZPVF8+cvCb7dL7rknigXNf1C
 2zrkBS7AAAA
X-Change-ID: 20261021-pcie6_fix-cf66f4b8b387
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795329955; l=3040;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=nBLbfXrnUeOg/k3lrOwzMPzMyjCM8oeFudQrYc52rUI=;
 b=w0703ZbG7o+IyOKcodaTDYKM0mrFG87bvx0OmCPwNrsb0f1gNsudmjaQoF/ORAk8AdndNGWdj
 gYfEUfxCaXeDzxpAlxR0a/rHWuYGe3GTmExBpLrYgFg27qpjnbhIHeQ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX86/dNY6FIbuP
 jK9g42rUCZXcQFRSqEj26Tq3He8Lj7ztKXppntUUTE2pgwC6scGIVxxjfWwZ+vNK9PDqCsmL5Dg
 irYs6YXaSvJiBDNYMbesZelqB8ncNibFZMAbCLqqgljfCAs6LLlcKENYyOPVesDntcXTnMCsOxo
 Cw/deduy+9cIMMAH6Q1IntjVFoUvjSQKzKyDMvuNhUS2EquKWrcrOGqSKroRxUvaOBAl8+9gpZt
 bGm6i+trACy8rxillxzuw04XhEoak6IngnufnxDM0BMLE+IIDCPXI1H1ALjwgbKoYgWrCnt5n1f
 L0Sxq1a+bZql7bsAUrJMz+jdtMjvTaB9pP1z83qDJ5jATwP+lOpzvOXpRNgfJ3OKGZ4x3IPHuJw
 a+7Mqjac7RUwSt2I/kG3B0ek6CGKNUj/0sIdiuVNg13ioOBb5Be3V/gFhf2hRU7FbakZlYGQjxI
 UEJM8+G4VNqcLwTA67A==
X-Authority-Analysis: v=2.4 cv=OM+yTiaB c=1 sm=1 tr=0 ts=6b028faa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=zkpMToBQJcapbifWyZsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX8u9bd40wJTQt
 8ARh8cAgmeX/k1xrkNKw4trEdSnDrt4juNUd1UpYO8nciny7mk3iB5kP5yt2ZlUQbzXZt2oAZJz
 aGAhS317YfVNnp9elvqK7op/x5gi5kE=
X-Proofpoint-GUID: V1CpDyHQNDNwyBHivMzIyP8ZVcT_NVB2
X-Proofpoint-ORIG-GUID: V1CpDyHQNDNwyBHivMzIyP8ZVcT_NVB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220026

Add support for PCIe M.2 Mechanical Key B connectors, commonly used for
WWAN adapters.

The series introduces a DT binding for the M.2 Key B connector and
extends the PCIe M.2 power sequencing driver to handle the 3.3V/VBAT
supply and the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1# signals.

Finally, describe the WWAN M.2 Key B connector on the Glymur CRD and the
Nord RRD. On Glymur the WWAN supply moves from the PCIe6 Root Port node to
the connector, so that the slot power is controlled through the pwrseq-pcie-m2
driver and the PCI pwrctrl framework, like the other M.2 connectors.

The series is based on the qcom tree [1], arm64-for-7.5, which has the Nord
PCIe root port DT nodes that the Nord RRD patch needs. That patch also
depends on the Nord PCIe controller support from the PCI tree, which is in
linux-next.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm64-for-7.5

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Binding: describe SATA/PCIe SSD Adapters too, since the Key B slot accepts
  them (Alexey)
- Binding: add optional config-gpios for CONFIG_0..3 with the Table 3-18
  decode, and config-state to fix the configuration on boards that do not
  sense it; defaults to WWAN PCIe (Alexey)
- Binding: replace w-disable2-gpios and wowwan-gpios with gpio0-gpios to
  gpio11-gpios, as GPIO_0..11 change function with the Port Configuration;
  the functions are listed in the binding, with the IPC pins and CONFIG
  state 14 marked as vendor defined (Rob, Alexey)
- Binding: add optional alert-gpios for the SSD SMBus ALERT# (Rob), and
  i2c-parent, devslp-gpios and pln-gpios for the other SSD signals (Alexey)
- Binding: replace one port per interface with one port per muxed pin group,
  with endpoints selecting the interface: PCIe lane 0/SATA, USB3.1/SSIC/
  PCIe lane 1, and USB 2.0 (Rob, Alexey)
- DT: add the Nord RRD WWAN connector (new patch)
- Rebased onto the qcom tree, arm64-for-7.5
- Link to v1: https://patch.msgid.link/20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com

---
Krishna Chaitanya Chundru (4):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key B connectors
      arm64: dts: qcom: glymur-crd: Describe the PCIe M.2 Key B connector
      arm64: dts: qcom: nord-rrd: Describe the PCIe M.2 Key B connector

 .../bindings/connector/pcie-m2-b-connector.yaml    | 332 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  29 +-
 arch/arm64/boot/dts/qcom/nord-rrd.dts              |  40 +++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  70 +++++
 5 files changed, 470 insertions(+), 2 deletions(-)
---
base-commit: dde0308a2f8867806a444df1fdd7e685b1c56d5b
change-id: 20261021-pcie6_fix-cf66f4b8b387

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

