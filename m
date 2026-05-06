Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3E1643B;
	Wed,  6 May 2026 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778035613; cv=fail; b=uhYKTny5ckWQrmf6ATJZAKdeAuhtgIuH05IucJ2EOqBPwCVJsCFpJfaZs6jdp3CVd6aOplJv5GVJGOmJXGHASdrUfzRo09bqdoE9UMGzVMGA69XtB5MhBzWS6iRIib1u/N3rrMKQgKFHXK+z31HweN36bnpoSMv43NP5ECzTDBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778035613; c=relaxed/simple;
	bh=2dL8X4RBEmlMQxTMxZ6z5ZDFuKlqCd7zEBN2BSxoQgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rvjIUXheeA0o2Jbp7xuvJSInEvnVNEa+jiTiqWtbFt/IsMGCUktOAyN6rejhCoLTOWQB7mWe21AHviZTtuDg/j+q2XQakIu3Kp4uPj7ENEB+P7HdBqNiiF2ooJVfbRniia0XLuOWQjPf/tPjlsbhJ6OErpOoqbawg/IySYHl2oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ipgx9uNh; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ipgx9uNh"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646186Nw2226351;
	Tue, 5 May 2026 19:46:28 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020114.outbound.protection.outlook.com [52.101.201.114])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dyupyr785-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 19:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAjOgS7wIcFgXmop/f8lDoTVrUtDdVP3MGp/SwNhmwPueyiPUJusryznLHj73F6fVP2TK3UZF1xegw5xvtUUb0thYHm63h2b36NimffPIPvBf9mAH9VjOEuWWBHYUN7SVCBKW4sc222nh9h7qocHH6exx8utZ+JktpN0pKja5syelbFNFbZiUE6UZjFQ04zwjeioJ7GIFCvgU6ME24a835U4On0rnmkCjp/FB44sxNtgp6BmGPNpeVS4k5ZrkLwuJnhYZ3kG56Mzv/gBDEXoEK0AJYWnTkVD1XAb8n3E6DJ+mgHKII8PdWw5tPFgml2gjIWpY8OLq1al6VRp7bik6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dL8X4RBEmlMQxTMxZ6z5ZDFuKlqCd7zEBN2BSxoQgE=;
 b=LzYIKm5dv9FqHQ2xcHNMHrTtkmeCXphcO65CSKect8MQ1coROtRd3CEhyPmlYXz7g/U0TOGtEm+p6z7mvXONuMbkbyr/buuOxuSUKkEEbI9OvaQyuYhQYBPgVI4l/95nuI4NjINEnU2CYUIy/FQcxJ2j0htgo8P4qXxe0kPZG7+0BEchRL+CwXpMKZrhbucspbdcHKbJCW6tjS+sCvBaSZchz7OZf2Ds+1syyzA2I6nCH1sGcVTBUSk3hn7TEkza9dT9UeQuht1UaJlHIzUPLlUYwgtxH2Uj3B9d9PbBMVgVOKZxDzYi6j//jpIW/AifS/jTEozKziTa9Ze5yVHhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dL8X4RBEmlMQxTMxZ6z5ZDFuKlqCd7zEBN2BSxoQgE=;
 b=Ipgx9uNhiN5BnlczNI3/NNgyjIBwaz9ADJQuVi6Pa1llkYPvdSE4dlOzIZH6/EPtZpet2FCpqqsyQHB3IU9T9bvVk3cN6Xa/X1YjConMumpat/y9IpbexcSVKUo30HrdHwWBRf8+a1jOCLQDtTTVkV74dyy6ZaEEpaylafnp0qg=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by PH0PR18MB5089.namprd18.prod.outlook.com (2603:10b6:510:170::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 02:46:15 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::48b4:4ff8:d5f4:a49a]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::48b4:4ff8:d5f4:a49a%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 02:46:15 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "bjorn@helgaas.com" <bjorn@helgaas.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "will@kernel.org" <will@kernel.org>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "vidyas@nvidia.com" <vidyas@nvidia.com>
Subject: RE: Re: Re: [PATCH v2] PCI: host-common: Request bus reassignment
 when not probe-only
Thread-Topic: Re: Re: [PATCH v2] PCI: host-common: Request bus reassignment
 when not probe-only
