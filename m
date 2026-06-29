Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25773F5BEE;
	Mon, 29 Jun 2026 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749909; cv=fail; b=P0nvlvWwvedsj7CQz1hwirPP53YPh9E2l3jfxPPIlz9PiW5vLNOL9dt3EqrYpO5dsYkKb4ver8rdQ3BWtANXCGfH4tDz2WtVq5zy4YWpYxneBY3x29BF+hiOeUAKCnsIYUWHvONEVqkULVCHLK2//9MQh1K152npzacszGqLC14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749909; c=relaxed/simple;
	bh=ryo7OMqc/fC3O8UQlTMqMDySqHT1Wln+2OM/o5+n5Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/OlyPhPtZL3HZ+1pQ2eKPAIQB/LaLTXBu4HF57+oM2RO4UcMSoidemda5TvwcQJwg1qqxC7Vf4MGPczvMQ6H49BR9yA/bBUtQ2/ldyahHq6TJACb0J4dlGtvOM4Cp6OBp/+IMU3jFhbGsM3OhElHMRnGgCmaPITePqj1RfAq24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XrrZP9ti; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XrrZP9ti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM0sw+tCXJoSLL4aZmsTCp1PbEI9WgyTn/aE4dxjcISrULwiLnE3L8/QlY4Ht66GBZ36oC4CP2tGs8FTeTByrnYhxPo5L2Z6IakNkOQsDOJU5oo/3Hzb3KS3D2sRnOe3ebLmkFcXDDlaoZZbRNEl9+GO89qi1DULyhGUkbkublaok/tF1V+GuD0srxFRRHHvKtnAtU9ay2Fw1ee1nj0fjEn5zdyZ9Yq1bczzXwPXRJXwN4cx0hK0jTANoDkdSUYEdMaCSSdJxZTNfWnEkV3irC3pZr0K7QqlnNU8DvdBoUKSn0g+S2uhIG2cdfJvS8rpGRTZkqxZWZ0bvWrsfEQnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/fb3giUlMFokkkXD8lMD0UyLGxW9PsmvHme8hAkbz4=;
 b=j93R5H/riSlF3cincjXZEwuRuHiSqlylFGjHiIVhvAS14vpUs2T0E2kebkK/gySqqvho8sQNSazl/hep6+3xJ9xRjx1WbAqESCH0OJ2MMjiejNms1nF/HgYKeRE2JpWNuCffYdO7Gy0kub84LXTcu8TSkoZD0DZ7RlO0ZD39Etl2s/e3Cd7BwGwbFywzXdBNgsN9PMLKSAEWVfs0ixcp5ZuSWKbO5SNsoYIH0Nh4l3n9GHlWbCSrosXhPGkdl5zx03k796XGU4vwzEUjMv28hRugtKPpJoNQJVj+lqSXSn2ykQuFaXnJbZBgLxt/kbrR6xj6OVHPrp7oeIqzLte2tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/fb3giUlMFokkkXD8lMD0UyLGxW9PsmvHme8hAkbz4=;
 b=XrrZP9tiPsfjvt1PnzzYQfhN20fQAfNW/A1+375CHzyJesEdnKoQa3Ua9nu32bpefvwmCWUlu3e0qt6Khn2LW3CQ32RiK2dudQA8CQTAc4as2e0YnF0A+okCH6Tf5EvaGFdRgk4nzIWLeDeI/6FSPzBF6HBS7hd16ny9X+WQtlZZgwmqMLqTNV+wLeZ42nxTm+BwrlewyiXuH12Pltq0zChSEXivhvv4TGLXw7g6Z76Opf1ae8xOw5LQSiZ51BUIcwPsqt+zqjS/eDMqPP7fNNqnD3TXCnHO2cySZx1EDwO0jThftwUGESkKf+2rtqNKS8du7/ihB5kpaxSA1KmwTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 16:18:23 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 29 Jun 2026
 16:18:23 +0000
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
Date: Mon, 29 Jun 2026 12:18:15 -0400
Message-ID: <178274988899.2274593.17371952702316181859.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
References: <20260520084904.2424253-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::18) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: 87913f25-2b67-4a02-8c50-08ded5fa0adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|19092799006|1800799024|921020|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	G8JUKdbXzHA6YMFTkmm4lwKXQvO2X7+XFPUNiei0CwlwypDwRhAqjtHTaNDVu3F+WKMRbV5JDfscmF/FkqbvTJiNxQT4JH0vz/luy1uLj6wTqxNTB38icVSxSdSwsBHKEk88j8ulZL9e2v+TwUHoksT477NiNFVk3ar4g+Smz5mi73iBZf5bTEEFER5EomFCcfMz+SVjZI2OZbhNLq6QQje9TdNGSELA+3zLWoaWos42w+y+OTptsgJkqpsYpSzUwDhCAkMD+B+lgaOeF/N4xuzNbmtHXyXD3MIXI8f+XsE+aX8tIkIBp4YdBfTbV+5gUIJiQ++FKUiCI3lvNmASeo+xBTMdmx6cC8zk8PaNVREuSaCDWIDCczFetmsPcScg/pKoGm/aRgy9kZRe8Q9NHhBkbJf7pWKNIul0JzUSikEkvPIHgOAY2f8dTkW+yc8kNRw3K4xvmTlveFttwm1cGpWaUBXf6OdyiWb9nEWLTYSzYRLrnVxYrkxk/fIs1TIsqx73Io/NjeocLGFJA1ReZnSWrnqBuq3vLmJXooz858Nm1jVHgjWQ6PRzBasiIF6W0fwX8IW0NJuKHZeooMInuFiOyrPhvf3bdJtgoz64kNMGiUbDn/DHaSBIIn0+Zkql4E7cNxfyoDMR3Ek7pN2PxY+WZ2UZd8LJv1yuRVkEczmql12i5M8r2GgRqTEWQTQKFQhjwrTJIj7BUru7F7vsJg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(19092799006)(1800799024)(921020)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGdXOGdVZnNHNHJxakkyNEdWTEIxTWo4RUxuUnAvR0pCUUZRYUxDQjZSQ1FY?=
 =?utf-8?B?cXF4MmpGbUJpajRMTWw2anV1WUZnVlorRGl2YzZWWjB5dXBqbTA4U3kxajFi?=
 =?utf-8?B?KzIwQVZwR3Y2YTgxeFdjbE54aWVZbm8zUDNOMlMvTEs1S1MrcWpHVFJJUkli?=
 =?utf-8?B?VlZBVTA1Vmk2MFZEMUhyMDlCZ2ZSWkw1MDhHWWN0MEY3M3ZNNU5LbmRodTY2?=
 =?utf-8?B?aWwwSkUyVzdFOGNCZlhSSTZhTGhaNDRUV1UrUk0wU0Zkc2c0aEZaN1dzRU9t?=
 =?utf-8?B?THI0cjJYM3VwQ0tFVjc2MlJCcG41czRyMjNISWg2Tm1KZGM0M2x0ZUFua3Zl?=
 =?utf-8?B?SnJKT1RSR2ZrQTA4RFlCc2NISzRSOHpOTG9teFIySVNrZitQbzJDWkY0TTFU?=
 =?utf-8?B?M0huVndYdkV1Y2NzdER3V0lVTWx6cklCcHBuRVdtS0tLOFNzeEFqTUVjMGtU?=
 =?utf-8?B?cWM5elVXa1ZyanlaR1gyRCtVT2M0VGZUUER5cHdKMFA3YjdRREtSN3E2cXFw?=
 =?utf-8?B?R0xSWHdyVUxyQkFIN0Z6REpYbStOV3BPR00yUlVEdnVtOXlEVXRvWkY3Ry9Y?=
 =?utf-8?B?TFdPenlZNUppMzJJbGdZSUE4NGhNU08rTjBiQWFhVnRScGQxVlJNb1BoVncy?=
 =?utf-8?B?ckpVTG90bnpYNG5ibFVrSkZ5bElTZllmM3l3MEQzZ3RWaXFFUzlJTVpobTNB?=
 =?utf-8?B?SWltejRWalhpbnQyTTljTmVnUmx4cmNTdU04R3BTdjg4dlpQbS9aU01vWVV2?=
 =?utf-8?B?QjM5cWRaWE9BRys3TUZ6MnpyOUYySEc0NkphY1dHR2JlSTh5d0VsL0dTcnZn?=
 =?utf-8?B?Ly9RY0pyZlkzWFhyVFBlODV5bVdIQTd2ZktrYmsvUDhYT3pqaEc5WldsUFVU?=
 =?utf-8?B?aU9WclZla2FHRWc4YWluRDVkZUZDRE9MMjVCL2xveU1HZDRFeWJ2cXJQa0Iy?=
 =?utf-8?B?Z0pCVHVzZWE2YzhmVmR0UWM2bTR4MjFPNklVc2FaU255S3BSUHV4QkNnNjBU?=
 =?utf-8?B?VHNnNklZQlNtbEp5WXBvQ0JhcnhYdVJXVkprOXVnUDlWbjlaSjM1am8rRE1n?=
 =?utf-8?B?RFlmYmJONVpiYWF1UTluT0dCWGllMjFpbzgxNDJkNXZYMWRpWmZQNExXbnJD?=
 =?utf-8?B?UkRGSUgyTEtPZ1V2K0pyUzFDOHkweDMzeUpqMXB2WDRkZHZ1Zk16RzN6NjV2?=
 =?utf-8?B?UkxsQWQ2S3lDUklhbVp2U2VLVS9wU1kzRytSSyt1RnducGozQkVtYmdmZGts?=
 =?utf-8?B?czRGTzZydjQ3Z0xLaWUyYWMvYkpWREVQWnVTT1YzUHB4NVlBM3FuZlFTdFJD?=
 =?utf-8?B?c2EzSlVvMlI4K1dzMVVUc3JINGppL0lpZHMxeURPL3R2b0J0ak5QUnRya2hX?=
 =?utf-8?B?U3cyZU0zWVZrZjZRajhtbFJCR003dkNpRDgrZkxwVXBYQktvQUpOSDF5ZzBE?=
 =?utf-8?B?TEVYWjVzU0dnYWw0UEc5SXQ3RVhvTE9VVlRwYnJ4M0lrMERka2MxQy81bFh4?=
 =?utf-8?B?RDJzVkQydXNsVys5N0VaYUJXcnBuWFR6RmJFVXFrTVBsY0pHTEZKMFRIaFF4?=
 =?utf-8?B?aHZaUElXMWVoaXlHTGVTYXBydW55bjlVSE42NEVkNThhK1VadWVYT25uNzdq?=
 =?utf-8?B?a0RqeG5oMUhuMkpsSTZXYTB6OVZMZmJwQVJMYTU4VFdIZms1OCtSRFhjTWRj?=
 =?utf-8?B?MXBDZDVlMUF0K2gybzFrNW9mR2RESnpTZ0piWWsyQjVUQlZQcFZGd3A3VnRK?=
 =?utf-8?B?MnQrQ0pGRmtweTZReXJQZC9rQUtsL3k1aGE3d0dZUW9TUE1zTUp0S1I3dWZF?=
 =?utf-8?B?YVlIRW94L0tEYTY5NTJTc1YvNEpIeHEvVVhsRWNnNlgzcko4Z0UzOXVmYmk3?=
 =?utf-8?B?VnJLbUNXcWxBWXBOa0pzUkt1bnRxMGZxaEZXeG9HQ3lLeVNleS81Y2VEd2dr?=
 =?utf-8?B?MHJrNTQ1MzdtVnBZRFNXNTVWdHpVeTAyalE5bUgyOXBBZ05mU284VG4rUzNl?=
 =?utf-8?B?UmhOcEphSE1jelFrdzV5QlJaalpLOGZraVpnWC9WYUlwdFIrMHBjdk5CNkMv?=
 =?utf-8?B?L3htZXZZSDIrQStONk1NRHhOQWJha3BwRTU2aUtQYlYza0wzQmRXTjdLYUtP?=
 =?utf-8?B?RUpycEg0ZCtocHN5MmJSZmJKaUUzcnJ1bGZvNWsvcGhSNG9HZnBNZkZHTDdY?=
 =?utf-8?B?NjNZR1JGNmt1OGczYU5kUnliR0RWTnRwWU5RaTZCYk4ra28wRjR3aUwyZ3BG?=
 =?utf-8?B?dUhJOUo2aXYwSkJxejVoWXA2dGhlUnU2bS8rUmpnMkNteis0U0x0dTFEdHBt?=
 =?utf-8?B?d1VPVjZvYTVkellEVUNJZVYraGVPMzJjSGkyTmtrV2Y3U1dHMUZjdjZjRWg0?=
 =?utf-8?Q?IPqBGsPudsUhiqxLOIA3310rIFVWxuPLk0d8N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87913f25-2b67-4a02-8c50-08ded5fa0adb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 16:18:23.6980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6Zq9gr/yAnSeMY1ksOi5AMU5AJouhQmFRShrKqZoK6xQWZzEy+GeWtsMSYPIkxestGrbILdNH5cQaBAthyALgc26EkUMHjYRnREyHjyQpfsGptdKMC/b7wG3wbcePT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

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

[2/8] arm: dts: imx6qdl-sabresd: Move power supply property to Root Port node
      commit: 6ae623838bba6b1d7dab2164bd12a166eae670b7
[3/8] arm: dts: imx6sx-sdb: Move power supply property to Root Port node
      commit: 090ca78c5f5b8b475d51d729a7b79c5b7d8bbc47

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
