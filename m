Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029905;
	b=CN/eF+WBCJz5cGswhy9v7nxDIe2+qLEXCb73xMMXGPA8sM6RLF+t9pz1zvdI5HppuJbO
	 fYqPzkM/AWvhIFVTLuYjrtFtaL5ANT402Y3+GMJ1pmqdpLjChdfR/yrC1QX+J6pwREsHi
	 sDPjuU4c4oPYzvwqf44BkmHK4/AnWLx6kEke7lG1G0GkQPevczlrj8g/PMV6/UPP/q94n
	 kkgwa4QtQiw815wvEj6wkW2mNH6wq1AKAWbayfm7lTLpNgBvKTvWW1/SVEbfDde3tXpCF
	 ZNDRGAczocK0RY+XIW+N0nAZZIdtPUpBNZ6dCZpP8SCdpPoZL8WTz6DFwuISl7Gyyew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029905;
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
	bh=p0ckIBSLWBLs5a0fo9yBcCJh7aYmg2JGCZaqim8FE4E=;
	b=adcyFGyhYzlUcGoQ7u1DTvaXtCwUqGBCcKzIdDw/IeGvCKY8t6PiWqNUJ7zNdD9DyZyv
	 I2OHNs+1pGXyd5FVL6Slsf2H+Iltm//sei5xEs5FpRUMgU08FmDhoeB53+Aluz36kH/hz
	 KsuNIxZozzokL4HcTGqAjZSi8iF1l+6mIxtgmxiSNQFG3m1q4e2fB7JUMC6I9BUPS8AYz
	 X91vNnfYHgpn1ckEuZYTJcKyOkL8VM9njhTV7i05e+2iTjfNamz8vxQXykiSdG/dTfTAa
	 sDe/+cmeE/6yTpg+luqRWyLjtzme7I/1WCoL6tIGWsmUomYVS/j6UKvPYxK5R/x9+HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CS7ipwqy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E2606A334;
	Wed, 18 Nov 2026 19:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 907E2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CS7ipwqy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJEGLsiy8SxzD3xdVWXp9+syXjCsYLj+9FVcd2/Z10D/e1M13qtOr5KjC8/6xAUOmzXPWfbFhJBhS6T9POOiv0dR3kfQTUaDSiH8+lVFqCO3sNjU2iRHbPkwR4VeRc4x8N5ofNvt7HnrtgJnN4BYXIiiTyujXW8p7nxWIsocy49y1AhKbnvkVb4BweoMJPSBtWxMjizzQjj75Dg7QpNbALPuVvWfe86IENS/JY/LAJdLpig3tQStuLVxAr9NLer9Pc1WQhXWlvRzCjspDNuqY2lVtJZGITAJvy+yHh4wEkEiQxY5yhY+r4sKGkZhMELKqz41ixuj/4eylRxkZgoE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0ckIBSLWBLs5a0fo9yBcCJh7aYmg2JGCZaqim8FE4E=;
 b=es80TZkJ7iSAP6IJaSBa/QN7JOw5pUX81DlNrRlRNgaZaiFL14DW6O1DlUA2gRBo96w2HQlH29jjECL5PFNk2Cy/EnufyJZMTWnrXbGPl5sm2gv3Y4zq0pnJcwMsiE/0qG4ZA02Ln7UFm/3l/tqZwl4Bjz7v3+G6hJuQ0WwdpJSdqLR2E2EQAYPNjt68ArtpW4yLPMM8nusWJxaQg+yp/DZqTOjQ9w7zpVIHawjywb8kiFAHtbJm+Z5QLC6ljeXyLXweu0kPP12z51AAvG3897qikYSOre6lbFxIDBByaS8XzGul7vng00E62xH3FI8cThuY7b/sUqOWSBGMDLJyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0ckIBSLWBLs5a0fo9yBcCJh7aYmg2JGCZaqim8FE4E=;
 b=CS7ipwqyuZvvWpoAMmASkU8s3HBkcuN7lnVoHZ2rVHe/OOlsmrKYXAHNX8letYGjuKjyTLIMgyw39BQy0pXoES0cclSKhEYVFOWs4rEH6PBnasD6ZX4PCCrpp7kOC5oLIcZuT8DnQ7srMNHNSKf1Wgqq+AX8cQOW5a+YMem8imtS1yalzRdGR6HjLx6ub6TT18dijFysqCocfsobTm7bwZdAP42lF4mBEQW+m7CkhzHHSgZwjlpOG9O3Rv4EoeQoRGq8b96nUI8jp+3VBt6DO6VOLeadHYXd9OeTkY909ksSh0TcreWdkVy9qD2Ep2QSQIv1Nty+PvTGrm0gTPxYEg==
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
Subject: RE: [PATCH v6 15/31] vfio/pci: Route every reset point through a
 try-reset helper