Thread-Index: AQHc3QKBrc74cXnvwkeJkqw+7UbM0g==
Date: Wed, 6 May 2026 02:46:14 +0000
Message-ID:
 <MN0PR18MB5847913D9E15805B85A0AAD2D33F2@MN0PR18MB5847.namprd18.prod.outlook.com>
References: <20260414081730.3864372-1-rkannoth@marvell.com>
 <20260504224955.GA669929@bhelgaas>
 <MN0PR18MB5847809DF7EB9A3ECA4A4159D33E2@MN0PR18MB5847.namprd18.prod.outlook.com>
 <CABhMZUW5Y3g86_ki8MfcqX9Qj63TxqQR=m74c8sBm-puZGEvUg@mail.gmail.com>
In-Reply-To:
 <CABhMZUW5Y3g86_ki8MfcqX9Qj63TxqQR=m74c8sBm-puZGEvUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|PH0PR18MB5089:EE_
x-ms-office365-filtering-correlation-id: 223fbbfd-f0b9-4e68-14b6-08deab19a428
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 rPzCrUOoIdl+IkOJTbcqE9ihPoxc8ecrDXdnshD31jjRNRSJf7YClVpcNk61BREafzqhPNR8JxSWgwvm3Jl8kohMDMEyCR9Wv2hU0O8r5pBrJji6HS8cPZ2ubz2PwdTXHKEHdkrRDqoPEexJxjLPwVUzqH3Fqlbt/akvvksCrYwWpqG++7cHHhwZpD62FNUBJnRwo6Mo55r/jPzKr3FI0LJeRATYEE6oNpNLk2uws/fw980wz5796lJCWezUKpisKmy234HinBOPR6R/dXwP6fJ3yeFWt/H4tqVBjdXIYkumQmpnFUcvNiIwpdiM8tVsRDvLMCirjQZ01Ge1TNSXLEaoc4p4uU5R4SgkQPD5S/SIZ+NkZEwn+UJOvRZRM/Jwld6Zy6M4Y7f2/jNihPHkZmHn7+A5AAjsVgP63ACwXSpYmeG2Qp5RE2HI1pweqafna4ylNFALZgqLqUDoBH78S0E8/wQMAwrtVyHoUhkKvpKBnseWMVyoGd3cBpSZfWKb+GrU2sUepChY4M+A/zphWM45a9siZVzlDh11yBLhiRTiuQgqM1/Hh0M6GwDhSKdgVTnXekqPgNHqY53+4oC1X/3UMU7VgWsDAue2Zn1FXEiOjDHOKMiGJy1+PxldbIhsLTdgGrZlBr8ArTXtb8O+EGq3/+bJwJsw9BLzpC5Wudwh1lTamHD9+cLAopORq6lP
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZE1uS0RyRSt5eDdJUlRCdnZ4WHJzMCt0eWtuWndWQ2d3eWVwc05ZR3piMUhM?=
 =?utf-8?B?eTZMRlFOdjA3bGhQUFZzYlhTMjExN3lFSktjRjE5WllUTm0rYUxSbjdraEh1?=
 =?utf-8?B?RFpXNGdiVWJ5UXA0YWp6USs2UmpyMWNJWUd0RDEyUE9VS1l1M2FYZzRsVTFD?=
 =?utf-8?B?eE5YaWVrS3FqdmVkMTRnQ0Y0MkJNZThBK01nWWRYV0h3M3RnVmNYQlI3V1U0?=
 =?utf-8?B?Nkh2dkhTd1QvZnFOd3Y3d0o0YkFBRkU0a3lOTlJIZmRDeEdCV0NNOEJ0QVA1?=
 =?utf-8?B?Sm1jRlg5MXBUcE82ZzRJRnpBVUJGZHdLc0trbk5xYUxWRUFhU05JV2YrOWhW?=
 =?utf-8?B?NmtrVUJTSStWKzVqL3pORlJ3ZDRHNjRoaVZWUWVOako3NlIvdEM4U3cwZ0Zt?=
 =?utf-8?B?eVVTTDNCL0h5bG5IRFZObmcxai96emN2Ry9uekpadFpkcjJyMHlPckdUVGJs?=
 =?utf-8?B?QVZoM1I4aEw0SkY3UVNEK2h4WlJ5MGRXTDN1clBpUDRtSkM3aVdvSENWZVJw?=
 =?utf-8?B?Y1BkalpFazYwbUVuUjQ2Ym14blZwRzhvNmdYMFd3VTRJaDE0NzhRVFV5YUx1?=
 =?utf-8?B?eTBYVW5UcTM2b2M2Q1NrbXBSZE9EejRLRDFQSDF0UHBhMW9Lc1FhRUVqVUdY?=
 =?utf-8?B?ME9CNStlb29GWTZEZWdvb2liUTlKZ05FbzJVVU9xNFB6U0dSeDRORkQxVUs4?=
 =?utf-8?B?TzYrakF5OVozTndxdklLT2JhS0Z0UWtNL21tVGpTL05zY0Z0VmxaWUNYYy9a?=
 =?utf-8?B?dmlXMDVwREdFYTQxY3RKY1Z5ZE1PbStadUVDdTFpZGRZUE1EcTlWWks1UkJz?=
 =?utf-8?B?aXFzbk5wSEE4dy9nQmgzeGd0OWpoQlY3MHRZRThGWTcwb1F3OEs0SGthTys5?=
 =?utf-8?B?SUE1Z1FJUEdWUjUvWTduTklrLzY3eDNzekxYUFJnNjBPVVQrVnpYcHZyQkNC?=
 =?utf-8?B?WVFxUWNRNFQ4LzJDR092cFo2Rkh5Nk1sdGZqZG5jQzhsaHdmRUFNbGlGVWhO?=
 =?utf-8?B?YkI2Tm5HcWE5Y21MdGxWVExEb1BRRUNTck0vVUxEcllEalB1QlZpVG5aNjVI?=
 =?utf-8?B?WDl3SnFtV0lYRjhBMFVHNHRkVHpQeU9UL1ppK1VDUzdTQ29OL2tJdGt0WlE3?=
 =?utf-8?B?Vy90NHkwbWlGd1pSUGFENkpRd0xVQmRydzBFZVRxa25YUFltL0lLWERkSDFm?=
 =?utf-8?B?TGQvN013OCtTMVU4aWRHei9qNnh1Y2pQVG1jNVJMR2NJVEtjQzNkbmFJbk4y?=
 =?utf-8?B?b2JGdUVVcFdQRWRzaXU3ODYrYk83emNRVytSVVVGbGFCVjRud1MxUWE4M1N4?=
 =?utf-8?B?OUd6ZWVEU2p1MEk3UmMwcWFVU0hSWVFxbkppL0dHbDBqT3FTdkhvaVl3aXM2?=
 =?utf-8?B?TkpFTXNqNHRKTDYxbjNoWDNDc2IzM3orVXI0VnNpak9WaWtXM3JSSXFyQXEr?=
 =?utf-8?B?UGx4c25vSlAvajhNdjFwcXU3dUlYcnNpUjNad3FuYXBlQnYzVjZ2empRaWFO?=
 =?utf-8?B?SitkM0Y3OWVLWDl5ZEQxODlVWWNVR1cvSGxJZXFJTmZTczFvdHBlU2U3WlND?=
 =?utf-8?B?T3pZQmRkVDdib25RRzBXNnpobVA5ejR5Q0VuVVA2K0J3OTVkWTMwVnh1RFk4?=
 =?utf-8?B?NFZVNzIzeEFjNGo5OGlNdG9yaThGU01aRnNUb1o1R3d5R1ZQcWNpeTFNU3Q3?=
 =?utf-8?B?aWNmbjh3Yk1jR2Rvc0hYYWJHSVZBN2FmL2ovTkZqWjV4RklmbHVEY2N1L1Vl?=
 =?utf-8?B?eXVWZEVaNVZFZGJkR0hyTi9kdk1ZT2JUT3ppYmhIYmFhZGQxdU95VlJ4b2hK?=
 =?utf-8?B?NkZCVFJDNkt4MUFyZFFEZDNwdEVhSERPNE1hOGJlYTdRZm1NMmd3clBpWDN1?=
 =?utf-8?B?VmlTSTA1czkyRmVwN0xkYUtERkdPQjN2dWl6bS9XblFTL29ETGxaWUtsZmd5?=
 =?utf-8?B?SEliYkJIY2EvMHlZbHRySUp3eTIwWEk5YjQxcTJhUkRTVi9VTktocmdSN0ta?=
 =?utf-8?B?Unoxd1dLQUZYSjNORkt3U3RrVHJqT1Brb1VsaEg2WXh4d3FoUjRvYUpKeGdR?=
 =?utf-8?B?M0NPWEo5TkVuOFB3UFNYc0wzZlJrZk9YWHRtS2Q5dm9GaHY4V1R2MEJBTkcv?=
 =?utf-8?B?ZXdCcUdLL1NWNE0wYWhTUWhvam1CT09zUXV4RGdoZmRRT2ZxVVl4eHBsTWkr?=
 =?utf-8?B?SE4rSDJBMDQ3MkpxWjY0eTlMUkFKV2lKTTB2T1NsK1VjWW1JS0NOTGRQUmFC?=
 =?utf-8?B?c0lJYzcyV0pZUEVwRE1KRTRCQ0xoODM0SXBSaGhyZFdjd3c4dXVycmlwTmtp?=
 =?utf-8?Q?Fx5Rm5yFMrn65SWLsc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Tqt0Rw5whC4p2s+E/6F5LTPDetMp0WZXy4OV+qHkcCPOR7LeVdEx/D/aanoSYlfAvMCfD1k0edRWoUWEUBNq4FQ4Pf/BpjMusDPcBtCmQ5aXQgEld1FQraFxpo5aj2dhMYdNMJrGVLg9wFbqIbeRKjQnVygsNhIuDePQ1Haremn6WU4KyyV6EPvwK54rf1KRJCMEW7/bIiWNkWqBFjnV7yjlnt6zlXxaHa25wGHLUEVaMQcpde9vlfDia+E9Gfh7X6KQDKqZs/baJvWqPC/g0T/9nSQBnA0a8YOulam63GXkmqKQgCAKVQd7j2RtlPloLbKgdithzcRtqT7WkV3QUw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223fbbfd-f0b9-4e68-14b6-08deab19a428
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 02:46:14.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWxOhNtDFQR0VJkD4bBa9ciRUq5v0xwLbwiU2XEbkC5LYLeejjkjI5xcySWlvgTPwoFMU+sGOYi8/1NnjN3Zhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5089
X-Proofpoint-GUID: _vGbRUX9dg56PUJFkRazZKHvuPHA9oeg
X-Proofpoint-ORIG-GUID: _vGbRUX9dg56PUJFkRazZKHvuPHA9oeg
X-Authority-Analysis: v=2.4 cv=BoOtB4X5 c=1 sm=1 tr=0 ts=69faab83 cx=c_pps
 a=b+YkWSWpBA3VYLEuQ6BQHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=FlG6zWXmIzq583POqvsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAyNCBTYWx0ZWRfX03J1KyGeJspv
 d/iFV4XllMLnbfA8SPa2x9GbC7MK2Tohgb1xkHX7oFl4hvXuwtBKKXAxOnOKQ4vopnWCY/5r7yb
 wQhD3l1OOzGAGAGPqSkx1q6cqlq/9DCM9vDCB2h2BluSBsnx+G8hi+rM9W4pAOrQ+r4V0mr8Ps6
 WWBL+Y5VU/aeicU3+qHUjRiPCVR2uxMCMkdrdTPvTHqyRUIR7+SxAAMF/h/K9edr7QwBi9ayD6m
 nDssEqnpV2iEmc21VOT+5jqL14WJJJKjRLcmw+FkWdrUzPM3B9dNb6yTVA2ECYlg01t1k25tzHv
 w8tnUBfyDpV8tzAg+6fAwEtaH1205zxawXwsERFe0DNQSASGaJxQbea43JhwMQMdK/GXoWOHWs2
 3SCML4Ne/uNxGmQJEj0ra8Q+BjpZ4EaEhd87gfzAsG0ZB7AcB7nbU0TO2iz2YWWqSAfJvJGI7e+
 dcV+BpdrDmc2SpFIAgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

