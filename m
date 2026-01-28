Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B334E763
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600458; cv=none; b=VFL6oM6ceQLNt/9MRQGF5DXTiwAKyuNxul+2wpJEOYMhByaHNE3ekuULG7iKhvNh5jrW/uVJbGatbfY4eQkJ3LZhU2lS2nKkNC2uBDOkfqZ+zdXHKg94J27L7NhGfG2va94e5jVlLLrh/23ipQHY+WrFM8cBM+nwP30NbFWL5tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600458; c=relaxed/simple;
	bh=2/RHS3VB+9/ela56gcCfKz5EhOgp8MbiqRV5USDd5Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JjzRRk8N+O9+yuYYgle4aRWiiYdLlwlgqircxuavnwZjkzgEcKTHlAQ1/YyDRcwY1kzynkt88DnfOJu/39Ybz4BtgK9h0l2DIjnx8GbHssbnE8herPGnXHKS8nLxVhzJPBrMMHcD5DOhAFKKBn+a0j5iy23t2flOOo/M+TshR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P8RYbQiU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KtfEmv2p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8RYbQiU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KtfEmv2p"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92eK8042112
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	26elPWs7TSj/P1iv30rj+NWpCzRlNUklVKX54bnVcaQ=; b=P8RYbQiU17NBiLJI
	Aqiq4/+WZO2pvPZm/LkwqpkLQ8KWPo0Gw4ClFGSJngWW0mp63MLm5jbfn0nIQFue
	mFZmsfeiG+H+hs21ctEhqZI5l7ytzHdzxjFeCrPXeUOH9szwmcpB5o3amv/q4291
	bsymptpgkWzz332RAd13uGxXTzGHMr8XHIsJZcyhkSlHnDQDduZdFYEopnGXjYh6
	GznBC0CFSCVYY966uhnloEp5jNsmj5l17GxjSHShdNL+7b+ByiLKDee3glfMLO6w
	1Cldlr4Bel+mCwA67Xcrs7XsvMYp1nufzh503woCnjSyMdfgUu6qN9MuZOrGB+C2
	Kr+EWA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355tv98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:40:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bce224720d8so3905264a12.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769600456; x=1770205256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26elPWs7TSj/P1iv30rj+NWpCzRlNUklVKX54bnVcaQ=;
        b=KtfEmv2pQ/6Epd66qkASK7Gc8mh19O34hU4fwakf+AY6Z3vXwiyVZHqp3cPwhRAFlH
         efKJRQOET24YvvTxCJDf3DvoaxSBF8Aea1YXT7CjFRubI+vo5qEtyPKD2lv0KEm70VVH
         LB3zc+Cq3cLp5Oy339v94n/5ekOjeg2FlYQnZ1wrcVAac4TzSbGO1k/bbRJfYyEMyan3
         UgeU6Rk8t+Cg/L25Q2IU6nxgqJaY38in4vkGBpK9wy0uVafUJqq6BVTLrNgWrA7WFxm6
         y7g0XGEHkqCajWEcbSn2yFic6+nkrrG8vB5QfJGzzSdclTHhBme0P5pNzN48wrTmBRUV
         z/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600456; x=1770205256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=26elPWs7TSj/P1iv30rj+NWpCzRlNUklVKX54bnVcaQ=;
        b=cbb7xRH+4L9wOfnhsjvnItb4bEamY8mX7UuUPfWMNzQnrFenhY4X/ZijVcIT2bC2rs
         OZt7gjlW5GUZPrc4KBbd5GoL+PT2AS5dsSEdG46EcxdUIxyyO41QuOWVa/AmiMSP6fL5
         5qM58yBc6msyQN5w/P8E76xPWp0TSlwLfooH2oZmlerNbKCJjbsO5JwK1T0lQdV8Qec1
         elEXdRZvMvIsWXimppyulHEDxMuC7arR3nL+6XbMqiCv3htyjTwBw7vM+xcrJZaY96n3
         BvcuXhmJHQo3aYNucoQ4WJc/2L8cU+Ct8ALSUpA21X4upfI44lpHtGn2q+9qOHSkCgMN
         IWCQ==
X-Gm-Message-State: AOJu0Yz1gkWX/ATf2YEVuRUAAf4pfjOihNilM2wEzGT9w1RoilbCSy6q
	l7NLJF1g/GxNqRUV6NnlgXKyUAMo7a62bDExhkjocK+vCavF06DVXhh9iT3oa6G9uQbbELacmEE
	jr6e2PrIqj43EP9U5Uexmf85GLXRhUhmOooatQ5/ktN7NooTsckTSQkPANJ0YUWA=