Thread-Topic: [PATCH v6 15/31] vfio/pci: Route every reset point through a
 try-reset helper
Thread-Index: AQHdXYpzlycI4IIptEyBvFxe1YDKw7cetBqAgBWkjdA=
Date: Wed, 18 Nov 2026 19:24:48 +0000
Message-ID:
 <IA1PR12MB9030983615B465CF53B80489BD7A2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-16-mhonap@nvidia.com>
 <20261104165247.2597f574@shazbot.org>
In-Reply-To: <20261104165247.2597f574@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB9455:EE_
x-ms-office365-filtering-correlation-id: 445f3b94-5046-46a7-a7d9-08df45a99ec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|38070700021|261021123027099003|261022075727099003|10067099003;
x-microsoft-antispam-message-info:
 8RDw6pNUFr6R9HRzASnA0d410o722aeCLhfHfo28pBHzy8Ty84LNqXijZwnk9aBzN4IV8XHTYTmMgmcv6/x+NijsVMsXT9HDTUh9rolUVrp3vwooWSH1Q5Cnv7n9lo+FkHBb4k+jolOewqcdwx+WvvhfsgCiGu7q18PyewLJpTrTuTOyqsExnlB78Xk8o0Jt4n48e32AUV2KTYhe645XzkVIgmgOiADKJ3ij5dTCVZTXaiPb08jc51EFT6umM2c81yGsA+cxGYD+vtWxaEk3RnFhgfV050vIocjvnmvwRmV8803eyLJd4LlUj2BNcGppNEWrkNLJf1V0PApPZJ4EU5zv0jU8xGtnfsEdc0m20kuwGUUqbX7kHAvdiPB2cjgyAO76+1LmoIQLe2grLgPCMy/E2dKXdAsUhYgsvABLxdmFUSNPzen3fKG4yco0z1+nNJFlDHIWLAgLDwbOpHMpl0xgIFWpDykIqFeJVFE/rGe0m41KH8uGuOeaagsGjNc9DLZ4O0FQyMHMMcKZFhLtHJU7YdHivO0EPKgR4jKtHqK36wSgGeQN1c/L4HGavNEnRiuVXG+xxhvvXqHK9SOyum9NV5161EsnCHiAkX2Bb3W7VC4lCmN5uHKL2wS/5jDTQNNi+an9MFhPxfyrjDXQFTpKIEAxg9zKCBW/oL3MyIaqH5g4ZmZSfa9Cbi1xKlLZCS/qod427SJRxoFenpMqRCyTE1CXHCeIZFrx5Ssq+mQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(38070700021)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9Kq7c0tGHHglGFUSXKtDV1ffzpMUQ60jrWU4L+azRxU1BiPntpRE6uLrUZQl?=
 =?us-ascii?Q?fGIzgymRkxsI5Tb34jzWX+r5OUAZfkMxi3IW+iHhFqYSZtvfFDR4qJEwPOlB?=
 =?us-ascii?Q?W+kqyzhJYjzivDMzxKcupJ//xjcrzxa4agIKaNolQwf4zRBrDakoQh2ntE8E?=
 =?us-ascii?Q?do+ycDyM4jGoCoy6WkbjH06R4JlAxwls7luxJjPQUwP/2tOp9XET3HZEWpAB?=
 =?us-ascii?Q?4vIDpE2SpYWFx+4Omhcu6o3e4T/ZDZafb8T1FRS9/MN/7TmYOohgRtx8Dlve?=
 =?us-ascii?Q?0pO0DgomKRovFNbBwDK4wymCZ8wgGngez3eWSwEEay4UVH/zYEARnoBRmsNa?=
 =?us-ascii?Q?/jt7At28htznFG2lLccyl1HBZnDfD1bgML7u2dY7INMU+NgyLIJTisxI8GTN?=
 =?us-ascii?Q?iC8G5jVMJtW+W4wX/dH3nT5J5FJMfBJnuaStniR/LgZ3YiMRn+PlimUUufSQ?=
 =?us-ascii?Q?KtCE/ey9jXgKAZQg1elsQeXT8TP/xv+ufV6QEsvfA9iOEL3K94+ypc0dhEdb?=
 =?us-ascii?Q?41Yg9hIBm8hB1wzBq0bOh85K2z7XrnWq5zrTt3NMi6b50QIdZY63sIUm1zQ7?=
 =?us-ascii?Q?m2VtPveZH5RoDSfchsI1OX8u3nAwO7zI1Kw4zIah67FOEkPc2cbszeoguT7s?=
 =?us-ascii?Q?UZJ/ghQS8XiSCSJ3uNDu6AEaEoolnARQCxhJMCScdZpc+GJTBxSyhS4hmz6O?=
 =?us-ascii?Q?eixw3we2TmFR48ZPVHsIl6wBhKZBxrcV0g3sMll1LV5hsgcg+UikBSeZByuK?=
 =?us-ascii?Q?tMKi0c/R940QZzC/M/Rr5dCefP6rKy2vZWqifmMY896gGDWc1AE5pwFATuFl?=
 =?us-ascii?Q?9wl+fZN+UtjLoHOD0vRyHMU8KpmOz1HMSCdchnR/nececAjclQn2K0HYypVU?=
 =?us-ascii?Q?JSZbiJ5/zKpR5pZjiH+XSSIJIEr5uBvG2aJMLWGmX8kav/0RwM3CaJtx7omQ?=
 =?us-ascii?Q?r2Y5YVk0JqWd5r0Lj2rQhv5UGBUjZuyNJhdCyWhtZnzyHlw5sxZ9vxqCJLrA?=
 =?us-ascii?Q?Dd7/+WWQV1GrBdBSn9a2C7D3N+mN4TesTfh6hVMu4IljyYBjxDwyLjt5UJ7A?=
 =?us-ascii?Q?B2Q3uUgHoOYEhqn4XAoP84UGgmw18SrK6OW6Bbw4amilFyTuMQfHPzjg9I2b?=
 =?us-ascii?Q?cd14P7YC6wSjoE478bcdlo/2UkJOSwJYVmWFPBonueuCgUDGS72Ws8SD8e8N?=
 =?us-ascii?Q?YqF7JxnmKodVEmlYjLJ+KQ7SR8rfn9BAdYEJ1JgnLx7KlCZ2zNzU2wPoPsx4?=
 =?us-ascii?Q?2AARszosYj/vtL4YeIzBtoTavxAqh+5qs2aW1RSAxeIMP6INt/3BIbmb547C?=
 =?us-ascii?Q?jmnjL9gTM5NeVDWX5lK76Km5KNPyl6qzXi/I0b6fsIkRqjbSgwXgc/5IV5Xy?=
 =?us-ascii?Q?y8jaiB3eSwPTsU/V1joDufVAI1r4qACCGYSsAG23etyWkTeBdpoUjvPuLPBH?=
 =?us-ascii?Q?ndYjG/0bXE7+SbbYHnDS/DmAfRWLkQCPT+4qxM8pVfnE3YNBnUyqlSP/Iqj6?=
 =?us-ascii?Q?UgTgi6Z8Ys0Q1FFOs6imxwYNLx5S12mA3esa2L5JyW/DOMvjCVuDQ6oQEtr1?=
 =?us-ascii?Q?PnHasTyn0PFNaIVpfZPcOO0JPdp2p30gI0tGyuY0u4gsOLhidGVa3a57Ks0i?=
 =?us-ascii?Q?XLxQ5BwRSSpWZYMtKsT8k9ppgvuicwiGRqcXOAbCNSOWdJ11n1hnFzMowLy9?=
 =?us-ascii?Q?ueki5qir/fKlrR1w1JY4jW1AQNtY+V6DVz//PfK0quu2ry39?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 445f3b94-5046-46a7-a7d9-08df45a99ec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 19:24:49.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hvmq/YwKRSH7+pJIhKv7Vn5it5izvLrzLT6Rjxdo2KtSI32Qks5yzLGJT1rZgLpySPlWnDMGcd+l4jrGCa+qg==
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
> Subject: Re: [PATCH v6 15/31] vfio/pci: Route every reset point through a=
 try-
