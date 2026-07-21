Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2119.outbound.protection.partner.outlook.cn [139.219.146.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5176E40800F;
	Tue, 21 Jul 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621114; cv=fail; b=fkogUPY8CQvvurCekPMtKRVHpUkt6e2M4g3xBDYzcLbJuzBDCAfC03sK5lwXHyULtVhx43/6instnZs8Vg3gWyMEiR3iWDVMJ0NSW7bmr8LpWF7wyIVyxhQKZSgZGR5FLSXYmCd9JMUJUbRKjYZUwvXOYSSSWoSLM+6IjQz3hkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621114; c=relaxed/simple;
	bh=2WSyo4k3mg7amAXL42DRas5FwrMfYPq851gsDiBNr8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XoZ2Tfa+HniljOG63Ix9dHNhR9KKDagsGaZy+XSAlFB6Un+ycEEQ5EHw0TIuuijFr0iuu+M+eNihofhBiu6MQqraQmrSBNTLDJUFoiPZm4sgbetgNjiT1YU+ZNjQ+G/gKYPj//VvizG0tiCE3V0qMluzfxTIFJCkQEr0UT2ehVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.146.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCFp0z8hyIyCVOMMxJsspNnkK4Tl+W3AGa9g4fL53lWq9SOghLh9eduL7be7S7cRSvl4S1gsNhy+UPhg4v2ArnmWMtRjqE1jT4W34+IXDoI1GzQ3Jgwy/sJ5nfmsDVBjRpYPxn6LwvGj2hwshGA2UFChpokbJfhXo5gfKyk9UKL0J8gY9PgkQDwQuET4XhbvyDJpK/mqnEsaK/YesuSiQklcIXdLltBQrIR7WnnEpxS38QQp8KBG+2wi8LSU79gYlaZSE4QIO9/3poKp5smV4ZVV0Mm1W7+DbGlsAi3hAPxzmMIGavyBninz286ELm4AllUgmWnFu/AvrfoIwktFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WSyo4k3mg7amAXL42DRas5FwrMfYPq851gsDiBNr8w=;
 b=d94sUX8T++7nuiiHuU7GrWv9LWAn37NU5LmtpIC98luABSTZcLdqRoOV0eanWdbbSRPtlsa9iAygzM+/blCLgwTSRuC8aTFnmRS7xjcxubBvp/IMral7m0p9VhyIFPOBkrXEb1rIwwO11dSW+GqBOSZZ7bW9Ny67+K+YH7TTteXIJuXkPhprVY+WN1vOVFqV2B6n9QrOya1+rLe2D3K4c2wtuopXlbO675Uj1MY1i4TI+6iDPDC7P/ETxDISUxxsUwGcS+6oA9uBC+E/Dm7JEA9MUtsOhgflZcZ9ducV8x59QhvYpsAohxx8L56Cd0DoAQfek5PSMOTz9SWgVsYzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) by ZQ0PR01MB1125.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 08:04:58 +0000
Received: from ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 ([fe80::9e88:7d6b:fd6c:cc6a]) by
 ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn ([fe80::9e88:7d6b:fd6c:cc6a%5])
 with mapi id 15.21.0223.017; Tue, 21 Jul 2026 08:04:58 +0000
From: Braden Zhang <braden_zhang@lecomputing.com>
To: helgaas@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com,
	braden_zhang@lecomputing.com,
	brett_zhou@lecomputing.com,
	jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lumin Liu <lumin_liu@lecomputing.com>,
	Notics Zhang <Notics_zhang@lecomputing.com>
