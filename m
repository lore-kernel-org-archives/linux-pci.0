Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792487180;
	b=0D+8Ac/sZcqZ9xG+z0QMW5l5DLsm2iX6rU3M3pY/O7VOBUZ6fZzjZFOEHW7VfEcMdrjF
	 OA5ILDsGHWPyd0fAFw+RnhkUeRerA9sgc/77YCEd22P/WR6iWI1T5kE5tIpxDzTBaF+Nq
	 Xxl4YBBpHipzIS16IGm6LOGS7NMVO5QPB5zuwLVRWH/KpSMvT9691x0SwXty37SnWEXjj
	 rRDHwv3IFdpukcpok7hUbXoITU6H+UgysNf+jCP1/IAmIjwtKESEmdqaMQJ46/c2VN0sO
	 NrZpa18t4cAcZ8z6FQqSRjO5hfbyI8bbEpUQJB9eCcnttqzRdsjXcPY3ip+5ouaaghw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487180;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BmyrqAVNQgp8Vc4OgF/ZUrhmF/X6rQoJQzVTv+mhxLE=;
	b=xtbSAvYNzDQMJ+ICEf26RXB739hCOg0fCM4PJOwpuBjyJmZRXf7pEhpNV/6wXzvxpr5Y
	 cnMKFNRhcH791QVOGME73HCKdVLAy7xFvuzisiwvCrpqWeh1XALkbTELUUXi33PiKo/7i
	 0RiXKm/xfRJrT7b068B8JaRuL5tJ+D3g27a+Efz2JMhhf5Mf1h9b5HKG/cwVKty3YHg1s
	 IFosPB0yhwZBoxXxJcVHhzwCOsMjKTvwqPdkMa0dmnvFOQTYlRFcULFyqEmbUaD/8w3L9
	 KLgKnqT33sVtcXs75RAPAs0iq+tyUMmRw3m0UJoMCABHXs+9bCJqGLP2Ld+YSn9ouCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ThsUGBea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.48
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5074606A31A;
	Tue, 20 Oct 2026 09:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5074606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ThsUGBea
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czpyQhIulkN4gZ0gtdEC1t7av0nlZzBk9U4bQlKuYE8X9mJVunruImycDLzboBKwEE1TyPOycTggHWvY6N9YGMPzivlzpFtz45Tbj3whexU5924rBa4ESY2jkq1GAEcfWjgrANKXknUnPav0vtTZbRKQ1YjzE1ylwaUFQnmr8Zrw7pgkM/EvwkKRSbBxeEnQW6DYtZgGxx2DZIusBG/uRYazISVDNLYO9PgIGLC4MXHRRd6sEHKjIto8Wq3BsVKDwOd9UKY+D0ZvHb9+D72Jo8vy6SEvY6KNoHxaoFX1ldfMlzN2KTmopU6vDwuKCxSlia18FrpJCbLVbwEkyjjtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmyrqAVNQgp8Vc4OgF/ZUrhmF/X6rQoJQzVTv+mhxLE=;
 b=QkwOmomqQeCEMTXC/CW2JVI0XfXLPy013nJ7iGrngRfMJ5mGeglVgSuAJGsRmmCmQgZXvRoeYkvUH5M7BuOwfK3thmf1Tuldq8Ms5rcCtPvdhe6opY/7aHd90CveeK17uHXX9m88gfEQCvkuK7JF0zYbFc121HNXaEJN8MQp2aVCLQQn6FlK4apIv8LUJT29ZJdFZeUXifjtYBJofWCNOpCwfoqJXCFpHd+TaRXRHQ1AUyUH3N/spuCNQtUoE2APQ+jmg2cGodJQ4mO0fSyE3A4oPTKuRNu8IvmwQoN7pnWzE30znEaIrvaZ3rNTMySe/wjBvfP06cletbfJrlVYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmyrqAVNQgp8Vc4OgF/ZUrhmF/X6rQoJQzVTv+mhxLE=;
 b=ThsUGBeaPpWmiX94w4Ig1b2xI/aEncVZMCBaRB9fiGaTiMAhkXcCfTzYG53+ngEsbaFZhL1IctOeM+dkPCN39Y4NQHLoSIZWoEfGL+9GEXMIhTs36I3ZkK+msqtS3eVMg+bBuTFen9wCwEK2fG8jko/xBgfvnvspGBC9y4MHSLFDaWCy6NIGpbEJWtL+Sa5Z3oB/JtxIZX8H+i467xf/YZI10oEVSj7jgyVUPhS+IHnFtbuMRAPlWHG7Gzn+2mflkx97jKZd9gLyOXUq5wSjn8gDGeiv7kZrwuDMGf9/TSOOrrIcnFzyYpEFucMVS9SRboEqezlERFXiZLzuWxWqNA==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by LV0PR12MB142838.namprd12.prod.outlook.com
 (2603:10b6:408:3de::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:06:15 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:06:15 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "aik@amd.com"
	<aik@amd.com>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
	"iweiny@kernel.org" <iweiny@kernel.org>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, Srirangan Madhavan
	<smadhavan@nvidia.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Thread-Topic: [RFC PATCH 3/4] PCI/TSM: Derive the coherent-range IPA from CXL
Thread-Index: AQHdVJeqGblX8LB8bEWpiS6+ofq1VLbwsisAgBWH5nI=
Date: Tue, 20 Oct 2026 09:06:15 +0000
Message-ID:
 <SAWPR12MB999267A866A807FB7AC3B255FBB0672@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-4-ankita@nvidia.com>
 <f5c8a479-5c00-4a4b-8bfc-3f83f3df8c8f@intel.com>
In-Reply-To: <f5c8a479-5c00-4a4b-8bfc-3f83f3df8c8f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|LV0PR12MB142838:EE_
x-ms-office365-filtering-correlation-id: 2158ceef-da0d-4b51-0d97-08df2e89658b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|23010399003|1800799024|366016|10067099003|18002099003|22082099003|4143699003|261009223027099003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 Ujv94RQjf3EM9GxoKExIT/r0RRVvXuX5vsGlLdL4IeGQNIvGuLmHMn4GvQw67LtFalsBrx0VASUJ60ev6mD6jgBx8YQ6GQOWVQuWjN3sxbEovkY3BXqMboyKgkTArhGHIsLLjWQfY93wpvB2MykhoOMBO1JeWjjUMPF3OkyiQHgN0Tjjk28fwO7k7i4Cu9sNKCjzZZSk5NRmhz4IfX1nok2xNQCZavxARdpO+Focte/WynOl2V3PcftiUu/x+tW2WBv+sqATGqye4x7hYIFIftwF7pGF8VBJS3sU8KwJ658dlMpq1rGANxwUSAU+dRVGyNX0zevb4fpMlCPQH/2c3g47XGa/dPd1H4qM7VAycwKrd0TiZo3NsPyQN2haj23WrCOAzHnYKrcMhUVhpcFkBH2ocGXIWMe39HENGLOKwh41P92peFma36h80HblM437yQbYzwAGw9DGCxSElIOqPWT34T6QHz5Y1BQF3NvrRu4UAxdmbg3n+K2dcSFens6Vccbc8WGJSXY9mEQsb5Nypipg06aaK8IyXPCXRuU7ucY0v4jKy19RFGsaz+fxg9BR05bjzsnL51pRvtRb6G7HVshe93vkLtFeC0wNR9p0co7DGXk30dkwI6pb44YUNxNCRxZlMK2bMOKo+oxo/svmV3mVqo3ct0aluouq1nz103Kt9TH4bkuzxPIYilrZKb/DHADyP5qtQwz+Lu/u/F92VdkfdtbCzCIIZXlJwKKOSqc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gueCchDYov0IdyFI+og7lGNGXGiJQQtdjj31mBm/HMBwGVdsuzETjQZI8i?=
 =?iso-8859-1?Q?34zrbjkwC1WP2OdlvwVn+GLQdTgapz3kzgg59bcgfG6jiXg2bF/ETv60MG?=
 =?iso-8859-1?Q?sE6u5Kv6ZbmK/hcfWfAahllx63cEqpWzoQujFDZ/QVui4n/tVl9qgwxIoC?=
 =?iso-8859-1?Q?9vYHke1XaB5hYg4Pdk9pPZfc/Wk6rMBNgsNezRPQEwrtVCfTwNOo05nFrf?=
 =?iso-8859-1?Q?Bx92RA6Ch9IWxUbYEdZeGKSPmjqGmpBVoR2y63val7iY23mZH14LH10X6p?=
 =?iso-8859-1?Q?xAuiH/53Rghs6HiR1HtU7SMDwsCULbdXQUGQzrJuU44H4u8chYarpxTNO+?=
 =?iso-8859-1?Q?5ttRn36ModxfGSFnbgdkXP12QkhrU9+0Tb+ww5mY47VHqMf0E01mRU1d7y?=
 =?iso-8859-1?Q?12s6hQ7xkNj2fcEmzDpZ1vZk3ZV8u3I7ZpT9YeSmdvHj6Jjj+SMRS37vm3?=
 =?iso-8859-1?Q?Vv+4xsVvX2YTgDLPFgaHjeuXVbwcscHxnmKpFTo6ddjlcmVvAqm7xoEitW?=
 =?iso-8859-1?Q?tSL0WjfTEz3efnUHGV/eO29Qdu4pC5Xp1iDXXXMmKjLjL50aigtz9x9Zd5?=
 =?iso-8859-1?Q?+DcirawnNuuJBXXHbiLI3qv9COaWJKhGIO8GpmY7AVigl7nwizXJwEQU1u?=
 =?iso-8859-1?Q?l9IuAyOJAlhXlA9DHrRsnaephTjkp528sJFkLUGEIQV7E7PL/at8fxKtb+?=
 =?iso-8859-1?Q?aQAE674Eu1LowWyfdFhBhToPIzrd2U46AvBMN0CUra1MpBPOaRLOW9i/v3?=
 =?iso-8859-1?Q?PA3ai/D4PizdlDtTecbCOA9Akw3n8hxApMrAWStXzQigTQLAkEBhZpX32f?=
 =?iso-8859-1?Q?QS1M367imcS5ujKdI3AAS9EYPFPSAe+OGSOTFEyodCffudgptywCx1m7pA?=
 =?iso-8859-1?Q?6d0aYI0uXxcHVLSNkeUoDZb0BF52ppLObhMYMoo6Zd7kIy+bkGyW3ADoiO?=
 =?iso-8859-1?Q?IxQ2FQXWu6INHqzEXdYWcSrKaIdvRxsS2tvSN1RMUba3y9MG9sA0mwnVzB?=
 =?iso-8859-1?Q?lXHt+IxwniXP1okNPCrTQ5sHZlVi/K8WFL3YF1/bztliiIpu6zVao0a5IU?=
 =?iso-8859-1?Q?zTWjv+GUiywLKY11jgD/4pdMFYZXTdf09gilutqXN5M+X0xKxT9YjL/pig?=
 =?iso-8859-1?Q?giJ3CmFC0IstirFiI3q3wcyRuz2LHJtpjhC91faCJe0gR7hG93Z5eAtjH8?=
 =?iso-8859-1?Q?rs7arCc2sq9x/AVEdNkYXeB8Y368yThaSdFmexNNES8H2v9A56ZRV13CwN?=
 =?iso-8859-1?Q?0RvAoBzrmPWD44lUqgpxxjK7gq/eALU5X28cG8tQRo09Q92audnmPKBV0d?=
 =?iso-8859-1?Q?c5erbOj3eyKsPVFGAKueP+G3R1fD8wb85V7b75hQNoT4RzD8xpUA4nwM3O?=
 =?iso-8859-1?Q?Xlh575oVwHUVgJYgGBDVCipuReKJPQhK9A2Z4DpdVTVV4ekQh1+8G8+5j1?=
 =?iso-8859-1?Q?Vu6mBbvuTuKDrj41xRmhYI/vYh/TtKk9OuYiAG1SjvSOnMd4jSHyYTnp9c?=
 =?iso-8859-1?Q?X1MASAOIRiPb43bGRQiETxsJLAnTisGt8Pgk4wNgliIJ1HCalijCk1r5AA?=
 =?iso-8859-1?Q?BhapvSTUYnyxl3OU3mSTSVpBiNFshOBy5kIdIof9TCyRPHXudATr8MTbdD?=
 =?iso-8859-1?Q?41Z+4t4UujpVWVOia7GrO9OnMAQjRaPMLjYqWmXD60KtlC3Fw3BisAFlCg?=
 =?iso-8859-1?Q?VsmRXAjlVcjWcGYS0sO4TfVs6QsEQF9hD8vGGZI3zdMNddMgruhAgauqqB?=
 =?iso-8859-1?Q?ineeUKr7Eg0Rt1tNPzvZU+vXAMcP39bi0iY5RYT1l5PE71xgWI9WMkFNww?=
 =?iso-8859-1?Q?5YPvEZQ09rtCmFIHXgwXQ1N88cyBj9kaRKc2H9rs2lfuObXogR/x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2158ceef-da0d-4b51-0d97-08df2e89658b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 09:06:15.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYO/t3S3UxoEDDI3rcpU/HYaXbBu2pCxxWQ2BXwfdZlm8FLokqBtj39cUhm9QRWa9bLZw40wfgIUlZ1JhGXJhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB142838

Thanks for the review!=0A=
=0A=
>> @@ -904,6 +904,41 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 t=
ype, const void *req,=0A=
>>=A0 }=0A=
>>=A0 EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);=0A=
>>=A0 =0A=
>> +#ifdef CONFIG_CXL_RESET=0A=
>=0A=
> May want to move this to a header. Having KCONFIG ifdefs in .c is typical=
ly not preferred.=0A=
=0A=
Yeah, will move it.=0A=
=0A=
>=0A=
> Also I do wonder if we want to put this code behind CONFIG_CXL_RESET. The=
re's dependency of being able to run the reset stuff for a type2 device bef=
ore passthrough > to user space. But the attestation code is not part of re=
set code. Maybe putting it behind a different kconfig symbol with dependenc=
y on CONFIG_CXL_RESET?=0A=
=0A=
Agreed, better to use a separate symbol like PCI_TSM_CXL_COHERENT and=0A=
make it dependent on CXL_RESET.=0A=
=0A=
>> +static int pci_tsm_coherent_range(struct pci_dev *pdev, u64 *out_base,=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 u64 *out_size)=0A=
>=0A=
> pci_tsm_retrieve_coherent_range()? Also, why not just pass in a 'struct r=
ange'?=0A=
=0A=
Makes sense, will use struct range in v2.=0A=
=0A=
>=0A=
> DJ=0A=
=0A=