> reset helper
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 16 Oct 2026 21:48:22 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > A provider such as vfio-cxl must reset its device itself: a CXL Type-2
> > function must not take an FLR, and its reset changes what the provider
> > lets the fault path map. vfio-pci-core resets a function at five points=
:
> > enable, close, VFIO_DEVICE_RESET, a virtualized PCIe or AF FLR, and
> > the guest's CXL Reset doorbell in the virtualized CXL DVSEC.
>=20
> What substantiates the claim that a type-2 device must not take an FLR?

No, this is a wrong claim in this patch.
This statement is wrong and I will drop it in v7.
As per cxl spec 4.0, FLR only affects CXL.io and does not affect the CXL.me=
m, CXL.cache,
CXL DVSEC state or the memory controller behind the HDM.

>=20
> Here we're promoting all resets to a CXL reset, but a CXL reset and an FL=
R have
> different scopes.  FLR is exposed to the user through config space.  A us=
er might
> reasonably expect an FLR scoped reset through the PCIe/AF capabilities.  =
The
> CXL spec defines FLR vs CXL reset, so this actually makes the device non =
CXL
> compliant through vfio-pci.  This is a massive policy imposition.
>=20
> What makes this necessary?

Agreed that this is changing the already established policy in VFIO.
For v7, I will address the reset as per scope the spec has defined.

