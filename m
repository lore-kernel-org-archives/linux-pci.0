Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792475406;
	b=xugLkVUYnkjVTQaN+Pc0mpmlaQIUdjhyigpdB9nGTVS6493oW7KCe43Z0Xcu4ijmTK3h
	 tLzf/YeImwsASRoclPzqlS2l+kEQQ3zPn7pZfibENKP0HoLJ9MrkKTIxsmmyJap7NsqKd
	 /avAo8j2nhKv6/+VQO8HaRrsuWoJhWWf9rmah9cEf058ika6kA9tEAknV8qZXEQajN6ER
	 /Sz1a4e2yhHfGZ3EZoSESDS3HY4qqsYPIy8MxJ3HeeLkMv5sEVuoVntKYGagKEeCQZ4Xy
	 PpzKiV9sazA73ve92OnjYeHpoZIWUA7jBPXCiO7qw1JCoxLJw1R++jVpF+EvnK4Abhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475406;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=97YcXvyYGIVeSS/ZokbaoOVYaTX+hBz9IEaj5Kar6wQ=;
	b=IbOuo9zsBZgHb5jv/XM19jbCBEm1Xkc1e0LeBhiaG44+gNth6Fhu2U3cLsJsoArWwoXd
	 KDMq2bKkNalgJfRWAdHuh5V4MY+j8PGLtEQ79d5/tyNs+8Z8yJwRx/tqJ/iiT/mEMWKP8
	 2d5dFZWc17K6BhBegzsCSC5wjmWo0+1i8VV/+Kvp4c97c+ND8cYrM0GKdvJ7nfWcogzeB
	 nXp8tWaSc0E+sj7/EUMDDIlBAaynWGzwR0xBLqJnYMgTrIIsSN+L/Tc1f1/sIuZsSgkxU
	 Qg/ZGf053CYlQojc/MOYZNkn59ahW/+yrhGdC7qcqLPOwbNW60wuhz+/Qy3b6lykrJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=khq9KIEF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.140
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021140.outbound.protection.outlook.com [40.107.74.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2662D60A2605;
	Tue, 20 Oct 2026 05:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2662D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=khq9KIEF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO6Ydy2jP0zi1uK9o5DKpNWo7QQMCExORFpN1udotcTkGS5rWebhlBpss7uAbgv6zv2/9IbDJyXy4Rk4nm0Y02VltgpKgPyxgzMd7aeq7uiKqOzUj3oDmDGM0y6WfD4gRhXawvJZQhfwqo+IhMtW8i+rSG38wXOporYnG7soMjGabjtnpWrWe8NSyeYMDuE1XtMlJuaIK5Q+YhIU+qBAgKalrL/Mcaj5Gl6iRoIJSR3OMg5iJ82TIyzEKS9mrDKb2InORs2rUJuLps7v348InGdEh5prof7Kt5SmdQ6zFCVTMZI+9odDB2RYLdTOZz+Cea1ks86+/lSbQL1ZMBUt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97YcXvyYGIVeSS/ZokbaoOVYaTX+hBz9IEaj5Kar6wQ=;
 b=aDf27sYrqA45zRle2BfKmndClcU7ZwFZo0rdK9l3rK4yg93PNxZTCf+UAv1DajvWJq3pP4lU4QbgEF5EqxOPaxrUI6tT2kzrhKCOnDjo7Hf+5vPiTFqfBIinaf7Wi1Tp0HM7iiOf7Gs4s0Ek9Ez7LSFoCbfAvqMRmxWlwZXtpWbIS+Ojm5AT6hG7YwWyC2l6ghUH4pJVygLor94UFuBDTgjjflqdln96hQbR6CJ2lgZUS9dU1Ii72m0qHECzjPi/6zB2u0nwzeqfmTzDsIBFPqcJn4P962nxM2wmVKPeIG9bkiAVzXCY2NwAnOWx9s7z/BNadco7qJGdFLC9niBt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97YcXvyYGIVeSS/ZokbaoOVYaTX+hBz9IEaj5Kar6wQ=;
 b=khq9KIEFfMHMjQ6u2luLpR6I9di30a2d6xeJpLj9ihgWsLorm37Y+89vx52GIdS3wHz+TqhMWXqGJMxuNPu1rpMf3kOiajzDPz0RKvcg8p9gdaSrxzpXx21cL8ZJtGXB3UR/WkdH8R+wWm55ooSp08k/ORhkW1GPlibCk7ntsgM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY6P286MB7913.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:49:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 05:49:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v6 7/8] PCI/NTB: endpoint: Allow DMA and MW to share a BAR
