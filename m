Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7D3EC685;
	Tue,  6 Oct 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297244; cv=fail; b=K5S7z8aHdeuGmSdtQ1NTotftZ+oAjC5p9TYXWDA8Z3rXySy/myU5XxWBAsHsSPpbq+eMqdgF9xke7P2YDsdCQ0E4SVkRkjld3yfIpLZrwBdiV9F4KF9P0oV+omgdaAkXxCQxMxeVtC9lnxebJIv3UCtQmXwh54cHijTpbpeOoOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297244; c=relaxed/simple;
	bh=kn8Ph3vYP+C1guHGUt8rM+O1eft0yzBf1qr11O8gOKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VE4oZbpJbfllPyuDZb8TAyEbZHu/qBAsXEW4eYBjS/EcSEKTPN79+YccLo1kr2BTTGyCXD7yIcBTkxRrIJ1eBcf6fIh0qk3fWWicwDdQNXcded0YHn7Ju8KRFQhqaWMRamYj9cPLVuDt5mDzpUKLngnKt4PdcZJfgtcOMBHvrG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y3FYlWur; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y3FYlWur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcue1AGLlyKOc9ITxZVtrlYqUOkS+BFc5iPE+WA9eX6mQoollXpQVWBl8VrWtAkA2EhqaO/awUfty0iAL9JiVUilc558R9DnLKsPWvmQu3GhtGtfIVgwhXAreM6EM6k3swoBA3vCgrJDSe/f/UoJGnFXh/Hl2/A1+fQkVYIZEgZM3c8ddV9wiM6Dae/RwlJDJlIf84FYIi3gBxcdc+1sZwpfFbC9ggiknNLW7QeHVE+QReqEFhnoAYxzksnZypqr6I9LurYKaH1973QigmX8pZhYjQox+w0VvPhDu1FOnDKjBSsqNE7f+8V02CcqJ4yWc2CRyDkYvjUbTqJLh9UY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHdyInXuyMfmfxVNJCLPWUjPzlOFS9+fQ7Wwd7zWODM=;
 b=CzubZMD0uE2nSNjjTlv7iYCJ+EYpIkYCFUBMfSDXhLifQSftkxUT75iV+ea4CfdIcDGFq3ZuSYwYBSPmdwjCJMUntS233zHb8N6RghodPzpco0hruf0KoYwQ0+4gOmAVSQ4smYtvxpH7AUf4fTOsd0CzoDJyaFjPe5NcRVq4fMXEe+8clse7AlRApY33P4MyXWABxNcedzRwMAG7XzigviNK/SH7SPkVllMZ0kbmhisl3Vy6+PwdcLmczKO9f0t6NbIl154Vs6GIY2MywYKG9kBTOomRd8+yc3NdX5XeOoFoz9ha9w2CinoqjTpEEMgrRgoBfOcI5AbV27iBLX9lSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHdyInXuyMfmfxVNJCLPWUjPzlOFS9+fQ7Wwd7zWODM=;
 b=y3FYlWurCUzWo52N9FMG5Pr7O1Xw9kS1kW+Cm8y6XCtv0Lys7AQwuYs58NIxo7MLl6WzHpEexyKCEBVhdxtZhD/TX/6YpLkXTMP36K0S64ZLfLhe10xhKsR77yveTkaI+m+S+5wEnJsPHAbe/6HxBVpJ2eAU92NFiwX1VPykbCw=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 14:33:28 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 14:33:28 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMA==
Date: Tue, 6 Oct 2026 14:33:27 +0000
Message-ID:
 <DS7PR12MB9550E85CCAED9C8C0D19DCA79C952@DS7PR12MB9550.namprd12.prod.outlook.com>
References: <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260925052727.GV106095@black.igk.intel.com>
 <TYCPR01MB10927DEE310195FA62C67E9D296802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <TYCPR01MB1092798A529672215ACC586BA96802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
In-Reply-To:
 <TYCPR01MB10927C563CDDD5216CDFCD4D696962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T14:46:55.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|CY8PR12MB7243:EE_
