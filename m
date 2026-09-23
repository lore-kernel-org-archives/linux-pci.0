Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919983AD52D;
	Wed, 23 Sep 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147977; cv=fail; b=IAFOnGGQzmHQu940PZ0IMBk6JtUeo+ooJtKSoO3eYSgVBcs+FtgbS2/PyPY4SoHY6FQeatXrq3CVpTFm5Wa/uqK6x9L4nBSpc8cVgQhQvNWuhMtausR7/O/esKFKEAUlT6paFpRLgG2lRqw6I4MSScv+BFvXg7bSQtd81gzdoVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147977; c=relaxed/simple;
	bh=0Ji+rPCnyOu8DKLKbzBT9G6frbSPYDk7UEwqmmmLHV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/SLzXlsl3++G9ls2B4AN2UmumStt053Qko+gh7vRe7E6LHNXm+vOy8u0EUK3GkNL/w0keQ++mTxVy8oivrtPRuUKr+N4eRvn4iPKuoxRRKK3KfSauL9BJla8dK6zejHSHH983njpFJAs63BiMYBAAaelNTF3p2zcp35a6xP+WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mymFTjRb; arc=fail smtp.client-ip=40.93.194.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mymFTjRb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwYyAqLki7O/kC0mTBWpcHmyrP4UqRzxs58Bsfp79yBNQ2H6dhuI+Ekez1NCcJLkzrokvchnQNfwL8GEeMTOxlZDBWtP3kEDRqlegzHVKKYtd51HZOxvZPBVRDoaGjBpsJd5B8Pfi4PW6xBZWl5Gboqg5BcFGUeMPC0B8Mi1Hqu5Wczc0i9ub9Q9sIoi8ZN+kwXGSL/O7+uX0AQuLTZp9hOT4PAO561Ae/OvYxwU/PThkQEypctqC6cfr53+omuM1JVACMuAk4nvhk+HpsGvb0MCioVDggQTvfLqVoFvX9GU5jxn2gzYeLQJb3RwmcpO48xg8jVBCf1q0AOoBllZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZnK5WSbeaaKzX5CRVhpj3VN+yIgh/V9lUzJfPsGUtk=;
 b=AqvnQi2cYpJPOqGTulUOL25abh5mN/ip0xOEUVosx2HhOHa6W8KWlsZGD5uVr5kOenXzhTGOuATT9sLs6IFO88/UxBnRZ57BdaUlCoKrWUEk/6kyZrQL14+UdoS9H+dQpPLuVhaJDVP5Hspj3wBIq7v1MCGdLdZoxtRnAqlmjjaPnbkz79RgCmNlSjUr2LB8Fuxisesr04iCW/rKN9GBAog3ij3PW/9IwMuDqI9W2bSkiuA4cVOqKvy+wB3Ard121JFJeWJUTSpReR9Kg5W3vGe066jsXhl4PqG7ajOjcI1Hr/s6cFew79TWiKz7gN1YMHZp8Fxcuop8NrPVlHlDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZnK5WSbeaaKzX5CRVhpj3VN+yIgh/V9lUzJfPsGUtk=;
 b=mymFTjRb9DfjOrKxBthKNcj0H2QDeOCrF+l/zCmLJSMZ5XqYSUChN7amSi3NJfyvqL8YkihR5QjoxlQfqeICDGFzoIMjsvqlVRP0EJ9qVdDUbU5VwuMTQBnENKDCuKd4lhfIkjnxjzOhZ8yLLPq5r6m9eDGcK7PNMt2wGTPfuyzn+fMHLa8jjLtq5IlfERr5sLxq4qt1bPtJ1C1u84T/t3ChUBA6KKV6brJSbqr9lr/NSX1uvPaB0dwrWAgZAWOJppNlv6SyoWc1oNX2SCeagWzN4vXEgEnrxO3jRU+Eh6Q5x3Dl+IXUtxGjjGNhSKgn4ZKZjsPyRptYvF++B+ec1A==
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:19:29 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::48) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 07:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 07:19:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 00:19:11 -0700
Received: from mmaddireddy-ubuntu.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 23 Sep 2026 00:19:07 -0700
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Krzysztof
 Wilczynski" <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 3/5] PCI: dwc: Drop unused shift macros
