Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC88450902
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382857; cv=none; b=SLTePRQ62eUAZ662yDgXlGvDtUDObY5vIWlxgMhvz2gNWycGXxWFzDZWCHCJlW2PD41oS4wiKgtFlkeOMwEC5Df4aMb5c2NbTz6rbfic8CvHYwaTlD2FGTwUd4WHbsoeRTJaP+PIe0EyK746cXLZEf39wp+qayQWgEbSRhQq4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382857; c=relaxed/simple;
	bh=ov8hIF8M1z6R9wDtFRkRAkC1i3judy0L71MjXuy8SHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxgYtgCY14fuExEpCfKbtJWGSn4RpkSw/LyFczE/cm3FvbtMl1m5f9mSSdhWxFvmB7vHECUIz7c5foZgQH/0IFkw2ZpwV33pCBr/5VzRmWKj3rubCxwPDLD5qCUfEEawuZEp9vSacQhPkbiVoFKbzST93jZByfsiNraH9ZHGWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dW/1JQe9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcRHpEkL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dW/1JQe9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcRHpEkL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SC0TQd1625044
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wClwdHi//EK
	ovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=; b=dW/1JQe9cBtpzMr3eMM/+Eqt4vo
	0ZSC+iHG5TPw/xMg2XFg6GwVycdDVghqjMmcwUHoFoBBTu2k02Iqux4l9Dy+ugQp
	2MWnmuqNsGUVl5O2w+Hv4sP6jOYwTa4qpSmVi6q1qXmJZk4OLaeTrK3xBe35It2T
	R7LsM8nBmLY+f9r73wsgUyRtzBKA64N0TVm0x+rsVYfCtz5OiudxL5hTo8ARKWA/
	SVpbvFedwKEVGJFLqP+I7F1YnMcx5QMTrZCLlU0XyBBdB1v4GPWJ43pSDsGclisF
	oMxvcs5QbZ0UUO/1sYYucyM3ew42wqnPo6IKYPNXMVfj1h8abVpZK4KqA5Q==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsb66r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 13:27:35 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6056351129bso16226759137.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777382854; x=1777987654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
        b=UcRHpEkLmkqrsoFjjEI8AAkd/TQzu0/DczlvkAqT97GHO1G8x88Lg4ultHuPfGihhe
         ZtbdYRPo3660qwN/98b2Z3Nnq7eXWhuFgLPJLnDZ5JBNM/SmuLrcrgeF3SPne2camEd+
         zVJp/N7NmyaCQTS1oJsXPp3zBveVGwPJa6rmt3e3uPtuqpTzDrjerQm7Wg6VvJTjeb8i
         ofLCP8n/UXO5JipymKYD1JW8eNaMsEwuCE0F6SRXueEhGRDvpzibWSoWGPNGGqfyL9vQ
         cqL/Nx3mVnoTkdCSPGe4HIDlLK7O6GeEDf8qgB7db4D3j05ICxXufMfPzyBiBOnMQu3E
         pvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382854; x=1777987654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wClwdHi//EKovApGGp/o1/cMKxisBXL2sxG8w7zO7Fo=;
        b=o9qjszBTQskw+lmkpV40HQbKo+Rw0OTcbj/qcCuNpbsAKp1sH9xnJlwIP1a45bx0Dv
         uQWuOFGmRJMJjiWMG64VquyCS+FWCcDvT1S2GBikWLcyW3TQxF6FE12wAK7b8/WPhAcR
         0hYSW9N3FvKWptjyU4Ci8RdGVkgXANL/jyun9U5Y7sZNtH630NyQaUsYakXXA78vH9IA
         ZCa9aP/nbFM6VeGt+3cQ+/TsGQMANTiDf0cTddysD1aWW2zoQ64PXpFBfTXuXVN0/HhT
         VQapy5mxifRL4TCQbUuSiCL+WTBHuRQa0kkq53NrX/AQD48gn65s7eq0bY75GZsru0N7
         jySw==
X-Forwarded-Encrypted: i=1; AFNElJ+bEW8mpw0XNV67HOFDh+Gwzu0OQQ+HbUq0oKMCw4ApEHF8oyWHAn8FZEQo5cSOxoWwSCXWAdm8cmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6CDKvo5d040Ast1/lV035H5A18PWZ/zkqjvoxbz6nmmeOjlW
	/ilAMfyzCQkU7uUSM2huE6FCua5w8R7DfaTOzNrwtTyw95/UCt5N2L2zSI0Kk9osuN8atJKAUlM
	JopNRR6wEyNFX2uMA0mgYl14Xk4BTi76sIuKwYjJavN8XXmJL4ET57ZaCB0WxrnM=
X-Gm-Gg: AeBDiet0ey6M993yT7gdLpLnNdA3dohihz7GTsdYghhwqnnlOeIqj1uzpDYtoHE6+9Q
	zx5pYMY4bb7PAL/M59AOMiXUlrtiC56O4iUiMP0OovEgHzBxUrUP/zc3WHjBWxkQCL6FBFJt7Sr
	OKJMZQJBBlpyxSUYsmmU0WsZ972dZ9un64UW9FCJ8OVGYu1jaTEzzOLGZoYww/vVMOxVEJ2saM0
	Ruw69lFJu6nyCv6okbhVLiRyMqb9ycY8z2BRRUbCBXGbV4/NJl6eB6sZzqIEhhwkhdNg1JY7Dkt
	EUQF6YRstZh+mQKMG0neKcZx+gOZTYuPtjMj8AeDzODd4x4xzAgVI2au1kBcSZxn3M6rB0gIU8e
	pmNdNKdvU37RtfB3zId73jJEvEM+nYvJcQspTSSL+sphDhOM=
