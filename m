Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010012.outbound.protection.outlook.com [52.101.84.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A13D9DCC;
	Mon,  1 Jun 2026 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326718; cv=fail; b=K6AGjfRoyEONoqSVhVlF+s02Lps8+AZ2dgI+M7zCLxa6VJ0WKL5/87wVay9hKn49c/9Ua6WoW/CksjZcMBBq+WSzkMsl6FQZOyefZ/YxsAaqwUbcFnlHnuxpChjvriFyo9CIcSH28dtJBywT8GdRAN3TmwV5gtdQEDIyFnN2X3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326718; c=relaxed/simple;
	bh=vrdE/ZcczKpZ3bcSzv02xZ+INxquWayMGAwcYnTLo4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5El9pF6vOcO0QpX6rGF72Z876uBT1hy5auA+0nIBjoR1IdVsLQdJWXiG6OyYce2TpDTrigrVxwWzsI4d7pt+Q8u3mgNA9mZYTr+pG0lx2DxvfZ8Tfo2iY5YqH2nrJtZhoHY9F6ksPEWPch+E14x+t2F2I7p0hp4oGZs5jVIwE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jVz7IG41; arc=fail smtp.client-ip=52.101.84.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jVz7IG41"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSReW/1Q3LERzpF8xbjfC6z7WZNc1r6xmykkvFOdK+hy+4NpgwePwUpBmCcP3Et5XpiNOQzgwtMR47piB7Z/8fXDtal/5uXYmuRWAKOapSSnjxoJLGeUoH8oMy1N93LpXKR504JJTC3JviAB5AQkASM+3rXKLhLAHudboJIG3KCDU47JasXKpPkkuVGu5HBHcOyz/gwOVHaY/FdiZa/SV9LfjSvDyKbx7hiqAwa0Fv1hXaJXAWDe6Z1KZwuvmZdLMtb0rRDRz/bLqgocQmEwRgTbsnCsS3pOR7Hn5y7sPs/93EoXgIP+Iv8+nDUkxK8/X1yhMNNcnPsRNZqmH/g80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPZ/hLV+4BoBPaYkf8KVsgixUM81Ml4IcdD+HoqJrC0=;
 b=WUWZNfcnJQI/GbYavIp4bM5zdAvOEiDFTAuAmLHAZw+yeYm8Lmw3fwhjzv4QqB03S0ovFUi5R99d7F0ozTZInDwbROu1pXVGoQ0QtAJWZPP5vbK0RQQrwo0KrSEcndUn1gsrHZEeTRV9FyeYlhIkYiwx5hTIAOeFi4XZlfPDbXJgLX6tizmKWOakM2CqEwCmmqV3ERRg41HpjZ/O2p2s5Pmw7XgIazAXnutkz5vVvWoO19JDEiA/CIfWZb9xpL8oyBVaAusZDGZsopS1b2QVfPbiKqY9ic4t8HtfbXc8L1kA24nN8nEFx+Jhw/CnvwfB2n/zNHA6R35JEbojeSe84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPZ/hLV+4BoBPaYkf8KVsgixUM81Ml4IcdD+HoqJrC0=;
 b=jVz7IG41xM1s5kQoRzS53oCApNouumTZck2DHJHNjQVrL19vZXCriRXQ2CuQ3zmKBXp1O5zkR+OynwuOA6nNYNO87w2qkz7euofsHndgn/Boq2utnlKcRRlIzIlkTY3UJRLLhRK13qSYIiYBeXoN0paS5PxtxATD5Mf0feZGQt3ywd8PLzxc+GCY/i6wKDBXZX4i9iZ8oEsnCt2ECm9lkqrSJMLlXugkzH2M9zI3ASMaNOA8t8CKgFPaUHId4GBCuLv02qXQur1aPEXPg4l6wjlcCAb5DbEvCStco5LqI3JOiZlfJ1aYvfraC1sRFMw+hItnHW7abCZi4PDa5FBdAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8232.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 15:11:48 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 15:11:46 +0000
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
	Sherry Sun <sherry.sun@nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	imx@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V14 00/12] pci-imx6: Add support for parsing the reset property in new Root Port binding
