Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88CB44E045;
	Fri,  9 Oct 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550058; cv=fail; b=PzG4gbImqUZt6vhXIa79GkxK91SHCCTL8Og472GivD1X7pVep5tKwMIfbvMMsCeu5BWsVuFXnt2wlXUPeI5TBYSSjif+BFQfn6eCZl3zxdOMQroAv97eCI29BGLHxcVErlV46V6IpVV7oTafrMWkUTUQv+q1aXiW9QZIsKn/Y3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550058; c=relaxed/simple;
	bh=Dbas8rPd/EVhHgAtP0GLx4DM2k+lhiBRiLV1ahETCpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O1D2jGVqSj8WNJOVgEHeMVOQ2e7Y17Jyqf6Q7dBCMoTp1ijX5IHFtt7AioxyJJQdP1odG8ppDDr7pS1DABslBUD+a6M/3Onev6MRhWozZMwT8rJzAYxqfQYuG8kBWAjzzJEqZm8hcBycy2JWNIO/McdVvAaTIvDUvpgEwwtsu5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=20LTRIH2; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="20LTRIH2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQi8H+f5dQRuKlGibZyo0IJVgxCcHdcJB5lbeuiHjOd8PVBxoCbUnik1Ko1eooiTo/KM+1tFD+Y6NnX0zUsGdiOIkkVjcFJkvfJVXO5oIPYjlYgvY19SExvaxxiZ+E0nVqyYgN5pxWQA5jN6uFz/vmLwk2Qo2I3g6UDFYG2VuUy7WlU39DJ0bYZXVyOPI7H4xdpbWYBo/Hu592H5s+YCyzp9A89vd231FJeGhdTHlLmRvTXTs7HxHE26AGl+9zKBSMN6SSoC+tHkO74v8u0mqdB6L8YendqYT7uSoeeFmCQ1KUkSVAHTJ+qkFMNUm2gIcYy7PD+2n+mn8TkAsz0M4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se1K99RZX2BrfJAzo03VoBKvxP2lpshthRmWF80u7n4=;
 b=vdnjddE9St3sSo6wncQL+3O5y0uXm/TgFkTyQHs7XiHKgGLJenfXIxdkZSHTrRswYzgm8JpKdEaSZ4gcdtwjfngKpT+ZtjH18vcRlqxFki6wu1A06jZMMJCk8h+kDE9gFi8qVBl0Q+K+fXJ0qBKuNxeO09I611p14KW4ePtKMMnCXXhUUCO6WKJ6OUyPDDEOCWAjYiLaKNbezZAi04gw46ID58prLV7dgxlVed4Xcr0zqiaXxewgupA27K0DcK8/VqK/K/UvqCM+mPojt2sO93dn5sl8+xLKLPF6ztHDzy9ZazyV74ibISIEmFMki3MkJxo9VssCYTF4/ST+y/OzYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se1K99RZX2BrfJAzo03VoBKvxP2lpshthRmWF80u7n4=;
 b=20LTRIH2gY50WgOWqMtNuAG3kHn6altJUvDDSzM1865iuCV2h4FtpmASTdFn64IOrzqc03B2A+9lXN1ZVUc+6Kk5AQ1wbTlEsn/rN1V3pk3/HZM4pjHv1VLcK9EZq0tGKozuCGE+Ilrt0E7fJHGIDxcI2emkQVu/BsLiStHhKPE=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 12:47:27 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 12:47:26 +0000
From: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>
To: Freeman Z <SHD-ISAC@outlook.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "westeri@kernel.org"
	<westeri@kernel.org>, "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>, "Natikar, Basavaraj"
	<Basavaraj.Natikar@amd.com>, "Martinez, Juan" <Juan.Martinez@amd.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Topic: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Thread-Index:
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEIAAHYuAgAAI8kCAAAk1QIAAFJeAgAQrt/A=
Date: Fri, 9 Oct 2026 12:47:26 +0000
Message-ID:
 <DS7PR12MB95504FE60773F44B1950FEF49C922@DS7PR12MB9550.namprd12.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <20260925115041.GX106095@black.igk.intel.com>
 <5d065dcb-a4b9-4e9d-aeee-8a9bd1d875d7@amd.com>
 <TYCPR01MB10927F1B586DACDC97FFB606A96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <7822cb02-f32b-4f02-ba65-4b90ebc42ce8@amd.com>
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109276162440B6A8CC34DEC73968A2@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB953383C9C73C9715FB9C5A339C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB1092779F2FA9CE76D5A76E4C396962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <051b667e-eaa9-4ad8-86ce-1a326a612284@amd.com>
 <TYCPR01MB109273BCB71161ABE3AD85A8696952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB95503B5244149768A62590099C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109272C6ADB253EBABEEB30AC96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550496ABBB70227D5B2B0679C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <DS7PR12MB955053FCD5A303347E165D429C952@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB1092781DD2EE8EC1EEAD4A52C96952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|BN3PR12MB9570:EE_
