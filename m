Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792484361;
	b=C1T739b9aOG+/hmuU7l7russl+BC395V5PNZ5FGYCBAFUI2wM/7vsOjD5eOu6bukJ3zQ
	 Uqs/bTRgETIYP9RdsZUUgJP4v6Kmxl2A2ht7P1GJ8L3ETRNnem0dtJZmcs6yGC60Zob+2
	 zC7dPEQBnLQCQIQoF9Qwe3eMfTrTeYHhlUXkQJQQty623ZJgdPEPRUJWl/Xeu95NRO6KI
	 VgSmTTD+TDqMVWc6d1o/ytPkyZ7OlH0YreEcLEkjXYrdmEylh928iUh6xxLfynpepeBfO
	 0IPnXRpbZiFsIeOcMhA9yU3xkVJgCBxwAAqwRd1oiaO/+twGT5/H/vF538vLhCeHOFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484361;
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
	bh=EXwAM5gT6N9vvGZbHO2LnRj97KES5NQtwiH6nPXlBUA=;
	b=RLVGlMJFs+RygXJEnPFklIvZoPAZ+9NeJLJ3892EWEbfLwZq+fmLOxmOidK8W6ZzQLsC
	 ouP5HjkYCRKTafth1rNNFp5r98gmGNtRu+Uk0wdAXTFExH/EPgRa4stwVuU0YW64Rv1nh
	 FO5+z2I0FHZMS6P8FNTT7wmD2oinHuabLzo6R9+vbb58GlzyzfUgJluH99X1ymmTaDJgU
	 K+pBuERW2rA5gG3jg6sUvIsrt/c9SRnXIn8dM6txrob5vNxDjqbeMwqcOoCretDBMwOre
	 ny1qGfecHLsodSgUNvXBD87y2I4GLbpTwkuWF+O4kCQt5p/lDaAA0BbNmlyxfByZz2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FcMkLUEQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.30
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6569606A31B;
	Tue, 20 Oct 2026 08:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6569606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FcMkLUEQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOi5kyEFddFIues+quxiXPkUl9uMf2vlV3pc5cp4ZgMFI52S5UW/TuzGkAMgVTsAw0hh7UAq/5NRBxseRgvSIYWF7v9yUP2rgIrn77oUTP+ICg+Jbv2WdMYpZT0hmtqV8PIPaDw6rha8xBEbtNr8GQ/8zG54593iOQ8bvgmRy64n6EJlwnNvCqtJ9hQf2HKZiN1v0cpl8TJHpHDtaqvSYvoaiRURMqds4TL+ijgxXzrJhaYdFSC5uZCbjVCn9mOe9ERx8y7R5ThicsQMXQHQ7HmYa0AlI+EAqq885tQVPpDM57eC/FlpCQpEyAzLVU+xuNglTFP/dQQ3yqVod98F2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXwAM5gT6N9vvGZbHO2LnRj97KES5NQtwiH6nPXlBUA=;
 b=P035XPEPJSxRUCssm6mSCoH59XmHGSLVpaChRhM32VGrmGHuTPn0kH7Tm7Ud3q/fj0WZdoP4LweQX4sS7jmoYzSnY9eb/uUO9d2LXF+8ItSZVU7EMYR5F7mp4h38KlCYag83Txl597oxBYYztr9ymjGD2c4ZnP4w6BkXwiS7zPnydLO89Kdr2NOWxoHvY7Ow9a1UsSW93s0t8phxDgkER4/OseYxhjQDrKinR1VLekMl8yD+xwFlFeqBni7MMRsUnh/29zFAGOWPn6WNiUcUQyVOc91rErcZMl0mIxeDItnqMybxjH7yhlZPdex5uTFU/YzKwNV+ovkMmmbgS3ZpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXwAM5gT6N9vvGZbHO2LnRj97KES5NQtwiH6nPXlBUA=;
 b=FcMkLUEQYm820eVgGJOeO2pxJY+0dfKLfHYWXtbh4W33MKGvIYqUorjUh589eWrS7Fa8DumW3EpAFjVKJMtS05zLTpO9ZokgcV5kNdaCQoZ+XpFGk6TDKxoUaPDmcm2Gn3vNc0rj9nB2iA8S1EqXr0Xklh8T0s63G9xYJWdnfF7OW6EdpUDbfMndEHhYYTS05GdX8cnd+rRiNkTCoPr7qwlMnG4Cbh61K57RwmsIuKP7L9nweRV1IhHl4mXZvKXczZ+HIMvebTyYdqdqedGYdlMk7Riv6y79wAh5pUc7KAtD5/GDtj5y3dicVfDgtS/+MmtGAN8SYotA5PqSWFMKIg==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by IA0PR12MB8206.namprd12.prod.outlook.com
 (2603:10b6:208:403::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 08:19:17 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 08:19:17 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Nikolay Borisov
	<nik.borisov@suse.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jic23@kernel.org"
	<jic23@kernel.org>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aik@amd.com" <aik@amd.com>, "iweiny@kernel.org" <iweiny@kernel.org>,
	"ming.li@zohomail.com" <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, "bhelgaas@google.com" <bhelgaas@google.com>, Srirangan
 Madhavan <smadhavan@nvidia.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
Thread-Topic: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP
 Report
Thread-Index: AQHdVJek7/NTCN7UekepMskHjoH2Lbb9H7wAgAMCP4CAAAp7AIAAAJcAgAX+dbE=
Date: Tue, 20 Oct 2026 08:19:17 +0000
Message-ID:
 <SAWPR12MB99926758175562579523122E66B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
 <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>
 <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
 <230ba855-0a7a-4187-aee4-ac551c1cac76@suse.com>
 <atIajk/T/xb3NMK+@yilunxu-OptiPlex-7050>
In-Reply-To: <atIajk/T/xb3NMK+@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|IA0PR12MB8206:EE_
x-ms-office365-filtering-correlation-id: 7e610df9-26fd-467f-bc97-08df2e82d590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|23010399003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iJ3xtqkdOAk8252aVsd/qKM0gjURAp9Nk0gYQ4w6ZvZkeJoVIvOt5ctZTbz9sPLLDJOroTldlEkeO6LPY6iPkKdLZ9/Chqz6XRwj8K+J5jSTFAnuePYdAlGMl1HSlM63dKyolKLOPzK3D/UDJtu8H+EgRcjTAzVzYxh9jOBmdJF0xa3IwS4QmqzsEZ5HQZLO15c9DVYsXIOJFOiyGBVPy1jC5Biv4g5LbFYNcR9Clao2FmXBWCLORbuLIcpIE4qs+NadrvhlmoykRjOneCSczBFb6dJqeLhzDd3MIpzqjxWTXsj7NaqMVN6aceo17PTj6tHa+L1h4DZYIWYTuARFyciWW4+7RWdBZDsBuXmA13WAJv1fGdMdpQOZFj7spr9Csu4W8MK1kw9WE2T59i3Fiw+cs3LHzNUp3xNQrs2QuC+lFf6jQBZYoHjVVyhZmihPinvknXSTnFNoenjQ4nZtvytLKwTi4GLCvcKOmUQM72p/QoTueh54pRQ6so50W/N9wMib+RKc0LGy2DPvx/GJtOGxBND864BzHG5mTwnWDxeO5MbeEzbiht0HVIrwEYDID1AeHqPBfpEBPaRmsWP5t8ZOIuQd7A9EucYeViqpLD0MfW1+4OPqVBO/m/8ZrTSiimGurbNjZNGS8gQey9MzIG3WnKjrK+IlWxfX67IvZcMixPGIaY5XIhkjAR6V7Gf54FvPCErEtvSbFCWlOXVyz1ocwJ/WkKI7i0QgoN07ksY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nOCP+XtbIV1xqNb1ZDbw27g+UoDV96IdM0JceKLz2/UWVVF9K4fP5CX7gE?=
 =?iso-8859-1?Q?X+bsSeX89kdWwS3hoYrz/phPxjZf3R1RxLMfsWw567RCg1uBbump5oWY13?=
 =?iso-8859-1?Q?Wl6XzkX5YoTiAipjcOrMeuPnbLojzSs70V3+B4Wx1g0+quK30t5RJu1EVu?=
 =?iso-8859-1?Q?u74ZltUh2QK/5MeRspIl3izs43XfYgLcF0GxWtvq5DX7Z5TyJZv3KIpjql?=
 =?iso-8859-1?Q?UqmD0VvzfZDdQmIjabGYEglxfvZvTw5c3szM73ElV/JCn9YessgpvBrxUG?=
 =?iso-8859-1?Q?GNgxUCxF/KbrNefgRbECp3f0piPkI5GPExcAV1NNS0FmC3ET/AWQOG990t?=
 =?iso-8859-1?Q?wkBrUmREuXt3kKOoYgj94c9kE2YI3DfrrLBp8+airVuMgwFMRhuBfZy93b?=
 =?iso-8859-1?Q?fQ/O4aXQ6Y4gAcRIb1L7I5qwMKREIjwgMOwi0EpN+oQgnRdkkcfBg2LK16?=
 =?iso-8859-1?Q?UekygnHH7kDFK+l9LB2ImNORMaRNDeK0WN8PqIqd1NS7jstmxdeGRKTF2z?=
 =?iso-8859-1?Q?Jprfr+UtbFPncbmxu+RY/GvJaOp7GtgMwUyTXENGJjEHKvE9jAf72jfI4M?=
 =?iso-8859-1?Q?9U7N9GE6RBv6kkOks/Ho7IVnCtp3IpY2lmZod2cXK3L7Hwu4f8+afFOvXS?=
 =?iso-8859-1?Q?y9PS++45HAbeFaoH5cKIIx9T+mayZjRDBUiui18K+ZyXw0bNZ2y48f+NZg?=
 =?iso-8859-1?Q?Lw5/2HHPngwSjlmRGyRIf87XxKhmgWedWOoCyiVv0xvsk1z4pozBNz1CgY?=
 =?iso-8859-1?Q?0WUanHP7brtJHfoPeLhV2Y6F35m/vqdmZWTLfNo2Z8sgkCy41TW+5uzi4n?=
 =?iso-8859-1?Q?1Po2OXqEPt7T4kOweX61aPxAnddPIUhWecKtV/SzUXOFdU5J6kAsjLeve/?=
 =?iso-8859-1?Q?y+04e7tQgGtW3P8XDlgCXRQl9lxLeGRVPAVu5RnBNuEIn02EjVTXkDwHY1?=
 =?iso-8859-1?Q?TSsnV7jKalNMP4SNRS/k38lb8MQxjfukNTG9Yl5s7zZyu+YMFSd6tZ0HLy?=
 =?iso-8859-1?Q?+WzfNTSoudgit5GHCo3FkxCfzxqn4qgK/AFjni1Bk+sAJ9vvL5z4lL7Vp/?=
 =?iso-8859-1?Q?SOghs5DpXP3NORS6ugFzydIgD+LPn1dMgDolT/E/dh/L5h1p1ARYXA0SpS?=
 =?iso-8859-1?Q?8WDXzove3Qzctd6rKfLz6QS9an8UxgW8gY6E5foh7qwtfa46R5w/rDmdwb?=
 =?iso-8859-1?Q?BqmAo+UoR89KNsc3sYkIoB3FO4NFNhYpq7jZEELQhJV8u6hOb5w/A/CYem?=
 =?iso-8859-1?Q?j3KQFVDcID8ctWyQct/u5K7lrdrTZbZwo6HmUfAZzOgAw/JA2LGSY5n3iR?=
 =?iso-8859-1?Q?Oqs6z0nuxAyo/TkS5IeOiB2KsrdORutWJh7ocVFh8Im8oqc5snc6wC1d/I?=
 =?iso-8859-1?Q?u6w8S1As5tGeTcXRUVt4yajBl/3eOleB21LQvoXtlXHSHCQukXv1nkhbY/?=
 =?iso-8859-1?Q?0dPqOUZ5NUokByU2DYeakMWggfAuBugN7rcMFLfIbFX0kunEYbnhSh+ZoQ?=
 =?iso-8859-1?Q?XyF5xIujG0oF7SBAW4dcJUGd2dPcGPlXn3sMS0mtQ9/QSYFjMhyvLRttz3?=
 =?iso-8859-1?Q?cgVwVuAQ4Lm36QMCpOzyG8GG+9TkTsbkx5IdrbbM73q4KVFAdmEGSJGS70?=
 =?iso-8859-1?Q?IyBZcFGczGNk5J4aAPWlfcVBCIyji1OIxGlLy+HTnv/FjAZRPRWmpkgkc+?=
 =?iso-8859-1?Q?FnBN48oMa5UUY9YAlcwMP3hGk1AD3+7Uca+WQDNUAnPPhbHw8JUP+AZQtl?=
 =?iso-8859-1?Q?1q6/vTiC8MwxC16ltR1f4vztGpWj2ILb8MlNN9SB7B8JfAJ2FBJkmA2jJH?=
 =?iso-8859-1?Q?/yS3Pbo6poO78hP0sjmRyda72NRt/a9/PwjMSt/5G6TBTfg9I9cO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e610df9-26fd-467f-bc97-08df2e82d590
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 08:19:17.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3Mm29v5DnCFZfzYObOpzO0yFdSkIj0mtrVFEuXzRWxojWnthCtnr1NONJaq15L9+YCSnXyP5WVet/XFX6YtpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

Thanks for the review. Comments inline.=0A=
=0A=
>>=0A=
>>  While not wrong per-se having a strict check would be far clearer, no?=
=0A=
>=0A=
> I agree, if (i  =3D=3D mmio->nr) is clearer.=0A=
=0A=
Ok sure, I'll change it.=0A=
=0A=
> Could you help specify in the changelog how to ensure the obfuscated=0A=
> address BAR aligned. I believe this is not mandated in PCI TDISP spec,=0A=
> so we need to let all TSM vendors know about the rule.=0A=
>=0A=
> I remember it is done by TSM setting the MMIO_REPORTING_OFFSET as the=0A=
> largest BAR size on LOCK_INTERFACE_REQUEST, is it?=0A=
=0A=
Will add. DEN0137-2.0-bet2 A9.6.2 has "This algorithm assumes that the=0A=
MRO (MMIO reporting Offset) value is a multiple of the BAR size.". It asks =
to=0A=
derive in-BAR offset as region_base % bar_size.=0A=
=0A=
ARM also recommends that RMM pick MRO as x + 2^n, 2^n >=3D largest BAR.=0A=
SO it is a pseudo random multiple of it. I'll mention about this assumption=
 on=0A=
TSM implementation alongwith the spec section.=
