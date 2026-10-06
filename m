Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010623EB0F3;
	Tue,  6 Oct 2026 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306748; cv=fail; b=eJTTPfTBEeUYSL3ibPlfv6zy9ZlS/tD7H19+GNODnJZ8MaX9reVaEdhxWPKqZ7Mk0/A5JhWaLv+Cf+rJTDSCrzUzTgF7o9CmU2ndP/HjGX1oEhHwUi5M82qp0Q3QFxV9qq1nSGANWpvzduUULrctfh3KLCc6Ml7CZcnPMIaDKcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306748; c=relaxed/simple;
	bh=ErVB2fvEvoGFAH7ShufLHCUZGZOm/+pa1MoRl+74YRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=anDBUYNp8dStQNWtEnjyXJn0tlCtW/MQhWBCSR4+/211hxgCFSi9AHWkoVEjr6qQB6UjBbBb3vQRl3G90D3QqxUr4ymgZF02eK3yqPyaUtOtbtPlf2JPdurpYhPi5ISGlcj1SbGk7JD5HnnA2cta1k2CLot5pkEFL06ZTok9l9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sy4EqrXn; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sy4EqrXn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW3wmmYyPsbpuZrHdiN3AXAyJvyUoHqNsa+M9TDYwolwnTaY+einlJWs9aG3+biUjzr6Hdb0m4HXYbqbGsixltdWs+C9bOkc9Lb9nK9D7EcgjsF6AoRYMHKNzfLPdyQreAmiXSmrJ4xMveyU6ccxCdSjjl7udG6mnsRnx53Um/Qhbz3qg8ZoLcximlhJURojSaGFR+1Pgfv3KEXK6HLn1Em7yoXPH0kH/M3/0c8VT6/e0QKVyv+YVdHZtK1FxhImOPoG77JVv6UpP2EHtuMWkbDD9Nb1XnzXuARDjUq341NHzmKgiwpRvIdg8Mw3j7qSJ0551M9DBy33Pb+TIFaVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3bBnww56Ou54jU8xWPw0O6fIlpXPW4Vwqk+dZ3/MLM=;
 b=lknzaOCqINC/837BJ29HZRQ5ocqYJoeIn3NvlwskSxGSGxrJ9fTdhAuTlGPQHM1+u/sor313pRin7PjeB5lYnT/cK3eub2GbqxoWvXjwq18oZ77LC1/6eKI6kwhUENZiUoqyP64T6coXjICLWJDGHkA3qnjqXmr9S4/2bEPPpAsFRq4hcXaj7edQiJ/DdsSE8U01u1ElNv1cLGIJOmg5VOIbzNanMO8/JXnKYFM7F7sJQf0s9pReEt//VTigehUwVCdN0LHDYarfYN/0NGIoTefEmWW6pXmfCujIky40g6WQhmaSO+fIwK+MLB68yBYQ94hihxDkadstX7jQ9QyKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3bBnww56Ou54jU8xWPw0O6fIlpXPW4Vwqk+dZ3/MLM=;
 b=Sy4EqrXnALGmVK4Vfz7OBTls5zh/qd1QgFEaURTFXO3dNGdCEhDjhsFI87Gn2+JuWn019mVV1O2YvyzIPQmEHWpGFWEGRcD/PQftzIJQhQCwiVFLLvCbMVRF5ERejYaoLj65PSzI3OTlq9fNCVJKA/hXfjAR3n6zcUTCh34xwjs=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 17:12:23 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 17:12:23 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEA==
Date: Tue, 6 Oct 2026 17:12:23 +0000
Message-ID:
 <DS7PR12MB95503B5244149768A62590099C952@DS7PR12MB9550.namprd12.prod.outlook.com>
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
In-Reply-To:
 <TYCPR01MB109273BCB71161ABE3AD85A8696952@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|IA0PPF6483BC7EA:EE_
