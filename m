Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67533F12E1;
	Fri,  9 Oct 2026 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526457; cv=fail; b=Olcu99TBEigdmbSYGyns5+6Poxq/p/Gp7aeVUJX6PiGOVGEC67wxoe0jJ21szp/WlZb4eKxQhR1+iB23IoQx9xxZ9TOibWd3Am7L7XUi+stdKImBAOTWKBIiM4fARggaqwfdo7syxvxu808FOi1IoAUEgoz60yJk9AsHU2f6JdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526457; c=relaxed/simple;
	bh=qB1CBvHBjixRMV/IgKRUpBGDYFyr4jg6tVjXm3zZVYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bzYExaGV3KZgCDa3AtuZrbxCcxoDbr4l5KhArH2vn68Ypg6QfR/9Htjg7i+LTTdkQxhW9Zbmex3thA5Qcl4v+Sx8gcaDOet/30EW2DjQ5iNPDaWpUvVWCYH3soGejaVGFmulRUtRCe0XvKo8MXBiF0sIWCBv5Gbb0+aEsev6Au0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NitYLw+e; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NitYLw+e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsWi5mAaru2i07rcRpffJPDk6pzWSVaEaR1kKUDHmVZPUsx5O9J3xylGTSduhA8U2JUp968XAmc7oMYpRhDtPk300L5LztatXu0lQS1o9TJG0B76bJ8ZXjS0cuYGo3aNVL83ks+BVtFs9JMRBL5lta2Mm4vXEEDf0OCQ97AgE14gWdxnjRYIheh04C8kMPZwbsPtAWVI0xJvZVcDRvMIQLgR4dFCrK7R1ZAQWLhpHcvYccOKq9hMxZGAoCWMIM5LxI6Pn88RRaUb7gs8+dXKN4K6YAeUyUy4vYfXwu0h/hg0F0aLhA77kp/6TO3s3LE15PYRCPR+LImvzmVKERN8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+3NRBQ//k3Z/Gk27aYYKRbrl7tQ3tmz0hRW3hOycko=;
 b=aVEtog98iFR9HQygINKFII0bkf9HxfWzMtWRV2Y+lLg5K6bvezc5gsF8UZIOm/M0ZJ+UTpT70WcFtPgKOTn3LZfjhWoaeFAmVOcFUrg1WPUs0y/xqE+qjnlMa2py/HkEUffcWIfPhPpYiJu9z2hzvdNHsjr8HMjse/ewGoegz3PdWEm8JQMD8XqAmS1UnOfl6OV0f12vQBDN4PpjGhUmsAK4t7YHHoyNTc74WdG1fjwctyrX70ugvwebVF6p5F4gAVHSD4/lMrt/ZHI5eyRaLGkHyRfYnubHgRgnqF7EkRpqzgdwGOtU2MwKkqnx/xQJPoIO07NLjUl6RHk4cJ2EcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+3NRBQ//k3Z/Gk27aYYKRbrl7tQ3tmz0hRW3hOycko=;
 b=NitYLw+e10i/ivC9/mfmFLCciKt+VVZ6EdYu3xYZkbiNlohHhL1Jb0cTIAt1e9CDuMfpHGftPEY/GiFi6FjHHQ6mQ4UHSdwxZ0tdpAeCTWatfsrUDUbu9Kogr81r3SCc3W0cilG/B0ICCtOFtTpxBXSwKnGTB7AcmLP552SOUu5vUWlWhE5ec7CYwkbCpmJLnEW/Z+yKposo5Od8ZXU0hNXRmfB0CcMv69Jcuo13fWe65mWEPpnZ8QJNyrUV014a+vXf1GPcYhhT18xj8uK9PyI3eCueJTQfGEi1oR6W6WdQsLKFihinKx7oGiiWlKtMIDKpMqWI6qNkpbdILRlQJA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:09 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:09 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "dave.jiang@intel.com"
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
Subject: RE: [PATCH v5 03/27] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
Thread-Topic: [PATCH v5 03/27] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
Thread-Index: AQHdRgpghYTEeQxGakyqixU7lrfeILbZ24KAgBrtPcA=
Date: Fri, 9 Oct 2026 06:14:09 +0000
Message-ID:
 <IA1PR12MB90307DB2BCB490E890713148BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-4-mhonap@nvidia.com>
 <20260922024341.7aecc867@jic23-hlaptop>
