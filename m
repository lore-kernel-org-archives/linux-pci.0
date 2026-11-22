Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329968;
	b=wQqLHktvReAewHZzXXZYSFb6vwFNFFjxWitqjLq/pE0Uoxy9lRhn9Uufx5vEs5xIdNPp
	 mpS3FrjbeSY9U+PpztNY3qZD194Oe5SvcJhE7+O0vM1Y5FMMu6HS0fMhE7jaX5fSZgVWm
	 arWYEV1juvSOpSxT4qZ0VAE9MDoCxPap8dIopbxbpJ8XCqHr6kVjWZRo05NyxC0MvrRjR
	 3O1ku9pO9w2a+RJqSUrxmyCUuyDj9jaRDCjTvgi2GsgdkR/4WomOlG2RbctiQSyxo9tGy
	 jIb5G+Pem/xKpUxmG5p5gqwU2hINrxzPxVZC2VYyaceIclZnKU0jdUphgTqVNVFaj6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=H/b9r64wVj4efOL6ncKUcE6MGl+qFdrpSZkrqiV+IvQ=;
	b=42MSoRp5OBxvpAttXRPxO2zC0f+L/T9Ho0MVqmwyURC+Qin/ghVjIcVzVZJwIwa1oLEo
	 96a0FiteH2i2CM/37/9jCcMhxio8TcmA/fYmmclaSwYFW+zRdKrcKIVxmsV+Bl2zGdp9U
	 z383mUY1cxE+G3oiQdHdq3e0csh3lio+p3xgdWFu6xiv5a+6t014I16OS2oKKHd3Z8OAf
	 b1K+8WuKE/KYI9x+XsMHawqveYpCOytn2axpkrU6Ld69JoQqLDiyjwqtZPf5kPn39HxnH
	 1zT/dB249udDP6gL62kMjGKLCF0WhTt8v5/fwRrKyqMm3hoKcynkF9Q8rQFiwlRh7mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1AHavZA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ThTc3t5Z;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EC606A320
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D30EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g1AHavZA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ThTc3t5Z
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3kUxN2612079
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H/b9r64wVj4efOL6ncKUcE6MGl+qFdrpSZkrqiV+IvQ=; b=g1AHavZA7+/wFP3E
	uTSCsL0EAT/1GL1ykBhS5je5x4i5qA2Z+GxS1wGLKGKU08+DeycL++wFjUOyYJXb
	847WGawtFvuJJwCyfUHpD87YnFsZxLfEngF2/eIIguZ9CFmgOh6c1jmOxSCqA38C
	7GJ8v7gN2RYelZWt9qKN4uBhiO7tI5zPTc5G6bW/x66WPAQaZPKlN0zDAfJo6aES
	nquRrdJ5FM2RAh+g1cxNuLTA3UGRpgYXJqX7vE//KjWpFFGc12baATZfaEODQLYV
	CSGVM8FHhS9e8H4WlMECO3cBq3I6bMpmyQqQA23OHTqg5j0kC9v/Z/uFmFe2jiqz
	+uL5Jw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j328ru11e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 06:46:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-384c78aa0dbso3291344eec.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 22:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795329966; x=1795934766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/b9r64wVj4efOL6ncKUcE6MGl+qFdrpSZkrqiV+IvQ=;
        b=ThTc3t5ZyZSNmmF/0nuTCUptAC3t+nz0BSYp/A2S4tXuxCl/9VNh6p3REGDLQP9Ke+
         w6l3qHB1cL8W0JMXtDxOU93Aa9U9L+36hx88trqCHknWbQLeB8lNcrw8jPwdp9QBgqGa
         z9q6wiTyys8GxzeGTvR/7q9epG/GQ87HxhjDxq9+W2LjRDH2iYbQ/6hYS++1Ho1nqT3v
         m2BYbLbV6HJVdPnEHk9ZMO/8rECGDAqnfyeZqBcEF1COPyb/sVd3dR+x3zotu1eVKkEF
         YkJ0QbaCyDZQOEwnTvwLOO73GcxHAJ2gW0PWGjRIOYyxg8VJfjfYR5CYtuUZiAorif8f
         xD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329966; x=1795934766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/b9r64wVj4efOL6ncKUcE6MGl+qFdrpSZkrqiV+IvQ=;
        b=K3xW/sTvsv6P0pFEoeJU4WEQBZxFIOfcCJlRoz124j29keFLr4km2EGs3DlwfnBSHo
         RyKWOX1FT72Gpv5m4h++/yY1WdHnhkChYK8fkSexd33Ec/h6ZikLz8FEy9Qa4gfXe4a6
         n3BQta+pTbTVv0ANIBiePpVC2lKIC218BDR3IruzxeTabTQxYU6i4w4aXfgESNUtEARd
         RjjN+K2EFUudhGdKa6150ss1qmWsNuXivuQ9g1WCkCc54+y5pDjtrASG7Q8zU81StuKh
         UvOr6P651AYpyF3Bi8yK+17U7GAghJ4bOstaNNhMEn1bYx/iDCR303wHGz3E/w1dIpAF
         P7+A==