X-Gm-Gg: AZuq6aKjw4EYfPQaj5k3tA9e8d/jXtDbk5CFjeaBO7xA0IiDgHK1s6BxbinbHEO69oq
	U7K6Sq08W5W2j1MjGugs6voIDZL6ajkQR26R7q/vTgUadYpGViXBtKG2h+lCFgd80Owt82/vfN3
	Ci52XLi+3LnocWhm/Dvozqwk26JaL2HIk8BQkNMWOLoNaAE/pQ6SckrQlHrIXfeIZJMyEqIKscq
	epU8A158u1/cpwD48ELJ3+bVZii/QAf4hB2Pmch7M/nmfOsWxmyMSd38gqjmlikePNUVBJB+7Fu
	QvPAJko9FR8Y6kDM/v+j39J1vUY07k1zS9MmL6tNwCze6kUncqa/Q8a5CUzTTaZ5iXbR+cSCicv
	m08u6pOWdjOA3vBU4F+vwrklZmb27qo6b5zbQf7g12KuC
X-Received: by 2002:a05:6a21:7a90:b0:35d:bb66:5ce3 with SMTP id adf61e73a8af0-38ec6287db1mr5032435637.12.1769600455884;
        Wed, 28 Jan 2026 03:40:55 -0800 (PST)
X-Received: by 2002:a05:6a21:7a90:b0:35d:bb66:5ce3 with SMTP id adf61e73a8af0-38ec6287db1mr5032413637.12.1769600455424;
        Wed, 28 Jan 2026 03:40:55 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f41d0sm2010678a12.27.2026.01.28.03.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:40:55 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 17:10:41 +0530
Subject: [PATCH 1/3] PCI: host-common: Add shared D3cold eligibility helper
 for host bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-d3cold-v1-1-dd8f3f0ce824@oss.qualcomm.com>
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
In-Reply-To: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769600446; l=2595;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2/RHS3VB+9/ela56gcCfKz5EhOgp8MbiqRV5USDd5Bg=;
 b=9+Uq3obX1/upVJ1jSgLEdlZDN14hf6EC2Z5l3sJYRX+e2KMzaMrGwzdlT8eEsRE2LClbxTJKD
 nw9j0LzsDcpBv/30rGcMussGSOFuzmC9sfng9UFkEgAb0iNNoHU2HR3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=6979f5c8 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: CMiCXYxXLEXTP10g3t-a2X2gfbERQtEH
X-Proofpoint-GUID: CMiCXYxXLEXTP10g3t-a2X2gfbERQtEH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5NSBTYWx0ZWRfX0nvS/4vWlZcC
 pEKxAhHfHnkkGvgX7wn+qecAquZaBr1rzHGZ0UyUUjUZLVbVlgDJ5rZ5rqMVACeOI1DUA0OvYf2
 LOx3vVB5nMQJTm5rmFwRfviwJ3hztF86M1vZRlIKaczKTRd9j1jJ7HK755h9QfXVqDBjit5cagU
 X4WT16qpt5hoDGlnMTLnTark2KPeyQhvuHTnD61z6JN2cWyqCkerec6/BLTu3slxl4EZXR8N/81
 KuyePmHraBvTd+9SCCvzwqNLirsMMUQp0fA5vMtD6pGIXl3ae4nW7q+WO3GQXiAU2ghgszq/1bu
 rhD1t1bGRigVTSY/9rubLSuNFCo/j6T7+J3dFks4wFF6UN6dXoc4T7UA6oxv8+3K9556sysrZSo
 Omd0+XTFAoLp9gY99OSz2U1mHbYyRKr3OdMRjrVUp+AmxllyyPa4AEeqkdur8mKU91LEUgXRWyL
 pYxbRZ3x9FzvZkrfT1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280095

Add a common helper, pci_host_common_can_enter_d3cold(), to determine
whether a PCI host bridge can safely transition to D3cold.

The helper walks all devices on the bridge's bus and only allows the
host bridge to enter D3cold if all PCIe endpoints are already in
PCI_D3hot. For devices that may wake the system, it additionally
requires that the device supports PME wakeup from D3cold(with WAKE#).
Devices without wakeup enabled are not restricted by this check and can
be allowed to keep device in D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 29 +++++++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index c473e7c03bacad2de07c798768f99652443431e0..225472c5ac82c6c5b44257d68a0fc503ec046ff1 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -106,5 +106,34 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+static int pci_host_common_check_d3cold(struct pci_dev *pdev, void *userdata)
+{
+	bool *d3cold_allow = userdata;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return 0;
+
+	if (pdev->current_state != PCI_D3hot)
+		goto exit;
+
+	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
+		goto exit;
+
+	return 0;
+exit:
+	*d3cold_allow = false;
+	return -EBUSY;
+}
+
+bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge)
+{
+	bool d3cold_allow = true;
+
+	pci_walk_bus(bridge->bus, pci_host_common_check_d3cold, &d3cold_allow);
+
+	return d3cold_allow;
+}
+EXPORT_SYMBOL_GPL(pci_host_common_can_enter_d3cold);
+
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb31fbf1dc946ef1a6afd5afb5b3c6..18a731bca058828340bca84776d0e91da1edbbf7 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge);
 #endif

-- 
2.34.1