PkZyb206IEJqb3JuIEhlbGdhYXMgPGJqb3JuLmhlbGdhYXNAZ21haWwuY29tPiANCj5TZW50OiBU
dWVzZGF5LCBNYXkgNSwgMjAyNiA4OjU1IFBNDQoNCj5JIGRvbid0IGhhdmUgYWNjZXNzIHRvIHRo
YXQgYnVnIHJlcG9ydC4gIElmIHRoZXJlJ3Mgbm90aGluZyBzZWNyZXQgaW4NCj5pdCwgY2FuIHlv
dSBtYWtlIGl0IHB1YmxpYz8NCkFwb2xvZ2llcyBmb3IgdGhlIGFjY2VzcyBpc3N1ZS4gSSBhbSBz
dGlsbCBmYW1pbGlhcml6aW5nIG15c2VsZiB3aXRoIHRoZSBwbGF0Zm9ybSdzIHByaXZhY3kgc2V0
dGluZ3MsIGJ1dCBJIGNlcnRhaW5seSBpbnRlbmRlZCBmb3IgdGhpcyB0byBiZSBhIHB1YmxpYyBy
ZXBvcnQuIA0KSSdsbCBleHBsb3JlIHRoZSBzZXR0aW5ncyBub3cgdG8gbWFrZSBpdCBnZW5lcmlj
L3B1YmxpYyBhbmQgd2lsbCBnZXQgYmFjayB0byB5b3UNCg0KPkkgYXNzdW1lIHRoaXMgaXMgdGhl
IHNhbWUgaXNzdWUgeW91IG1lbnRpb25lZCBhdA0KPmh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsbF9hYmtxbS01RkxD
ZDl6QU04Y1ctNDBya2Fubm90aC0yRE9wdGlQbGV4LTJENzA5MF8tM0YmZD1Ed0lGYVEmYz1uS2pX
ZWMyYjZSMG1PeVBhejd4dGZRJnI9YWVrY3N5QkNIMDBfTGV3ckVEY1FCenNSdzhLQ3BVUjB2WmJf
YXVUSGs0TSZtPXlIN0VlQmU5SHdSbGxEOEstPlBGTlMyQ01GU2xjYUJIVTZvM0RZYTF4bmRKdndW
U0hJNGFQV2k5OHVES1BSSUpJJnM9Qks0X052bVhhcXlzemtNVkhXQVBUYTlNZWFYLTI2S2EzeFQ2
TktTWHdGUSZlPQ0KWWVzLiBJIGJlbGlldmUsIHdlIGNhbiBpZ25vcmUgQnVnemlsbGEgcmVwb3J0
IGFzIHBlciBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y0LjE5L2FkbWluLWd1aWRl
L3JlcG9ydGluZy1idWdzLmh0bWwgPw0KIk9uY2UgeW91IGtub3cgdGhlIHN1YnN5c3RlbSB0aGF0
IGlzIGNhdXNpbmcgdGhlIGlzc3VlLCB5b3Ugc2hvdWxkIHNlbmQgYSBidWcgcmVwb3J0LiBTb21l
IG1haW50YWluZXJzIHByZWZlciBidWdzIHRvIGJlIHJlcG9ydGVkIHZpYSBidWd6aWxsYSAoaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnKSwgd2hpbGUgb3RoZXJzIHByZWZlciB0aGF0IGJ1Z3Mg
YmUgcmVwb3J0ZWQgdmlhIHRoZSBzdWJzeXN0ZW0gbWFpbGluZyBsaXN0LiINCg0KPllvdXIgZW1h
aWwgcmVzcG9uc2Ugd2FzIEhUTUwsIHNvIHRoZSBtYWlsaW5nIGxpc3RzIHJlamVjdGVkIGl0LCB3
aGljaA0KPmlzIHdoeSB5b3VyIHJlc3BvbnNlIGRvZXNuJ3QgYXBwZWFyIGhlcmU6DQo+aHR0cHM6
Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5l
bC5vcmdfYWxsXzIwMjYwNDE0MDgxNzMwLjM4NjQzNzItMkQxLTJEcmthbm5vdGgtNDBtYXJ2ZWxs
LmNvbV90Xy0yM3UmZD1Ed0lGYVEmYz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9YWVrY3N5QkNI
MDBfTGV3ckVEY1FCenNSdzhLQ3BVUjB2WmJfYXVUSGs0TSZtPXlIN0VlQmU5SHdSbGxEOEstPlBG
TlMyQ01GU2xjYUJIVTZvM0RZYTF4bmRKdndWU0hJNGFQV2k5OHVES1BSSUpJJnM9N1hmM2lrVVBa
cFRqYm5YM0IwemltcHNIRk1nSng4Z3VSa3lHQWw3R1h6OCZlPQ0KU29ycnkgYWJvdXQgdGhhdC4g
TXkgbWFpbCBjbGllbnQgKE91dGxvb2spIGRlZmF1bHRlZCB0byBIVE1MIGZvcm1hdHRpbmcuIFdp
bGwgYmUgbW9yZSBjYXJlZnVsIGluIGZ1dHVyZS4NCg0K