X-Forwarded-Encrypted: i=1; AL+hErHjv3OL1KmTrz69Gq9OrcOrOIlLEnWddSm6xpKqRN2AhvommVe12NbEdqkf9e5dDNIR2TJ3HtZmjTQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LCvgEG27RYflTjDoTTzYt9Wij/NjwuAnM4HgQ5Y5QUfIJAZQK
	5wLlg2OKdHN+fmrd31QqdpAAW6bFQOI6aDTjVAO88SZy6oyzCJu83XXnq8AbQVQFYSy/48aQe9Y
	8IpF26K6y7+YQQ9kdXXxjEvBlcjj7YUTWzSQe8L7cB9HKtNGx69l+SQTicMQz6OQ=
X-Gm-Gg: AZFdTZdMhG2PUpKVpgsSuXIG2GD/l+5BvxouuTSVjPcBxpvxlNhB24+nRIA67AtkxNz
	Rsobq10e2kiUO+cog5GYmqzGEcExP4TBzqs2B4BArC0ucdKrqtddjv/AvCaZFRARF8bI1qGMdni
	MtEWCNhZyt6ctS24+PQRw/RnkrYPZraIA+sSBc8SYtYG/bIQW2JVKBkWYytA3YJayAgBvxzQvO8
	j7/XQ1FY80pvwLJrkH9bqoD5fK2COP8OV2oIhnIx/Yt/QHS3Stw+3JXFmXEKzTAXgDtIugJVHAM
	6oMmlApfEYrTY1Qjs/qkoE506PILhk8CkrZRz8V8HKfKySgrweNb5V3dIcSbcpCj7DXYJFYeY8h
	L/+1y0jvpEfO/ActumXfcNTi8yviXLLe2jDCEbWY6NtMo6FiGN8qidXEtFivWrTGn/+39NhvRm2
	ieeB0UoqtR
X-Received: by 2002:a05:693c:8084:b0:36f:4981:da16 with SMTP id 5a478bee46e88-3857073f5ebmr7775365eec.25.1795329966126;
        Sat, 21 Nov 2026 22:46:06 -0800 (PST)
X-Received: by 2002:a05:693c:8084:b0:36f:4981:da16 with SMTP id 5a478bee46e88-3857073f5ebmr7775348eec.25.1795329965510;
        Sat, 21 Nov 2026 22:46:05 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm27598615eec.10.2026.11.21.22.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:46:05 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 12:15:51 +0530
Subject: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 B connector
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
Message-Id: <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795329955; l=15475;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=zcs4vGjIwXcjS+UfeXqojSMnLw/E4xL2h8k0QNt0xzg=;
 b=b64UBy6CYP+LsGSWtzSBImMsk2RKvPgyZK1jQmjgVVBF3+HF5Lj6V/rdo+zKSJGwP19HENvXg
 zY/rNaeLBqNCKWk4KH1v5EtIOPmpPIf60uOQay5rbOvUhlOnt+/m5v/
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX1aRtQTJbd1kS
 ag2OBx5N1CnAoJfBbgFZbxbqXED+HJJ7ZRbhHwhXXruNcuoTl8sHRxcc+yp9z4yOdPkZ90anOgW
 ntUiwTP+ymaRQzfqjeTNakd1Te3UPYc=