Date: Tue, 20 Oct 2026 14:49:47 +0900
Message-ID: <20261020054948.1218370-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020054948.1218370-1-den@valinux.co.jp>
References: <20261020054948.1218370-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY6P286MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 385b84c3-1605-4686-9d06-08df2e6df95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|376014|23010399003|366016|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MvGWWbqI6nKqv1bXFfzCYpm/s+HWsxe22sVVgMYL1zGy921DwirZ7jyveqEX00whpwO05G1kNfyEXHlbIkGHjebfU8ftttGeRWTiFYaiW3ep2tXHAPSHZvjUjHV/u/5YdP1/aC/fPaVhydy6zYWpuUhOsvGAJr+xHoBC83LVtiwFMNPEqk6rXVGuC3aNnTgJU5DH6oErzU2g1vgV2oHdJ3c92OisLj8VRh2qKEyLWit8GvJgDU5DrDnXnk/S7gSyb+HFMHPB/GLKxzKzZXRSD5rLMarKz0FQd7qIpUs8/A9NSOe3IPkyL4UJO0/aeVrMk/w9S/2ww4ODxO6H43ztxXIGxgQtjHFi2EBCb3630T5JPbrXLjbYl3Bo7U1N79QWj2ILRK8JizpOmLA9WP7UbZ78ouFQ/8+6qUsytJn2IwSxFOmVBOfMK86/mBS1MSt665rrFpoVDxAq1Sh5cyJ7+PJ956UkUdACqAwjImkeuE07Dj8iz+avGm9p4TP57S+/86crOQlhvIJhEme1yLl3En05oBdZiZ4IV8ETHyNYxUSQcJBO84Wsy8wa5X5xTZB81UxEXshave66VS+rW615rSpSN45v5ODQOMPR7qZEtqb/nOoYMwrjIiVkSJnxy/XQa80JzPbF4/ugow6bXnvGp1g+SbXZIaeT4tDCldE2BSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(376014)(23010399003)(366016)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdZWRS3dUdy+nT7IZRe7INaiT8jfIhCW9QPSaKqEishO5CuUcOBPy+XvwXby?=
 =?us-ascii?Q?qtBLhu+JXVIJDHrRsI43qvIaS+25oW9ZKrCO8Mg46LF/+aql3ZYhDbDAp+DU?=
 =?us-ascii?Q?uF1MvqMJwzLTkna+z/rxa6PcwSTJV/wDyDdjdl5hvUS0c0tEh4B2ywPDbL7l?=
 =?us-ascii?Q?njbf63MFfXrR3aIYi2uFzCgnIZBaZ+9FmzmoWLxj62npC/wuv2RH0oieE+VQ?=
 =?us-ascii?Q?PBniAergR51n+Lrx/83Z/bD1M/gvj2vQ3G5x+bN/GrPNIDrsYImHMCk0POhs?=
 =?us-ascii?Q?+rrcTv0koA85J7fDprrxXwWjR0KnQ+UNeN+8B4ZAo8Coksxga1yFrMR3J0Ux?=
 =?us-ascii?Q?JTeN3ygNY3PLTFb6/JLergQ1KXQ5Bgjd/LsOYR7aX29cwqU2/i58Iv3jcDUK?=
 =?us-ascii?Q?A8CXY8XjuPrbdn/jmYSVFyQZwF8aTOVXr/vRMk18L280RO0yYy54g2I7FBq9?=
 =?us-ascii?Q?o7oVTtRekm3sd4DI8QdvSLm4wTybK1qbUfucYez69maUYSS88+VYe32o8Gkr?=
 =?us-ascii?Q?Ftx9ipnjDzkDvTaXw5oCBMe+PHMImcLdZuXtOQUsao7f5p9zZ2X0/iV5A5Fz?=
 =?us-ascii?Q?nJG+YeRu0sWIst6M5ekImO4zTEZj66N/LymqxIsmi0s9J1h76Uj5U2ET8IlI?=
 =?us-ascii?Q?0PDMvD9A+vuiJa/1y0S6VHf03i5k7MKoZjVbZQRZ5oU6Bm88pn8Ns3UJYIog?=
 =?us-ascii?Q?rFxtNFwYo0dX9M5ymdLsx8HxqJziyHPOr5x4bPVYcYACqJigOM/3RZZ5QO91?=
 =?us-ascii?Q?ZcRmXqFrRasb/EA7nx6QL0MUxY5TYv+WANniF3Y0j1en/wcX6OeDNq5ReRUy?=
 =?us-ascii?Q?M4dvLQGMcezRgVOFUxJBHs2+Fc5U1o5fRcMDNtYjlrMzUw8f+77Y6NNiT5cq?=
 =?us-ascii?Q?lKC4mGUgN6XE6G42k/zwbAaDIKmIF3e9f+vfRzWKiPabC0bN0EqNkIpJGDVW?=
 =?us-ascii?Q?48O35mlvhnlgu67QI8SRc9e51dmQ4sYwt3hChIKjE68p0NUtIlGv1jRYdrIv?=
 =?us-ascii?Q?qdH7A2620BMaah8jl0x+dK3JLxaEwhicOL+vBlJgP12wy9m2OG4sXxTtC5st?=
 =?us-ascii?Q?1OADxgRlN/niGOpdqm0wCa54mKg7aRlYlHpr4av8uAWzw5/z7DnFcqFr7MyO?=
 =?us-ascii?Q?H8a9RKf/sceNXvsZLvX5exrJ4WEFuozmNm6P7NjMl9obdIc+dGM9u6UJDXKj?=
 =?us-ascii?Q?vGOkmQ0/qjvkX6Q2h1Sot7vLxG/kurEbtJAbsiqihYHbGrmg7u1XU6Rdqq6D?=
 =?us-ascii?Q?hFN9nkslzL5UtfogfQu8Sw4OeCkYPJ/bBizyd8yRxRwrVBcR9Vi5UYxUe4Eu?=
 =?us-ascii?Q?+121CoqML74x/JC8WJB8sMCT0bXiSn4tvdm6ZVZx1iop+9PvcFqNZgyc6+gU?=
 =?us-ascii?Q?7r4dZL5JyRZaUIimVWOTqADzY85VFrVyEaGJxBAVcaS51bANngy2ag4r6WyO?=
 =?us-ascii?Q?AKGe7+I6OusMu7gcfrBWPKua2Od1j/qpW1fn1vRZ2zY/pl652+Fr+S0/QStq?=
 =?us-ascii?Q?w74lox3amjw10kxLLIk4H6+V/MC7JGfBi4++E9tU9mvt2LZQn9w9T5CrMBwm?=
 =?us-ascii?Q?k6JHtrO4FzDaZNFIKbw7UbuiQ9rmCBliT8TYcT5eNCCpIi8J8wAD/GzCBR9/?=
 =?us-ascii?Q?IQMIqe8a7gRQv1QTOzTX4c/TgFS0jk1hKtMNZQVgQvWC7eyV/HlipCIds0h7?=
 =?us-ascii?Q?lf5KDsMVuhZi7AafMy3YBikw9U65AkkOilkBGTubSrmUCWy3YJNGoubIejuu?=
 =?us-ascii?Q?Y0xksN8dWXrHih700Fg/W0jjzLW4zQGGm43VkZuMGe04vGsUfW9F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 385b84c3-1605-4686-9d06-08df2e6df95b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:49:58.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvAZnNk4+n0Pz+PniSYErxSLwyWdaj1iZjpcgLWk4TBVi0OIW+a7kDNGvtP89Cak/UT7tOlET8qBQIK9aFyGkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7913

