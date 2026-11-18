Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029904;
	b=qURJbTmZPnRi9j4peSZv6zlkmlOBFbhDIewKtrykZxCemylu7sPqJUSRfJJE6fpHg7Bk
	 NjfmZT/6jm7oTczwN8h9AEYXJoU+Mkj4g6IpzQYcjXieI6qmPbLngn5TvHGkUMbj3IJ78
	 mQlW/uxWt3zI3fd9/67jIfU6jIwTiv6AQ2gcCF6hJVE5A8oGY+i84810DwPJtsYsagoaC
	 Mt7H/b62vRNo6iLja4CZT6aHhzO/FfKhYpBKDLMYYQC6QFzujZVBsEUVxIa2DvdbT4ydD
	 3oXvXgcePnLgWN+VdkhjFy1wrY/kVWXzeLPxA2HY1J5Q9+43cjiB3sfgcCzRZD98jpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029904;
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
	bh=IxcaskVNHaPhuM8XfCRqFJPQx/TEgUdNzIioqB8CNXc=;
	b=vqSrbCUM6pvC6R6PQKw5PykiqvPNzakyqYyHbDI5IGFyGQn7irEJ+mSWg8JJyC1VyHuE
	 2kfjOVXWZb2sTNnUTyM/MktN1/AqFLrmOPfWQ7M5puZ5L/XHsyulyuyFP8WuBaUasASlS
	 B2UiKrOvawdzJCTa21ZmJQkpD3mzZNl/3fUZWLtvPvCSSqL+F7MmOLHpsnDu/de+81AHf
	 NlYqsT0SqcDnkYRZAiSyUoYlCnaIFEN+ViIxI1X7DnQrZ3mYQJGsBlAQ4SqG+brNSG+OK
	 +x8apJ4boGluchA/Y77JZ6RI6EboR8CcEah1jg31efhhH54+oYbMltARtcDXNugDXBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iuxbLv4z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F360A261A;
	Wed, 18 Nov 2026 19:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD4F360A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iuxbLv4z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMUshkL487y2WGudRNDFZqCyQqe8UZm8HmuEons3D3cLSO/MIA5F9uEnQl0xjrg3y3BdAKCzPB5645wbj/az5bE5hTGbqkzZ5y1gs79OporRd9zr/5/azAUbGRfAVkH/X6QGZ8enWdzJrpMJVao0kxVdBXweUxykE4mE7Yo5JJPICcPVQk8wCK1VdoL8aJeAgkbZJFCftfeAOQhX4gy1BVjaIultjP3jORhoiFDm7f5Djy4GEEn6tz57nxPZQtZoMKJFL6IeUYAOWaW0fJAkekMUYxB3lZ664Uk5Td4qyr0C59kB3c+U2GlccJhCQDT0Z/98rMOIZXo1xHRHT+DV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxcaskVNHaPhuM8XfCRqFJPQx/TEgUdNzIioqB8CNXc=;
 b=Ji5IrtM+ESR7+6u2epv9CAPQ9Rd8DfzVRDKM8Yngzirmvw8n16lIhwp/n1su1jHWlLpJ72NrwGZCtEDJHshGU7NBnk2oA9LXnJgj2hOXermB85KehjgYIgm80iVBRNRs+H1WEuCIcRWdWCX9kMnbyALNbocl5aASYaNFMUD/i8vTgpZb6JvalW0aiBDbI5RJK59KkHcdClvmLKVsOMr+6/oFiTp+lM+9Z2sgJAxWxfIh4tc3JrQCiEMJbwdycKJ7ZD0Ur5G5NBrJ+fC1Fyyj7TQgVygI008kviWDfHU6KFUUMaT0Qe2ZscTaA+RhAp8Wx4EFseFydryYkbIJ9qd7Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxcaskVNHaPhuM8XfCRqFJPQx/TEgUdNzIioqB8CNXc=;
 b=iuxbLv4zUW9HQJIkPvKCoOgSHzxzRX6kdBKmbdPC0fWoF+HzjziUPwGZdB4GMp9gIT3rKSHK/K/gCnywPJaCdqRPA+tMeq4sCki9V2qXggCxWI5ZS95DpGKUQoc2PscWZomcktuWnDRwKxtnwcPEaEsBxF1bAueGkxruYoD9Hqh5CLoh8iNGpyZ0/lbp89xBhQ7fs/79XaSYow9E4RoVoyJcsf/U83y4tFPQ7oCE+mfn0Bk06XypmPzoUAaGn88wuXHpQai2l6haZBCaZBfJCw1amlKz08CODAmXDXqR8fcDFp1prUKnL7yPr4pBzpoQbZvytn6h0XJiTO7u8nsUTQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:24:52 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:24:52 +0000
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
Subject: RE: [PATCH v6 07/31] vfio/pci: Detect CXL devices and load the CXL
 provider on demand
