Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2987432E7B;
	Tue, 21 Jul 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621389; cv=fail; b=tmYvAS/Qd+uJau7tXaBwbYiVqsqmtT3+279OTdF6Ok+I5cBl6rBVcDzFKbEdi4U2Cce5T7N2HU8C1gaPzmC5fHhIW00DCwseHmK1ftVa19qqrk92lwtc203Wib4kcW0G5D+wbcYVjvSE5a8AgIPAf+J0OL4l01IYddGEcVCBqwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621389; c=relaxed/simple;
	bh=2WSyo4k3mg7amAXL42DRas5FwrMfYPq851gsDiBNr8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OPevBbOZM+IPsdRq4BzvJDC7Y8F5lGEMXNQsZywEpLNUkflO8ReanJ0FAJ3DgKsDmJvIb7IiCEYQuNyFhLftYH47E92T1wwzwd9z0c25pMxikcz6m5+Czg6x9e5UF0CSssrUawzodYR+Dr/36IDpmG11O0KMR0BJGBGrdFNx76A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGMtn7tmqFPTb8d5Q2fKrsxL4U7v0VP02arOBBWPX+VxXfCAOTSDKJxYK7Ot0InK+KuT0C/TKq17ST55zQJFfEGcVhl8azbZ8wDioo/g8ykAngw4rMs8qbC3Epf7T8uAnvNYlEilLqEthVneNg5CP+WMi9yx4QItn64lNCFp6MorACsOwB+oJzqTX25BavYtZKOxnODOSSuV5ABxC5I4jUQWWPM7rU4OLWi7okaBBrkAO75c/e9Fx4SAeUtqh97vGiWat3J/M5LhFzoCw3oZPvTHVRhN5TeqqQnCXXvUk25Hu+7lRc05YCqlq2oJJZPTtluGNVKNWxP25nVBW7Draw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WSyo4k3mg7amAXL42DRas5FwrMfYPq851gsDiBNr8w=;
 b=Jxid34b4xFKzh+JJ4rQmAlLa50Pu8gmf+uB9P/66dxIZAfRkNnTd6iqNFLKqJjOrtb+trRTSDW6MDeAmOKGWlHnvBzL2FnXzulXc4Qw0aHl4YezPfatYhW7s2Go89/dUSWjlrKDK0h9L6BK2Vp58+Fim6SalBsDN+gWjUKmoQP0TVkFGOTZlXhp2rzUpAv+OQUtXWpygbM/1gQv2x9fff38gpBJ4xKEfQ3yNrbNm9g3letE4MoqAuL2k0tpYhPeMR5qAOpW65iRYsmBFM7V9Ww5BPYvN+A/LrubPzan/NHJEIghKsXldq8tIRsHtTSyT44QSvMfqCoz4TRL0pJjeLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1127.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 08:09:34 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%5])
 with mapi id 15.21.0223.017; Tue, 21 Jul 2026 08:09:34 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
To: mani@kernel.org
Cc: Notics_zhang@lecomputing.com,
	bhelgaas@google.com,
	braden_zhang@lecomputing.com,
	brett_zhou@lecomputing.com,
	jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lumin_liu@lecomputing.com
