Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD628FFF6;
	Tue, 10 Mar 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773129225; cv=fail; b=MKMCCJqwbPb51pS92s/WjKRc2ztuiqhGNMTcJhHffe0OUpx14rvQYfE4YKfwC67kAbTJNW+C0GdFZZuAdFhUHA02VcnJ+R42pMu8n+YkRNc7FdqQpRE9S2pAbzJnd3PgDGzmjq0Uf1fYka/MqcenatqHDWtMTmqXYdnXxx3Nxhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773129225; c=relaxed/simple;
	bh=H4PE4jBI6v8kwlyDa0q47r1qhH/BWgDtQVybNlWd7W0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=chKhzPOxQfICt5h0PGX4UOWBu49InSsyDtQGQDoXHeDMsb4hzr7J3eksoLM2JWjkeKuLfWlKgJMOukTni13VCHRnTHrrl0we32cqGFWqwDttuuL3DAd+b17fquq3XWfcWkUemQ/6ErvjQXKHhsus4KldzO6dhlHFuYyWAsbocoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M6uP9Zmq; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6uP9Zmq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMpIE8bP5h4kocLEDOAbAmDp2eb3UtBofQqaWMUlh6kqcRkWB03yLLebqS5BMIwn4qwI+JwJTtGih9jpGx8BjE48cVh820BhH4iTrtktn9rxMDZNLH3Fevto7S89KIAPXWwQ6UKpIjdpH9k6Fid2biICY9OGrfXUSh1/V5CTer0rWaYy39FPEYMmZCmDJ+3x2aqIciKTLrW/4JawdgbMqLlaT5NrwCIu6gqzYfgxmGYBiSNNMPOhx7w8TPbo7R0tVNkxiIBYaqVBMzIOaYDnNUxh8H8L17sst4qEH/xwOSRKo+a4t2VHQY43hujt/avcbunh484DPfD5EEwCnBLGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTzcrV66O5Mfx8Lw6ZZDaB1Jr8Sdpu7o14mcEIlQTik=;
 b=vFm3v6g9bgvHv4VyDKKNGa7pOG24d5qI7JRbDYqNFl/7lxAGUhuIDMA8roBiqfMwGI6O6zv00cYbGiYmYXH1wVGZ4wWfhERAUwpld+eT4eDc1MqDmeeVhTF3yEdFQcUJEEbXySLxiRbtHemlEpCUieqMUaLWLHvAt+zm6nQ9Z6h6jh7MpwdKNH7SRaB5kxJbAxV8RzN9dQHiCwGh6xUTpLxYfCrwq//pNxlCcF+Pz8kXS++/i0GsvOq+5TkxWX+wHizTRGbUxoBFSK3rAlgc79BsDw96NVwf+pflSceTg0nl2y+N50aL5QfmJ+LZyfMMdALFBCeOVTXn/rD1KIXEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTzcrV66O5Mfx8Lw6ZZDaB1Jr8Sdpu7o14mcEIlQTik=;
 b=M6uP9Zmq8GKmlxeOcS7nBnTUi48oj+T9kl3HSvlAXcvngO6KpnvakWi0wQMjLjlquc98C6Dre2iyQ1Cz9R5xBletlKv0/TH4Jm6EG0kjUvldcwDmM55lqgQY+xnmaN+W0DwGz4K3kC8pC/yN1x6WBOPCNOebO8AwkD2fOqZZP9mFOueBo2lfoFBZTsS7GmhSy3LCZE97l+WBqmginMnmgqEEwdRfl0E/WM3iBewAkFPdxQb+lD8ifr2/m0dw5d8dPDIHTA/zDQKn/lRDkXIv4qydQUNk5PnLb3Dn89DtVgk6aBg8q9UDb/3sbK+5t/itcCdJrA6tS1gYfw9T1Ngs+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8678.eurprd04.prod.outlook.com (2603:10a6:10:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 07:53:39 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 07:53:39 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add i.MX943 PCIe supports
Date: Tue, 10 Mar 2026 15:54:55 +0800
Message-Id: <20260310075459.726495-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU2PR04MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab64608-350e-4ce6-2988-08de7e7a2476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	0jU96SdgokfzVR7aozASEGkUeJ0SBjXqjZOuSI+HhoIC4WgSlVTctf4vQYXRekhFK7s/bDdcmBBX4nAkCnWkj2Kxt3AOMnnWtkP5aIqB6ASsEi+ZaAQuc/Rp6Wb4QYISalYpjV+vD6R8eZkb04aYj48PQHiME1W6Ac0Z+EsP2j2DhYgzbC5veQc4IXh42QJJ1SQM4c2e+iHKJgM3x0BrwPwIYihkXHHl4eZvUdymKF/J0HBXHIRQqRizwGkk8VFNxdGq7xLQM+Aoino0Zpgv9SKxnGXYeCne80Tcb2v5a6oUp1VnAbE/XbiPz5o739LUW5uhOAgvUpUM7XLdL9LUYYBfShVGyNRRpTHhU/BhFLOahWWtPfPr9mfCw+EK80EZnrMs1JoCe+X9QYtdZAwrpz2M50U517hziA5X6LPUrvP1c+yPA9J4OB+dDoW3aHOhU7AdvLrG0vwFz2A048iT9RSUjwgGc0qEEVPusIqHfWWyvAHoTx3OpCCWhqR36tgoSh0BVBhII16D6eVAbx5Nf/UbXQJMXkP2FPf4U7dmBJocpoJB0jgMXxmCDlBs/fq+WrOIHLJbBOHEOvyCgPRLhktom2ORlEbH/fIBo6Q7Uo9J5ePgPXJ399Tv774C26RlOmm4Dbuw7dfpvh2ckHWzVmWcWi32imuVIrTjGq2MAT9hnzRUfwNyq4FTyxw+ec/LzL/qLKvt12fe4pctL5UqYwzALy8douUGjzI7c3EZXD8Ob0SXOCQTkQfABKGLI62YvYfNy3EnN/2RvBw9sB8cFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?REdofTAJh2dnn1YSKLx3CPnn+qCdC4qM3xOM8+BfvqCCb4k/62gtEdvT5Zy/?=
 =?us-ascii?Q?ivWfdsSTfxWB/+plyvF2BPdRSbYKevHct0GPParwpp/yBb2nbzSYdp6IPJiG?=
 =?us-ascii?Q?eWdpH0voSDRxSgO6UP1kt1Ax+1rw7KmgDDq7rkE/IDFrsfK/mk4/nHIhQmT+?=
 =?us-ascii?Q?6OtJlfytKQURxZ2X4yBoJ0sklXG4z9nZMmqNnC5JNPiHKuRKDHBx3L3KJEkf?=
 =?us-ascii?Q?oy0N9ocwl0SPZ5YLwrGy+5966cczyv/z8w3DZ8tVNVbr9chOln03DVgQjt2S?=
 =?us-ascii?Q?T/Me0y5sQPcnL7T/O0Je9o5clsYnUWmAZsqSBk1OC/UxR1w9mZlOsKCkX5MB?=
 =?us-ascii?Q?g3kcZGYfKW/rmqAWUwYJbXgOgnKPwZJJCV6p2LLCqoDOio3yJqRkC8Uozl/a?=
 =?us-ascii?Q?vEpUTynJQO7T8l5dEs7ckwW/B+lkjpVKVFAvjEXpbxMy/SUuDB7sLFYTYYe0?=
 =?us-ascii?Q?S0cGEh1dAoNKCn9M8roCDh2ilLlUACNIU6WmkKWzSj8h4nFfjUa17Cwi6ngr?=
 =?us-ascii?Q?Z/C+4ty6OKATKIJtsoBcGEZ6b3urRn0QbgPYCDX28Bp9neBGcArgeO/uW9RQ?=
 =?us-ascii?Q?9PO3soe2DYIiAKJhRIsGMSIYfNmkis6e93Rt0UdpRP1cLVRBfKOhzR/jtpxU?=
 =?us-ascii?Q?1o6s5/r/UoGe651eje3fY7XiS/LeVDcEbcIFZ1zGbd1dP169vkCbs+MNRVTz?=
 =?us-ascii?Q?qJ4MwJpMEINtfSscPdg91M+6RarU4QWtaUN6AzAnOJ/uYDXS2SLS6QrAJ00r?=
 =?us-ascii?Q?WU3k1UGnph6vTHVztKJ0HYigmrwfEEdkRZwVUemb/Mi1ONa0FbWZmOau0rXv?=
 =?us-ascii?Q?8bqCa6oL/KmwItAYuh/zyGiNKY/gkmtpnW4F0VwlXsrANev0osVtWSg3mZp/?=
 =?us-ascii?Q?snNMqDB9SUx0tlZn13+/RDHXRrZWZsJc9qbu4TT7IryqULBONYtANRplJeYX?=
 =?us-ascii?Q?58T7e5RmSc/bXhM/9WqVi1ZJv+1rZzG1ZgCJHB/glzExOjeSfHQKTu+EQWCE?=
 =?us-ascii?Q?q9aKeD9TYUKql/nTSQKEFxIu3h6lBVgShOs3ZSW6+pdwgihBxoHHejEW8XxW?=
 =?us-ascii?Q?sbQsGPLqkIyhpIDeUfnP2hFCTBIw+OmFokQ5yZbBj7qGIxfab8aN3/RRryTG?=
 =?us-ascii?Q?2P184u0ubEDaA6G+6382g6exdFx/tPZc8BqxpVfhQ8Iazb9wqM3qVyAJuM0z?=
 =?us-ascii?Q?LqFXk6fJT/o5wMoUcdonTcAzoNd2FTl89XO4V2k1OcJNu6269bcCGYfemQh0?=
 =?us-ascii?Q?PtCGrZ1MUXP4iPpevoJTpqN3GPZkbLb1YDvch7QmYICZpAp50IEvZo3rvd/H?=
 =?us-ascii?Q?fcCnXtL5xp5Vaz/X0V7Y+oeK3aTVoHnGn4eInasxLiDEnDkNMP3pj07K+J3S?=
 =?us-ascii?Q?fWLH9btcLWwyEUwUL130XTWwy5kLE1zn/bs2wPWH+hzXgydHxrSEki4bw1px?=
 =?us-ascii?Q?7KgmdkVC7H2ro2FQzikEj55qv8HbS9msNsHdOrt09ObE6XRMGuRMwTJX9nLX?=
 =?us-ascii?Q?da44cBxoWMl4fWlOns3xBGTiInr8HiK6cclPkF4/Izo8TR12z9OTge52CyHb?=
 =?us-ascii?Q?1tbDbLrxQJBB8XF0KbFGgUrNmfnVJrgj696/Mtyncp/lzpMwCUlcYpzD4Sqa?=
 =?us-ascii?Q?YN/ViD+YCxu4O87G/YyAIRNIc3y7ZrNPrbcyu70NeU00z1hRe3nUvjm8JgdI?=
 =?us-ascii?Q?ymkVolq6m7luy6tZZH56uBEfvKRpBPmnWTj0FUDd+4pqFrPMAqcTmHMO0JOk?=
 =?us-ascii?Q?MqjQx4pg4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab64608-350e-4ce6-2988-08de7e7a2476
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:53:39.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nk4RB5jvteiFR9Pkyv2G0adqGLv0rW95R12gE3eZfWyLUUXR1WIQlsvpT0RR9Rul8cI/Uy1DVr9JNZOdj5Ob7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8678

This patch-set adds i.MX943 PCIe supports on EVK board. Please pay
attention to that it relies on the patch-set[1], and the PCIe1 port on
the EVK board relies on the [2].

Both of them are included in the v7.0 kernel.
[1] https://lore.kernel.org/imx/176649331066.523506.9443864112044699350.b4-ty@kernel.org/
[2] https://lore.kernel.org/imx/inzg46tc2fwsajxq4vzdyuiq7krzy6xtcg2mjaieninz7zsmgm@mtdjr4tuegpq/

Changes in v4:
- Add missing space after comma or '='.
- Remove 'fsl,max-link-speed = <3>;' in dts, since it's not required anymore.

Changes in v3:
- Fix build warning in the dtbs_check.

Changes in v2:
- Refine the nodes sequence refer to Frank's comments.
- Rely on [3], and remove the duplacated codes mentioned by Sherry.
[3] https://patchwork.kernel.org/project/imx/patch/20260204022306.2372889-1-sherry.sun@nxp.com/

[PATCH v4 1/4] dt-bindings: PCI: pci-imx6: Change maxItems of clocks
[PATCH v4 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
[PATCH v4 3/4] arm64: dts: imx943: add pcie1 and pcie1-ep supports
[PATCH v4 4/4] arm64: dts: imx943-evk: Add pcie[0,1] and pcie-ep[0,1]

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  4 ++--
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml        |  3 ++-
arch/arm64/boot/dts/freescale/Makefile                           |  4 ++++
arch/arm64/boot/dts/freescale/imx94.dtsi                         | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943-evk.dts                     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
arch/arm64/boot/dts/freescale/imx943.dtsi                        | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
6 files changed, 249 insertions(+), 3 deletions(-)

