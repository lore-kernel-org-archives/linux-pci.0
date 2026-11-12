Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493092;
	b=pHW95HuKQqHy9CpUU1RjpiVN+X9hq7Ijo/PxutdjnFV7+QdECkMIsovw1mcn1IuuNuMr
	 YvvGL/HJgxmLXGh8vyo93xgb07wNwihU5eVosmsJH2GIKFAhHP9ZPoXdq7f220Yz16x6m
	 JViYGEfbf8oIdFwREHCuC9nEHoK+D7/hi9LdS2Rkj5/aSk9FNAeXtRMtip/jygZ2GgNdh
	 /VkqmUo2F+mKKpzyzEwAG1WiBmUs3pd0gHM+J6S/06pwu/ovf2XEyS0Vq6OchCUBgglKv
	 UueFHJyuCq1vU4A/Fdjpu3JERgpl0DEj5/RP2UbWIv6DHRwaevGIxwqajgIeFe2foFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493092;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ka2yhlDCWvaJnoM3eI9ZfCHMeS1DhEPdDlcTZSMfyEI=;
	b=FzlQYEFJSzPGXuoZzqJNBVGsqv7KMBRalut0hcrI3TxTe6qPc23xmqA3Gf7wsdNAPrgi
	 QCwfk4E7Y4f44kl+3reyw84ucB8nMRCROpKlkY5899YGJUYqXhfdlpjiGe2RcGoDJX98h
	 qwB70lu734kiZ0AvZXtpgTvUN8heDzFmlLee7SIlXtp8tCcc3yMFR47AfFptEiTDgEQcb
	 KeGFTXgi9Gd9yNkEoC4/SbXUemgLNyVKLrmnL/V5TbMTcB5JnUyzQKKUTHZwVe7JwvyfF
	 08pPosgtUT4KpWw+k6R96rgjkd/xvBD1MmqYY3Uyc955eNVeJ6ENgtxyygGvMPvXdVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SU5Ik+oX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.4
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73DF606A8B5;
	Thu, 12 Nov 2026 14:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E73DF606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SU5Ik+oX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D71qcuIzh0TQeL0OfEXyqj4ECE+spWWksU2oh7+ShKSbaCvmMYYMwbDxzw2MgXLKZ+fdGOmJNjxr6doxWJ4UWvz3kliY5/0N+AEzCwsSQe2wGdSq7l0XP/jsW6Z5MTYC6uoBr0uKrYfWyM8t6ga8ndjZmhHgZ8ylzbJV4sIM54Z0MGj1/rsUyEC4mOoPwxTwnreHBP1jgjfwEvE9xA3GD9X38IUujxAGq7WupQtHrK8mObxkVAS6CSpt3VQTtztRBCOfI+fqvAzY/mR+s5iaQF7GnSkdWETK2PUWh46NREguOBsB4slkyErGEVQKpbJQ4zNFkeK05Xn4hAwS73tBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka2yhlDCWvaJnoM3eI9ZfCHMeS1DhEPdDlcTZSMfyEI=;
 b=pCa+CdzU1pHztfZzhX+wRY3cuwv0jIrvOJ7kfKyAZCWmnyOV6jcH+9tVya9EXbuQDCWwMuv4G4Sw1pwRDbqKYgLoWs+ym93tNmKEYhnasNpUx4T2+Ep9tK56wjnRIbVgCGrUwZNUiUQxRB0yFhL/nB/xccbeRQ/KxL9CWZL1adO58xH7WMEA4xzl3wfLs/v6g0nB1sroz9ly85oMGjturB+w5+cDErQQduFjPERpSBUS/EfDBAZXbii69IUV0J2vbYOhpIn11lf13q/P9GR9jtjH5tgYCVQy0ZYI+rW9AqZeG3Guo7aY22iGCmu6xK7bA9uB9yzDH6C9DWq7benMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka2yhlDCWvaJnoM3eI9ZfCHMeS1DhEPdDlcTZSMfyEI=;
 b=SU5Ik+oXa3gnMYUR+Ai415U3U8/cdyWkwakNi19JY3becivbOl7xn1Goj1pUbwwu4pWHnleoxmBlhwRM8Xawx5vi8egL7ANXfdESlMENRaQc8JvgTJxMBqSszhbt57JFd5+x0jQNrN52K3ZfOLwyLSQxAqD/RbBuKjIvLrTfP2Lh8xxDU+CQLy5a+q0XZ/x6WhCnLHl8UZeurE/NxGYWKb82qaKXC1eeAfWpq6VqSpeHWQ2T7p07tBajGVW0WNupsrhN3PVfdBbd4igw+Jvwfdxlb2Qpk/Joj+/OpUMtjxyLTaawsvCzS2ODNAOlRO2lkqjgO70hRB2RDQmvTD9XKQ==
Received: from DS7PR03CA0162.namprd03.prod.outlook.com (2603:10b6:5:3b2::17)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:18:08 +0000
Received: from MN1PEPF00079400.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::1f) by DS7PR03CA0162.outlook.office365.com
 (2603:10b6:5:3b2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:18:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF00079400.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:18:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:49 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:17:46 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 02/20] PCI/PM: Add a power-state helper that tries the bus lock
