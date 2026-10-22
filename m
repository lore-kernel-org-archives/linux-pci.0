Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667526;
	b=z5f9doYGuFvf8qFE3UXpWZgkkcBRtzBb/fvnkuQL8InkEGJQzxSgx5poKmzM3ZT09CvM
	 VropldYq61NjFpVSnaKR/fsnEoGlklrC+irZDfQ5oIBl0Xu4SpJxNnNTpcBlhjN1fegzo
	 ObbU0Q0X5lr8Wi3AXokcZi6ONc2Vmu9S7lpqXhzeYUSdj8ZCWmw6LNx45OXEAIjqZHeqa
	 KO+sS4oQQ7yfavUw0AcQX8gNzrcq7IwRJ0BzTuTkcRsLiN95+f9J9M2rXpzQ5XxrPiPo6
	 iFQZSeT2MGjMKM9hA50Ab36dTAqYgWYw0HERV+jAiC3Ke71RkFc4RaM2OGJpuGiZkyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667526;
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
	bh=zB1Y/U7PTN4W+vz6ucb9H4vWk8vU9f9P8ckSBjtoT5A=;
	b=bbupDrACfd5RE95aqaEcVnxDEndevds6cklj9EF3F2mUHthunxLLsaMcGCBDdZ6Wq3+C
	 2k1gYGtZuPaR5H4R+P1kJtvtxVFxpv/daBM3gcwocpfu295PYqRcWh9dvaIZ0lJKF98Dn
	 1qA1bl0tZQxDaysp8+oWWXncnsXZWAzkpE1TLGYe7WvUiGqP5VL5kDIPxC/Lb/G6P8Hnq
	 FrpnyWM2lEqJ0+qQGYT3xs6PZRE0ex64n5dupZclKUGUPEYObpJuwhendMDQIsBngEv4i
	 Vf8/3PFiG0NwoyLxR/GnFNgIGsZAtUbi0Jq0iIwMAWhCxQm+OHzpehAiaSOEvZBmk1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ti26wiZc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A020606A319;
	Thu, 22 Oct 2026 11:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A020606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ti26wiZc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaQRsRYCSFZSmU48RkwiWbES/2FNwmK6kUkUG7z3AeScZvVTenQT8Fu4vayXTMdjGLsp9dWZ/Sxys1jaSYJbrMSpQjyi/QpdBWGoy5UBmB1RCoRHtzMcxe4A49L/AE52R0PVSWtFVA/Fa5uTc0xWEZR975n4e0ap9R5UVkt61VdYz4CvmJGu2blv4PuW6IbMvcTplGVmlCb2keS0SgANO0Py44bdrIJZgH4KtYhH3cvTviLYqyuhXIc408MkamAFBBpMyewJSIvND5UdvqfsJZiRqQimbcLqnYbL8R3VzkI+b9hMw7GqdXPMH/kxO+2bdGBY+znUavcpaU1v7gGLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB1Y/U7PTN4W+vz6ucb9H4vWk8vU9f9P8ckSBjtoT5A=;
 b=poSKhplwPT0+BucbFcav0xxE0M8/ZCB9ZtXWGPgO+SLZOkfGsFl+JjiACxMn9Q99PBGwQpUNgiEPLeDggREbbt94k2n/0h2ERp18+S9C8g0SGHqjdFW7OlRFxnkR0H7fhj6UnkLKz0jL+tidZnyEqFrybszx3j+GzTq1lKPROJrlL5hCWXfK3CNB0Q6Lj7blvgFarqqso4SHH3x7YSPkpxo8anjRV4cxlvhU8EYOTKG6gOreZ0YxtFnvXuokVpZTdlawm/h0Hyq2fGwoE4YLBd8FDJJP2uGBQ+Z2IjtqDMDpr4AYomnJg2DCSxuX8zAHcO7ubxqEHFnqwoB1lDsdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB1Y/U7PTN4W+vz6ucb9H4vWk8vU9f9P8ckSBjtoT5A=;
 b=Ti26wiZck8U/3u2fikMMpaZeyBtv8l3fIGC5FucvKAAGiv0Rz88ob6CbDWiu61KRhTtbhDDNwapEc2KFSzL/TUZLhgjWDSNkmGyvKS9zbsb4hzk9bM5tb0gU8yN/XKJgDlAw+RGs1apOr/WpSJxgAyEdJXWP3w4NRciNNJ2LgLk8LLNgL4sqvNZLp1s+6xBOOrp1bX6uc0v2heb/J7KH2qt4FfemjlWILUYlbUlCtDb2VCU+u09LTnNw5y6PCNyTumr3umbtAAGHvHRqDSZtdhqyDLAKC79q2tRgrENrfz2vYEP9kFJNZs29LxeMM8fvnRBm5RY1AFqwCqgvKgZ3Nw==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by LV8PR12MB9181.namprd12.prod.outlook.com
 (2603:10b6:408:18d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:12:01 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 11:12:01 +0000
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
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Thread-Topic: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Thread-Index: AQHdVJenWGflQInJnUi4i9OPVn0EsbcGRAuAgAM91Ak=
Date: Thu, 22 Oct 2026 11:12:01 +0000
Message-ID:
 <SAWPR12MB999267C1AAD24C3DC56302F1ECB0652@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com> <atc14MnbGUcviAhr@MWDK4CY14F>
In-Reply-To: <atc14MnbGUcviAhr@MWDK4CY14F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|LV8PR12MB9181:EE_
x-ms-office365-filtering-correlation-id: 836fbf71-940c-475b-7c84-08df302d4c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|261021121427099003|4143699003|11063799006|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 j/yc3Qj2d/CqP727MWWmSKFueR4WSo5mzTg6TNJN4RALjPyRdlda2kRCJYgtxn1iCiyq1O5g0oyYmGR/ThlXjb2HvPCA3RT3x5b0mxJ1v2W4qFYwplml8rtmaOXFnxe1KsyagYkvkUysR+W4tVAv6BYfudZnVAW8e8O0UArfi9JKH5nWbLETJH68SL8/QSisJHa1B/fhgxzRS9CTNsgiGHNneTQQO5GOu48rCba8v9/yAQOBjNHDOuLbF5FQ8IF15/NJiJf9RknJ4gn11WWOS+UVEg2W0by1PzQU7KimppQXkMymEJBRsH7Vz77QlsdYDEUlhsU/A7PGaXNrCdUcdZPjvbSLqqwKmdXIVAgZv8c4PKO0U84WCvBhHOTLRNWEpjJI82UQkO0gDo4SyOy0qv6v1pdpGx54y06AKN58ZZvI49sGfNv/+j2GL0KusDF6RpEqqqRMLuUXPrioqjNprWGx4f0SWj7+u4r22AIYKTRc7z3CWchvUOB31KrnpQVd1OQSlesOboZjMAb5g0ae8BPwR9ONXY50FQSb+0qtTNML7qlR1FhpSrfsv9lcHo8MIJCFYNJj0sDsX+DzTL6OyS4c8hhBVpM5pVhPWYvEz/HZzIvQVA0F4q+wj4lf/TuGALTJ4/iMXOvojao5j7hmWyiDORfXu01iS/qqZ05afCemGPS/t1hJD+xaXC6EOrbTbnErrV4WSzs7M2ZcW660fcqc7vxA6ytmsww5PkxCpGA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(261021121427099003)(4143699003)(11063799006)(10067099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BqUKt6Lp5H8V/1sw47BNX8axxS6xRqGN6IjFX+cxDSKgBazdJx7wttsgjJ?=
 =?iso-8859-1?Q?vmIizbwBUwlMrsTZiaau7Sm2FakKyuSlzclgyzpVQ7GZo1qvj4uF4+D+2b?=
 =?iso-8859-1?Q?jF56RSdmJ/XVhwOiyDx7aYHYclXBg4uV4D/aMu29DWtAIuGhjURoGN0fPr?=
 =?iso-8859-1?Q?9KEhAsT8NJlX1duiIw4VRdgOSiyus23Acd5xmiHJw8bOrvZesGyv6GuM1c?=
 =?iso-8859-1?Q?5zCUg29o684zBGDhTecSL5D2ptYOanyLrF2FOmlgtOTHrOq+DFd1Pf6RTQ?=
 =?iso-8859-1?Q?JTLoAZ5CLCANczLr7LTYXOW2bhe2jwGEEMORKG22TPy8tXN/eS1xOddAXP?=
 =?iso-8859-1?Q?8Ip+boJgoXzeXStPk4P2EoJToPXiiIhVTwI2p8D++HGfjRI9tu3ossVN52?=
 =?iso-8859-1?Q?jETh36xwJ+RJmwMGZXjcLLJaOmkoE5NZHcQE2B5cY/zpXcZ0qDXGN2fpHq?=
 =?iso-8859-1?Q?urxTGVWilSEYQFHuWBHFp0MjIf2MGLIZYoiBjMnGK8McTQVBQsJzBh8Sns?=
 =?iso-8859-1?Q?J3X1RgxzNkjMFLXVx1SA3WIa8QcieCunJz9Xa+fI1Zz8NZtczqqPr8x0yi?=
 =?iso-8859-1?Q?LvKSgwIwmPhSc+vF6hXIFHtL1yp3EiO3J0m0CXZGBkDwKickpToMrgYKEg?=
 =?iso-8859-1?Q?nRyPXi6dCAQ9oQ1FH+N1WHTS2RGRd0jEytwmaWF4MXtLcZjd2qtrcNwrP7?=
 =?iso-8859-1?Q?js3XEOfUXr7B5i8i2EOxKpRAka05JAPjKEmnYoy6ww0T7mjNlMPpbSfUng?=
 =?iso-8859-1?Q?/ohROlNHUgEXfcM94Et5WehkYZxUo0NJmqm9/66w3fDxiOo3sJbm929EUF?=
 =?iso-8859-1?Q?Ttw6rEfrYIYBLouO3agJ/RP7RphR3Fg2yzIrjxFNcAIqBRCy+Zu62tdM3T?=
 =?iso-8859-1?Q?6lcZXqjgMjF9SyZFvE/PgBfOtop9HhfQbEbOd+/IsDeeQT30lY95LjjNUf?=
 =?iso-8859-1?Q?rHQhXoEFk6GMtiDIVCZigtSv7l0EwY8R2bpNI6JDcjcPc7dvMVpuEX6S42?=
 =?iso-8859-1?Q?PEnu9OgniEpZirlZAXLJJrCDldJZvF1rIHMQHTZu0dmZjiy1z/418zi4Ns?=
 =?iso-8859-1?Q?W3LjALLxxrwqqUW3HTtfcJmvl0+gPbvT48WUkAapeBcwXsaPgidLJaVarZ?=
 =?iso-8859-1?Q?L6ffu58yczSu+b3ST4H/Pb00Qb2huKPtrxcEQL087W4mstl9+9CINj/plH?=
 =?iso-8859-1?Q?GlsC0bDUFNpAR+XO6j8gLPk8N4A5mpllGEcOtUEFRqUrEGUWcdPg6iYpg0?=
 =?iso-8859-1?Q?0cEbKK1IdXQIojCqt7s1zdaQATjIQP9VTTzvL/P7oMC2f5da2ysVuXDOFO?=
 =?iso-8859-1?Q?DB+YebvAtOi0m+kkQLx18XKviAAXGqVUXyJy22BoXGdu/EdvGHjYd5Mjmh?=
 =?iso-8859-1?Q?58p+Baz+LKpff3f4DVg/V1GvVV9gS2YYHBLSDFAKMWQbkkWcBJ8SCVQS/9?=
 =?iso-8859-1?Q?AoPh/B30q1CytAvG7N8HKFCjP8+cJ3JvDJszzYa9JvyFTVfRDyJJ7u0e1C?=
 =?iso-8859-1?Q?my52OJ3sLwe9sv/ZQjLdPG99PeDvLMfKlhUz9SUDcXILinnuNjKcNNPTbo?=
 =?iso-8859-1?Q?mnXIA6HrNSmM9NbH+CbcRRu12odaNz1g7vrS6WWBOCbCBGNjnLkpcbfFSu?=
 =?iso-8859-1?Q?le6TyOqs3VHf2785Q/ziRQIl9daCbyluOjgQgp3dYD+JQnOtuolT30Zkx4?=
 =?iso-8859-1?Q?GcJGdtHnyg42QHp/fZyAoQxb3ANdcA3YaGaLA+SNW5r4FACyzClIIon0uh?=
 =?iso-8859-1?Q?OPGNFJ5o7SnGjuSN3CW4JqC2l2hxftv5aM9NlhsaAcpgnq?=
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836fbf71-940c-475b-7c84-08df302d4c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 11:12:01.8248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 61ealvI/nt186jjDsBQXksDLt9t55wjgCMjccVyfH2eF36gWyQJqb+tQT9vk4J/5vixmdl6ouCTZkjhGYW8M9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181

>> +             if (!(config->flags & CXL_DECODER_F_ENABLE))=0A=
>> +                     continue;=0A=
>> +=0A=
>=0A=
> Hi Ankit,=0A=
>=0A=
> In cover letter you said decoder mappings are fixed and locked, don't we =
need=0A=
> to check CXL_DECODER_F_LOCK here ?=0A=
> An unlocked decoder can change later, leaving coh_resource[] stale.=0A=
=0A=
Right, I'll skip any decoder that isn't both ENABLE and LOCK in v2.=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *res =3D DEFINE_RES_NAMED_DESC(con=
fig->hpa_range.start,=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 range_len(&config->h=
pa_range),=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "CXL coherent memory=
",=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IORESOURCE_MEM, IORE=
S_DESC_NONE);=0A=
>> +=0A=
>=0A=
> Hello Ankit,=0A=
>=0A=
> If we encounter zero-sized HDM decoder here, the resource's end address w=
raps=0A=
> to 0xffffffffffffffff.=0A=
>=0A=
> I think we need to skip zero-size decoder here or explicitly make its res=
ource=0A=
> empty.=0A=
=0A=
Yeah, good point. I'll compute the size up front and skip when it is 0.=0A=
=0A=
> Best regards,=0A=
> Richard Cheng.=0A=
=0A=