Some endpoint configurations have no spare BAR for DMA resources. Allow
dma_bar to select an MW BAR and place the DMA ranges after that MW.

DMA submaps have fixed BAR offsets, so a shared MW translation must
cover its configured size. Report that size as the translation alignment
and require it to be a power of two.

Limit the host-visible MW size to exclude the DMA ranges. Older versions
of ntb_hw_epf treat the whole BAR as an MW.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v5:
  - Include the host-side MW boundary handling and place this patch
    after DMA discovery.

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  43 ++++-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 147 +++++++++++++-----
 2 files changed, 148 insertions(+), 42 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index e0016128b95c..975ea424de6a 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
+{
+	resource_size_t end;
+
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return end;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, bar);
 
 	return 0;
 }
@@ -707,7 +724,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -739,21 +756,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, bar) - offset;
 
 	return 0;
 }
@@ -851,6 +867,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
@@ -862,6 +879,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Invalid endpoint DMA layout\n");
 		return ret;
 	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    ntb_epf_mw_size(ndev, bar) <=
+			    ntb_epf_mw_offset(ndev, i)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index ac83af54122f..89f828234ca7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -84,12 +84,13 @@ enum epf_irq_slot {
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 
 struct epf_ntb_dma {
+	struct mutex lock; /* Serialize DMA submap and MW updates */
 	struct epf_ntb_dma_ctrl ctrl;
 	struct dma_chan *dchan[EDMA_MAX_RD_CH];
 	void *bar_scratch;
 	dma_addr_t bar_scratch_phys;
 	size_t bar_scratch_size;
-	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 2];
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
 	struct pci_epf_bar_submap *reg_submap;
 	unsigned int num_submap;
 	u16 rd_ch_cnt;
@@ -229,6 +230,22 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	unsigned int i;
+
+	for (i = 0; i < ntb->num_mws; i++)
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
+			return ntb->mws_size[i];
+
+	return 0;
+}
+
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb, enum pci_barno barno)
+{
+	return ntb->dma && ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
 struct epf_ntb_dma_filter {
 	struct device *dev;
 	int chan_id;
@@ -353,6 +370,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	unsigned int i;
 	size_t align;
 	u32 next = 0;
+	u64 offset;
 	int ret;
 
 	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
@@ -371,10 +389,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 	if (!is_power_of_2(align))
 		return -EINVAL;
 
-	if (epf_ntb_is_bar_used(ntb, barno) ||
-	    pci_epc_get_next_free_bar(features, barno) != barno)
+	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+	    barno == ntb->epf_ntb_bar[BAR_DB])
 		return -EINVAL;
 
+	offset = epf_ntb_dma_bar_offset(ntb, barno);
+	if (!offset &&
+	    (epf_ntb_is_bar_used(ntb, barno) ||
+	     pci_epc_get_next_free_bar(features, barno) != barno))
+		return -EINVAL;
+	if (offset > U32_MAX)
+		return -EOVERFLOW;
+	if (offset && !is_power_of_2(offset))
+		return -EINVAL;
+	dma->ctrl.submap.offset = offset;
+	next = offset;
+	if (next) {
+		/*
+		 * submap[0] covers the MW prefix. Keep its temporary
+		 * target at address 0 until the MW translation is
+		 * installed.
+		 */
+		dma->submap[0].size = next;
+		dma->num_submap = 1;
+	}
+
 	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
 	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
 	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
@@ -408,7 +447,7 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
 		chan->desc_addr_lo = lower_32_bits(dma_addr);
 		chan->desc_addr_hi = upper_32_bits(dma_addr);
 	}
