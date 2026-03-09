Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012039.outbound.protection.outlook.com [52.101.66.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A141324D;
	Mon,  9 Mar 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086066; cv=fail; b=ZxweoCQcMpYEeRcEASLGkQimGtnLswbyynGu1hYpnTNzahUm5eyNcefuMwB1QEeOpQM7/dY0jRpoe4gdmdyzZ49Nx5nJ1zw8mbpI7ERL21JDpehYuolOkhfxcQwqggxZ4IFOC6cUXTFLOb6C/KCO3U/pB1y8jhnLjslP8jgfn78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086066; c=relaxed/simple;
	bh=yu5xPuE5kTvz9K5zz2Oh0xRwLeNisQrIqQa3AFXwMLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZ1+w/CDi99AU2uzpGgQdD7fOx9dKz4GXoHTDgrSY4iH8u4Il+GZyUK8ttv71APozwsdt8Xz5mAif6qEopo3xcs0DDIEfrvE3f+WZcpjF4abCm0NujgBYlohSV+S9wgKzM1XzNrPaV3X6eFnQzJTip/+DclTyVAyPIcWAEOrdiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XascAQJy; arc=fail smtp.client-ip=52.101.66.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XascAQJy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVCxrGWkohydwiSTT7uRSNrNosyGyjQkQi2Q9ArhxnNBiZEokn62Vg+fxxf3DD4WTAsgyG5+uKB7zG4qm9r4toA6E1v+q0cHRbi9ITvtWhpf5WjZY01Dl0heU7VwlzFhACWSvgrHJQVvlUwSr1oKw7Yrke1QsXBDiahDpXRDB7maMyQoT0BoZm1ZXAXFy3FqOQzRyqudqJz1qhiYAenAM3C1gPM/vuhNURSoU5okfcft4GkvlTJbQgssTPWHg0NfR7G/8ewurpamxpLmd05jNv7MtMgWWRQ8PJdBBGwLFQbr7Tx9lrJ9IKTbqmbeNMh5GFxHFrXGwzL+oz/ieaup8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6F8ziQ78pIKh6J8274tLVZvRKJ7WYdWnbWWF+Q+Cp8=;
 b=qaGT6wO0hCEpxCyu0E2JjNRY8uOy3d3LvQsjvHxFSj8pr1Nc7iZZEFLCdIQE8UdlAsdrI8mgqOmhT3NF3/0uFmE6v/2OoKQEk4qz19NefQD2Qs1GkTbiB78tfxNqczcgXi0QuXB98KDDKU6VZQKvIGbH6J0SotXF+mrQTCmHZdsSdKQSJ/oorKI0i6L0BvfmWcddMTrAYdTPjTfq7cKh4mxbC9flRvuxuSgAoUhOmnFvff+mV2R0rVCndA8nnTtt8uMPmIRBfF2MxGG41jtvNqxJHIhwbBRQL17Vy/zA5mIXcYxUX38FkHthTB9Ig/8FVaTGVdJ3QEomo6svBAHU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6F8ziQ78pIKh6J8274tLVZvRKJ7WYdWnbWWF+Q+Cp8=;
 b=XascAQJyToiYcnV6JMiCH6m+LQaetLpBUzocrbPKrGgKxn6pU85WOcgpOozITTsXCjKWXs1QINDr0YsZuK+vlTzSd/JSo0uBi1QSkGo2+uWi8xplBjprM8ZzsqjodotkDUWN5FKSJyvcU4c0BYcdS8P0OB20LJzhSmqTO62PPI1eVJP7Xj8FnncnvehrtUd1uWmzAgvh51wFqAyRMRKL6sYR0bVtmkew+zOHauvLlSXz0KIAdHMs3odX6/Zd7JL5wkagoRpQWbZuwmlcEY9HJllnbX3hBeZxK8mqElgISo5C42MnonlHesEXMbL8dBkLIJ99G+qXGE9IsQJqOsPTVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by AS4PR04MB9289.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 19:54:22 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9678.020; Mon, 9 Mar 2026
 19:54:18 +0000
From: Frank Li <Frank.Li@nxp.com>
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: imx94: add pcie0 and pcie0-ep supports
Date: Mon,  9 Mar 2026 15:54:05 -0400
Message-ID: <20260309195406.1787254-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309084431.3015463-3-hongxing.zhu@nxp.com>
References: <20260309084431.3015463-3-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:510:325::25) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|AS4PR04MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cecae9-d517-4a10-7702-08de7e15a640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	p5RwUdyB+SLC0dQQQSagkvB3PYJTkcRrY41VJvQbnvDFfvidyoqpSoCTJuIp1eBNjYTwE9UcqrHqnhEVgK3yZ7vfpTqrh018PN3LT95UAB00gbjJXkG8s6e7Kzbk+hB/1scK6fzh4ov31ctkcVSvnAsv6TvXkT0ARHaCCOJ+oMPgK4yIk711wWRi3aoRX2uMxQh4TrcSxpv1s0Yc++Op7ax896JtE96WeBRUJwxb1ewSvtV3kqm5qZ/g3tSD8q4MsqJLf8n8y+GPeKxgJTDKNY8wAtwKgAw69GAhrywHSam+M6siKcIIPooTfY4pzORrNebpgoBf42iMce5Rqn/6HzSR1GcihgbHz4ESsigzCr+cK9M1Xdx+6wTWg8VzKajVf20QUCFWwJq5+kn8suOuTEjQwmXrUqYldpVeoUjgnNVeXtAzYCtqC5ydTnt41G4ox4abRvj+8RtXAfaCx/PHVu5iOiEFmJbqyB/VrrSV/LIJv6K4fyDKxi7md4uOt4ku1V2zs4YNguw9h2C41sWQs1od1Wk9LKtAwWi1OWgq2Zv7h3oF+uOzW84u71I0aLUhKPZEq/k022pzQBysHtpr86AJcUsD5IajtbWrOEzNz+0ictiaxl1/Xv9JLaGmyYcWx1IoAxwqB9uQiWDO9JzfqaKUEwkxYwEUQpJAALaRSqFUyMt2hdCyWIAvHeYi60QPsRi6iBDeMXRBGI1fBYgCbLCvg0OWrVx6f5mZvJah4HLqZ7fi4VoIuSv4V1aPwEkfRof1EdsM1Z1uHTUSP4PuKBbM3qws0N2Lx/ibh/CFPabPGCaGYU1CD3wdV7C/GFSu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NdG7XaA5ZJum6ib+j1/e5ek/COrUYnMvxgY0IZgDywik28kEt1JXOBWhdewG?=
 =?us-ascii?Q?fARJxftNFMp4y4NqGVmj44whgfR+RiiaQSVKsP4T2twQvGWbdKuq4bLulTPh?=
 =?us-ascii?Q?Y1srx+kmOLb5ab/VAuAllKHns6NTNEgZQ3HnPEvCv/8zE9sCOTkoMlO9kLja?=
 =?us-ascii?Q?3Wj2cNQWiIE5e/OX+CcU7fYjKHaMcIbhqq0K6/39vv7GZoEpRSyXFlKL/1se?=
 =?us-ascii?Q?5AVJTHyz8ZR08yy6r8FSh/mtrOTCIR1D6kXSP39cCMN4Vo+IIlkU8UdBcryl?=
 =?us-ascii?Q?XvBfxMsSac/dT2mBP8HxdW1utjbxhDxJfpeUkGQ+s/lC9P73jizhU/OtyOdM?=
 =?us-ascii?Q?WHj7CnrSynKUYaC/1GAFa96CAbHC71CNqjEuKogHbjPnxeT6trqlq2u/K0VJ?=
 =?us-ascii?Q?a73i00sSgu7LtIwVGISPyKJFdZYZfq7cG+1CgVNlJV64rWXkqHgTGfrP8fsU?=
 =?us-ascii?Q?2I7gi0El1hTxb8PCOo0IOPj6Cj/nbiuuXB10yQ2mjhWL8P+uHliLSvBNSnNT?=
 =?us-ascii?Q?3nIyfhArQr0b8gByTVVgsMy1LEBuH7oo7AoSOV0NC0ZMrGx6iq4VWYp9v8p/?=
 =?us-ascii?Q?HHO5TpNTPRR0TEbyh5334L+00EX0jQ7dsC1o9VlcI68hIX+vfTeOI0ZYlb3B?=
 =?us-ascii?Q?F2sQ4CIg0YLh6eCJmFLm44oX06rKuzpNUbGyCIOgDyjkLV7x0+qzT9DCa7pN?=
 =?us-ascii?Q?hlgugcc48BrFCr+Z3T4ZJ0JP31SzcQsxKYtd070jQbLnihnAa2PLinBXNsdo?=
 =?us-ascii?Q?nciNMMiiw8OiU75CbEGrIWzkfGIzU3MihK8P28Hczs1dLvR7G7ALcwBZTe9A?=
 =?us-ascii?Q?9X7LGbzGcz25DbszTu8KNz6gxpPaam2J5b07M9CBPgZ/8Rd9pWPvQFUFk3dL?=
 =?us-ascii?Q?zMg5j72b3RvnUEVBZKKrrlA0Ai9ZvVuqQu65ONLLpdMWsvsOhyRjSPOoSGjH?=
 =?us-ascii?Q?dJeOYb1Mv7BWwv/ePHRxviloCeX3iT3g69obQ5ULebCf9mzT8/r3L9HOy5Og?=
 =?us-ascii?Q?TcD4jTTKW/VftZs7STcNz/JLyQX3+6xtDXP/ojGZ3T4+zV2ZAb3Op1Fx/9r7?=
 =?us-ascii?Q?uMkmXrJm5QTsXyf/ITKJOSn114+1K5v+OvFipLDgTsyhVBMBNLGhIesrEPYT?=
 =?us-ascii?Q?D8mgskRuF3nRFgvuHfaEmEWY6kjB4W8vNIK/xo2m6iiy4ct7oGzCkvnZrHuJ?=
 =?us-ascii?Q?OHzGAPm+RkCAIKtqKLBpBh23HPEnW5XwhfRAzJTjm8ZCepW8jRvlQzidwCKN?=
 =?us-ascii?Q?UaTUtTyi82zz49kGZyQd68sy20TpS+mfoP6A9ugQ+iGeDGavG6zRYI06xHaN?=
 =?us-ascii?Q?DZ9yuCbVFBntCQHnvFxu9C0RqBkUolEo1XS7LN4aPv6+z74HJHLowO+ebp96?=
 =?us-ascii?Q?7JEDN8gsW09VmFviCbkGvhe+ovTzzKrXPjB35nW1YgIney94OOn7pS9LrS0z?=
 =?us-ascii?Q?Y+2TiT7DbEz3/kIyRJOrRo8ZuVYgndfa8LUVNthx34LImvEE7MeGy8veOmuW?=
 =?us-ascii?Q?jdUWkqytad+dx8O/QM7lHn7OCUaOZ+pJjQWIfzEOg1iLl8dP8/UnzR/n+++g?=
 =?us-ascii?Q?4CCKK4Kmy+uhM4Sb2qvhZz5RlVr9shPQjerYVtBuJoC0ccHKI+BIyjORDpwu?=
 =?us-ascii?Q?AilZOTQXH7XGmIPqM1nKZ5ANfz09U1X7t9DKBLf0p3VoZQg5AZgi/HdvxL+/?=
 =?us-ascii?Q?2qwkHb6nlBcCN1cQboNf9UjITgUvCSXsWr5YC5mF/yTlo1vK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cecae9-d517-4a10-7702-08de7e15a640
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:54:18.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDU+NcuN67IBP3USuo1wHbbZdw5FC5moZ42DK+SL0oK+sxwSXNe9qHz0horLaVu/38BHw3BvzabFUUnaGNeteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9289

From: Frank Li (AI-BOT) <frank.li@nxp.com>

> +			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,

AI: Missing space after '='. Should be "assigned-clocks = <&scmi_clk".


> +			reg-names = "dbi","atu", "dbi2", "app", "dma", "addr_space";

AI: Missing space after comma in "dbi","atu". Should be "dbi", "atu".

> +			assigned-clocks =<&scmi_clk IMX94_CLK_HSIOPLL_VCO>,

AI: Missing space after '=' again.

Frank
