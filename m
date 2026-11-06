Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793968842;
	b=WQD9/lnv/twz6U5i1hTJ7JdZX5EeaKpVIv9WLRduyZwv6whD7DaFvWW9I+/Y0UdX4/tr
	 Am+20UB4aFQ7Bo3tVtsL47v7AluRiPu8kaqg+VKgrEI494j0UEcXSg+nXQvFhgDCw2q5E
	 G2VdxvqaEAIsbntEusKsREzpmUx8+HNwoP1KESDpLb4M5fBC+MlZZ269GAbprXq1pnC9U
	 cTzNALKEoedVxWX95WbG3nvI+nySv/it4GTHGcFQuwxK5ncyurAgbwntuM7vroFk8E84M
	 /jEHxl0H0+qnc7074LYTex8cKI3Zv7iMsPj22qaZr6eJU7z61FDT7g0YxQNxWb7QHxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968842;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=N5D3y9IC4PPIpsHzhYq0VhtxWEfuISNFO0DXA3iQuz8=;
	b=14Yy0p2D/3U6BSW7YvnQWrQWhpxOOUctqALPNvCOZ9XVTr4wCAa2Js540YUJ/LCGXCG0
	 RGtKcHvIfAGdGy/IYtbRH0zfOmLQX2DbFSSml5cwrHQSUiPhBkhlqyZtvJkFtJbZK7xGp
	 CublTrmhM768fZ7AeJptSxjcMWiKk/S4sF3sDYQAfwMb9Zy8Owe6J5ZWeUMMiMNIb1YE4
	 htZXUb2yAYyQO412lFw/30KJDdHPOJA14WyV5joy0hiIq1pX80D2aXGS4IFhx3QaNE6eq
	 8juodFM5rlhMlItyaJNQATugQdcJWg+5hSiQcUgsd7mU1KhAyQIdumfHQH8BQH/Rgjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ct2t2lM9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB9606A329;
	Fri,  6 Nov 2026 12:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDB9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ct2t2lM9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIZ0KnX94Dfe5a3mPTTQRowmLdPnWnCFcJ85S5nZq6KsHYDAXn1rU9e3yARcA8G5AX8SP32T7e8PkoFUvi8teNt+CXVExPUqz0PtLVRBS1L6vrX0kjuXzwwDRozcbfYj0NwXLCR19fEgQlQyIEMsvII+GQv6o8VBdw0mdWUt1CBCI73bcz1lx7ZCxK9GRPLIjjpktI4vHRDrtXfqlqooP4Ut6u033PFnze73hFbqlGaaw6XAZ7Qj9S7XxTXI1TZ6eUbTiKMt1ZP5TiXOc2GcjTFCMDP5w1XgJ8iBUuYdKsYZMhzzBy9toBt0SoXdevw9JnJaGGN96CUSNZnTdlJTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5D3y9IC4PPIpsHzhYq0VhtxWEfuISNFO0DXA3iQuz8=;
 b=vGkGitdY3HDm1nMd0RWHZVHIIrQz7VBTHT+38xqD/+2L+BdOkafK190ayk61itoCA0t8JkCW07cCeu7hxcpN3EGjcUUrS4TP2xDtu0y5IIGSA1oMp5XLetUGxdZfuAfsZKHG3FOOpTAIejozOW4IN8AztF4xuaI4grSr6XqM86VhSYhwJ0mq1TR35CbZyNoTZn+JmnxBRExs3Z+zFzoF5xLD8dW/sB7CVOV0QftvyX0hkHtxBaeimCJQte6iFEULi8OMeYYg4h6A2D1y0lXq52hqKX8cGjObYbQ6p2COq54qkLzzYYgCqm7GAfcOKWtBq3S7abEa1uLa9rtOd2C2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5D3y9IC4PPIpsHzhYq0VhtxWEfuISNFO0DXA3iQuz8=;
 b=ct2t2lM90bbpXPLBoj6mxFiaxVXfF9Jk/rnF/CcBhPd2V8sqB1ZpDuvFJUqdvvtD6cp6QE8Bbv0rp/ghFnR+S61SWJFIW1Yu3L7LThgu7TNE3B/BUbpORkUX2QK7d1Cdav5JK4gKM0NXSk3MbT2aEr6Gv7lYutgjn8O8Kp3FY5ixdbc5REB2o+f956ccahVrytOjvGfn9IBsMg1URP+OVlhfToRzkOQbSrhkzEON6QKfHTUO5yhB8pJtIz6xRelML08PVryofkV/w0pmXe9F8N7U32NSMAH4SSSez65MU2/WqzrKiZ0/pm9fECT+vaw0nmCAuC22o2/dGGHQ0U1Z9A==
