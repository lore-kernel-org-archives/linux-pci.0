Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795033379;
	b=NL1PKZeW8RZzlbB2P9E0a51UE0W0VLoRixpNrG+3NIZt3VxPFPNlp5pszh/XdeZeCW7J
	 dBc9Lw33A1FerIwR5znHYzXsFX52EMuTZL66LHmeT6xYFgHMKTec9nw33kxNkWiGwCHwf
	 vQOM6/ERB15kNrx8/9d05zPX6rM8QGS3RnBlLQyCy3woPMGhsBQFpi1WYRH4OhTToghzV
	 IJzNcLRGvjA24L25VnmY31BTtG2wV+ErrHQlMVASNOMal5H3SUqAvxtcOKIbjTmIngyMI
	 0DsrpX6L2k4BXTfVbSFQCBTkN1f0NNB2vjsu2z56ZNkTnqRmDcPu0ScKs2YAeV9aniA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033379;
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
	bh=WU36LL6Io6SGRmXDDc7XFb3Fk1s26TOBsy3K8igAGQQ=;
	b=ziK1rkjdTs6gDKtxm/8b5GKLzTxHZiiDRbF1HzRh3nKKAWA6xwXKvceqbeJIVwoE2Tf2
	 WAjPtMMjc4CKYQKnIOkT9Z0XBBwqPk+gjbHlIoNenjnGFXU9zCMSuHCJl7WdMJCM+H6I1
	 q7XR2rwBkftXeZY1V85i9ZaVcmwWur95X2iyHz9FQq6/0zd2dp82jtigAwDQ1ELfVaBRL
	 zyULR7bcPZ+8FTpU0Gja9cTxAOTzUNLLKQnVfP28l6A0T3uc/a62oBChPSQtAAZAlIJtg
	 0hh+1Zr2n/LUxSHj6exbv29mUgyovQ/Su2x2A/GnYtLiKZDtfW4SI6qQIphPieNB7Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ip+OJi87;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.52
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D560A2606;
	Wed, 18 Nov 2026 20:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 677D560A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ip+OJi87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUK0ypsk+N5UjGMXZgbebN40NR/8WnyfRjCLhn4ImxMC6q6XG9dgAYtUeutJ72QmEePkPf/rxMKsiVPJ77zkDMw5riAqIhgGhqHxzHbNrwqAmDLzhnvs1A6twyplL9B6EIfupW/fdurZcTm++iW7JDNyY29W0pP9WtHcT69YIbmNCwVQrWQsh8Vz+671zjWbPWQgUu3dE1Hrv+kWuV1VPkUxXsy3Bgmsylm/xTlvP8F8XVBd2/cRjR/nRvTKF1sn02AuMcLP8fZm3DoO4ArqpQ1A0et+uEKfaRdVtKgv0o7+iLpijTMJ6uPrLKaaYSHY1aTWzIe09AdEojJuHHNISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU36LL6Io6SGRmXDDc7XFb3Fk1s26TOBsy3K8igAGQQ=;
 b=Vc9/FV7Y8vjzh5zGGiQ5big6HRHC9fzIcocwz/ZZHUOGELeTEsnVMfTDKOftSSm5b8EKs/5llYXn9Z6zOLfXE2l/vDnhivTnLlu/64bXWKFSpZAxfy46RIM/8ZCNeqU/oKDl5Ai+mJYptEqve4YTcpOcpL9pVjwCtGmupXx1vMgdfAmjd76rLacRxV7cKaUn7Ga3yOk/X4+BHCDN49scGQ4C2Op90/o1Rlee/oSiaVgbjF9yvS4GyOjBY0I4iuVXOUn2jnS76zk901Y4MweY9BEF7TTKFQ8xe0xLdXLeW01W57a6Tf6iLoTECrdFWCznA+oM4VpnouywphW8e3i/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU36LL6Io6SGRmXDDc7XFb3Fk1s26TOBsy3K8igAGQQ=;
 b=Ip+OJi87mb/Lpa3m6EJG8rvB2z22IoXNQMi0tEMEMfX6yaUZEARdBr5wKgnHvHE8tGHtnjUCeNBzAOfN0XXkvmWlJ52Wsx4Fd6LoBwrf8+OvhJG82rSfgISHLCdPLxofYBCsfuzOlXbe7npl8mykiFLnt088ZUO0GBLGV1aHgLWk//xvttExlIjPAk6WKM1G5gMdWO39DNrp0HqT6VSSj+kd5+cUZde80hEzO7Cuj4Sfb4L1d1ob5Ermn9kYVE4+tuc5n4c3nGwVierBRUujYVnVDqCVasc/eR+wawT+cDWQpspOGedt+2c9S23zasLFWXswc3Q9WM2iXoYN+T1Zkg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 20:22:44 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 20:22:44 +0000
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
Subject: RE: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL reset
 hooks
