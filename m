Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FEF36C0A0;
	Fri, 23 Jan 2026 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134531; cv=fail; b=Ms9xXPtLjcRiey9D0cfzov25XIYgNLERhcF+B2vhC5Y4GDJE1SP59AwN/34xgFpeJ+owBBHDalI2DYyNG72/lF9Y0k2xP+42Z8P0AjMtaGofG28q+sJzEkzXYeIRXqosS1cF4CSYaDU+9IZgGTdLDn/UyRgP7fINY8QQxBmwOms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134531; c=relaxed/simple;
	bh=oU5cHXE0FMe4OEJ88kg7VcoS7m5S4gS0AOYGI2qoWGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZWTc3XMCjcKVnZeZkNBGt4bxMv2Zq0lEV6hxsDRTWjS9O+jOZrh79hZiBHY9JinlYS5gN8CLEViA1KwZY5po7IVJcqohlXSLW6y6BTbaCE0s/Y1KW5ZBlQo13VrC2GK2r+35MGGbUg1Iap76FdR6RJ9NQzA3Go8FjOfOmtPiFXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WqeANTXW; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WqeANTXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzH2rVYxYz6DMFRTyMtmECPrx1+zehvO2xzYu6RpEcfyqYdbfNTMNC6BfXfwpDGVGkCWjqC1fm8LkkfPDKbFPh32pfx3VakGjvx7dOqyNysFeBkW5+8SETS1xwn2UD1K+VGANmtera8hT7eLmaDKPWRHcsZYgOkAWNwxYyVDQB8e5V3EejfsVBfVQ6YTvMkEBLMc4X7LNd2pXhHv3jxMvFpf7J/fXQYZJ6DDq/oHBnL4wf7gkr439ZBiShzInpBDnbZOM4qiQtY/oEw/sPuf9uY5so0XSdkHe8GsMrVAZC4q24wWevMgyc955xMUvfh2ETitFa71VZflsl/UckqnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8qP+eF432awzRyc42cLlR09d4A8DwzxZ8vk9Z+0cvM=;
 b=fQR0faNfNsKK/rlNqzNl7xePeS/Z4IoS3dmOt+jSwTTaiYmS/mrhWszny+ANYaiTLXFd+NnvvH3W75mqngIwKJxpdknrg8pmF4b97YwXEGy2DOT1+S/KkSwjtsy+IvhUFC99z9KUYjprnPbfMczkcHPEoDzNEI0lFC1uP7FSug6XSADk016iX9QgeYtEAE2L1+bHJsthefnlQk5kVCDq8DFptv2wxMQ62E6Iy9uOl8aPezkUgCv8E0arfvB3LmhiBUM1hyidRqGzN5vEED+fy+rEqVPERsYI2ZISVOCyWoK3DludIOFZdYoC/4xjjSZo/8blOVpELO+PR7/GvG9YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8qP+eF432awzRyc42cLlR09d4A8DwzxZ8vk9Z+0cvM=;
 b=WqeANTXWoMmohxoYwc+xifg96Lmz5XuekKyYDDqDkaP8fMoOe4IoYJQW2Y9K4JVmM04URp4mf82V9TZ3Wo8JzPpy0V07dHOd6+PXGaDCyqlOj40YZKio+9258V7aHf72Sp4ypqnB5SJiQQPsPxPcNTNuQjXOV14R9kud36oGnwCofBeWk6NLNTxUAIIKFI0kKjhFRerEq5bBkQARoZ9iYsg9du9V8WdPa9gUYmZXZWjB7rKgDmdV1nLJlmEnTdGvHg5jwdoA4xYOeiNUmQfnK8RvymB8GJqnvBdvotpIoic0sUyaeDbObMNOqTuVOeWSM57rAnMB1ELnyGru9QL2Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10332.eurprd04.prod.outlook.com
 (2603:10a6:150:1ca::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 02:15:18 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:15:17 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/10] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Fri, 23 Jan 2026 10:14:35 +0800
