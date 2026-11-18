Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029887;
	b=aR5KHwZIZEIisSc3cNvTEaF8jOHRqCX7JB5tq001LwYAkpVL+lQ5iHQDplPjkvTH4ibZ
	 9zRkPKd8qN93M2nKpK4HPl0rx8ej5dpCIQeP/NJx47nW4Ql3lC/WDkH5s+2J3qEkz81gi
	 IZIYjemnrcm7w2xk+BN0JVm7ZJeKPh0soDeaEQLdZCrXE0AiZNaJM81cSUKDQ6rreFuF0
	 9JzhP92Wn5a5ZV/6HUiKcwM/mt/tq5MYoKj+DGM5JBdeZVb4RlozxYW9ZNZHjuaxb2g4g
	 VJPln6FD4y2ICE2z+C4CzuJJmvIscwcjtRk8bblsQhlAAHU2yfIDIMOW8uMI804unMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029887;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=di6CpM8xPfKp+JB2JVbEkH1jHYWw8AZmgKJXDjtifP4=;
	b=jkCGbK4HBzfVbjjjLx7dxlSVq+HRy09fnLP71DfPLz/JvPKF8/P10Z/IRUuHRDYS8SlS
	 0x+A8Fc7TNLYa2ddokb/XKwe7KptgFO4AB0OadY4x7mxHrni0sgjrxGulXmfM9WrpZNwx
	 ukIxc+2y+JMeSCLXfTZ+bJyz5ifp1zL21JsBVBZSzhreWqjwwjzsK2u8npQTj0oQKg2IO
	 0juOHM9lbuzLJ1skdtEHnqm0a0dzf32IcM6lyuNOO/hnk958pTjBXPv+bEcZr5dcxmkIT
	 mZDN2NQzpBcwxm7bBiYCtEa0FqykHrPeMqChYQN8l0naVbEgjgCfufZXIsf8/+v5NYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lUSFAeKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE160A262D;
	Wed, 18 Nov 2026 19:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45FE160A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lUSFAeKG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1daMFYebXw3jp/Xd3y0xodag4Yii1ygb5OJBG89sz//FNPnQKmuC5H+gmcnY67szFsomipQ5iHsQyWkcQhCpsyDUx2CnqtVLbnFyQYFMwR2SrfDs0lBkGwbu00tX8ZHU8fACvHcVnjJg+DpP51V3piipn7a5t3KRmGmUG1zwA330lH3qG6Zs7z76J0Gggweo6CA/OOhCcnBi1nx+IIwpG30JLqzaLXkV5KAOhM0kV8YpEeS676JkBM/GnNLI6VZFcfhdeWY3n3wE9p4U0JB2dVLObHUeDrfkBwKa6Z0/+PD+dReUPLWF9sHTiFT1vo/NK5FLdk2ByC6Dj10y4CWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di6CpM8xPfKp+JB2JVbEkH1jHYWw8AZmgKJXDjtifP4=;
 b=K5Cki4BPsD6W9sJEWP/ZfHhTu0VSHgThViOHv++0yi2dMuZE1vsGA9lojyaodjmGi+dj2ZJor/HbonRMnhmxRoorbp0bH6QFPsgl3Q//UD3hwl2fDiZDotjolKHbPbejHiwBDa5mCD8VcGrwhmdFzlUGQ93fAJuZn49Tvc0Wk+vUxHAIRgoG+Dy4KVUuoHCVAz8jfwsJAYzIov9cTFv/fXCcNAkdDk3ClbYe3xXm6sQiWfWxeP6sYrV/0TJv4krjFLyWq0x4LeMOPuq8aeWryN9Re3ZQ5CBipOBeA/JCcvXqsUk7BfS0Y1TCnmsYaxWh6zr4P8Cc3tCZ0g4A4QJ/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di6CpM8xPfKp+JB2JVbEkH1jHYWw8AZmgKJXDjtifP4=;
 b=lUSFAeKGJe4g+qvYe76TRN9c+ykZ4EE1eH8Crppa3SUPIp0aMQPcn51SrRmSl2KwKGxMiivgHmAP0GKNliQRbnmvJcT5rx/ySur4qiWD6GfHAsQW8UwNK9Px34bryWn0X/JwOwIrierduTx8EHYfPue6L3792nesRqCNhDLEqi0cZFyeEAdciOYokkO781Xfrz55/ih1WrJsM1xjTuI1RU07cJEeDe9id6tB8T9n+4kV3DZLYSfao56NY4uLTfl8ifur55SRegQOAlzoSJ/zOP+p3BDtpWGpwZdM4mOgqSxmdOvqqfdx5c2EPxvY3pkkRkVSofkT9TrxAEKBXWI5cQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:36 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:34 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v6 10/31] vfio/pci: Refuse ioeventfds and dma-buf exports
 over excluded ranges