x-ms-office365-filtering-correlation-id: 57ff862b-a719-4355-4f8f-08df23b6c968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|3023799007|38070700021|4143699003|56012099006|260925021311599003|260925022911599003|260925021911599003|6133799003|11063799006|10067099003|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info:
 NL3ExLWSb4g5867KFP5DD5QbucdQZFhpR2S5Brs0Q8lomQy9pI8r3O5sbgZ2Vbja5Xkm9Vu8NBME80vqiQgv3wWeKHjNiZtY6IZsZaBacp94qArrwejTpcaZntZJX5xw6n+DmwpJBC8/cHk3oEuH6lKNGnFyWv2Q2AVq7Li8+NuCRsTjgs585czzm/UlBmRotwNXFiMSAw1mGb6rIfafGNFdNMMEDSMmrdSaYIPkwgi1pzskxgCMkpFj2ynbQTTdU3vyM1QTI1xrOehQyoU6o4WAVUGQ3ij3zaXDYXjEnCqoob3pEK4y+izhOEZ+daX3zhMcFCPvvj9EAyVdlUrJR6HwwdpvuVVTzezUo9OcKuxTpzB8w8tV5Y4EYkLINNvbCmuaEmAE4HAw3XrIUFRAWdVoFwucPq4Oq6lXmlPHrSacS7cgMvnnE3RJ5J++3WkliOUxGkYXKW35fd38/zL765V0/+Q0XeUdFYRNuE7vdqEbfgTA+HMJDLOjGkJrIiKU6P59cu8bd+TVYBvRXCMNVCJCdsyahUia8GXMYybUjnfYJxfStymCY9CfKvxzcbRxAnpGO/Yl7o6a9IgI19B05aq1PCoCKENnUZY2foMDpfbqh0XdZNLj1PpRJ6WbMvKD3i4Nr7XoKWKZ2LEqjC5ou+SUauUeOAsAXYyi/9AX1LsyPMqXZVy7h0mcb7pWEowoyQxXh49VeFtXrB7KeEDhzXJ78EWgbxMmFJCoKbD8gCw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(3023799007)(38070700021)(4143699003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(6133799003)(11063799006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cT3Tfh8i70MCH0qIrhvUrHrxKN2O9AopV3JBGc5wqSRWiBnQpNY7ndu4xz?=
 =?iso-8859-1?Q?9IcpyiR6cACuJLXTr4ymOHp/gy8ePEQ+Einl6fKMxyMuheJSi+jfNOdoTL?=
 =?iso-8859-1?Q?Djd/Ma+8DqaNsB0C+Ok6mBhOSy7S6WHZcT2/yviAMwqZDZqLM6v0ljqu45?=
 =?iso-8859-1?Q?UhWjLWsEqU7vS+EmL6ZiOQyzNSxd/8OKE5mFf/zvQJqIc3puIdfeHQSMng?=
 =?iso-8859-1?Q?rbb08tVdLBuN2jeaNBHQm9bpaXtaQfqv0LAApsI1+LtNnSwmFBIG0r5KkL?=
 =?iso-8859-1?Q?426CqECrJXmBIdlH15ZTrdSTaegAsdtchSweCysIUkk2HgiTzO2NpdPhgs?=
 =?iso-8859-1?Q?Wak/K2fga+nYs7lvmRRcHQUe2eysSLwfXWGNTAJYBwIHESVJGJWOMJB+yh?=
 =?iso-8859-1?Q?rWgBh7lS1g8gj2arZhurFsEixto7X1beZWjqotVHaU+W7NrT1uZfEcEjva?=
 =?iso-8859-1?Q?m8N2G2giEe9xXF4tMsidbknu5J3e3shE1rCIooLesaFXc8/cEuKZtSauwX?=
 =?iso-8859-1?Q?cBXvJuGzABDS6jzDWUV8LbFD3Kbq1P6EdaAJJVkXgQQsjDUkI+5CRoiyRe?=
 =?iso-8859-1?Q?5N3r+FBSvxDiaGN29m9FtP2dEfj9cKC4BRvEvICJTkvsWbQB2YLXoxxB6h?=
 =?iso-8859-1?Q?O283WmwSWZ6WzQh9RL0CuuBV40MSfacAaFhJgNzY1PQYhVdsYhMnh33zkc?=
 =?iso-8859-1?Q?ED5h2vb3bQ7t4Qy3JJIaWCagIJS4S6fWsnlc975oMYHs7tourMu7sOTknL?=
 =?iso-8859-1?Q?s72VzbGffPEr06u3J039UntGjsec0FJeVnIRSFoO/t/HzUeEhArKVDiizl?=
 =?iso-8859-1?Q?KYYPSvHZfLShaYWtpDDoQUMV+hZ4LJTPVluRPHof1vM/uX2s89aC96+fjU?=
 =?iso-8859-1?Q?D9Di23ooNblnUcfbTV9llSRGzCTBReCfROWqGWXquRS1EzK72363zYqwTG?=
 =?iso-8859-1?Q?wV4vfy8LmMo7sXwvFB3zFmIXIrLChrHLu5Kqh6AiFLVtS0d0xgvr6OwFyx?=
 =?iso-8859-1?Q?W2925JyZpXikT0TfSgA4PNw5ThdkSsnC5TsOOwapfL8E4VWUgi0LW18vHJ?=
 =?iso-8859-1?Q?7ces3b+k+YmFdOsdpckh0+6inIta82dly1BqrcuZMKrZKOjt0a6AN2iBkN?=
 =?iso-8859-1?Q?xwANTQ2BUfSWVRgsmK64EHad01j/X1N3r2Kr+oY/F+sgep6O0eeJlCtoA3?=
 =?iso-8859-1?Q?OT5JhiItx8Zge4HuN23XI1rGHtqi6vIG+Fa5Xu8wA1vhiZMgaaADaGnJ2s?=
 =?iso-8859-1?Q?OUyoJCYbjjUWdr7wZeMyWXJHgaEC0lG6UVemwWlTbFJtFDn1q9g2xorAuA?=
 =?iso-8859-1?Q?up1YmfkjkHNkXF1LTlPgj0qQoFFHea8er3Y97uMKAdF01EZhfF6WLYHwqG?=
 =?iso-8859-1?Q?llKa4styRaWXgwIaumOaEGIa68Xnk18oGtlvMv2sOw+6K9JfNsIxf4OCa5?=
 =?iso-8859-1?Q?rCemX4CTJOyNLx7IrVbbHa5q+5hWkaqjwaQj4+m8qPoWel7kHW7t70igoE?=
 =?iso-8859-1?Q?qhGYcZHD6edQqQHcLy9T+PLXl1GCsEeDHS3F2pECL+cEDzl5V7pXsQ8ZSl?=
 =?iso-8859-1?Q?9ITB6pFGjF4zB3gCe21op+neIpqVRu1Jqk1RKoLZM6cfGzSaDtzpO7C0Wv?=
 =?iso-8859-1?Q?M/sHl5f86wCuNdXBIEgMBY5aQfhwYlO/4OU0MDLRBElEEs4IhuuHaIvwUD?=
 =?iso-8859-1?Q?j/2ev6aZvUIfJbSmc+ZW4HN1OFy1aJ+jOqLXfaUpSCiqfEO/qeiEw4xa8p?=
 =?iso-8859-1?Q?DUwJimNzXkR4HtsEY16EHh9klmw9+9Md91bT4WbVYf5ukB?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ff862b-a719-4355-4f8f-08df23b6c968
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 14:33:27.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCiggY5QMD3fpB+tdNOGLLG9DoTV6T7mt6lfXfcxgVDUyYMTmMmEs2hyBtgy/rkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243

AMD General

Freeman,

Ok, regarding the 00:03.1 device, I am seeing that it is misnamed in the ta=
bles.

BIOS Bug Report: Thunderbolt/USB4 tunnel port `_DSD` misnamed `XDSD` (00:03=
.1 / NHI0 path)

But that more than like does not have any bearing on the root dock enumerat=
ion issue...

I am unable to create a case where I can replicate your fail on my test sys=
tem yet.

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Monday, October 5, 2026 12:10 PM
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

I checked the PCI topology on this system.

This laptop has only one physical USB4-capable port, and I do not appear to=
 have a 0000:00:03.1 device at all.

`lspci -nn -s 00:03.1` returns no device, and `/sys/bus/pci/devices/0000:00=
:03.1/` does not exist.

The relevant part of the PCI topology is:

    00:03.0
    00:04.0
    00:04.1-[09-68]----00.0-[0a-68]--...

And 00:04.1 is reported as:

    00:04.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD]
    Family 19h USB4/Thunderbolt PCIe tunnel [1022:14ef]

All of my reproductions with the Kensington SD5000T5 have therefore been th=
rough the 00:04.1 path.

I do not currently have a second 00:03.1 path that I can test.

Thanks,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Tuesday, October 6, 2026 1:01
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

Sorry if this is a repeat question, this (non-returning sub-devices) happen=
s if the dock is plugged on both the  00:03.1 & 00:04.1 path, correct?

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Monday, October 5, 2026 10:39 AM
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

Sure. Attached is the ACPI dump from my ASUS ROG Flow X13 GV302XV running B=
IOS 319.

I copied the DSDT and all SSDTs from `/sys/firmware/acpi/tables/` and decom=
piled them together with `iasl -d DSDT SSDT*` as requested.
The archive contains both the original AML tables and the resulting DSL fil=
es, along with the iasl output log.

SHA256:
9c2664d8927f2550d171860867f00fbebe161c18017cf58fb84445475c392469

One potentially relevant detail I noticed is that `0000:00:04.1` maps to `\=
_SB.PCI0.GP12` (`_ADR =3D 0x00040001`).
Its `_DSD` advertises `HotPlugSupportInD3 =3D 1` and associates it with `\_=
SB.PCI0.GP19.NHI1` as USB4 port 2.
The NHI1 power-down path also references GP12 and appears to contain explic=
it handling for PCIe `[0:4:1]`.

Please let me know if you would like any additional traces captured while r=
eproducing the failure.

Thanks,
Freeman
________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Monday, October 5, 2026 22:35
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

Hi Freeman,

I have applied a patch to stop the toggling between suspended and active of=
 the 00:04.1 (AMD TB Tunnel Port Hub) and the Barlow Ridge device on my tes=
t system. Just to better understand why you are not seeing that issue and I=
 am, can I get a zip of:
sudo cp /sys/firmware/acpi/tables/DSDT /sys/firmware/acpi/tables/SSDT* /<tm=
p-dir>/
iasl -d /<tmp-dir>/DSDT /<tmp-dir>/SSDT*          # decompile together so c=
ross-refs resolve

The ASL may give us an idea of your original issue with the dock suspending=
 and not recovering sub-devices...

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Thursday, October 1, 2026 1:28 PM
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

I tested this with my original workaround disabled and after a reboot.

The Kensington SD5000T5 was connected the entire time, and
0000:00:04.1 had power/control=3Dauto.

I first monitored the sysfs runtime PM state directly. On my system,
0000:00:04.1 stayed consistently suspended rather than rapidly toggling bet=
ween active and suspended.

I then traced the kernel runtime-PM events for 3 minutes, filtering for
0000:00:04.1 and 0000:6b:00.6. I enabled:

    rpm:rpm_status
    rpm:rpm_suspend
    rpm:rpm_resume
    rpm:rpm_idle
    rpm:rpm_usage
    rpm:rpm_return_int

There were no events for either device during the 3-minute trace.

At the end of the test, the states were:

    0000:00:04.1
        runtime_status =3D suspended
        power_state    =3D D3cold

    0000:6b:00.6
        runtime_status =3D active
        power_state    =3D D0

I am not seeing the active/suspended toggling on 0000:00:04.1 that you are =
seeing on your test system, at least under this configuration.

Thanks,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Thursday, October 1, 2026 22:54
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
Do you see any toggling between suspended and active (mostly shows in sysfs=
 as active but quickly and randomly toggles to different states) on the AMD=
 HOST Bridge Tunnel (maybe 00:04.1)? It seems the Barlow Ridge controller i=
s the cause of the toggling on my test system. I have tried this with 2 doc=
ks utilizing this controller and see that the Kensington SD5000T5 dock uses=
 it also.

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, September 25, 2026 10:49 AM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.w=
esterberg@linux.intel.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andre=
as.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vge=
r.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.N=
atikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceL=
an) <acelan.kao@canonical.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Hi Mario,