Message-Id: <20260123021445.3782170-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: e613112a-4c25-426a-a979-08de5a254098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlV0YWE4aUMxbWlhZnhwWlRqeEZBdmxvQlYvQXhoM0V2Sit1Z1Jyd1ZCZEEv?=
 =?utf-8?B?cjd3WEE2QmRjSTIxUUMzbzRlM1ZESXZjUUI0dHRRU2l3SU1hM0FjU09SUkVV?=
 =?utf-8?B?Y3IrWi85Znc3L1BnRUI1N3VOV08rN3AzTWwyWXBBWTVaWWlpUmhWTklSQWZ6?=
 =?utf-8?B?akZ3bVZya3hUMEY4bEV4RVZvZVRMc21jbytrMUYvTzB2RitLZ3ZhSTBqaG1F?=
 =?utf-8?B?cHIzV3NjVW9Idk5mR05ja2VFSXZVNVM1bGdtSFExQmx4ZjkrVFdsVDR1Uzg3?=
 =?utf-8?B?a3llbndESW9PS0RNVDZ2bEtKcDFjYXJDQW1sN1gyazYyaHdhQWR4eFpac3hx?=
 =?utf-8?B?YklsZVRDZThVTjJ4SkVmWllFNGdXRUdpbm1aL2VscUJpUXNTQkdPVmkwR1pQ?=
 =?utf-8?B?MEM2VXFtTDcwa2w0OHFFdzZDZDUwcnRwWXJxdm1vZmVvUmczUWRock5GbWJF?=
 =?utf-8?B?b1BnZFJVUnl1OWxsbmJhR3VkeGJDUHJraGc1UkppVjNXSWRSL2VsdVU2Nzl1?=
 =?utf-8?B?cmxEVWNOdHpESDQ4VmdaQXEvYVdhTjZpam9MdkZrbWp4bE9NNUwwTGVEOW1Z?=
 =?utf-8?B?dCtJSHN4SCs0M1VhdmZ4MHJrVVUvenl2SEM5L21LYWQ1ZEpHbjBEdDNVeGZz?=
 =?utf-8?B?S1VNRTBmbjMxS29wZjNIS1ZZSERENXF5UXloSzVkUk4xeVliakxqQmxhZWhj?=
 =?utf-8?B?R0dKV0licHloSDJ1RENnRzhUUWZVK2N0dm5DZHgzMG50MzFNY2tET0w2L0F6?=
 =?utf-8?B?bzYyR2xIMDB0bDUxejRIdzQ5Q2FiTERGcTJwc2YxemFlUHN2Zjl0bHIxcnky?=
 =?utf-8?B?QUE0RHozMHhRZ0kyZVN2WUN3YlFZZkpWUGxKSUFkc0cxYmtvaVpueHdXVlAz?=
 =?utf-8?B?TC9Vb3JKZFg0VGp2a0U3d1lRY01FcmxqZTEwT3p2bzVTM09ncTgzUU4zTnBr?=
 =?utf-8?B?cDgxUnlrcU55bFFkUnY3SVFvakEvODgxWWxpb0FGOHJOQmpkQ1k5KzFnR0Vo?=
 =?utf-8?B?UHZmWXZHQUVpKzRmMW9jNDlZa2tvamhoYlRyVlhINU5iMk5INHh1N1hVNVRM?=
 =?utf-8?B?NGVRYTY1SndiMjZlRDVha1BKUlp3M0ZtS3VBLy9uK2U1MnFXQUhvRkpnanlR?=
 =?utf-8?B?UHdCRTh5V2dVVUxqbnpxaDI0TEh2UDF0Nzk5cnpqajN6bytyRUc2NHNTUXRH?=
 =?utf-8?B?Q3Y1ZGZMWmxhMmMrOUd1WEIxZU10bEtwSldEbGpMUTZsUTZRYXNKN1RkOUV4?=
 =?utf-8?B?cFVoSitNSXBNeTQyWmwwZWFWcCswS3hWelpReWN0V3gxTEQyeDg0UDJYMWEx?=
 =?utf-8?B?RDZJSTRwbTNUQTY5WHlxOTNmcS95MzdMcVREUzhNUjV3UWZ1WVdBZjJxNmIz?=
 =?utf-8?B?dlFOcHJOSkk0bzU2dXVqQjNxM1Y4SlpsSG9UdkJoMUJQbFpUWDlYUDlpalFp?=
 =?utf-8?B?WXRSbWFjWjVYYXpmYWN1Y3hEN3B1MWF5OEl1RExGUk02NHlZTXlrdGMvczNV?=
 =?utf-8?B?MUxraFZSeDBPYVBPSStPcUdOcmhOUzhzZWxlTGtncEhUTnVIZ1FtRmZhYWYy?=
 =?utf-8?B?UVo4OExwU3NLSDAvWWswNXRpOUdhZnV1d05kVW9LRlpueHRPMC9MUVBnUEJ0?=
 =?utf-8?B?a2JueitISFV4SGZTWDFnbnhLTm5pN0U0RnlJVEdaaFlVR0ZveWd4anVKUDlW?=
 =?utf-8?B?M1c2NXFJUVJzYzlKM21xdmd6RFlCMER3b1hqZjJFRE9PMGxjelE2elFiU2VW?=
 =?utf-8?B?dEJSeGdjaVo3TU1Bd01ZZVVmLytXSHhranlBQ1BJbjZqalRmMmE5eWhwcWNK?=
 =?utf-8?B?NXVpM3FyTFVIN2NkSkptOTVkZnZtYjdIcEpZS2g3T3NSRFVqQW1ORVJRUHZK?=
 =?utf-8?B?b0pvUjM5Z2RpY3JmQnZ0M3JXVTBQR1Nhdks4MVpzS09UMVZGL0lEMzZScjQv?=
 =?utf-8?B?cHN0clV3QzZMRDFGYnpMaGh1SFo5bzloZGZOSkFTclJ3UVJXNUNCRWtOODdu?=
 =?utf-8?B?bDJPSWI4S1p3ZFN5SFZ5MFdwUzljdlJYN29qK2djWE5Ka3BVVm9rbDNlUFNu?=
 =?utf-8?B?NU9Va296UnBabU82OEhma2NUbktrSHB1ZXo1My9BNmJzdkQ4YlNTZ0FaWmRO?=
 =?utf-8?B?eWkwSGRHV2tJaWxBU0tvMzhYeUFwZ0FwS3RGTFd6YWx1Rlc5SEZ5Sm5iVkFz?=
 =?utf-8?Q?flqfYv7uOFoD55hZO35r4bLi1L3W12n7mjqidhiYgm7l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3hnVkVZS09PclcxVmZSQUo4bVhYRloraUU1bkgrTVVQLyt6eEl2S2JvQmZj?=
 =?utf-8?B?T0h4SXJQY3JwZFhiVnhtTmRhZWVzL1VhNmRTd0JLeHJFVjRoZTZ6Y1VLd0l2?=
 =?utf-8?B?cVJ0QUZTMUYzL0dzS2NmLzNwK1VXcVBqYi9qaTd3OXhLdGdQNXRSUUhCRlpr?=
 =?utf-8?B?NnlIbEZMR05jK1pRWmgvMmxiTGg2TDRremRrSDNJWnZRRWthWExrTnNzM1li?=
 =?utf-8?B?OFFmZEJxL1RPU1JndTBoZzdDQTZOUHo5cnhveVFjcnpVQk1OYUJyd0Znejhj?=
 =?utf-8?B?UDE3MUt3SE80WTJBRVdoUkZuT0ZFZmlRMktKa2lpM3RYZWc5ZjZqekNUM1dT?=
 =?utf-8?B?YlVGbktLNll6OTR6eXA4SmdMUmVXbm1QakswL1lFalROTVlpWVJsWmh1bkJs?=
 =?utf-8?B?Tk1pOGVHTnJoNmkxdWVJczV4Y0hTTlhtMjRFYUlaRTBiekxXZzYxazN2emJQ?=
 =?utf-8?B?dVdpZVBpR2svMXBSODYrQ05nbWZYWGUxa0pDa0IybnlEWHo1TXZDTUt4bkNJ?=
 =?utf-8?B?MHdaN0oyY3RKNDVnQk9ucElKRUQ5OG1KODg3b0Zqb0JILzNhRXFldDRTWlNS?=
 =?utf-8?B?cVFaVjlraG5tR2ZlQUltUXhIMDNBQUxBcmdPZ0s3OHZRM1M1NjU3d2x6NEM0?=
 =?utf-8?B?YnV6YWNUSXEzS0M3eWxKRG12UzJiSysrMDJweDlFQU91dWFlSkllWnRZcHpr?=
 =?utf-8?B?Kytxc2RNVVptTFlDc2JYVzNnYkl1UVFlVGcvNms3K2drNW93NU9uRXJCTGFk?=
 =?utf-8?B?TmdPN2F5bFNMWXF0MVhOQUFQN3NGS2JNczFDV0JvYlJla2o4RmZUZ3o0d25k?=
 =?utf-8?B?N0d0Q3k3UGFiZWVSNFBrN05ZMHE5UnhNM0FXMFExdzRubXV0N1BFV252KytF?=
 =?utf-8?B?bVZhTnJMT0Q4a3B5Ky9ZVkVrMDEybmxrdyt2bWJkRXhQc0JFNzVvVVBablNj?=
 =?utf-8?B?eFEyS1FwUzdiWWxUOG93QUlPMU5tcjFubnFqWU8xem54T1VxdzhueitDbXVV?=
 =?utf-8?B?WDUyWkg2MEppQllKbHZ1Wk1UeVlOUmNCenJ0djNsNWExTWh1dmhRRnlXQXZJ?=
 =?utf-8?B?N3RLWC9EYTkrKytBU2dPQ2pyUUw4NDUxRUMyeXRpcC9sMm9PWkQzbklRU3E3?=
 =?utf-8?B?MWJXQTUwMmtGbHVRQ0JhR0ZuMWVxQ05LZWF3LzhVTFh3UkM3dlNuMDA1VHU3?=
 =?utf-8?B?TW9mbU5VVi9wbGVpZFBTZzdQMUxBRjRDZEl3c1VyUFEwWG0zZ0pNSG96aEQ0?=
 =?utf-8?B?cHpaaG5Nd0dndFRzVkVFT3lWVndPUmRPWlZuaHdVYmlacWc2QktuWVV3VXdE?=
 =?utf-8?B?dXZPOWF0cnZDNDhIZWJ6Q1Nwd0M4V2hMaTVYUmdMWG1nd0pMZnRZdDVyWjlw?=
 =?utf-8?B?dDlEeDIrY0piNjB4L2hOMXRncnZFM0pMaWx2MHBzSkxZa0NtaGJ5Q0pJOFBy?=
 =?utf-8?B?cmNXL1VZVkprZ3pyTTZ0b2NRZENjSzIvakwwd3lVeGEzcnFyQUx1L08zK2xK?=
 =?utf-8?B?d0Q5QWlJZk1BeFptVFYzMzA0TmF6RGhHLzVGZGYxQ0dCL3ZySXIrL2tKSzl2?=
 =?utf-8?B?T3ptK21mTUVESDV6MEp4NExrVGlIb0lMTlFxQWxWbjVmZFpXblVmSEs4ejZa?=
 =?utf-8?B?SEdpUnU5Z25NL0pqWCtKWHpVenBvT2RKSW40L2ZDbFFNcDJCelZNOTFsMG9Q?=
 =?utf-8?B?bURFTGpHTTh6Ny96ZVRuV3BMNDFXRmoybTA4RUlGSGxON2hMTXRuRFRDY0RZ?=
 =?utf-8?B?aDAvZjNUVDlZUG96ZGRVb0hOVW9LTDBieGNGcHpVWEZva0g5V1MyZHBER3JC?=
 =?utf-8?B?d0JPL093aGh6Sys5YXZURVFmR1F5eTY5UU1BdG0xdFhRVzBIY3JsMWpjdFFZ?=
 =?utf-8?B?enlGYllRdWVvcmt6bjJqNnZFRnRsNFlaRHRhZ3B5VHJKcGFneFlDZ1dzRTFS?=
 =?utf-8?B?TFR4U0NIdWUyM28vc21NWE1mSWtncWNVRXJsaXVVVlRpRXp6ZStTQVBPcVBL?=
 =?utf-8?B?dkRzb0hBNEF0aktQNHFFQ1RhQ0x3R2QxWDR0aVo2THlTUklDOWpQMm9tNzR4?=
 =?utf-8?B?N3ByTTgrU3RTRit4UkIxL3BpZ3R1Qk9JRndDZEhkUXhtMHVSMytrdEd6TnJS?=
 =?utf-8?B?a3dDMC9sTUxhb0dGbGd0RzVzNWNyOS84SmFKYmZpVDMvZ0g5Ujl5SFQ3VE5K?=
 =?utf-8?B?dU8yOUZLT29Bb283TW1rOGxuenl3T09nc2l0UnMyaDJrMFJpWkZGdjZsVDNJ?=
 =?utf-8?B?S2lyaXlRTkdvRVp6MU0xZjgxOW96Qnpua0E5ZUkwKzcwaE5jS3VYbzFFVkZl?=
 =?utf-8?B?VlNnQkZBMU4vZWpiL0pNeW1sdFRUOHRvTnE1dUR5Ky9aRk5yaXNJQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e613112a-4c25-426a-a979-08de5a254098
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 02:15:17.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZKhP+wy7hPgCiiBKdObN8XSYtodqU4/ajKS5PWhEoEOq04oVbJNWLlBMX75kvSLb+S+VlSiEsN2AsGWBq2XgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