X-Proofpoint-GUID: NYjDz_k2-LxSd48rP-oCV7yIkz4dGp7i
X-Proofpoint-ORIG-GUID: NYjDz_k2-LxSd48rP-oCV7yIkz4dGp7i
X-Authority-Analysis: v=2.4 cv=c9w+0h9l c=1 sm=1 tr=0 ts=6b028faf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=MlodEPlAgwUD-2UE0MMA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfXw3UYLjoTeGHm
 eWYcTI0uUMhnoRjTxth7ZSylCn8rdnLJs2GXOpthQtTVcafqg1O2Rgv5toUZtI4vAmK/o6SS+f4
 el8+fDe9UdodTW22B/Q/X2FxiJUlDS14VXG3tQpFdviSH5exNMXik1jPI7B2Ls+9ECQXbroGEHP
 Vspi/tweItpTXKYanYnmBGgYNE8IcKSrvnKenSq+lNXjOVPDAPy7d9jFHIHiMxo/GXRVrMbhn4T
 5WPdTZn09qh7QkbhqhbnsXUhMJDeK+9spx884mMMa5tiLM8yWYtZYPi2PwK6DqzZjo13PgYGkiR
 WIIlwHgkkwjDb6Mv/egkfubpOglnLg3e8PjLh33ary/EdngcI4GsknSmnCIYyMVoo0ICv2qZ9cb
 9a7BNhWelwjCarmB0Otj9LZRkUj7lwVHVF2p55BrEoZj+MMaxxpv9ffn0Ft8tOYHCzccl4lt/47
 ifFoEkQ15yGTsrjy5WA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220026

Add the devicetree binding for PCIe M.2 Mechanical Key B connector
defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
connector is used to attach WWAN Adapters to the host machine over
interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0. The slot also
accepts SATA and PCIe SSD Adapters, which use the same pins.

Interfaces that share connector pins are described as one graph port
per pin group, with the endpoint number selecting between the mutually
exclusive interfaces.

The connector provides a primary power supply of 3.3V/VBAT, along with
optional GPIO signals: FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1# and DPR
for WWAN Adapters, and DEVSLP, PLN# and SMBus ALERT# for SSD Adapters,
plus an I2C parent for the SSD SMBus.

