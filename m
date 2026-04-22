Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387724886A;
	Wed, 22 Apr 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865996; cv=fail; b=EGDGqVtgGR5qO7K9QAjsBz7zl64cfsoljGY+wSlAyXX90HwFeJTLpaSEZ7kS5EpPMThk3G6cMP+b3mXjrIBOS2JwxU/FfjnGtPYyrIbUpsvUM40fLM9zTtpUdETezBg/T7V998Jw4XkKfP3nIKX3kqvGPopo7SukscyMj1hxYaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865996; c=relaxed/simple;
	bh=u1RfyaBpv4fPJlP9mdg+EaA3UiiTsThes8As2kgO8nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XRqg8+ehy6QmFZzep4nLCNmKo20vPP5Ab47DeVE8aYCqX7z2S63ipXGcS+z28nVY7Lmltn3pYlYjXALMwImltmyEfhBypBazDcnJ7mnkm9WsM9QD9E2k9bAbfNG7kr8dC6qaau3agKEuvLiZ9rX3ErqnG0/jDuuGHHB2wKR/T6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LjELJeCQ; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjELJeCQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=priDxM4ht6WnTVCt0k6/bwHtaO8RGSX3e+TurFuqDVuiyGbM4UAoeLeQwJ/NXyNNSRjLj8yoYb5z/G87LbpnrJXvTJgSAk/Upn/LYb0UQy/bfMYrPsV8oRa68HZEdn8bhukJ6EqyJdY4+aHsJPjV7cmROvTtChHl+4SnlrlKngnK6d/JvTqLFCHDV7LhEuuZNMs6O0/3uNnuJ3T62C+zQIKwVGxE9UOjBDQ0D3x2Nsb9RtgEqjKXDt3Sqxl6OBIVHv3XGbLYwgXrF+4sQp5WqXuVZD2YGTTh9WWXCar1Yl9cCCETP6Ddaxtvzfutze+sPaFEtV14OFpRLs316Bb0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1RfyaBpv4fPJlP9mdg+EaA3UiiTsThes8As2kgO8nU=;
 b=YtUayZYxSyFG3vw0gcLJwRAiZH8y0yXYzk8bA+auFcRxnROammXtIz3TcPrWkQG/YBGkcxdkfYfFE/4iLL85GqJRXqGnOZWw6lJkfWpdOqhlSE9ZdMPRDCzq61twtDBsnmmImvJ2kGsRHJW5VLpyd8CJjJcTAEnjnCkcc7rhodXWQ5IbC2aMBVnHFiw55ztM7cZmRBG2xpA4OkXs1T+EDUnAyk+4/vSb5dkyZ7EXBSwB9iLP+37e9sjbdZ9lk8VUnbZ8G60nV4R9vrnOCj9E89mQe592PIlV/qqvHbKWJ+uckC7i4BsbFAyE9G2WYyQ3GP1G9MJbdELqgo3PcTJZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1RfyaBpv4fPJlP9mdg+EaA3UiiTsThes8As2kgO8nU=;
 b=LjELJeCQUgvk0Kb9gPVszelRETN3pdVdXVWYDHogYIivXY+faiZUvyAJ3SamTabDh+UuCzMRAlaDJNbxoy9MJVy6PnYQmbFGnjqJWFxaD06NYofQtW+LyPEApsukWXyWVr1IWah0fBS83MuzD5m7UI3uXRl6IEYYizc0q6pqWig+1QdBfD7lN+rhRdeY1gdo0H6pnrK26z8TcxqU61rdnvP6GtfarStl7wZmQIB4fl7q8Hc+qNXp9ufWo/5ktFPsqUe6UqGvdWHfgc6921BBH4lCwifpnieSbOYLWCdt392KeUpdCQOVDDX6SU8ZbhwEuidQNw2x+ZAZlZRuHGSbrA==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 13:53:12 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%5]) with mapi id 15.20.9846.012; Wed, 22 Apr 2026
 13:53:12 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHc0Zgo2hBh5DA290mJYllfRy6fsLXpj50AgAAPNW+AAWmPAIAAEihH
