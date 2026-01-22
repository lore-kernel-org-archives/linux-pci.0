Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844E37AA8C;
	Thu, 22 Jan 2026 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109903; cv=fail; b=o+VkZigpXnrctFa1syF7aAe6E5z3KxtQvRc7dF1FoO0LY25rVwb3gc+WCNoXsgdIrlwf4rha6kF6L8sL3uaG+CF8G7fqMW+6M9TPhhdHsSdsJEcJLmN+LOqNqKtH7Xsp+a89UsoE/2iOae0uZdDjHDH6E5sY4jIhJWWVZzTDzhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109903; c=relaxed/simple;
	bh=E0VBaLBZsELrPf1zSMypLESxoOY3a/wAQCoTDj23LVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sqdgnn3gg5mfOM6VBLPMTIRn+tAUzuR/klNgw7vISgak0fTs1/52LmswkRnH+I9g/yW0OGnyjNBbBIZ5cdlFtjE8C0ufArvk+ZIsKhRg1cL/gserErq9MMH7Lej1p+8sWinfhMUgEbTRqkSGV74ulCZBU4r8Bj0t1L3X+bktE3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QlPAW6ZA; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QlPAW6ZA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZqegOAwJTwOpFUlNhahZawgUIQUjm+vhydzC3gsXxlIzkTyVb5lS5ZcO97C/sZ/sr2zxseG3NEM+de/qFPNCnhLcqHLPvNXwHHxHBm6lzDOqtCjn243yI53YargxyuLSAll13Use/YRhjWtUmDHHEObc8zJepFrPAzKB56y5bUGIBkl32GF+v2NOrm3JLi0h0ssa5Y5sh0fh1XbtT93ddOz7jZSjwpeZG3KIjBy6hOaNnfs+d5IQyth0Oz7SNJY3gdQdgg4MiXJ++sPzPEg7AAAY2OYIra0fl6xVmEAXR8N0t8T6N9g1zm5ncTEosfdHStEnB2v6SJ5i9TSxPUN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+w3VUKVbtKHX05a+22A1pqXbnJQdabQdj9LWNhhqZps=;
 b=RxqtolaN1CeMypKze1hIVgmvqcalPkypX7ywQxtdJhxxZSKeX24eZQJsOawl3ok99bUDACIJNXZ+WW132PpA4gS3GpDZ9cVyu/LU78hcujLcHfwIH3k9cnq6K86QV9y3FEMazIt1aA3Y89inpg3YapxOv2DZZiv3x5gt4Gw2jgXQrAekFbX6ex5t4zlfwZs4Daoy7AFKvSQLLI2bBDxQq/U32yikuLIEKoCfTXgnwiSzxzZdQVgnX1ONGU9Z63kxIbz8SRYsJlHe1aZIm8r3SlFLwFwLLzKe6RWzc0rA/I/xpFQSwqYQyJ2IsuwPfhkY2vWW+QnQHexQVcrA9t5sYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w3VUKVbtKHX05a+22A1pqXbnJQdabQdj9LWNhhqZps=;
 b=QlPAW6ZAWazG4yi00tojcpWXUpnzfMp02Zs77Y96sEi33CQQ1CELM+9Y4MPD2r3Z7mePI2d6kkjHadBPnZqSqavWsVs/ovE4jpCm1q2NEPJRsj16OngGdNv4FcDHJXkQmZ0yEdPSH2Sf4xHmkSY8/d92da71BL94l0VudNlgFq8E8fifvOEezGdEFh06M7ZB6i7ILMCcS0rrS3cj64VoGS2e9Sgoj/EUB/ZHOYTvi4bMj0bydGiuOQ5dKUhD0HtMJnjvn6VpwFW9OZfvuPocww750qWc+bZzTfTe8S5iRSpAjkzip3q69HWMZo2XOCHe9t2shZqZs3Oh8n+nY/qv2w==