Thread-Topic: [PATCH v6 10/31] vfio/pci: Refuse ioeventfds and dma-buf exports
 over excluded ranges
Thread-Index: AQHdXYpXTaVh73CCV0e7bQqHCmUr9bchpneAgBKiknA=
Date: Wed, 18 Nov 2026 19:24:34 +0000
Message-ID:
 <IA1PR12MB9030391F457918CEC347418CBD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-11-mhonap@nvidia.com>
 <20261106135245.2870aebb@shazbot.org>
In-Reply-To: <20261106135245.2870aebb@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 4b3dd3e4-cb44-4b76-b341-08df45a993d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022113327099003|38070700021|261021123027099003|10067099003;
x-microsoft-antispam-message-info:
 pEvPfkgaqTjeur1j9fBHFP6AmvOlrzyWfIPalRnWcGuF9LBoBVZ0+VQljk8VmPiB74DRRL2QRBzsH3jvaKc5mqChVrK1gHog50BKqjDpiapvlTgYX8gi9htOhC4zTxD+jm/55iJyEd3o/B2/lzDleLVFYy/D6ER9zdkcafg/SRu1rsFdFaV4TqBgXeZJgi1L8Gxn4bDAiK7K/VHCMISrfi+CwLQeNGkgmQtV3cqHXsZ8Zl+XvQHrJb8XZWkx7EUBczdIsFZb76t2R3wgW5x7dZdZEeOKKdJ+HEJhRrwMZ8zF8rTGH2Q2rljkFLVba1k9R42NNCVv/YQO0wP7WAx3pY7NGVJ87XI+KBWslxzatvKdo5GOzLg/cBvWrx/9QZXiwHGjWONIf2DpBqFn9vJ8F/zethSjG5W8CI0/JqrqB6kGFPwYDNw51+YlnCgAotxiqlWGZXtOTgauGmqhsdG5T/H/+rJJLGRcayCUDJmJWv/FsCCXY99TI1shhW5MnzF1C/hJ7XSZyedk1prZnQeNdFnDJLjw5Uu42mWAi9sk6MbwL+AznSAF8rYutkXc3WRSuX8toThplMdnfKdLAuXt0vERSC6BHhSbwe1m616JVlte6LwRQzHI6UpWnQLHpupPncuiHNV7pamoqYnimHwLnnCae81wPtaVGObfGG67/01HEplbwhRKfPt0WOMfrtaShjLjvX9WOK38gSlyCTZt4iRWCydERIYoEX1L/88Gnto=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022113327099003)(38070700021)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lRAOTP69nX/R+9sorufR9LSix9/K8IChf7PsY3KF2egDTAucWJEOLwZUWXkJ?=
 =?us-ascii?Q?7Ka1wnWJUZAkOqdPuAHD51yTmZP1YNJ72oztBkqi+WPrhoM4I/uYxZNYHQ2v?=
 =?us-ascii?Q?iXt88wW7pV9I9BN3WxuXrLqeTMB5GkD/uo1uVEE01/AkgYfkmTISoFcH8y2I?=
 =?us-ascii?Q?YWxrPeH+Bu7o5MthodClQlTHKv5zIv7tMU9kKBCIi2+cgK90qZpbL7ufKaxC?=
 =?us-ascii?Q?/6GHk80+eJgvmvjsB0RCBKUn+BslwsdWDcuCQwRXMSKQZVZSE6mWl2wU9zjW?=
 =?us-ascii?Q?VYmfQA1RSdcoRDI1QyERTJlr1SD0Ra5X41Onzca/5XPlZzJbyqonSiYNHwr9?=
 =?us-ascii?Q?CprQi/uw/r6K1PMTcgyprS3ucT5KAPksOdmBvgaNVeE973XtRWoE7pUtUbJH?=
 =?us-ascii?Q?fTY2WACF8lSLvntj136YSBTlEGPYhj4P++X9LGXprikRYhgC8lL2Q1q6XyWo?=
 =?us-ascii?Q?XosBD01Msxsq9zazQuxIAhpmEccBOSb2VJkSBtRAA2DiWBXws0Hz23CA+DKI?=
 =?us-ascii?Q?hZW1CfVCfUukDQmdSD/Iltz6YJXd4XstG1mo2as7gKW5kIRSaDsXvkU4ojpd?=
 =?us-ascii?Q?UdrGnfgnVlm8iQy8INMJJnYk0Y1TgCM9zUNz1pyXiAwfJqNGvn1T/6NLXUv+?=
 =?us-ascii?Q?wKQBzxjfZQmrt27X98XAhUiLC1PWToZX006kUhkYz6ZDPU3SemQ+easO8vDU?=
 =?us-ascii?Q?ygPN+Ckn/4V84+wz+cqe8ib6cHtMi/q6QajU3JYvDy0KpUlgZlNkxFq0rloE?=
 =?us-ascii?Q?BvpLKbZSv6km327ch4Of4bMAW7kxfipGArbNxyTr6T0m0dcRc6aYwFn78sRo?=
 =?us-ascii?Q?93pth8pP7w9E8jqu9Ozs2SB5/X/s+7PeEGRoADssmhOmDpK5LFIxsCvijkkb?=
 =?us-ascii?Q?RNFyDs6l6P4APsxRWMi1WpL080SXmDm6ZCc/YG2p7MMjFnaxWbuF/1zG+kCh?=
 =?us-ascii?Q?W6KZ3CP8q0W87P7/oG5dVQi47OBiP3I/91V0qFoPmd9BQMIeJlgPxZoaZ3+m?=
 =?us-ascii?Q?lz1j/FVPo6Bp3m7hYBunA+D5LLNkhxMhxQVqxy5+OUMrCFrv4+VlF58kkOTH?=
 =?us-ascii?Q?gQvtsq9bgbmWK7GAQRHZaOCBYD4FLIyVRtOdDmi3q06DY92ogdj86InwFLfN?=
 =?us-ascii?Q?2poVDMgBw97VUxJ/f7t1/rbhKGm6gcGRa70u2RVuV8DrA4shpNChaAHAy73b?=
 =?us-ascii?Q?q+Pf5I072ghdysxBq3C3Ay6Lx65IPbKaduQXpvAtqutbe/j0Y6HjsBGklJQH?=
 =?us-ascii?Q?Jt4/8IA9agCUKDLvmIMzevKqh/2lX66K7zcS6hjA+HjqJD5tGNUYCYT4LyOX?=
 =?us-ascii?Q?LoECzWI4pTLJQCsT+1pxg7Jgm9bIYnHDv3C1YAkUotVpirf2dz8sleYWiTzn?=
 =?us-ascii?Q?amekFXvtcjNbZrQvN4u+hgzmr18uu/wXGhRMq8bwQM3mSYhGr/RAdamdUNrU?=
 =?us-ascii?Q?oAu1yAfJvyYIYeTMwU5cFNxdy/PaRfHRu5oah8qYEaSqTwyxs8XkuZ0HY+ZU?=
 =?us-ascii?Q?Rj9g/hYGBEXM4SLQz1GgXFfM0pQdfw9Huc4t03k84Zhn6+0IK6Iq+/Xb2T9k?=
 =?us-ascii?Q?ny3J35+TawL+vDGAAYB4F8Y75TUo9bQNz1SEswaTLCFYuG/zIteOvkU0n5e1?=
 =?us-ascii?Q?ieiCh/5VEvt642gJoun6zqg13BB3NI+F90r05I+VaGoF8ChnS3PrOPRZN83w?=
 =?us-ascii?Q?xdRQdncfUhcyAHgXo1r4H03Tr29Kldatl4eqCMIxVYmVZoeJ?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3dd3e4-cb44-4b76-b341-08df45a993d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:34.1972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcQbyADEUy4vLf7p2m0+NTm9EPNfMqkmyC5wy6YtNn7kfvqXG3QXlDMqxOHISkrbDRS6y+TR7/IAK5mq8KeVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Saturday, November 7, 2026 2:23 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan Madhavan