x-ms-office365-filtering-correlation-id: 38b61d0b-4759-44bf-8ab9-08df23ccfcce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|38070700021|4143699003|11063799006|5023799004|3023799007|10067099003|56012099006|260925022911599003|260925021311599003|260925021911599003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 M53nrG3IoUTRShohSW6DyjUPWzKxAEwiY+WXYaryzQSlLR/9R0gQ8hx3QVvlmEcUWHq3ej8efKYulkQlSy0WG3WkBoCGcbSkFSitNtXHvPAE5dRsAJMccDlpjijCYenYTsQ5bd6BmnhzRAKkIUsmV8nz1IM1ldQQjFyAlFCOA9NrhHKxKEOw77Cg6b5SrCcEWyZTy4eLcm27se3MOfqyuMDsz0MxXeAYAFY+7TmbQQ2q6MXn/nQC0hFjAZei+Ij/ySVt+FeXP5N7NhM44c3/4Rof7DW5wuQfgBWQ+jqMvLBMFfUi7yQ5eKZN2UKFp8bA02xFEHvyZ4gLLAciSWZLyLik0T2Tf3oOIV1ZR7nyFUL+fTaZSFLcB1ETLV+zoTAdAYvfYrJD8FqPkY+YhQ6pdofr5CdaoLp+4G8U3RBgADhgixQw+iNlS6wzJ+dMUh16Lwd+5zFA//KdiqYluvwdK2LFIgXMgGHK5pOdGkXNmij0ylJBPy56UYSXVk0tH2uAavCBbkZBVVdF8lpjefSHsO32gq07kwUOrB6gw25ll0tKd9B/T+RsZThb/tdGNl3mup3tUuzzGEZrzGmgSrHAVJxV4xX4nI0L84ratQix8T9P5WMZnHAEl1cuVuuKes6t89doArINblILwdv2Kk27JBsIy9dDBTPFlaLVJaty/rt9RXQSAvmJjz+R9kTpAzt6m6udXgR+6CO1N/wlvt0QmQdJ06MCyJWgjg1+lGb7cKA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(38070700021)(4143699003)(11063799006)(5023799004)(3023799007)(10067099003)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zf76dbtKDaUWrMtVLfHhyClQRg/aLiV9UyteswPiKk+dMZ4pqpC94FyLsJZU?=
 =?us-ascii?Q?xmQh7Jthapt05JnkuXy0AnMRuaxScJQs7Ykft37UnTN5Rulz8+pYihS0gwYt?=
 =?us-ascii?Q?sqIQJXSpoMNi9DCMihyhG6N0lwhNd+au1s6IedbZ7DXofAY4aHYIwSHNcpmr?=
 =?us-ascii?Q?NonrF1fUC4J5KXoTm5NiuW86c992vZCemSkh9dm1qafKV+OZ3y12W9lcd5N9?=
 =?us-ascii?Q?LjHOO2TwCmrdXNSBWbwbaRjzpXqtF1NBegnyaIRoXLc6HnO0DUUYXuuTWQd0?=
 =?us-ascii?Q?WrT2cm/puAWNetM/b52toF65cX9twJ1p9nHORkAPipzNTr9lnjv32t2v3Cnk?=
 =?us-ascii?Q?xHKpvHfrzubFo4PD66mX7s+9pyAHRSaTsa7HPekOkGOGTiyxuhBEjdoOUgzw?=
 =?us-ascii?Q?aD0h7C9EvCTj/49fLg+xB/RgHBBqtOIf6JpNg+Cle7PLMP6/4ENJurhGFfwM?=
 =?us-ascii?Q?oJP4b58wjRO3POj6yp8T/ilDh7+5/EsXW5ma7bTQdQiD2Z56g/dsgmD5X6ze?=
 =?us-ascii?Q?nVjsUMH1x7b5dMdipHl94O7TIltKB3Nlm4NZbomZGMRDiXTRoU8a4Lti45o7?=
 =?us-ascii?Q?6GH6maWeiIqZw8sLQNIC1+tBxjobdRhY0iGzcrwNb8CAHoPvicyi7Gz/Yp9o?=
 =?us-ascii?Q?umKJEYsU2Brl7u5M0LNP+tds/ejk54eMkAut1jMdWGQ9NPpj5RSWEX6I2M5q?=
 =?us-ascii?Q?3JIPqU6K0645cERiJiQGvqWGTWFJUzyojTqAzgwWw/avDwFBMA4DfRDlkOxp?=
 =?us-ascii?Q?RqQWe52AoFEBUjYF9JQnC7MqruAFxCJdYPk1jofGDsvzvBkNnBCRcTFV2lCs?=
 =?us-ascii?Q?2j7gTd0Djndbwczr0JTaY9T6MPIbF8ickeyKakEuL9M2ds/UIxbBrUsDZaZt?=
 =?us-ascii?Q?AadVtWbE8seUe/G0AxXmWijlNw85SEx6KkZdhrLwb9/2IBTw8NAcmtbmbzPE?=
 =?us-ascii?Q?h1W1/Itv98NZCWKivBjg37+WbigWzaJnPIk0mVjrBcxvOkCoLCIF+CK64SrY?=
 =?us-ascii?Q?IXjt11foyag2BFNZUCXlKl132px2dbUle1BvGiu8T9t4JyXIXPj30AHAxrK5?=
 =?us-ascii?Q?rf137hPglqGP/2cMbBRPaNja5YGupm0jyBrVOkAqAq/U5iBekqtbxNePfxb9?=
 =?us-ascii?Q?kZaHAlZPpvxr04vzLumPKjWP521T4o9r985okrhdcsShIMGXqUoL4ZbGGhBu?=
 =?us-ascii?Q?G4QxCFKiWI8RObC7t5l9qVildV4QD7E2A/gQEFE85guzPLAsk0qC5jEs+X0F?=
 =?us-ascii?Q?geCGf4vVfftsZdzcUgyRTKeUthkl1AlbneBZ+yT2u5Jlel2Rxjv9rd5tH/w4?=
 =?us-ascii?Q?naG98LC0n5Qc1vPFnBjcY9CghgwjwLSwICb9jQ5cOXohtTxehHRTS+RPTyH8?=
 =?us-ascii?Q?tgJb5icCRj3++8OG378EwV7xXgKteQ3tQytOGSa++Wgi9wukbGvK7VuKb2nL?=
 =?us-ascii?Q?0EWJXJZXOEqBm0JBqlO2tbAt2SnQPb289IS2u68IEs8DfLPYYNjHB1uRyWs9?=
 =?us-ascii?Q?eMtwe57d+CU0uGuuKU6ubctlM8HqFsghXtpuY2sVYPZXv7JLkcSEJyhL9c9Y?=
 =?us-ascii?Q?MgAPVeMdhqTicNhtRg6xabFe6xWuY986TUiTQw5Cnz1/OQ1dd3K8s9MsDv/N?=
 =?us-ascii?Q?rPpRUNoWQIEIw5UBltbasag6Qw0Yq2J/jqvHHPkOoJHdWcCXkiClsAx/M7Td?=
 =?us-ascii?Q?psVTESNEQ7hJ/N5bn78BKUqSDrJLti1y+ykRr+FWhvQ8nQe/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b61d0b-4759-44bf-8ab9-08df23ccfcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 17:12:23.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p5AoCV5SWFvRs+JsxxXCmP9cH98F2T2FTFN9JBPuGRftw1GIj70p5ft5wmSc1zVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA

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