Thread-Topic: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL reset
 hooks
Thread-Index: AQHdXYpkTge0tadFUkKQBGmeopvbmbch1nCAgBJ4n/CAAClJYA==
Date: Wed, 18 Nov 2026 20:22:44 +0000
Message-ID:
 <IA1PR12MB9030E196B6C4AB249FCCF432BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-14-mhonap@nvidia.com>
 <20261106164427.51791193@shazbot.org>
 <IA1PR12MB9030A85A328C20ED230AC4B0BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB9030A85A328C20ED230AC4B0BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|LV3PR12MB9266:EE_
x-ms-office365-filtering-correlation-id: 31d1da75-e171-4f74-cd1e-08df45b1b405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|22082099003|261009223027099003|18002099003|3023799007|11063799006|4143699003|261102130727099003|56012099006|5023799004|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 01DFz54X4XFx3fWACjin4i1bpnqeUHBLSIdWNmDZ/v9vJJEluLrMgIyvnViH6qx0ZzjhoNUhrN3IpeyfghjpTJfsg7wvvMOPh6A/tKiNwoq55L/Bf/cXwnN5ltX+t7KKeB4bjrb5rOzIWJn3Gn3tYXH5sh40k9vi8Fw6pVIv7xWNkI+t5sKgPzk8I4+KHPDIQs85e2x5wY8GyWx2Tyc2ErTcnyw6B9CS4B/VvGMYd8QdN0PvoLU5+T1v8DtEpsIo6WxUXpuW4ermeF+CnFZoEnBZ4pwbWNRhbhzmKlAFj9aPiOyk+ryFFdN9jbLXTARdzqPe2ToWqnvxhXq/kqP9O3teNrQ09/brBF66g1VY6Jj6/+fFJyteM9jRhW2O2kWT4/4uaOoMzOJ8kzms0WQo/OMVsSlhCGqqzD0ZveQMVlkhIqJTvWXN59jSqSeyTnH+S86AbWjX8bXpi6IVfg7o6DrAQb1Ax0F57n3MGONeR/2gyCOdO3hYoEqBMPTYsTPL04rH3JC/UwVN6Z6NHCOM2k8XESk/48sRV8snpWGH+5LKxuunhN1bgoWKG/LCq0z+xesQmMDguC7M33O9WLS+ddol5aMfqDP7GnXRhVpdGDZ96OawBkO243uxDQ40mQOZ08wOfFzF9yBgvmGp60wupsvsM2doTJc/oX/ke5ryG6QsUwg9CB7Q76ATDgWGJoAqi7N9fpzKUZIGhYNTu8IkLxCc1g3JLVcE68ivagBP5zE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(22082099003)(261009223027099003)(18002099003)(3023799007)(11063799006)(4143699003)(261102130727099003)(56012099006)(5023799004)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IVTPx96NrcbgppSsfo+mVfiZSvxIy6PglBMB4puY0HHV02zFIXXZSBB5pYcl?=
 =?us-ascii?Q?6LhxbhQKs9YSY62BW1Yk/DVlt/MHwJCA1QfkjnwZu+6SklPphHXn+VV2BBbB?=
 =?us-ascii?Q?PxphX6+zsD/IDYSWA6Y24pqNk5Y0A3hl3e0pqs93oqZI+tnkFmYWXan0XxGq?=
 =?us-ascii?Q?bFW2lkoI7RMaFZC75pR1pSbtNRC2EWOQnKTEN+2tzEvNBRFO1UXBVt/pnyut?=
 =?us-ascii?Q?zaS7VT8Z2lk3DjBDuynkGQLklAi+Yz5I4A+IcPLSm9IAW+g4Ir/76z4Y0FM0?=
 =?us-ascii?Q?Yr5DxfHWoqR3BjdRCB/HJY6NYgncL0G3oAAVcohQ7uzvuuhbM2vYYFOOPa4G?=
 =?us-ascii?Q?/baFz2r+jtpoOX3cynI0zIG8G4L6Sn7gPWneNbR9QTNVNURG49wi5xOwRDgP?=
 =?us-ascii?Q?U7tgV+ivgo0QBd50FQ//Km9Cc9pCON69DNWhycIIQDwv3fvEOsmxf7kuTJF8?=
 =?us-ascii?Q?EBkSao20ILfRo9YTmKgVP9YVFgTug6iv42OV8E+NB8lz3i5l2X1hsYDwFlYQ?=
 =?us-ascii?Q?eOwf3vifxCc62NSusiU4+lQv566OzrFO4eRzB5M46ZE3glfqhxXQr+4BuvtC?=
 =?us-ascii?Q?56Lk0lIOX24AQOFnhMY2d3z0/8649r4T2e70nTe4rPoFwSNQIjWT5czBuAiC?=
 =?us-ascii?Q?pTvp2MXO29XNkf/hE3t2N1lrr30M+Kj9kkYxc3M6XApmawGbM5ogGAm+aNsx?=
 =?us-ascii?Q?UTp3bt5JiVtdrW85zOcjrWI01mkGrRRjf9zB6ljzTXZRcdImhdhkqs2MLCh/?=
 =?us-ascii?Q?ZjIqVHlIaR/VgOoClo0n/bKH7OOF0f0bAZJOE5VMSpXj+qr5STUL/6Jupg8X?=
 =?us-ascii?Q?GZXkn4nhPBNXeEUly3hbd6qESPx7Qd0ED01G69IGQp/3KH8z/GEmcgZmr3d5?=
 =?us-ascii?Q?4fbUsprMGNKi5RkDNsWZlReM0xZzrTZZJ9Aw/7/bN+vXNDXRTHSpJtJrzg+8?=
 =?us-ascii?Q?BBdStw0cpMTzOOXMakNqVYWLean+cu9UVTpGnuHKV7rHD11D5DEIBtJxplqi?=
 =?us-ascii?Q?qbyoBmn9fJQ9Yt6lyzP19eDFcBeu+bhbfXh7uoFRT8SJVcHbhtgJyDxLX5lR?=
 =?us-ascii?Q?5UVv8xUwHwr2w7IUK2dTAddyCboFjUfW7iVq7lizXBhRDynm1sgs/1O4wCDZ?=
 =?us-ascii?Q?8TBUVb9X2fGmyPeTM6ME9EheMaMeZvq+aqAtZExQUKDWvgr9vnuCg39HOzCM?=
 =?us-ascii?Q?mVPsQztX/rvDHFnZrYpKMBJ4rgfq3nhDxHaS3+vP69s01ocoAuRQZUtavwAi?=
 =?us-ascii?Q?PHKnHqNElrQoUep/ARrTFjZNQVZK7YOk0WuvX9CvHPmOtc5oZUES0f/YGXA5?=
 =?us-ascii?Q?6rn+KxAaYKl5SrBQHluiUI1K/Uxjl4XGZYoyBqyRwaSzEf18o3NnpFlluxBL?=
 =?us-ascii?Q?BiC9c72sAm/RPB9ub2qeGg2E9n4BIJhCVEXzJLfdOt3P0rukCALmM8FA7teJ?=
 =?us-ascii?Q?+CwF0zWv4FgRRFvfQNRl+T1iHOYoMCJNO1G+jGFo2rqjCyVpK5sNgEqeTQCl?=
 =?us-ascii?Q?Tn6sb5zpwqp7YV8Y5hmasz8XJQYY0GIePKPCAmIm4KewAs4/y+TsWANs0HL1?=
 =?us-ascii?Q?JaseD8+8K/Q3MDYCF3iR5HmEa1UV/xOy9aHUu7sjxi5SriG9/9q48QgAN2XR?=
 =?us-ascii?Q?pAtUaDw86b3Aa5PUjW29PI19+RFiWkVc6L5FU+wf0kwQ/uPL4WyQG5isvuiV?=
 =?us-ascii?Q?BrBaw2/Wcc+BELaOEjE6To0m7dDe0b/fabTpE3v4XWGIfaaL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d1da75-e171-4f74-cd1e-08df45b1b405
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 20:22:44.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpLDYTVBwPwskOijt2uzzdGKgp5I8//q3/K7EZKtz9358OVMQfodgyfAi4qxoYrmSv4P4DKjRm9i5tOWUhKKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266



