Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A82171B1
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785693492; cv=fail; b=iHOVP4/eY9FC+RDJhpF98RJzOiziIyyKcHyPOvsrFImSFuHqnFLf/pJiYzfm7J1MEy5Z7cS723oUOX9s3gIcKDGHPR2TDMLdcAwtOfqxX5plFtRlgkwiPN6kmYwPjVdoxL1wQcAK4glfPts9SYL/RGgWONgA1F4iUxyiGZpRcE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785693492; c=relaxed/simple;
	bh=H+QRvgF/1Y6H7ZtArXeRKQwjg3fAHjYESPpyBUzfl3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRG97hH2y9TgmixyBeKbxJ2RIQm6YWTJkhTueahgSyHknrqGhgJOO7+yycs8h9voBAQB/0EH7Ju01cdYlM41+v1Cgrwsa/TGIkTr1XBTSdGB2LW0f5+2BrbbUm02KQtOq1yGI83C0J/g/nTTOAiS3J5spUwjceTFysQznC4zkc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XdII4uI3; arc=fail smtp.client-ip=52.101.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XdII4uI3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALQdnpHCjDRCWBR2LJE2E6AfMLH6rz0ydRDFvzFjFx47UdCLsXAZ+/zY6AwZ7rLkAteP8BcPOKS7/JidnJ4QlPqSmcxfgZ6ulq4dOSg+rRJsn19etNoYhGjjRajuodHM7F7tesX/sbsnbKVuLagk5WKgsK/7s6FcCVl1SGwmcUjwmDtnzSQ3dp6O98U8Pcf7jfN7+4P1LHPGN9TzaawuhuyIedLztjWSmc3Ab+dEyfYcFWxnvXT5aDvBfOctEHY/A/bjRwv5vgN/hdQX67efnuFMe5kitOc7+0NBEC5nMuHOSGhwqX/AIxppBNZ9TcNbVE/AKQjSuSuLtUW9n67k8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+QRvgF/1Y6H7ZtArXeRKQwjg3fAHjYESPpyBUzfl3U=;
 b=Vks13UGKwb32T9RBIHLVAZ9lQVIfHIqXYGtw8sVZP4lpeEPjea7CkpW7ZF8uXe9OalQTnvnJfw9qsJHGiVep66V1CTImtbgsRgU24UjR2Fu5Dp9Ew1lZN+YExrCaXMURJBa4njQioanZW3uK0T0XZ/T79Z6anmlYRGBd09RumMs1uNCe6juSmZ0wB5waMuK2OTzG8NAK43AWEZYNycb2b33Kpf5yWlfi5ylaO1Vd/hAAqYjQF3LK8lm0vOJYZ40UTOi2jt9owF7eUrIYtDa9yhwnrfl6IJdJ5YP2NuJp+Ky0O4cEBFjAV54E3W2Le+CUiXNVVHbIgEGJphcVKreneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+QRvgF/1Y6H7ZtArXeRKQwjg3fAHjYESPpyBUzfl3U=;
 b=XdII4uI3/+G+4re5ggUEiHKRiaqHz8Yy7aZ2nS+UhzcaqYLqI4Tp7d1K6qGJoJ3ZpfUteLMZAWBa3D2Ut0NEdr6cQP3lH2dzQ00fKQfzjm+mutRRi8UHdySzsbksxAYWmDoCUGUAqWRprun6/kA8F0QUZKDdLrJf4fk+yyc+LMZOj4dEs8fsmE+qC8hw+eSMSRvcuCsUhd35Oe2MYOdRyqZ9x5/XwNLMOfjgjBwOK4ybRVxPb9BQGTIZL7Rp8vt6NUgfHz5e6yOknf3CqNO4yx/qNrXlbpmSeCBt5PzXTykqekeXyVdEul5CT6HWSC9cmlRPP3rMMGDDRH/RfQ01Xg==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by MW5PR12MB5681.namprd12.prod.outlook.com
 (2603:10b6:303:19e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Sun, 2 Aug
 2026 17:58:06 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%6]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 17:58:06 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>, Alistair Francis
	<alistair.francis@wdc.com>, Lukas Wunner <lukas@wunner.de>, Donald Hunter
	<donald.hunter@gmail.com>, "aik@amd.com" <aik@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
Thread-Topic: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
Thread-Index: AQHdDMrP9Hz/SiqStU+fW87uE2fsaLZ41w8AgBJS5Wg=
Date: Sun, 2 Aug 2026 17:58:06 +0000
Message-ID:
 <SAWPR12MB9992679DEB9AFB41A21B116FDBB0D62@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<20260705220819.2472765-2-djbw@kernel.org>
 <20260721182046.16219426@kernel.org>
