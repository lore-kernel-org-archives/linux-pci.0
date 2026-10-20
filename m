Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792485723;
	b=oxI1jCdWB0cWVk9Z/yXb6L6Dbgyzq/5SS//FDsBiWre+n4mk/AB7w+DCTFH3g+XFlkCL
	 T4jmcNnB/6NDZeaIv7RuJO6FWHOmb0TjtoQ3fLwgFNDPpETionO4e6VfC3OV/BqfNLGa1
	 Gmii50s7+eCZL3MMhX2HLzPTEWd8A5ozAHGRT50xs93myHfvHlP/LBz75yJOvXgqWGcmh
	 LiHivSHJVUjLhHuhnmlyX0lBJpP67PZoZ9l1cThj5P1EGD4ciPsiG8HP5K293ebxEYFXB
	 i5N1ThjB6RQqaORTrC3DGQVqNi855PdMQ8lUkymTfKZ7N68AEpTkf+xliMmg18VupBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485723;
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
	bh=ld1FMEGRtYmXrQHxXbQZ/N2GRJ2iiVStKAamh2QxX1M=;
	b=nwgNl1yHa0xmpp70Ezy7n/elM8zuc8RGxnffarAjAPi6UKOg/BkgcWtP0o5N5dRKnkTE
	 WfCq2m2E5wCMCPOckPb0oesofIFO8Ng6zjlJIBmt188IMnidrtJQ9YQCewVSFO63OBfxE
	 USIrcx/ZUTdbZyro0Ng8YrOgv2SQoDZLM6JDT1RvKLzxmEESr+bc7IzjPnoHHOZsOQH6h
	 C+zsPSFjoPMPjPcsUZgQ2lrsBG9QcepR0T4Kbp3L7NF2S2T8v42dzodqhgEF+GKkSjPmx
	 sceaIhEic7AdQQm9UtTquEBgHc1LE+DuAPtZsTzEueyRR2XVSoaclhDCiFmMCjRK2WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lSMzVD6m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.43
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61388606A31B;
	Tue, 20 Oct 2026 08:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61388606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lSMzVD6m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMzO+5BkCAresQRth1wqaMdlWsjgJqLS/CTr77zwZ9VsBiPtP0nVcRub3V/9e9GJXee8A9plTdqDWF1Z/oHV6gCn9Y1x+EXDMDpNoDI4/gvNV8+DL2xDjuGkHm/v6tFLl5mNR/BE/23447C8Mx/4ItqLvJcAY34CqP8jUuXs2afN4rFP4RTUKQcNDEZosjVf8rmoEZeVa0caJiYmF46Sj1Wa1xaWCx4NCtM1YtFHv66yDsoL9elXvujr+jxy+G0KTxAljzjhEaJdM2dOZnFPEMJwjug7YYsMtGp/srcNjCgEWscnB0hX/hDp2pYw1DKu2zJ3de34pd4kpPCYKg60+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld1FMEGRtYmXrQHxXbQZ/N2GRJ2iiVStKAamh2QxX1M=;
 b=uagRG99oqE8RH1EChwF29XXkUQ8Le9qJUfWwuqOzk/rDbSoicVpRZSrtVTVsdSE9f99Q29FDolmflhuZ6mwz4omT46aYb8vhU/8vgUHX60zMYUBLNI9CuHHzdyfJfLWXDegOJr0jY2FAcNfKadnzRaY8Qjay9Ewh49bXkeUcUfkae1EHvu3iNNrkVjkgMlOPgw8Az3O/Z3rCxIZ52Shi89l//fGT00ycCDT2/e/pauUS1R3I0DIsnk4pZLwpOu3YwLq0elK//CSp5yy0eeTqJ5fxqAwtVQaL4Nbvjw2KTlkV0H6M6QOZMjIhUu8mIAYnLD/Lxsb29sUvN1AqwLzMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld1FMEGRtYmXrQHxXbQZ/N2GRJ2iiVStKAamh2QxX1M=;
 b=lSMzVD6m5uARd3TsS+oiUyZrGgwTN4ZlKwe59fesN2tYWitbU0+juEWnePPTSVYnXJGUorkXzxRgSsPGZZBv0dsAjlGwREQ6JVF567pqSjYb8wZozdbfGLWpwe4ySyD3tN9T6yzxo5a683tbTBqfVm7ku1rX85Vllc/j5Len3sL4RALZWHNxUe6TgutptIlt3J2RbjydTpnr+F4ff2ql1TMjGQfmeQnpzRVAIfQfoTpY4+mry76BwRLkOz2lFyJZZDgkLHV8wfUmYFgQO3p15OCMsvfNZDKFAI+j+iRY7B8AMEF7wq+e2rBZupnP/+0va6y615yQ4BGccAapyD2/dQ==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by MW4PR12MB7467.namprd12.prod.outlook.com
 (2603:10b6:303:212::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 08:41:57 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 08:41:57 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "Bowman, Terry" <terry.bowman@amd.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Thread-Topic: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
Thread-Index: AQHdVJenWGflQInJnUi4i9OPVn0EsbbyensAgBO2Ah4=
Date: Tue, 20 Oct 2026 08:41:57 +0000
Message-ID:
 <SAWPR12MB999267EF0CA5F3E284C1BC8A89B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com>
 <bf41f28d-5fb0-4b10-b2f2-3c7dcefdda57@amd.com>
In-Reply-To: <bf41f28d-5fb0-4b10-b2f2-3c7dcefdda57@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|MW4PR12MB7467:EE_
x-ms-office365-filtering-correlation-id: 07b12874-056d-404b-878a-08df2e860010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|10070799003|366016|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 oA9zUVteiX0Tjo6lVGREFK0fvgS1f83XorsJErDew6hcygfX0HviZAEmTlaKuNW32OusTQMXbht9Vt4QbLYa8KHGkv6fLALo+tLFAG56jg7z9K+k10p3ZCNMSQzZrOWccKsat4c6xQlpsMJXpGXJ9GWGUo+lH89UuI39S57gcrgr28Zb050Y9+M/X0jgtDCIV/KnRKt3Nh30q5mrCH844RUao1S14yUJKztnzuQ3dbfQpuBUrzFP9iN8Rf+3RhTj8sE76xWBlKy2LkJTa0OA8zKJ8CSwg+J6AzgAUNyf4N3PRpUxkOGFZu0ZeXEFQ4W8OEAcGmskEM50yPviXvpjt0iTonbtV9wHfRe7uV6gEvE7IZO0qO3KJH4qoG5RlnohhZXFWz89xUwQUKWt1+PIEg9zoOuak25i5xz01j/gMO1A6z359cqj3eClo0oZKf++WZimqWYv3A3cIkxoGyT7+5GNYJdeI2ZFExUW9aOIw7twS6SiYaw5ztVHsbZVHZxToXNx4rnmhVD2V6glVbnUoFL5d8V6E+0gEGglBhYw0QnOZOJKQOrwD9koDw6U9an7fyLCdSOMjDs2wgSI2s/sWSpzD454+XtHSM6vwLw4ygRjpFinKiVJO88qeDzO8hstvlVJuDWOP1U0JeiYI/ez18vWkgzd+BV13qr50/AEMl7s8FV9MrSKUH5uwU/qP+yJtajGzofqD4cHIeUQbjmQW2M1cHK2MaDuCoLKE8GTBLU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9rTV4ur+D+rDatVXIN5J/Dq4sPU1Eqzl2vFBj/jTQbINffFpCndyAfpopi?=
 =?iso-8859-1?Q?vPhwAwLlpTTsislZlXlfpO6rg3giDiA5jfvUIbjZd2BpepC9R0IjmdpeaH?=
 =?iso-8859-1?Q?A9ZTPWwmiNw4FcGXMhMmAkvKrykq9i6eZJMML+9C/EbykKFTkGqQQU1Z0K?=
 =?iso-8859-1?Q?+S5kBEk8g+aRBJlbRkB4zlYikcEm/hSxOIW31mA5Z5aKylr0lTAlWdcdIM?=
 =?iso-8859-1?Q?QHUk4XI8JVaWvYHER6Gev4rIJtgRGgyBSXxxQEMRTYuafjefFBzqKXYs5c?=
 =?iso-8859-1?Q?PO+JCTLU6eN96vH9Rj1ldHpte1nha6yyfiRszvNW/7dzO+uKqGd71xP5F8?=
 =?iso-8859-1?Q?czoaggnk6LGvHagEzKRvzev5+J1+TUgzpAWAqFTtsv16ozVAWQZewIR9Rf?=
 =?iso-8859-1?Q?+IeyjmoMQt2xTTrB5SC3k2bOkQk5bSbfMhJbZM/oBNQZnFFbJUP6B+Q04U?=
 =?iso-8859-1?Q?gQ9zeZhFKMDv6WxqbiRS/7VgYhbuLc+TGfVlHc/Ha3KD7rPDjOWzrdC1qf?=
 =?iso-8859-1?Q?u1V76bBMNAXSD4HWZRH1oXBlGX5kOjEHl4squWuyuzs9zVHUXWxJ7LcqaI?=
 =?iso-8859-1?Q?zJiM4RvgDQXm9i/0DBakiUwOrmypVZMTcxSlXkFm6nk7PFGLVjLVPWSFAm?=
 =?iso-8859-1?Q?PnvhplrFycWaPQ5qL6gY7EdCN9TF9j6WemK8Ykr4EHdRYUzOD/cm5Odl7u?=
 =?iso-8859-1?Q?c+v8V4WllaURGcsPRhJzIIlwXzAf0ZJvyD3Xbs+gh94KHyTw9yJFd1fVPt?=
 =?iso-8859-1?Q?vlz1Eu1N27XH6M/IwmmXfEBKDYF0QTzytmrrsukUJ9C59llrBKpDK8Bz+F?=
 =?iso-8859-1?Q?3J8YKaostg1dmG3fDu+CU5hctimfc8YIEFldO4eN2gEfLCkU++EmfJpw0C?=
 =?iso-8859-1?Q?VdUhjdJnmNarwlbGJpQ0cmxEekSO+Y2cluxx3uBJAqCYTvyyMna1bYObH2?=
 =?iso-8859-1?Q?qBUzy0YUUGfMgI6IF1OtFXVyJtyQm4y6HT19gznc2QR0ZVFyuSAZX43E2g?=
 =?iso-8859-1?Q?cUOFpFYn7SJ4PmbHdbP+JiHf8ZnvlqaheVZ5R4bwkJ6oBE2Mqn64NOmr4s?=
 =?iso-8859-1?Q?nTcC/JFSdmK+krJx8oOEx9uNmd473zhmaMqAuO1ptBniPgeymRSYswN1rI?=
 =?iso-8859-1?Q?PJHC+p1xK8F28PRt7MAZCB5qfse/S5ZvsKS48rBglwMR2hze/VgoPFbY6U?=
 =?iso-8859-1?Q?G/Rt+beWgunDsUPg1d77IL7ATmXE/vtyIlIF7LABeH8tvSbofFIMbMdo0G?=
 =?iso-8859-1?Q?ehlXAZ+7Ek6iAuH893N2RtzPNKOp0Ja8/u81O6ybF+LPrj2RisqsdN/9i6?=
 =?iso-8859-1?Q?fQePSn1lVRWn7lfEQYDjmhpbPtkcGwgJeLYLp5ne74ycKgq3WV6kliV9nY?=
 =?iso-8859-1?Q?010wLw8l3TldE/6yaHJDrJUmUeAZXpDCkd92VGXKqKFzgcxPOYzTSm5jtO?=
 =?iso-8859-1?Q?/kMDBhkEARPDEMb4cVc9WNPBVAj+0zg/ScopjEOTx+7e/029mm1FIVEYgp?=
 =?iso-8859-1?Q?fDr3LzzA57wFYfhqvFtek26ZE2WwtjFq8YYIPS9L9iJB3bUWjF2KF+L+z8?=
 =?iso-8859-1?Q?3gwCC9miVp06Jop1LhN7RtqE7MtXzUdc8xYgulKYOzjrmnQPQZtR5uPVz2?=
 =?iso-8859-1?Q?2rkIJQCbGuMgzPuxJzbH6eRUWRpn6MwlD2tmWkMrCZEqyMdAt0Z2nPWkFx?=
 =?iso-8859-1?Q?eNRw/I7AUOoPJf+7LjI2IGb4BT/i4ecG4w+0od7P2vIJ0CJBdgjhjllryi?=
 =?iso-8859-1?Q?TXRz6NA2R8ERnBT7jzto84m8rBvjUS8tyuleMlW3edodsTk6HGK9LJlGsh?=
 =?iso-8859-1?Q?2TiK5CNcX29RJbr3wT0y0ZUXxGunGP4m+vnlUfajiuljKOoMOUuK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b12874-056d-404b-878a-08df2e860010
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 08:41:57.0946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Il44G3LQaeFmyXBVOtxN8R9OlWntn4RQTHNEb6NIOAELV+x2hhRXC0Msw2336TZRAv/uoofrgQqefCl1miWseQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467

>> +=0A=
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
> On platforms using Normalized Addressing the Endpoint decoders contain DP=
A ranges. This =0A=
> patch will then record DPA ranges as a result. Translating this requires =
call to prm_cxl_dpa_spa() ?=0A=
> The challenge is the PRM in drivers/cxl/core/atl.c may not be initialized=
 this early.=0A=
>=0A=
=0A=
Yeah, good point. On the platforms that I used, the HDM are precommitted=0A=
and have HPA. But I agree, the snapshot must not silently record a DPA.=0A=
=0A=
Is there an existing way to tell at this point that the endpoint decoder is=
=0A=
DPA-based? If yes, I intend to fail close with coh_resource[] left unpopula=
ted=0A=
Or would you prefer populating lazily until translations are available?=0A=
=0A=
=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conflict =3D insert_resource_confl=
ict(&iomem_resource, res);=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (conflict) {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_warn(p=
dev,=0A=