This is my plan:
- A PCIe or AF FLR written to config space is a PCIe FLR in vfio side. For =
a
CXL device, vfio-cxl will run pcie_reset_flr inside the same save, disable =
and
restore steps in pci_reset_function.

- Initiate_CXL_Reset written to the CXL DVSEC from guest will be a CXL rese=
t
routed through pci_try_reset_function(). cxl_reset series orders cxl_reset
ahead of FLR so that method will be run here. cxl_reset series also perform=
s
all cxl_reset's with a mem_clr enable so we will also have the same effect
in this case and guest's own Mem Clr Enable will be dropped and not passed
on to VFIO.

- For open/close/Reset ioctl, I will call the same PCI core calls done toda=
y.
For a CXL type-2 device, those will be cxl_reset with Mem Clr Enable.

The cxl_ops reset op, this patch and the owner-aware entry in patch 04
will go away. vfio-cxl keeps only the work around the resets vfio
starts: it revokes its memory mappings and dma-bufs before the reset
and reopens the memory after the device reports Memory_Active again.

vfio-cxl also holds the HPA range exclusively while the device is open,
and the cxl_reset method refuses to reset a range that someone else holds.
So, for v7, I will release the vfio-cxl's claim on the range and release
it around the resets vfio starts, after its mappings are revoked. The claim
will be taken back before the memory reopens. A sysfs reset of an open
device gets -EBUSY from the cxl_reset method.

