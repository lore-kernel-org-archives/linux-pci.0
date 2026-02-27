Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356030C343;
	Fri, 27 Feb 2026 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195764; cv=fail; b=QA+4Y8YQHKYyPXf6AZ9s9uTneeaLEXEPGg9hl0l/80e2WaHVwhU/vO7MeQ4zPZ7s3LU6veEqa+m1gahaeh32+I6k3enCAHe5MRjMxTZlMcwhWQrJswFjPe9hgza946JabXLC2Dbmkn0IpEW6qqUtoautjbswCxU5xevGDVmnJcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195764; c=relaxed/simple;
	bh=msIpQfezxXvxn4frL00dhHaiYmqfKCQjhQIsDyPvds0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EfMM+ypqd6h44qwCUwUm4A5eWJ6h4U+JSwesVAagslo2W9nuOi/lscmvhMUuckSEaipfGhY0xlaJjRGO68QJ18/Vssdp05DrpH5Q6lApZjRgU8Ob35qmIQ4KcuBjAKJi+xpabD2MO0eihphe5H0uSOQQ1uDupdAf+surob1T1YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jey8Camb; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jey8Camb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOsIU8/JwJHI0xOZaH4wfzGbk3EP4Ehl4WrIMKx26f4ee5RIvYAZcFXTRS6sMA1J1ly8b8EecCv1fsKt3Vfe6EEt7npIRjrXYmOGlixP2Bl1uR+IE/nHQVjywV5E+1H5LbVZNO8TNNEpqmzxK4Yc1aPt9EP3/w3E6Uh3177LFgc1AGd06dpZsiNG59d7BA+Y9eMgmsFKPfo5GROWqeO/BZAIRHEqG8qlLaESUSlJjeDi1waLyDd5r5qmzt3V1pQ+Xv08uq7+INOx/bOaQA+MrBRnKI1J0mfquxJ4V4zlax5Dpls1xJiyuK+u8pDU2HRV53z7jROAjrVIXWnxCE5zBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msIpQfezxXvxn4frL00dhHaiYmqfKCQjhQIsDyPvds0=;
 b=qU5g1eyT3V36OrRqG8XlL3aqxEngH0geclYLAKv5DI1c6BvtY2V10SPMz3/HUPLDp/B5Ca3GZqiOHPmtfwRFKrCov9atZ048q+P0uAiwYqMNMOWc4ZsM7oTvlAyNjiSWHOsM4X/dbVboTDALd6sN9kvePwXnh/2lGrJ8G5OvijT/hWLWzhNXZJbcb1PYZUSb9GnyNI7Pc6gUZdJhwCgvc3WuBGTyYth8NiANTZ8zTAeOBQgEvCU63PtSTVN8sNNaXR1hzzip50z/6yEW9Dhn36klui3Gm26k+oCvbJ4SojP1YEIyeUeuGddfAIMobASS09Lo7TnVEirmvtnEI3//Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msIpQfezxXvxn4frL00dhHaiYmqfKCQjhQIsDyPvds0=;
 b=Jey8Cambs/VwKr0P643BGV7IyKJkYJ6QajkLJJVxnq32Qg61eLsstoqWGnJPsbU+pYa8MHM83QsLnZYZQ7SojjW2QmJGCcxamYpjrNwwx+GtmNBdeLgRFhjKqrXSc8GsGThtWqEJ1jzm2e6MKZTm3Nza8PVIe1pwH2FtcBcEb6TOeu3gbF5i+0pnmlcuUM+eUHnbulNXnL1q01QMG/0pl9Y/TxyxATntnbp7S5+kxDrl23c0cwhjCneM387e3VIBgsFyKzlu35vOYcPx6aSk1pQfKl/aYEbMzqISVIT2mp39OI9OaNDQYp0BdfOcj3x3y4iJ31XuxDf6gwBXlt2R7w==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Fri, 27 Feb
 2026 12:35:57 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:35:54 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jon Hunter
	<jonathanh@nvidia.com>, "kishon@kernel.org" <kishon@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"den@valinux.co.jp" <den@valinux.co.jp>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"cassel@kernel.org" <cassel@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during
 Endpoint interrupt registration
