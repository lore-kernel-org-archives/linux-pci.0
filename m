Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795437683;
	b=lzxue4+LKTCDmr4Pvnv+bULmGZwZ2iJWWx8eYT8W3pgnc33dKoAR4VLoesbGuxgtHIRR
	 3P8AQ7zW4sI/ZudY5jgMNeePuaJvXgCdC3Q/cbLywu93AYFsDT3+W/p4XeK5kRgmiHiuf
	 2sgqe5C4856inOZX4jEXZms62srvh4q4qSD/YyXqmgXTi8UOGMH0vkJrL1lh+EfUyLRBR
	 W0PIF005BvfVl+0ZqNEIEE31TlQZS/TsdRwxBxG4WJGxjR8bPfEyn6S8POTkDrlw8lDNt
	 folOzTdA0FQc18MJbHxFAvhfAT6YucN5l/c+RP69njmJgscH+k79mZmoTHgOOXVshmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437683;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pmilN6+LxM/ZNl673QOCte689GCQmYAdWDFbQB2dNb8=;
	b=T2Ksbr6ndipL7SapTJem6ZNQ2MWg4LXjznu3eR2RUaxJ9uBAyOS6gFsjgBfqFRh9rPy7
	 aWqWzyNtZFwjkvMYv2qfyux53O0INZN6hLrBrLy4zEOicG45xBH0ak7djsH84WDIhvdLf
	 Dm33rHz6+6aE1eDYqa9nV0pfWKApKvBVvtQxY7KxOWst9zkHLx0lZjh6TNoEDR3xoRsGO
	 5Feqx9azfHusccjz4TxoPvG2emDPqk+UfkP9YJy1i80CYQW7NTCNak762l+uJHw4k8vSE
	 F/jNNXJOHjXlfBk1Qu9psBf11S42vBZxQS4jaKaf+ThsKAVKMo3IAoFeKvcwSEdIfXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ltpgJ06q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.54
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA16606A31A;
	Mon, 23 Nov 2026 12:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FA16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ltpgJ06q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yib/vZX6Rg9ySESlO5NByfiacmAqhm8YDJrEPXE5bE2PKis8NqPKYYsOcmfnLbzISCewDWXrILSSTKTf8fpa+rxsOLPtHIgB8wU6g9mPipVn563pMoR58ywtPeckkvTLKEZEdVY0OFuTfe6PT7OHros5SkdRX28L3GVt3UKEaZkfXwhrPMigTCsfC231/dv60EWlq0Kzi5P45ySQTEg4aL+ZZlEw/lp6UlkPTInGi09JTO29L/Gn+hqedT+74G4RqnUqNUPtypX5j7A/ZwVGy9NhDB3HKeFaD+D+6xzA5tjpeKwi3SSIjpRwOTRbtHRS7kP9wVPQrO5spamE3F7v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmilN6+LxM/ZNl673QOCte689GCQmYAdWDFbQB2dNb8=;
 b=BU4R2/EtHOyMcWFI27UdY4zmEsGWtl+3HWYZKCiKbUMMatyVrPIw4yU+Z7yKq4Sytkh5PpkS7YAzLozMmBxgPg8kSQrRBpfnA50WEL4zC6ZB0FmW+mpfh6P2vo1ijQPMY/okXt57k4lrobUPRZoio1cNtg4kuRQ20vJlaFnRpRYrZt8QNsjcdBJdqKEqw++PhSqFlk8AV5pwVjnAIY9yIJYd5JEY83E4Zy1UaqVno7in5TOZviY4kU7nRxeHgcFvaafvaiprQAme2pvFYOj/l2kEvwdwDENclZl4lT1CZm4VN2FhhAUqMqH1jBBk8zSEKuP67/OVMqr1V/VhVZ6GQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmilN6+LxM/ZNl673QOCte689GCQmYAdWDFbQB2dNb8=;
 b=ltpgJ06q5uMuOKkN/ATmsaBw1AAemaMEQCICX019IOboPypOOaVp45gWLp2h2KcaoXML2ECfrYcE1Rgd25YLdyYWrSVSNdoJ7hrdsAxQCOK30LmBlylxwq4IAf87sO+bJ7UziD0Npkj5FpNGFF4cg23BO9c/YLs3yvGmqBL15EWuttizFqhsxm+2HgwSP4/onuKxeWJaKSPhbAtpdyVPMyw/ar1SWMb5veOBN5wOt5n7KVyULKSAiz10952u6XcEV0RXexWNkAaXZITFBQUwdxjhXjVvD0J/v91XDAdunVG2L/NQePQGOsv2cmcvqXK20TeyiH6xQR3X0RcHJGBzrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by VE1PR04MB7359.eurprd04.prod.outlook.com (2603:10a6:800:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 12:41:17 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 12:41:17 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH] PCI: imx6: Use dev_err_probe() when parsing Root Port nodes