This patch set adds support for parsing the reset property in new Root Port
binding in pci-imx6 driver, similar to the implementation in the qcom pcie
driver[1].

The plan is to add the wake-gpio property to the root port in subsequent
patches. Also, the vpcie-supply property will be moved to the root port
node later based on the refactoring patch set for the PCI pwrctrl
framework[2]. 

The initial idea is to adopt the Manivannan’s recent PCIe M.2 KeyE
connector support patch set[3] and PCI power control framework patches[2],
and extend them to the pcie-imx6 driver. Since the new M.2/pwrctrl model is
implemented based on Root Ports and requires the pwrctrl driver to bind to
a Root Port device, we need to introduce a Root Port child node on i.MX
boards that provide an M.2 connector.

To follow a more standardized DT structure, it also makes sense to move
the reset-gpios and wake-gpios properties into the Root Port node. These
signals logically belong to the Root Port rather than the host bridge,
and placing them there aligns with the new M.2/pwrctrl model.

Regarding backward compatibility, as Frank suggested, I will not remove
the old reset-gpio property from existing DTS files to avoid function
break.

For new i.MX platforms — such as the upcoming i.MX952-evk will add
vpcie-supply, reset-gpios, and wake-gpios directly under the Root Port
node.
Therefore, driver updates are needed to support both the legacy
properties and the new standardized Root Port based layout.