-	dma->ctrl.submap.size = next;
+	dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
 
 	dma_dev = ntb->epf->epc->dev.parent;
 	for (i = 0; i < dma->rd_ch_cnt; i++) {
@@ -481,6 +520,8 @@ static int epf_ntb_dma_collect(struct epf_ntb *ntb)
 	if (!dma)
 		return -ENOMEM;
 
+	mutex_init(&dma->lock);
+
 	switch (ctrl->u.dma_ctrl.reg_layout) {
 	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
 		ret = epf_ntb_dw_edma_collect(ntb, dma, ctrl, resources, count);
@@ -551,7 +592,7 @@ static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
 		return -EOPNOTSUPP;
 
 	barno = ntb->epf_ntb_bar[BAR_DMA];
-	mapped_size = dma->ctrl.submap.size;
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
 	/*
 	 * Submaps cannot be installed until the host assigns the BAR address.
 	 * Use address 0 for the temporary BAR Match Mode mapping, as is done
@@ -607,21 +648,25 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
 	memset(bar, 0, sizeof(*bar));
 }
 
-static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb,
+				      const dma_addr_t *mw_addr)
 {
 	struct pci_epf_bar_submap *old_submap;
 	struct epf_ntb_dma *dma = ntb->dma;
 	unsigned int old_num_submap;
 	struct pci_epf_bar *bar;
+	dma_addr_t old_mw_addr;
 	int restore, ret;
-
-	if (!dma)
-		return 0;
+	lockdep_assert_held(&dma->lock);
 
 	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
 
 	old_submap = bar->submap;
 	old_num_submap = bar->num_submap;
+	if (mw_addr) {
+		old_mw_addr = dma->submap[0].phys_addr;
+		dma->submap[0].phys_addr = *mw_addr;
+	}
 	bar->submap = dma->submap;
 	bar->num_submap = dma->num_submap;
 
@@ -631,6 +676,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 		return 0;
 
 	/* A failed dynamic update may have already removed the old mapping. */
+	if (mw_addr)
+		dma->submap[0].phys_addr = old_mw_addr;
 	bar->submap = old_submap;
 	bar->num_submap = old_num_submap;
 	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
@@ -642,6 +689,18 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
 	return ret;
 }
 
+static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+
+	if (!dma)
+		return 0;
+
+	guard(mutex)(&dma->lock);
+
+	return epf_ntb_dma_set_bar_locked(ntb, NULL);
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -1269,6 +1328,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	bool shared;
 	int ret = 0;
 	int i;
 	u64 size;
@@ -1278,22 +1338,25 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-
-		ntb->epf->bar[barno].barno = barno;
-		ntb->epf->bar[barno].size = size;
-		ntb->epf->bar[barno].addr = NULL;
-		ntb->epf->bar[barno].phys_addr = 0;
-		ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
-
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
-		if (ret) {
-			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+		shared = epf_ntb_dma_shares_bar(ntb, barno);
+
+		if (!shared) {
+			ntb->epf->bar[barno].barno = barno;
+			ntb->epf->bar[barno].size = size;
+			ntb->epf->bar[barno].addr = NULL;
+			ntb->epf->bar[barno].phys_addr = 0;
+			ntb->epf->bar[barno].flags |= upper_32_bits(size) ?
+					PCI_BASE_ADDRESS_MEM_TYPE_64 :
+					PCI_BASE_ADDRESS_MEM_TYPE_32;
+
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
+			if (ret) {
+				dev_err(dev, "MW set failed\n");
+				goto err_alloc_mem;
+			}
 		}
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
@@ -1310,10 +1373,11 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
+	if (!shared)
+		pci_epc_clear_bar(ntb->epf->epc,
+				  ntb->epf->func_no,
+				  ntb->epf->vfunc_no,
+				  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -1331,10 +1395,11 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (!epf_ntb_dma_shares_bar(ntb, barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
@@ -1936,6 +2001,16 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ndev->dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		/* DMA submaps start after the configured MW size. */
+		if (size != ntb->mws_size[idx])
+			return -EINVAL;
+
+		guard(mutex)(&ntb->dma->lock);
+
+		return epf_ntb_dma_set_bar_locked(ntb, &addr);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -2134,15 +2209,17 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
 			resource_size_t *size_max)
 {
 	struct epf_ntb *ntb = ntb_ndev(ndev);
+	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+	u64 size = ntb->mws_size[idx];
 
 	if (addr_align)
 		*addr_align = SZ_4K;
 
 	if (size_align)
-		*size_align = 1;
+		*size_align = epf_ntb_dma_shares_bar(ntb, barno) ? size : 1;
 
 	if (size_max)
-		*size_max = ntb->mws_size[idx];
+		*size_max = size;
 
 	return 0;
 }
-- 
2.54.0

