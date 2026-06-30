Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D13D1AB7;
	Tue, 30 Jun 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833485; cv=fail; b=S9GNGFf018VpoiuqOUF475NieCtH/UMp43hdgCCeWkqEYugDSMjNm3nI8b5xHA1O3AppgE861g4/DMRo4R7/td89j8VwLMsRYv3BXyEuvb9SMtn4W4DtaTLFu1SX27L8kNSY5pgRxDPo7xJDUnHbNw+/P3HvjARBGanRNVjSpEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833485; c=relaxed/simple;
	bh=Co+Fva+CPcvEcxVO1+Hnk4rMmc864gyLAbaa7jkdeyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYIh3iCu5s+W5Fe4z/qW9U/YZ0wp8Qs6CK0oAYKvACiKzGmnos0ktX1nwO/Ex+fTKSbF65qYbnI+UjZBVbFIaMQncY2de5aGHv+rbxq7GP/IyLj+kPeBeJYUu9wyNdFjlEL39wSNveY3N6yKwzDpBoAshjSBOL78GzsFxGqn8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lk+jGMwd; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lk+jGMwd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuimRh0zqpWjnx31CHG2qMfgo/BMVqZ67RKlB2vReOxOKgVSEdtlg4enu/KubBcNBLL/16JLCixiaIePiEXdPN3P9is68sAO64dA5EtaCrgYhP+GYsJrVYF+DTSAJmqoh/XfYcmlIziQVtvrbFlN5Qli1PuJgty2cbtNIEcanXUCkWGdP/3ca8b/H9zOwcm6eaN1BZec1Fd7e9yvRx9j+n+AGgF7KAJL3H9JOste8iLb052VnvJ6K5TKGORyNhenEijJ/Hz6lZ0ONoJePGNgpUGx2R9qeIBkenL0tVqNJ2W3v73eBJpFEsVo1Z12VupSXWrGfMAhclYk8eCFB4A6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syPDA9f6y4Ud+KHnT/hgqmcnwEhI4WQyBwIQ2jX3wB4=;
 b=hzTdzVjEdX1D4IcnPkqh/wr4Gvw2Iy6D7VnVRRbSyFaFvebE/VUna2Mgv1lut7p7IgsErQ8R3yHQAKB8qKIGwstfePwjsJFstgYluKj354Hja/NArAkEIaPqg3LHKUVzc/UXd2xrf6npdRQIaZOrOpqAL3RdKPTOX1BXinULk83sJ/v25VQRcm9e1rwVrG2uDsOt6gJAhsWqkoxYRW3bTFf+6ZAQGKNLTe/EeYw9EMk9GvhrNPDOy3zam1Fk7m0mTE/3X7G0rV9e4gLaXkJwubwN9VlvY/YDdHPYTXP9g4iAr/GLUYo3O4yBXygC0Vcx5GCOoNbE/X1zbzVJWr66xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syPDA9f6y4Ud+KHnT/hgqmcnwEhI4WQyBwIQ2jX3wB4=;
 b=lk+jGMwdDN3rHZNJsT1cdf3YllGwB6wQQXPZmMAiZVjgKtyIjPSL5VWanMXBohuxAiUd553qOQ3ivNWcH2AkTTBkvJjomvbUl+yn+0auYIsBNgqWv4Q6/v3R2P6/xc8ek+Zn4sbM2h3RZeY98hBPjHK+SoR5YK30IXu0OgCp0S3y9GBF6YCp6l12DECuWI+YJBIj8q8W3m038eF2QGDXxrJXlB6mWjshNrf2q8mq0qWDicuq48DEYlUOX+luKL7YatkYLvSk0oGzTBNI84vvVjAdiMJg300vaqE30kUy9soFtj6rvFzzfb7757WaOcf9ZDH3Q+6GTRzYN0gh5+QgvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA6PR04MB11948.eurprd04.prod.outlook.com (2603:10a6:102:51b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 30 Jun
 2026 15:31:20 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 30 Jun 2026
 15:31:20 +0000
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
Subject: Re: [PATCH V4 0/7] PCI: imx6: Integrate pwrctrl API and update device trees
Date: Tue, 30 Jun 2026 11:31:10 -0400
Message-ID: <178283343009.3269775.506226017892254973.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA6PR04MB11948:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f529dea-4413-4940-c549-08ded6bca23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	knuz85R3tZzUND9zxZnE9qTLwHi+CpjEYqdZPZvJJqv3nQitrEn65g/9kEC5BiOeQtg51F2bADCWNoXq5Lk6/iH0oZgn9ld7y9wikYz+ZDUFfIfDDWZPpKDv0oIFSwTkJYKhK/Db+nGE2psNtv9Bc9e+vUUv6HYw9qtXbvuj6z7NKpnYwfE3c2h4i/hkmyGb1nfcSxDhF8vNBRFpryMcn9gbC+KYR7Mw0c1v8eyp5UisU6lNe0z9VrJLZ2hiIBIG7F4d3onHm5GpnX7M+0Aw2cS0MQLFqwjipoDqcMsMiP1UKHLaH8soUfW3pHqyFICVwKzWpYsYA7rpUMmE9FdAarghkhRCPtb3hLH045Oz5td26lrLKaS7/6kDTySdGb0a3vKC8bwK3nMWDZHgaMV6f9X1nRHtQ0E+vpeeUr3jkYO/kwYHp4eMpdjDyf6u0/0fk1C3TpRBC2NP/D2anH5ZvrpF0e2g1KRjMIwUniBuE5Yy5XMgn1NqtefzuHFZel8LWeNNmtByz7TOu7aD4EB/SlzaS356ri2QhvVCCx0RrUQETJ+ebXlKQeE77SOna35bIs5nBsQgujoP7OXXomaF6fBEn3ZPhvvVW8FsBTSx4CT3XfpIe+6OjdHw8X6Z2uey2ti6wr3dzj5HxIbPWFfbfBUAVJ8iWC0/9P+672OBYeLx4D8JVWbHr3XVbko3hEmvnL8UHKr2rCCWENub0dYebg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHRzdEpzRlZTOHkrMVhxSXNaY3hZNEE4eTZHdVd2dklCWE9tWDBsSnpTZmJu?=
 =?utf-8?B?Q2t5V1MxTWZZT0JJWW9UdVNXcUhuT3ExZHd3dk14UVptMW4wYWxlSStLZEV2?=
 =?utf-8?B?K0N0UzNHdEZGell0K3EwK2tkTDZ4cmZFL1c0THN3N1ZMdEpTUEtsMjNxbytF?=
 =?utf-8?B?TC9JZWNQTVpzWXljamJ2eUlnTEIvNkdMSWJVWWMwTFhMUXVkVlBjc2ZNWDFR?=
 =?utf-8?B?SlpyaEQvbktFR2tnYTJReWJVbEgwM2JaYkVpVGpLRkcyZnl4TEtwOTZVRUpi?=
 =?utf-8?B?UnpDV1N3QlByeXl5NWxveG1vaUhjUzJzTEovYzI0ZTNmMUQzRWM1UTZDYm1H?=
 =?utf-8?B?dmZPeEZIV3dxQUoybjhGQUpWdTlXVGQ2cmNldWJDSHdDbHJtbmV2aWNTSTgv?=
 =?utf-8?B?dlNucmZWOWlTTWFiYWVxNUZ0emVSdllaTDhWWEx4Y1JMOXNtQ084N3NuQW9O?=
 =?utf-8?B?QUY2RTN1OEdDeWIvMTZBZnh0TkowSmM5M2lHdnVCQWozemdFTmtDY1NiaTlj?=
 =?utf-8?B?cHlpeUlHdS9KeCtSMHZuV1NTeGs5aC9DOHhqakZSVzB2OFZQSDRSdU9kb1lV?=
 =?utf-8?B?ZXBNUGlPM2NJTDNwQlRYUGNHQk15Nnp3ZzlrZFdVbTYwOTFhUmZIc1Z1Wm9W?=
 =?utf-8?B?eFgxR3Q2WHp3b05ZV0Q3Mitia0xGVFhCR05lc2h6OThHeVV1MHlVMWRHVmhR?=
 =?utf-8?B?VHNJQ3lmY3VFWFV3TjhvcVZCeWl1NHAvNWcyZFJONnc0UHM0ZCtyQVpxaGhH?=
 =?utf-8?B?bDc0dHFpakVJWHBrWWxvRUc5SjkrOHp6M0hLZGlmREJkdnp4T2prNWgvVlg3?=
 =?utf-8?B?ZkN5Zzc4a2U3cW1oQndTU3NGMWsxTERydytYVjNIUmgrYk8wWTVTbFZpMENP?=
 =?utf-8?B?eU1DRjRmSWM1RHNhK1hRcDE0ZFdtaXBxdCtGbGdjRjlCZnc2QTNzYnh1Qml2?=
 =?utf-8?B?RGFRd0NoKzhOQUN4d2k5ZE5sZndkNEdjR2hxdUEwbG1tMGkwZlBLalhBS1Q3?=
 =?utf-8?B?U0s2MmpGeUl2andRUk9iYWdqb3E4TURxdThFRmVpNTk3T1Q5dnl0UmZPTUNG?=
 =?utf-8?B?QWpjUDVOSlhyZHN6aCtwWkZadzZ2a0IwRWdaWmhiNDcwdXQ5RnMybzRrTTN3?=
 =?utf-8?B?eWxGMEozVml4T2p3TFkxVmpXSXJoZ05GSGVzelpVaFlGNmdoWmx6RzgwZ3Jl?=
 =?utf-8?B?dVBxcUpIMi9la0RmU3kycDI1SDFQL0RsRDBmUCsrblNxY1ZXZnRZWENsdm02?=
 =?utf-8?B?TytXdE5DeVdNRUU3Y2xqazMvL3Z6SVlGdkxaWnFUUldaMHZwM3ZCMzgwdzNh?=
 =?utf-8?B?aHNpd2gzcDFzM0JaQ1pLenk0MS9HaXNGMW5mSE1nZGhwUzFkSEdtSTdCTjBK?=
 =?utf-8?B?dlhUaHc5R2pqQWJWSCtOeDZvVVVzdW96WHBEYk0yNGM3U3dxTktIWU5PQ3Jq?=
 =?utf-8?B?SjM1RmhyQVRLMEIwakRQQVdySU9yVDNBbHk2bC8xSnoxTHVFaDBjUlFoeVo2?=
 =?utf-8?B?QWY5ZWpiU2VsNW4xc3BCQWlJYlpQbXcxTkdJQ1JHQXFnTjNTMjhKWVlZaVl3?=
 =?utf-8?B?bzNZSFpOUVJjenNCUUUyWXQzRFFnVERlSHhXYkJTK3c4RkF3S056Uk1VQ3VV?=
 =?utf-8?B?cXNIZGUvdmxucTZoeksvWFR2ZEV6ZzZTODNRaTZiNHZuWWJLcVJBL1Z2NFhS?=
 =?utf-8?B?UHdtaGR6M0RRcmFIcm5yM2VoMUlaR1JmUU9NdVJTdXZLR0xWRG9SajREL0Vu?=
 =?utf-8?B?Q2VEZnY0UmVIbllZRmxFY2p4cjZUdk0vOEFBVkozdlZUZGhkNEY0QzMydzZG?=
 =?utf-8?B?SW9PZWsrYlErSU5OTjdJSnU1ZE80dkdKVjV6akdqYWQyRk10YWhVamVKQ2JU?=
 =?utf-8?B?eENVdWthLzhidVBTb1pKdkpyN0pHSWY3bzhSRS9QYVNzSFBqbkVlZ3dCdFM3?=
 =?utf-8?B?MUZXR0t6alhVU3NEVEt1cmpQRkZlajFTWDdNZHdVMm9QYUIxVXA1ZUF0VmJo?=
 =?utf-8?B?UXBPd2gyV2loMFlLL29qK2RyaFQ1QUI3M09QZmhGZG9sMFE0T09BY3R0WVZV?=
 =?utf-8?B?Y3MvRVRTa0Zsa1A4K3d4YnpmT0Roc1dUbXB0cTlNZjRiSzdxMWxoU2Q3ZUN1?=
 =?utf-8?B?NkxRSjBEaDhpOHNNNnUxbCs5MDZ0QVBLSHB0aHVsNU9Pc0NBUllDdHhZbEMv?=
 =?utf-8?B?cXRCQ0lDNlpSRFJZZHZSbDZSZnRmZnBJT1BJUnNzYmE5YllqN1VUV3RreHdF?=
 =?utf-8?B?M05qcTdPa3dSaXBOVkw1MjdsYldVbkdjeFNWNjY3eCtObENaYWRqQTRGRXBx?=
 =?utf-8?B?YS9LYS81NVpCc0tHZC9VM3h3bmRSZ2VyelkrZkl6OHVaQXpoNyswK1hjVEV0?=
 =?utf-8?Q?90l/HuB/Nwfzny/98E9Ex5eiqSmfVJx0S0ey+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f529dea-4413-4940-c549-08ded6bca23c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:31:20.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJJu+AcyO4IT/1bAS51mk/Q0tVqg/lCwSA3iubOCRpH+E7wHuqg28hpc9hGRt0V3xN8mpsqbri+56Pi85/xjR2rKWqV6TgdOS2GsWtyJBCWFVtRFiL4qirNeBgwTf6SR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11948

From: Frank Li <Frank.Li@nxp.com>


On Tue, 30 Jun 2026 14:07:03 +0800, Sherry Sun (OSS) wrote:
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

[1/7] arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
      commit: b16fded592305f04ae40764f5fa91d5ac6f02a65
[2/7] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
      commit: a1af6cf5a6ce526ea41d4686fa14580a48b2e768
[3/7] arm64: dts: imx8mm-evk: Move power supply property to Root Port node
      commit: b6a38d70bcbf0893ce5493f3daf0cb19e5102269
[4/7] arm64: dts: imx8mp-evk: Move power supply properties to Root Port node
      commit: fde093c386a64c820a704abaab9ffd9ec738cd4d
[5/7] arm64: dts: imx8mq-evk: Move power supply properties to Root Port node
      commit: 78610987333b0811a456f9a4782472fad00f4a19
[6/7] arm64: dts: imx8dxl/qm/qxp: Move power supply properties to Root Port node
      commit: 240950f3ad76761066ffe399f62670321c1be1f1
[7/7] arm64: dts: imx95: Move power supply properties to Root Port node
      commit: 6e53e8b854bc6f8330d07905b73e53ad02aff62b

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