x-ms-office365-filtering-correlation-id: 8119f1a7-d075-4770-555e-08df26037922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|6133799003|3023799007|38070700021|4143699003|5023799004|11063799006|260925022911599003|260925021911599003|260925021311599003|56012099006;
x-microsoft-antispam-message-info:
 PMS5xnrivwN50p+jlXwADNNZbWglFOxPehsS4ks1cfzpsVe5w3cKHKvNl9+kk7IPE4CQv/EzFt4AiB/py1GNckyxVqnm42+M1kw3QrHsWJG/jy9OGZij+Kmes4TQqV30geoUFX7tRwFBL5vlO5ySJTZYOLY0Ie4Bb6lmD9/gUneT0F89h7VV6vtYL6uz/mHirmxiVVUXesh28VgyR6dshJsE/6URI22PZTY8FR9ok+zphYiZ8n5QVKuTgwou8wE0J55kuAtfMJUFGtSnz9wyu0XtVnMe3WhRodQemB73A3YGxU7XxI0Zl0r5g7m5XuLwCQRQC6jHIFSHxtvMlv/9L4riedoJZaPycPwvrL2o1jU6MFRm8tvWKVLtdRjJRV2lzuQAUgrCCL/Pna094w43bOiZtHMyCtR0FVHLw1XD8QYD1Z889c5LjJWhYN9MQcSOO6RKDVx4DQWwiXDN8kHpLyBEnuDBLM2zPecsIZ3BYwtPkmRgHwIqfv2Qr4mbRxwKHKEsbzbcGfkERFdoKo4rCOB625RWN2LCdKpc3wjzMbtkeuzsgI9sLQDeUNuj9b4wdm3kqlNKzTa/aBdciE6/TbgM/let0IcaSFlauJzYgxNDrm3Od/vxY/Hi+rEfI2PqqteSpTACTW/636yJQAQHBNTs/bc3XBwFUX3Tue8mikCi+O1BS9VUXFpDCaEHCFrmIIxpx1vTwJgUl/QyvBUGKHeC9l2a3+/p6JwubNsrDK4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(6133799003)(3023799007)(38070700021)(4143699003)(5023799004)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IKDYP/ZROfAAqQyFDoh8w2aYvtpknQQL0n7uerqikV75fgp/NDtJ/eaZhfeI?=
 =?us-ascii?Q?TCof66jxZnrU/O4QKFu+P/dvpzIG/Avgmb9DjxbyQhVu5XDhjBtGOxbiyPAI?=
 =?us-ascii?Q?z/xLZ3Uya1DGzq/JVu+WlxSDRW/glg6qmbRj0r15Ik9DZTqDFh3qeFo7xobT?=
 =?us-ascii?Q?/XVzoV1scAYakRYcolpm70zwmk053nVWLREAL1bqwGtff1WGJWJ/DXr7ZlLj?=
 =?us-ascii?Q?H+3i6bR7JZ92htHGQXs7XV1LoTvvlFPQaEFgGqf1XMkUSGHK8Hnx7mz8sQCS?=
 =?us-ascii?Q?gkzt6xjfHFIE79aFrmiSeplaa3meupG/xtZq2juzNdFcOCWIdXBqIBiU4LoO?=
 =?us-ascii?Q?zi7tZtjGgFaikkkSe29Wk0HnYhjjJZOQ915k9Ss+flgA97YOUJcy0G3qQjRn?=
 =?us-ascii?Q?SnOYiLXVyelZl060hzl/p0PBsM16UbmYxqkWT+zsUzfKOuW2w8tcSkTd8KcD?=
 =?us-ascii?Q?BOuKiydZJxVOv6T1EtsLGJ5eP2w4VIdIE61N5yEL3I1zK70PybzKWq/Kv1ge?=
 =?us-ascii?Q?wteWjdzq7su0brWil0SKXHBBsNQG7DcGbKfMUz2htfIUPvRfHrnLhESi0DHy?=
 =?us-ascii?Q?KopraBdx5KZH3xLGYiSynJ30yFlJG7m+3GLmz30z7YwMjznp5vFzLALCLo/c?=
 =?us-ascii?Q?3IEHN6Y3kFGXVBu1tHY5D87lbyKMlBWBGvVQQRS1BhfCSKEyLhhMKEwuE+91?=
 =?us-ascii?Q?bfdDG/818rSBVeBJMbP1SBXuoKrqh8SeQAp4CpGTLZEAPEDqR2UZx4rULDsU?=
 =?us-ascii?Q?x2vh8kfHjp/EfpAa1LqeJqnZF09Gm6UKEB9jnPtoOSVaU5xIaACpBl/tNdkp?=
 =?us-ascii?Q?SEX4Z9FxG6tDd5z50YuSvd+R4S86FclKRsuImxoDm9/mJtWlkLmkxHtFHHrC?=
 =?us-ascii?Q?J/7m4LdV8lhheNUOXX1MU5BgBszk8HZaGHFYmubEWFsg/lk33UkMGVvYQH0V?=
 =?us-ascii?Q?v6giqZJHKK8mRB6cCso+bmXoBgiiwvHaBR0priiSDf3oh7GlJQfIcHfgyufZ?=
 =?us-ascii?Q?D8sgXLcRduQMFn2Brk4Cmt/IiVbA2Y+dWgQfLAPAtAOB+BfcCjoPlRP5GXP5?=
 =?us-ascii?Q?sKp2Y5nMssBF7NAQU04iuua8dIpdd4T1eT2KM4UrxjIQ80JdZChRGp/tciqP?=
 =?us-ascii?Q?BOpduZ7uCqzHEwbFsLrNcB+SMUmaRpntsC3y58h8xlN2dtsb1riJtUeIi07O?=
 =?us-ascii?Q?6aiQ2LyV97oPIWkr8Ix27oz1q4niziko+MScZLCjYJqc72Dp5ysIuRNp3p0P?=
 =?us-ascii?Q?5oYMM1lGE017ms9cfHtaV1mEHYZFRHfNubcAXN8l+ziPzb13kNa/2bqF4AxB?=
 =?us-ascii?Q?Kf6YSEgfURPRSWqF2nbLxLHRpTbH/k+5Oik69WOPULs06GTz4jL7rwKF/HaL?=
 =?us-ascii?Q?nxCVJSF7wDgXMUIQ59/zw2FDggVblO8aI0f1iynGbtaLm6xIY6Av732aJttv?=
 =?us-ascii?Q?SdawzQltr2blh91AGhwinU/EPVzkEJ4pdUuPsKglj73lps//eP6Tx4GUQ+rU?=
 =?us-ascii?Q?LAT5PVbn+f4ri0lMtJVHQEF2eX428EttqLqwW8F6bazJU25JtFFiSHiaDh2z?=
 =?us-ascii?Q?tRBCDcvtdrjGTwxt3lOdxAiJIMTzkVpWIht5ObHuC8CUDbvNq2yqJtIlMYwu?=
 =?us-ascii?Q?0AlXGkbNWAuzhkzh/lwHOFJQ/7dIb1lX4EZ3Qi1S75bOechtGUebVte4ADtj?=
 =?us-ascii?Q?TrSR6+L8WSkO0RzkO2qvxJOMTCBqPhshKKfiLkHz7PcR0e+2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8119f1a7-d075-4770-555e-08df26037922
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 12:47:26.8418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zMfmZvX65qciQIasJlS4REKxTdcWPfDU9MeSwktaWmn3oxUnfYSzhoi/j+HMksUt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570