Date: Mon, 23 Nov 2026 14:41:10 +0200
Message-ID: <20261123124110.563397-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::16) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|VE1PR04MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa724dc-6722-44eb-6055-08df495f111c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|19092799006|10067099003|261009223027099003|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261028144727099003|261026140227099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xJZN5U5gmq69AKarW4qJFmqRe4n50F6NmJcEdE0PQ2yuLhc+JTIvfRrj58HtL3fkADxhzN+Z076qCX9VAUmgx52a0sHFxts9RlGa2U91aRUU5V64g519cxIT0rgr7tUWRBP64tE8P0yzh+r95zReJmY0+FLzZ3xUPFnRCEor02vr0fNdd2PqM+P+tdDqBwqagXA8j1DjzM72XBMNDoN9th3LlLgp3MSZEUuJY4iLJeF+hdRahJXXg/NfE44NoTCHFw5k3//3WLVZa6PcI2ZkhUO97KtvvrFF1la6vyMIoxoCVO3PBIYJYdlOz07OYf2bpR6YEbnkjQuO+B9tQtnrx/yeIkCmJVFN6DlXQUxsEPRLZIJbCCC6StWjukZ6qankctb7H7mcwpCvzspFg1Y8qMR8Qfciwl7L52VgMoJkRZjBgT+YNN3imLA8rkO6xfNuEDsnAZ8t2tRkWB/55xGfjGztzgNQZJgvonsE3rYnKWnk+dCFvK0cPT3jEGcyDtg9dlaCL4vaCoehR0P0dsRxWoLsvIG+86r3dwdNglAGhzGGZfUNA3kPxHRqyXCF2u53ByL4NbBOhvZWYhwrwvG2NI8FdVpdGX/0JoZeqO6TUyJMFgcoNjyxZGQa6RJw+NCG+mcclVg6EW4fCEst5Tj4JUbBL7BYKk+zCOpj41hvZLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(19092799006)(10067099003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWo4vSl+c5XpHOtsNUOTjyZfhTokbAu8s2WEXA7oZWViSSvFSHJggKg0A+Qu?=
 =?us-ascii?Q?DSi9+QfWUG/OMmOE4vhIeXqBt2hqci2rvTgyzut3NnUuQ0xCyQPJjpYRtFJw?=
 =?us-ascii?Q?LaVUtxbS6Yg2k8PdwgbEMETn1gFr1Xm0SCUub6FIzxdTXFPZIeoAzJzn081W?=
 =?us-ascii?Q?Jt5WBI59wD7nmFcU29qVb3KyoFU4FsC3aE9mth9LwFUCMGHfq7PbQQdqt4JP?=
 =?us-ascii?Q?5pWVowSKxM/jc4dJ3oRgUvi8LEext3WBOgphVLDWANscXyMIeg8M9c9MwXj1?=
 =?us-ascii?Q?oQSsuLpiBLTOPkWRBj1oiynDDuvf9HgSy0iwpe7bGLPOQQwMWjQPnQqxru3y?=
 =?us-ascii?Q?h6RmWXq19z6Xu5KspoHkqNlTW3I0syXxgc9YO3iXMEmQpmPMuD5gDvBXP96P?=
 =?us-ascii?Q?nrff5wz9uesMEpaT1U9eZC9uPXxcH+T2toAPIUOIDILdOjrsDduP7UQk7mR8?=
 =?us-ascii?Q?KmHtopVpRbDz6CvloD87/n1sGv+cxWpdcwvKN8/9m7vwprBWtCiJdkPFYvcW?=
 =?us-ascii?Q?D25Nz3Eb8VqNjFgmgfOjHttB15WZDHucXklHUHQLF0zetOL4m6n0Qp2oHa4g?=
 =?us-ascii?Q?961/45rEgc12i5GSxYaDa19zGaghAqoGKCzuKB7RnggAbJ8HNEj6RlO10oam?=
 =?us-ascii?Q?xoC1UDFMx7S9TLqbvPRRLV7Luxxkagyd/DTC8zA6jXc9Zh3/iW+GLdDOkHhV?=
 =?us-ascii?Q?pIP/4nHe7HXLvWYWx2GahR4dLdQVvUDJUJ0CkCNYdpxrGJon72Rrbe8VmpnU?=
 =?us-ascii?Q?6gB5Hvw/ZcIwHu14YJRT4h7spYcwthjFU9HyNtQATf6pqDyli6iwxteQuWrg?=
 =?us-ascii?Q?dhDeWNbUeJlb8KH+xux4a4iCdJzrykS2DHReAEiVH+AGrXxYzQn6oFNoveD7?=
 =?us-ascii?Q?qYQWsQwQ9HSD0llWqtl1/musS/XCjgjLRi+ZQ72eFnkOyANlQ1E2fdaHCfeu?=
 =?us-ascii?Q?ObUKuy5L+ufI749C7Ezhv7pBqy9/Im9HGFsCdP8qPXipTCpVa4N/dGn3Je05?=
 =?us-ascii?Q?CChKhKH2oNR7c5rvAPjKRL7tYCsm+8x2or55GfgF22a0xA0aIKs9crTP5Gg2?=
 =?us-ascii?Q?my9dBYBMDcKlp+nNJlYXRjrOnKCK6zMZmpMmAzVRrG3jB/DRAtxGtkcit6g5?=
 =?us-ascii?Q?uYHNAeg8Q9UpWZYD4uLUmLM7OgaEgL4OV93E3l3W/MnVKMldSNDX0zHLU0kk?=
 =?us-ascii?Q?8Xok2uCdpyirNZG7wxeZkY21q2o4hw4Dhw4QShZDM17D9jR4cGhsP3FuDUm2?=
 =?us-ascii?Q?eJyYybRy7pd09jwBKvwnk5EjtIHgvcVLYbpWspS4sNyefgXpKjsbH0qP7nSQ?=
 =?us-ascii?Q?nzAPbHtZyegZEdiwI75VqLSSFKSLm7S1TCMkF2/t0i6u9aJStet+QhgEVZSU?=
 =?us-ascii?Q?QsEaWg1DO97c1BGPlMaaQPXHt0rJNZ6nFEX7EW8KAd1tX0jXuDSs3Ylks/XZ?=
 =?us-ascii?Q?Z7NtXAiMqe9LrjFvnGISeOvC5E4JjwcrmLfoAlUpJsTMPavjNvMJIrQHERnQ?=
 =?us-ascii?Q?n8//wsGsbdh3epzdhkJJFL2HFKERHYqfvr3b8Z5f+jLVL2HcXjTYkEexqcJ2?=
 =?us-ascii?Q?fJUgSoaGCfv5N4SU7LybPXohPlG4DbBh8nEZ+uwq2CDZRcdhPcVQeBMGdv+W?=
 =?us-ascii?Q?hfFSQRZfrh2sFNeQJmDrrOUoquDDWg1tVQi5Ws1jjbLnup014caIkapYtHgv?=
 =?us-ascii?Q?crlKZImHIgGBIK/aIsoXOexVZzOWNuviZeYfq25hKa9/uK+vUMcbTYebatO/?=
 =?us-ascii?Q?8OaernbhbQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa724dc-6722-44eb-6055-08df495f111c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 12:41:16.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8xTZvrcdmMOSFrCsndFBSM0U/zIb2n9iw3eDnefzvCzTETAeRPbAvViQnRuNnD0Ruhc92c2DBWsIPespiIOrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7359

pci_host_common_parse_ports() returns -EPROBE_DEFER when the PERST#
GPIO of a Root Port node is provided by a GPIO controller that has not
probed yet, e.g. an I2C GPIO expander. imx_pcie_host_init() logs this
at error level on every probe attempt:

  imx6q-pcie 4c300000.pcie: Failed to parse Root Port nodes: -517

Probe deferral is expected and not an error, but these messages flood
the kernel log during boot on boards like the i.MX95 19x19 EVK.

Use dev_err_probe() so that deferral is only recorded as the deferred
probe reason, while other errors are still reported.

Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 865438ffde879..2a7f09630d14c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1395,10 +1395,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 	if (bridge && list_empty(&bridge->ports)) {
 		/* Parse Root Port nodes if present */
 		ret = pci_host_common_parse_ports(dev, bridge);
-		if (ret) {
-			dev_err(dev, "Failed to parse Root Port nodes: %d\n", ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to parse Root Port nodes\n");
 
 		/* Fall back to legacy binding for DT backwards compatibility */
 		if (!imx_pcie_perst_found(bridge)) {

base-commit: 7bf2db752515a9020b310984ae3bce1089cfdf20
-- 
2.53.0

