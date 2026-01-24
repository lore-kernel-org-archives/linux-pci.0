Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A91191F84;
	Sat, 24 Jan 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769263380; cv=fail; b=BVqP1re9vIDkG0I1HgNLNC1mFQId0FnorRycqaqPf3/L4755mR9E+Dp4rKTtLsKbzIwxskUDaaB9JTAn7YEnZLAoDkV5ERWUJ8VA7537DJPTzVXYREIU4YOG+aVJnwY6AubKwFCgEvQypkjwqo1PCE66wI1rU0e6ivd2FkdfmOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769263380; c=relaxed/simple;
	bh=0fLBPxzBX/UuPZqoHadXTgaFun33W6l073HLusw15RE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CozzxFgeHx4vkv7BLGuNQJOwWdg++nXpflcbKW8lB6GZaro2WRgmd7efnGSrRHMkpt4d7EnxmPaedEgs6wf+wCHEkXBBBJvuhZC7VUneN6lAVJ/FURXVTdLbeqYSCsK2TpHH8XzcoB1Xz1NVVkmUPqrgFJ3oBfxv/1CDeRe0EI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K3YGw0f7; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K3YGw0f7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDckq9FJXOo7fvF/o6NWvbWsyJKR7BUOIwHr9K390UI9R/eZPskbZMGJDB9dYrjO0jKzJskFob4depGaGpID4jG8OLoxmP+m8KeF8C5JtTU+j6mh4/m5PsQzVVOtxPPWt95pwkmYvtKJ6AtJkaYTg11+adYkfVuJteJNAtszeHLlsIG5hpG8WctH+DHEROIoOyxgAhyf+lMgcs4cf3Uf1N1CaP0P6i5q/cR/Xg8woxauS9AiaaFmQeJ/hdRNcODvlZdflSiJhGpR098QdlsnHDPuB+rWlbUIgbMCVAYHnMJsza88CAzKmFk3/2N8+JhlU0Aex0qUINKxKNGHDm6ERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5VT9yrb/7vFP/noylWUeSw2QMVkxoaER7QxSqlFnIk=;
 b=CYqNLqurqY3Vi1r2E15ZAeuQsDdyVhUOzzNHSpAox1AlbCze+pYNdH3atLXR6WVW40KbQxHPOeqoVzPBMlGLO74LB33BQzfCw8Dy+3rwNgQ25bIj1dWv7b7jeQWkRctDRdk6o7yb7milGpfHQnhhO4q1sdU6T+uxSfJcJ66iKER3aoRVLWPeo5jvSoTJblosHF7imqEZE8WhmWCutYSc2zaU//ZmCfUn49uYmy3AMkaDKx64YcGCt5AyLQGlk1JFBO3KWMNEnYuawRz9v/MDqVf2Z2Udg8Q6yyV949AwHNxjEEa93ZT2D48tIKY2kWiEIhAglSm0F7brDjZOhlf/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5VT9yrb/7vFP/noylWUeSw2QMVkxoaER7QxSqlFnIk=;
 b=K3YGw0f7sxpeFKRTLoCZO1qYinGMfEOpqSg20O7gjzSJz4aIsJ9pEpHKV/S1i8wDO2QNovH0dFDYZfRDraV+EJ1l5AgppHI3qp+oJJpBQSKMt0mYsU+PC8SyuwsX43kYGd9BqbNarXzQ0Hooq9BRunjGY51HtHJ35GPdD9LC4pc=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by SJ0PR12MB7084.namprd12.prod.outlook.com (2603:10b6:a03:4ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Sat, 24 Jan
 2026 14:02:56 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%5]) with mapi id 15.20.9542.010; Sat, 24 Jan 2026
 14:02:51 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
CC: "lkp@intel.com" <lkp@intel.com>, "error27@gmail.com" <error27@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "jirislaby@kernel.org"
	<jirislaby@kernel.org>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error
 message
Thread-Topic: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error
 message
Thread-Index: AQHcdDuaO0M7OyzYOkSdAmoKYSb4+bVhhhlQ
Date: Sat, 24 Jan 2026 14:02:51 +0000
Message-ID:
 <IA4PR12MB9810A988D4192F92AB760CECCD95A@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20251223184003.32950-1-rakuram.e96@gmail.com>