Thread-Topic: [PATCH v6 3/9] PCI: tegra194: Remove IRQF_ONESHOT flag during
 Endpoint interrupt registration
Thread-Index: AQHcpPTFgd/Rj6JzyU6v2BaN8w7lYbWWgU+A
Date: Fri, 27 Feb 2026 12:35:54 +0000
Message-ID: <27efc115-959b-47ed-9ef7-b79c8930176a@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-4-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-4-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|SA1PR12MB6680:EE_
x-ms-office365-filtering-correlation-id: c245580c-02b6-460f-881c-08de75fcbff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 urfSoEHWGkgePN723vJWQgsAO1teayBGLJ0U4P7wlVJYbOjeU9uD6MbScREiC0sjzJilIZBqpQV1A07cATFgzJiJt9P9JUxRnyB9W5kVHxFoeh9H8b8nAnhvzu4+pDFzW14O1oXD8oJ1necjiC51zdRy57jb1gkljCT+0js+6TM9S6b1OYF7h6QNQxchcP0b6/njX0gSMuB//bwai7CO5QHp/N1wKBc04Fg/hNyMKuNh1H7lxAeM+sWI7HvBt31YfpnX+WK+Mz4NVBFuIMjbWb04/+shJNDdr3lOJ+7lRF9rx5d7gIeGo1YoEqWIDkYtCqfDD/MpYV/vP9Pb+H/5tZc3MwGTvH5xuNTOPvzNpSTYJPSij+Tjz3pToKShuCQfuPSeu5n6bw1ANjcrgwzRUi7G+e2MC1JA6fDVAWkia7CiWV3/GYxqX/lPx69byhIA4KOQ919KRDinFa0hYCAryU3aSF7tcpEqGjUFQ1tanhfZ3uG+fyAoRONT2Ird5YyXmCoRYnmc8zAvQZxGmgRTttIknSe5wkSEmc4t3Oow0F+CQzO0hA8CT8lU2NEuWvM7PBUj0Wx2pEMnFytHunZZB9OQmPB1FR4zd1XY68crrKMiL0L8zzmfELbjVEFRNqZhebAhOxCfrHA6UsSEpvh757YIG5gS/H3VlUsqR5L6PBEovVycUk1zsu8P9HjLsHLhuEhfGJeWOBNqF8PQ08CfFVT1MbF59u0FXBnPSt17RvCrpbm39g5rQJEe3QAxmtqp4SmZ+JKvM72SrTw9wrxqXst8rx9jXfch2HR16GWSknvLjeq/EW6GzAuZtspTtRWt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXZIMFBFSjZVS2NBcko4Q2hTSC9XL0FDTDlMeUd6dGdST1NNSjlsNmFDRnRM?=
 =?utf-8?B?azJnaW91WjRDRFRuNWJOVzhCOUtWSjI2VS83bzc4RWhQa29tT2p5SDhHb21o?=
 =?utf-8?B?SEx4b3FPc3lmK25jSzNWcU03L0RLQ1lkKzhOWEsxMkdVMmFNNDlzQld0WTNp?=
 =?utf-8?B?ZFk0RDFvNG1odTRMTTJwamh0K2xDVElvTXJHV2FTRnNjK0lYSnNkc2YrT0ln?=
 =?utf-8?B?aE5yRnkxdzd2VG5FVnVlWERrK0E0Zy95c0pHQ0F1M3JrdDhCMnd0MGVPM3Fk?=
 =?utf-8?B?Qit6U3orQWF4a3FVUlZkMVk5VGlWQjFCYkpVdHhybDd5eW93NE1hTjVIQ3Zi?=
 =?utf-8?B?SlBTRGRiNCtFZHdtbEFncWlvTVpjczRUUWpYdUk3dXplK3ZKMnpmYm8vcVE3?=
 =?utf-8?B?ZEpwVEs4MVlBOE93ZERoZlRhZWV0emxhNjRWbVBWWTBVbVAxNndSNENxTXBp?=
 =?utf-8?B?Q3FHbTNjenQ1QVl0djRWZjJvMHZ1NWtmcEdxaTA1VXl5MXFBN2R5SkU2bnFs?=
 =?utf-8?B?cURHZ2VJcFUzdGRwUWo1SmJURTZlenVnVG5aTDduMk5yQXBKNXZXNGxOc09N?=
 =?utf-8?B?TEc5eHVGb3pUdlhvT0pxRkJWYTV2TFh5eFVqaVZsRlBabVFuZXlzdUVEUFB4?=
 =?utf-8?B?MlFROXZrRXdYK0hWaVFZK3R5bmFNTndOZmxRUVZKcFRXcXAxbHZrR3BydHRT?=
 =?utf-8?B?WUV3MUt6NW5tQTVBNk5USElGNTFGMGNoSjRtbjd2WkVwMVhQazVNczJ1dGZq?=
 =?utf-8?B?S1dkQU1ZZFpRMVg5eGFMalFWMmJJMGx5cm5PVGErMzIxQS9yUjZmcFMvOWtZ?=
 =?utf-8?B?N29OSEdLUWc4RVFSZEhQdjhwWlRKdEZEL3dHUUY1VkMyRFdXekpWYlVqYUMv?=
 =?utf-8?B?UHFKRzA2dlpxU2VJemJyRXFHSHpXNm1KelFBTVpiU1dpVXdyd1FpTXU0K3VR?=
 =?utf-8?B?KzRUTnMxZ3RudEJDNEpnNzlFT0UwY3QzWk9mRTdITCt2QXZDNUgrekRBZThm?=
 =?utf-8?B?TmhmdE9VVW1uQ0hFb21zK0Z4YlUvYjN3TVhUWmRqMldGam1tNHB5ZkVvMDFk?=
 =?utf-8?B?OGFjMGlDaXk4MG55Qkp3Z280aXRObVZhcjVLc01qQ3ZmUUJpRTNRNVVmTUM5?=
 =?utf-8?B?QUZzU0gzSTVGeEtQNUtDcU1ZTzhuVnJQVkN0My9WSXRkS25GOTR0VUtsZmN6?=
 =?utf-8?B?NE1MQUhwNEZmbkU0U3BWQXgvV0NndkdYSDZXRWtWcGtVVEZxUzUrbXNLYTc3?=
 =?utf-8?B?V0lrb3ZMbjd6ZWkrYUVHa0R1VG9KOEpJeUR2aHQyWTVCbFk2TVFqd2hhM1E3?=
 =?utf-8?B?NURsWWdHa2JpU1N6MkI5NmRzUW0zNmx6Y0QvNnZGQlo5bHhEL2o4R3VqeUlD?=
 =?utf-8?B?ZEN5aDllYlRqZ2JZMW9mbUZpUVUyZ2RaLzJ4T0pYQW5jQ3IvcWNWSjZubi9H?=
 =?utf-8?B?aVBLQkg4Q0ZMTDRGMUtMT0crMmRXUTFFL1JMV2RkUlZCNmhOUk9zSFJWZklK?=
 =?utf-8?B?NzlwS2NYSHZCTnFGQUtPdFE2OU9VMTV6WmtiVDNCV1VodGE0RWFZVWV3QUN0?=
 =?utf-8?B?ZHYxTHFuN2V0czR5QmkwYmNnc3UzUHFFcHU4L1daQVpaMkJTSk9XUFFJKzBx?=
 =?utf-8?B?bHlwK3dpSzVVTWlUaUVjV3B0YVBGanBNTjduSHdMeURJdFhOZGlmN1paYy9o?=
 =?utf-8?B?Ym5lRy9wQk5NajdnbmQ4akJId3lZbzVGWDFyME1qRjNpSGxEZFoyaDN6cTlv?=
 =?utf-8?B?cXFXK2dOaXV4bUZLMVZoZEhjWThYZ0Q3QlRzMXBnR1ErRUl1UHI0MnVOellj?=
 =?utf-8?B?U2ppa1BFMHAyTGNpdiswVlArOGxIZWhmemdHdW1HdkdFTEJyL3UwV0VydHlv?=
 =?utf-8?B?SS9NNWxwcXI0anE4UWgyVTJ1UE5BSnNZNE9MQWh1ZlBGenJWUGN4NzFCek9x?=
 =?utf-8?B?Q2orU1ByTU12dGwvcHhLZ2JxSU4rMDBONEg2UXo1WlNsUlRGdUdnOTMySnVi?=
 =?utf-8?B?cVF1amoyRWhaTTZLNktlMHpRRDFhZm9Nc2k0U0ZqR05McmdlY3RxU0ZZODFX?=
 =?utf-8?B?eVRHK0QrRU5CdVNNaXFGdlc3c00xdmhGZTl4amxibk9NbXZkVDZscTlmOFN1?=
 =?utf-8?B?d1ZmK2tUd0t6a2d5RFVGVncxUEc3YmMwR25acHBCS3ZWVmV2L0tLT2F5bnpv?=
 =?utf-8?B?dDdXMStCd2Q1Qmp3b2xGVWg1WWJ6QlZqTWcwTUdMNTFma1ZUYWVReW5DZE5v?=
 =?utf-8?B?NXpRM1hKMWdTWE4zd2F2Z2hEU0lCdFpiaUJxT0lPU3hGR2lweDc2THJ1Nndr?=
 =?utf-8?B?ejRxVjdzL1FDQnB5N2VoeElzUDZ3Qk9KMEExS0ZKNGZEc1NnbzZFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <843C395BD61B2443B11ECB36710FDAEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c245580c-02b6-460f-881c-08de75fcbff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:35:54.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Dhne9mk6TY4tCjYzPKX/bhcUoELAK+HTEU/aChqLPkXhG0Qp+tDW/YeJMQICnhKdN2xxixQFnVUSpNnqvU9mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBUaGUgVGVncmEgUENJZSBFbmRw
