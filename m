Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC805223707;
	Tue, 21 Apr 2026 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784392; cv=fail; b=q8+7UiGRgDoW+y5DzVvQ20lkHji1TeGKujp2Gj9vHtoq/F96QOLdyZnnI6eyfbtmKXcXgURtG7oGM3lTZtqKgbm8IbOl41w/YWzcwqUrQCFLLuVSYVYomu4w8EaxSzsUZJmGnNijOdW8bPqv9C8n5uRZgVYOfuf/01flb5sRoS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784392; c=relaxed/simple;
	bh=qVha0NLmE8n8sNsPMjobBbDWUR31WIItOf36PuiH2/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QnSypARicrzPtp5p9V7SHAsibLxOAIO276fwMi/orhuXXi+L1bVLyXX5GR/6imBZ3wO9qQlY5dyBahr8MQHOr4iwILUfFMN1F+kRnMtYBGjhVPzpRxt7gPZJU+JSSoJT1HkwsZvwO40n4hpTFXg2Nlwa1lz9nzKN1jusjkSx20U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZOz07ajE; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZOz07ajE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSC5FEWVpOF2SKEkGBOboD9V0k381CBh2rI9DeT3TVkkWKgtUz2nrelCxqBML312lWrAaqUQAIZGYlWcXnUT5/8ilr0EuysSqwV94GgdOqIosSxKBV51rCVzpjX6YB51bRo5c6/8V4LqNWgIvqZecWJ5t9JQOyyK3NrQnILNnxN4sC5ywgp89r/opSKHKB/f0sh0e3U/4OuLAqY0EyQ2+Xj980qt9/JgSgSgJLmymDL2J8ey44q8Tf0jwJDW0jtzBrsZQEsgXHWYK09MSjIroH1jXdNygcSwknvrCSGdKop27XFbBb8HS0p2N4mvuOsL9OT0i5u3fHZTkb5W0soQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVha0NLmE8n8sNsPMjobBbDWUR31WIItOf36PuiH2/o=;
 b=Cv46c/kucMhuazPzBudtIeVsqlrm383LX76o6Gq6kvk4PFQg6aQzMldVhUV2q/Nymp+W5JFttVFhp9llOAv+9HPVYAxSBS1yQLaXCLZitvP8o03mLzInerdpsiupmzKRU4qqZE/PSTzQ27jpop4RtAAAb8IHS5xDbFSFL2/A9iVKUyCTF5B+1UBZZnccnqpyZNRnEQxs37b8qoG0PhaSvG4IsMHGoduPWUN+QnHyAq4S/ofg91xwP2oW2qGqBdj2QsKb/3Fm09w3e7F7bvEu8qaHx/S8kpRztp0jK/OkYynTrvc5RcfNFeWBeXTvS9yiCepsBUetZqlQ+evBdxhedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVha0NLmE8n8sNsPMjobBbDWUR31WIItOf36PuiH2/o=;
 b=ZOz07ajED6PWVe/sOkA9Aatkn10/KUL1aYS/Q8Q9n5GUWtRBnYRKH0/Rn3sxoLpkXHGT3EE7r1B2Q91KLNyd8wYLVdWf9DDnuOmy5t72N+sGwk5vwaMDe67SNU5YYF5SWz7PPgel1wiU1zu03rgrNZqeCSgWraivASnDeF0RBoJffmcvQF5b0DoAjlR9T4L+b3qZFdgWyywGbXfEBZI0KK2miNh+NbMk3cahwuzlzoNxA5WrmZGrBNqLNSNNooaEZeYGK9Dcj+/vGPpj6X6zvTIy/iHA5dyJOjcxAFzB20nNSGv3jO1wl/qojuLFlH4Jm7yCgH7uNsJup9WWykcJUg==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DS0PR12MB9323.namprd12.prod.outlook.com (2603:10b6:8:1b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:13:06 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%5]) with mapi id 15.20.9846.012; Tue, 21 Apr 2026
 15:13:06 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHc0Zgo2hBh5DA290mJYllfRy6fsLXpj50AgAAPNW8=
Date: Tue, 21 Apr 2026 15:13:06 +0000
Message-ID:
 <SA1PR12MB7199D0D2BAD762A5F2B2D78FB02C2@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260421140659.748577-1-ankita@nvidia.com>
 <5b2c6258-ade6-c35c-0edb-6da0ec96e987@linux.intel.com>