Thread-Topic: [PATCH v6 07/31] vfio/pci: Detect CXL devices and load the CXL
 provider on demand
Thread-Index: AQHdXYpKL5uZEnghmUSofyelBg1aWbcetC4AgBWoamA=
Date: Wed, 18 Nov 2026 19:24:46 +0000
Message-ID:
 <IA1PR12MB903080126D5C9434839E803ABD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-8-mhonap@nvidia.com>
 <20261104165304.2563f4ae@shazbot.org>
In-Reply-To: <20261104165304.2563f4ae@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 6110e833-c63d-4c7b-72ae-08df45a99e61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|3023799007|4143699003|261102130727099003|56012099006|11063799006|261026121527099003|261102123227099003|261102124527099003|5023799004|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 zH4jrDiypzfgfOkt78A3OPU7JHtHE69TCsJFm+jNE8Jnn8bue8a+24PGWNuFZOI3eAmc81louKjE64DCC6bkh8PSpKCDa3naeHrb93Voc/vZmxXK4RWenrfHnLUsNIC6+avfZzb9PcDEBkbvjn+dzAxZgAaYAS7mSJMJUZW4u3t9zxtkBETe6ZfNVK9qvi2dHLjluB5OfHrqjlWJQrNL1WFJfiaj6yirSLocLDfD3+RaFKvLXcZ0hD1tebVQ/takvF56QiOz7Ed2GMvjuZ/AQ2MD74925l7PqrxNUHVL5czi54nibqzxsDZozud9JiA+sHBvFBXFPWps1+AlCHGaa8+bjQd3NenGv83GPdmPCZJtpX5gkhW2DcorLTsaY2AzkziKUJPXPXzmf53nCDQYhJUlaLe/kWwgGi8uomzziDM5OyfaEnUTYp5Tv+oJoVnddHcq8KBbcHfXi8uKbegMcIDAPGbJfDR7GqWact/R9hP/A3aL3Z/S8hG9zHJkqk8o0K9/vO8f0OKnQZEJ1zm4/SFhtGVj2P61IW022T1DI6SlkHMbjDnViBxIl0K2m1LPJblKTrDLwotsKhn6RPHL7x8srPr5stLdwqnA04xSuuukrb7GBsjfzsdO9jElPJRvZLcRwGU9+TUPDlhcy7shR7UyPBldBrO9rAWkfkJ4B/agUmAhYMZqmIExQ5RHqI0RnVrLahD+bM1LNcApSbe4TOlrfcJHnQZe5DPJ1DBpn6E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(261102130727099003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261102124527099003)(5023799004)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lCfT+aE5l5GA5hIZ7JrUnby7ESMbEdeNAuj8Unq+knYr2lY3+PO0QwKUBzHc?=
 =?us-ascii?Q?ne5yIEef+h4E+83JUP3GW/OHSQUpUiOpwgnI2gO0lsZhsPz5Sq7VDYt5LR8H?=
 =?us-ascii?Q?3TZ+PhQiQNJsXxgf2mF9fMLuQjZjSm0sttOnkzC6PatWG9GhxfL6W0AUJvbr?=
 =?us-ascii?Q?WuzaB0frYBZn+nSfNR686v3wUbP+uf0YAaL28COI09pERiDhQj/0m+d5wpzj?=
 =?us-ascii?Q?uGyRaFOsL0r+uF1TbOLeM5gUK16pTxzPNGsMBE6HWhxQRcoUdm0yBW+xNxYg?=
 =?us-ascii?Q?MFuqP7JMUGrhQpT8B1NLKLvT5ghKeWKkZeoCRyVoxKGz1gIqOYEY9gvdG/cM?=
 =?us-ascii?Q?38deSuBQZ37vqemozGs2oHvc0zjOv/tpj06XHcAt06JWaVMCB8uzvL3uHyZg?=
 =?us-ascii?Q?4F1KgUIfYTDxNQJNAuyvo6yxDyCGGQx2vPNXUPjdjxpHHNFTsISMir99P6rr?=
 =?us-ascii?Q?SIaRNr0KUq6vHxHjUM19upcK7q8RL+4vka3d0NheJtxnnPsY/MwW9jERIdl1?=
 =?us-ascii?Q?Yim7e/Q/0Us7dXx+acyRCfz1XfKghKkBscBpMmzuvRMvamNC7x2W5RDeGMjl?=
 =?us-ascii?Q?Lywk95K7GTRYzUEfDE57EO/3gfBlWoxCGt4m94kodV5ks9q+yDaIydIH0aJ5?=
 =?us-ascii?Q?RJWKo5joi4WOuqVKp7mRmsd3am/3IKj6P2/2WtnMb1pBCstDWCHPm/FosjIN?=
 =?us-ascii?Q?OE6WQgDW3Sinf94rHvvB48tx/0QyhVGoPlo8HF1FMByaEFNGkNGGCKHtdq2K?=
 =?us-ascii?Q?dNA2eCbeHFUs8eXElB65hh2omkHxWcm4oev0uh4HZQSEd6Y97a3Qybltl8+z?=
 =?us-ascii?Q?nRhPNvR0vXYCYFw4SG61c0FZuiqSEyj7KNvm4ha7AfPJ2xaWGfNmd1qrXLEY?=
 =?us-ascii?Q?xuHG6u8oTOn32RJZkr687159rpi+EJddaxN2CgA4vDd2BVQOUeDI4YlOc+iF?=
 =?us-ascii?Q?f+lBQaWYJfD/12A0XmGpV9k3wL+GZcychrYpQITDHE01A/6K94kGa+eC62iv?=
 =?us-ascii?Q?LgBYfrL7iM8szI8ZfINNbUNXKn6rlDhr62A5SPQzJRajJ7IjeNfP5/iXw6WR?=
 =?us-ascii?Q?AeBj9EL4IMsnATZuo8Mq1E93tcfdqGV1spwml79ImjehtBejT0EsUeZcXHA1?=
 =?us-ascii?Q?gr9nz2Cg+NJu1xgdCZDGI5tH8QXUmBjCU1MxExRVr5GOiRiQ0hVk0cfw4K0t?=
 =?us-ascii?Q?q2qr5bJ5sFnZ/rCFhUakNFQsljO01vPup2RrJALvUmbsXu+colJU4SOFiGY9?=
 =?us-ascii?Q?EPysqq/yhfTadkaRTlM7c5zmAP/ZTQ8Q/2C/pT75WzFBq+MwujAu3mvghTlX?=
 =?us-ascii?Q?qeyIE+rnmVE/mbrpd2qIYTzkgrR4kOIsUCAKRs3G0PiirdZ9vZw/Ap/GpqjZ?=
 =?us-ascii?Q?ddAnSug3onfbnSE80C0fdN986j1Hg15fRxAy7MdNPQNR2g14jtpjOR07RMfD?=
 =?us-ascii?Q?kF4uDgDM8N2K6x/z3zp575lyqz5L72IcRBGlhMBm1fpkngVJZRmoBrvWcJa2?=
 =?us-ascii?Q?BNGkf3yXo90pyi+3hpLFmmoSjJm235BZeCDSr7eypcuZZe9FO1ekKkWor8hn?=
 =?us-ascii?Q?oiJMO9hqZEmIjY8xVOgT7qujPoY70691/iuZKlbQDUV2XLnTr7M+UGpw7VD7?=
 =?us-ascii?Q?fEzJAlB2AHRwiH2G0BC6TnXBDrKKVZmuphMOjOx6IV5kSSmFxvR7uK4lA6lb?=
 =?us-ascii?Q?KmPD6Y1Dd5rxM2ndOlY0c7YmkpQzicRADV3HK2qqpPVCGwzt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6110e833-c63d-4c7b-72ae-08df45a99e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:46.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjCyvtuOVmrGVXUdWiIbRfJs+FJfXBkY2lpP/KCcBkzPaBUQADr+hvz0XR7JEBBEqg1T4QrWRsd7gnV6ZdaXEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Thursday, November 5, 2026 5:23 AM
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
> Subject: Re: [PATCH v6 07/31] vfio/pci: Detect CXL devices and load the C=
XL
> provider on demand
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:14 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and
> > the CXL core in unconditionally would bloat every vfio-pci setup.
> > Detect a CXL Type-2 device at bind and request_module("vfio-cxl") only
> > then, then hand the device to the registered ops.
> >
> > Each bound CXL device pins the provider through
> > vfio_pci_get_cxl_ops() (try_module_get) and drops it with
> > vfio_pci_put_cxl_ops() at release, so vfio-cxl can unload once no CXL
> > device is bound.
> >
> > If the provider is absent the device is bound without the CXL
> > extensions. A built-in provider whose initcall has not run yet is
> > waited for with -EPROBE_DEFER; the deferred-probe machinery will retry
> > the bind once the provider registers.
> >
> > The provider .init() can return -EPROBE_DEFER when the device is not
> > ready yet, for example when its CXL port has not enumerated. Propagate
> > it so the bind is retried later. Any other init failure is non-fatal:
> > a CXL Type-2 device is also a valid vfio-pci device, so log the error,
> > drop the provider reference, leave cxl_ops NULL and continue without
> > CXL support.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 101
> +++++++++++++++++++++++++++++++
> >  include/linux/vfio_pci_core.h    |   3 +
> >  2 files changed, 104 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 2cc5dd20396c..e50b36751d9a 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -2202,6 +2202,101 @@ void vfio_pci_core_unregister_cxl_ops(const
> > struct vfio_cxl_ops *ops)  }
> > EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
> >
> > +static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void) {
> > +     guard(rwsem_read)(&vfio_pci_cxl_ops_rwsem);
> > +
> > +     if (vfio_pci_cxl_ops && try_module_get(vfio_pci_cxl_ops->owner))
> > +             return vfio_pci_cxl_ops;
> > +
> > +     return NULL;
> > +}
> > +
> > +static void vfio_pci_put_cxl_ops(const struct vfio_cxl_ops *ops) {
> > +     module_put(ops->owner);
> > +}
> > +
> > +/*
> > + * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CX=
L
> DVSEC.
> > + * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem
> > +only)
> > + * devices, which the vfio-cxl provider does not handle, so confirm
> > +the Type-2
> > + * identity before engaging it.
> > + */
>=20
> Probably another AI comment, it's only describing what the function is
> obviously doing.  Drop it.
>=20