> -----Original Message-----
> From: Manish Honap <mhonap@nvidia.com>
> Sent: Thursday, November 19, 2026 12:54 AM
> To: Alex Williamson <alex@shazbot.org>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; Manish Honap
> <mhonap@nvidia.com>
> Subject: RE: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL r=
eset
> hooks
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alex Williamson <alex@shazbot.org>
> > Sent: Saturday, November 7, 2026 5:14 AM
> > To: Manish Honap <mhonap@nvidia.com>
> > Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> > dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> > Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> > skhan@linuxfoundation.org; dave@stgolabs.net;
> > alison.schofield@intel.com; vishal.l.verma@intel.com;
> > iweiny@kernel.org; ming.li@zohomail.com; Yishai Hadas
> > <yishaih@nvidia.com>; Shameer Kolothum Thodi
> > <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> > dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> > <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> > <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kvm@vger.kernel.org; linux-cxl@vger.kernel.org;
> > linux-pci@vger.kernel.org; linux- kselftest@vger.kernel.org;
> > linux-hardening@vger.kernel.org; alex@shazbot.org
> > Subject: Re: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the
> > CXL reset hooks
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Fri, 16 Oct 2026 21:48:20 +0530
> > <mhonap@nvidia.com> wrote:
> >
> > > From: Manish Honap <mhonap@nvidia.com>
> > >
> > > A CXL Type-2 device must quiesce its coherent link before any reset
> > > and restore its HDM decoder state afterward, or a reset can leave
> > > the device mastering the bus over decoders that are no longer valid.
> > > This has to happen around every reset the PCI core drives for the
> > > device, not only the ones VFIO issues directly, and around AER and
> > > DPC recovery, which can reset the link without the reset callbacks.
> > >
> > > Add:
> > > - reset_prepare
> > > - reset_done
> > > - an optional error_resume to the CXL ops
> > >
> > > Export:
> > > - vfio_pci_core_reset_prepare()
> > > - vfio_pci_core_reset_done()
> > > - vfio_pci_core_error_detected()
> > > - vfio_pci_core_error_resume()
> > > which take the vfio device.
> > >
> > > vfio-pci calls them from its own pci_error_handlers, which resolve
> > > the driver data it owns. A variant driver that binds CXL devices
> > > calls them from its own handlers the same way; a driver without
> > > reset_prepare, reset_done, error_detected and resume callbacks gets
> > > no CXL
> > support.
> > >
> > > The provider hooks run with memory_lock held for write:
> > > vfio-pci-core already holds it across its own hot reset, and
> > > vfio_pci_core_reset_prepare() takes it for a reset started anywhere
> > > else until vfio_pci_core_reset_done(). The hot reset records its
> > > task, so a reset that another task starts meanwhile waits for
> > > memory_lock instead of skipping it. pci_dev_lock() blocks user
> > > config access, which a PCI_COMMAND write can be waiting for while it
> > > holds memory_lock, so reset_prepare lets config access through while
> > > it waits. reset_done returns an error when the provider could not
> > > restore its device, and VFIO_DEVICE_PCI_HOT_RESET returns that
> > > error; for any other reset the provider logs it.
> >
> > Cryptic.  Seems like we're skipping updating all the variant drivers
> > to make use of the new reset and error hooks, which seems wrong.
> >
> > This also needs to be rebased to the the new drvdata handling in v7.4-r=
c.
>=20
> Okay, I will handle both the flagged items. I will check the new drvdata
> handling.
>=20
> >
> > I'm also not sure why the "provider" terminology has snuck into this
> > series with this level of prevalence.  There's only one cxl ops "provid=
er", it's
> vfio-cxl.
>=20
> Okay, for v7, I will mention this as vfio-cxl.
>=20
> >
> > > Assisted-by: LLM
> > > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci.c      |  39 +++++++-
> > >  drivers/vfio/pci/vfio_pci_core.c | 154
> > +++++++++++++++++++++++++++++++
> > >  include/linux/vfio_pci_core.h    |  22 +++++
> > >  3 files changed, 214 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci.c
> > > b/drivers/vfio/pci/vfio_pci.c index 830369ff878d..286244059569
> > > 100644
> > > --- a/drivers/vfio/pci/vfio_pci.c
> > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > @@ -223,13 +223,50 @@ static const struct pci_device_id
> > > vfio_pci_table[] =3D {
> > >
> > >  MODULE_DEVICE_TABLE(pci, vfio_pci_table);
> > >
> > > +static void vfio_pci_reset_prepare(struct pci_dev *pdev) {
> > > +     struct vfio_pci_core_device *vdev =3D
> > > +dev_get_drvdata(&pdev->dev);
> > > +
> > > +     vfio_pci_core_reset_prepare(vdev);
> > > +}
> > > +
> > > +static void vfio_pci_reset_done(struct pci_dev *pdev) {
> > > +     struct vfio_pci_core_device *vdev =3D
> > > +dev_get_drvdata(&pdev->dev);
> > > +
> > > +     vfio_pci_core_reset_done(vdev); }
> > > +
> > > +static pci_ers_result_t vfio_pci_error_detected(struct pci_dev *pdev=
,
> > > +                                             pci_channel_state_t
> > > +state) {
> > > +     struct vfio_pci_core_device *vdev =3D
> > > +dev_get_drvdata(&pdev->dev);
> > > +
> > > +     vfio_pci_core_error_detected(vdev);
> > > +     return vfio_pci_core_aer_err_detected(pdev, state); }
> > > +
> > > +static void vfio_pci_error_resume(struct pci_dev *pdev) {
> > > +     struct vfio_pci_core_device *vdev =3D
> > > +dev_get_drvdata(&pdev->dev);
> > > +
> > > +     vfio_pci_core_error_resume(vdev); }
> > > +
> > > +static const struct pci_error_handlers vfio_pci_err_handlers =3D {
> > > +     .error_detected =3D vfio_pci_error_detected,
> > > +     .reset_prepare =3D vfio_pci_reset_prepare,
> > > +     .reset_done =3D vfio_pci_reset_done,
> > > +     .resume =3D vfio_pci_error_resume, };
> > > +
> > >  static struct pci_driver vfio_pci_driver =3D {
> > >       .name                   =3D "vfio-pci",
> > >       .id_table               =3D vfio_pci_table,
> > >       .probe                  =3D vfio_pci_probe,
> > >       .remove                 =3D vfio_pci_remove,
> > >       .sriov_configure        =3D vfio_pci_sriov_configure,
> > > -     .err_handler            =3D &vfio_pci_core_err_handlers,
> > > +     .err_handler            =3D &vfio_pci_err_handlers,
> > >       .driver_managed_dma     =3D true,
> > >  };
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > > b/drivers/vfio/pci/vfio_pci_core.c
> > > index 3d4e01eea7b1..f1e1ec36eec7 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -2462,6 +2462,7 @@ static bool vfio_pci_is_cxl_type2(struct
> > > pci_dev
> > *pdev)
> > >   */
> > >  static int vfio_pci_core_cxl_init(struct vfio_pci_core_device
> > > *vdev) {
> > > +     const struct pci_error_handlers *err_handler;
> > >       const struct vfio_cxl_ops *ops;
> > >       int ret;
> > >
> > > @@ -2473,6 +2474,23 @@ static int vfio_pci_core_cxl_init(struct
> > vfio_pci_core_device *vdev)
> > >       if (!ops)
> > >               return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER :
> > > 0;
> > >
> > > +     /*
> > > +      * The provider must see every PCI core reset of the device and=
 every
> > > +      * AER or DPC recovery. A driver without reset_prepare, reset_d=
one,
> > > +      * error_detected and resume callbacks gets no CXL support; the
> driver's
> > > +      * callbacks must call vfio_pci_core_reset_prepare(), _reset_do=
ne(),
> > > +      * _error_detected() and _error_resume().
> > > +      */
> > > +     err_handler =3D vdev->pdev->driver ? vdev->pdev->driver->err_ha=
ndler :
> > NULL;
> > > +     if (!err_handler || !err_handler->reset_prepare ||
> > > +         !err_handler->reset_done || !err_handler->error_detected ||
> > > +         !err_handler->resume) {
> > > +             pci_info(vdev->pdev,
> > > +                      "driver lacks PCI reset or error recovery
> > > + hooks, continuing
> > without CXL support\n");
> > > +             vfio_pci_put_cxl_ops(ops);
> > > +             return 0;
> > > +     }
> > > +
> >
> > Just implement them in all the variant drivers and make them validated
> > in vfio_pci_core_register_device().
>=20
> Okay, I will check this part.
>=20
> >
> > >       ret =3D ops->init(vdev);
> > >       /*
> > >        * A provider that is not ready yet (for example its CXL port
> > > has not @@ -2759,6 +2777,128 @@ int
> > > vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,  }
> > > EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
> > >
> > > +/*
> > > + * Take memory_lock for a reset that the PCI core runs on a locked d=
evice.
> > > + * pci_dev_lock() also blocks user config access, and
> > > +vfio_basic_config_write()
> > > + * holds memory_lock while its pci_user_*_config() calls wait for
> > > +that block
> > > + * to clear. Waiting for memory_lock with config access blocked
> > > +would hang
> > > + * both tasks, so let user config access through while waiting: the
> > > +PCI core
> > > + * calls reset_prepare before it saves or touches the device. The
> > > +caller holds
> > > + * the device lock, so a block found set is the caller's own.
> > > + */
> > > +static void vfio_pci_reset_lock_memory(struct vfio_pci_core_device
> > > +*vdev) {
> > > +     struct pci_dev *pdev =3D vdev->pdev;
> > > +
> > > +     if (down_write_trylock(&vdev->memory_lock))
> > > +             return;
> > > +
> > > +     /* The caller did not block config access: nothing to release. =
*/
> > > +     if (pci_cfg_access_trylock(pdev)) {
> > > +             pci_cfg_access_unlock(pdev);
> > > +             down_write(&vdev->memory_lock);
> > > +             return;
> > > +     }
> > > +
> > > +     pci_cfg_access_unlock(pdev);
> > > +     down_write(&vdev->memory_lock);
> > > +     pci_cfg_access_lock(pdev);
> > > +}
> > > +
> > > +/**
> > > + * vfio_pci_core_reset_prepare() - prepare a device for a PCI core
> > > +reset
> > > + * @vdev: vfio PCI device about to be reset
> > > + *
> > > + * Call from the driver's pci_error_handlers.reset_prepare callback.
> > > + */
> > > +void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev) =
{
> > > +     if (!vdev->cxl_ops)
> > > +             return;
> > > +
> > > +     /*
> > > +      * vfio-pci-core holds memory_lock across its own hot reset. Ho=
ld it
> > > +      * across a reset started anywhere else too, until reset_done. =
Test
> > > +      * the owner, not just a flag: another task can reset the devic=
e while
> > > +      * a hot reset holds memory_lock and has not yet locked the dev=
ice.
> > > +      */
> > > +     if (READ_ONCE(vdev->hot_reset_task) !=3D current)
> > > +             vfio_pci_reset_lock_memory(vdev);
> > > +
> > > +     vdev->cxl_ops->reset_prepare(vdev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vfio_pci_core_reset_prepare);
> >
> >
> > This is all super sketchy.  Sashiko triggers multiple critical issues.
> > Having different locking behavior across CXL vs non-CXL device is not
> > acceptable.  These callbacks occur even if the device is reset through
> > sysfs or AER while the device is not opened.  Inferring whether the
> > lock is held or not is very hacky.  Thanks,
>=20
> Okay, I will recheck this part. For my review I was only using review-pro=
mpts
> kernel md file instructions for my LLM review. I will setup local sashiko=
 and
> verify this with complete runs.
>=20
> What vfio-cxl needs from these callbacks is to keep the device memory
> unmapped from reset_prepare until the device decodes it again.
> memory_lock was the convenient lock for that, not a requirement: CXL
> memory decode does not depend on the Memory Space bit. So, in v7 I will
> serialize vfio-cxl memory region with its own lock and take it in its hoo=
ks.
> vfio-pci-core will not take lock in the hooks, so its locking is the same=
 for every
> device, and hot_reset_task and reset_done_err will go away.

After giving this more thought, I feel vfio-cxl lock in these hooks will
still need ordering rules of its own: it must never be held across the
PCI reset calls or a user config access, which wait on locks lockdep does
not track.

So, instead of above locking rules, I will follow the nvgrace-gpu approach =
in v7:
- reset_prepare, reset_done and error_detected only mark the device memory
unavailable and count the reset, with no lock.

- New faults, reads and writes fail until a CXL Reset through vfio succeeds=
.

- The resets vfio starts still revoke the mmap and the dma-bufs under
memory_lock. (Mappings that exist when a non-vfio initiated reset happens,
are not zapped)

A plain sysfs reset of an open device resets nothing: vfio-cxl holds the
HPA range while the device is open, so the cxl_reset method returns -EBUSY
before it touches the device.

vfio-pci-core still takes no lock in the hooks, and hot_reset_task and
reset_done_err are gone as noted earlier.

Thanks,
Manish

>=20
> Thanks,
> Manish
>=20
> >
> > Alex
> >
> > > +
> > > +/**
> > > + * vfio_pci_core_reset_done() - restore a device after a PCI core
> > > +reset
> > > + * @vdev: vfio PCI device that was reset
> > > + *
> > > + * Call from the driver's pci_error_handlers.reset_done callback.
> > > + */
> > > +void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev) {
> > > +     int ret;
> > > +
> > > +     if (!vdev->cxl_ops)
> > > +             return;
> > > +
> > > +     ret =3D vdev->cxl_ops->reset_done(vdev);
> > > +
> > > +     /*
> > > +      * hot_reset_task cannot change since reset_prepare: setting it=
 needs
> > > +      * memory_lock, which this task or the hot reset task holds.
> > > +      */
> > > +     if (READ_ONCE(vdev->hot_reset_task) =3D=3D current) {
> > > +             /* VFIO_DEVICE_PCI_HOT_RESET returns the error. */
> > > +             vdev->reset_done_err =3D ret;
> > > +             return;
> > > +     }
> > > +
> > > +     /*
> > > +      * Nobody waits for the result of a reset started elsewhere. A =
provider
> > > +      * that failed has logged it and keeps its device memory out of=
 use
> > > +      * until a later reset restores the device.
> > > +      */
> > > +     up_write(&vdev->memory_lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vfio_pci_core_reset_done);
> > > +
> > > +/**
> > > + * vfio_pci_core_error_detected() - prepare a device for AER or DPC
> > > +recovery
> > > + * @vdev: vfio PCI device the recovery reports an error on
> > > + *
> > > + * Call from the driver's pci_error_handlers.error_detected callback=
.
> > > +The
> > > + * recovery may reset the device without reset_prepare and
> > > +reset_done, so a
> > > + * provider takes its device memory out of use here.
> > > + */
> > > +void vfio_pci_core_error_detected(struct vfio_pci_core_device
> > > +*vdev) {
> > > +     if (!vdev->cxl_ops)
> > > +             return;
> > > +
> > > +     guard(rwsem_write)(&vdev->memory_lock);
> > > +     vdev->cxl_ops->reset_prepare(vdev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vfio_pci_core_error_detected);
> > > +
> > > +/**
> > > + * vfio_pci_core_error_resume() - resume a device after AER or DPC
> > > +recovery
> > > + * @vdev: vfio PCI device the recovery resumes
> > > + *
> > > + * Call from the driver's pci_error_handlers.resume callback. A
> > > +provider puts
> > > + * its device memory back if the device still decodes it; otherwise
> > > +the memory
> > > + * stays out of use until the user resets the device.
> > > + */
> > > +void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev) {
> > > +     if (!vdev->cxl_ops || !vdev->cxl_ops->error_resume)
> > > +             return;
> > > +
> > > +     guard(rwsem_write)(&vdev->memory_lock);
> > > +     vdev->cxl_ops->error_resume(vdev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(vfio_pci_core_error_resume);
> > > +
> > >  const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
> > >       .error_detected =3D vfio_pci_core_aer_err_detected,  }; @@
> > > -2915,6
> > > +3055,8 @@ static int vfio_pci_dev_set_hot_reset(struct
> > > +vfio_device_set
> > *dev_set,
> > >                       ret =3D -EBUSY;
> > >                       break;
> > >               }
> > > +             WRITE_ONCE(vdev->hot_reset_task, current);
> > > +             vdev->reset_done_err =3D 0;
> > >
> > >               vfio_pci_dma_buf_move(vdev, true);
> > >               vfio_pci_zap_bars(vdev); @@ -2940,6 +3082,17 @@ static
> > > int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
> > >
> > >       ret =3D pci_reset_bus(pdev);
> > >
> > > +     /* A provider that could not restore its device fails the hot r=
eset. */
> > > +     if (!ret) {
> > > +             list_for_each_entry(vdev, &dev_set->device_list,
> > > +                                 vdev.dev_set_list) {
> > > +                     if (vdev->reset_done_err) {
> > > +                             ret =3D vdev->reset_done_err;
> > > +                             break;
> > > +                     }
> > > +             }
> > > +     }
> > > +
> > >       vdev =3D list_last_entry(&dev_set->device_list,
> > >                              struct vfio_pci_core_device,
> > > vdev.dev_set_list);
> > >
> > > @@ -2948,6 +3101,7 @@ static int vfio_pci_dev_set_hot_reset(struct
> > vfio_device_set *dev_set,
> > >                                        vdev.dev_set_list) {
> > >               if (vdev->vdev.open_count && __vfio_pci_memory_enabled(=
vdev))
> > >                       vfio_pci_dma_buf_move(vdev, false);
> > > +             WRITE_ONCE(vdev->hot_reset_task, NULL);
> > >               up_write(&vdev->memory_lock);
> > >       }
> > >
> > > diff --git a/include/linux/vfio_pci_core.h
> > > b/include/linux/vfio_pci_core.h index 6520a2dcfd4a..881e51c42414
> > > 100644
> > > --- a/include/linux/vfio_pci_core.h
> > > +++ b/include/linux/vfio_pci_core.h
> > > @@ -72,6 +72,21 @@ struct vfio_cxl_ops {
> > >       void    (*release)(struct vfio_pci_core_device *vdev);
> > >       int     (*open_device)(struct vfio_pci_core_device *vdev);
> > >       void    (*close_device)(struct vfio_pci_core_device *vdev);
> > > +     /*
> > > +      * Optional. Called with memory_lock held for write when AER or=
 DPC
> > > +      * recovery resumes the device, after reset_prepare was called =
for the
> > > +      * error. Config space is as the recovery left it.
> > > +      */
> > > +     void    (*error_resume)(struct vfio_pci_core_device *vdev);
> > > +     /*
> > > +      * Called around a PCI core reset of the device with memory_loc=
k held
> > > +      * for write; reset_prepare also when AER or DPC recovery repor=
ts an
> > > +      * error. reset_done returns an error if the provider could not
> > > +      * restore the device; VFIO_DEVICE_PCI_HOT_RESET returns it, an=
d for
> > > +      * any other reset the provider logs it.
> > > +      */
> > > +     void    (*reset_prepare)(struct vfio_pci_core_device *vdev);
> > > +     int     (*reset_done)(struct vfio_pci_core_device *vdev);
> > >       /* Pinned per bound CXL device so vfio-cxl cannot unload under =
usage
> */
> > >       struct module *owner;
> > >  };
> > > @@ -166,6 +181,9 @@ struct vfio_pci_core_device {
> > >       struct vfio_pci_core_device     *sriov_pf_core_dev;
> > >       struct notifier_block   nb;
> > >       struct rw_semaphore     memory_lock;
> > > +     /* Task running VFIO_DEVICE_PCI_HOT_RESET while it holds
> > memory_lock */
> > > +     struct task_struct      *hot_reset_task;
> > > +     int                     reset_done_err;
> > >       struct list_head        dmabufs;
> > >       /*
> > >        * Excluded BAR sub-ranges, one list per BAR, sorted by start
> > > and not @@ -207,6 +225,10 @@ void vfio_pci_core_release_dev(struct
> > > vfio_device *core_vdev);  int vfio_pci_core_register_device(struct
> > > vfio_pci_core_device *vdev);  void
> > > vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
> > > extern const struct pci_error_handlers vfio_pci_core_err_handlers;
> > > +void vfio_pci_core_reset_prepare(struct vfio_pci_core_device
> > > +*vdev); void vfio_pci_core_reset_done(struct vfio_pci_core_device
> > > +*vdev); void vfio_pci_core_error_detected(struct
> > > +vfio_pci_core_device *vdev); void vfio_pci_core_error_resume(struct
> > > +vfio_pci_core_device *vdev);
> > >  int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
> > >                                 int nr_virtfn);  long
> > > vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,