Date: Wed, 23 Sep 2026 12:47:04 +0530
Message-ID: <20260923071706.1134320-4-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
References: <20260923071706.1134320-1-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b5e3f9-4e36-421f-c771-08df1943021e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|82310400026|36860700016|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cz48NL+QASezxd19UIItyyn/7kezZ1UZmhndEf/1WJCR3MTWLcVxzx8LdBIkxAHj+RNMCGCMo7mFE4gF7+x8+f4l+i/MBb14s5U3nRcy3U2xW3gvJN5nEestUGRirEZxUF9prAPMOvyhdu/NpUvERn/9Wgo7xFSwjbqJWsKtd+u8ap4x0yW9j7znX4qXb9/B9hXtWmrEHHpS8c5an5IL6fZDJTw5TmWa6bV5oOKIhNmhurSxpWyFxvaQr4x5QQbTpiI+JUlX6tFw1SkYToa+NQn0PcwxycphIfSHToz2NUbLg5qoV06YGtlp4galzc4Jo5yNteI/ijiDXl1Q1wlJhOS9Ltnd+krgVwZS82x+NZcPJH4quxiDG6839mgO1VKZ0tola5ml2sa+bdDvQvHGAi+8ylE6b85S8RtkDouZPacL6nxJy+LcQrOUl4GjNBjpleFIhyuCxEkJSTHWNxsTAZiqdIiACMW0c5UoTT889LQvSEv9qN1apLb/t/HWBZBsA6PMLW7bhfIwGxzXXy3gGgP8cZM+uxfxoBGqDoX4D1cLADncE3kng+sPnxSaGliTU0Au3yhvx/G9qJyevo2vvInn8FrZnmEvmQNoO/EFAGnMhOZQ8+54ljMbKSjPVqEzm1Vl33nFQ+d1HkjTff0bw3wZ0TcXcUNvcYp2yALOlb3KPoBbhycl1kATTOl9R0ml0KPPZ14EDQctdhrVSsOW0g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3FQw6G3NbIw+G5Pk4/l86mT6DsIAsGRuFP5/V+gXNDeBoBBMC2f3otMjZWaee3zjt4Goc8f0fr5hXTQy2KR406IRIyFu1+Gl/vuS4v4iQ7If6Mx6ISuL8pBPOD3vwfuq1m/GRzdOqsCw9i2zeEjVH8dxrcCR61i5yqvXvMcBFw8F+gz8Yl1unJsajQN+EmnXb+4vK0jKf/QSFkIwgmE1tLuG2vs7owEC+6lDYwwQ5QtLXQkcHTwjGnAX2I82pw4KPa7eziCLQ5+2tDa2J6SYkf5Hu7Dr38xcoOriKuPHbnVg1FmrRWV+fESpmNcZfqXnY86O5hAJr38yiFGSksmIqDCzHLPaAkmtN/xrEfkhIPqZJMbrZV+IQJfhdP/0ZsDeZOKJR+O3s1Q2iX0B4fgeZZ5HQDWRrWY9Olsrmvt67fXn4ZnIykj02KdNrs/LdbSq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:19:29.7669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b5e3f9-4e36-421f-c771-08df1943021e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

Tegra no longer uses the DesignWare field shift macros after
converting the call sites to FIELD_PREP() and FIELD_MODIFY().

Remove the unused shift macros and the old narrow event-selector mask.
Add the complete event-selector field with the standard mask name, and
keep a temporary alias so existing users keep building until they are
converted.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c4db241547be..f70b7da97e07 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -82,9 +82,7 @@
 #define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
 #define PORT_AFR_CC_N_FTS(n)		FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, n)
 #define PORT_AFR_ENTER_ASPM		BIT(30)
-#define PORT_AFR_L0S_ENTRANCE_LAT_SHIFT	24
 #define PORT_AFR_L0S_ENTRANCE_LAT_MASK	GENMASK(26, 24)
-#define PORT_AFR_L1_ENTRANCE_LAT_SHIFT	27
 #define PORT_AFR_L1_ENTRANCE_LAT_MASK	GENMASK(29, 27)
 
 #define PCIE_PORT_LINK_CONTROL		0x710
@@ -151,7 +149,6 @@
 #define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
 #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
-#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
 
 #define GEN3_EQ_CONTROL_OFF			0x8A8
@@ -277,17 +274,14 @@
 #define PCIE_RAS_DES_EVENT_COUNTER_CONTROL	0x8
 #define EVENT_COUNTER_ALL_CLEAR		0x3
 #define EVENT_COUNTER_ENABLE_ALL	0x7
-#define EVENT_COUNTER_ENABLE_SHIFT	2
 #define EVENT_COUNTER_ENABLE_MASK	GENMASK(4, 2)
-#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(7, 0)
-#define EVENT_COUNTER_EVENT_SEL_SHIFT	16
-#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	GENMASK(23, 16)
+#define EVENT_COUNTER_EVENT_SEL_MASK	GENMASK(23, 16)
+#define EVENT_COUNTER_EVENT_SEL_FIELD_MASK	EVENT_COUNTER_EVENT_SEL_MASK
 #define EVENT_COUNTER_EVENT_Tx_L0S	0x2
 #define EVENT_COUNTER_EVENT_Rx_L0S	0x3
 #define EVENT_COUNTER_EVENT_L1		0x5
 #define EVENT_COUNTER_EVENT_L1_1	0x7
 #define EVENT_COUNTER_EVENT_L1_2	0x8
-#define EVENT_COUNTER_GROUP_SEL_SHIFT	24
 #define EVENT_COUNTER_GROUP_SEL_MASK	GENMASK(27, 24)
 #define EVENT_COUNTER_GROUP_5		0x5
 
-- 
2.34.1