Received: from IA5PR12MB999278.namprd12.prod.outlook.com
 (2603:10b6:208:603::24) by MN0PR12MB6247.namprd12.prod.outlook.com
 (2603:10b6:208:3c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 12:38:36 +0000
Received: from IA5PR12MB999278.namprd12.prod.outlook.com
 ([fe80::a2b2:ace4:2cb8:24be]) by IA5PR12MB999278.namprd12.prod.outlook.com
 ([fe80::a2b2:ace4:2cb8:24be%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:38:35 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Richard Cheng <icheng@nvidia.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "terry.bowman@amd.com" <terry.bowman@amd.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "brads@mainlining.org"
	<brads@mainlining.org>, "lukas@wunner.de" <lukas@wunner.de>,
	"rrichter@amd.com" <rrichter@amd.com>, "gourry@gourry.net"
	<gourry@gourry.net>
Subject: Re: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from
 CXL
Thread-Topic: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from
 CXL
Thread-Index: AQHdbTp5Kg+4eVi9K0++/+gYyidN1Lcg0o2AgAAiFzSAAAZmFg==
Date: Fri, 6 Nov 2026 12:38:35 +0000
Message-ID:
 <SAWPR12MB9992676C0AD7255BC8D9A6BD4AB0762@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
 <20261105152909.53452-4-ankita@nvidia.com> <au2j8EmUZmyeNs1h@MWDK4CY14F>
 <SAWPR12MB999267C601F3B004A274DE4A72B0762@SAWPR12MB999267.namprd12.prod.outlook.com>
In-Reply-To:
 <SAWPR12MB999267C601F3B004A274DE4A72B0762@SAWPR12MB999267.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA5PR12MB999278:EE_|MN0PR12MB6247:EE_
x-ms-office365-filtering-correlation-id: 319ecc71-9656-4809-5826-08df3c02e01d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|10067099003|22082099003|56012099006|18002099003|261022105027099003|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 nb0z+ohTdL82VTVj2M9X/cmgcrHBt9RxS8MC6sT8Kk1Uzh9fog7tBKOHr1ZLjm5h3dch1Cj98yTLDSfT8r3wbojYz12TFsPVnHyI19MByeTrwy4p5ZCEfzzSxdhWG5kv0FY6twyaKEREyGqlrS6D31g0zOZi+aSmNk/vvYODuMgddjVcX47/PskevFsMOElQar5R8yMGm5HwJQsaRud7Gno6yOfZ6AnMMi45+YIVuMAGCqR5Wrg3pqxBXNs4x+oEdEU19+/ZSBiXXarbSei6K6X67IuoqfE5hJp8PvtlI1IW8NKMc8NshgX58Lh2DU3aE3bCoC/poNPmV46bkXAonMKUFq/O3P/wB8TeuAiMcOxhK+FL0lWDRlmRYE9JxC6H0mlLSqMi32Iauxn8TR+yCbDdw/Y1hyIvWKgZy+vmNMf+4qiTQfcGVar3UPd15A0psKkIQ8FJHTyAzgRqM6QLwZdLFDXv6hXdmvweSNKQGxttvp98jHsGDkjLPyBJnQVbHd4tjlBKCkyxLadQMxqKm4DEiykKHkhsc5S/BPCn0wmAKZ7MUm93nFU3egaSHqk4ZETRnVN1j73ilcEkAnFheTtcRFZOqCqvEqyZyIILJiyx5NvC8sK5qOi3+vtjHy63UWnpAU21OS4ZcGnkxj0sQffR8wgixcXnwjv2Np+l7YDjBMsRmKKWrxsGZdbDGoUZcsdvk1JFyRdjkzNs/87vLmwmOB+UJmTUlc+zu8eQaCs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA5PR12MB999278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(10067099003)(22082099003)(56012099006)(18002099003)(261022105027099003)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6GQBnxsIV6Zh1mSlMosZkHY1MMlz2Q/MNYCLiOWZhB4eC2d2hYUkA5wonl?=
 =?iso-8859-1?Q?NcnRz4OwfaHwdGY3aABRPqbKBcXidijS50VYzV1w0PzDRgWdlHqeQLCLk0?=
 =?iso-8859-1?Q?U35G8JU1rzL3EmC04/bo1bnIQ+oPBeMk4XB9Bb799IHg3C4S15F8g2aw9S?=
 =?iso-8859-1?Q?+sBQ8X/jR7q/g4MeDfGC8t59uxnVYmiSQt3l/RhP/k/fuyxrnV9gUod5ku?=
 =?iso-8859-1?Q?oRlhFtbGnPoDTPruadinVqezIYjgks6JxRuPtXoWye7PyI/x7UHNOEJ9uv?=
 =?iso-8859-1?Q?OwpnDRxfxfLsaVw0Kr03Hul9pMOmL3FszFV+G5boyVs1ViUwP9GvM4Znr+?=
 =?iso-8859-1?Q?9y+kn1ZPcyiPO5+aplCxh4ABMCV2OLTUB7isYqWrh+QU2jgwLQY5WdQwiI?=
 =?iso-8859-1?Q?d+JqqueKwqtrSmkJ8/eeJpxB9+uc2OWojZapaRIdZAfzI+Pe8Y2eFVd+0G?=
 =?iso-8859-1?Q?w43C6ixgQsTr4TBfiUh/bkE0RiE1U0DyiLwstnYWNyOnwgIyxRUOI7Px+2?=
 =?iso-8859-1?Q?yTkcx6AQyhsz9z2yjDAu57fHa9l4BuFqifFdTpO73GWMhzdN0yIFFkx2Oe?=
 =?iso-8859-1?Q?Ev6f0HwfnDv8nndXBYPeWNoK9f97DKGkvxAydyNKDXSlxfGZm9whTzxxhg?=
 =?iso-8859-1?Q?n7B6mzxUHwLevmJ1QD820vAqGaiAho80xjl50rRvHPdXdFSpFbJy7Ju+Qu?=
 =?iso-8859-1?Q?jmLyi/frc1StrY8oqunqdM+Pz6e9YwtGpT7GJh3RHP3VSQFRDVLO3VXRUu?=
 =?iso-8859-1?Q?sO5HHmtiJZTcHMx4xFOEcIeGQCYqunmOaiUcCatReuaIxiJI8Q3WK1y+0R?=
 =?iso-8859-1?Q?E4KQSZ7gEzvbKbX5PLuI+UfcVPxSFQJCsPFTlMii7a5Z3AV6+7l/mgiern?=
 =?iso-8859-1?Q?U4n4S7LfowVQecWIKLMxapY8ZiFB8NdnRimK1K+GSpzQSYc/7rrrpgf8Kz?=
 =?iso-8859-1?Q?aQXr/H3Lhqy3nvJjzwkTteOEyo5JAeaZexPKOQZwBHEuosM6eVkMHRMWPd?=
 =?iso-8859-1?Q?4ZGjQuUh7CmklkODpCPLxJJ9z4LzIx5lXLFtdOt/8/jDqOGo31PDHc73NB?=
 =?iso-8859-1?Q?S6DspZY/dCJwxvazshNq49+hnyPnNUckFjLStUgdmdFGqjWe3fHwteQ4/z?=
 =?iso-8859-1?Q?nguYB3n+hPvtgDBJ73/O4mZr2AV59RYbYqWhwXbNR0QmDp8CfohiUYelIG?=
 =?iso-8859-1?Q?sVouaeAeR6ILrXpdbXWnov/ZzuNC+yLejHQCLrKbD57fENopSr+yc/lSR0?=
 =?iso-8859-1?Q?XuSQ4EOUDQq5bQTE0ls+xKYsa+/rQ65blwYZF+G4Z3OcVDyB4kfuAsa4tU?=
 =?iso-8859-1?Q?81JrC8nTArrFkdlnto21Zjd+HMkVzu7rXyzrgN3JJ28ovWgNxh7Hx9gLBV?=
 =?iso-8859-1?Q?GASR3EixlOof1Sdjabm7mXLQ5YBHjlfMVZO2Cm8GsY6vPRWfLnMXIwGaki?=
 =?iso-8859-1?Q?btVJianswwf4rRfK7Aq1bfs6n2iuqBanaek6DhskWp0oPvox0l1zuDDG8k?=
 =?iso-8859-1?Q?HvKI0Fb/My4cqKP/phuOOnMNakPfliUYzOt/RQg4XRHQwiaYt7I2/ndyeC?=
 =?iso-8859-1?Q?UHexwsrrbZqzL9vsULrC/VTiahiaL1OZciHuKjL81youp/wFqwaTZH7QgE?=
 =?iso-8859-1?Q?HbdNSjD7reBQBdxAVjW8AgqdHCJcb1cKMwCL8Z7hlUitk+Q3HJ7HzdU2T9?=
 =?iso-8859-1?Q?upt050IatXS5GanEUhEPWotPv+e8Mh0E/Lv4PgfMLEY5ejl7/7+maoyKOy?=
 =?iso-8859-1?Q?N8T+NWRoJS+ZXQDmlU+pY4V9kwglvbseUvav0/p9fYuC6h?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-AuthSource: IA5PR12MB999278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319ecc71-9656-4809-5826-08df3c02e01d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 12:38:35.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD3K9RD2PmvObY+AI/ABu0IfBhP1tJd3s0tLrIS2WIxWT1ci+S65lmcs6LcbgP8BiHkkayE+YXuqttUEltLEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247

>>> +=0A=
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reporting=
_bar_base =3D tsm_offset &=0A=
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ~((u64)range_len(&wi=
ndow) - 1);=0A=
>>=0A=
>> Hi Ankit,=0A=
>> =0A=
>> HDM decoder window can have non-power-of-2 sizes, why do we assume a pow=
er-of-2 size for=0A=
>> coherent window?=0A=
>=0A=
> Hi Richard, yeah the region base calculation needs to be updated=0A=
> to correctly determine the CXL region base for the=0A=
> non-powerof2 sizes.=0A=
=0A=
Just to add, IMO determining the base IPA of the CXL region using the=0A=
interface report does not look straight forward for this case. Trying to=0A=
figure out a proper solution. Missed to mention this as an open in the=0A=
cover letter.=