Date: Mon,  1 Jun 2026 11:11:36 -0400
Message-ID: <178032665378.3958634.13115385587092452797.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422093549.407022-1-sherry.sun@nxp.com>
References: <20260422093549.407022-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::32) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: ada1196e-b406-4238-8423-08debff018fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	7JZwYWLwNbd6/EBID7i1lww52XC5deJ1Aq8SQjgkv8+L5gFMGrpyxs4x7EVd8Ddv6GvtYD/eojOIj1pdeG+Er4wT6pHkERdOQ7E6N6rERle2aeAkYz68fNaTU5AExkg/k8BMin/ZlkrWcm3sHkznh7wrKaT7fk7zQT9TziutowGdSoIsmmC1Bzkkxzhla4RISiSWo4tTRNRbHc31tFaBXajKqFu/w/8xeQu6NZUZUWNhmRtGQhP/uSW49u8SoBFbj/h7Vu9+Q8Aa2NVGAlj62YuszjokReRaARh4QurTedq940A+z4WLizgshdS+rf97f6w0UuwDZS0nX0KaP5NiY2HMQ9JQF9hSqXS6sEEvQw3WqVxR58buHrIbWyvspqmJotisvcpbOmSna5qV/pPFqm1MiqWSX7Pj74i5lPlnbU4tPoIWDRAWXnsRduIox1ctvM9kzePhZVkUVN6C3VlaraycDQXykVKGM3RT2r5gz0Skkmv5S2hfQ3UL1EiVKQpa48ZtsqvEE79HGAJXB4J/D3VN5Qw2sTKnH5DcQ+kMxqbMB+HqDSFxdYg/Rip2uuPEsE7Kbp8W4pk/tg6EEBevRN7xA1cCZlM9gp/U7G//zbAe6mhu3MKQHuZJj1pGsKMjcOWrNx5/epApfChFM8n5+OFcE8OHfEysNDBfby9SOMnJfJVAK9dKcwctqMR+t0mSgyHHop4Ew82OKMA5TAq4iVB0m+TjIGmlMDGxTQloaWAey2LZ0kDRw6b1XCREHC9l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBWVXRFK2toZmRjNnQ2Y0RaL1FtaHJ5VnVnV3RVWEd6T3VFZXNyY2dRdEJ0?=
 =?utf-8?B?MWVGNHM5OXJFQlhzNWlvYThmSFk2cTkwTzhPRlBhTE55dW1vOVg1ajltc2xG?=
 =?utf-8?B?Wk5wNzV6amtaV3hEa1lnY1BHSXdUeGFGSnQ5V2RtejZ6TVkxODh1T1NwMjFk?=
 =?utf-8?B?aEtCK2pMbUVLQlJVTlZwVHkxSkpoYzdWK3VoM0hOdnpraFZFWGFXNEU1aUUr?=
 =?utf-8?B?RUxIWVRtaUJmWHJFRGVOOHlLcHhPK1k5YlorM2xlZDhOR3ZJNVk3TStmN0k0?=
 =?utf-8?B?RDRyZ1A2d0pWM0U3Q1ZFOUhCOWt3VVRNM1hJWkNndmhCN2E3NnltT2Iwa00y?=
 =?utf-8?B?TGJZLzNOdGlXQXFBWms3eE9ZR3BTaXUxYXFhSHNPQjk3aEh2R1JPY2lFNzBj?=
 =?utf-8?B?MDJlWFF1TmIwWC9zcHhMYzlmbVlhZHc3MmdRWnBNVm4xQk12Q1B5SkxtTXZI?=
 =?utf-8?B?MEV4bDNzU0lKakEyVzdWWTRjVDlQWWQwcURUUm50bFNxenJ0V2k2QUJ1Y2dD?=
 =?utf-8?B?bDZPN1lSWFJBcUt0T2trNmNsNVJxSmVjK3MzWTVTR3hlYWdRQ1dGME8zQnF6?=
 =?utf-8?B?ZXNVQmYxQnBnL01IRjh3VFBNblJjMTdwZWVmZHlhMW9kMEZBN2g1Q0ZvdkpU?=
 =?utf-8?B?a05qcnhPT2ZPS3FqMVFwMWxraVdCTUZRMkQxNjJydDFtemlOWHQ4Q2dtY053?=
 =?utf-8?B?a2l0YTBXeEwwQVBpYTBvU1o1Q0dFQkxqM0VBUlFBenVuaHRtRXd4OUYzVmgv?=
 =?utf-8?B?RHRNTDZmemhLb3lJZWRJaE5KRG5GT2E1YTd2dzQrM1U1cjhEQkZtWXdZMzdQ?=
 =?utf-8?B?RUMzQlFYbXVpblg1UGcwZWJKZ3BiMURBcGc4cGlrSjJoYlY5aitZNE1Yc2pN?=
 =?utf-8?B?VmxTNVE2QlY4RkhZTGhqQitlbUNCOHQzR2NzMU1ya1JJWGtEMFBDc01VYjJI?=
 =?utf-8?B?UVZrRHkxaEw5d3FkK0xqaDZkcnB6aURPQ3NQdUREVjFTTUJxMUxSUCtUeU96?=
 =?utf-8?B?ZmRSSkk1N3FlTDlSNVRpRGRlK2NrQU52MHVWNzlkN29TS1ZmaTdPMmNnMGlk?=
 =?utf-8?B?ZExYUmVDMFRSV0VRam8vTWZOSks2L2FCSm9tN3NUU2o5NFoybWRhVTBuQ3d2?=
 =?utf-8?B?azZYbW50SDRGVkNjR1VBRTF3OGxySjdDb1oxd0kvQm9KUnZRTW8rVkNhMzZ2?=
 =?utf-8?B?Uk12b3RuMHdwSGRxaGY1c0s3ZzRmZ05jTnBNTG1Kelg5SzlHTEpvSk13Mmor?=
 =?utf-8?B?R1BpeFJjVkw2enRTdVNCRUNQTEo4ZkRYNmVRc2d6OExZMlVFaDV5dm9vR1d6?=
 =?utf-8?B?NGYwWlFOekhOVFdHa1Nyc0pCR2t2WVZDQTZiaVY0NXVRaFhLSXlJb0ZoRkNM?=
 =?utf-8?B?MVBwS3pjVnhoRER0ZEhjRHM0NVVCeVBXUExDamJUSmh0SUw1eklKVnk2NXo1?=
 =?utf-8?B?elQxK0pPVTJHUlN1R2t5cUFtTzhQeGNXSis3ZUl1aGZmaTRrOW0rREVsM1Bw?=
 =?utf-8?B?WHVjYVVjblF6dnJrUEJqVE1zaCtXb3JZUndDYTY0YUhET2tNbUZHZU5pTkJS?=
 =?utf-8?B?cEQ0OHorQU1kSkNnbk5rdkJTUjkwL3RkbmtuVk9Sdm4rRHRlS0k0Mm9ndDhp?=
 =?utf-8?B?Z0g3bDZtNS9templNWhoWXdrR2trVnkxVDBBenlTRFY0aEdyUjROMldTRjNR?=
 =?utf-8?B?U01rL0V1WWpJUHhYb3FYRDF1OC93c1M3clFDcFFvOWl6amIyWEZCUkpQMXh6?=
 =?utf-8?B?bkVXYmpSNDJzcEpPWEhpMFRvNzFMeGJOV2EvU1ZnYlJOQ09vZ3R4cGN3bGMz?=
 =?utf-8?B?Y1FGbGprdWNQM1JORkplN2s3Q0QvcDNsVi9GWWsrR0U5c0tPYVBlMzZ5SVNV?=
 =?utf-8?B?dnYwTTlMVFhLM2d6ek9PQUNWYllkSHpIRi9CcGhSdjBncHBoT1AwTVZncm9V?=
 =?utf-8?B?TVVTcjdnR0xBb1MwZmhLcDNnaW9ZWERUV0FFMmJISURGMUFpL3BwS3ZXTm9i?=
 =?utf-8?B?OEN1TEVpbGFQeDNZSDFYeHQxdU5sRHZuNjhTVHc1SVVwUFN2WjhlOWg3bE1T?=
 =?utf-8?B?SmwzL1BaMU1oZW5KOVIzbm1DTHZpYk5vNElWMlJ6dXRjWEFpNnk2R3NjbVJt?=
 =?utf-8?B?SzlkLzBqSFV2K0NTZlVmdzZha05BYkVJTmluOEJmNGYySnVwN0R1Wk5aZys1?=
 =?utf-8?B?cW4wdUw2MlFpRXFDaXY3VUFPTEE1S2YzZGxnYXB4TWF4YkdEWUNvQnY1VXBF?=
 =?utf-8?B?YWV0ekR2RjIzTkpCcUdrMjFnSFYzUDZKVHpTWEVUemtCejc5d0ZINVF6a2pX?=
 =?utf-8?B?K3ZiQUc4ZVlBdkxCSmRqNVV5Vk5vMlNGWHQyQ0VTQm14QWNkMlh5YmY1aXg1?=
 =?utf-8?Q?qCAWa5mw81nUWvY8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada1196e-b406-4238-8423-08debff018fe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 15:11:46.7731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tAQau2dsdlbZbUBcm1EQYMqPlgslLI0HTvO7h1tnzkHbRbesiDe+BvESGFbESiXdlxzssZl0voPbofPknNEbJaW3D8nISvxr9hV+JRf8y1M8k2gTe6t0vmQuIeiukMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8232

From: Frank Li <Frank.Li@nxp.com>


On Wed, 22 Apr 2026 17:35:37 +0800, Sherry Sun wrote:
> This patch set adds support for parsing the reset property in new Root Port
> binding in pci-imx6 driver, similar to the implementation in the qcom pcie
> driver[1].
>
> Also introduce generic helper functions to parse Root Port device tree
> nodes and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
>
> [...]

Applied, thanks!

[05/12] arm: dts: imx6qdl: Add Root Port node and PERST property
        commit: 63452b5d4fb253c6c77f68ae73d17276a01d5a0f
[06/12] arm: dts: imx6sx: Add Root Port node and PERST property
        commit: 7116b986aeaba3690b4bfb6e313be2fcf07454ea
[07/12] arm: dts: imx7d: Add Root Port node and PERST property
        commit: 01500ef0a65107e49197621e7db93c4f3fd8dbc3

Change 'arm' to 'ARM'

Best regards,
--
Frank Li <Frank.Li@nxp.com>
