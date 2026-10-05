Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA73033D8;
	Mon,  5 Oct 2026 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219718; cv=fail; b=OKkNcpO5fk/R2bBFbVI4i9/b8T368mkNWZK5znZMPLBENn2+cusHacTYBpSDeVMNRmAAhzOp4VbF2U5XdMZDFzC47dko12PVE2sRZcZmXCqBZJeEz+nDtcTi0Vrn+ahoITnnMZ3KKSOw67z/LSW5Lp+x8OntdEpMtjyjBBflOKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219718; c=relaxed/simple;
	bh=JwnlARayWLW6OTOAVg22ZQKn2QFWq+4HfCTEdWSJbHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnt3ILCE+8bsA/99Ih3mGlePJBAN3n/C8Irb75jYXReLN+Yl4qZWmJ65BJvx4RwFmUMj1p4UciCLvJ/tAUoPxIu+a0SqOiIAfYIL/SXdQtTScRVTDdJeolFFOzYHWA8WfRNuZTrdEQuE6KFakSt9QiDaO841o0laAMDQwRg9vac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sT9nHe05; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sT9nHe05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZRKfTI+0eEUqDSKf1w23EucBNrw2xwPBx/+8Z48RpnIZB03NJiWXnVYaFCuXHfeQGVpWqtHtMzKr45iTdNZXdEE9BIs85XdjqowTd8tWaO2IeWNbNktFSKcVmAAAiWnNW+KhWG6w3PDJqXxPmPw4yBp3HZBpBa0jmU0CF2ikttd8gQocJHmXeXiPxHUcyFJ3nWYNQqibu4H+RnjJYb189rB4HtcbW6x/u40VarR/gRdSXV7j9CZLPYfUQcs3yTH/GsJdC9X7tsKsZ/B+Z6LSzibFSn2ZN/TbXgAv5oZJzxyelycf8szZHSD0OPh31LfsYjTd5pMlwdlbiBTzcjILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47Jtph/l6QFOD7YemE8bdMOO2OTM4wy/+FAnaa6Qzb8=;
 b=WKqc1fgW/6ZjWV3LzpmsOc5l1tMVuKguyJNCVrPqViUYGc2/dNsg+usiZrDUC/6U6YgZfnncSHiB6TNeu3iMAKj/bsibqsGigDBD1QAJIFBRfxlKcqqOc/Fwr+LOSpUMNkg4ID+ODuH4Z1ZS3C7lhpdjFzxEC5M9fuSP2M+8iz4M99C0aCACrwyiKsOPJE48s62esIseuh+h1BScccYLU8MxW+yB7GVf6zPS+fqyFvvGQBcn7QE1LTG7Vb9oeMGmz0vFeb0raxc+lnaukUUtf2JxwbRH9+4IfQfssKpep2K88dPOHFKBNm21dR8bGcE6AoKjpVkiMQj/C94hLUO94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47Jtph/l6QFOD7YemE8bdMOO2OTM4wy/+FAnaa6Qzb8=;
 b=sT9nHe05MyjiAa73eaAzwuOMg8Oz1+bzTW87gAMMKlWCTipDn3/XTKLQEROCPMBNpX0VWbKujqs8jX6+CUwcLz+GhC7007A08fN8pwjtk7Nq8zdhckKT+rljOpGqVdU1Ny1qnZtZ9mdX8DemqBR1iSRF9PfwsZ2cPq7TtQwljpE=
