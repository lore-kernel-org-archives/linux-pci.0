Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011045.outbound.protection.outlook.com [52.101.65.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A21E5201;
	Mon, 29 Jun 2026 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749754; cv=fail; b=lFkFulXNNqohyXkCxiMUiewIgZmfqwthX3XqQjfMXPOs1KerhXN/sf36IN8gUDD8SVeUUuZENJxvGM3FKy6kZlfOo0BZNV3ffRts18OU5ciW5U1TQTu1DRpT8pJB4Mz66kD7PyUlR8hKwgrBEtR6Knw6Kqc2jTaONBgx60hXk18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749754; c=relaxed/simple;
	bh=T6i7dqrliIkIIP7s3RjPP/rT6mde8m/kls/nyqfWDew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mr8Hl5hRXprCCosSFMUZIxjhlZzPigtSzdDUatlQMKwbhFsH8DY+POvu4c5QmIMnEdbh84e3xAlWXKOWhSJySw8m60ujQF14ddssUcxYEPHA/PCKHDwrsTFb78rAoFxo+lKqnm5dd8YIpTnE9OjYJyzLD0kij/Z4+0tzKocw4N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wrh+EvFw; arc=fail smtp.client-ip=52.101.65.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wrh+EvFw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTJ60es+rlcmUJiJvlOFTwhiCc3vcxwrh7VJBFHgOyR6lpoDXNN7W/z65BC8d4V2XRwnZSX+qEtR5vbGJoLf6qkSHBF8J0HRlwUgXg4mWoZZQh/56Ehg7d7Sh7MBgzRYPBXGHoidgv7JOTmYeqToU1O4PZb0DfiFSVFumZvquILjjTmsMwSYUzinm7TByJs3IfOxzQ5KcXDmj5NYG9hHyYQ9M/yKB7I6fCKE/CQSLeBE2MSmDcrJ1acFwHw621Bvn0naFD5/Irra6I5zescw1e1k3FUuJnqujFydtI8z93OCC33uAqX3b972KDhAtsOAnhQFvRy7ncxRiHzSi+hvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNYWBSCzCV6ZIcvqI2Ren8adTaO+TYmBuxo5mXmrfyU=;
 b=aiymn8Ypjj+JXutbelz6iP7n7Cj3diwmzu3BPcUSJxVvnxLsVqAXgAPbpwsmLBzSkRhu6jpBmPymS8uzJvrMgmi+8cabWQ6vRQvkFIwxlzckkI3N25PBhq6DgCi+kcs/Xl/McYQz8kOBAyfvNNC66SqoWPMY7ncbHdhH660Xq91I02N4podLG3cA9mv5KYAezYuKaebrf3gE3K0dYQDDfCMd8QxOvxG1WI6xcnECQ2OadBKWlEmDGEMErib7+aqfhYgUHv/UeEx+vhbQ0aeX/bxInJ1OrSj1QOatXYsFnGOA8fSbr66Rl16sOooA5yRfWfl7tRXoPGLhRnYQERXJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNYWBSCzCV6ZIcvqI2Ren8adTaO+TYmBuxo5mXmrfyU=;
 b=Wrh+EvFwOvlPjfYMNWrk5FM1xXMzJKEBPxS9C6IX0valPx/9Nsl36wOQGOjjLgUXw/vDp2LHIrqt/Hj305HudZu82c9Zz4i/XBbWjPKJYPaJwDwhk4oHNlnxvrjq2opsgAIDIXInFwCUmQE1pTwJJm76uqeJVWC7nm/9Ao1HVTdZ8UJU74yWNzeJ0X9hlH6ETHYJw6pvv8JlTFM2yFda6ItnuRfAvYm6ekteTi/JXPlQB+k7T6HAqdwpkCrw5S5BRn5FG2meWK+j4dsOI6nmv+0ijLEpaTKeh761CLBkxfHW7NkadSipyM3LR/IVbDNr9fIC2vXPHVeZmSwQZqEZ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 16:15:50 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 29 Jun 2026
 16:15:50 +0000
From: Frank.Li@oss.nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	"Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: (subset) [PATCH V3 0/8] PCI: imx6: Integrate pwrctrl API and update device trees
Date: Mon, 29 Jun 2026 12:15:41 -0400
Message-ID: <178274972426.2272292.10343813000676557857.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:130::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: e577f340-db2f-4092-7832-08ded5f9af7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|19092799006|1800799024|22082099003|18002099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	Fo7GAcMpJxYmelHI7ne0qKigxxLeAqcSCtYAZAJEn+0fa9puaYAa2nzDLrSubCb/OT0o2TJgmBEu9h+aa2f9YhcSX+MvHa9zgVUndgbJxGPdIKs/n6GUw05EgdyA4QsO8kP3xxXZ/3qp5IAQqBJdK27D/Asww00elYBr/qNvbWvLYTFdlJHxzM0+uoon2kahPDnBY4LYRr3Sd7eB3p2HB2nQH5N8MTxWG8V4bbm7yRwH6eCkJcbVA/ldV0WEETReImveS2hIO3biTInOpVHZySlb0ubtP3U2gfuKtCKxC3AvNOzTCwADAWTnS+VE7AFXn3ujxKyMMW5K8IElVGDj6z4EKrZN4WOl1nSamTUMEIOJCiRQccZ4AINIwnURuOc+Jc/anj1fojbTaK0wctNwoiZdCeaRGFqIK8xD5KoRe4MBzRlnZid5fOiiiSuoQqGWv4TPZcorfOA9Bak05gHqGni+ZA09mVFZemHYKhE0jLIWPU9sg5utBZLJUyC42pQEU2OM98eMF4TjO7FlVKOzE79A/LesC6KLN2M2AdfEiFtqlr3+obcXJ/sF9v3sv7+HHPXIOzj2+t8eCsbFYr7lrDP4LB+qhaD3GdbQNmyba2lezj6zZHrIJnOjqmHIWvQbQq7U5rdqrq3dEFFC0PMe8tZjX6pld1mxU5RmKxDccv+uGEUk40p4ApMN5ckPcwEmy9dS5y9BisWOTj/YTSpsLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHFRVWpLdkZFekZEbS9OTWpHZEZ5czZ3ZEpQSFVtUXVua0tuZ0VqQnI0U3Bx?=
 =?utf-8?B?Q0J6bXVrSDEyNUMxU1dMVzZqK1RYaEVEbkI0WGZYMjhMcU1NMkFtdHBiV0pH?=
 =?utf-8?B?WG9USCtxc1l3d2hobUlvblFqemFZakxzMVNqVnJ1dlRlOUFHVnVDWnMxVzFS?=
 =?utf-8?B?SmtNLzJPOUlQdjFHMnFDVlJFelV4UmVJQmJNUmpvMG4yd0ZqcEo0cjdzcGxU?=
 =?utf-8?B?U0xRTnZwcG4waC94RHNjZXFycEplb21kNEt0KzZBVlREd29EQ0FjQ1JLK3ZP?=
 =?utf-8?B?WXlCU2VWZzV0Njc0T3hxbU1YbTBPREg1VUFUSjZYUXo5YnhQcVJpVGhrQ0ZR?=
 =?utf-8?B?SENUdUkzSEFuQzB3cTJjbm9rN2t2eHZLK0xxT0NWdHNkTTM2UUwxMUlqTTA5?=
 =?utf-8?B?dEdKT0NKbXNIRVJjaWZxMTZIME1aQnovd2I4d2VFNmwxbUlNWkFIMXlhLzNa?=
 =?utf-8?B?eXRQM0xZK0UwcThkS1oweVhKTjhBM2tpbFBZMFBrZzl1Y010K2ZaWGdYb0ho?=
 =?utf-8?B?RERZYTczcHBTSWRkQjE0bEo4eEtiYml6RHRQeitOZmQwaU1pV3JQcHBJVkd4?=
 =?utf-8?B?b3ZUb0FMa0JMSC9tNTVuL2lNV3YrNWxFR09JOUtENDN5bVhWYXNYYUdyd1FR?=
 =?utf-8?B?MzIxWmNZbFFXZW9HQ1ZvaC94UmNuS21YRGFRSzhQM1pvMWtGeklTdWNQODNK?=
 =?utf-8?B?NzRTYnlJdEJ3TEpwTkUycjR3MzZJT0tBdmJuVmdLdStiSXUzdXhDUGw2VGF1?=
 =?utf-8?B?MUhWYjdNZXBmMjMwWUt1cHhTNnFPS0pJZmI1MVRqa05PTmt5WEtSSG1NSHVv?=
 =?utf-8?B?K1M1c0F4RHNweDY0V3dKSkEzZzc2QXB1MXd2YzJ6WElxSm41T1Nsc3FmNFIv?=
 =?utf-8?B?L3hLdzlQbXZiWDI1UnFVQzd0VDVMRW1tQUxHZWU1UGJsU1h6S08yOXZDZWdE?=
 =?utf-8?B?NXZBekszRSt5NHJtbS9mZSs0TWpHNmFaZFBjV0tWeWhMTTRLWHhSSmw1Uk5p?=
 =?utf-8?B?alBXRitYRXVRUGZzUzl1UTRIU1VHY3BSMDlWYlRLQkZDY2RiZWdqcWJUYU5X?=
 =?utf-8?B?THYyUTBEQkI3Zzc1VkNTR2crZzA5ZW9TOWZDS3VWYjVNelMrRGpMRHBZRVI1?=
 =?utf-8?B?QXkzT3p1bmlTYjdudFlIMkZCMG1VVitzeUpKMFhiT0wvWUZPMDM5cTVKZ2ZP?=
 =?utf-8?B?cEkzNWlCNEQwWFVXSHJHSDJoUWF5Ri9QM0pJVDExekZSdCs0dG4zSHdQRC9a?=
 =?utf-8?B?eUpzaUlFR3NJQlhaOHhlVTRCOHBkaFh5bGJuRytrdDhGdzhCeUQxM2oyemk4?=
 =?utf-8?B?MTlEWXRORm5TaytHaUJCU2NGK1NJNGMzaEQxaHMyQXplV0EwS2xiZi90UjNR?=
 =?utf-8?B?WXNlUGY5WGp2TDlXWWtSdS9rV3lwTm5hRFB4a3BPckVVc212KzB2cS9FSlNM?=
 =?utf-8?B?RkNYQk4waGVCTnJDWlFDK1RkRDJnNU1IR3hTbjkvbWp5MUY0bFpJMXM3WnFQ?=
 =?utf-8?B?MDhZR21LKy9oMmlvQStHLzJWSHlCckxkYjdvSHY1YWZ6WHA3NDF0V3ZKU2Fu?=
 =?utf-8?B?NDRPRXpwVTlJQWRKR2daV3hpakgvVDV6cWFSa3pjRjlENGh3QStrWVEzSFhn?=
 =?utf-8?B?QXR4R3JkYnNuMkVLWWkyZnczSWkwNndEVkJXVVMrMlBIbkNxNkpuWnVDSUNk?=
 =?utf-8?B?RTJvV29lb3R6SzQ0SXJHOElrT25wY0pKY2FhUVplK0NHa09nUW11Q0NPcDVH?=
 =?utf-8?B?VmlnNzBhWXUwaWE4VEFMazlZL0xhVUdDTG11SHFzdU9DWG8xcnBIdlJSQ2FW?=
 =?utf-8?B?ci80Z0pjOUQ2TXZmR0FMbjFXekl3WWcraitnNm5QV0lxUGJrUVFtcVIrUVJI?=
 =?utf-8?B?SEpadDEwUDZKMmpqamFvbTFDNDFEcEpUYWs4NjN2QXlwZC9TYjMweDlxeXVW?=
 =?utf-8?B?ckpQZWpnVUpwSnZIcWRWSmhzVC9xVTRHS2w5Vm9PU29nUmZSNyswdzBQNXBN?=
 =?utf-8?B?ZHdndEdaL0VXMmJRUVJFRjBIUkJXZUhPU1hFK3M1YnAyWTJmSEdzd1owM3Zp?=
 =?utf-8?B?NTF3S3kwNE95N0ozc1hEaHFhMW5waVgvSndDdGFsV2pVT2dRamlLUGV2b3FN?=
 =?utf-8?B?bkdWMDVmZm5rbzZwSHo0YTY4dm80SmxHNjBKbzFZa29FcHc0ZjRtUlZkaFN1?=
 =?utf-8?B?bk1qWWNWMnNackl2RTBadGRUdlNOMlE5ZVVkKzFCNzlXNjFoMzlmQ2lJN3lv?=
 =?utf-8?B?bzF0d2tYNFJlekZFY2tGbGJ2eEN3c0RYYXlOcTQ1U3JoZVBvOVJWWGlQaHRC?=
 =?utf-8?B?YzN3eVlhdGFoaUZmdFZ6akNoNGFFK1VKRE9qTVZVV2FVSlNQYTIvWTViQThi?=
 =?utf-8?Q?Fjv5O6/1/CIIi2vlYlx079izVnAsGNYNjuwRX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e577f340-db2f-4092-7832-08ded5f9af7c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 16:15:50.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXcP/xh3//eqeXjxCXdu0wQsp58JLDgNqQxU5/dJad9ed38XIjuzle735SGibUyV8PZ+byXTd7V4UJsFDAnKIQqnCAFrKTlQ4ixkM/Q4P79wjSVWsbZGiPbnY3T2WRUR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944

From: Frank Li <Frank.Li@nxp.com>


On Wed, 20 May 2026 16:48:56 +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> This series integrates the PCI pwrctrl framework into the pci-imx6
> driver and updates i.MX EVK board device trees to support it.
> 
> Patches 2-8 update device trees for i.MX EVK boards which maintained
> by NXP to move power supply properties from the PCIe controller node
> to the Root Port child node, which is required for pwrctrl framework.
> Affected boards:
> - i.MX6Q/DL SABRESD
> - i.MX6SX SDB
> - i.MX8MM EVK
> - i.MX8MP EVK
> - i.MX8MQ EVK
> - i.MX8DXL/QM/QXP EVK
> - i.MX95 15x15/19x19 EVK
> 
> [...]

Applied, thanks!

[4/8] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
      commit: 1d054c3d7ba2acf95140d2296a7500c44b28756f
[5/8] arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
      commit: 6be00d898ed3bf5cacc90bc58b8ab760ad5f26a2
[6/8] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
      commit: d6dd43676b6acb4967060a27c711a482b687142a
[7/8] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
      commit: b3731b730e6f0256bed55562cef39e61aea006be
[8/8] arm64: dts: imx95: Move power supply properties to Root Port node
      commit: 0ac3b96903603e3a0c9e0ce732716837ddd86c7b

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
