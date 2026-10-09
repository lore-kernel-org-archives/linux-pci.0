Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E6447811;
	Fri,  9 Oct 2026 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553148; cv=fail; b=scSblJlVgFqpJFLzfRVWoeQvo5LcfSNXq2bZAW5zUZ1JppQ7XbO9NsFY/PFCobbv4WA4CiFhBjaoUrKVQpNHBw78JS39PngHnae+shU0AEkBFkJeaBjnuMXVOB/TsURC1AWmIx77XSMWmC9X5x5mxGy03taOZgsRgBZqUyqDOO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553148; c=relaxed/simple;
	bh=9tDzK7qGI6nuHFjl0M5JcbN057qLm5WTdQ15jkKxrc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3s+QIAreOwmws59uJ4ZmVsfKeqapYu94Du7KeDxPk7TmOTfhyDg4tO7XX3nMtfjvwSq4Wo95gwzDMhSZMtapBlThq8CkPFjf33YdQO6RFOiLO3s6vDsKVpPGFCZn79X0s3nFFK1Wz8Qp7baf7FdKlrOFbgVg4J0+U6r70q0fkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rtM13N24; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rtM13N24"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh3kckzrdM3BHjQNAxZVrRDhNH4vYbkIjKlsSDGIiPCxjfrPxaoetRmnxmLYM3Lk0Q8h88pDRqbDwnWV5XaNhc/A3PdzxEk7xBc9Uw6AK1rBMyBTYnAWIuVUx4Lta+zMWtn585GREBdyQP2nwEX8V53n34yeIoOJA7cGv1GRnhkYwyDmNDZHClTVrWEch1U+2yqSGxg00Cj7ZoNqkesTbLrpcDniFilbPDdeP2nGbkli+tEAdpbnHgapkmp/2yEEsW3ROfQWv52NKKaSZFE/X3M0w+RUXStQjnS//xh5jGtgqxjZMIWnAvuz06TXECrOV5Y+XC07kCfL5w0OXCIwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRgyHJW6dwHiei6Bp+Jss3fMD/bydayAzTse8d5UsW8=;
 b=Tro5AvTmlT0Fqungc2KXlaIravnbnO2VGHCP/E7LLfm86npYctld/08XX5mAuSRvfoPbpK+IBeV9LPfvTxCtbiiajSboEXkPoHpq8edhVZXxEQNtvHEaBJtGwsj5K///WSsR5pyRI50BErltMiJK9RyNcYEhXh90cS2JeVx2z+F78iaRhWKp++eitFDV/banq8m7qH6asjKB7rroJ3RUxHi8CKmityg9/V13025Hsb6qWR/zjGEH97c+2QwAC4a/MTLjP8xf0Zhhk+i0ewAEifotQ2sZZwL4N+IHJXjPdLCIlXYOW7BJicwo37oy1Co6MPvIKftUzDLcVh3tr9aLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRgyHJW6dwHiei6Bp+Jss3fMD/bydayAzTse8d5UsW8=;
 b=rtM13N24lpKpxABPgLr89zV3ih3/+AfNZVstygrigW9Sy1QAaQYefSCkx6D7WiAlEvTtCp826IeOt7JSBd86hSxNEPwg/zfSlx7wvcncAJWJjny+ubjLooGQuyukcgSGgVxRmqFiY7TRxhR5/GI/DE7i2YnCv+3AlWpl+T3sAAQ=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 13:39:00 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 13:39:00 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oIAAPdKAgAYEaGCAABWugIAAFm+AgAADFoCAAWNLMIAABEOAgAAgUoCAAAeDEIAAHYuAgAAI8kCAAAk1QIAAFJeAgAQrt/CAAASwgIAACANQ
Date: Fri, 9 Oct 2026 13:39:00 +0000
Message-ID:
 <DS7PR12MB95500DA47DA5616DA06DF67D9C922@DS7PR12MB9550.namprd12.prod.outlook.com>
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
 <DS7PR12MB95504FE60773F44B1950FEF49C922@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB10927E84328D5CB5D9278D98096922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB10927E84328D5CB5D9278D98096922@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T16:59:54.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|PH7PR12MB6419:EE_