Date: Wed, 22 Apr 2026 13:53:11 +0000
Message-ID:
 <SA1PR12MB7199B36C260415CE2538B466B02D2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260421140659.748577-1-ankita@nvidia.com>
 <5b2c6258-ade6-c35c-0edb-6da0ec96e987@linux.intel.com>
 <SA1PR12MB7199D0D2BAD762A5F2B2D78FB02C2@SA1PR12MB7199.namprd12.prod.outlook.com>
 <f5f24e2f-c341-f948-e6d7-b3a3a54a07af@linux.intel.com>
In-Reply-To: <f5f24e2f-c341-f948-e6d7-b3a3a54a07af@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|SA1PR12MB999229:EE_
x-ms-office365-filtering-correlation-id: d03d93b7-a210-4433-eade-08dea0767e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 v1xe+3zDgMBUVzDploOcP1xlAFm0Wouny30UbBtKhKhkFCXXYtknncdsl7oEOWBBpuBH/7r8nuhV+iPZXbnsfcKHGqC12p1ohJNKZMKFILQNWWNMloRRNOU2O5YA03g7Lh2NJF14JbP0sPHGM/F7Svdp52pl+FUZ5xNCT7xCof1oC3mD8VpnNMhvzlyjaQIkAnfga1ARoG2+zzcIwc8c5bbldDG0spjMnZLukp5/MBddeljCi/KioZEM8yb47q/uhe1bVA939K3pY7yz7N8BckNhC7yYtT90j2HbbGu4mk3GwOLMSbKtc3/AZ/3kkUFr5MZ2fXRA7RfgDHcRzVcSVQB+7KcT7JK7YAHbQnlbJcwpqpFTf2ykpFpZGd9k8aReb1Td4eVCn+Jqml9qi7/uaKCjI5rZJ5glWqEbJkSq1UGi961b6M7dH78Qfp6OEYJ6P4kSE3TUgXCNoZo83FsltNajgLOwAeAeE/fOPSmZnDtV9gS/4i/vthCGIX6N1qrHKC/ToAUsMgoZW7Qd2y4mORUpaPzKJoAtsn8NTxZCaCcpoa2JwSoDQjXH0AIjp5siIHR5Ay14LQihfmef0ez6xMSpD15pztlLFPuhFrNJBsLEZXovdxooOu3QRSDX0Zu3+dQHFvJ/w95hB4HuGi8Kl2RGy8zQ9K/+WQ0ArfVW0IpC6xHAwsCGVWNkba3UcEE8X1loqEN7S8oFJbK+1SNtrLTbDE+nflVlc76tjhK0qK/O6WTeeYoleNLzog3Oiy6w6tQwXJ4XWuqs5IgGIn4cSIp3zUQpOX4pYkDu9bZiAP0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IyqLRUV3nfeiEgNEjThOvoggkuR+4RWLfC0FrI1vyE7/2zhSpEssCwykVG?=
 =?iso-8859-1?Q?hDgLCDXEKDcTNcYCjkeLb8WinNNjb+tgQCC+O8p1iF2WinRK71yrpW9E3z?=
 =?iso-8859-1?Q?CeyWPwMGdpDhMol7/HVrediNC00MpozKZl24FcH6TBoi+L+L2fTyTFxaWu?=
 =?iso-8859-1?Q?i9nXCeeiozqQcQQpLR/VdKU33+FWgNZDCwlWbgp3dgMY3/6Rk7OKZ2zaGq?=
 =?iso-8859-1?Q?eHJ8ZookOWrr8481zAgjX7IsSX+S8qFEhBmBIheORq4M2uKZXvDVHeY8LI?=
 =?iso-8859-1?Q?lYGmsNrmziedXASHv6mEuz/xpnhJ2ma9FmyHpDZAtBsS65EYE/Bbwzc4kO?=
 =?iso-8859-1?Q?/gqhetrGlus/ka+XfGRiho+4pQc40WxuR1UCwEaJD46olrq5f8xcSxtBjn?=
 =?iso-8859-1?Q?lVI/EXnU58GeEi7q6QomWgs44eU1ctLDa+uf8Cq15pgX2P83tlg7zPwVtw?=
 =?iso-8859-1?Q?GoIpMB+4N0EerlWFHDh/o1ewszuHUNvFAnormVXj60I0tjc+rmRXAKawxo?=
 =?iso-8859-1?Q?YBSkS/NeYbdgXnFOhA0tw37LYkWJIsTDfCxh0gLhZW7UnUdQnyCoBl0iSV?=
 =?iso-8859-1?Q?0yj9Q8RqPz0yk6GlwaBF+OXDG+So//rcanfeEEPTyOtZDbfivQO6O0ARdq?=
 =?iso-8859-1?Q?OiZ8JmUXU9WLjoEupGPNg3B/gZD933ta12UWtc0/CRsT16RG7BcUg2WxCY?=
 =?iso-8859-1?Q?dmwlk1Hc9qlDebVOUbWjPr093mb+0u53n6OrXrIG0YUg0PWChSqy5K4V4G?=
 =?iso-8859-1?Q?nqv151HSjs3B9xvTN02YviOm+bvFb/2sb8l01bC4DWJFaz4kKKGuAozx4P?=
 =?iso-8859-1?Q?LRQCe4m1QOHHjPeTWNGHt5sIvk6LYaHprIsB/ye5RlK2cxdggy+tSQBREC?=
 =?iso-8859-1?Q?s2k3MZCXRhZcDn3Dylt/wjGzeGH1I/PO6Nn8bu+hbFGTE8v/xFJJZBGNaC?=
 =?iso-8859-1?Q?vzQNvhG1OpBiosHVQ6MEBVaj7Nh0BQZmQTe0m8Qs9AGn2hZFFZh44MnGjS?=
 =?iso-8859-1?Q?eDQ8q+V9ph59nMD3E6ugJSMasKXLpDtycegTUM9auexz3cL9+cfYQe6GXG?=
 =?iso-8859-1?Q?UPkE1gNExN++jCHDwhC2UVOdCJkjS8+onJuDXsJp69rEz/YJf5iFEC0Z2L?=
 =?iso-8859-1?Q?FOIpqBK68pwgUNiUkv0BBsAr8FRYjZSSbl8Db/2I4x563aF7+JRT2z+QG/?=
 =?iso-8859-1?Q?DdHrPK72oKUzdPOrmjZlI4ggM/e6bm9Yq0ufRqby8gQQ17Tub/ZSg8BuEx?=
 =?iso-8859-1?Q?by6gJMlP4uem530yDNwjJkhJlCk+GnOSF+XWTXVicWC0y5PIbsoBMrNPjq?=
 =?iso-8859-1?Q?QxcEBJD/n+m65Re0ihGAgeNzdY4+VgGq0BCZ2vGO0jklHAdRI7A6fs9TVx?=
 =?iso-8859-1?Q?9xtH3huEpcejE8AETKcSl6gQRy2EuXm+bnGOQQCduqOBpwZSfg0OYSvnsy?=
 =?iso-8859-1?Q?fMJlueLEHBt+b0dcJWC8z+vTLG5QQK67hELRXMVp0lxU1+Ri6vd/ONiUkz?=
 =?iso-8859-1?Q?CuStpe6soTo3n1V9ljixK9hF2V2EKBhnbndNmxBJUFiiK8rtjq7pBbHOCE?=
 =?iso-8859-1?Q?BApmROCqtKDGQ4ogiRFWW+4VWgF5jX4f10gAo992Rqz7X/gOp+Vr6sWs/7?=
 =?iso-8859-1?Q?V/khQMtOU46BRAt2pRQ4Bl1hiPut8IatxMY/cmBDVRWhZUhJnqDpijy4tc?=
 =?iso-8859-1?Q?XgXcLFMuS+O41dpa+lJ7V0694IAuEpJavgLGnG+gGDE6cZsjAW1AU1bfvw?=
 =?iso-8859-1?Q?/Fyafr4Vwc9i36S8ooLJbNMB2J8LyGyYxdxt2Pd99yyg6o?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03d93b7-a210-4433-eade-08dea0767e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 13:53:12.0243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIpWzMfMomnB0UGSjqweAjsIt2kox6xOpYCEYcqA1ZQ7eRjJeq3dm0IVNxgywjuJ8LXIoviTDV2OqQD9WyWwsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229

> I didn't see this change in v5.=0A=
=0A=
Sorry I sent out the wrong version. Fixed in v6.=0A=
=0A=
> Sorry, I mixed from what header it comes from and it doesn't exactly =0A=
> comes from jiffies.h either. If C files rely on indirect includes =0A=
> through other header, it makes painful to refactor headers.=0A=
=0A=
Added linux/time64.h. That is a one hop to vdso/time64.h. AIU=0A=
vdso headers aren't meant to be included directly by drivers.=0A=
=0A=
