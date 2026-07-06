Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB433B6BF7;
	Mon,  6 Jul 2026 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348988; cv=fail; b=kY50FqI/Fu5RZBweBVDQwKV56DtAfHsMwa2ufSRQWDMjJQrx2/DxICj2widWqoukA7TiC8g7VQ1zU8im22aOC5hcTlIMdWMA6Gn8v1e03J4ySua6WoXoDpnkUpo9PQ5sPITrGkwVEKCTRnX3pIjXPmCUac30fPsikjC66zraZyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348988; c=relaxed/simple;
	bh=/yg+X8tDzbJq2LtiBWgMrX9LFEBxtCaclW0qx3O9jRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ok/hLbJZjD9av+BQs9/FARzNXGrali/ObtT1Kowy/gp6mJOUO8bIuHog6nHbgy9FEFJC3vz4dXQ/tHfB+q8a7PG4fVJawL0XoA/ABZZ9uq7+QjGNjqvC+w9zfqWlnVg9cwqY6mu5FHJvsqUE5j3W8rruJ6EQzihk2ktJtrRrGWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ANyTN1TM; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ANyTN1TM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUT1X8sEqJimv7aSgSp9pg7Jc8w8opvXxWq9tUYqHjr6xsAhlOXo/qTHMqpFVCaYVW+AqWlvHnfdLZp4P91uVFaIuxuHvPo1iyar+15rQbEJhF0s2cON5354GnObdIS14w4idf2gt8QSDIgP6RE7D34QyhMHNjrOwdNdU/RdJ2WlWjyCYoHkgNAS3cXgqV8eV2nd4zzC65UOvD4S5FGaVoX+lGNLuDWV2IuPtw76joRc7S/0YLx4jbR8Ob57tQ6HjYk+X2hqGXqrbcGhdU2w5tZRv4m0ueKeLqlbH7FL6nUdynznf+k+4un7aHBhmr+onOZ9ybp3TWZwEIjCEkvzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB4lpeiXim0wbuTUAvHSuHSqTMSPi9b5YzO93wu8PkQ=;
 b=AKtUGMElIgYhIoNtbV3CYS6SHTUjaIaTZ+hyZePMivzAp+klIYmTiKTaD17pndc7Uer2AeS5x/ZmY1rszwSd/CWUEkAYlGlGUqSKCU8DDGghadTgjZKIZGI7RBZBPQDeQokCW7IHic0WyQQObVj83cPY96ENoI8ENMUwpYXsACMsPABHPcJD79LnXBKmuWDketEmkIiVNufygfX9Bz6UPbRLBHOH9q0XatKwYCF3fRfLCzu/1Raow/kffb4RRBqXfObX6/L76xcZNhvx6LqkaDA/gJ5BdVbbsf4H5iBxGmw1NRnwMpB9pFot5j7uzT9NbEXoTtmSzvaq1x+etIMY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB4lpeiXim0wbuTUAvHSuHSqTMSPi9b5YzO93wu8PkQ=;
 b=ANyTN1TMCOQ79Aas1nJj2QFXEdxcaK1/HLr3PPp+RA+/AZQqopkfwxZYaApymtaCG0kH2BzJ28rBo0H2L1dhJaPULB7/itV8zVMn/rORYTv/VeszlIedX+14vifD0I/Xd9eOTG86NhqH1rXZpLdfkxLJGl0fscYQIR3/Ok0FHvKIJPxwWPtN1ZOlO8LhaGPoKgHdxMdK8cfJUak6PcyFk0jPQmRhw+yduaPpdWCXZgiu3kvsfM+NLVPxcsnRhOzvOqw5oYKG39aQHWLH/maxaFJTAhIEdlGnCmZgRm8LsfqBJdGpBLy92LeRNnMYkwNHNk7GVA74FUXrfKJlvIxPZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VE1PR04MB7390.eurprd04.prod.outlook.com (2603:10a6:800:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 14:43:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 6 Jul 2026
 14:43:03 +0000
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
Subject: Re: (subset) [PATCH V5 0/7]PCI: imx6: Integrate pwrctrl API and update device trees
Date: Mon,  6 Jul 2026 10:42:56 -0400
Message-ID: <178334889913.1328922.3977960494060423278.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:806:6f::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VE1PR04MB7390:EE_
X-MS-Office365-Filtering-Correlation-Id: 549dc4e6-09c9-4864-a7e2-08dedb6ce1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PdZ+sKIT1ozPmgAofBZa+2Qbw8MUEFbh7mED7hoqUFII32Lktcj8mDpwzzCV+ZqOv2tFt4CGhcyRiwUuH88vB4MrfWizXIvqTzsgbWhpHJNeuK+ztg4edVB5CPewhuoE/V5oTSRu2W3trXidYWTzE+TQAPXMrksLlOj+RE4RtMgZn6BM+kT8chRW6kF2h738NbzpHe4EAwkKqDuKM3Dy7+vgWUtu4w+wgDd+774q+wNxNBudlI4pZfofQsspXWzVIo4gbDwXTM+PHCh9RLHf3L/VJz7QjRgRgZ/uTYZUTUtREF1VYGIZTWKZ4TUsGzLKCKRN9vie/5LU/QESBeZ4FnRSQAvBcVfEtskpxPBUJM1UI4derqoTX2MNk7JS54KO36LZzMHhlEwWZ0RvsaabR3VUyFyGH65qJ7gMXcbbzs3qB8uhHF7S3RmQrYjtWFFEOuZvUSuab3qLhhBLQs1yIQQAmRvtBelCpRmxiYP2ZUmI4K4qTszRbqJLF2wtfIVVubEhBSynPf79819ZkmwA/nibc+R1Ibam01BH+CAHMXEGNGo1x0TakDi2Dnn4b2zhpIDjDHFeOsJTng7/8BTHyOcDOK07xnFo0n9R7FGvwxqzBywSCojnzMCunF8X0T6Z8AIt4r4xS+Pd4vg1x/IeJWa3baMyWlfs9CklAMscudCAr7TkNlrDiS9LUqvmJvk9EQ/ybRqguEsdXgqKtZidpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clJrRkxTeFRrZGwyVFE2L1lPM29FQUpHeGcvUTN0b0FIaVljdnFKS2ZZOUdl?=
 =?utf-8?B?cWpHNmVWNVNYbGRYRkduSlJQZlRUcXlmSlhYeFkvUGFNWk1BUWNXb0pwbVI5?=
 =?utf-8?B?blovaFhUNk9pbTgyUEprRkxtSUlHbXg2OTRZZXVvdXpVTGk0K1Rrb1dqSUZy?=
 =?utf-8?B?dGRQS1JwbGErV1Vvc1YyaFVxYm1PRCsxMUM1clpCRHE2SWtQOE1MaThDNEVi?=
 =?utf-8?B?VW9GcVQ4aEQrRkhRMjlVdkRSbnFDVndtZUNLdWdva05oV0owanlsTWNlZW55?=
 =?utf-8?B?TWpUZWlsd0Jka1A5aEhadGpza01wNW5qNWlJakJvRDRoQmI4MHpDelFUNTYr?=
 =?utf-8?B?UlMrUVoweWFGZjArRVdFbnhtaWc3MTUvSGhLa0Fnb2RHa01QMzdqd2xHc096?=
 =?utf-8?B?U2VXVk5Sb1FxVlFmVjErbTNyRVZGQWlDMGJRY0Nld1ArZFRsWVBSMWlqcTdP?=
 =?utf-8?B?cVdjeUJJTHBHVHhtOHVsdEZneEV1dkNoQjJWdHNldkFFbWFwTEIvT2V2T0s1?=
 =?utf-8?B?TXlxcDJaVHJOdkdlZnh1a0x1Y1N5dlkwQ3VReUR3WCt2c3Z1ODV0UGVRMThm?=
 =?utf-8?B?M0lCbVJwcTNyam1mdUZNampBYUFlSzRDY0JzS00wbjRyZnUzWU5KZDlaY2Yw?=
 =?utf-8?B?RXpkQXkwTVg4OWIycDY2djQyQytSUEE4QzBZOXBQM0VXZDZuelZtNHJqdFJi?=
 =?utf-8?B?Yjllc1hKSE0xblBXSlRFZjhzMmpONXgrczBxMnZXMFNxcks5VTY3YUJPMER0?=
 =?utf-8?B?REI5MWxaWUd1YU1xSmdvWFZvNUcxdzM3UG9WOTFUZlhHdEZWV2VVakxFcFdJ?=
 =?utf-8?B?MlFBeEdPNzI4K3kyeTFmQzBWVXVvdVFEQ1lUZ2M0SWgveFp2NnhFb2RocStq?=
 =?utf-8?B?Q0JIbVdmRVdMU1BJSTV4cjhjc0U5TmVubi9oR1NXREt1UGlscUxyOWsySjJF?=
 =?utf-8?B?dWUyRkcvK0t6NjFDamlsNDkzcDZGUGJESjIrMFlmNUR2M2hnRFVqajdYR0s1?=
 =?utf-8?B?bnErekNqUFdtUlN4ZGxOemZ4cThqQjVQSFhZZlBrLytIVTlJaVZYejJqOTdL?=
 =?utf-8?B?Mkl2d3Q0NGF0Ny9pckVOallkVjNDN3VMdy9jeTlMUjVPL05wb3kyMk8xbzZQ?=
 =?utf-8?B?ZjJjRkJLeE5rVzZrREcyUnVJK1FsbUFHZFplVVFGRTcvV21zRnhKc1hXTWJU?=
 =?utf-8?B?QXJsM1hubmlzeGdqZ2pwOGI4dmxrNFk4bDg3T0tEVFhPOTFxYjgxOEl0UUJo?=
 =?utf-8?B?OEhxZmR3L3lId1JkNUFTNWUvMmw2bTFQcVpFZGVkTHhYSnJTVG83SVJWUnNk?=
 =?utf-8?B?MlFhWFo1UExEQU5CdjJxckYrcytzUk8xVjdSMVNVeHNZTHFGeGJ3ekc3SDh3?=
 =?utf-8?B?Q1JteTZYUWZIUnZYR1YzNmNDMzNOTGRlZitlU05HY3JYYXcvQ0d1K2NXTFRl?=
 =?utf-8?B?dzZ0MnhtWVFYUERDZWhWdjRoUGp5TlBtcFBsb3NTajE5OFVqSk1yQUVtVzJj?=
 =?utf-8?B?TElYZHV3MU9sV2xBeDZ3K3FGdEtwZXNjVUF3T0trRE5VbHgxY1Jnc0FMR29h?=
 =?utf-8?B?RFlVQjV3Rk1JS2RzbW5jb0tZSnhPNHdvUVcyWFJrNUlVS1FrdEFKTjhFdXUr?=
 =?utf-8?B?N0ZpaVpVQUhPd2d0M2Q0bHVVL0JmMVp6TVdsb1FzVUM5a0JkMjFXWlJUVjk2?=
 =?utf-8?B?S1UxVnZSMG94UFBhQUhOVmEwUytPNXpGSFMvVEgwamdwb2cvYlExMVhib0hI?=
 =?utf-8?B?aXIwcFlhQkZLakVDK3ZDT01wNmdINlJnTWwzMXhvbnYzMG1JUll4Y3hsNDRC?=
 =?utf-8?B?SGE1b0k4TDRkNnhnbFZZckx1SGh2WDcyYis5aVdOYXBqODNvRFNWbC9DcU9F?=
 =?utf-8?B?d0hBOFE2Z2FCNzNQaG9GNkhtZVU4OHFySC9TZyt3ZlV1WXFWVkhmYnNvWmN2?=
 =?utf-8?B?MHdDMUpxRFd3TC9JVFhIN25vdGswNmU4aHZaV1VIWkpDRjBOc05MM04wWjNB?=
 =?utf-8?B?ZXJoL1VkdEZyNmhmdU1tWmNiQzNKOXRaQXgwVlFPZFIvN056ZGY1eWNycVht?=
 =?utf-8?B?VUlpS1AwUUNEWjRGbDFBejd0akRxOGxuclNNTWJ3SEVZQ2x3MmRIWGd3blgr?=
 =?utf-8?B?TGR2VTZVdUlSRmwrNTdITmVXRi9vRU5KczljT3lXNGxLMkdMRzVtbmNjeWtL?=
 =?utf-8?B?ZWRxNlVLRXZQd2RuRjZZVHJlYitMc3UrQUxrMXdvWDc3MEsyOHI4THJjTU5H?=
 =?utf-8?B?eWdPQnZFV0JtVFAyN2pVYmZ2R3lyOGI2NGRnUm9aSlRtNlhVd3A4WnNhM1lD?=
 =?utf-8?B?RVBuSG12Qmp1ZmRORTlvbnJhVFBRa3NnejU0WFJKTkpZdWRtYW1FSkxudWQ1?=
 =?utf-8?Q?P9luLY1l/6RadeMQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549dc4e6-09c9-4864-a7e2-08dedb6ce1e5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:43:03.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsXsIOommex1leC6amUKQdue7DFSJ/1PjL7HR4HwLnUfBJOhMrH0PokTkd1MwsSZ/LBLh8R+3U5oTJKOEZWaXaSQa5Ohll2XaNvnRh8PqFj8+JMzDycpQaiHV5TO3sYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7390

From: Frank Li <Frank.Li@nxp.com>


On Wed, 01 Jul 2026 18:52:27 +0800, Sherry Sun (OSS) wrote:
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

[1/7] arm: dts: imx6qdl-sabresd: Add power supply property to Root Port node
      commit: c6458ea4dee9a61dd67599edfc8b2a39bdfceee2
[2/7] arm: dts: imx6sx-sdb: Add power supply property to Root Port node
      commit: fb3efa82b5076353a7ab17c62a62e7c0724d2f97

Change tags to ARM: dts

Frank

Best regards,
--
Frank Li <Frank.Li@nxp.com>