The function of the GPIO_0..GPIO_11 pins depends on the Port
Configuration, so they are described by gpioN-gpios properties with the
function of each pin per configuration documented in the binding. The
Adapter configuration is either sensed through config-gpios
(CONFIG_0..3) or fixed with config-state, which defaults to WWAN PCIe.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../bindings/connector/pcie-m2-b-connector.yaml    | 332 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 333 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
new file mode 100644
index 000000000000..4760863ff4f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
@@ -0,0 +1,332 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PCIe M.2 Mechanical Key B Connector
+
+maintainers:
+  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
+
+description:
+  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanical Key B
+  connector. Mechanical Key B connectors are used to connect WWAN devices to
+  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or USB 2.0,
+  selected by the Adapter's configuration pins. The slot also accepts SATA and
+  PCIe SSD Adapters, which use the same pins as the WWAN interfaces.
+
+properties:
+  compatible:
+    const: pcie-m2-b-connector
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator for the 3.3v/VBAT supply.
+
+  full-card-power-off-gpios:
+    description: GPIO output to FULL_CARD_POWER_OFF# signal. This signal is
+      used by the host system to turn off the entire Adapter. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO output to RESET# signal. This signal is used by the
+      host system to place the WWAN Adapter into a power-on reset condition.
+      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for more
+      details.
+    maxItems: 1
+
+  w-disable1-gpios:
+    description: GPIO output to W_DISABLE1# signal. This signal is used by
+      the host system to disable the WWAN radio on the Adapter. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1
+
+  dpr-gpios:
+    description: GPIO output to the Dynamic Power Reduction (DPR) signal.
+      This signal is provided by a host system proximity sensor to the
+      Adapter to trigger a reduction in the radio transmit output power to
+      meet regulatory SAR requirements. Refer, PCI Express M.2 Specification
+      r4.0, sec 3.2.13.4 for more details.
+    maxItems: 1
+
+  alert-gpios:
+    description: GPIO input to the SMBus ALERT# signal (pin 44, shared with
+      GPIO_2). SSD Adapters assert this signal to indicate to the host that
+      the SMBus device requires attention. It is not present on WWAN
+      Adapters. Refer, PCI Express M.2 Specification r4.2, sec 3.2.14.2.1
+      for more details.
+    maxItems: 1
+
+  i2c-parent:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the host I2C controller connected to the SMBus
+      pins SMB_CLK and SMB_DATA (pins 40 and 42, shared with GPIO_0 and
+      GPIO_1). The SMBus is only present on SSD Adapters. Refer, PCI Express
+      M.2 Specification r4.2, sec 3.2.14.2 for more details.
+
+  devslp-gpios:
+    description: GPIO output to the DEVSLP signal (pin 38). The host asserts
+      this signal to tell a SATA SSD to enter the Device Sleep power state.
+      It is only present on SATA SSD Adapters. Refer, PCI Express M.2
+      Specification r4.2, sec 3.2.10.1 for more details.
+    maxItems: 1
+
+  pln-gpios:
+    description: GPIO output to the Power Loss Notification (PLN#) signal
+      (pin 8, shared with W_DISABLE1#). The host asserts this signal to
+      notify a PCIe SSD that a power loss event is about to occur. WWAN
+      boards use w-disable1-gpios for this pin instead. Refer, PCI Express
+      M.2 Specification r4.2, sec 3.2.18.1 for more details.
+    maxItems: 1
+
+  config-gpios:
+    description: |
+      GPIO inputs sensing the four CONFIG_0..3 pins (pins 21, 69, 75 and 1
+      respectively, listed in that order in this property). The Adapter
+      grounds or leaves unconnected (NC) each of these pins to tell the host
+      the Adapter type, the host interface in use and, for WWAN Adapters, the
+      active GPIO_0..11 Port Configuration. Boards that only ever use one
+      Adapter type should use config-state instead. If both properties are
+      present, config-gpios takes precedence. Refer, PCI Express M.2
+      Specification r4.2, sec 3.2.15 and Table 3-18 for more details.
+
+      Table 3-18. Socket 2 Add-in Card Configuration:
+
+        CONFIG_0 CONFIG_1 CONFIG_2 CONFIG_3  Adapter Type / Host Interface   Port Config
+        GND      GND      GND      GND       SSD - SATA                       N/A
+        GND      NC       GND      GND       SSD - PCIe                       N/A
+        GND      GND      NC       GND       WWAN - PCIe                      0
+        GND      NC       NC       GND       WWAN - PCIe                      1
+        GND      GND      GND      NC        WWAN - PCIe, USB3.1 Gen1         0
+        GND      NC       GND      NC        WWAN - PCIe, USB3.1 Gen1         1
+        GND      GND      NC       NC        WWAN - PCIe, USB3.1 Gen1         2
+        GND      NC       NC       NC        WWAN - PCIe, USB3.1 Gen1         3
+        NC       GND      GND      GND       WWAN - SSIC                      0
+        NC       NC       GND      GND       WWAN - SSIC                      1
+        NC       GND      NC       GND       WWAN - SSIC                      2
+        NC       NC       NC       GND       WWAN - SSIC                      3
+        NC       GND      GND      NC        WWAN - PCIe                      2
+        NC       NC       GND      NC        WWAN - PCIe                      3
+        NC       GND      NC       NC        WWAN - PCIe, USB3.1 Gen1         vendor-defined
+        NC       NC       NC       NC        No Add-in Card present           N/A
+    minItems: 4
+    maxItems: 4
+
+  config-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Fixed Adapter configuration for boards that do not sense the CONFIG_0..3
+      pins, given as the state number (0-14) of Table 3-18 of the PCI Express
+      M.2 Specification r4.2. It selects the Adapter type, the host interface
+      and, for WWAN Adapters, the Port Configuration used to interpret the
+      gpioN-gpios properties. Ignored if config-gpios is present. If neither
+      property is present, state 2 (WWAN - PCIe, Port Config_0) is assumed.
+    minimum: 0
+    maximum: 14
+    default: 2
+
+  clocks:
+    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
+      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
+      more details.
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph bindings modeling the interfaces exposed on the
+      connector. Several interfaces share the same connector pins and are
+      selected by the CONFIG_0..3 pins, so each port describes one group of
+      pins and its endpoints describe the mutually exclusive interfaces that
+      can be present on that group.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: |
+          Pins 41, 43, 47 and 49. The endpoint number selects the interface:
+            0 - PCIe lane 0
+            1 - SATA
+        patternProperties:
+          '^endpoint(@[0-9a-f]+)?$':
+            type: object
+            properties:
+              reg:
+                enum: [0, 1]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: |
+          Pins 29, 31, 35 and 37. The endpoint number selects the interface:
+            0 - USB3.1 Gen1
+            1 - SSIC
+            2 - PCIe lane 1
+        patternProperties:
+          '^endpoint(@[0-9a-f]+)?$':
+            type: object
+            properties:
+              reg:
+                enum: [0, 1, 2]
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: USB 2.0 interface (pins 7 and 9)
+
+    anyOf:
+      - required:
+          - port@0
+      - required:
+          - port@1
+
+patternProperties:
+  '^gpio([0-9]|1[01])-gpios$':
+    description: |
+      GPIO connected to the GPIO_<N> pin of the connector, where N is the
+      number in the property name. The function of these pins depends on the
+      Port Configuration selected by config-gpios or config-state (Table 3-15
+      of the PCI Express M.2 Specification r4.2, sec 3.2.13.3):
+
+        GPIO  Pin  Config_0     Config_1     Config_2     Config_3
+        0     40   GNSS_SCL     GNSS_SCL     SIM_DETECT2  IPC_0
+        1     42   GNSS_SDA     GNSS_SDA     UIM_DATA2    IPC_1
+        2     44   GNSS_IRQ     GNSS_IRQ     UIM_CLK2     IPC_2
+        3     46   SYSCLK       GNSS_0       UIM_RESET2   IPC_3
+        4     48   TX_BLANKING  GNSS_1       UIM_PWR2     IPC_4
+        5     20   AUDIO_0      AUDIO_0      RFU          AUDIO_0
+        6     22   AUDIO_1      AUDIO_1      RFU          AUDIO_1
+        7     24   AUDIO_2      AUDIO_2      RFU          IPC_5/AUDIO_2
+        8     28   AUDIO_3      AUDIO_3      PLA_S2#      IPC_6/AUDIO_3
+        9     10   LED_1#       LED_1#       LED_1#       DAS/DSS/IPC_7
+        10    26   W_DISABLE2#  W_DISABLE2#  W_DISABLE2#  HSIC_STROBE
+        11    23   WoWWAN#      WoWWAN#      WoWWAN#      HSIC_DATA
+
+      The IPC_0..7 functions of Port Config_3 are vendor defined, as are all
+      functions in CONFIG state 14.
+
+      On SSD Adapters (CONFIG states 0 and 1) the same pins are SMB_CLK
+      (GPIO_0), SMB_DATA (GPIO_1), ALERT# (GPIO_2), PLA_S2# (GPIO_8), and
+      LED_1# or, on SATA, DAS/DSS (GPIO_9).
+
+      Only list the pins that are wired to a host GPIO. Pins used as a bus
+      signal in the selected Port Configuration (I2C, I2S/SLIMbus, HSIC) are
+      not GPIOs and are not described by these properties.
+    maxItems: 1
+
+required:
+  - compatible
+  - vpcie3v3-supply
+
+additionalProperties: false
+
+examples:
+  # PCI M.2 Key B connector for WWAN with PCIe interface
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    connector {
+        compatible = "pcie-m2-b-connector";
+        vpcie3v3-supply = <&vreg_wwan>;
+        full-card-power-off-gpios = <&tlmm 121 GPIO_ACTIVE_LOW>;
+        w-disable1-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
+        gpio10-gpios = <&tlmm 123 GPIO_ACTIVE_LOW>;
+        gpio11-gpios = <&tlmm 128 GPIO_ACTIVE_LOW>;
+        /* A zero phandle marks a CONFIG pin that is not wired to a host GPIO */
+        config-gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>,
+                       <&tlmm 125 GPIO_ACTIVE_HIGH>,
+                       <0>,
+                       <&tlmm 127 GPIO_ACTIVE_HIGH>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie6_port0_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&usb_hs_ep>;
+                };
+            };
+        };
+    };
+
+  # PCI M.2 Key B connector used for a SATA SSD
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    connector {
+        compatible = "pcie-m2-b-connector";
+        vpcie3v3-supply = <&vreg_ssd>;
+        config-state = <0>;
+        i2c-parent = <&i2c0>;
+        alert-gpios = <&tlmm 130 GPIO_ACTIVE_LOW>;
+        devslp-gpios = <&tlmm 131 GPIO_ACTIVE_HIGH>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@1 {
+                    reg = <1>;
+                    remote-endpoint = <&sata_port0_ep>;
+                };
+            };
+        };
+    };
+
+  # PCI M.2 Key B connector used for a 2-lane PCIe SSD
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    connector {
+        compatible = "pcie-m2-b-connector";
+        vpcie3v3-supply = <&vreg_ssd>;
+        config-state = <1>;
+        pln-gpios = <&tlmm 132 GPIO_ACTIVE_LOW>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&pcie_port0_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                endpoint@2 {
+                    reg = <2>;
+                    remote-endpoint = <&pcie_port1_ep>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..b9db9686dac5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22255,6 +22255,7 @@ PCIE M.2 POWER SEQUENCING
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/connector/pcie-m2-b-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
 F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
 F:	drivers/power/sequencing/pwrseq-pcie-m2.c

-- 
2.34.1