Yes. The laptop is already running BIOS 319, and I do not see a newer BIOS =
available from ASUS for this model.

BIOS 319 has also been installed on this laptop for over 1 year, the reprod=
uctions I reported were all done with this BIOS version.

Thanks,
Freeman

________________________________________
From: Mario Limonciello <mario.limonciello@amd.com>
Sent: Friday, September 25, 2026 23:24
To: Freeman Z <SHD-ISAC@outlook.com>; Mika Westerberg <mika.westerberg@linu=
x.intel.com>
Cc: Kovacs, Alexander <Alexander.Kovacs@amd.com>; linux-pci@vger.kernel.org=
 <linux-pci@vger.kernel.org>; linux-usb@vger.kernel.org <linux-usb@vger.ker=
nel.org>; bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org <we=
steri@kernel.org>; andreas.noever@gmail.com <andreas.noever@gmail.com>; Yeh=
ezkelShB@gmail.com <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kerne=
l.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath <San=
ath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, J=
uan <Juan.Martinez@amd.com>; Chia-Lin Kao (AceLan) <acelan.kao@canonical.co=
m>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents=
 JHL9480 downstream enumeration

On 9/25/26 10:12, Freeman Z wrote:> Hi Mario, Alex and Mika,
>
> Sure. Attached is the exact .config used for my unmodified Linus
> v7.3-rc4 test that reproduces the failure.
>
> SHA256:
>      488899cc5a0b5f2de69466df2639e39769d40d90682f51690400399a549309c2
>
> This is the final .config used after make olddefconfig for the v7.3-rc4 t=
est.
>
> The v7.3-rc4 delayed-rescan test that succeeded used the same configurati=
on base.
> The patched kernel was distinguished with a different LOCALVERSION.
>
> Please let me know if there are any other platform or configuration
> details that would help align the reference-board setup.
>
Thanks.  Can you also look for a BIOS update on your side from the vendor i=
n case it ends up being something unique to their BIOS?