AMD General

Freeman,

For clarity, the D3Cold Allowed set to 0 and 1 tests were on the Catchy OS =
?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 4:04 PM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

Yes, with d3cold_allowed=3D0 the dock enumerates without lspci.
Logs for both cases are attached. Each was taken in its own cold boot with =
the dock unplugged at boot and the workaround disabled.

  d3cold_allowed=3D0:
    before hot-plug:
      00:04.1 =3D suspended/D3hot
      NHI      =3D suspended/D3cold
      09:00.0  =3D absent

    result:
      PASS - 09:00.0 enumerated naturally

  d3cold_allowed=3D1:
    before hot-plug:
      00:04.1 =3D suspended/D3cold
      NHI      =3D suspended/D3cold
      09:00.0  =3D absent

    result:
      FAIL - 00:04.1 remained suspended/D3cold and
             09:00.0 never appeared

With d3cold_allowed=3D0:

  gpe10: 27 -> 29 -> 31
  gpe1A: remained 0

With d3cold_allowed=3D1:

  gpe10: 23 -> 25 -> 27
  gpe1A: remained 0

GPE10 incremented by four in both cases.

In the d3cold_allowed=3D0 run, the trace shows 00:04.1 receiving an runtime=
-resume request shortly afterwards. It reaches D0, pciehp immediately repor=
ts Card present / Link Up, and 09:00.0 then enumerates.