In-Reply-To: <5b2c6258-ade6-c35c-0edb-6da0ec96e987@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DS0PR12MB9323:EE_
x-ms-office365-filtering-correlation-id: e6e01e1c-13e9-419f-5955-08de9fb87daa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 OXX5DW+Z+bNFnRKpoMvuHLOPDhpHifiLLFzyLdNS1XHjJxSPdWgDsNe2SUY2V9wzu8JCxxJFUUx2eov40DUUv+tpVcHqrI8Kqj5ZyW7JM7os7p9Ex6oE02OykR3OUBgzGbtepJ3+Tk2hz+YL8HG+V1oXq5mwNLTHKfDfbtJlb6nC4VOSULHYtadces3hlwrnwzdS9YXU2TzrYIXkE0gltJ/GlTN5M1c3KJk2IGfZhKvGDLaYeFQyVtCyMFH+YmnQp3VzP1vIDASq4ER6adw9U6ONb8lyy6i6nISmRzcQbb0jVVn3MNFW0NpNgmnkT3FIid/90N9Cn03/OT1+d2oWBVukKKZgcSPJ7N1vx2FirTGL+z7Y1UkeZRCowPgqyR9VOJB4y+eo6UAKEOu8cQVtQVQOEy10ioCigUAWbwjVSt54dR8+QKJ2YdcTFNpdZsrObk01odwvR1WRB+xEIl5V+rFlFvZm7GPgTREtWY7w+BP+FhbcLnaMO7Igfjpm2oc+Hh1/8TGS1kanRwlJ8+tsV9UdG48/BdbawVZv91f+IBnSHhDahv2LD83kfX0Ee+wHTaweTVfIEnjjJx2rgM69qxSLdlFrb6u39HpR5LugJb8hiBw62pdhLWO3pUDnXXwfebyq7/hcdhPBJzw6iDxImfFvgNzCW6kWqwft4Secs0LzewS/WGZ4pADpf868t49N+rwmYTUhkZZbwQ8K+ts2wva5zGjN0YSiUAg6s3GIuv4z4xjFniouAud6xFCvVNi3b8V9MNKXOPLLDcKAznaPMKDP9D4n7obyTiOng9OnWbY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oHe5ihQml59jPR6zVT0FYelbzvYaBOj4WkFeO4P2dJzi470AG1f7QFsvxC?=
 =?iso-8859-1?Q?jIs5jn27lZz3KrNGLSiwgnO91DhTKDdD+grpCWRxPm8XGhc6Q8qcS8dLKd?=
 =?iso-8859-1?Q?01gM89qH87NFqdHvPyy5uDD7O70eHWIOCdlDIoSO/2ZcfOeKLU3KZqecgn?=
 =?iso-8859-1?Q?8EhLXf+lTjGsk3rL6qmAYORzTdGdqwFCGzghMTrI5/Ts83kDXS6R4UjKK1?=
 =?iso-8859-1?Q?gJs5Oc0/Y9qUmECcqMD78MfhXrONufFolrIK7r2gm+4IUTAusTdi2s7CQ4?=
 =?iso-8859-1?Q?RvAxLrYXnCT67bq5s2Q1uwCtwSg1GPf04oZC09eRbudFWxalABGpFOoDZA?=
 =?iso-8859-1?Q?Ui1N7lW7r+qEocn8p7Lufhx+sZBS21PaqzEnlIb93yEOh0y0ayDBuRMVci?=
 =?iso-8859-1?Q?7rxtltXxcL1wIAleWr7rj6T+iN3MP7kzVVwpRsgqGHim4b+A2+7fvTu++b?=
 =?iso-8859-1?Q?r/QHJisgATLQLPQMskb8/jkABy8q+/WmAKSd5J6/mkTz20v/dN6/irnK3p?=
 =?iso-8859-1?Q?8YxVJEVdQAQ95SIC4bHdV7BMwfFb2ZyVdfEC8ec9Pc1rlqe+LTycGPnBdo?=
 =?iso-8859-1?Q?QnR/k4PRQOjnHzzIeG2MeTEWeb9PRzz3XixOU29pZVx+rvpwjk+5PZh8Sx?=
 =?iso-8859-1?Q?+KQ/0wrZ7d/quU//8a5GgwWjw1OcyjzLTK5CR3UWEhRagzbIvX+ycq57Sr?=
 =?iso-8859-1?Q?waqclm1id1Q7e6sIBPP0p12r1sydEYaR8TP2BDTm08jdI9LrOARSCjXNBA?=
 =?iso-8859-1?Q?vedc22rBF9NIEdqIIfgA+ZE4cpKZ+DhUBmdurDUw7S2MwDS3s8C76nU0Uu?=
 =?iso-8859-1?Q?uddq6Rj0Yh2fr9BKeaEFWYrKN2qTUNNUmGIC3g3379wZEtjlXi9YR4TRrC?=
 =?iso-8859-1?Q?EwBhXyxjNDuTNowOBaHzJNJrXm1BkTPcXxGCphq5a6cZFiji8/ug4pzOMu?=
 =?iso-8859-1?Q?OqPgAaR3IIko8KMHHLlzAOPaSlosafWswK0ETPY5Ni2jzO5iFqUdAXTDkm?=
 =?iso-8859-1?Q?xE5+eVRnN9pCWnM8r35K6fuOoL/NLW2ImvQ+i8spA1tHAf39StvLSiOc/Y?=
 =?iso-8859-1?Q?X9S2cNBpuj0hJTdyUPlGD4z0XITodlo1RLydxk1JtGtVDfaIg4nEGv2dvr?=
 =?iso-8859-1?Q?A46wSfRPDg0YWTaP+4j7isvC8CBoymCAfIcdCbdDJiVnIEzKlqaxgTgcvD?=
 =?iso-8859-1?Q?HXUbm5+rYicmu9YFmp0WPLxX5jRtqXd1P5sSN8gxE46Z5kCWHIvX5tP6Bn?=
 =?iso-8859-1?Q?RALYKAlpChsef8kwI9BVGTXPD2AFI7YbfjdT03LKbZGXWp1rijJ6Olk106?=
 =?iso-8859-1?Q?UkJtus7/HWR52o+P5ghFr83MMZT1Lf4MNSAr0ah2CeNKaRjSnlh5z9qqSQ?=
 =?iso-8859-1?Q?CBZtGIjdjzMJTUIMpdJQyg/1eS0oXRtZaamyAYmkFF78YUIFlVbJYmvzlb?=
 =?iso-8859-1?Q?lCWWisYk2Bk2QnMSm3EBpCoFf0pkp6JZeQPfcmh/DxDZPo6qlmJRFjJLr6?=
 =?iso-8859-1?Q?xkbjXZyZQl+DUjmoN0N1O/QOMVMeT1oUGKU/brD3A4uV5QfAkqq0wel4ip?=
 =?iso-8859-1?Q?ss8RMN2YwdiJcv03SSsoeDTyJaFtESRFFwlIsjnEtmQq4rZ9+06qhhzqqE?=
 =?iso-8859-1?Q?eYAsnx3RbjDYssf68qja96fNcn9ipOI0P+mumCcu1fvP5LztoNLbSs1V4j?=
 =?iso-8859-1?Q?LU9Hv0DUmqZzi5vG8Uisshqi3J/Ji8N6vEHQh0JQQ0RP/0700pgaEGqFe+?=
 =?iso-8859-1?Q?knL095RctPqjz5BEgbEFZOOg7KhvUl8EqSV8G68XbeRcHT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e01e1c-13e9-419f-5955-08de9fb87daa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 15:13:06.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g+9GA6hJiG/H7BBEoe781wk06Ksbn4YmJcbs2STB7Ji5mGj8BfK/C+MnA1Jk5WuiHDmxAWHbBJKKaH5T4O9H5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9323

Thanks for the review Ilpo!=0A=
=0A=
>> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 =
Low=0A=
>> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3=
.8.2:=0A=
>> + * 000b =3D 1s, 001b =3D 4s, 010b =3D 16s, 011b =3D 64s, 100b =3D 256s,=
=0A=
>> + * 101b-111b =3D reserved (clamped to 256s).=0A=
>> + */=0A=
>> +static inline unsigned long cxl_mem_active_timeout_ms(u8 timeout)=0A=
>> +{=0A=
>> +=A0=A0=A0=A0 return 1000UL << (2 * min_t(u8, timeout, 4));=0A=
>=0A=
> MSEC_PER_SEC=0A=
=0A=
Ack.=0A=
=0A=
> Also, don't forget to add include for units.h.=0A=
=0A=
Sorry why do we need to do this? The MSEC_PER_SEC is getting included throu=
gh=0A=
jiffies.h.=0A=
=0A=
> -- =0A=
> =A0i.=0A=
=0A=