>=20
> > Add a mandatory reset op to the provider ops, and refuse to register
> > ops without it. Add vfio_pci_try_reset_function(), which keeps the
> > trylock of pci_try_reset_function(): it returns -EAGAIN when the
> > device lock is contended, and otherwise runs the provider's reset with
> > the device lock and memory_lock held. The close path keeps its bridge
> > and device trylock and calls a locked variant.
> > vfio_pci_try_reset_function() saves the PCI state first, as
> > pci_try_reset_function() does, for the provider's reset to restore.
> > The locked variant does not save: on close the reset must restore the
> > open-time state that vfio_pci_core_disable() has just loaded. A failed =
save is
> returned and the reset is not attempted.
> >
> > The enable path still fails only on -EAGAIN. A provider checks at bind
> > that it can reset the device, so reset_works is set for a provider
> > device whatever the result of the first reset.
> >
> > The CXL Reset doorbell now runs the reset and reports its result in
> > Status2: Reset Error on failure, Reset Done on success.
> >
> > Suggested-by: Alex Williamson <alex@shazbot.org>
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_config.c | 19 ++++++--
> >  drivers/vfio/pci/vfio_pci_core.c   | 71 ++++++++++++++++++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h   |  1 +
> >  include/linux/vfio_pci_core.h      |  7 +++
> >  4 files changed, 90 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index 1fc463540211..6fbece95cb9f 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -910,7 +910,7 @@ static int vfio_exp_config_write(struct
> vfio_pci_core_device *vdev, int pos,
> >               if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> > -                     pci_try_reset_function(vdev->pdev);
> > +                     vfio_pci_try_reset_function(vdev);
> >                       if (__vfio_pci_memory_enabled(vdev))
> >                               vfio_pci_dma_buf_move(vdev, false);
> >                       up_write(&vdev->memory_lock); @@ -995,7 +995,7
> > @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, i=
nt
> pos,
> >               if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_T=
P)) {
> >                       vfio_pci_zap_and_down_write_memory_lock(vdev);
> >                       vfio_pci_dma_buf_move(vdev, true);
> > -                     pci_try_reset_function(vdev->pdev);
> > +                     vfio_pci_try_reset_function(vdev);
> >                       if (__vfio_pci_memory_enabled(vdev))
> >                               vfio_pci_dma_buf_move(vdev, false);
> >                       up_write(&vdev->memory_lock); @@ -1786,9
> > +1786,20 @@ static int vfio_cxl_dvsec_write(struct vfio_pci_core_device
> *vdev, int pos,
> >       if (!(ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING))
> >               status2 &=3D ~PCI_DVSEC_CXL_CACHE_INV;
> >       if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> > +             int ret;
> > +
> >               ctrl2 &=3D ~PCI_DVSEC_CXL_INIT_CXL_RST;
> > -             status2 &=3D ~PCI_DVSEC_CXL_RST_ERR;
> > -             status2 |=3D PCI_DVSEC_CXL_RST_DONE;
> > +
> > +             /* Run the real reset here and report its result in Statu=
s2. */
> > +             vfio_pci_zap_and_down_write_memory_lock(vdev);
> > +             vfio_pci_dma_buf_move(vdev, true);
> > +             ret =3D vfio_pci_try_reset_function(vdev);
> > +             if (__vfio_pci_memory_enabled(vdev))
> > +                     vfio_pci_dma_buf_move(vdev, false);
> > +             up_write(&vdev->memory_lock);
> > +
> > +             status2 &=3D ~(PCI_DVSEC_CXL_RST_DONE |
> PCI_DVSEC_CXL_RST_ERR);
> > +             status2 |=3D ret ? PCI_DVSEC_CXL_RST_ERR :
> > + PCI_DVSEC_CXL_RST_DONE;
> >       }
> >
> >       *pctrl2 =3D cpu_to_le16(ctrl2);
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 1e0ac28b7564..6676c561465b 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -605,6 +605,62 @@ static void vfio_pci_core_unmap_bars(struct
> vfio_pci_core_device *vdev)
> >       }
> >  }
> >
> > +/**
> > + * vfio_pci_try_reset_function() - reset the function without
> > +blocking
> > + * @vdev: vfio PCI device, with memory_lock held for write
> > + *
> > + * Reset through the PCI core, or let the provider reset a device it s=
erves.
> > + * The provider resets the device with its PCI device lock held, so
> > +take that
> > + * lock here, without waiting, as pci_try_reset_function() does.
> > + *
> > + * Return: 0 on success, -EAGAIN when the device lock is contended,
> > +or the
> > + * reset error. For a provider device a failed pci_save_state() is
> > +also
> > + * returned, and the reset is not attempted: unlike
> > +pci_try_reset_function(),
> > + * the provider's reset needs a valid saved state to restore.
> > + */
> > +int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     int ret;
> > +
> > +     lockdep_assert_held_write(&vdev->memory_lock);
> > +
> > +     if (!vdev->cxl_ops)
> > +             return pci_try_reset_function(pdev);
> > +
> > +     if (!pci_dev_trylock(pdev))
> > +             return -EAGAIN;
> > +
> > +     /*
> > +      * The provider restores PCI state from the saved copy, so save t=
he
> > +      * current state first, as pci_try_reset_function() does. The loc=
ked
> > +      * variant on the close path must not: it resets with the state t=
hat
> > +      * vfio_pci_core_disable() has just loaded.
> > +      */
> > +     ret =3D pci_save_state(pdev);
> > +     if (!ret)
> > +             ret =3D vdev->cxl_ops->reset(vdev);
> > +     pci_dev_unlock(pdev);
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * As vfio_pci_try_reset_function(), for a caller that holds the devic=
e lock.
> > + * Only the close path calls this. It takes memory_lock with the
> > +device lock
> > + * held, so user config access is blocked meanwhile: the order a
> > +sysfs reset
> > + * uses. That cannot deadlock against a PCI_COMMAND write holding
> > +memory_lock
> > + * because no user remains at close.
>=20
> Please tell the AI not to add any comments, these are difficult to parse =
and
> often unnecessary.  If there are specific locking requirements for this f=
unction,
> they should be annotated.  If this function cannot be annotated, and it n=
ot
> general, even within a static context, maybe it shouldn't be a separate f=
unction.
>=20