X-Received: by 2002:a05:6102:54a7:b0:610:56a:4bdd with SMTP id ada2fe7eead31-6280bde472fmr1278814137.28.1777382853830;
        Tue, 28 Apr 2026 06:27:33 -0700 (PDT)
X-Received: by 2002:a05:6102:54a7:b0:610:56a:4bdd with SMTP id ada2fe7eead31-6280bde472fmr1278233137.28.1777382840066;
        Tue, 28 Apr 2026 06:27:20 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d5ee9ecsm7232213f8f.16.2026.04.28.06.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:27:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [RESEND PATCH v2 2/2] PCI: mvebu: Keep child node refcnt for probe duration
Date: Tue, 28 Apr 2026 15:27:10 +0200
Message-ID: <20260428132708.95998-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428132708.95998-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260428132708.95998-3-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=ov8hIF8M1z6R9wDtFRkRAkC1i3judy0L71MjXuy8SHg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp8LWvxjL35h3b9GCXehstfFtvOosrOCx8JxD2V
 bgJIU/Bh3aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafC1rwAKCRDBN2bmhouD
 16WlD/9v1FyqjVeDIKt9vW6cdG/antel/dqTkWtauYAQHcCKwfJF/GUZ7e5Ze/UthhvEqtUjfNW
 qZ/SJxUyDrHJFuFruqiSughQx1TfTQw6NpicAiWE6hLuGADO/tBlh1WO4FEqmSq6/onJPPh1eyK
 IM5GewioAdS3wz7EE0DOVoncynQBibxpTkhhKaRg6sE54NQJ9YDNHOya4xtiY7rAitvZmQsYBnJ
 eajJULQzgNDHPXvaa6XGiQ+YB3TuW+2d8gBKWywb9RjfrTfvPT3Wr9tjk3jZOlXf0BYqF8EwMY8
 p8f+69RByv/MAkZzG5yeLjLU+dCQJkH20OzLi+Y4nFu+g/pSwCYc3z34JBAVYtQ68cH2jaCpKvI
 voA7mxbSB769nrhf2neiMDLMVvZxY+ndor98M+G1p4lrgjo3e6nYtW0GNSxKkrqGCqJth68mibs
 +FRu106p7ZkPS0Fc1/pRSz1u5xoTxQGizvKPWkjNjJDzYenIot2+/F/r5pYio5Q3FYZHiV6AXfS
 4hHkeKMgqe5tV6O3bInL4xOmnh6ZFt6+UUUzYpdxhFL/Dvbg/no+ZoxiAlOq03mUU1f0r4Gch7x
 7PkoM4XZNene8Vm2AcQUTxlesu1YkVtRLteTwGEklVDXm0NtEu5KBmnqO8YLFGu0QzplzXxKb5x KqbBl83c5g0ouSw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5liD-z_cMS29LmzWDqRbcNHa42ZduGF9
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f0b5c7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=pABr9VbpVV2WwmlfmZwA:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyNiBTYWx0ZWRfX73m1xmWMPEyL
 2fEVwmJ4MaxcNlfpLPc/bzAVC6XOzYKjDejlAHSiNf8etLqrZkuTKg5zSVCPtzCP+VoIiD/2Fdu
 BFE1Z+b+LtOlMDd8kaUoRw1lRi3Q0vCj1HnsRY0dP0u6DtT7cRYyws5vqDtscNlX2BAw6pfRYbO
 GjTZCW90Zzih/jKtsAJ1ConnUi1NO8ajDHvS5W4Pprfb5EVtDNvSLYsWRPyROsDHrx0pH2nwwig
 ZXJHc0cn+mft5PjlfnDBXh0FIooKQb8lqKg9dWf/RiQYH5t2kH96GTHghYsr+Zqf7EdmNFpFvGT
 kkLWT+zAM7ke1PLNTtxQMb4oSI4y1X5hN6ZkLZS5llFCGBQJCoAypqMUdTzp/1Ul75e8aDrdvNJ
 6bqxHFazKEas3TLzUMb6/YxlePisIG0TXNYv+n9SNbYgBIozJVtJROOSlvkUWl+g33GOX5oQRpl
 yUuLccnpCEjJoa0kiSA==
X-Proofpoint-ORIG-GUID: 5liD-z_cMS29LmzWDqRbcNHa42ZduGF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280126

Driver in probe() first iterates over child device nodes, storing the OF
node pointer but does not take the reference to it for the remaining
part of the probe where it is used.

The pointer thus could become invalid if children OF nodes are being
removed from the Devicetree, e.g. by removing OF overlay, while the
probe is being executed.  That's is highly theoretical issue, thus it
does not look like bug with any effect.

Nevertheless, make the code logically correct, so acquire the OF node
refcnt for entire lifetime of the device, since the pointer is stored in
each port state container structure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. New patch

Note: Not a fix, because practical impact is absolutely zero since
of_node_get is a noop.
---
 drivers/pci/controller/pci-mvebu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 4d3c97b62fe0..7fb9c7393588 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1236,6 +1236,11 @@ static void mvebu_pcie_port_clk_put(void *data)
 	clk_put(port->clk);
 }
 
+static void mvebu_pcie_port_of_node_put(void *data)
+{
+	of_node_put(data);
+}
+
 static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct mvebu_pcie_port *port, struct device_node *child)
 {
@@ -1482,7 +1487,11 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		else if (ret == 0)
 			continue;
 
-		port->dn = child;
+		port->dn = of_node_get(child);
+		ret = devm_add_action_or_reset(dev, mvebu_pcie_port_of_node_put,
+					       child);
+		if (ret)
+			return ret;
 		i++;
 	}
 	pcie->nports = i;
-- 
2.51.0

