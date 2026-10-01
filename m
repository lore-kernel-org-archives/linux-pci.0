Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FC52CCC7;
	Thu,  1 Oct 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866486; cv=fail; b=absH05NkLwjURWghRrEOAtC/bV8AEYzDNS0KY5EATJUDIDWJ1pcSQGCLVOpA0MvDzprYCCh1KyhBDhD6k54epJmHQqUMKuU3y1DFB01TPV/Ox04W1pw2uSP64X0t3OEUUhPhcnLzpKYEDpJdoc1GQz5z9IP9cLH9n3Tq11Mb0Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866486; c=relaxed/simple;
	bh=Uii998KsA+cpW6Ds6Qp/RdzEJ1nPfH/nxrduhbHrCRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXNd+vLkdmVTSR50fA5ZKoQaGF9EE4PKdn+UjJ+RMZq5yTB82eOdwZu3rVz4j+FMgfkBc5BaMLjMgd/iydm2kQOu28S/sPqjf2vCV+jU365MiUCz+G88cC2EtN18FCZmNypnZ/EcKXQ8Y+yN+seLV9Fy6peL1UYoqOqaNdSTQdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qxZwWblv; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qxZwWblv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncPP/t+5wmpYppl237UwuLD5DgrXYkhF0d/44ER+cEAbAEdnc2B/x+1QUzXc2Le65p3Zz5vFvXDO+Q7kuVXZM2bTUoYzwfFg4WihAhcYaoZIFg9mz7kyFiT9DeYWzxReWB0SaKqcb3Za3rPgJqOQRJPjKikd/x9c0ZuyuX94vKZH1HwDLkwuip2uawozyDNoqqPxQbfK7MuniWeXCFInmJZq4KjGxX+HrXk1lz5Q4HnemHYxg2kx7f4uPINwylmnTMbp6UjBeJZt0TgFdI46mcQT+2LYRtF4T0wDtBr+TTW01aJj3hD6hQ/EDGEtVii/MZVPvfnP3HiYGbcoRBrkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0yQ7mddyuxYU+07slysK0h3EnBlA7n2GSvJBQpIvYs=;
 b=yCXsqCgSk9bN/8EIAMuoA8Er3DSEwElNh/IhJ2GaZiIgrrI12Q3MG5EHkuLmRvuAZGapavTtehtqXZXBY4Cewhlkahb5ElnLf6pUQHL/fHGx/pSdA6shznjxzxOixdzBU9Y303ii8LtEeGy7bYOY6YyTGn18JsboN5jR2FSa4oxUUXcbY7fB4cet05XBNpJ5mb3sWUe6cqfnysz9GRT+z06msbPqlVRCbdVfpttYXByd2zWG5t1MG8PuOZuzJTRgmEihAD0NSP/xlEH7Gvro2Tw3skmbkL3Z4Q1A2XjbqWpRpxCRY0oOdmlTIjJ+Qfq/09Gh7FbF0XIV+mbOCnQE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0yQ7mddyuxYU+07slysK0h3EnBlA7n2GSvJBQpIvYs=;
 b=qxZwWblvkw3kdfBQdat2uCgr8wTf+65ZzLeKO+7BtCr3ugCeNyidZlbFKhpDW1fUxX2ppaqkVL48Ktct5ajLn9Co7Dub0MfZST1s7wty7VLBESwDEr1mViwBJ+9U+s2gpaDia9vI7copkavaXp+iw4kEwGmMihX+ZChq1Z3BUrw=