In-Reply-To: <20251223184003.32950-1-rakuram.e96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-24T13:42:28.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|SJ0PR12MB7084:EE_
x-ms-office365-filtering-correlation-id: 0c2a38e5-d90d-49df-dad8-08de5b514367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JTjsJ4rQcHtYUuboLBIaNxD2H4vTOaiQAp3bep8X37NmYMoPqsdmgiqFst0O?=
 =?us-ascii?Q?8pkuAawZ7PSAL4Z1Iy9PDJWubP48FDuEVig0jTXWJy9ohbor3FdsS7C+x74t?=
 =?us-ascii?Q?jAW5uvlTzUpk7PLB2ts6JBoQPJ3p32dnQZNhEepZA0E/sasKHpFgr++jYM/g?=
 =?us-ascii?Q?Da+SKN9Ik94juWIGeZVqI9sedAXIO/eQGN3MQ6I/M2LDCTJviDzYSrDYs9M7?=
 =?us-ascii?Q?cp90pl7mfh1Z3Yt+r2UVJjdp2JurUlxwULaQ7MrShdDjyVAJXEoHE5kpXXRT?=
 =?us-ascii?Q?CdgsVR56YNckdKT7bBjFaes1R+Wdq954OmLhJvXPypu9PRoPN2n1NeobPhU0?=
 =?us-ascii?Q?X/EF3iQQQo3q53GK+e5IBRLvx5E4+BMynknSiGq42nDBbIiPUljDYv+XCNMx?=
 =?us-ascii?Q?dzuLni8T5DH4fYfKBVPrqL0BVkpC20IXHnRAPsTzFGQOHsK9Wof3CorWLjud?=
 =?us-ascii?Q?7Ad5Rnpb6+Mg+TVWaCJVN7wTqm3YfOgRHl6Zd4Nh0L0kCwbl21ABqvqzQAmg?=
 =?us-ascii?Q?qe9YbU+ECzoJ6JqcPSUAtkojPWUh06IjDa+6oyBqJkxe/dAK299fLkmhWCqB?=
 =?us-ascii?Q?0MZyTbLFQK0D88E7+MnB0HC3d3T7PEYvG8WX3/CjHpqiHBEV1Sst8raePSCi?=
 =?us-ascii?Q?bKaupCY0jlP088azLKbgu5yXmJKrN4s4m/TO6VSwAa/p/YjKeGcAjM2uRneQ?=
 =?us-ascii?Q?aJ71l0Sh8GhuHifrtmxyuDr7pXLZOv0EA/V7umY1y8WBgG3Hgl/mkmxqeKX4?=
 =?us-ascii?Q?pK9otoVfWHjTxyx53G8gOtCvyey6S3ng6qr19tdAH5V6m/KXRuO/gjL6XTqX?=
 =?us-ascii?Q?H2e8h2ukPYV/sUE6xBapk9pAS7ZK0XWldCMzVn1wRCXxyiyb49uOrHPFpker?=
 =?us-ascii?Q?G2CSwWGSfz31RpZoaZh+hIHoD0QOF7J0ULCCjqr0ctVbi8jDXMkBr36quz06?=
 =?us-ascii?Q?d6+kYbkjl1UF42fxrNF8ZOQXFg1+cIFi+eD+seNFfuky82WrewomRaZp/x0q?=
 =?us-ascii?Q?yJreoG0r5ofW2wYxicnxnC6+QamFTTozL9y1kpjouBiio+8WbTxc4tkNFjru?=
 =?us-ascii?Q?h8uCWMPV8/kZn9LLxP3+1ZdkLkJSipS98GJNeRGvyTU/ahhtzitGpn8vg7Tv?=
 =?us-ascii?Q?TA6G0xTobEVwKappW8jDK5ssyEpcObEFfGFeSlXH/J0OlorxFhXozN2wis2V?=
 =?us-ascii?Q?8H/WeqUZdXElEu5p/aU7zHr/70j6xyIpFwwTiSN9QphG+hOokWHJQCeVeFHc?=
 =?us-ascii?Q?pFmTe7oeUuCgmN14WJR5nGsix71idqR5Gmj9kdZra49LZixHqQ8de3QIJ3Dl?=
 =?us-ascii?Q?cRUtgoWDEUTMngKFNwSofcPfWsghi1+P7BPD1gs5+U2g7MoA0RM/t8+4l+C0?=
 =?us-ascii?Q?62dh6CIe3PAq+YRodEIXymI3B8JnRTEstAjJiOaCUr5KliggxUPFlrApZQws?=
 =?us-ascii?Q?ttOD+N/mZyP/nG+Bp7lnWvXMQ0evapzCTPjIMg7pS6rTzkC2++zXbbIklV/G?=
 =?us-ascii?Q?kBPm7yKt86duyaAyan6h9kf3pa8DcAD3x0zw9Ru9ioSoHilRt/gtHNTbIRLz?=
 =?us-ascii?Q?Qbr2mgramr/eWEok6fQqb31BWd0Z/VS68azM3TYISJNNscJJhs57UOYDQG1k?=
 =?us-ascii?Q?nHx5nx0+kY3LSL7tHjSmgSE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kTGwTJRs9H1zY2Zjq5z3eboZTqiWlDxD9NPZN40t1k2RkgrsgUHHNb+lWaPk?=
 =?us-ascii?Q?aEyIB8+ZNC190Uw/QyH1F5XLtzQnCqKbLAm7q8cw6NKXXywTmKht9SFTHizv?=
 =?us-ascii?Q?0Sc49kd6jUr+nYK54ZkjleCxTgocnrlYVW9dbZ7EZifU7TVmm4ry29QR4l4o?=
 =?us-ascii?Q?dDXmegzQf1W6lGdqV4nRP2e52Nc13qctCT4OnBPLXQPbu9mcnts6O92FzD94?=
 =?us-ascii?Q?H43Nrips+PWy5dyeg7Yu10MXuXRcEjs0/63btZRJI7FBtXkP1iZfTQHDrphX?=
 =?us-ascii?Q?pQJFEb7fTouzvPuk+t4PJQsOg8fDUm1VwChLHbhtwf0WRsnxnmFl9pbPTfSV?=
 =?us-ascii?Q?0pjQ1PAYOiFXcMb4cVf5nyj7Oz7AnF8ZOgMJ1ASg2RbFQJE7ss9Ti2+b3nhb?=
 =?us-ascii?Q?sdKwpbZu2ed8EqrniJxOd2YOYzVzSZd9xPSegTUFdpVxr/8UNT42Lu98Dqcc?=
 =?us-ascii?Q?NELFW7sX7yVqijbVAo1dEZFgArrzLLE0/YZOWIa6Fm2J455Cpx28JGDCS12Y?=
 =?us-ascii?Q?9RkVGG+Su/RteDdRFjij8tdS4o7Z7ycwPC6XsXJXXrM8oyYAHapBhqt6nAI9?=
 =?us-ascii?Q?ob0B1whFnB50BRcSXWRESoNsaCqPoP6LTqK7WLMny8OryZVBUAGjOp69OjNm?=
 =?us-ascii?Q?dPFVfYe8e9c16YWhiL/STcZn0Tt6X7pGA/JLO8kbw+OUXEMCC33UqJ0FKyeg?=
 =?us-ascii?Q?IMRK8tGEKn2a97TT9eCP4w3uvKpca1ZJoGDpj+SuyCcjXr+d7YOhGXJYiwJP?=
 =?us-ascii?Q?Yz2p+0lTZalecUWBh8O8SpDHlgwoDaJkpY6HZjSqoKvspLX4RuxZm3/5rH6S?=
 =?us-ascii?Q?1IoiEILDx0BUCNhdEpCko+ffmBNbJhFyGiNGKbMhMpdD6Lrse4oqWtzXqyiE?=
 =?us-ascii?Q?2wCI0zcU+7eVFGnvbt1Qy/AG3HMK+XKfyLhIuqkCTiPy/cbqxq9v7AEVawWo?=
 =?us-ascii?Q?sMGLJZqTz55yyKfehh6uRuzKRofMSyhOBfsTfq9dwoX1cKquruffcqOAeKyS?=
 =?us-ascii?Q?gaVec9/m4Xrug5NkS7+hif/ZpUrpBsmAf5zrniaOByo+eTXACC4xFm984NTK?=
 =?us-ascii?Q?aDoLqZAxeRaVI++CVfmTenJpISv7iURNfPtUDptEVxWQMGdA4XCbjF7/aCjn?=
 =?us-ascii?Q?vgtZqS+Svw2Zq+4u7n/s516xDivA7iro7WedjrM6/AXLbXsZgGuJUlpooDVo?=
 =?us-ascii?Q?e2KjemTHKY/X+2V+1u4R1n+xGsNxHjcgAyjGn2YkCPaU+z/DwzFXf6AxXPfj?=
 =?us-ascii?Q?DEltmrLOix5uuBnwEvfBPxbC/J5SaHy6hkFBidqdX3tEdO83gxyOUi9/oN8k?=
 =?us-ascii?Q?qxCZpi6oUhdGpoUE3fJMjgSn9gV7FrJGOSpnmwGAR+Q7PJuIjYPh51yRpkaY?=
 =?us-ascii?Q?cKet5tx0sZZ+eCg8ZImjM95byo9PJTifOvKy/hdA83okgO/568dsECtI+Q4m?=
 =?us-ascii?Q?zUxFFyt/6bpHZcbtnaTTmrDKDW1vafebWTXeuTtgpoJXten7AZVuNmf7XDS1?=
 =?us-ascii?Q?MEyX9qTxeMJp+p4Zi+Ln7aNhbijlCzy8g09vJZLvbMIcT5IgRk5/wv9X2JES?=
 =?us-ascii?Q?dRAJKvbaeSj/aJXKL65zvuii+xCy28vr+TuvlVIi3lFHb7c+yFFKnLAFUz+D?=
 =?us-ascii?Q?XSaUyDyHmSYgReLCOgFNQJrMrLCXzpyiIAAaUxCOvhIrTo8tyoNy+u8sRmI8?=
 =?us-ascii?Q?d0QtJbswUiH/dzQ2o661gsdR4lyrnmw5nm9bU4Eh7fxdrTzo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2a38e5-d90d-49df-dad8-08de5b514367
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 14:02:51.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6L7DYXvq/k5cSCoSwlKNHKqwTKNIqJnhhHW7WV9qh+QWvPdWUytEAkZVNlGBDm6XyuXnKun1chDaQLnesPBYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7084

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Rakuram,

