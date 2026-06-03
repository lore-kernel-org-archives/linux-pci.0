Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6791A38425A;
	Wed,  3 Jun 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478245; cv=fail; b=Dy3RpAWsXKG3dyuk3RCRfxDd48Z2zkd35al/D9STGmJhp5L1WDAs2SHhrKvVOjnJERwi8PR9SKBDdVbNWpS7INHT4ENg/2ZIBbQQEnySttpiS+gcTPzt/ro0TTrihbhZ1XK/3sYS0oMDTi7GurrQq7nSNbYDHK6l+godyis8gig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478245; c=relaxed/simple;
	bh=fdjG1HhRR9oIKOnd9ZuPfEXkeH2psY964RFoI3NuR+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U7WnSVvOIorI+19Sph/af7Q/kvSM0EA1Dn6MOOYvJR7ldG/s7tDj1uVNufJg1gKkR3+M+VMnmuMpRXiYbmtMqBavqboof6BEOWR4LDTieYlhmHd6Xq2ZkUAs3X2OegJCzFbB7cGGb2NKc6ayvmZSyDO88k7pupSmmAnym9lz4Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0dnfbOh; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0dnfbOh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xt4OSoFXPZx+2IhfnsX/afzhlhBNuNNbrYzHyrM4VFM3Vor6BDc2h7FKBWt4EeEalc3HMnl0vaN/mAuaaQGjHnXsPKeZi7wmeCTX20AdJVrV6qtjGfGhbM/RQOc/CzL8J80btEeFlkrHSYR9nM0sFO6aeLYI3cfItM2x2PtoLxUs/Jl1kXojsK1q03ch03dATiu6F5ObZbpEK0dMgn9O3RIp3dhWXXli1RIizLKvD8rL0Osrce8f3WZlf+tJgMAfGOQy5C5s4v55wrVQqEy12U2/tibhg1lBg5arozERtzoYMv1cUTXCVPU/CuoyWMAqBYHWS3HWEXMZO0mZBtcJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdjG1HhRR9oIKOnd9ZuPfEXkeH2psY964RFoI3NuR+Y=;
 b=Ie3qVMmKoYxC5P5gQ4ZCNf9l1h9CRzRt/sqqgUa6RYuRVvMUVbKc1i8wOu7s7h1goef2Bytq0G8RjOfBeqcd0k19WXFKReWYHwbIS4dcA210YR3juKoh4L0NiJfHG7ijn24nyU07Y6bFoZnt8XnItfdeMonDZCzIaaJynoWF70bmCHkU7M4JKSyqdkKVnfrzo6LofowrA7V/CrK9hG2P9KZdEnPnFluJhS+SnkAp/xSLzESiF203HOY9bt9mw93xU0eDpoTNE2IR4Ho+09F8rAA1QKLDhh+exVnAKXzm/7rXorwJMMFPLRePai0KuanpGK8i/UNmp8xUdFAg4gToaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdjG1HhRR9oIKOnd9ZuPfEXkeH2psY964RFoI3NuR+Y=;
 b=X0dnfbOhvBXkuWpPn32HpsoGF0quPMYHMiofdCUiKvkdd5EEFKELPv8poFxjXhe2W2JqfJexX4n633ZjbdY2rctu6DddM335QDwfm46ret0Ebt2LPbX4ULjlYc0JLo8zsa02VuDpejaP4AJM8qJ+YaSGERak26NYXnHFm6V2zuHch+E8gIrF1HPZn/rr2hQcSU4pr5ZjMDfV4ricj4WP+SFacwVCsabkKnqK9puLgmM5UwujFyU+WEVrUk79b54pnTwus/GjAjVMcPSWOBACMH1sbaBpON0mt4in08nXhYVAaQHsbP5trtbeSzc05rolbrsMitkmolajGok2KaMwqQ==