In-Reply-To: <20260721182046.16219426@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|MW5PR12MB5681:EE_
x-ms-office365-filtering-correlation-id: 6eb33291-674f-4201-eed2-08def0bf9ad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|38070700021|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003;
x-microsoft-antispam-message-info:
 EvSrkKnSoHXImGuio2/3hHwVgmAvM4wwZIMFKCSlKiGz9aNdvnK3yRyCncEzCDeAvqtL42kygHPpkjRCjwVcLvhXLPFfyQBBCkMejlPEbkAcDBxBL99abwXABWQ/5EJ2iPjKtr0bL7156qrN6Lygcxy9O6LNUIk7IF28F/aaHu9HrO9VbaBcin4H8XOyM2bFESOYO1CP4fn5OVNmJq5Jn9lK6XXlwt1BwX2+fjeyseRnBXaWmvlTl3MIeiubGqfbQq7le9hWzmGbFnsO9KaB4k2Nl8gdVt6HbToQx2jR4rtP+I1aZlxSxE3UaABx4dwjxxoOde3JHbQBIpAyiruWdVHpFXcmTlBDsmdSQan2oGUCArierJt8HBi5/ZRdh+S8FPRWntgXmepVZHISt01KBv1/y57hJ57g0TP1qnTOUFwKHlA9qFF8JAoNiln0if0BxSSiHXjOipElf32UO1HIwY4tQIZZPoR7z17et8V6GT6/tvvuyoP/AEY973y096ERMhyJSvk8GgDJdZ6UVBfX8PVoz66qDxw/TvwvqitvqXvsC2kZIMzVjmGAvsV7lI6oLO7OxLjgTu/i9RFeyu/gPvCBfMeGlFROSWGfkGIDejyNY6OuQM/G9Dtfh30GBhLFcBR+4Td8WunpKl/KL7bFLgjl2sHHZgxzkFS6vbRN2OqoZNyRV2LCDem9ZZwcSxpTy0cNrTd7ftWL0U2wcu1k0QguQbbPcoWgQN/YEaT7hx0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LottLhyPOzNvifVj2tt3wcsHfAvg7Q0C3G/EuYF3NmkjCsvbdGfUYaXyXd?=
 =?iso-8859-1?Q?pjSaRla6SfQMXhVMnVcjomdyd0OglB2bx11Yes3Nl/W/hQGW1xCMH+I+ig?=
 =?iso-8859-1?Q?+/fzi/ZLHFfBX8VvjVTOqXsAiqwr8oxpI6YqEknu6EEl8tN+CsUQMnJldr?=
 =?iso-8859-1?Q?ORY+G152xHgptj4MU4E6CCbDDWMMdMmbULnQVBa0KzJFPFlZC6AcGCog8C?=
 =?iso-8859-1?Q?kMp1E8Bq5HcraCJ7O16SVUWrm/CWbWB/UkgdVzRzFv59trHEwxft7KiflS?=
 =?iso-8859-1?Q?3sNaMIGbIXJYMCcEQ9n02W/ZzHypnnmx2B96WsJ1r4i2Rh1aVaCG1pwWKz?=
 =?iso-8859-1?Q?f6rgfizx3+p6sB8D6ETVmrRWOzuqmOI3CAFSsFHQg8btTHTcT1UlA2lViq?=
 =?iso-8859-1?Q?H/VRQ0VJnVR9bVCDFZVKjwFm/SfpfWD+4q0Jehn2bg8Fil0KPZZl/2jrBJ?=
 =?iso-8859-1?Q?NMb2g/qdl9q9ubiZWHZthArHTd9rSQguYXwM2X0QmI/94B0Ix3ZRxX+uzA?=
 =?iso-8859-1?Q?fWnJeCChA/YA2vW7GO95GV5AWRSlf/l+nZMdFZ+t9rRZJvdcbBOiJ0Z0e9?=
 =?iso-8859-1?Q?+oxkJa57Mr5J7VIllVohdjfOHgQY89RM1l35yjOJUPa/NZiLdGt5Xe3Cyy?=
 =?iso-8859-1?Q?ZZAM1Kd80Q7QB9ZQ8lT7G6DncSFwlyx6N4QweBjx0+hSn20ReTZV3b4cCI?=
 =?iso-8859-1?Q?3gitf88iSjnPryK/ZSXB2GQPYuw/oRBWBBWWZZ28sZhksO7b4350UMuCdv?=
 =?iso-8859-1?Q?iKftJVpuzvW711nBq9eilynI5xbjyNaU/cbm7WptU+zZ8Vr0qk7OtFdWJf?=
 =?iso-8859-1?Q?7ul1K7+HogsrRIMpMyp/uOahFQpp+Yn6CXqaVpB2lIapOfCMkYdwEKt4JH?=
 =?iso-8859-1?Q?Er6gIIDu2UGQhzkKwCUZgyaH1UcmZwJHaapSQY2dOeDkYH0xpatpmWcqpS?=
 =?iso-8859-1?Q?MTLviaklmJPzFWyfCuGayCtv5Kj5Bj8yMW9IkxqUbm7MY4AT7BnaH0dGS/?=
 =?iso-8859-1?Q?fmBIRlgLcN0oQqSVymUflV0dmXytzd71nRAOIk7RBShd61VVazrXQVNsrf?=
 =?iso-8859-1?Q?FSYx5fzHz+5aphsnDb5eiGZGTtrH87NFzSkVZqwl7hoGDU606iodeIE5zL?=
 =?iso-8859-1?Q?DNhE0zGSJ2lRQJvpMSqhncUm0axc0IVKiAamNVZ7iP0vDAop221c3lwe9s?=
 =?iso-8859-1?Q?EeArkh8O6eHZwfPCCKJiof4e0/cfxV75iYudimM2JnkItL1OGEVlLp9nbc?=
 =?iso-8859-1?Q?gxe+y1Pv0BDxiQF3y/mIhlQoTJCuIhadA2dwcniAuQn8wfJUHleza7nLMv?=
 =?iso-8859-1?Q?M4mz46/fvNcG2vwOwr1hSyXZwoo0aIgotOIopfGIEOqwsdl5Mrnv72azNo?=
 =?iso-8859-1?Q?YR5s9XkSsys0aJZFR1squHGjFNKPM3vxkfddriTyenvzNu0HXEPJ2yqdVc?=
 =?iso-8859-1?Q?0Wg4VVec5PDThgqrxS2MALXuZaMLzAoQEhcOVpntaqxYodQTGbZR6fSfue?=
 =?iso-8859-1?Q?7TXxDMMh8Y+/ChNh12XiuXHvA4kpIxec8k9wG/GRFuoKl/CBFlYItxJpQN?=
 =?iso-8859-1?Q?46AqqQSEEZjg6Vr9hKrElwCr9MpGNnCnW/jPot8/vJ88Gwr4eKR0+bcBEA?=
 =?iso-8859-1?Q?CK3gWHTvBK9fMR34Gh3lycQpvKBLgagZy0yqHCW6PWW2jasn+Be0/nnSMT?=
 =?iso-8859-1?Q?7vokFyRqY5isikMDCcV+QC21qJZS0l3PwP5ee0HUfi9G2E8ec0E1faeCGr?=
 =?iso-8859-1?Q?sObb0orSgVfyNO6xm/hJ4vSapbZUPIloxiRVGmuurL6Gxh?=
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb33291-674f-4201-eed2-08def0bf9ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2026 17:58:06.0312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrepJ3lHtHpXSjM+MEeHqOBF4EatjjS7TOpFEXir27ZL+4KwOWzp6BDBptH1aTrp83qUnqfh+d7ZKGhLP5aFoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

> I don't like this, sorry. You need to come up with something outside=0A=
> of netlink or more netlink-y.=0A=
=0A=
Hi Jakub, picking this up and continuing on with the Dan's work.=0A=
=0A=
In an earlier discussion [1], two options were mentioned.=0A=
=0A=
> Alright, so to make this more Netlink-y you can either:=0A=
=A0=A0>=A0 - delete the F_MULTI and replicate other attrs in each message a=
nd=0A=
=A0=A0>=A0=A0=A0 add an offset attr; this will make each message in the dum=
p more=0A=
=A0=A0>=A0=A0=A0 standalone.=0A=
=A0=A0>=A0 - keep the F_MULTI but object_val has to be a multi-attr, and th=
en=0A=
=A0=A0>=A0=A0=A0 we have to teach YNL to correctly append the attrs.=0A=
=0A=
So I'll update to the first option of standalone messages with an offset at=
tribute.=0A=
i.e. every dump message with a new offset for the chunk it carries and with=
=0A=
reassembly left to the consumer. I suppose that aligns with your preference=
?=0A=
=0A=
[1] https://lore.kernel.org/all/20260318170014.6650d2bf@kernel.org/=