In the d3cold_allowed=3D1 run, GPE10 also increments, but there is no runti=
me-resume event for 00:04.1 after the hot-plug. It remains in D3cold for th=
e rest of the capture and 09:00.0 remains absent.

IRQ 35 for 00:04.1 remained at zero in /proc/interrupts in both runs.

SHA256:

  d3cold-allowed-0-20261007-041520.tar.gz
  5e0af29245592916fb1682cc0bd3bedfcd75a1863d2d1bab0c2ab72bb14bc292

  d3cold-allowed-1-20261007-041802.tar.gz
  3f6e00600e65faf5fb5fd43f6d753c3900e6247500fe5f3297b6d23e25a0a8c4

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Wednesday, October 7, 2026 3:53
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

Thanks for the update. BTW can you try:

BEFORE plugging the dock

echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed

to see if the devices enumerate properly without the lspci. If they do can =
I get a log of the fail with echo 1 > /sys/bus/pci/devices/0000:00:04.1/d3c=
old_allowed
and the pass with echo 0 > /sys/bus/pci/devices/0000:00:04.1/d3cold_allowed=
   ?

thanks!

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Kovacs, Alexander
Sent: Tuesday, October 6, 2026 2:18 PM
To: 'Freeman Z' <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciel=
lo@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Freeman,

I'm confused, did /sys/firmware/acpi/interrupts/gpe10 increment on plug ?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 1:46 PM
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Limonciello, Mario <Mario=
.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

I reran the test with both 00:04.1 and the NHI in D3cold, polling the ACPI =
counters and device states every ~200 ms.

I pressed Enter late, so the manual "DOCK PLUGGED" marker should be ignored=
 for timing. The first observable hot-plug effect was:

  01:54:51.116
    NHI:      D3cold -> D0
    sci_not:  8 -> 9
    gpe10:    unchanged at 27

Then:

  01:54:54.083  gpe10/gpe_all/sci: 27 -> 29
  01:54:55.152  gpe10/gpe_all/sci: 29 -> 31

Despite those GPE10 events, 00:04.1 remained suspended/D3cold and
09:00.0 remained absent through the end of the capture. IRQ 35 for
00:04.1 also remained at zero.

I went back through the ACPI tables and noticed that GPE 0x1A and GPE 0x10 =
appear to be two distinct wake paths for GP12.

In SSDT17, GP12._PRW returns:

  { 0x1A, 0x04 }

and _GPE._L1A sends Device Wake notifications to GP12 and GP12.SWUS (as wel=
l as the associated GP19/NHI devices) without checking PCIe Root Status.

GPE 0x10 is different. In SSDT16, _GPE._E10 is the GPP PME dispatcher.
For GP12 it does:

  If (\_GPE.ET12 !=3D 0xFF)
  {
      \_GPE.ET12 =3D
          (M017 (Zero, 0x04, One, 0x78, Zero, 0x18) >> 0x10)

      if ET12 is 1 or 3:
          Notify (\_SB.PCI0.GP12, 0x02)
  }

For 00:04.1, offset 0x78 is the PCIe Root Status register (PCIe capability =
at 0x58 + 0x20).

A GPE10 increment only shows that _E10 ran; it does not by itself show that=
 the GP12 branch saw PME Status set or that GP12 received the Device Wake n=
otification.

In the earlier full capture, GPE 0x1A remained at zero in all three
snapshots: before the plug, after the failed hot-plug, and after the target=
ed config-space read. 00:04.1 remained in D3cold until that targeted read, =
which immediately caused GP12 to transition to D0 and the downstream hierar=
chy to enumerate.

GP12's _DSD also has HotPlugSupportInD3 =3D 1 and associates the port with =
GP19.NHI1 / USB4 port 2.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Wednesday, October 7, 2026 1:12
To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello=
@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

AMD General

Freeman,

Great, thanks for the confirmation...

Can you try:

get the 00:04.1 into a suspended state
Run:
sudo watch -n1 cat /sys/firmware/acpi/interrupts/gpe10
Perform hotplug of dock
  If gpe10 does not increment when the dock is plugged into the suspended p=
ort, that's proof the wake never fired - and it's likely the GPE-0x10 _E10 =
path. If it does tick but nothing enumerates, the miss is likely downstream=
 (native/pciehp
  side).

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Tuesday, October 6, 2026 11:33 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alex=
ander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.c=
om; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; ra=
fael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Na=
tikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez=
@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Alex,