> <smadhavan@nvidia.com>; corbet@lwn.net; skhan@linuxfoundation.org;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v6 10/31] vfio/pci: Refuse ioeventfds and dma-buf exp=
orts
> over excluded ranges
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:17 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > vfio_pci_bar_rw() keeps the excluded ranges of a BAR off the device,
> > but two other paths reach BAR MMIO without it.
> >
> > An ioeventfd writes the BAR directly when it fires, through
> > vfio_pci_core_iowriteN(). Refuse an ioeventfd whose range overlaps a
> > write-excluded range, as one over the MSI-X table is already refused.
> >
> > A dma-buf export of a BAR range lets an importer map it for DMA, which
> > reaches a range that the BAR keeps off mmap. Refuse an export whose
> > ranges overlap an mmap-excluded range, so the dma-buf follows the same
> > rule as mmap.
> >
> > Suggested-by: Alex Williamson <alex@shazbot.org>
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  4 ++--
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 14 ++++++++++++++
> >  drivers/vfio/pci/vfio_pci_priv.h   |  3 +++
> >  drivers/vfio/pci/vfio_pci_rdwr.c   |  9 +++++++++
> >  4 files changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index f099a294af34..211fff6045e2 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1107,8 +1107,8 @@ static void vfio_pci_free_excluded_ranges(struct
> > vfio_pci_core_device *vdev)  }
> >
> >  /* True when [start, start + len) on @bar overlaps a range with any
> > of @flags. */ -static bool vfio_pci_bar_range_excluded(struct
> vfio_pci_core_device *vdev,
> > -                                     int bar, u64 start, u64 len, u32 =
flags)
> > +bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev, in=
t
> bar,
> > +                              u64 start, u64 len, u32 flags)
> >  {
> >       struct vfio_pci_excluded_range *range;
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index c16f460c01d6..8606c15ab2fe 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -260,6 +260,20 @@ int vfio_pci_core_feature_dma_buf(struct
> vfio_pci_core_device *vdev, u32 flags,
> >       if (ret)
> >               goto err_free_ranges;
> >
> > +     /*
> > +      * A DMA mapping built from the dma-buf would reach a range that =
the
> > +      * BAR keeps off mmap, so refuse such a range here as mmap does.
> > +      */
> > +     for (u32 i =3D 0; i < get_dma_buf.nr_ranges; i++) {
> > +             if (vfio_pci_bar_range_excluded(vdev, get_dma_buf.region_=
index,
> > +                                             dma_ranges[i].offset,
> > +                                             dma_ranges[i].length,
> > +                                             VFIO_PCI_EXCLUDE_MMAP)) {
> > +                     ret =3D -EINVAL;
> > +                     goto err_free_ranges;
> > +             }
> > +     }
>=20
> This should be rolled into validate_dmabuf_input().

Okay, I will update this in the given function.

>=20
> > +
> >       priv =3D kzalloc_obj(*priv);
> >       if (!priv) {
> >               ret =3D -ENOMEM;
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index 53544e0cbedf..09a68c99b43c 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -52,6 +52,9 @@ struct vfio_pci_excluded_range {
> >       u32                     flags;
> >  };
> >
> > +bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev, in=
t
> bar,
> > +                              u64 start, u64 len, u32 flags);
> > +
> >  #ifdef CONFIG_VFIO_PCI_VGA
> >  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user=
 *buf,
> >                       size_t count, loff_t *ppos, bool iswrite); diff
> > --git a/drivers/vfio/pci/vfio_pci_rdwr.c
> > b/drivers/vfio/pci/vfio_pci_rdwr.c
> > index 93823c6391f6..ef098f0b1401 100644
> > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > @@ -476,6 +476,15 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device
> *vdev, loff_t offset,
> >             pos >=3D vdev->msix_offset + vdev->msix_size))
> >               return -EINVAL;
> >
> > +     /*
> > +      * The ioeventfd fire path writes the BAR directly, without the
> > +      * excluded-range filter of vfio_pci_bar_rw(), so refuse a write-=
excluded
> > +      * range here.
> > +      */
> > +     if (vfio_pci_bar_range_excluded(vdev, bar, pos, count,
> > +                                     VFIO_PCI_EXCLUDE_WRITE))
> > +             return -EINVAL;
> > +
>=20
> The code immediately above this is still performing the open coded exclus=
ion
> based on the MSI-X range, which is now incorporated into the generic rang=
e
> exclusion.  It should be removed.  Thanks,
>=20

Okay, I will remove this in v7.

Thanks,
Manish

> Alex