Subject: Re: [PATCH v4 v4] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Date: Tue, 21 Jul 2026 16:09:19 +0800
Message-ID: <20260721080918.2760753-2-braden_zhang@lecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <va5ueoyw7igqh3bx3fnlhrylzecstkzcf3jvb4kylio45dvpjf@ydfnnczmej5i>
References: <va5ueoyw7igqh3bx3fnlhrylzecstkzcf3jvb4kylio45dvpjf@ydfnnczmej5i>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784621358; l=393; i=braden_zhang@lecomputing.com; s=20260518; h=from:subject; bh=2WSyo4k3mg7amAXL42DRas5FwrMfYPq851gsDiBNr8w=; b=/Kn4Feac2GFSkDH0pcjZKUCbfJROx03n8E844edeWGHZUEYCZygvcysyIr1L3rwPbpu94Qj/n oTJDPioxoKjDsdgaCd56+bugoZsOKK9C8uRO4l7fVYPgITmjTTmexmC
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519; pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (10.43.110.218) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn (10.2.3.238)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1127:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dbab09-672d-4e7f-7717-08dee6ff6687
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|1800799024|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VgkWWjij91JtYilgZSD/sjtGRkfI4pjUeQZ+KBCcuNzhg+5rZP5G/1+YJ9y1aECfPDTAtoe3c6hm1i3Rlz2vGTk0g+hyQfe4teVlWhB4YTUP76BuotRePg30R/TzQT66TiYVIBaI/9w01V+/dLIu2007wUceHML/rbJiQ3HN2bAxdus4+ysc1gomqENGsiWQAQcsL3biq+SxD3D3EuaEMo52EW1aTpeZyQTNV69vxkNAp6w1aGsQOXBlZETUs2Wt//RaxbM14qyfpMSMUiM7NBu7hrRmIspsnHHupOD4O4USOmoWVAbLTBDhd4PyQSaixumKNyhlJwGwHrkfUaSjVJBZ3thQ+eWmP3RH/a4w4VDI8WwqoBq1+MqM01MfSuXYZs0L9DBHx1kH2lJd6LQVae61S4NvjYE1hXvspp4sTVA95Xw17qOmpIUY8M6qCeEZCFyOyZpCn5rUpwpnEbcRJMUVdJXp+UG3TAjPcdZTTxN9mzm7cQWbIqGlB9Y/xtC0Hx2//KfPlZtEKc/1CLqWvvzfzSrPJ05NEIhYe98yr+hdbeNf9uFX/fFOBWEI77b3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(1800799024)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AOipe41KKmztvxQJbaU7LhujTA8gkz9DEdl3ksnMvijgoSdyt8483A/bO80Z?=
 =?us-ascii?Q?1oyNlKcz4qFgo76iCSpqDkTc4rX0B5GUzK1EGNCI7R6vj0LGLpZToqjCNsPI?=
 =?us-ascii?Q?XOtsehVDs2WjklvQ6IFTkOCuJrSqgfz4hT1rBache8StnHDVQyobSqh7kQ0S?=
 =?us-ascii?Q?V760O23WKjSjKRIt2CGtTqoqgEYxZp8tCgSfhTb5vdha5rYy+0Jw493X8q2h?=
 =?us-ascii?Q?1NAiqaGCTB864hPCWVS0qxP1HUcOpeebXiBCX1PTwsUPhr+MNt6NTOhAFnIz?=
 =?us-ascii?Q?QujIrTa7HLtTXeNRU8MIjBm9wzIZT7Zm1mqC7zCXM2L22a/kZlD5vashE+VV?=
 =?us-ascii?Q?/1zewWGC3Tyqt2jYcxwa+EXzd8E9DJfZ4sIj7GU8R08AmnUpszZ5GfIpVij8?=
 =?us-ascii?Q?C9Et4sGRmoVQ0KqlDxLm71VRHT/1Rut0BcmwI6B744tBzg6q7l5j2nr+xfP9?=
 =?us-ascii?Q?WMAQCVS+BSX2GqkOjAh2moDyrBreAIy2dWVJr3Znain1nCi1DA1s76vzZ2WQ?=
 =?us-ascii?Q?jt1e36vkULkYiauDrdbAf9EHq5tnj64B4OTEyEAvPNHuZuYVoQrQ7Lvk577h?=
 =?us-ascii?Q?oNosub/+pBJXFi8xF653pTb3SdXQi+6wb0k22HZb+8IFj1w7imUbxVDY/f25?=
 =?us-ascii?Q?piq5o/oc1BqkRdT/qI15F6WtXONveuOiHtPN6Yfvqn0hEcYuE8xfV7FhTvaw?=
 =?us-ascii?Q?IrezL9dvo3uDc0chc2+Jhfyep8+6HhH6Rx+s4N/PO87KeClEj4Ho5x/aCUAq?=
 =?us-ascii?Q?lO2s7ZhXpK/UJ2v7o8x8CxxOj30391NkcwBTse0ZVlLGtMb4sXCUxWDJuL2O?=
 =?us-ascii?Q?gGnvQpADPYkiZtipe/yV0C7oMV+AarFX4u7IlgbAwujwzy4zQjOO21s03AAt?=
 =?us-ascii?Q?yL1QTQHjQ2QtXFX9QXYeP6j2kC/oidomzpuXcmHvTCVBJhScB9Ydhsrb2Q6R?=
 =?us-ascii?Q?j5+O0cUhjjo8bjgk39VxFTkzxDZIHDn7Hsz1lng4noBFVlBr+/KVwLBjFGxk?=
 =?us-ascii?Q?vj4rxGIb3JdLI9KawoIdtEaXKVeVa4Sauf8sQCKihy8l1C95VBS3Jr/h3vVM?=
 =?us-ascii?Q?hUFny2XX4bbSEaScUFaJFBjn4zTxRxteHaoDinuYaZbsLXIdLg9b2Vpcx+QC?=
 =?us-ascii?Q?oCdSqZ3Mb9LLjPtaI30+tQHpykXl+hupgMYrDYe1COfFsZQXw8+v4k/v4kQy?=
 =?us-ascii?Q?9Zv51GJZQMunJTvLCMaX5jPM+9LlD9wkIoF1vrGxjU6amjTn4vMilPntUx+q?=
 =?us-ascii?Q?NljwO6WtO2THt/oweb2fbF0L5pvqTjv+Vdoi65wMrliiMxkUfc1QJnYxMMyy?=
 =?us-ascii?Q?YEJzi8Gut1M9YByhhT1ul/f6c1mTakJat5TfEfEKCvNXsdydtaQe5EmPnfgq?=
 =?us-ascii?Q?6nPkZKWgxxdgQfuKkuop4w0Ir8g/timGcit8HjiJUgclUQAC+0JXTpa33RDr?=
 =?us-ascii?Q?8OWsUGhjUnnV9uYxizlfA0znhrzmrIwCh8X/JErHIrfTzKiQ/W7mnDjnU4TW?=
 =?us-ascii?Q?MyXWP3lb5+UDcON3Y5d9k4GhKNLmH/vRz92Ur6mXrl+5H5Ek8OhtHi9obX81?=
 =?us-ascii?Q?ifMX4hc5t9K0Jbarg+JeT6U5lZTxAvBC4XlkRg/Kf+sh/j7JIzxwCdVDs/Sm?=
 =?us-ascii?Q?w89i31itTI8GeJP0Jn6USWDcAOHUe0uTDnT42Xn5G8ClokuQlvsblFlqCwJ3?=
 =?us-ascii?Q?Es3fKjTQLph9cnidPsi9GfChJdsjNtpZMTwEL4GNwDiC4MKDEpVf6K/ZX4Bb?=
 =?us-ascii?Q?C6q/GAfGmaWRbDe5v35CHgQFSA75dIM=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dbab09-672d-4e7f-7717-08dee6ff6687
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:09:34.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e77wFOAouoFG7jYxGPbwEIXS78Ok14Ti8TdZmqCg0BPJgpOqwgJxxue1EyixsxGw3zSF159a0Tj8kd29TWlufHJp3d2JIPCR8KIHJBHiDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1127

Hi Mani,

Thank you for your review and for pointing out the issue.

You are correct. I realized the patch was missing a PGP signature, which is
why it's not being properly recognized by the mailing list and `b4`.

I have now added the missing PGP signature and regenerated the patch as v5.
The new version should be correctly picked up by the tooling.

Best regards,
Braden Zhang