> -----Original Message-----
> From: Rakuram Eswaran <rakuram.e96@gmail.com>
> Sent: Wednesday, December 24, 2025 12:10 AM
> To: lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> robh@kernel.org; bhelgaas@google.com
> Cc: lkp@intel.com; error27@gmail.com; Musham, Sai Krishna
> <sai.krishna.musham@amd.com>; tglx@linutronix.de; jirislaby@kernel.org;
> Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Rakuram Eswaran
> <rakuram.e96@gmail.com>; Dan Carpenter <dan.carpenter@linaro.org>
> Subject: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error mes=
sage
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> The INTx devm_request_irq() failure path logs an incorrect IRQ
> number. The printed 'irq' variable refers to a previous MDB
> interrupt mapping and does not correspond to the INTx IRQ being
> requested.
>
> Fix the error message to report pcie->intx_irq, which is the IRQ
> associated with the failing request.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202512230112.AaiGqMWM-lkp@intel.com/
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> ---
> Testing note:
> Compile-tested only.
>
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
>
> Command using for testing:
> ~/project/smatch/smatch_scripts/kchecker ./drivers/pci/controller/dwc/pci=
e-amd-
> mdb.c
>
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/cont=
roller/dwc/pcie-
> amd-mdb.c
> index 3c6e837465bb..7e50e11fbffd 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -389,7 +389,7 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie *pci=
e,
>                                IRQF_NO_THREAD, NULL, pcie);
>         if (err) {
>                 dev_err(dev, "Failed to request INTx IRQ %d, err=3D%d\n",
> -                       irq, err);
> +                       pcie->intx_irq, err);

The fix is correct. The `irq` variable at that point contains the last
IRQ mapped in the preceding for loop (an MDB event IRQ), not the INTx
IRQ being requested via devm_request_irq(). Using `pcie->intx_irq`
accurately reports the failing IRQ number.

Thanks,
Sai Krishna