Received: from SAVPR12MB999121.namprd12.prod.outlook.com
 (2603:10b6:806:4e7::18) by LV2PR12MB6016.namprd12.prod.outlook.com
 (2603:10b6:408:14e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 09:17:17 +0000
Received: from SAVPR12MB999121.namprd12.prod.outlook.com
 ([fe80::93ef:92fe:74d1:380f]) by SAVPR12MB999121.namprd12.prod.outlook.com
 ([fe80::93ef:92fe:74d1:380f%6]) with mapi id 15.20.9913.009; Wed, 3 Jun 2026
 09:17:15 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "alex@shazbot.org"
	<alex@shazbot.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHc8llUjn8y6mjsCU2e97g2INaIobYsfiIAgAAKCxo=
Date: Wed, 3 Jun 2026 09:17:15 +0000
Message-ID:
 <SAVPR12MB999121C53E93D42F89C39C8949B0132@SAVPR12MB999121.namprd12.prod.outlook.com>
References: <20260602063015.3915-1-ankita@nvidia.com>
 <ad24ef7e-9e2c-42af-b2c7-8b72031ebf0f@redhat.com>
In-Reply-To: <ad24ef7e-9e2c-42af-b2c7-8b72031ebf0f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAVPR12MB999121:EE_|LV2PR12MB6016:EE_
x-ms-office365-filtering-correlation-id: ec5cc789-941a-4eac-87ee-08dec150e77d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|4143699003|3023799007|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 7mAnciRAwFzdTTpmS/XvBYAPnoA3xiQwR8QlL08UsbAIAm8G/qlEBncNJA8IFmymh3CcJzFQ07z/ohy6+VMzF+nS/TFYVNHIAMTo8PIkZaiespqTyU1f1vN+W219SB8AuYk2UKkJVFU0BpgzTEr0XI7nfFYvDDbhXnBbq1SkDxQENrWLAHhhyTIOG39vrYaRkeo1XM7nJAfN4hTCChSdzRbh1p+u9VYjdkvLgdj5ecvPGtRU4betd4pQTBSQZcLg+hzc+5lSw0JHLWJiQ1yAPnNQITPkghPo9429MDnYDRpj+dty5VGzgmBm0W4oeFFPxvXOn/Isvoj6LBLLH3zxHcnkLpr8+1P61Vm6g9P+TEAQ+KQFMWW3tYR3Lxt2YDq6WdZ8yp7Rj0CVFvIo1CFYqadUp8NqJiEatOvsCxaK23eaN6IL8A9oQkm1E5xEFo1UOItlLX67YJchwnT+vHB8ATVBfBxve2Jq3JQ9Cn9AD+D6ePbK6wYRaD3+Vu5h5yVRbue7fsnU94akejnYCXNPJAu/G8juMJibhumcqMWSNwqRAYORFBPKn8PhZYrTbit+a3NhIZau0xqjUXm3QZcTM8bSMRK8pLvJEPwd2frXHxM0y1CXlJ0G7PVkCN+RUTakVmaMldrXBftj5jpGnHXGosf0oNN6yxJQgYB0kogcF/3YQOzy4QF10Y4lhVq0iufA5CAUi6Rux18WQjaNfEmiIDG1fjZbMPYbvyGq1xWsXmpcSSj2mFzs1A09ITjV+3nd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAVPR12MB999121.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(4143699003)(3023799007)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5bzRtMJfFmIVYFRxbt2p1cXj8x5a5cKYbjiiO8vQ8W9uceZsnIm6laY1yP?=
 =?iso-8859-1?Q?YQcDfrgtMseWjjynBON0IDX5WbDMKhePAfgnsBDKpj5W86r3OGpa7tOLet?=
 =?iso-8859-1?Q?mGLstYwwITTHzg7iwEvcTdG27tPmD07G4frZuzMWGAD3G1BpF988KjbPoe?=
 =?iso-8859-1?Q?+sFUsz5lu4Zy3J7b0ntqmigKlfkUTLLIglXmG4VhPPm2N4XOo9BzZJAD9t?=
 =?iso-8859-1?Q?AGhlDF2w8xG6Rr5OWso+TkIYwp5+cEZqT8kbungYK7QSMov4VCIT5DqBoP?=
 =?iso-8859-1?Q?0JjAIlQBODedJ5gr/oYLSSGIOvqIhmgkhK4kUae+OKBrPuhicMSf/7Jjjz?=
 =?iso-8859-1?Q?uF4BsnIiuMWX9PrH5zTi26/wZ8P+Dupq9/Bp6LdLpYsMJqqNuYBW5ekTEz?=
 =?iso-8859-1?Q?oNUb46m6ymhhTObF74rb2FngOPYrqlvbEtHbwXUuXOYuPmGNL1prphPhMA?=
 =?iso-8859-1?Q?bpt8zyB2eceovl1AVSIy9jQRgSP7P/Q5PThbfuYvsA1l6zEqviPDCXRUGF?=
 =?iso-8859-1?Q?r5rsR8wldKdYiKsWqbbXezX9/nxvK5mi5BfpVlZp+602nmVSD946g85GTW?=
 =?iso-8859-1?Q?APDpG37hG3J8ZmNu/RehiCgA7a27n3EDjFAnv5OsPqcFhaJOIRLO2QN6E1?=
 =?iso-8859-1?Q?Hhm+mRU5soM2X9W7aIXcPYnJwGgJEpBA7GnUGqP3cGlu3ylXYjQ98NVPJX?=
 =?iso-8859-1?Q?jfxZoNGSjSLuZtnNuWuSi8w4UyzYoIXg8c95jU+FScCLTcWD4VKRXaQK0p?=
 =?iso-8859-1?Q?m2zq0PFDkq5xMEPw6p2pM7imCsQyFQJtxNzWPYeGbv3MQC5ctIWdWqCjS2?=
 =?iso-8859-1?Q?VZaNIhSPt5pu2zibZIhJzBK9sIK2yne8JEfbidupDFnmktR8tTG19XIkxY?=
 =?iso-8859-1?Q?DxkeLZ/Jzbb1RNPZY/xqx65gUFZDf2VlvUa77XfISaiYVfTGAE1+JscR0e?=
 =?iso-8859-1?Q?luXnyZlUsp65zUEJXPriHonerrbFbnuFq1BCmZ5UBRZmmZ6Q/W8RJuE+Fx?=
 =?iso-8859-1?Q?1mk4pJr9krZoMoaK8E7UL4oIUfCITDkOmSwtY8dMrMkYOYp+ikPzGFwtHJ?=
 =?iso-8859-1?Q?UUJxhw99m9JSh/CCdKFP6stxMzboxhDLAGTtP1XqR0eXNL3Yao2xZnvT3Q?=
 =?iso-8859-1?Q?cRhdUDTKJJPZc4mCm7eNczVtx9b/UaHAtvub6uwZzIYQz5Xd5NlBnm53E3?=
 =?iso-8859-1?Q?R85UJQCVNpwyphYhDccBU+i0Wx1EtzzVnHxEYilAl+7cp6/qRaeCdfo47m?=
 =?iso-8859-1?Q?lJPt5zL3EIg6plhMCTVQYgmm1edw8CaHfb36mhbFd0ZBRpAuICQUdg10Y6?=
 =?iso-8859-1?Q?VxsUYWsRIrsjDWf1RvT58MsTGDspNaeuypk2w5FrgXeSlR+z/JhMrlqke5?=
 =?iso-8859-1?Q?q2ScyIWtuI1npFhZZ/GhokwKhspwf4U5AijHXri8M2/8pygA99mHUsAu42?=
 =?iso-8859-1?Q?SlGjaJq7UcU10I8rX64uozibU5MwnP+GzNPOfTx+5jHF07NcYtr0Yf4Gmu?=
 =?iso-8859-1?Q?uAnBMo7ApjFe2EQFVZuUzedA4jmnrcupNz+VPOyo/YdklRsUEMH4WcjaaL?=
 =?iso-8859-1?Q?lvPww5aO1d4yQKlq4R+rUhURGtWGv6REfWGxTXT1PmgqGxiMTnvQGKisW8?=
 =?iso-8859-1?Q?c6gOK3GLYNBBr04hf8SSti+kAc5+mSNORvTxbdiw7M+EpYC5UTVseh0bWa?=
 =?iso-8859-1?Q?OUcEWmEcOkl0uqvdY+OVZwEe9CiRHSeb42DnbLmFqROT8JtqWSrXd8y1dj?=
 =?iso-8859-1?Q?8TRaoeRQ3cR9/5THAh2CSzSP0mJ3YKTSuE/WoIH56fV3FK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAVPR12MB999121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5cc789-941a-4eac-87ee-08dec150e77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 09:17:15.7875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnuGgvTIcKmrJnEl6OpBViyRMTjdMCM0oB9v9zq7uK1f3cAyzNTkyn1j+1ctCTJqa6gaLh8OyVVCRBcR/GyUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0 dev_set_drvdata(&pdev->dev, &nvdev->core_device);=
=0A=
>>=A0=A0 =0A=
>>=A0=A0=A0=A0=A0=A0=A0 if (ops =3D=3D &nvgrace_gpu_pci_ops) {=0A=
>=0A=
> Shouldn't an update be made to nvgrace_gpu_vfio_pci_table?=0A=
=0A=
Hi Cedric, we don't have a production device id finalized.=0A=
=0A=
So binding could be done via new_id / driver_override to exercise=0A=
the new readiness path.=