Okay, I will drop this.

> > +static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev) {
> > +     u16 dvsec, cap;
> > +
> > +     if (!pcie_is_cxl(pdev))
> > +             return false;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     if (!dvsec)
> > +             return false;
> > +
> > +     if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
> > +             return false;
> > +
> > +     return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
> > +             (cap & PCI_DVSEC_CXL_MEM_CAPABLE); }
> > +
> > +/*
> > + * Load vfio-cxl on demand for a CXL Type-2 device and hand the
> > +device to its
> > + * ops. If the provider is absent the device is bound without the CXL
> > + * extensions; a built-in provider whose initcall has not run yet is
> > +waited for with
> > + * -EPROBE_DEFER.
> > + */
> > +static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
> > +{
> > +     const struct vfio_cxl_ops *ops;
> > +     int ret;
> > +
> > +     if (!vfio_pci_is_cxl_type2(vdev->pdev))
> > +             return 0;
> > +
> > +     request_module("vfio-cxl");
>=20
> A local sashiko run questions:
> ---
> [Severity: High]
> Could request_module() in vfio_pci_core_cxl_init(), in
> drivers/vfio/pci/vfio_pci_core.c, deadlock when a matching Type-2 device =
is
> probed asynchronously and vfio-cxl is an unloaded module whose own
> async_probe setting remains false?
>=20
> Asynchronous probing can be selected with vfio-pci's async_probe=3D1 modu=
le
> argument or driver_async_probe=3Dvfio-pci. The resulting wait cycle is:
>=20
>     __driver_attach_async_helper()
>         vfio_pci_core_cxl_init()
>             request_module("vfio-cxl")
>                 waits for modprobe to exit
>=20
>     do_init_module() for vfio-cxl
>         async_synchronize_full()
>             waits for the outstanding vfio-pci probe
>=20
> In kernel/module/main.c, do_init_module() performs this synchronization a=
fter
> the provider initializer returns. Successfully registering the operations=
 therefore
> does not break the cycle. The provider's async_probe setting is independe=
nt of
> vfio-pci's setting.
>=20
> The warning in __request_module(), in kernel/module/kmod.c, does not abor=
t
> loading. Dispatch through pci_call_probe(), in  drivers/pci/pci-driver.c,=
 also
> preserves the cycle because the originating async callback waits in
> flush_work(). The global async wait has no timeout.
>=20
> The final series retains this synchronous request. Could provider loading=
 be
> moved outside the outstanding async probe, with binding deferred until th=
e
> operations are available?
> ---
>=20
> AIUI, this could be resolved if we do the request_module() on bind and th=
e CXL
> init on open, but CXL expects that we use the devm interfaces that have a=
 bind-
> >release lifetime.  But then...
>=20

Hmm, I will need to spend more time on this. With vfio-pci async_probe=3D1,=
 I think
the probe blocks in request_module() while do_init_module() for vfio-cxl
waits in async_synchronize_full() for that same probe.

For v7, I will load vfio-cxl from vfio_pci_init() instead before
pci_register_driver():
- if a device present at that point has a CXL DVSEC that vfio-cxl can handl=
e,
init calls request_module() and waits. Module init is not an async probe, s=
o
the cycle suggested above cannot form, and a host without such a device wil=
l not
load CXL module, as per your suggestion on v3.

- A device that shows up while vfio-cxl is not loaded gets
request_module_nowait() and binds without CXL support, as it does
today when CXL setup fails. A rebind will pick it up.
I will use MODULE_WEAKDEP("vfio-cxl") to keep the module in the initramfs
without loading it.

> > +     ops =3D vfio_pci_get_cxl_ops();
> > +     if (!ops)
> > +             return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
> > +
> > +     ret =3D ops->init(vdev);
> > +     /*
> > +      * A provider that is not ready yet (for example its CXL port has=
 not
> > +      * enumerated) returns -EPROBE_DEFER. Propagate it so the bind re=
tries
> > +      * rather than continuing without CXL support.
> > +      */
> > +     if (ret =3D=3D -EPROBE_DEFER) {
> > +             vfio_pci_put_cxl_ops(ops);
> > +             return ret;
> > +     }
> > +     /*
> > +      * Any other failure is non-fatal: a CXL device that cannot be br=
ought
> > +      * up as Type-2 still works without the CXL extensions, so log an=
d
> > +      * continue rather than failing the bind.
> > +      */
> > +     if (ret) {
> > +             pci_warn(vdev->pdev,
> > +                      "CXL init failed (%d), continuing without CXL su=
pport\n",
> > +                      ret);
> > +             vfio_pci_put_cxl_ops(ops);
> > +             return 0;
> > +     }
> > +
> > +     vdev->cxl_ops =3D ops;
> > +     return 0;
> > +}
> > +
> > +static void vfio_pci_core_cxl_release(struct vfio_pci_core_device
> > +*vdev) {
> > +     if (!vdev->cxl_ops)
> > +             return;
> > +
> > +     vdev->cxl_ops->release(vdev);
> > +     vfio_pci_put_cxl_ops(vdev->cxl_ops);
> > +}
> > +
> >  int vfio_pci_core_init_dev(struct vfio_device *core_vdev)  {
> >       struct vfio_pci_core_device *vdev =3D @@ -2223,6 +2318,10 @@ int
> > vfio_pci_core_init_dev(struct vfio_device *core_vdev)
> >       init_rwsem(&vdev->memory_lock);
> >       xa_init(&vdev->ctx);
> >
> > +     ret =3D vfio_pci_core_cxl_init(vdev);
> > +     if (ret)
> > +             return ret;
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
> > @@ -2232,6 +2331,8 @@ void vfio_pci_core_release_dev(struct vfio_device
> *core_vdev)
> >       struct vfio_pci_core_device *vdev =3D
> >               container_of(core_vdev, struct vfio_pci_core_device,
> > vdev);
> >
> > +     vfio_pci_core_cxl_release(vdev);
>=20
> Sashiko has a doozy regarding the resulting lifecycle teardown:
>=20
> ---
> [Severity: Critical]
> Can vfio_pci_core_release_dev(), in drivers/vfio/pci/vfio_pci_core.c, inv=
oke
> provider teardown after device-managed cleanup has freed vdev->cxl when
> final object destruction is delayed during unbind?
>=20
> In the final series, vfio_cxl_create_memdev(), in
> drivers/vfio/pci/cxl/vfio_cxl_core.c, allocates the provider state throug=
h
> devm_cxl_dev_state_create() against pdev->dev. This release hook instead
> runs at final vfio object destruction, which can follow driver removal an=
d
> device-managed cleanup.
>=20
> Device-cdev close and unbind can interleave as follows:
>=20
>     vfio_device_fops_release()
>         drops the last registration reference
>         completes the unregister wait
>=20
>     vfio_pci_remove()
>         finishes unregistering
>         drops its vfio device reference
>         returns while the cdev still retains the vfio object
>=20
>     device_unbind_cleanup()
>         devres_release_all() frees the provider state
>=20
>     __fput()
>         cdev_put() drops the remaining parent reference
>         vfio_pci_core_release_dev() calls provider teardown
>=20
> Enabling delayed kobject release provides another path without an open fi=
le.
> The module pin preserves the provider callback text, but does not preserv=
e its
> device-managed state.
>=20
> vfio_cxl_release_device(), in drivers/vfio/pci/cxl/vfio_cxl_core.c, then =
reads
> the freed cxl->hpa_range and cxl->hdm to release the reservation and free=
 the
> decoder snapshot. Reuse of that allocation can cause an incorrect reserva=
tion
> release or an invalid free. The final series retains both the managed all=
ocation
> and this final-release hook.
>=20
> Could provider teardown run before device-managed cleanup, or could the
> provider state remain allocated through final vfio release?

I agree this is a bug in v6. I will handle this in v7. vfio-cxl state is
allocated with devm agains the PCI device and freed at unbind. But the tear=
down
happens at final vfio_device release. This can come later if cdev file
outlives the unbind.

For v7, I will setup CXL objects in vfio_pci_core_register_device and tear
them down in vfio_pci_core_unregister_device. This way, nothing CXL is left
in release_dev. CXL lifetime will be from open to close only.

I will make sure this is not introducing any bugs by running a local sashik=
o run.

Thanks,
Manish

> ---
>=20
> So perhaps trying to shoehorn CXL's devm lifecycle into vfio-pci is bitin=
g us
> anyway.  Thanks,
>=20
> Alex