Thanks for checking the tables, and Mario, thanks for the explanation of th=
e _DSD -> XDSD rename.

That is consistent with the suggestion that the XDSD rename may be an inten=
tional way to keep an unused reference-code path disabled. This GV302XV exp=
oses only the 00:04.1 / NHI1 USB4 path, so the NHI0 XDSD issue appears like=
ly to be separate from the enumeration failure.

Since you haven't been able to reproduce the failure, these are the conditi=
ons that seem to matter on my system:

  1. Cold boot with the dock disconnected.

  2. 00:04.1 power/control =3D auto, with both 00:04.1 and the NHI
     (6b:00.6) runtime-suspended in D3cold before the dock is plugged in.

  3. No PCI config-space access to the root port before the hot-plug.
     A config-space access wakes 00:04.1; both the targeted 4-byte config
     read in this capture and plain lspci in earlier tests caused
     enumeration to proceed normally.

I captured a failing hot-plug under these conditions using:

  kernel: 7.2.9-1-cachyos
  BIOS:   319

The capture includes runtime-PM and PCI hotplug/link tracepoints, pciehp / =
ACPI device-PM / Thunderbolt dynamic debug, and ACPI GPE and /proc/interrup=
ts snapshots before the plug, after the plug, and after recovery.

A redacted archive is attached.

SHA256:
  4d4d7f64aeb4a2bbd8e68cf221de2002ad427d3456fc8354c06f3d3760dad065

The relevant timeline from kernel.log is:

  98.774
    First observable hot-plug effect. The NHI begins resuming from
    D3cold. IRQ 38 (00:08.3, PCIe PME / bwctrl) increased by one
    between the snapshots, which is consistent with a PME wake through
    the bridge hosting the NHI.

  101.015 - 101.017
    Thunderbolt PCIe Down and Up tunnel paths are activated.

  101.017 - 135.664
    00:04.1 remains suspended / D3cold.
    The NHI remains active / D0.
    09:00.0 remains absent.

    No runtime-PM activity is recorded for 00:04.1.
    IRQ 35 (00:04.1 PME/AER/pciehp) remains at zero.
    None of the counted ACPI GPEs change.

  135.664
    The script performs only a 4-byte read from:

      /sys/bus/pci/devices/0000:00:04.1/config

  135.668
    GP12 transitions from D3cold to D0.

  135.681
    pciehp reports:

      Card present
      Link Up

    Its first link check after resume reports:

      lnk_status =3D 0x3011

    This has DLL Link Active set and no Link Training bit set.

  135.808
    09:00.0 [8086:5786] begins enumerating.

A full lspci scan was not needed.

So the PCIe tunnel is established while 00:04.1 remains in D3cold, and a ta=
rgeted config-space read of 00:04.1 alone resumes the port. pciehp then imm=
ediately finds an active link and enumerates the downstream hierarchy.

No wake of 00:04.1 was observed during the hot-plug window.

The kernel also logs:

  Wakeup disabled by ACPI

for 00:04.1 on resume, so GP12 is ACPI wake-capable via _PRW.

There are two observations I cannot explain yet:

  1. sci_not increased from 6 to 7 while gpe10, gpe_all, and sci
     remained unchanged. The snapshots do not timestamp that increment,
     so it cannot yet be tied to the dock insertion.

  2. The final Root Status of 00:04.1, read after recovery, shows:

       PME ReqID 0021, PMEStatus+ PMEPending+

     0021 decodes to 00:04.1.

     IRQ 35 was zero in all three interrupt snapshots. Since Root Status
     was read only after recovery, I do not know when these PME bits
     became set.

Best regards,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Tuesday, October 6, 2026 22:37
To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlo=
ok.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.k=
ernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google=
.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <a=
ndreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; ra=
fael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vge=
r.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.=
Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (Ace=
Lan) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

On 10/6/26 09:33, Kovacs, Alexander wrote:
> AMD General
>
> Freeman,
>
> Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the =
tables.
>
> BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD`
> (00:03.1 / NHI0 path)
>
> But that more than like does not have any bearing on the root dock enumer=
ation issue...
>
> I am unable to create a case where I can replicate your fail on my test s=
ystem yet.
>
_DSD -> XDSD is a strategy I've seen employed when someone wants to pick up=
 reference code but has a difference in their design (for example they don'=
t have a retimer connected to the second USB4 router and disabled the IP.

I don't know for sure; but my guess this is a strategy to avoid technical d=
ebt and mistakes when merging future reference code versions.