b2ludCBjb250cm9sbGVyIGhhcyBhIHNpbmdsZSBpbnRlcnJ1cHQgbGluZSB0aGF0IGlzDQo+IHNo
YXJlZCBiZXR3ZWVuIG11bHRpcGxlIGludGVycnVwdCBzb3VyY2VzOg0KPiAxLiBQQ0llIGxpbmsg
c3RhdGUgZXZlbnRzIChsaW5rIHVwLCBob3QgcmVzZXQgZG9uZSkNCj4gMi4gQ29uZmlndXJhdGlv
biBzcGFjZSBldmVudHMgKEJ1cyBNYXN0ZXIgRW5hYmxlIGNoYW5nZXMpDQo+IDMuIERNQSBjb21w
bGV0aW9uIGV2ZW50cw0KPiANCj4gQ3VycmVudGx5LCB0aGUgaW50ZXJydXB0IGlzIHJlZ2lzdGVy
ZWQgd2l0aCBJUlFGX09ORVNIT1QsIHdoaWNoIGtlZXBzIHRoZQ0KPiBpbnRlcnJ1cHQgbGluZSBt
YXNrZWQgdW50aWwgdGhlIHRocmVhZGVkIGhhbmRsZXIgY29tcGxldGVzLiBUaGlzIHByZXZlbnRz
DQo+IHRoZSBETUEgZHJpdmVyIGZyb20gc2hhcmluZyB0aGUgc2FtZSBpbnRlcnJ1cHQgbGluZSwg
YXMgdGhlIERNQSBjb21wbGV0aW9uDQo+IGludGVycnVwdHMgd291bGQgYmUgYmxvY2tlZCB3aGls
ZSB0aGUgdGhyZWFkZWQgaGFuZGxlciBwcm9jZXNzZXMgbGluayBzdGF0ZQ0KPiBldmVudHMuDQo+
IA0KPiBSZW1vdmluZyBJUlFGX09ORVNIT1QgaXMgc2FmZSBmb3IgdGhlIGZvbGxvd2luZyByZWFz
b25zOg0KPiANCj4gMS4gVGhlIGhhcmQgSVJRIGhhbmRsZXIgKHRlZ3JhX3BjaWVfZXBfaGFyZF9p
cnEpIHByb3Blcmx5IGFja25vd2xlZGdlcyBhbmQNCj4gICAgY2xlYXJzIGFsbCBpbnRlcnJ1cHQg
c3RhdHVzIGJpdHMgaW4gaGFyZHdhcmUgYmVmb3JlIHJldHVybmluZy4gVGhpcw0KPiAgICBwcmV2
ZW50cyBpbnRlcnJ1cHQgc3Rvcm1zIGFuZCBlbnN1cmVzIHRoZSBpbnRlcnJ1cHQgY29udHJvbGxl
ciBjYW4NCj4gICAgcmUtZW5hYmxlIHRoZSBpbnRlcnJ1cHQgbGluZSBpbW1lZGlhdGVseS4NCj4g
DQo+IDIuIFRoZSBoYXJkIElSUSBoYW5kbGVyIGV4cGxpY2l0bHkgY2hlY2tzIGZvciBETUEgaW50
ZXJydXB0cw0KPiAgICAoQVBQTF9JTlRSX1NUQVRVU19MMV84XzBfRURNQV9JTlRfTUFTSykgYW5k
IG1hcmtzIHRoZW0gYXMgaGFuZGxlZCwNCj4gICAgYWxsb3dpbmcgdGhlIERNQSBkcml2ZXIncyBo
YW5kbGVyIHRvIHByb2Nlc3MgdGhlbSBzZXBhcmF0ZWx5Lg0KPiANCj4gMy4gVGhlIHRocmVhZGVk
IGhhbmRsZXIgKHRlZ3JhX3BjaWVfZXBfaXJxX3RocmVhZCkgb25seSBwcm9jZXNzZXMgbGluay11
cA0KPiAgICBub3RpZmljYXRpb25zIGFuZCBMVFIgbWVzc2FnZSBzZW5kaW5nLiBUaGVzZSBvcGVy
YXRpb25zIGRvbid0IGNvbmZsaWN0DQo+ICAgIHdpdGggRE1BIGludGVycnVwdCBwcm9jZXNzaW5n
IGFuZCBkb24ndCByZXF1aXJlIHRoZSBpbnRlcnJ1cHQgbGluZSB0bw0KPiAgICByZW1haW4gbWFz
a2VkLg0KPiANCj4gVGhpcyBjaGFuZ2UgZW5hYmxlcyB0aGUgRE1BIGRyaXZlciB0byBzaGFyZSB0
aGUgaW50ZXJydXB0IGxpbmUgd2l0aCB0aGUNCj4gUENJZSBlbmRwb2ludCBkcml2ZXIsIGFsbG93
aW5nIGJvdGggZHJpdmVycyB0byBwcm9jZXNzIHRoZWlyIHJlc3BlY3RpdmUNCj4gZXZlbnRzIHdp
dGhvdXQgYmxvY2tpbmcgZWFjaCBvdGhlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNh
Z2FyIDx2aWR5YXNAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWFuaWthbnRhIE1hZGRp
cmVkZHkgPG1tYWRkaXJlZGR5QG52aWRpYS5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIFYxIC0+IFY2
OiBVcGRhdGVkIGNvbW1pdCBtZXNzYWdlDQo+IA0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS10ZWdyYTE5NC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS10ZWdyYTE5NC5jDQo+IGluZGV4IDUxYmFkOTljZWMzMS4uYWVlYzVmOGI5ODQyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS10ZWdyYTE5NC5jDQo+IEBAIC0yMjI2
LDcgKzIyMjYsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX3BjaWVfZHdfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gIAkJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShk
ZXYsIHBwLT5pcnEsDQo+ICAJCQkJCQl0ZWdyYV9wY2llX2VwX2hhcmRfaXJxLA0KPiAgCQkJCQkJ
dGVncmFfcGNpZV9lcF9pcnFfdGhyZWFkLA0KPiAtCQkJCQkJSVJRRl9TSEFSRUQgfCBJUlFGX09O
RVNIT1QsDQo+ICsJCQkJCQlJUlFGX1NIQVJFRCwNCj4gIAkJCQkJCSJ0ZWdyYS1wY2llLWVwLWlu
dHIiLCBwY2llKTsNCj4gIAkJaWYgKHJldCkgew0KPiAgCQkJZGV2X2VycihkZXYsICJGYWlsZWQg
dG8gcmVxdWVzdCBJUlEgJWQ6ICVkXG4iLCBwcC0+aXJxLA0KDQpSZXZpZXdlZC1ieTogVmlkeWEg
U2FnYXIgPHZpZHlhc0BudmlkaWEuY29tPg0K