In-Reply-To: <20260922024341.7aecc867@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 03f2cc1b-64ea-41f9-d277-08df25cc8804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 4JnJsJfLmmw9bNze5aPfJ4ZBLT0J0sy0iNI7KD6u93v6+Fi9QRfb90mQUcPiWkVdLfPmpGb+MJP7oSsnwPZex1lMBswoff33Vbiu5rW5p4vKdEi0yie2i7k3ocXMXODKCCfNd/Kooav7lq/tYU8TF8TPMHe3UozvYTzLWOx8QpWlNi60deh5q3fi0WAga9kx6PLrbxlv1GKlOREueIRjszvlxR6hYVIw328OrB6PlBoLRHKvYCK3wanSyAEfLeaYBuwjB2TeWuVnkuGcCe+UWKZR4dsEgHcH3m0tu8Y2GnsSLVLaM76h+5NVSefxSLEX9kB3ldOtDeqJ4lTj10c0Ukwi3SVg8c7uCF+65xKDUIyrg+wNJJMyFj9F/STgRnoEYtxZbiGfU52hX+812wU1sMrr/KYNy43eSAKGzJxof7bCy9ND0/BWLpI/9va8QVnSNl1BD49nyOd4CSE97Ws+BZdo+NBAsLSh76BpzSybfrs6TdQuTMriHly243Uj3KMuF7RYsXLXlh7if/JwK7tGCq6Pzcdi3Oz1lpMGWOdt0ZCirFxR/MlVOCJpdbMcxKZyOan4TvDhIFQQDkSLmxd9Aod54lnszd4cYqbQuwrfrCf057gQV1VRJ6UWJ9rLEtYNwrCu/INlzJkey8NnYsKK0stW/sPcRZBEyaBWn5BUWWDqLBT3QAjby3LxXP0oGL4AXD5Mh0AD0QrDzcyiYlNunIAzcpLOIKRQjzbhjcqzZw8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FJKfYcfLAg4taohuIL51zb2jEOlEaCNQiuFIjNWCAK2ep2BP5yVCEB+0S8ol?=
 =?us-ascii?Q?v8KxuoqDnW41OadceMq2Ae5q8Zb1e7Doj+jnCIl/0JSERyRlY2iIl2BuJL+/?=
 =?us-ascii?Q?2gXT09ZhWB5m+2pZBJnEddvzGkKBMkHVy02nLcNFEb1bmed0/JDggf2fwxRe?=
 =?us-ascii?Q?Jk3uEFWfoS4FpJCs89cAjbnqc4hVsaSx7R/h7oPz5xP+bsAXQQq8QDLssk5y?=
 =?us-ascii?Q?huqUijgOBt1IePZNEdBNJU0iU+PZHJrVqfKTZB+H+UzCMpsceArld8b3Fgwc?=
 =?us-ascii?Q?n5uNIBNURsujWonWvCMMG5WZ9+4UcRb+R4k/dcAWr/GRkemkghkyNk2agbn6?=
 =?us-ascii?Q?CMFf/d5zFmAyvaK/6kHLlyvXTm+NJ03w9eU/LlDiO+MPsswk48llgIZqmSX9?=
 =?us-ascii?Q?dQdh9PdJkVOkPRSrHzz2KHbnoVrkT0CyaDTu321yc8q9mFIzpIRATY7ucUSi?=
 =?us-ascii?Q?2RfTlTElktV0A+YPFezu0g0vzglaykmbfV8NABVmYKrTYMHE9dsQr9JDjkEm?=
 =?us-ascii?Q?De2HVcEgIhKQrARLvHW3eLkU/eacV+zqNMTJH08qLmqX1NCZ03zsFIcKBcbT?=
 =?us-ascii?Q?uX74l1IkEXJRztlzT7yCGXYT4WO4SgTSMw+8ygxSHesIa1kbgC8G76PhB4eg?=
 =?us-ascii?Q?BReUscgVZY1EcD2N7xjF5NPrLS3/TqPo/SqQ8N+ApZhtYvzX9oKzvqn6OdcA?=
 =?us-ascii?Q?sPs11ISUQ8fZMAC1N5CCjGyuu6KPI2mxAVx+MIx6mEDX1GIioXJ+PMJvNe/5?=
 =?us-ascii?Q?Q03GmRdZgmAtmG6HZfwl3Dh4M9+YxpRm+ofcm/CR7yvBtwX6CZSjHNVikvIS?=
 =?us-ascii?Q?hxzvzwReqOPnutmvhauuFSw/RjEmxJxM96j3VrNEGAMNX5gSoKhBuoQeLJ9c?=
 =?us-ascii?Q?pu13hChXp1J4813BdWSF4F7F1iurzecrIvrJbFA8OwcWJPscFc1Rlr0b0kzt?=
 =?us-ascii?Q?FaDOmi79swy3hCuJsAJ2dTE9rd0tsR+46Cv37JELmadZvwPFw6qoqqnIzRZx?=
 =?us-ascii?Q?LIbLiMWvhU6TLAOo/1/9bhA9ZaRSzlHiomtfmfQTKAk2dUylOhhkz8IJ3cH/?=
 =?us-ascii?Q?1bpovMk+tHNsxKBXlNdymFKB4TMUZmDN9HxQ3qLgdsrVjAV8sc3+0JUmeoz4?=
 =?us-ascii?Q?RSZEp7zVEq/jHxQ3B83WJuD6XAkZLhUfPPgglP2rDN4u7APglpYp2JEgXcmw?=
 =?us-ascii?Q?GR1uFS6RU0Nvh87dMRJb02jddXtlazTb9j0e5XCSDOqeI7PERIAIBIaKDiSm?=
 =?us-ascii?Q?ShI5SnrfdcZ47YW5D/LDGsTX+jbvcl1XPN8FLILJvYbClsIVCZ1414r+eEAI?=
 =?us-ascii?Q?tH1REa6m2/O44haOpIB62Q29+YHJtNujystvPyaO9rpiJJUfPC6Tlalk9D05?=
 =?us-ascii?Q?wZPEggviape7LExTbxV2u/U0vpNNPfswcl/FVdspZakdJAdyOloGr+IK0zH8?=
 =?us-ascii?Q?ZVEJzKu21yBHvxi+ukToFRxhNo9kiejM3sNDEW9pTDzFU8P33u47nmt8OTWq?=
 =?us-ascii?Q?srYHpHur1xcYzWUj6xnH0xtHShms0/sIiwVYU/veCBg8c0xndBW9+7ax2Ki7?=
 =?us-ascii?Q?zes4vOaiLA4aKx22wfaXXn+tY9M8A+O1ejCtwkz2fjZpynW8iam08eIwDGpX?=
 =?us-ascii?Q?ymVtYciePZTTMTlq5imRn4Y5CoqAjoeWv31pFhixneG/6BiqRHOIJgu/k2sE?=
 =?us-ascii?Q?L9YEX4KjaXo5/bD7GkatfduqK9NMx2H88/MO7ZZJWaEej6PV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f2cc1b-64ea-41f9-d277-08df25cc8804
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:09.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9NfdAT3D0yt/9ScrBfkpJmcT5bw/thH+1/qZHssOd/a/hh/QYgWW11TJNOsaDTkbRM46YKHV1ZuFBsm3EQNdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, September 22, 2026 7:14 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v5 03/27] cxl: Move component register defines to
> uapi/cxl/cxl_regs.h
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:16 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The CXL component and HDM decoder register layout is spec-defined and
> > is needed by a userspace consumer that cannot include the private
> > drivers/cxl/cxl.h
> >
> > The vfio-cxl selftest
> > (tools/testing/selftests/vfio/vfio_cxl_type2_test.c) builds against
> > installed uapi headers only. Move those defines to a new uapi header,
> > the way PCI register offsets live in uapi pci_regs.h, and include it
> > from drivers/cxl/cxl.h so existing in-kernel users are unchanged.
> >
> > No functional change; the GENMASK and BIT forms are written as plain
> > values as a uapi header requirement.
>=20
> I thought we'd fixed that these days...  And indeed we have see
> include/uapi/linux/bits.h for __GENMASK() and include/uapi/linux/const.h =
for
> _BITUL()
>=20
> Both are in use in pci_regs.h for instance.

Thank you. I think I missed these. I will update the file and the commit me=
ssage accordingly.

>=20
> Jonathan