x-ms-office365-filtering-correlation-id: 7521ea3e-ba55-4535-3fe4-08df260aad0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|6049299003|366016|1800799024|38070700021|4143699003|5023799004|56012099006|260925021311599003|11063799006|10067099003|260925022911599003|260925021911599003|22082099003|3023799007|6133799003|18002099003|4053099003;
x-microsoft-antispam-message-info:
 2+vmEshUcm0O6rbhPW5vL3pWfEq9i6ixap9OsdFKahpzzlWZsaU7Pv7NeNTNjlMuNoW55Ftalbohypi4HkHrsTD/WcbgTBi9/7Y4M3ky8FLIaS+LHXst7oWVfbtrydfN06XE4T4OFNhS/tS4Kxzua1v8HKpG/Vj85QgYuJD3MzyAGkD9DCSGkhlsmU4GEzTwCnlO/ZkiKR1fDN7XACawK87MNmcVDN939aUzkHWDhTAn3iDNrapzolle97sywlfkG+3Yc1/BWy15P+tKm5gluSv165kHlLxGpIaWFxh/NJ01iEJsCrS+uL5YVbS8MY9NxVq+IZFFjdQG/HGIhNgte5fhPaU1fFh+9QugXyIyot5MqtsHHXWldTzBAvB0VUZR3REmedbrmamE1+DZyVkdsd92bDr8Bd1e8TrAkD5x0y5NtYCcxQPWaKX7cpON0/p6ZMKQWnG5fdcvEmp83LSrxz7hFvl6swid7myEHfDd0DRfM5grpW7MRbVTkwa6HH5u5KGEwK1ZKqT6CSpq1K78UVxB9jYqMbR349J/h73ZcilvuKzuUlM4YKiZ9Ydo7PFcWNc4/jkc4YB13llbnSoh+V9TFACxkQxSTCn0ghZL9p2BY6CDuggRG1T1E0J9Q0DNVoTgZN3i0QJc9+d8SZStEoJopLtXoU0sda9fKdAp0UQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(6049299003)(366016)(1800799024)(38070700021)(4143699003)(5023799004)(56012099006)(260925021311599003)(11063799006)(10067099003)(260925022911599003)(260925021911599003)(22082099003)(3023799007)(6133799003)(18002099003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?apuA/f806COImjYLHGjDPUD9j3aExXvSx5SgeiNVWdT5A8atLUV3U01IvZVB?=
 =?us-ascii?Q?jo2znI2FhZqwQhq9235dJrep3tmJ9wwxfbgy35f/3hlntNRTYlWaPTAQvpnN?=
 =?us-ascii?Q?4d+vNaZLGVRsz2UT+ISuh3IhI+Syu5uH9fMqoZKucyUszLs/UrHKn17vsDiu?=
 =?us-ascii?Q?4HNOUQEw2YkWeQt0GpUdpuIVLFkciUhW+bMsSpoece6Q6rVYYa5jV9MO3rWX?=
 =?us-ascii?Q?ghCSfnTEmvwbZCSvo6m7ZXetozbSl1TbXXHT7dSlQc3DqEiNV+MD7GJG1hH6?=
 =?us-ascii?Q?ObIZfGRJLuretrix4TTiJFWc70CoGECToZh7XmA+CTt2bLFj/j4ooooPrR29?=
 =?us-ascii?Q?A+rPU9OGgbw5P6aAdF8LMy05n2D946I1He04xK9OJ+cLkiOdiKU+rY3CE3zz?=
 =?us-ascii?Q?+LN18nOWwyL+xb69RzBQXqeZ9Qtpg0SWfO6Fm3/E5eGyhACtaUJEHzmpHdjM?=
 =?us-ascii?Q?fFM8yDg+cXprxdSt8FI1It5hzKQeQaR2wrDIFjhhfdCWPdIngH+YqFuViif3?=
 =?us-ascii?Q?nUMX3KxHNp+vKBdY/326/EunN2Io8V40ZsuDiE/eaiv1NKLkyoyWEJ1yoUK4?=
 =?us-ascii?Q?W16O6aP4lesD6Qr4dFSDPAzhQEbxAM8Cj4aC2aRFt0zoCdy4qShxs8KOFjmT?=
 =?us-ascii?Q?WZzridiT2gAEMbJdR69HmXRLVrJJdNA8UozrUY7StStH5Omf8Amf7+RIXEE5?=
 =?us-ascii?Q?NicXC+lJX+insKTT8K0T4DyKFYDBjLdHe1RaJrXpdP/XHQdU99ubLV4zcB9/?=
 =?us-ascii?Q?2m7N0XHXnXkmTCVjP9NgSgdLXl4w2rnxB8cKlkuUKE35PpnWGWdb+kdI1+k5?=
 =?us-ascii?Q?23W5qiGgkQqhXRjfzKB52RtwLYX7YyRcr4noZlA3Li8Ii0pzhN77O9vVHEpl?=
 =?us-ascii?Q?mUX9fE0DtWz75DnY2lXvQS2GlUuYoQzzs2+EavVKPRwqbOYz90wXdihP1c+p?=
 =?us-ascii?Q?5q7+xV3dHUE97/5vqYsojtTR3P8feSz+y4pPZ3p4Whe9wudWWDzcUu8kXDnY?=
 =?us-ascii?Q?QYe+rUvwkigXDu//2pqjRTY+A7ZD9PBV0Jgwec5iMzO9sGB2AlN4Xw16NUcf?=
 =?us-ascii?Q?fgi0ffDu8dJOqFRPeosfLOClZe6vOiHLkCyIsb7n84qoYhUB3NA5BOG2vNat?=
 =?us-ascii?Q?hzdMYOkePljWWJ2Q0rGjTvfUqvKFfXcheuUDNNmM36PB0rqcdhOl6KcaISMb?=
 =?us-ascii?Q?gMG2K0fIpZJMSw8GZYoRXo++ndtMXkkoIg//WZbfIYsg53zU35h8FPRUGMqY?=
 =?us-ascii?Q?HBWQEWDo9905w6xFQkWc7dhWVtFOIEXHKr/HUIwNvqC9ClnHPNXz1FqLcgsm?=
 =?us-ascii?Q?BkI8bAzIcIqG0bQGPXB4SF1wvITBRMYpQNPBL9E7EQw2NmS82pR5o6qKOl3U?=
 =?us-ascii?Q?+/nJhCUAUIpRsXg1MYuvra9FcV1Bruh18gggbXgLcbNMWXBqw1UBhBQnJk4X?=
 =?us-ascii?Q?KbDX1ZKojRgS1BkaTEzulPsQUIGSw+DTqaz7lXfKZ3Yw3vhhJElDGLoUKYUN?=
 =?us-ascii?Q?Ez3hIKZyVim43CB0c/D6pkQFoIVjowq3hahBsmBJKqcnfSZnmPdoTRdRcA52?=
 =?us-ascii?Q?UqshNiDwN+rjQ2ylqD1PmU6AsQgjAM3sBGjUEhhjxiSiWohk69lVuVFEfv2H?=
 =?us-ascii?Q?wHjCVuEVHDAin1GpdFs0seXx1UsXJXkG8jdgHbrRAj28TG6DV+YFohKUYwvi?=
 =?us-ascii?Q?2UgCrfn1GesIUARIHoGppqCymT7iuFDU+oFE2VUhSo1aY2fh?=
Content-Type: multipart/mixed;
	boundary="_002_DS7PR12MB95500DA47DA5616DA06DF67D9C922DS7PR12MB9550namp_"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9550.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7521ea3e-ba55-4535-3fe4-08df260aad0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 13:39:00.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJlOZEhiDc8cuHqbAuhE17+blQ7763bNMxOnnHM1X25Hb1LsXj3y36Mij8WI27xa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

--_002_DS7PR12MB95500DA47DA5616DA06DF67D9C922DS7PR12MB9550namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Freeman,

I have attached a modified version of your capture script, please return th=
e 0 & 1 logs of the attempted plug actions.

Replied or Forwarded By:
Alex Kovacs
845-625-4422
akovacs@amd.com

-----Original Message-----
From: Freeman Z <SHD-ISAC@outlook.com>
Sent: Friday, October 9, 2026 8:03 AM
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

Yes, both tests were performed on CachyOS.

Best regards,
Freeman

________________________________________
From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
Sent: Friday, October 9, 2026 20:47
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

--_002_DS7PR12MB95500DA47DA5616DA06DF67D9C922DS7PR12MB9550namp_
Content-Type: application/x-tar; name="d3-cold-test-script.tar"
Content-Description: d3-cold-test-script.tar
Content-Disposition: attachment; filename="d3-cold-test-script.tar";
	size=20480; creation-date="Fri, 09 Oct 2026 13:37:52 GMT";
	modification-date="Fri, 09 Oct 2026 13:39:00 GMT"
Content-Transfer-Encoding: base64

Li9kM2NvbGQtYWxsb3dlZC10ZXN0LWZpbmFsLXYyLnNoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA2NDQAMDAwMTc1
MAAwMDAxNzUwADAwMDAwMDM3NjMxADE1MjYyMTY3MDMyADAxNTQxNwAgMAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3RhciAgAGFsZXgAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAYWxleAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAj
IS91c3IvYmluL2VudiBiYXNoCiMgQWxleCByZXF1ZXN0ZWQgZDNjb2xkX2FsbG93ZWQgQS9CIHRl
c3QgZm9yIEFTVVMgR1YzMDJYViArIFNENTAwMFQ1LgojCiMgVXNhZ2U6CiMgICBzdWRvIGJhc2gg
ZDNjb2xkLWFsbG93ZWQtdGVzdC1maW5hbC5zaCAwICAgIyBEM2NvbGQgZm9yYmlkZGVuIChQQVNT
IGNhbmRpZGF0ZSkKIyAgIHN1ZG8gYmFzaCBkM2NvbGQtYWxsb3dlZC10ZXN0LWZpbmFsLnNoIDEg
ICAjIEQzY29sZCBhbGxvd2VkICAgKEZBSUwgY2FuZGlkYXRlKQojCiMgUnVuIE9ORSB0ZXN0IHBl
ciBjb2xkIGJvb3QsIHdpdGggdGhlIGRvY2sgcGh5c2ljYWxseSBVTlBMVUdHRUQuCiMgVGVtcG9y
YXJpbHkgcmVuYW1lIDk5LWZsb3cteDEzLXVzYjQtcG0ucnVsZXMgdG8gLmRpc2FibGVkIGJlZm9y
ZSBib290aW5nLgojIERvIE5PVCBydW4gbHNwY2kgb3IgYW55dGhpbmcgZWxzZSB0aGF0IHJlYWRz
IFBDSSBjb25maWcgc3BhY2UgYmVmb3JlL2R1cmluZwojIHRoZSB0ZXN0LiBUaGUgc2NyaXB0IHBl
cmZvcm1zIG5vIHJlY292ZXJ5IHN0ZXAgYW5kIG5ldmVyIHJlYWRzIFBDSSBjb25maWcuCiMKIyBk
M2NvbGRfYWxsb3dlZCBpcyBydW50aW1lIHN0YXRlIGFuZCBpcyByZWluaXRpYWxpemVkIG9uIHJl
Ym9vdC4gVGhlIHVkZXYKIyB3b3JrYXJvdW5kIGZpbGVuYW1lIGlzIHBlcnNpc3RlbnQgYW5kIG11
c3QgYmUgcmVzdG9yZWQgbWFudWFsbHkgYWZ0ZXJ3YXJkcy4KIwojIHYyOiB0aGUgcHJpdmF0ZSB0
cmFjZSBpbnN0YW5jZSBub3cgYWxzbyBjYXB0dXJlcyBXSE8gcmVzdW1lcyB0aGUgcm9vdCBwb3J0
LgojICAgLSBhIHN0YWNrdHJhY2UgdHJpZ2dlciBvbiBycG1fcmVzdW1lIGZvciB0aGUgcm9vdCBw
b3J0LCBhbmQKIyAgIC0gYSBmdW5jdGlvbiB0cmFjZSBvZiBwY2lfYWNwaV93YWtlX2RldigpICh0
aGUgQUNQSSBQTUUtbm90aWZ5IGhhbmRsZXIpLgojIFRvZ2V0aGVyIHRoZXNlIHRlbGwgYSBmaXJt
d2FyZS1kZWxpdmVyZWQgd2FrZSAoQUNQSSBOb3RpZnkgcmFuKSBhcGFydCBmcm9tIGEKIyBkcml2
ZXItaW5pdGlhdGVkIHJlc3VtZS4gU2VlIHRyYWNlLnR4dCBhbmQgUkVBRE1FLnR4dCBpbiB0aGUg
b3V0cHV0IGZvbGRlci4KCnNldCAtRWV1byBwaXBlZmFpbAoKVkFMPSR7MTotfQppZiBbWyAiJFZB
TCIgIT0gIjAiICYmICIkVkFMIiAhPSAiMSIgXV07IHRoZW4KICAgIGVjaG8gIlVzYWdlOiBzdWRv
IGJhc2ggJDAgMHwxIgogICAgZXhpdCAyCmZpCgppZiBbWyAkKGlkIC11KSAtbmUgMCBdXTsgdGhl
bgogICAgZWNobyAiRVJST1I6IHJ1biBhcyByb290LiIKICAgIGV4aXQgMQpmaQoKUlA9MDAwMDow
MDowNC4xCk5IST0wMDAwOjZiOjAwLjYKRVA9MDAwMDowOTowMC4wCkQ9L3N5cy9idXMvcGNpL2Rl
dmljZXMKST0vc3lzL2Zpcm13YXJlL2FjcGkvaW50ZXJydXB0cwpUUkFDRV9ST09UPS9zeXMva2Vy
bmVsL3RyYWNpbmcKUlVMRT0vZXRjL3VkZXYvcnVsZXMuZC85OS1mbG93LXgxMy11c2I0LXBtLnJ1
bGVzClJVTEVfRElTQUJMRUQ9JHtSVUxFfS5kaXNhYmxlZAoKIyBUZXN0IHRpbWluZzogMyBzIGJh
c2VsaW5lLCB0aGVuIDYwIHMgYWZ0ZXIgdGhlIFBMVUcgTk9XIG1hcmtlci4KQkFTRUxJTkVfU0VD
PTMKUE9TVF9QTFVHX1NFQz02MApSRUFEWV9USU1FT1VUPTEyMAoKIyBPdXRwdXQgcGF0aHMuClNU
QU1QPSQoZGF0ZSArJVklbSVkLSVIJU0lUykKT1VUPS9yb290L2QzY29sZC1hbGxvd2VkLSR7VkFM
fS0ke1NUQU1QfQpSQVdfTE9HPSR7T1VUfS1rZXJuZWwtcmF3LmxvZwpBUkNISVZFPSR7T1VUfS50
YXIuZ3oKVFJBQ0VfSU5TVEFOQ0U9ZDNjb2xkX2FsbG93ZWRfJHtWQUx9XyQkClQ9JHtUUkFDRV9S
T09UfS9pbnN0YW5jZXMvJHtUUkFDRV9JTlNUQU5DRX0KUE9MTF9QSUQ9Cgpta2RpciAtcCAiJE9V
VCIKCmNsZWFudXAoKSB7CiAgICBzZXQgK2UKCiAgICBpZiBbWyAtbiAiJHtQT0xMX1BJRDotfSIg
XV07IHRoZW4KICAgICAgICBraWxsICIkUE9MTF9QSUQiIDI+L2Rldi9udWxsCiAgICAgICAgd2Fp
dCAiJFBPTExfUElEIiAyPi9kZXYvbnVsbAogICAgICAgIFBPTExfUElEPQogICAgZmkKCiAgICBp
ZiBbWyAtZCAiJHtUOi19IiBdXTsgdGhlbgogICAgICAgICMgVGVhciB0aGUgZXh0cmEgdjIgaW5z
dHJ1bWVudGF0aW9uIGRvd24gYmVmb3JlIHJlbW92aW5nIHRoZSBpbnN0YW5jZS4KICAgICAgICBb
WyAtdyAiJFQvZXZlbnRzL3JwbS9ycG1fcmVzdW1lL3RyaWdnZXIiIF1dIFwKICAgICAgICAgICAg
JiYgZWNobyAiIXN0YWNrdHJhY2UgaWYgbmFtZSA9PSBcIiRSUFwiIiA+ICIkVC9ldmVudHMvcnBt
L3JwbV9yZXN1bWUvdHJpZ2dlciIgMj4vZGV2L251bGwKICAgICAgICBbWyAtdyAiJFQvY3VycmVu
dF90cmFjZXIiIF1dICYmIGVjaG8gbm9wID4gIiRUL2N1cnJlbnRfdHJhY2VyIiAyPi9kZXYvbnVs
bAogICAgICAgIFtbIC13ICIkVC9zZXRfZnRyYWNlX2ZpbHRlciIgXV0gJiYgZWNobyA+ICIkVC9z
ZXRfZnRyYWNlX2ZpbHRlciIgMj4vZGV2L251bGwKICAgICAgICBbWyAtZSAiJFQvZXZlbnRzL3Jw
bS9lbmFibGUiIF1dICYmIGVjaG8gMCA+ICIkVC9ldmVudHMvcnBtL2VuYWJsZSIgMj4vZGV2L251
bGwKICAgICAgICBbWyAtZCAiJFQvZXZlbnRzL3BjaSIgXV0gJiYgZWNobyAwID4gIiRUL2V2ZW50
cy9wY2kvZW5hYmxlIiAyPi9kZXYvbnVsbAogICAgICAgIHJtZGlyICIkVCIgMj4vZGV2L251bGwg
fHwgdHJ1ZQogICAgZmkKfQp0cmFwIGNsZWFudXAgRVhJVAp0cmFwICdlY2hvOyBlY2hvICJJbnRl
cnJ1cHRlZC4iOyBleGl0IDEzMCcgSU5UIFRFUk0KCmVycigpIHsKICAgIGVjaG8gIkVSUk9SOiAk
KiIgPiYyCiAgICBleGl0IDEKfQoKbmVlZF9yZWFkYWJsZSgpIHsKICAgIFtbIC1yICIkMSIgXV0g
fHwgZXJyICJjYW5ub3QgcmVhZCAkMSIKfQoKIyBUaGVzZSBzdGF0ZSByZWFkcyBkbyBub3QgdG91
Y2ggUENJIGNvbmZpZ3VyYXRpb24gc3BhY2UuCmRldl9zdGF0ZSgpIHsKICAgIGxvY2FsIGRldj0k
MQogICAgaWYgW1sgISAtZCAiJEQvJGRldiIgXV07IHRoZW4KICAgICAgICBwcmludGYgJ2Fic2Vu
dC91bmtub3duJwogICAgICAgIHJldHVybgogICAgZmkKCiAgICBsb2NhbCBycyBwcwogICAgcnM9
JChjYXQgIiRELyRkZXYvcG93ZXIvcnVudGltZV9zdGF0dXMiIDI+L2Rldi9udWxsIHx8IHByaW50
ZiAndW5rbm93bicpCiAgICBwcz0kKGNhdCAiJEQvJGRldi9wb3dlcl9zdGF0ZSIgMj4vZGV2L251
bGwgfHwgcHJpbnRmICd1bmtub3duJykKICAgIHByaW50ZiAnJXMvJXMnICIkcnMiICIkcHMiCn0K
CmNvdW50ZXIoKSB7CiAgICBsb2NhbCBuYW1lPSQxCiAgICBpZiBbWyAtciAiJEkvJG5hbWUiIF1d
OyB0aGVuCiAgICAgICAgYXdrICd7cHJpbnQgJDF9JyAiJEkvJG5hbWUiCiAgICBlbHNlCiAgICAg
ICAgcHJpbnRmICdOQScKICAgIGZpCn0KCiMgU3VtIHBlci1DUFUgY291bnRzIGZvciB0aGUgL3By
b2MvaW50ZXJydXB0cyBsaW5lIGFzc29jaWF0ZWQgd2l0aCBhIEJERi4KIyBSZXR1cm5zIE5BIGlm
IG5vIG1hdGNoaW5nIElSUSBsaW5lIGlzIHByZXNlbnQuCmlycV90b3RhbCgpIHsKICAgIGxvY2Fs
IGJkZj0kMSBsaW5lCiAgICBsaW5lPSQoZ3JlcCAtbTEgLUYgIiRiZGYiIC9wcm9jL2ludGVycnVw
dHMgMj4vZGV2L251bGwgfHwgdHJ1ZSkKICAgIGlmIFtbIC16ICIkbGluZSIgXV07IHRoZW4KICAg
ICAgICBwcmludGYgJ05BJwogICAgICAgIHJldHVybgogICAgZmkKCiAgICBhd2sgJ3sKICAgICAg
ICBzdW09MAogICAgICAgIGZvciAoaT0yOyBpPD1ORjsgaSsrKSB7CiAgICAgICAgICAgIGlmICgk
aSB+IC9eWzAtOV0rJC8pIHN1bSArPSAkaQogICAgICAgICAgICBlbHNlIGJyZWFrCiAgICAgICAg
fQogICAgICAgIHByaW50IHN1bQogICAgfScgPDw8ICIkbGluZSIKfQoKc2FtcGxlX2xpbmUoKSB7
CiAgICBwcmludGYgJyVzIGdwZTEwPSVzIGdwZTFBPSVzIGdwZV9hbGw9JXMgc2NpPSVzIHNjaV9u
b3Q9JXMgSVJRX1JQPSVzIElSUV9OSElfQlJJREdFPSVzIFJQPSVzIE5IST0lcyBFUD0lc1xuJyBc
CiAgICAgICAgIiQoZGF0ZSArJVQuJTNOKSIgXAogICAgICAgICIkKGNvdW50ZXIgZ3BlMTApIiBc
CiAgICAgICAgIiQoY291bnRlciBncGUxQSkiIFwKICAgICAgICAiJChjb3VudGVyIGdwZV9hbGwp
IiBcCiAgICAgICAgIiQoY291bnRlciBzY2kpIiBcCiAgICAgICAgIiQoY291bnRlciBzY2lfbm90
KSIgXAogICAgICAgICIkKGlycV90b3RhbCAnMDAwMDowMDowNC4xJykiIFwKICAgICAgICAiJChp
cnFfdG90YWwgJzAwMDA6MDA6MDguMycpIiBcCiAgICAgICAgIiQoZGV2X3N0YXRlICIkUlAiKSIg
XAogICAgICAgICIkKGRldl9zdGF0ZSAiJE5ISSIpIiBcCiAgICAgICAgIiQoW1sgLWUgIiRELyRF
UCIgXV0gJiYgZWNobyBwcmVzZW50IHx8IGVjaG8gbWlzc2luZykiCn0KCnNuYXBzaG90KCkgewog
ICAgbG9jYWwgbGFiZWw9JDEKCiAgICB7CiAgICAgICAgZWNobyAiPT09ICRsYWJlbCA9PT0iCiAg
ICAgICAgZGF0ZSAtLWlzby04NjAxPW5zCiAgICAgICAgZWNobwogICAgICAgIGVjaG8gImQzY29s
ZF9hbGxvd2VkPSQoY2F0ICIkRC8kUlAvZDNjb2xkX2FsbG93ZWQiKSIKICAgICAgICBlY2hvICJS
UD0kKGRldl9zdGF0ZSAiJFJQIikiCiAgICAgICAgZWNobyAiTkhJPSQoZGV2X3N0YXRlICIkTkhJ
IikiCiAgICAgICAgZWNobyAiRVA9JChbWyAtZSAiJEQvJEVQIiBdXSAmJiBlY2hvIHByZXNlbnQg
fHwgZWNobyBtaXNzaW5nKSIKICAgICAgICBlY2hvCiAgICAgICAgZm9yIGMgaW4gZ3BlMTAgZ3Bl
MUEgZ3BlX2FsbCBzY2kgc2NpX25vdDsgZG8KICAgICAgICAgICAgcHJpbnRmICclLThzICcgIiRj
OiIKICAgICAgICAgICAgaWYgW1sgLXIgIiRJLyRjIiBdXTsgdGhlbiBjYXQgIiRJLyRjIjsgZWxz
ZSBlY2hvIE5BOyBmaQogICAgICAgIGRvbmUKICAgICAgICBlY2hvCiAgICAgICAgZWNobyAiSVJR
X1JQX3RvdGFsPSQoaXJxX3RvdGFsICcwMDAwOjAwOjA0LjEnKSIKICAgICAgICBlY2hvICJJUlFf
TkhJX2JyaWRnZV90b3RhbD0kKGlycV90b3RhbCAnMDAwMDowMDowOC4zJykiCiAgICB9ID4gIiRP
VVQvJHtsYWJlbH0udHh0IgoKICAgIGNwIC9wcm9jL2ludGVycnVwdHMgIiRPVVQvJHtsYWJlbH0t
cHJvYy1pbnRlcnJ1cHRzLnR4dCIKICAgIGdyZXAgLUggLiAiJEkiLyogMj4vZGV2L251bGwgXAog
ICAgICAgIHwgYXdrIC1GOiAnJDIrMCA+IDAgfHwgL2dwZTFBfGdwZTEwfGdwZV9hbGx8c2NpX25v
dHxcL3NjaTovJyBcCiAgICAgICAgPiAiJE9VVC8ke2xhYmVsfS1hY3BpLWNvdW50ZXJzLnR4dCIg
fHwgdHJ1ZQp9CgptYXJrKCkgewogICAgbG9jYWwgbXNnPSQqCiAgICBpZiBbWyAtdyAiJFQvdHJh
Y2VfbWFya2VyIiBdXTsgdGhlbgogICAgICAgIHByaW50ZiAnJXNcbicgIiRtc2ciID4gIiRUL3Ry
YWNlX21hcmtlciIgMj4vZGV2L251bGwgfHwgdHJ1ZQogICAgZmkKICAgIHByaW50ZiAnZDNjb2xk
LWFsbG93ZWQtdGVzdDogJXNcbicgIiRtc2ciID4gL2Rldi9rbXNnIDI+L2Rldi9udWxsIHx8IHRy
dWUKfQoKIyAtLS0gUHJlY29uZGl0aW9ucyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCltbIC1kICIkRC8kUlAiIF1dIHx8IGVyciAiJFJQ
IGRvZXMgbm90IGV4aXN0IgpbWyAtZCAiJEQvJE5ISSIgXV0gfHwgZXJyICIkTkhJIGRvZXMgbm90
IGV4aXN0IgpbWyAtZSAiJEQvJFJQL2QzY29sZF9hbGxvd2VkIiBdXSB8fCBlcnIgIiRSUCBoYXMg
bm8gZDNjb2xkX2FsbG93ZWQgYXR0cmlidXRlIgpuZWVkX3JlYWRhYmxlICIkRC8kUlAvcG93ZXIv
Y29udHJvbCIKbmVlZF9yZWFkYWJsZSAiJEQvJFJQL3Bvd2VyL3J1bnRpbWVfc3RhdHVzIgpuZWVk
X3JlYWRhYmxlICIkRC8kUlAvcG93ZXJfc3RhdGUiCm5lZWRfcmVhZGFibGUgIiRELyROSEkvcG93
ZXIvcnVudGltZV9zdGF0dXMiCm5lZWRfcmVhZGFibGUgIiRELyROSEkvcG93ZXJfc3RhdGUiCgpb
WyAkKGNhdCAiJEQvJFJQL3Bvd2VyL2NvbnRyb2wiKSA9PSBhdXRvIF1dIFwKICAgIHx8IGVyciAi
JFJQIHBvd2VyL2NvbnRyb2wgaXMgbm90IGF1dG87IGRpc2FibGUgdGhlIHVkZXYgd29ya2Fyb3Vu
ZCBhbmQgY29sZCBib290IGFnYWluIgoKW1sgISAtZSAiJEQvJEVQIiBdXSBcCiAgICB8fCBlcnIg
IiRFUCBpcyBhbHJlYWR5IHByZXNlbnQ7IGNvbGQgYm9vdCBhZ2FpbiB3aXRoIHRoZSBkb2NrIHBo
eXNpY2FsbHkgdW5wbHVnZ2VkIgoKaWYgW1sgLWUgIiRSVUxFIiBdXTsgdGhlbgogICAgZXJyICIk
UlVMRSBzdGlsbCBleGlzdHM7IHJlbmFtZSBpdCB0byAuZGlzYWJsZWQgYW5kIGNvbGQgYm9vdCBi
ZWZvcmUgdGVzdGluZyIKZmkKCmlmIFtbICEgLWUgIiRSVUxFX0RJU0FCTEVEIiBdXTsgdGhlbgog
ICAgZWNobyAiV0FSTklORzogJFJVTEVfRElTQUJMRUQgd2FzIG5vdCBmb3VuZC4iCiAgICBlY2hv
ICIgICAgICAgICBDb250aW51aW5nIGJlY2F1c2UgcG93ZXIvY29udHJvbCBpcyBhbHJlYWR5ICdh
dXRvJy4iCmZpCgpmb3IgYyBpbiBncGUxMCBncGUxQSBncGVfYWxsIHNjaSBzY2lfbm90OyBkbwog
ICAgW1sgLXIgIiRJLyRjIiBdXSB8fCBlY2hvICJXQVJOSU5HOiBBQ1BJIGNvdW50ZXIgJEkvJGMg
aXMgdW5hdmFpbGFibGU7IGl0IHdpbGwgYmUgbG9nZ2VkIGFzIE5BLiIKZG9uZQoKW1sgLWQgIiRU
UkFDRV9ST09UL2V2ZW50cyIgXV0gXAogICAgfHwgZXJyICJ0cmFjZWZzIGlzIG5vdCBhdmFpbGFi
bGUgYXQgJFRSQUNFX1JPT1Q7IGFib3J0aW5nIHJhdGhlciB0aGFuIG1vdW50aW5nL2NoYW5naW5n
IGl0IgoKIyBVc2UgYSBwcml2YXRlIHRyYWNlZnMgaW5zdGFuY2Ugc28gdGhlIHN5c3RlbS13aWRl
IHRyYWNpbmcgY29uZmlndXJhdGlvbiBpcwojIG5vdCBtb2RpZmllZCBieSB0aGlzIHNjcmlwdC4K
bWtkaXIgIiRUIiB8fCBlcnIgImNvdWxkIG5vdCBjcmVhdGUgdHJhY2VmcyBpbnN0YW5jZSAkVCIK
ZWNobyA0MDk2ID4gIiRUL2J1ZmZlcl9zaXplX2tiIiAyPi9kZXYvbnVsbCB8fCB0cnVlCgplY2hv
ICJuYW1lID09IFwiJFJQXCIgfHwgbmFtZSA9PSBcIiROSElcIiIgPiAiJFQvZXZlbnRzL3JwbS9m
aWx0ZXIiIFwKICAgIHx8IGVyciAiZmFpbGVkIHRvIGluc3RhbGwgcnVudGltZS1QTSB0cmFjZSBm
aWx0ZXIiCmVjaG8gMSA+ICIkVC9ldmVudHMvcnBtL2VuYWJsZSIgXAogICAgfHwgZXJyICJmYWls
ZWQgdG8gZW5hYmxlIHJ1bnRpbWUtUE0gdHJhY2Vwb2ludHMiCgppZiBbWyAtZCAiJFQvZXZlbnRz
L3BjaSIgXV07IHRoZW4KICAgIGVjaG8gMSA+ICIkVC9ldmVudHMvcGNpL2VuYWJsZSIgMj4vZGV2
L251bGwgfHwgdHJ1ZQpmaQoKIyAtLS0gdjI6IGNhcHR1cmUgV0hPIHJlc3VtZXMgdGhlIHJvb3Qg
cG9ydCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQojIFRoZSBBL0IgY2FwdHVyZXMg
c2hvd2VkIHRoZSBkaWZmZXJlbmNlIGlzIGEgc2luZ2xlIG1pc3NpbmcgZXZlbnQ6IGluIHRoZQoj
IEQzY29sZCAoRkFJTCkgYXJtIHRoZSByb290IHBvcnQgaXMgbmV2ZXIgcnVudGltZS1yZXN1bWVk
LCBzbyBwY2llaHAgbmV2ZXIKIyBzYW1wbGVzIHRoZSBzbG90LiBUaGVzZSB0d28gcHJvYmVzIG5h
bWUgdGhlIHJlc3VtZSBwYXRoLgojCiMgKDEpIHJwbV9yZXN1bWUgc3RhY2t0cmFjZSB0cmlnZ2Vy
IGZvciB0aGUgcm9vdCBwb3J0LiBOb3RlIHJwbV9yZXN1bWUgb2Z0ZW4KIyAgICAgcnVucyBmcm9t
IGEga3dvcmtlciAocG1fcnVudGltZSBhc3luYyB3b3JrKSwgc28gdGhpcyBzdGFjayBtYXkgb25s
eSBzaG93CiMgICAgIHRoZSB3b3JrZXIgcmF0aGVyIHRoYW4gdGhlIG9yaWdpbmFsIHJlcXVlc3Rl
ciAtLSBwcm9iZSAoMikgZGlzYW1iaWd1YXRlcy4KaWYgW1sgLXcgIiRUL2V2ZW50cy9ycG0vcnBt
X3Jlc3VtZS90cmlnZ2VyIiBdXTsgdGhlbgogICAgZWNobyAic3RhY2t0cmFjZSBpZiBuYW1lID09
IFwiJFJQXCIiID4gIiRUL2V2ZW50cy9ycG0vcnBtX3Jlc3VtZS90cmlnZ2VyIiAyPi9kZXYvbnVs
bCBcCiAgICAgICAgfHwgZWNobyAiV0FSTklORzogY291bGQgbm90IGluc3RhbGwgcnBtX3Jlc3Vt
ZSBzdGFja3RyYWNlIHRyaWdnZXIiID4mMgpmaQoKIyAoMikgRnVuY3Rpb24tdHJhY2UgdGhlIEFD
UEkgUE1FLW5vdGlmeSBoYW5kbGVyIHBjaV9hY3BpX3dha2VfZGV2KCkuIElmIGl0CiMgICAgIGZp
cmVzIGFmdGVyIHRoZSBwbHVnLCBmaXJtd2FyZSBkZWxpdmVyZWQgYW4gQUNQSSBOb3RpZnkgKHdh
a2UgYXR0ZW1wdCk7CiMgICAgIGlmIGl0IG5ldmVyIGZpcmVzLCBmaXJtd2FyZSBuZXZlciBhc2tl
ZCB0aGUgT1MgdG8gd2FrZSB0aGUgcG9ydC4gVGhlCiMgICAgIGZpbHRlciByZXN0cmljdHMgZnVu
Y3Rpb24gdHJhY2luZyB0byB0aGlzIG9uZSBzeW1ib2wsIHNvIHRoZSBidWZmZXIgaXMKIyAgICAg
bm90IGZsb29kZWQuIFRoZSBmdW5jdGlvbiB0cmFjZXIgY2Fubm90IHNob3cgd2hpY2ggcGNpX2Rl
diB3YXMgcGFzc2VkOwojICAgICBjb3JyZWxhdGUgaXRzIHRpbWVzdGFtcCB3aXRoIHRoZSBkZXZp
Y2UtZmlsdGVyZWQgcnBtX3Jlc3VtZSBsaW5lcy4KaWYgW1sgLXcgIiRUL3NldF9mdHJhY2VfZmls
dGVyIiAmJiAtdyAiJFQvY3VycmVudF90cmFjZXIiIF1dOyB0aGVuCiAgICBpZiBlY2hvIHBjaV9h
Y3BpX3dha2VfZGV2ID4gIiRUL3NldF9mdHJhY2VfZmlsdGVyIiAyPi9kZXYvbnVsbDsgdGhlbgog
ICAgICAgIGVjaG8gZnVuY3Rpb24gPiAiJFQvY3VycmVudF90cmFjZXIiIDI+L2Rldi9udWxsIFwK
ICAgICAgICAgICAgfHwgZWNobyAiV0FSTklORzogY291bGQgbm90IGVuYWJsZSBmdW5jdGlvbiB0
cmFjZXIiID4mMgogICAgZWxzZQogICAgICAgIGVjaG8gIk5PVEU6IHBjaV9hY3BpX3dha2VfZGV2
IG5vdCB0cmFjZWFibGUgb24gdGhpcyBrZXJuZWw7IHByb2JlICgyKSBza2lwcGVkLiIgPiYyCiAg
ICBmaQpmaQoKU0lOQ0VfRVBPQ0g9JChkYXRlICslcykKCnsKICAgIGVjaG8gImtlcm5lbDogJCh1
bmFtZSAtcikiCiAgICBlY2hvICJ0ZXN0OiBkM2NvbGRfYWxsb3dlZD0kVkFMIgogICAgZWNobyAi
UlA6ICRSUCIKICAgIGVjaG8gIk5ISTogJE5ISSIKICAgIGVjaG8gIkVQOiAkRVAiCiAgICBlY2hv
ICJwb3dlci9jb250cm9sOiAkKGNhdCAiJEQvJFJQL3Bvd2VyL2NvbnRyb2wiKSIKICAgIGVjaG8g
InBvd2VyL3dha2V1cDogJChjYXQgIiRELyRSUC9wb3dlci93YWtldXAiIDI+L2Rldi9udWxsIHx8
IGVjaG8gdW5hdmFpbGFibGUpIgogICAgZWNobyAiZDNjb2xkX2FsbG93ZWQgYmVmb3JlIHdyaXRl
OiAkKGNhdCAiJEQvJFJQL2QzY29sZF9hbGxvd2VkIikiCiAgICBlY2hvICJzdGF0ZSBiZWZvcmUg
d3JpdGU6IFJQPSQoZGV2X3N0YXRlICIkUlAiKSBOSEk9JChkZXZfc3RhdGUgIiROSEkiKSIKICAg
IGVjaG8gIm5vdGU6IHdyaXRpbmcgZDNjb2xkX2FsbG93ZWQgcnVudGltZS1yZXN1bWVzIHRoZSBy
b290IHBvcnQ7IHJlYWRpbmVzcyBpcyBjaGVja2VkIG9ubHkgYWZ0ZXIgaXQgc3VzcGVuZHMgYWdh
aW4iCn0gPiAiJE9VVC9pbmZvLnR4dCIKCmNwIC0tICIkMCIgIiRPVVQvJChiYXNlbmFtZSAiJDAi
KSIgMj4vZGV2L251bGwgfHwgdHJ1ZQoKIyAtLS0gQXBwbHkgQWxleCdzIHRlc3QgY29uZGl0aW9u
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKbWFyayAiV1JJVElO
RyBkM2NvbGRfYWxsb3dlZD0kVkFMIgplY2hvICIkVkFMIiA+ICIkRC8kUlAvZDNjb2xkX2FsbG93
ZWQiIFwKICAgIHx8IGVyciAid3JpdGUgdG8gJEQvJFJQL2QzY29sZF9hbGxvd2VkIGZhaWxlZCIK
ClJFQURCQUNLPSQoY2F0ICIkRC8kUlAvZDNjb2xkX2FsbG93ZWQiKQpbWyAiJFJFQURCQUNLIiA9
PSAiJFZBTCIgXV0gXAogICAgfHwgZXJyICJkM2NvbGRfYWxsb3dlZCByZWFkYmFjayBpcyAkUkVB
REJBQ0ssIGV4cGVjdGVkICRWQUwiCgplY2hvICJkM2NvbGRfYWxsb3dlZCBhZnRlciB3cml0ZTog
JFJFQURCQUNLIiA+PiAiJE9VVC9pbmZvLnR4dCIKCmVjaG8KaWYgW1sgIiRWQUwiID09IDEgXV07
IHRoZW4KICAgIGVjaG8gIldhaXRpbmcgZm9yIHN0cmljdCBGQUlMIHByZWNvbmRpdGlvbjoiCiAg
ICBlY2hvICIgIFJQICA9IHN1c3BlbmRlZC9EM2NvbGQiCiAgICBlY2hvICIgIE5ISSA9IHN1c3Bl
bmRlZC9EM2NvbGQiCmVsc2UKICAgIGVjaG8gIldhaXRpbmcgZm9yIFBBU1MgcHJlY29uZGl0aW9u
OiIKICAgIGVjaG8gIiAgUlAgID0gc3VzcGVuZGVkIGFuZCBOT1QgRDNjb2xkIChub3JtYWxseSBE
M2hvdCkiCiAgICBlY2hvICIgIE5ISSA9IHN1c3BlbmRlZC9EM2NvbGQiCmZpCmVjaG8gIlRpbWVv
dXQ6ICR7UkVBRFlfVElNRU9VVH1zIgoKUkVBRFk9MApSRUFEWV9SUF9TVEFURT0KZm9yICgoc2Vj
PTE7IHNlYzw9UkVBRFlfVElNRU9VVDsgc2VjKyspKTsgZG8KICAgIFJQX1JTPSQoY2F0ICIkRC8k
UlAvcG93ZXIvcnVudGltZV9zdGF0dXMiKQogICAgUlBfUFM9JChjYXQgIiRELyRSUC9wb3dlcl9z
dGF0ZSIpCiAgICBOSElfUlM9JChjYXQgIiRELyROSEkvcG93ZXIvcnVudGltZV9zdGF0dXMiKQog
ICAgTkhJX1BTPSQoY2F0ICIkRC8kTkhJL3Bvd2VyX3N0YXRlIikKCiAgICBpZiBbWyAiJFZBTCIg
PT0gMSBdXTsgdGhlbgogICAgICAgIGlmIFtbICIkUlBfUlMiID09IHN1c3BlbmRlZCAmJiAiJFJQ
X1BTIiA9PSBEM2NvbGQgXAogICAgICAgICAgICYmICIkTkhJX1JTIiA9PSBzdXNwZW5kZWQgJiYg
IiROSElfUFMiID09IEQzY29sZCBdXTsgdGhlbgogICAgICAgICAgICBSRUFEWT0xCiAgICAgICAg
ICAgIFJFQURZX1JQX1NUQVRFPSRSUF9QUwogICAgICAgICAgICBicmVhawogICAgICAgIGZpCiAg
ICBlbHNlCiAgICAgICAgIyBkM2NvbGRfYWxsb3dlZD0wIGxpbWl0cyB0aGUgZGVlcGVzdCBhbGxv
d2VkIHN0YXRlIHRvIEQzaG90LCBidXQgQUNQSQogICAgICAgICMgbWF5IGNob29zZSBhIHNoYWxs
b3dlciBzdGF0ZS4gIEFjY2VwdCBhbnkgc3RhYmxlIHN1c3BlbmRlZCBzdGF0ZSB0aGF0CiAgICAg
ICAgIyBpcyBub3QgRDNjb2xkOyByZWNvcmQgZXhhY3RseSB3aGljaCBvbmUgd2FzIHNlbGVjdGVk
LgogICAgICAgIGlmIFtbICIkUlBfUlMiID09IHN1c3BlbmRlZCAmJiAiJFJQX1BTIiAhPSBEM2Nv
bGQgXAogICAgICAgICAgICYmICIkUlBfUFMiICE9IHVua25vd24gJiYgIiRSUF9QUyIgIT0gZXJy
b3IgXAogICAgICAgICAgICYmICIkTkhJX1JTIiA9PSBzdXNwZW5kZWQgJiYgIiROSElfUFMiID09
IEQzY29sZCBdXTsgdGhlbgogICAgICAgICAgICBSRUFEWT0xCiAgICAgICAgICAgIFJFQURZX1JQ
X1NUQVRFPSRSUF9QUwogICAgICAgICAgICBicmVhawogICAgICAgIGZpCiAgICBmaQoKICAgIGlm
ICgoIHNlYyAlIDEwID09IDAgKSk7IHRoZW4KICAgICAgICBwcmludGYgJyAgJTNkczogUlA9JXMg
TkhJPSVzXG4nICIkc2VjIiAiJChkZXZfc3RhdGUgIiRSUCIpIiAiJChkZXZfc3RhdGUgIiROSEki
KSIKICAgIGZpCiAgICBzbGVlcCAxCmRvbmUKCmlmIFtbICIkUkVBRFkiICE9IDEgXV07IHRoZW4K
ICAgIHsKICAgICAgICBlY2hvICJyZWFkeTogbm8iCiAgICAgICAgZWNobyAiZmluYWwgd2FpdGlu
ZyBzdGF0ZTogUlA9JChkZXZfc3RhdGUgIiRSUCIpIE5IST0kKGRldl9zdGF0ZSAiJE5ISSIpIgog
ICAgfSA+PiAiJE9VVC9pbmZvLnR4dCIKICAgIGVyciAicHJlY29uZGl0aW9uIG5vdCByZWFjaGVk
IGFmdGVyICR7UkVBRFlfVElNRU9VVH1zOiBSUD0kKGRldl9zdGF0ZSAiJFJQIikgTkhJPSQoZGV2
X3N0YXRlICIkTkhJIikiCmZpCgppZiBbWyAiJFZBTCIgPT0gMCAmJiAiJFJFQURZX1JQX1NUQVRF
IiAhPSBEM2hvdCBdXTsgdGhlbgogICAgZWNobyAiTk9URTogd2l0aCBEM2NvbGQgYmxvY2tlZCwg
UlAgc3VzcGVuZGVkIHRvICRSRUFEWV9SUF9TVEFURSByYXRoZXIgdGhhbiBEM2hvdC4iCiAgICBl
Y2hvICIgICAgICBUaGlzIHN0aWxsIHRlc3RzIEFsZXgncyBkM2NvbGRfYWxsb3dlZD0wIGNvbmRp
dGlvbjsgdGhlIGV4YWN0IHN0YXRlIGlzIHJlY29yZGVkLiIKZmkKClJFQURZX0xJTkU9InJlYWR5
OiBSUD0kKGRldl9zdGF0ZSAiJFJQIikgTkhJPSQoZGV2X3N0YXRlICIkTkhJIikgZDNjb2xkX2Fs
bG93ZWQ9JFJFQURCQUNLIgplY2hvICIkUkVBRFlfTElORSIgfCB0ZWUgLWEgIiRPVVQvaW5mby50
eHQiCm1hcmsgIiRSRUFEWV9MSU5FIgpzbmFwc2hvdCBiZWZvcmUKCiMgLS0tIE9ic2VydmUgbmF0
dXJhbCBob3QtcGx1ZyBvbmx5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KCldBVENIPSIkT1VUL3dhdGNoLmxvZyIKOiA+ICIkV0FUQ0giCgpwb2xsX2xvb3AoKSB7CiAg
ICB3aGlsZSA6OyBkbwogICAgICAgIHNhbXBsZV9saW5lID4+ICIkV0FUQ0giCiAgICAgICAgc2xl
ZXAgMC4yCiAgICBkb25lCn0KCnBvbGxfbG9vcCAmClBPTExfUElEPSQhCgojIFJlY29yZCBhIHNo
b3J0IGJhc2VsaW5lIGJlZm9yZSBhc2tpbmcgZm9yIHRoZSBwaHlzaWNhbCBhY3Rpb24uCnNsZWVw
ICIkQkFTRUxJTkVfU0VDIgptYXJrICJQTFVHIERPQ0sgTk9XIgplY2hvCmVjaG8gIj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Igpl
Y2hvICI+Pj4gUExVRyBJTiBUSEUgU0Q1MDAwVDUgTk9XLiBEbyBub3QgcnVuIGxzcGNpLiA8PDwi
CmVjaG8gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09IgplY2hvICJTYW1wbGluZyB3aWxsIGNvbnRpbnVlIGZvciAke1BPU1RfUExV
R19TRUN9cy4gTm8gRW50ZXIgcHJlc3MgaXMgbmVlZGVkLiIKZWNobwoKc2xlZXAgIiRQT1NUX1BM
VUdfU0VDIgoKa2lsbCAiJFBPTExfUElEIiAyPi9kZXYvbnVsbCB8fCB0cnVlCndhaXQgIiRQT0xM
X1BJRCIgMj4vZGV2L251bGwgfHwgdHJ1ZQpQT0xMX1BJRD0KCnNuYXBzaG90IGFmdGVyCgppZiBb
WyAtZSAiJEQvJEVQIiBdXTsgdGhlbgogICAgUkVTVUxUPSJQQVNTOiAkRVAgZW51bWVyYXRlZCBu
YXR1cmFsbHkgd2l0aCBkM2NvbGRfYWxsb3dlZD0kVkFMIgplbHNlCiAgICBSRVNVTFQ9IkZBSUw6
ICRFUCBkaWQgbm90IGVudW1lcmF0ZSB3aXRoIGQzY29sZF9hbGxvd2VkPSRWQUwiCmZpCgptYXJr
ICJSRVNVTFQ6ICRSRVNVTFQiCmVjaG8gInJlc3VsdDogJFJFU1VMVCIgPj4gIiRPVVQvaW5mby50
eHQiCmVjaG8gImZpbmFsIHN0YXRlOiBSUD0kKGRldl9zdGF0ZSAiJFJQIikgTkhJPSQoZGV2X3N0
YXRlICIkTkhJIikiID4+ICIkT1VUL2luZm8udHh0IgplY2hvICJmaW5hbCBjb3VudGVyczogZ3Bl
MTA9JChjb3VudGVyIGdwZTEwKSBncGUxQT0kKGNvdW50ZXIgZ3BlMUEpIGdwZV9hbGw9JChjb3Vu
dGVyIGdwZV9hbGwpIHNjaT0kKGNvdW50ZXIgc2NpKSBzY2lfbm90PSQoY291bnRlciBzY2lfbm90
KSIgPj4gIiRPVVQvaW5mby50eHQiCmVjaG8gImZpbmFsIElSUSB0b3RhbHM6IFJQPSQoaXJxX3Rv
dGFsICcwMDAwOjAwOjA0LjEnKSBOSElfYnJpZGdlPSQoaXJxX3RvdGFsICcwMDAwOjAwOjA4LjMn
KSIgPj4gIiRPVVQvaW5mby50eHQiCgojIENhcHR1cmUgdGhlIGlzb2xhdGVkIHRyYWNlIGJlZm9y
ZSByZW1vdmluZyB0aGUgdHJhY2UgaW5zdGFuY2UuCmNhdCAiJFQvdHJhY2UiID4gIiRPVVQvdHJh
Y2UudHh0IiAyPi9kZXYvbnVsbCB8fCB0cnVlCgojIFN0b3AvcmVtb3ZlIHRoZSBwcml2YXRlIHRy
YWNlIGluc3RhbmNlIG5vdzsgbm8gZ2xvYmFsIGZ0cmFjZSBzZXR0aW5ncyB3ZXJlIGNoYW5nZWQu
CmNsZWFudXAKdHJhcCAtIEVYSVQgSU5UIFRFUk0KCiMgLS0tIEtlcm5lbCBsb2cgYW5kIHByaXZh
Y3kgZmlsdGVyaW5nIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCmpvdXJu
YWxjdGwgLWsgLS1zaW5jZSAiQCR7U0lOQ0VfRVBPQ0h9IiAtbyBzaG9ydC1tb25vdG9uaWMgPiAi
JFJBV19MT0ciCgojIFRoZSByYXcgbG9nIGludGVudGlvbmFsbHkgcmVtYWlucyBPVVRTSURFIHRo
ZSBhcmNoaXZlLgojIFJlZGFjdCBjb21tb24gaWRlbnRpZnlpbmcgZmllbGRzIGZyb20gdGhlIGNv
cHkgdGhhdCBnb2VzIGludG8gdGhlIGFyY2hpdmUuCkhPU1Q9JCh1bmFtZSAtbikKc2VkIC1FIFwK
ICAgIC1lICJzLyAke0hPU1R9IC8gSE9TVCAvZyIgXAogICAgLWUgJ3MvKFNlcmlhbE51bWJlcjpb
WzpzcGFjZTpdXSopW15bOnNwYWNlOl1dKy9cMVJFREFDVEVEL2cnIFwKICAgIC1lICdzLyhzZXJp
YWwoW1s6c3BhY2U6XV8tXSpudW1iZXIpP1tbOnNwYWNlOl1dKls6PV1bWzpzcGFjZTpdXSopW15b
OnNwYWNlOl1dKy9cMVJFREFDVEVEL0lnJyBcCiAgICAtZSAncy8odWlkOltbOnNwYWNlOl1dKikw
eFswLTlhLWZBLUZdKy9cMVJFREFDVEVELVRIVU5ERVJCT0xULVVJRC9nJyBcCiAgICAtZSAncy8o
WzAtOWEtZkEtRl17Mn1bOi1dKXs1fVswLTlhLWZBLUZdezJ9L1JFREFDVEVELU1BQy9nJyBcCiAg
ICAtZSAncy8oWzAtOWEtZkEtRl17Mn0tKXs3fVswLTlhLWZBLUZdezJ9L1JFREFDVEVELURFVklD
RS1TRVJJQUwvZycgXAogICAgLWUgJ3MvWzAtOWEtZkEtRl17OH0tWzAtOWEtZkEtRl17NH0tWzAt
OWEtZkEtRl17NH0tWzAtOWEtZkEtRl17NH0tWzAtOWEtZkEtRl17MTJ9L1JFREFDVEVELVVVSUQv
ZycgXAogICAgIiRSQVdfTE9HIiA+ICIkT1VUL2tlcm5lbC5sb2ciCgpjYXQgPiAiJE9VVC9SRUFE
TUUudHh0IiA8PEVPRjIKQWxleCBkM2NvbGRfYWxsb3dlZCBBL0IgY2FwdHVyZQoKVGVzdCB2YWx1
ZTogZDNjb2xkX2FsbG93ZWQ9JFZBTApSZXN1bHQ6ICRSRVNVTFQKClRoaXMgYXJjaGl2ZSBjb250
YWlucyBvbmx5IHRoZSByZWRhY3RlZCBrZXJuZWwubG9nLiAgVGhlIHVucmVkYWN0ZWQga2VybmVs
CmxvZyB3YXMgaW50ZW50aW9uYWxseSBsZWZ0IG91dHNpZGUgdGhlIGFyY2hpdmUgYXQ6CiAgJFJB
V19MT0cKCk5vIGxzcGNpLCBQQ0kgY29uZmlnLXNwYWNlIHJlYWQsIHJlc2Nhbiwgb3IgcmVjb3Zl
cnkgc3RlcCB3YXMgcGVyZm9ybWVkIGJ5CnRoaXMgc2NyaXB0LiAgVGhlIHdhdGNoIGxvZyBzYW1w
bGVkIEFDUEkgY291bnRlcnMsIHJ1bnRpbWUtUE0gc3RhdGUsIGVuZHBvaW50CnByZXNlbmNlLCBh
bmQgSVJRIHRvdGFscyBldmVyeSAwLjIgcy4KCnRyYWNlLnR4dCAodjIpIGFkZGl0aW9uYWxseSBj
YXB0dXJlcyB0aGUgcm9vdC1wb3J0IHJlc3VtZSBwYXRoOgogICogcnBtX3Jlc3VtZSBsaW5lcyBm
b3IgJFJQIG5vdyBjYXJyeSBhIDxzdGFjayB0cmFjZT4gYmxvY2suIExvb2sgZm9yIHRoZQogICAg
Zmlyc3QgcnBtX3Jlc3VtZTogJFJQIEFGVEVSIHRoZSAiUExVRyBET0NLIE5PVyIgbWFya2VyLiBJ
dHMgYWJzZW5jZSBpbiB0aGUKICAgIEQzY29sZCBhcm0gaXMgdGhlIGZhaWx1cmU7IGl0cyBzdGFj
ayBpbiB0aGUgcGFzc2luZyBhcm0gbmFtZXMgdGhlIHJlc3VtZXIKICAgIChtYXkgYmUgYSBrd29y
a2VyIC0tIHBtX3J1bnRpbWUgYXN5bmMgd29yayAtLSBzZWUgbmV4dCBpdGVtKS4KICAqIHBjaV9h
Y3BpX3dha2VfZGV2IGxpbmVzIG1lYW4gdGhlIEFDUEkgUE1FLW5vdGlmeSBoYW5kbGVyIHJhbiAo
ZmlybXdhcmUKICAgIGRlbGl2ZXJlZCBhIHdha2UpLiBJZiB0aGVzZSBhcHBlYXIgYWZ0ZXIgdGhl
IHBsdWcsIGZpcm13YXJlIGFza2VkIHRoZSBPUyB0bwogICAgd2FrZSBhIHBvcnQ7IGlmIHRoZXkg
bmV2ZXIgYXBwZWFyLCBmaXJtd2FyZSBuZXZlciBkaWQuIENvcnJlbGF0ZSB0aGVpcgogICAgdGlt
ZXN0YW1wcyB3aXRoIHRoZSBycG1fcmVzdW1lOiAkUlAgbGluZXMgdG8gdGVsbCB3aGV0aGVyIHRo
ZSB3YWtlIHRhcmdldGVkCiAgICB0aGUgcm9vdCBwb3J0LiAoVGhlIGZ1bmN0aW9uIHRyYWNlciBj
YW5ub3QgcHJpbnQgdGhlIHBjaV9kZXYgYXJndW1lbnQuKQpFT0YyCgp0YXIgLUMgL3Jvb3QgLWN6
ZiAiJEFSQ0hJVkUiICIkKGJhc2VuYW1lICIkT1VUIikiClNIQTI1Nj0kKHNoYTI1NnN1bSAiJEFS
Q0hJVkUiIHwgYXdrICd7cHJpbnQgJDF9JykKCnByaW50ZiAnXG4lc1xuJyAiJFJFU1VMVCIKcHJp
bnRmICdSUCBmaW5hbDogICVzXG4nICIkKGRldl9zdGF0ZSAiJFJQIikiCnByaW50ZiAnTkhJIGZp
bmFsOiAlc1xuJyAiJChkZXZfc3RhdGUgIiROSEkiKSIKcHJpbnRmICdcbkFyY2hpdmU6ICVzXG5T
SEEyNTY6ICAlc1xuJyAiJEFSQ0hJVkUiICIkU0hBMjU2IgpwcmludGYgJ1JhdyBrZXJuZWwgbG9n
IChOT1QgaW4gYXJjaGl2ZSk6ICVzXG4nICIkUkFXX0xPRyIKcHJpbnRmICdcbkJlZm9yZSBzZW5k
aW5nIHRoZSBhcmNoaXZlIHB1YmxpY2x5LCByZXZpZXcvcmVkYWN0aW9uLXNjYW4gaXQgb25jZSBt
b3JlLlxuJwpwcmludGYgJ1xuRm9yIG5vcm1hbCB1c2UsIHJlc3RvcmUgdGhlIHdvcmthcm91bmQg
YW5kIHJlYm9vdDpcbicKcHJpbnRmICcgIHN1ZG8gbXYgJXMgJXNcbicgIiRSVUxFX0RJU0FCTEVE
IiAiJFJVTEUiCnByaW50ZiAnICBzdWRvIHJlYm9vdFxuJwoAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAA=

--_002_DS7PR12MB95500DA47DA5616DA06DF67D9C922DS7PR12MB9550namp_--