Received: from BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 17:01:51 +0000
Received: from BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418]) by BL4PR12MB9533.namprd12.prod.outlook.com
 ([fe80::d6cc:9c7e:12b9:a418%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 17:01:51 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+A
Date: Mon, 5 Oct 2026 17:01:51 +0000
Message-ID:
 <BL4PR12MB9533056AD6DE8C89370D6F6E9C962@BL4PR12MB9533.namprd12.prod.outlook.com>
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
In-Reply-To:
 <TYCPR01MB1092779F2FA9CE76D5A76E4C396962@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: BL4PR12MB9533:EE_|LV2PR12MB5847:EE_
x-ms-office365-filtering-correlation-id: fcfcc3bb-f8a2-4512-668c-08df230259c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|38070700021|56012099006|11063799006|4143699003|260925022911599003|260925021311599003|260925021911599003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 htOowbyjE3wSCrURJ0hE405XUxkJZBrVhrkQdixuFQb5OVx1dp5Zowdd5NTxkC7quQxbs8AmTyQVE2pfMtbqE/4RxI81Ydt4nN6nWct7pbvHJR3Fs8IF8NPb1M+2y8byF9a6SPOq05vmlIcMzaJfC4h0CFTCsmsWGMCC5HaNK+aGMw/wc+hY3X/vbYo6rBIe+RyIB7sRflIbRMqjhPlulcU12mnUKQylHSphceF9m6EGMs9Ln3Ar+z5dXD7iHA8OmtBbUZDR5S1rz/CxOEOFRnequqOAVlD6piVyMNNvRr77YQ2ZX/XfAdX7otIKWE/FjHJWmNnsFGPj86emdhUzfHef61KHDI3Ho5DlP8S6gyQFX9mO31UefQ70oHBdPPGfMUnkz+LBNEsMRfe4ZdWJjGA78JapxBPLX/fSobUrBiKQerQwi82T3ndKFZa6nEuwddHWlvGSi0Ra4oBt8uBRXTczjgs8boyP2R+AVyudY7uLfVc4jiNQFH6AUrg1fVNB57KRA0qrPlpRNgG1F8PScKdAXByZyMjZcQPukfVQoUHZpvcLNicC9HWAGkEboxVb5itV1GFDGCrgD4Z07TLlaoICj+MTMmQ5pVI8JIgedUtp61O/XJYKcn9t3zeM1qMmgZ5l+ms5zEaEv896m4nit+yHNlZSWOOETwHS/tvbIXRWN77154m6mE0QPUWeMHsM0fdKEik57qxeHmCvfjYbWUxhQcuaJk0ng+YPtG2OIpE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9533.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/q9UG0qQipXyrKKUjd8PHv896ooPyaMONo+OtF9lWazw0eD2TVCXUPKwUx?=
 =?iso-8859-1?Q?IvWRqZJsu7mGsXSnHmxWlR5lSOY4dLeSM0uLzEjPSaie+aT+hO495jdxGn?=
 =?iso-8859-1?Q?g7pnrlhiey357RtTfZGf+AvAUkFrN4cC2q7JEptXOHDRksA9qL4oaaCYdP?=
 =?iso-8859-1?Q?KP6qnN8i8kcEmNPBYYUIHS4Q/mP9zxmz/RudT6WZSqU2SRvSzPO724yjn+?=
 =?iso-8859-1?Q?EN5CQ//Eq0qLEElIybHX4ZgjoV57ZhLfjvpAXKxn2AwRhQZUswxdkCqFvq?=
 =?iso-8859-1?Q?m+Ofqr5uNpmN8z/SJkYaqrM4doqE6TMl1uz5jOm4WwzaiTCa1KFrdMD0GF?=
 =?iso-8859-1?Q?q/GPkGtDkqqmbXRFSyCwWnrGQxoGUPTYZa+tOMyhH2PUSLvUZ0hcK04TK5?=
 =?iso-8859-1?Q?A5v8vw/CL+NOo55YyaYTcvJZfdRWO9hPd05RwaqPoo0b1yA+4RNKUP2g/5?=
 =?iso-8859-1?Q?EjQ6Q9ibzrXYw9xsJOy4QKvQednSdSAWDaJxTjQ9nm1fKatPKFvFjhA6mU?=
 =?iso-8859-1?Q?eveCaCEotGAvxWtgdNznD4lPFXs5k6tlGN2jB7EVCF0ZKK9ekOsj8o7bS3?=
 =?iso-8859-1?Q?4wukdZiCYtX0/i2v1XEul3bLlUAoepjeZEFfD7/6/kH9LRQX/wZ8WZ1n85?=
 =?iso-8859-1?Q?Bot+3R2oX0h0DP3q+o4srTHS5ZhVxm0H5+F3f4PUkAIJF237BJC5ilozSr?=
 =?iso-8859-1?Q?OIAebhFx0pKYq2wNa43NTH0It3n2xJXUhWV6MTi8yl+9rZkvrTpX4cfgyG?=
 =?iso-8859-1?Q?ACBVi5KhokppphkTN6NjhK7ie14aDvkwaeAYldGbMILTFMtm2sXKNrZz0U?=
 =?iso-8859-1?Q?TOzcILTNSDTTWvF9aiTsMdXE2MQgAxUiFeBaf4YgcfuInJ469/IH4kREsM?=
 =?iso-8859-1?Q?SjlvEUkXYzuKIcVzbFMgBx0DNyE06TpTqZNoYNz8hUWE3k+S95DVMI0Ms1?=
 =?iso-8859-1?Q?tJdIKnuGs0UljVaRER0nbubYvaq3R7EenWIUupa/IvCSIF8DhgEN0dsfma?=
 =?iso-8859-1?Q?LwIcrtm6EmVtCvKzdkUR9vzSU58BNri1WR1YFS7Ajfqd9DftkDDqs612by?=
 =?iso-8859-1?Q?1NiWOtQLPmpRE8iYhalmheBmtboijSH5E0F7NfNeO8amUa30IVUjQK+QkZ?=
 =?iso-8859-1?Q?xlDNiSFoNXyKZ1bLI+KS1TtSKF2qc6RHCBqTvfDndy4d49URQZGKbD1w6v?=
 =?iso-8859-1?Q?O6y5SY73df5b0ZGpfWDh3Xl4qC6TQZQ1sFr38PfsO1ykf1VnGrNUOrs+rO?=
 =?iso-8859-1?Q?e/1e6fviqE+rxLXm7ikc4OJKkpE1osvX6zOUV3UWWtce8ZwNTuxyLgSJlW?=
 =?iso-8859-1?Q?9gWHFd0y4chDThIm0DQ3x6wgQxzDUv53U2BGhwIHpRnnFos9h/HgO3birM?=
 =?iso-8859-1?Q?m7KC8jE5DYPhkkfu/91T6iNdtyYg4gECbpzern7JTNxRADmWe5DpSwORji?=
 =?iso-8859-1?Q?txanWYlbil38Fh2VWmsFNAAAoL3VAv+9eLi+MU4Ub/nN+YGjMSfCtZfiln?=
 =?iso-8859-1?Q?lbTzqq4SMyUTlWqku4yrztigLOc7N0Egl1fvPTWWiXaQLC/r9BzspN59pz?=
 =?iso-8859-1?Q?lUhF3Rr1mffNW+7hj5gaZObmyv11dsOcI5czjVyhfASc/5XwnhrxXlmURv?=
 =?iso-8859-1?Q?Q/4XGqPbQ5PAPlJUC4S2iy+HU13M2d21lM/miIbrmP8bfFk/WfK5sV5Ihw?=
 =?iso-8859-1?Q?/CM5BhWKZjtPpFqr2oarTDzUq/Da81NTNgG0G212BrxQY/o4tHdKT9Abbq?=
 =?iso-8859-1?Q?SNEzCx8V0pJxg9ulMRnt3U6Gt0PDqAN12M2BIUPYxXKb6y?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfcc3bb-f8a2-4512-668c-08df230259c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 17:01:51.2532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CqUz9ejriKmEnsNz1tS1GcY6Be/ogB0LsmK0PMq/fX07/8Sr7C4NGIlsiJadFB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

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
