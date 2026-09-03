Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040FF400991
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423102; cv=fail; b=gkDuPKK1nDomxWj0Z9VLKiNZRkbFYMyMWCwqUszDZMcOmYGfDGo5kVFcmiBbl0t/kc+DRUtKAdXa0T8RNibQp3CATlDN45Ww1/KTIjy+iwl1ydSdPqT3i8m92NKkxDZEEZidVnq04sip1uE/Rb4c6KcOVZ/V/EX00+prqZWEckc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423102; c=relaxed/simple;
	bh=jOs18nlgaX+w6YQgzxrgOGOzUCpHdmPC4pXHTBNDv5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NrwTlzbn3AkpEXuerI72H/yOUiQXHc083xDlXtfnfLHQ+ZG3nQ7a6u4bh8ftgS6AHQNYYdXibSOS5qGaucOXUEony7lmsO1n9jmhphxOZJ7ouzmnbT6CK2Yo9KqorEwGmdFse22TucmyFj61/lWoMNUTuIQLEO7mhyal0raDV18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S5HLTvRx; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S5HLTvRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5h/CqDqYi8tln1XYBAYjrW2X0aHaMcFrHD5vJWlBiYQz/hvDK7NX5QXooTInY+ame5rg7H+QKRiPLQkqG+vPxHyIxfqYIEKUlK9MvqFNgQOLi4dr2qBSlTZxe8SRyxm5bTEx0Cst3fI5wAYoWdK+/TuSoc6bzTdxy1VE0V2WOVK6j5Ol6dH215jwhESFwsRTcDnfl6xlRAhJv4uR5AGWrQM5pyTvD/oVktnIUd4IVOju9GWoDDEeGMGp75k5zwXSSqXxO3M/unMw0sZy429YI5FBAlAuUnPej9hcVz5FsWGuuGBw6LkNAN5C0Tzg/wwxGA8uSxNaH9K7nbnTOGHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOs18nlgaX+w6YQgzxrgOGOzUCpHdmPC4pXHTBNDv5c=;
 b=C001sLMVSMjVG5XyqPhmdowVXw/MIPbz2h9KMMJdnfDeUeGxFFJ7bJJKkyfEIvKx52WihFWIT3kaWDt62y6ZFJLFKYTvTuf0xDXEzVAvwKHYgcypkWdmThVtEgmkG5Tq1ABdeq17e6i4Tz/s67s2tp4a8VxMl0L/R9pThN8O3gxCKgKxwKCTP/KW6G5TygIlFmgTNw8TENcenVU1C05N5UsPmCA06q9Z0eUAnEUwOsTVbaYMIMhbNFD8NHiC7nhxLdYG47HB/Jo77jkaz4fKsQUOv8MI0O6ZDxgeor55PekDrlx2JZtRh4xYq1O7yRGHiasIWZtL3JW/gWmpYm88Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOs18nlgaX+w6YQgzxrgOGOzUCpHdmPC4pXHTBNDv5c=;
 b=S5HLTvRx31OYR10z+3SKy44AIjCxj2pjUCEU9wmE3o3YL3xsXc0WyY2W7rgh0/Kf9KwnIi5rUaemAUdBr2Vkmx5em2jPR51AqTUQY/gZ2eUttXUj39duyj07V46bPw3pWGzArNNZEi46zz9rSTtRGVxrqiOqFi1MUx4UrgKYD2tByoMjgIWmzyi+nPbhNBp4VxU2TKOFrwwwghj4FFpSUe0LfiMiebNWxFocw9q9lSmmysMHR4Dp6YfqMa0mCLwJUfjiQJYSWYmEPwHCDYYQLVc3VgLrGt+S50VElMrUc3udiPkA9d5bmL83I3PO3Z63/DtLOx78hO0rsuYi25LjSw==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by SN7PR12MB7809.namprd12.prod.outlook.com
 (2603:10b6:806:34e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:11:37 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:11:37 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Aaron Tomlin <atomlin@atomlin.com>, Alistair
 Francis <alistair.francis@wdc.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>, Donald Hunter
	<donald.hunter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Lukas
 Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sami
 Tolvanen <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "yilun.xu@intel.com" <yilun.xu@intel.com>, Jiri
 Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
Thread-Topic: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Thread-Index:
 AQHdDMrOwfwmCkkN7EeGRZV1a3LRYbaCujkAgAD+F4CACZTNAIABg4qAgCwWtACAAAJogIAA1ICAgAD6zQCAAA7FAIAADOFp
Date: Thu, 3 Sep 2026 08:11:37 +0000
Message-ID:
 <SAWPR12MB999267E6BD07555203A5AE6B5BB0B62@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050> <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca> <yq5a5x0mzxhz.fsf@kernel.org>
 <20260903065156.GX24140@unreal>
In-Reply-To: <20260903065156.GX24140@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|SN7PR12MB7809:EE_
x-ms-office365-filtering-correlation-id: 419ded2a-099f-457b-20ab-08df0992f9cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 ovxhhH/O1ZHj4rhPbKnBz8G3nsFRosQumM2o1nK9R4zlg7dqTIWQjf/p1838uTnQvYBoT7S3SmNm1JLc589wi4oNIwvL4GAkAOrhxZgixwEmAE0yym+hDmSMM3Wx4m148LBXHuuhWV559Tj0GiG2Ry/nAq1ulc43o97eGzDfBdoUyEDg/xzlJizq3AcmorCcqyAEJX0DorcZxT66yw9dn4UozOw6i2bzaD9qDQ7fuOcamAM3BwlpFWN9/iQRXF1+L04MF18lJsPOaiu3Is/UCRqYc7GXKZJ+LEfT8IuT/dM/5673qgvD7hFZccmjx14cHYpnMqIuwnk4OUoFiZZEu4FZyvdj7+UQcPB5pB2QllPxkl8rlX8BoVmJVj9/uA55sOJopusxPfENXdAYd5LwCfQfwX4Hlq03DvaRf2ENXhEVpP11v93dWd8P77si8JtP8ddLVZqY3PJ6jJMlrPFx81s0K6Zul5sITvpRM2rFDcb2pWHPIPlI+3Jy+80BDK/QqsddXXLNEoMm5winVTnx7/Lx37lzwJi5F6A5VYxU7JwvVu5Icf31UoPAsnOBwBqR6+q/mckRkUyV4zw/aSRToqEXrqgEyLtV2amFsZ+2CXa2ZZaKs/2pyVkD2VmqDvGwRZdxZ4d4MU20hU/XF+swQO6DXeO/9TgGu652JnEL/LoWbr1Klz+w9kp9OJAsaMgH3JGT6w5aOG72xtR9RZF/SQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?sYX9ux03PwLVrsFahqRUPds4Gy5dj4zHwzutQmD5hygXzrpxfJHhPAQK6q?=
 =?iso-8859-1?Q?b1UDdHXYS9qkUrVQcw47Zc9bEmzq1WYzPPci5vNNjGCSv7VtNAJG+hDFQK?=
 =?iso-8859-1?Q?XiQlelJjWgWDacrjFvlW6uRlrUMjYQophJapNCElZXouyy/rIE2eL1MCMa?=
 =?iso-8859-1?Q?byQvON7D8kbO3M6CTB5QYoKx4yn0st2iAPpjb5kW+CSWtpTCvb7fnFuHCL?=
 =?iso-8859-1?Q?38QXW4v76EJDQA9TKNN4ypoNHj7fl6jx7iQXBThzNvtWEPImJQkYkH5Jwk?=
 =?iso-8859-1?Q?r+j73tzE3YI9Pz1W7AOUrjrGVLp1ln+vshcshiGkamocLCI398hqDLGeFd?=
 =?iso-8859-1?Q?j6FJJqZdmepwbhrGIO1D4qentRJpo2LbDq9EWrx5DK23ESDi/GZ2CAyC/x?=
 =?iso-8859-1?Q?cVJXvhU/rdksYjTyEPfNTjIfGfDvu3iq0I/WQFYEb80fzaa6qB1VZ8bH0t?=
 =?iso-8859-1?Q?zn8EDZGpcV5BB0E/01r8b0bauKhVL+Nyzwfx8Y4kbVsKlJnvAMLXUB15pi?=
 =?iso-8859-1?Q?gZrvQgj3KyMm4gY2V7pKtg5dc1McUzmm37aU/IkkG4Pn3ZS4iYu+xg8ZSR?=
 =?iso-8859-1?Q?rxAJEEYedncYjnpNESA+QZ9hjre7HCew1p3Gafnmcdfqi/rNBDNslMaXJe?=
 =?iso-8859-1?Q?3sqqsFDsS04hDHR6NMIn1WgznyDM10gD/Y1sVwWxry4LFSdAGv4N+e7OHF?=
 =?iso-8859-1?Q?aRBmbPJqNc7bIL/W8otwnl5nYAVA7X4ruExAK0PG7wbhAZbG3lDUdalDhF?=
 =?iso-8859-1?Q?xhKp6mKvBBFvNYMnxeWI314oHrenr3t3yjt2BDfN2cjnGWynNH7jjyoFLo?=
 =?iso-8859-1?Q?6wTEl4iwwX5VSCiztFEPc/H25CP184oBN4yWNokeeWKn0S8RFE91MLb90g?=
 =?iso-8859-1?Q?pp3snAH1FjbCF7guJS/+lEI2+vV4kvRJu0Cr9R8kLwIMv6TTAvSLGdsJiq?=
 =?iso-8859-1?Q?5KR7UbebATFT1QtUR80aQHJ0npew6NdOtG8HQeEfeCZret+Z8qso6AjdcN?=
 =?iso-8859-1?Q?EIzTOA6expcNbX0ApVCJqvqHKcBuM9W4v4Xbj6QK6BPSSNGcb3HpHMbUGY?=
 =?iso-8859-1?Q?Tqr9oARMvTaN8HNkB/0iykBDzekq3Y11yBcezPwDl4cGa+ZsDDS+mvYVNq?=
 =?iso-8859-1?Q?TXB9XdOfUDpV+0ffFu3nsdfw5cf1us0pisZbHMQ811PnvTuV935NA9DFc8?=
 =?iso-8859-1?Q?sVde0My955pzpss6P8rfVCDQEEvvZSvTfi4iPK4Iw35uUJWhcIp2vgcYAC?=
 =?iso-8859-1?Q?+njiEqkEXPomsz7iDoC2wqruHBQUBPijHjCYQ1RJfsMvi7rJ7ZgqSpK/vq?=
 =?iso-8859-1?Q?Z1sYDTZcYbBzLMHPCXgat2mh26cMV1GCen3arfk5eBT7fpi2EfoUjgtiBt?=
 =?iso-8859-1?Q?8sMkeWIWzWWNFOIKZVyvjMCHPDP0UASWB5zdabZNwbAdHswaJXQ8TEH7g3?=
 =?iso-8859-1?Q?bOhgjYBy+NuKln7YclImJCmSWGJKFAt+vS1u0ogGxftagpXf1yy/uegF5O?=
 =?iso-8859-1?Q?0hKHlBN2++wEOJo1Yp6WepF2wqxgzHGfcfTq2LnK4f/rYm3KU2tp8tSDLA?=
 =?iso-8859-1?Q?e4T2Z1pzSgIlyqukzIt36nJgNqf4rf0l+I+qcoykB7JOEKRNf6P69crpbI?=
 =?iso-8859-1?Q?MpNZIJ+Kq6MqzRQGDiZVi9F6sZmUjE2Xc12tmwNPFWquq7acljYxQJ1Rtd?=
 =?iso-8859-1?Q?0BVBxUu0AocM5zsbMW6avApO30uzE3BON1Gmsb5HaEsuNfnONHbRWtCQ3O?=
 =?iso-8859-1?Q?K49cQgQpJJQgMVJmKceRfsckc26pk+XhYeCdWvWsccwdG5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 419ded2a-099f-457b-20ab-08df0992f9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 08:11:37.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ozy6C5iTxpEFmU/S8iUumRfJaBOb1g5geOeXo26XfdkTnWA0XZXPbdeMWf0NU1fhGjwG4XKgMUbeZWpLGUb8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

>> Yilun -> China=0A=
>> Alexey -> Australia=0A=
>> Ankit Agarwal -> US ?=0A=
=0A=
I'm in India and the suggested schedule options works for me.=0A=
=0A=
Thanks=0A=
=0A=
=0A=