Date: Thu, 12 Nov 2026 14:16:14 +0000
Message-ID: <20261112141632.918954-3-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF00079400:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 979275bc-f256-4fd0-d9ae-08df40c7c651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|261009223027099003|5023799004|11063799006|56012099006|261022075727099003|261028144727099003|261102130727099003|261026140227099003|261022105027099003|261026121527099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HRJaJ4lHkRvjLzcZE3/yPJdmN+ko3M+Rdq/Whr9uMW6dhR5Kn25jV+Cs5t/mGbg8cUqTt+UUwPRU2IzE9Q1TpT3ArkL2Ty74PONRd5HYWOnuL9v/o8hn/HuQnhqpFwHZqvAKhAQDsD7/c+rHq8GB2Bpg3/kPQ9ksLMYNJWw+mYciVoT2cVe1wQ6b1pqqyFKUzqVQ697qnHpxeVrs1w1mHPq4dQC+6rNndKiTEA3+VIT1hcyDF4qsoUC87zzUAY+V+qxg//0xfNm429O+L6eqxhws+dKT9Lav6bPDvtFL83HozDJkDrzQ+2FpY1T2ZinFILJEsatH8KUSLYroEhW46OOV+ynFwg7IOLEuGMc3u1k22CoYEDJf00vyYeJrVxbt2YfyFULH0VDqXj6mu5Eq0Fwy/hm9ZDI2tSJruwvo74xd+mGBDuMvnhrBcfGSh1vpB28D9s3Pulw87JJKbXf66LWCnxJxdSj9rTib2JOYZF6ZnDSaAup7bXPZOlcZDSMUZgAyE/61gzrfmm1NFh2WR6jmyjPnT5HNQe3CuaHcNwJfD/vvuOXVOqJK70uPyScW/LLhIuzQF1T8XpWiROwIey/9uO96o7xC/8IjtpW1v6rmBs3Ud8pXKKzBmYnp/bSfIUYdX6Nr/J0Mp1ArJqZ7Pv6zkgLriNVpMEgFb7cH2/HoPRY7rtaxyUst6WQ/HnPD9Ek2qVMlrWSNAcH0wBASAA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(261102130727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EHHQgURKDGG9gFnMV5zBCwNDbTdQE31Evs2Srmkt9kvz61NtQsJ4iw6du7yZSdlXmZR60z5dLlA/W2ReV/PP4GAngWxhloHRNSmPZcBH7LQEER2w8I45VCMeoCoo+Bz2Mldeqnq4cNDcv/Jmeued0IYFUy8aA6C2QgaP/Ejgpuhi9kVeb/wENt3Sr9iEYenH+2SIz6PqIQPG1OHn9eg7h2UDVqtUOVsaohHEmriDwI7WUe0OIzW3D6YZVT0P1Y99SwMTthI/OCOnlWEalBwEeLs44V2HoWFeOTmsNsYvK6HskjRUqY/AF1ICkk2S/VMbOVa7tWe1ePoF3Zo8JBeo1W9GTlZpEOLtpUN1Oj7jBPu+0sbXY602FG9sB5q6c/KoeU82bNXewnhTy97QyQX0hPfSHjjTUPQ9sxtXRZ+xswmk5WYf4VrUz6XPbVLoh9EI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:18:07.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979275bc-f256-4fd0-d9ae-08df40c7c651
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF00079400.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816

PCI error recovery can hold pci_bus_sem for reading while waiting for a
lock held by a driver. If that driver also needs the bus read lock to
bring a device to D0, a queued writer can block it. Recovery, the driver
and the writer then all wait for each other.

Add pci_try_set_power_state(), which returns -EAGAIN if it cannot take
the bus lock immediately. The caller can then release its locks. Once
the bus lock is held, use pci_set_power_state_locked() for the transition.
Keep the existing cases that need no power-state change. The transition
itself can still sleep.

Callers that already hold the bus read lock must use the locked helper
instead.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/pci.h |  3 +++
 drivers/pci/pci.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..542fa4af0a43 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1535,6 +1535,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
 int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
+int pci_try_set_power_state(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
@@ -2216,6 +2217,8 @@ static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 { return 0; }
 static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
 { return 0; }
+static inline int pci_try_set_power_state(struct pci_dev *dev, pci_power_t state)
+{ return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 { return 0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..f2ebd19204aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1655,6 +1655,43 @@ int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
 }
 EXPORT_SYMBOL(pci_set_power_state_locked);
 
+/**
+ * pci_try_set_power_state - Set power state without waiting for the bus lock
+ * @dev: PCI device to handle
+ * @state: Target PCI power state
+ *
+ * Like pci_set_power_state(), but return -EAGAIN without changing the power
+ * state if the bus lock cannot be acquired immediately. The transition
+ * itself can sleep.
+ *
+ * Callers already holding the bus read lock must use
+ * pci_set_power_state_locked().
+ */
+int pci_try_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	int ret;
+
+	if (state > PCI_D3cold)
+		state = PCI_D3cold;
+	else if (state < PCI_D0)
+		state = PCI_D0;
+	else if ((state == PCI_D1 || state == PCI_D2) && pci_no_d1d2(dev))
+		return 0;
+
+	if (dev->current_state == state)
+		return 0;
+	if (state >= PCI_D3hot && (dev->dev_flags & PCI_DEV_FLAGS_NO_D3))
+		return 0;
+
+	if (!down_read_trylock(&pci_bus_sem))
+		return -EAGAIN;
+	ret = pci_set_power_state_locked(dev, state);
+	up_read(&pci_bus_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(pci_try_set_power_state);
+
 #define PCI_EXP_SAVE_REGS	7
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
-- 
2.43.0