[1] https://lore.kernel.org/linux-pci/20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com/
[3] https://lore.kernel.org/linux-pci/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com/

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Improve the patch#1 commit message as Frank suggested.
2. Also mark the reset-gpio-active-high property as deprecated in
   imx6q-pcie DT binding as Rob suggested.
3. The imx_pcie_delete_ports() has been moved up so that the
   imx_pcie_parse_ports() can call this helper function in error handling.
4. Keep the old reset-gpio property in the host bridge node for the
   existing dts files and add comments to avoid confusion.
---

Sherry Sun (10):
  dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO in Root Port node
  PCI: imx6: Add support for parsing the reset property in new Root Port
    binding
  arm: dts: imx6qdl: Add Root Port node and PERST property
  arm: dts: imx6sx: Add Root Port node and PERST property
  arm: dts: imx7d: Add Root Port node and PERST property
  arm64: dts: imx8mm: Add Root Port node and PERST property
  arm64: dts: imx8mp: Add Root Port node and PERST property
  arm64: dts: imx8mq: Add Root Port node and PERST property
  arm64: dts: imx8dxl/qm/qxp: Add Root Port node and PERST property
  arm64: dts: imx95: Add Root Port node and PERST property

 .../bindings/pci/fsl,imx6q-pcie.yaml          |  32 +++++
 .../arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |   5 +
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi        |  11 ++
 .../arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi     |   5 +
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi         |  11 ++
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts       |   5 +
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi          |  11 ++
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      |  11 ++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |   5 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |   5 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  |   5 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  11 ++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  10 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  10 ++
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    |  22 ++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |   5 +
 .../boot/dts/freescale/imx95-15x15-evk.dts    |   5 +
 .../boot/dts/freescale/imx95-19x19-evk.dts    |  10 ++
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  22 ++++
 drivers/pci/controller/dwc/pci-imx6.c         | 123 ++++++++++++++++--
 23 files changed, 348 insertions(+), 14 deletions(-)

-- 
2.37.1