Received: from LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 19:24:50 +0000
Received: from LV8PR12MB9182.namprd12.prod.outlook.com
 ([fe80::656b:e9c5:c58c:49e7]) by LV8PR12MB9182.namprd12.prod.outlook.com
 ([fe80::656b:e9c5:c58c:49e7%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 19:24:50 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Srirangan Madhavan <smadhavan@nvidia.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>, Souvik
 Chakravarty <souvik.chakravarty@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Thread-Topic: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Thread-Index: AQHcilvrWYzw6a5xv0eiHOznw6RvDLVcexGAgACYZpCAAOxCgIAAkHbk
Date: Thu, 22 Jan 2026 19:24:49 +0000
Message-ID:
 <LV8PR12MB9182859B472646DC93B72FF6BD97A@LV8PR12MB9182.namprd12.prod.outlook.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-8-smadhavan@nvidia.com>
	<20260121112005.00001e80@huawei.com>
	<PH7PR12MB9175CDFC163843BB497073CEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
 <20260122103109.000049d6@huawei.com>
In-Reply-To: <20260122103109.000049d6@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR12MB9182:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 0caa8d7f-92db-426a-329a-08de59ebe943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sd4KcCNsAHb6rEJuBkrZZ94HkGeT1yENhYxyze+CD+8lQwh3HYkU/VOG6x?=
 =?iso-8859-1?Q?xNKYnK+TLlEVpnQLe/1RHNVnaj1wIapEH6UwMQfM47cX9tGnbm3pJZEMFJ?=
 =?iso-8859-1?Q?wDJYKi38h4RsyCDCadDV7pYPGPT0zoKJlO9JOedfXY3ELW0nVqXOgXNkDt?=
 =?iso-8859-1?Q?xpBB5A+bNWmAqGzpl5uAu/xInuzXgUge1ImQQVBpDvRsFLS/xKlszzpdTQ?=
 =?iso-8859-1?Q?K/Dz1b3YdY1FG/siV5pSQfHT9M8zlgqmwEjM5eBYfdIGLCWrjXenzDG76J?=
 =?iso-8859-1?Q?E8kNGt7ci7Pd8m/o73+BduunlLn1DUrMuvYAkuF5iXPIPYezI6/2K49J/s?=
 =?iso-8859-1?Q?QZnVBRFwEbSbsOIndoEenTyR0i4KbetUumbAPC489LA3EPTVJgEQJeWx9B?=
 =?iso-8859-1?Q?KvPY9Y6Uz6lWEqnsIYPK1skwaNJMcq0iB+jSKPO3K9XobL3fqOJp4a8FIs?=
 =?iso-8859-1?Q?7wrmwy1pYfBGgYRxLDC2SV2qFKVmXR1Fylt0ASULnCgtq6YbMx3lirYSDr?=
 =?iso-8859-1?Q?k5vKSr/vjptNEsN1ATOSh/yxkvZeWKaVZl983fXzc8Kx83lH3LrvC37HAg?=
 =?iso-8859-1?Q?Ue4WhrzO+usDxHY5DRQwwkGcyjwUYIKpGxUrGlqXrD0gA1jwq2Atc+XB6Q?=
 =?iso-8859-1?Q?ciebyciNQm4czayNpId8NGyNIUJjmUvav8E+wzaRrP2vo1uMoFLRejPCf5?=
 =?iso-8859-1?Q?OpqdVNQ8b/GlPBuD7Y2uWNKhPcMxiDMULhuk0YsoHCHGl7kdg7kpsxzXMF?=
 =?iso-8859-1?Q?o5U3CAAP2+N0PHiVyxBY8hMlGJ4G6ahs3TEMZowLx10ITnrxzEb9yBMk+5?=
 =?iso-8859-1?Q?bz4HJUCR14aT3OuTQHw6NwnwIo91XIgR5MWKFbh3rV2BX2KcT1tLiPguy6?=
 =?iso-8859-1?Q?lGXbRp63kZ+gLtz4mR91z97KkXTr4tfUcVaNG6+Vkx2w5oWm9m83XJtubK?=
 =?iso-8859-1?Q?3A1y7XEG75WAKjhqDPA95albg3UrTWwoqo5LtIehu7h1IUlFyZFelltNxo?=
 =?iso-8859-1?Q?A3ixapLCYLmdg3BGFWZUkdl12Jlyl8XzI4NCU1yPCqTxeLMSWi17aD36RA?=
 =?iso-8859-1?Q?xcu0nrWzIRkydP6adsG4d+/blCKHdkCyP6B3FO7AX2Y2FrDjq6VMs2R24a?=
 =?iso-8859-1?Q?S5jCIQqsyveuEmetq6YCS6ZI4FSf927aeH4uDsuYfVL/LgBfclNFL3dEqb?=
 =?iso-8859-1?Q?F4SnGAlwBhdYeMqAcxRvFZX+r1Aajaj7JG4cRSJDYXixasNEDirCA5H6HB?=
 =?iso-8859-1?Q?kKNxOio4TCq0cVBTRsiTcvSAnmSc5MHMZsk3Z67ZTgBYd2md+qT66Pkz3h?=
 =?iso-8859-1?Q?ghTo1t7rO9SaS7K0dAxgD1s0FQzRqJz2oaZ6wdJNJdWQPsA77UcIEH0gU5?=
 =?iso-8859-1?Q?UoIc3896C04shVAm7TAKKty/Hh4KvbrJbmbZP3r0n7pyQyiStR7Br9Iutk?=
 =?iso-8859-1?Q?ooqobNQJIk1PmGqRJLIjPKg2fk5IYLc41nE/RGrpiQTBnR1hVHmjybJVIX?=
 =?iso-8859-1?Q?H9LvC9lDGZ6N6+VRmv7kG/28FzhMCt2lcir0G4Ndy4HPx7UOD4ZdW7kr/Q?=
 =?iso-8859-1?Q?SQoIVn1nMUmR6qQqQz1n7mZxUpOt87pDEc1FaZYG4Z6QyylTNeElhPGiok?=
 =?iso-8859-1?Q?njvnMXUrryRyfjNWBNv2IfMu0IQDlXdTI8xYYOSDIB8Kamw/NqGEWHQisz?=
 =?iso-8859-1?Q?c5xxLC3IoshnO07y/v8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9182.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?E/Yn+0fEeh+RCaFcOWhaCoPma9aMeSo1hFriHQOAkSCSNeTCVFdidsqpQm?=
 =?iso-8859-1?Q?lqFlr/f0Y8Q04pt66tk9UNR9rxN1wNIR/Wo2EAwMrdPHIl1WdobzcX3vdQ?=
 =?iso-8859-1?Q?RayF7jkF+J8qQKzkEys5bblnPBUZOIshbElDIQpDMIfHgk5lBCEr147e0E?=
 =?iso-8859-1?Q?OBaJDLIxmApMTHkE2kpuI7pN8R5Oo1rsbO3Wd3NkJpCaqJKk3mUqO54+qv?=
 =?iso-8859-1?Q?tnRI3ICGtZ5vCJs+DFtqxWq/tksgb06uVYajZlO+pSxatPbTsxAGoxIG8s?=
 =?iso-8859-1?Q?5x9NeWzcywN8hQsQD0qXRCyGSPVbpCU93HkReZqcP4xMaG5+uRnfv9V775?=
 =?iso-8859-1?Q?MU0Mqjfes0+x1c5PwaPHXDk8Olhg91TqZCmr34y/NmGaNkygiWtpK9Gaj5?=
 =?iso-8859-1?Q?I4IKeY+pVRwxIdNtqegr4q9n2EMwOudWjE+4tFH2MnwDCfv4Nva14lDOf/?=
 =?iso-8859-1?Q?DndiPGqnoQdXSqmCY8PdG3TUGQKcMzKSD3ZBI587fROhjMuO05RcAVl1nI?=
 =?iso-8859-1?Q?DbANMw6Qx61EwuLvl1P5HVhyg7M/P7xUt09l5UznX1BpYvfnP7bHUAz9pA?=
 =?iso-8859-1?Q?tNfI3I5teWrzAoWGBmgBq+di2hCvOT1+OICxnpJVvPcfR9pvadLGzlpCvL?=
 =?iso-8859-1?Q?690kBeu6L6LI3gbISAwfzlxxDdoStzTDAYzi2Q7hFGRXKhX4gjB4zLckvW?=
 =?iso-8859-1?Q?qZfQpQGblPr4WJ2vsKkGA4qbtKMXsfrjgrh1j3HwwqtI++6qXP+Yq2COVM?=
 =?iso-8859-1?Q?lRFUHVNsP53oVC4MBMp9afBbT80WqqDXUQW7gYVCfRQngIP3UH2LD/rfLH?=
 =?iso-8859-1?Q?+MW2F3+pvyYBqji/S+LfXmfxpeLt7/0snBC3Jzd0Oh+6PrPeZni1x9z/WZ?=
 =?iso-8859-1?Q?r1Zd/lekMsmesX55Rjs5OaJcf3KmNW/MkvmlayzGxbWGDPdxgKz4moV+0w?=
 =?iso-8859-1?Q?ydzyPXmdVciYWdUpZrcHV9Lw4O+fMy5OBNF2QgOUfMFXUHslWEfPGv6eZG?=
 =?iso-8859-1?Q?jxtQSEozXq2XnaVPSMrXg269rB2rNaklYsHfJnVXX/75oPWOcqN0ceeraK?=
 =?iso-8859-1?Q?ppXZYY/G/m6zrOej/Ntndbdukixy8QWm7FUBTDzGYscOXKkmLsxrj9Y1Wq?=
 =?iso-8859-1?Q?bsXkuBCpuEwWZJlEDQMaTKzs3iuFXMiBennq1hf/rGtOnbNxIu+JmrUuBT?=
 =?iso-8859-1?Q?VaWzZr0yXi0rvi4UStcspYA5ZKrRP3yr3RD8GTxHhuCi6xaQezXBrn+SkR?=
 =?iso-8859-1?Q?5lyQCBk6mcXXL6Y4tIUTYsIsn+hhcF6Lg+jhXC6qWzROpbR+0WI41DUjUm?=
 =?iso-8859-1?Q?e4qF4HFhw3XLGqjpM+HWgufD37VZ7d1wmKbUA3cm1QcXN/v/yeVsFvtzq9?=
 =?iso-8859-1?Q?ZTuu6sCG/Y/tHSTSkKFbjTHPDGqRo0hBIT84LorCmQOpX5+A1cB0jbNjO0?=
 =?iso-8859-1?Q?RLjlI8G5xste6yZKNvX11yblopTogPMqG4xDdO7LSlPCyq0srYTzgHRL6c?=
 =?iso-8859-1?Q?UsL3B2FUOHZftAMxoNH4b2Rri2TqE/cFp2Ug+U8qtYKJntakByL7lKP+9R?=
 =?iso-8859-1?Q?QLORWSOKvdN6ciWo27l6g9BlNJCWctrDIb0JDNhZ8hdZXy2BCHbBlt9cdw?=
 =?iso-8859-1?Q?WvNHKMB/1/c7u/9zwi9/zZKs2k3gU9b/1tQQf4SIB4tQRtSnrwQ6b63j5h?=
 =?iso-8859-1?Q?Sug9ReL8WdimQY5hRuRix19EzmKzKqbd2gGjRDXffjxPXlOro0xy0OXfLh?=
 =?iso-8859-1?Q?SlPUNLTecPaXas2nRQNivAC1XZf7pgxMU1Pqvng/Fp6D9O?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caa8d7f-92db-426a-329a-08de59ebe943
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 19:24:49.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FLod6W76YsXbGu4rCWeS4LMSshRkqW4EGZ+qcpO7wlFxsVkjQuHfP4GxV9WuxRGmo7dBew8C6LXCve2ZDRecA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912

Hi Jonathan,=0A=
Happy new year!=0A=
=0A=
> From: Jonathan Cameron <jonathan.cameron@huawei.com>=0A=
> Date: Thursday, January 22, 2026 4:31 AM=0A=
> To: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
> Cc: dave@stgolabs.net <dave@stgolabs.net>, dave.jiang@intel.com <dave.jia=
ng@intel.com>, alison.schofield@intel.com <alison.schofield@intel.com>, vis=
hal.l.verma@intel.com <vishal.l.verma@intel.com>, ira.weiny@intel.com <ira.=
weiny@intel.com>, dan.j.williams@intel.com <dan.j.williams@intel.com>, bhel=
gaas@google.com <bhelgaas@google.com>, ming.li@zohomail.com <ming.li@zohoma=
il.com>, rrichter@amd.com <rrichter@amd.com>, Smita.KoralahalliChannabasapp=
a@amd.com <Smita.KoralahalliChannabasappa@amd.com>, huaisheng.ye@intel.com =
<huaisheng.ye@intel.com>, linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.=
org>, linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>, Vishal Aslot <=
vaslot@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Shanker Donthineni <s=
donthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Matt Ochs <mochs@n=
vidia.com>, Jason Sequeira <jsequeira@nvidia.com>=0A=
> Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-functio=
n reset=0A=
=0A=
=0A=
>Prefetching should (hopefully) not make any dirty lines. Hopefully=0A=
>no one does clean writebacks (and there is a way to check if they=0A=
>do in the ACPI tables).  You need to flush again after to force out=0A=
>that stale stuff though before any demand fetches occur.=0A=
=0A=
I am aware of some systems which do clean writebacks to device memory. =0A=
What exact ACPI table has this discovery?=0A=
=0A=
>I need to think a bit more on this as there are some scary=0A=
>comments in the spec on CXL.reset such as all CXL.mem reads=0A=
>are dropped (timeout fun). Mind you a device is permitted=0A=
>to do that anyway before cxl.mem is enabled, so hopefully n=0A=
>one times out if a prefetcher hits the device before that's on..=0A=
=0A=
Yes, any sensible coherent memory device reset will have to include first o=
fflining the memory such that there is no demand or speculative fetch possi=
ble, else you get to deal with CXL error isolation fun.=0A=
=0A=
>From a kernel point of view SMCCC needs to be just one option as a=0A=
>bunch of hardware (I'll only point at ours as not sure what else is=0A=
>public) provide MMIO accessible agents to do this stuff and going via=0A=
>EL3 to talk to an engine the kernel can poke directly is silly.=0A=
=0A=
We have a similar custom engine for efficient flushing, but the interface i=
s not available to the kernel, so the SMCCC is preferred for our implementa=
tion. Like you say, the AML wrapper for SMCCC is another option, although w=
e also have some device tree based systems where the efficient custom flush=
ing is desirable. =0A=
=0A=
>I'm not against the PSCI thing coming back though if someone needs it.=0A=
>Preferably without the CPU rendezvous stuff though -> or Linux can=0A=
>just reject anyone who does that.=0A=
=0A=
Agreed. I think Souvik also agreed offline that rendezvous is not needed fo=
r the SMC based cache flush.=0A=
=0A=
Vikram=0A=