Received: from DS7PR12MB9550.namprd12.prod.outlook.com (2603:10b6:8:24e::16)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 14:54:35 +0000
Received: from DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5]) by DS7PR12MB9550.namprd12.prod.outlook.com
 ([fe80::e465:1aca:4c9a:6fb5%2]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 14:54:35 +0000
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
 AQHdSd1c593zF2yuc0efXEtk9KFFoLbazowAgAA18BCAAAG7AIABCdYAgACB41CAAMQiAIABc02AgABGIACAAB+1gIAABT6AgAAnFgCAABFJAIAAA0aAgAAG3ACACVy6oA==
Date: Thu, 1 Oct 2026 14:54:35 +0000
Message-ID:
 <DS7PR12MB9550D1A8CB397E8C7FF0C7D69C8A2@DS7PR12MB9550.namprd12.prod.outlook.com>
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
In-Reply-To:
 <TYCPR01MB109279CDE9AAF47B40FD1770996802@TYCPR01MB10927.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: DS7PR12MB9550:EE_|DS0PR12MB7777:EE_
x-ms-office365-filtering-correlation-id: 3dc24a3c-6a99-4ec8-e8c3-08df1fcbe8ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|23010399003|1800799024|376014|260925021911599003|260925021311599003|260925022911599003|10067099003|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 54kCV1R2m9oWw3Lf52mqSrLpdbSqKiOeC9x+HtiZ3PnvB9hPp2n/0QmpGMUMs0ffC8KHmBkDScCUpRadPYS3u0lyEgzpTBB4jHSPTn4PIqJ07jORKbGw8EevPiy49wq6eMWqR9Fr4tRItimjXV9h3VpViOp1ZpY60Pq7183YHb/U+1asH3g82GjuSt0e4En4QblCSvXcxdo6KzCUl7buE+xtjDcHuSbHbnvBGAbppjJgVNBJIopo37zjXBn5C6G24wI7n5jJJArv9lPydco9qQJ3jpakAfAyq43MT3M5NMeIaTWr/9JSoQN6Is/xfJ3mEP/IcaiCpJ6ARd8Gf8kdxChTPbBaUHSxVtT+rGu0+UCF8B5fiwrz2FPE31cC7aLkugKiAcqw5BxL0bZx8/hidAKNkntSEwVyNmcNiLa/2/4KlWvbMeYjaaA6fzG/jKNbNqe/8HxrlhHUzlJovpX4LoD1Jw6E+ULcc5nMcWjIck2wIXhcnx8uO2DlLJt7tzppAmJT9nbIfliI95Mnr4Ef2D/ebZgeZiYlm09QH/SHPGSFk1nzCyVgfbp41ZEG7k6qWD/4TpYWfKj+RICMwbF//bCY3Hq/HAX0k9qUn5DjMwIv3raJfn7BZ8jVNgvK4NM4B2sQOWmqNMhL/0C9gJQpIawPN4WUk5PNxBMTVeL2grrN0SJ7Agdzj4VSqpsl/7tXZNBAANvMv/8XtIJaKOcZBV2n5ZSOtlKhxK8kWzAG6Ww=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9550.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(1800799024)(376014)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eS4EFm26sdMAIw15kacbujeLT1Llmi9wOUAkV8ifLLklR9DSvjJStQgvsq?=
 =?iso-8859-1?Q?niv5ClHXF1Z8FEqPTxOv10peWaUcpBg7PMFqpHRt4mwbWFVOFug/t92PS3?=
 =?iso-8859-1?Q?eVdS8rhq3bHuM+e3yN9uecxi/dwq7JG6jkd1of+NbjEGa5JSpcu66A9EH9?=
 =?iso-8859-1?Q?B2eyv1AHfr1VM7cu4JslBAME83Qoaye/9OBHfvf5afNFH6+3eTUFgcqP3M?=
 =?iso-8859-1?Q?M7m9VtwqVtWJoeuqUc4zhuInCUNgTJXXGKhKd6aB2OgAM3JQtGhMUG417Z?=
 =?iso-8859-1?Q?P2yoNnBsntXma1rT7kI1+5+prmn+noE72a2EruIHP9D5aGH/WCkGGox6WI?=
 =?iso-8859-1?Q?uJEG0sRz/ft9Y1dWSq1x6C22ubij9sRl5GwcD1G8OgFFaYYwFQefiPDm/S?=
 =?iso-8859-1?Q?OD30i7c8kjk+eL2I+wCWGBH3H/EnnzeNbWg5CwvWDDk+t2py++D86jrFo3?=
 =?iso-8859-1?Q?K6x8YMFPPvM0iuz5neBE6r198r+ZlzMjW17WoAeh0J3DpJW/3NpchoV6yw?=
 =?iso-8859-1?Q?xkwoUP48Z4D19pDtcZ5d6S6c8HbErDyoyoY5CriDJFnMoU/qoTq/moJ8uP?=
 =?iso-8859-1?Q?btLndQ2wwP2HWaU+o/AUgZjtsMjV7XynalfnYv19MlMnzTf5RsWV+g5W4X?=
 =?iso-8859-1?Q?zFOtRzxPSlxEY0aIFEOqVnwh9P3AfoEBDD7mQpJJm0QDD+maMANAkA6DRD?=
 =?iso-8859-1?Q?YfJe1NKRK7sYeu2iXm81LKi6YE9WqqI9m6+OiKAjM4RtOPaXz47QqtvFdy?=
 =?iso-8859-1?Q?PGeBY2HR2FgJfnuJbSQjYNBaYs1lf4G0/ag3mrDA+4YFigVEAX7ji+FT6Z?=
 =?iso-8859-1?Q?OQ9Cl0YQ2RUB6QJehyd8SEUEOxoOx7SfbUz4GBCAbOimxCOu1iCUvkD+cV?=
 =?iso-8859-1?Q?wBFEA2UbpubBAOLqKu15CgeVbUcx+xvD0YV9bjeN5llEscEYnIv6E6LGwU?=
 =?iso-8859-1?Q?F3WyT73jyq+Wgzaw5uoBcM8NHzf14hXGmFETJU+cXEthOMthp9toIsM/Lj?=
 =?iso-8859-1?Q?BRknlzA2+/fM84Y2pspALODpuodwjg5Lx/LgUnp0qyhPGDDoV1RhPoQ9k1?=
 =?iso-8859-1?Q?mH68LX15FYw/NWnNIa2v0BsL14fvP0Qmm0V0CGQK16oprxdkhWAorJIcPy?=
 =?iso-8859-1?Q?qJZsUHR00AZ4an68uliypV3YAP0QX2y4TE9Vo3BjJ1bFjvQ8gLwx3DR+Zu?=
 =?iso-8859-1?Q?dHuIs9rk/nW57z+alh1CFXHT4/xbP8T2l5+GkhMDsPY9dBtQwqv37xIJRu?=
 =?iso-8859-1?Q?c4z+/mo9OVMEmaovPtpOS1WGjKjRmnn8MOZXrsCted7Q4QvM4IC2hJ4I8K?=
 =?iso-8859-1?Q?pd8VqGKnBsGCIJujGr+rHiOks9o6Nq4IOreX5ypQx+3U2hiqcirmeEabWK?=
 =?iso-8859-1?Q?6DtWNFEyWhVZM6v15S6ML+1mQId/wZXBhTJnjEWvP5QnjiKzlyX548Ha57?=
 =?iso-8859-1?Q?v+KGCenNfkdiI8/sJHg2Ek/DNCCiLdomTtv8gVlLfqHAK3FsK0tlzkzp5Z?=
 =?iso-8859-1?Q?3BfA6wPatSqyn0mZJgy2Z3RehEZOwo6BzRsXKhAjVTTKskNY+SE2mkTJUT?=
 =?iso-8859-1?Q?fCg9Tv2CCbI98KKI6kwuaMDzUbYiEqNiSM/lA6+2lbOJqcwkgxME+Crn+P?=
 =?iso-8859-1?Q?v4jI1nMKa6xrWJSPWX4GU6X195PGk5rySSup+Kju6Tqb6PziB/WIVHjqHb?=
 =?iso-8859-1?Q?ncXWXpbdRKiJBT5GFYO8079ql14ePAUxrBCqPq8+Fr1yvvXRqkKoQzl7x/?=
 =?iso-8859-1?Q?NIe2+f0N6k9lhc9tPv2KWpb98PTej5D2GVWwH9DQmd39kR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc24a3c-6a99-4ec8-e8c3-08df1fcbe8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 14:54:35.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFRKJLtCm4tt0NHMvxB2VIj4Uh27QLmxnq5ccea1R5hQiPbFMse5e51B0NB49FCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777

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