Subject: Re: [PATCH v4 v4] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Date: Tue, 21 Jul 2026 16:04:39 +0800
Message-ID: <20260721080438.2748472-2-braden_zhang@lecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <va5ueoyw7igqh3bx3fnlhrylzecstkzcf3jvb4kylio45dvpjf@ydfnnczmej5i>
References: <20260713173805.GA1223423@bhelgaas>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784621078; l=393; i=braden_zhang@lecomputing.com; s=20260518; h=from:subject; bh=2WSyo4k3mg7amAXL42DRas5FwrMfYPq851gsDiBNr8w=; b=kgXDrWKFPfYaOthGdMnUIiXQKXKxctE0ryZWId20csUUfx2THE04qndVTMLFffWIif3ieEBU8 Dmbku/oMOjyBkr24eMvdRxbM1N036duuoqjCH6jhOO0FtJqXnfYzKNs
X-Developer-Key: i=braden_zhang@lecomputing.com; a=ed25519; pk=d7V8RTvs1pxSx8mPaXNAe9XWo7K/eHkcVBWTjw1rwrQ=
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::19) To ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1206:EE_|ZQ0PR01MB1125:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7e1351-f574-4e6d-c97f-08dee6fec1c8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|18002099003|22082099003|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	CkPeqhhiqRof/stHg4Hq/bF0XGbe8aVagXWZDBgI9IvxaO35K5jzBKDYvQvczcfsy5w5QgM0cgN0eX+p5vff2Eue1AMTswKmHTPFdhZVxbdF9qvffu/2UY9lQaxKnEcMm4GqSlMhaB6IAOYxmzbrsxCnv3abGxnb5h/OhIOsUN19dYXvyF9Hym2Hbqe+pwYKrD+nN2oduxAi5tCII+JAoRPG0vtM1x2RfZDCAKC4OAqvPafhl74TUM2OIWb6lp1BxYafbFKnmDfaBMlDlmj/JVo4G4Vh4WGjO8zHlMgrf7mmrsKTOGB67vT+gyI85AyDAxwa4kZVCQJqdPzVN56nmkOnaB6a4xxy8MxJEKaOHZ0PoMrlSB2t9t/Bo2ZLq6i2j5x1s2GjXTUeYZJ5VlyjFrpNElX3NebZHiw0L0D2Qnw9kVzW+joA/9JTjpEPIXw3e8zyqy9PceSbSRSOAypDlYCI6kH0fK3Lw+1f/uo0gKzeqlnV6iCjba1xnW8OXzg1Tbk1TpnanvbLPS7qg8OYT20qsy89dI2aVaINM3rk/wYhsvNP3kUrf0ZWnres/GRk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(18002099003)(22082099003)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qiqxE111yb0e71XxfK15CxcE0+79/HxfvBEvur6wslBrAgn4OJe/zrru26L+?=
 =?us-ascii?Q?PP/f8KZtep2h34cRMP7NtBsZLQqQPFmaCiR6SYBxDtwhNjS+AUp0JJhui8Et?=
 =?us-ascii?Q?0DY9qKXCHjXM9eRhlyqAokrItJLTz3Wl9VPQnVKlmtszJufrTTept89MVD4S?=
 =?us-ascii?Q?QaTltE+04xEItPEfvWX7P/d/9n2ZpmfrvLbVBXtkOcRxeFKznhGYS9G4nqUn?=
 =?us-ascii?Q?/ls5wd0cKhtB7yiO+cyHme+R0q/1It3JHROJH+qctwbXVUjwPtxMfyZ6uYFv?=
 =?us-ascii?Q?92B6Txmfia3WYPeIixfnJ+80s73oSW4CDkuW3bJMPN+9MXr10CznGrdXynyU?=
 =?us-ascii?Q?TL0efh41P4oxcxwv+3MPumsKSZC8QH3137/kShajRBakDOiiGVBHs16X04/C?=
 =?us-ascii?Q?UE2ZJCu6Xlrf9lAxDKAf1oXZRCqNoKx81+Fm40mz+Sfmm8WrIWn0MY7GW7py?=
 =?us-ascii?Q?VAfnRUz+Jr8E+WYh9zm3fzIjo2lHCuEbsJnFboeWXffYCtnMX0gLqsib/UOr?=
 =?us-ascii?Q?bUtKt1hhcxvMIqacIU+tybdFUdtAoFZywggDBTT5w0l46ZqK5G7IOP5DisWa?=
 =?us-ascii?Q?8ttTFraH7WxUatrXmenLFpZgqddIQ9Tz88dystX7dPKXdtj/KZah0idlLzeG?=
 =?us-ascii?Q?ug6GPTv6RnqKEqhnpZZSX9LYC6TIceYjicGv5fwKWKVMPsMQJ0lFakBUUpre?=
 =?us-ascii?Q?5KQ7XEMG1QspUk4l6eF4l70EkhXtoPZb7CvZ2gSAx2sqh7T5jWCFqr37lO4Q?=
 =?us-ascii?Q?ZWTCQfUkSA6czN0K87QLMDiWlGffomqgCENCphlozuVVhOerCx6oF25/oaI9?=
 =?us-ascii?Q?i/vYAdOS/8dirAQwhBDmMl/X6vSrfBh/nAQVgBVpH4xDkIH4xpdXb3b6gwNk?=
 =?us-ascii?Q?SaJtivUm3W/4K6Bxk6VWZrvNwy1VPOC+7hYftaXG2aT3Dw6XTwTZXH78SS2l?=
 =?us-ascii?Q?zI1LqdP0ClDHamvyAcbdPdCGCBx1nh4sqnnaTj8m0lM/tlYk+f3MnzjmkbKg?=
 =?us-ascii?Q?oAFDaefwsZoZZjmfubuPTGUtx0jaaGEHyG7f2bg7DxmC+c/oin56INtk6bhp?=
 =?us-ascii?Q?zIm+wZdbMCQtWqvLND0JX4HeCoA6XorZNseQ34qc6E5Aq3B2jfGSxFx1JVkM?=
 =?us-ascii?Q?x3QmVKIHUUuO3d79QTEbMRMYzA8ZK7/uAHSOa5ZZ3AjNDrd0T/lKA+CY6kcY?=
 =?us-ascii?Q?pcSzKhjsQBXWEbhtQkF/GSzuJicJKHbhMqmk1iOSwEsjHDquJd5JZcxCeuSw?=
 =?us-ascii?Q?T+oT958/LA0vho8XNVNZoCQL+bd4kVxxQApqWfXn0368sgJQPAfV8vFr3mhl?=
 =?us-ascii?Q?EVkDKeJoEXOqGBa+GkdE1Sz7hauqHKGiV7MOt+Hv9EisO7NDA2eoD/1FB3Fo?=
 =?us-ascii?Q?MqvN6LptBYR6jwq3RZMlqKywlepI5LZrLlgZ1w+F/4M4jhX528BwvOx/fIml?=
 =?us-ascii?Q?SHGfeXoAvYlzmJ6labcleipZ6AknYCDb6WhvD9w7vFWFfzATFycHT4UvAsDR?=
 =?us-ascii?Q?YOHrHENbcAF7RcRbsOFYClhWE3m/f0pWgPXeJbxjNRiYnBzte1LtyHrHJuNM?=
 =?us-ascii?Q?bflzoFCVG/gKmXqJB3+A6GBM2UrRooQfz+eoOuAg8n9ug8OFzHdtv66ByE1T?=
 =?us-ascii?Q?eAALPDD1V3ncYToI0+3c+EYrgh9KabGjJ1kXytnxHgd21AqF7Vti9SDKUM8L?=
 =?us-ascii?Q?jUZSWPp2iycX980AfRwyUjDLgMSYmUFemKgKufnhEgoQbMC2f13+uuyFYe4g?=
 =?us-ascii?Q?b6JY3wjEQZGUuGeQeILgKVWO5fZUjO4=3D?=
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7e1351-f574-4e6d-c97f-08dee6fec1c8
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:04:58.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0heByOGez+xhX+udUogrvYoTm+nKBM4FIt+SWNH6aG+cZyxgN1DgOkamoXRgO6FmwCsE6QRzgmO63SY8m69ZA0BvximoymGGH36uWvkN6mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1125

Hi Mani,

Thank you for your review and for pointing out the issue.

You are correct. I realized the patch was missing a PGP signature, which is
why it's not being properly recognized by the mailing list and `b4`.

I have now added the missing PGP signature and regenerated the patch as v5.
The new version should be correctly picked up by the tooling.

Best regards,
Braden Zhang