Understood. I will refactor this part. For v7, this function will be remove=
d and=20
close path will keep calling the __pci_reset_function_locked as it does tod=
ay.

> > + */
> > +static int vfio_pci_reset_function_locked(struct vfio_pci_core_device
> > +*vdev) {
> > +     if (!vdev->cxl_ops)
> > +             return __pci_reset_function_locked(vdev->pdev);
> > +
> > +     guard(rwsem_write)(&vdev->memory_lock);
> > +     return vdev->cxl_ops->reset(vdev); }
> > +
> >  static void vfio_pci_core_free_dev_regions(struct
> > vfio_pci_core_device *vdev)  {
> >       for (int i =3D 0; i < vdev->num_regions; i++) @@ -636,11 +692,14
> > @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
> >               goto out_power;
> >
> >       /* If reset fails because of the device lock, fail this path enti=
rely */
> > -     ret =3D pci_try_reset_function(pdev);
> > +     down_write(&vdev->memory_lock);
> > +     ret =3D vfio_pci_try_reset_function(vdev);
> > +     up_write(&vdev->memory_lock);
> >       if (ret =3D=3D -EAGAIN)
> >               goto out_disable_device;
> >
> > -     vdev->reset_works =3D !ret;
> > +     /* A provider checks at bind that it can reset the device. */
> > +     vdev->reset_works =3D vdev->cxl_ops || !ret;
>=20
> I suppose, but why is ret not still a valid indicator?

Hmm, yes, ret is the valid indicator. I will remove the function so this
part will be moved to the earlier version.

>=20
> >       pci_save_state(pdev);
> >       vdev->pci_saved_state =3D pci_store_saved_state(pdev);
> >       if (!vdev->pci_saved_state)
> > @@ -846,7 +905,7 @@ void vfio_pci_core_disable(struct
> vfio_pci_core_device *vdev)
> >               if (bridge && !pci_dev_trylock(bridge))
> >                       goto out_restore_state;
> >               if (pci_dev_trylock(pdev)) {
> > -                     if (!__pci_reset_function_locked(pdev))
> > +                     if (!vfio_pci_reset_function_locked(vdev))
> >                               vdev->needs_reset =3D false;
> >                       pci_dev_unlock(pdev);
> >               }
> > @@ -1541,7 +1600,7 @@ static int vfio_pci_ioctl_reset(struct
> vfio_pci_core_device *vdev,
> >       vfio_pci_set_power_state(vdev, PCI_D0);
> >
> >       vfio_pci_dma_buf_move(vdev, true);
> > -     ret =3D pci_try_reset_function(vdev->pdev);
> > +     ret =3D vfio_pci_try_reset_function(vdev);
> >       if (__vfio_pci_memory_enabled(vdev))
> >               vfio_pci_dma_buf_move(vdev, false);
> >       up_write(&vdev->memory_lock);
> > @@ -2397,6 +2456,10 @@ int vfio_pci_core_register_cxl_ops(const struct
> > vfio_cxl_ops *ops)  {
> >       guard(rwsem_write)(&vfio_pci_cxl_ops_rwsem);
> >
> > +     /* vfio-pci-core never resets a provider's device by itself. */
>=20
> What a bizarre comment.  Relevance?

I think this was edited in partial and left out during merge conflict handl=
ing.
I will remove this.

>=20
> > +     if (!ops->reset)
> > +             return -EINVAL;
> > +
> >       if (vfio_pci_cxl_ops)
> >               return -EBUSY;
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index 09a68c99b43c..dbede6e24fa9 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -80,6 +80,7 @@ int vfio_pci_set_power_state(struct
> vfio_pci_core_device *vdev,
> >                            pci_power_t state);
> >
> >  void vfio_pci_zap_and_down_write_memory_lock(struct
> > vfio_pci_core_device *vdev);
> > +int vfio_pci_try_reset_function(struct vfio_pci_core_device *vdev);
> >  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device
> > *vdev);  void vfio_pci_memory_unlock_and_restore(struct
> vfio_pci_core_device *vdev,
> >                                       u16 cmd); diff --git
> > a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h index
> > 991a3fcd84eb..cb9ba92b696a 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -87,6 +87,13 @@ struct vfio_cxl_ops {
> >        */
> >       void    (*reset_prepare)(struct vfio_pci_core_device *vdev);
> >       int     (*reset_done)(struct vfio_pci_core_device *vdev);
> > +     /*
> > +      * Reset the function in place of the PCI core; mandatory. Called=
 with
> > +      * the PCI device lock and memory_lock (for write) held. The call=
er
> > +      * provides the saved PCI state the reset restores: the try-reset=
 path
> > +      * saves it first, the close path keeps the open-time copy.
> > +      */
>=20
> Reads like more AI generated comments.  These things like to talk, please=
 curb
> them.  Look at vfio_device_ops for an example how to briefly and concisel=
y
> document callback ops like a human.  Thanks,

I will update this. The remaining ops will be edited similar to vfio_device=
_ops style.

Thanks,
Manish

>=20
> Alex
>=20
> PS - I'm still working on the remainder of the series.
>=20
> > +     int     (*reset)(struct vfio_pci_core_device *vdev);
> >       /* Pinned per bound CXL device so vfio-cxl cannot unload under us=
age */
> >       struct module *owner;
> >  };

