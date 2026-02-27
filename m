Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57930C343;
	Fri, 27 Feb 2026 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195794; cv=fail; b=B436+y6Mtrna9lxf+E7+jXqPlD3kdzKhtTqvYCpyDNn7EW/m/yClUow8zQdoWdRr46hK3UEAP+kMObbVdb/cbxUcqrwW1mTcT7+BASdL0k+S/RYo92X9Co+Mf5YBRBQhFvAB3BNns/+BZu58y2rnMuIyHHt4M3sT5nlCClo2jL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195794; c=relaxed/simple;
	bh=JAHfFbz5XJbNum1a805V9AMGNhcfHqZ5KdtqpFPMLiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=grOSLHrkT2P+ecpqQdctzKb38qRAYwdq6CQHm49/LTFuHYSFE0I1Bf8Ebv1niFDSJF6JA2oyt6E4DlsHk26ZK1rvtHTmHCoDq5qEGFA0mQjGbHsNKiB/V6dIrecoouhrTTwR5tM6mPAn9oPEnwfXi7ZIoHvMIUIlr4+lzwhFXZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Js0Vs4B8; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Js0Vs4B8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvrP+StU4y+qsRLvRSnpG9iSnMsAdKL4TYPUNPtMRdhV/lSkC1hZU3MrNeRT9CkOfiFdY3YvMJTfNZJZbXpcgRHf8HELu5Vm5zi74v9zRMOj/jWvjnZmAcisdwdYG5FeW0oO7RRz3K/3LpnN6P2nH2WDiUW3cvJsgKWaVSfO0yUvslweMKXzoiHl4N+6EPzJGrQbkPUKWnZCKvpnvmGYVc3JbTUvesM7LUUdqv61ZGaFe5qb7XAaNPxx/uAMnH/6ag1z2dUQXi4sJxmZO8w0Of7X3WdTWpKwscxFV42GZwhQNCGBiyfQ6Ifwsx/iDqyHHeTewEgV+fkeZGSC5q31eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAHfFbz5XJbNum1a805V9AMGNhcfHqZ5KdtqpFPMLiM=;
 b=TRGkyfndwaUfVRXQo+SnUdN0hB48oDiT1M6Z8FCp3hzrkTplxJT2waCe9TjKdToh+ugXE3wjyfHNYnTK11wEwUGY94Gq67Wi3rR1IkDanm42HFACYTVFK4T+dQYSCqJ0EmeXcnZAJIf57qKIoLWP7f6UA4/FgsmBpOBc4obbNKnEjMOTVD+XjAGOqnwOdUGLGP7Xldmcg47dCOOXn1E99VdsKsHqBUt29JCmEOQZag6SROwA7YiZ9idmzG1UBfbFG8HtvevOi4ihg/mPdpoZ20tqcPhTrjX9WHFXXzp3zgtBaJ/5lXEyWdWPjIwKR7quonQwGgPceAlj45Mao6hH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAHfFbz5XJbNum1a805V9AMGNhcfHqZ5KdtqpFPMLiM=;
 b=Js0Vs4B8vd/Yv7SyQvhiQ0y9xC7ABvqOhOUMORDT2zaxVJ4PaZFOuFpBaYN4rans2ugGH8OF6YuBDBn3SA1NKX1UxTh8bgXbasilu3fB61W2XeIWeDYVIihxaaBWu61m3gOHxRV3DyyxO+eJ2vn31BgnLwRHuiOVP3MRxnw6Ad/FASAzbXeIxQTsnWbMKzTIdNmgHdOA8kuy5PFrpH3UOTFjcapjX0wUlU9594l1VOFN7SY8Koq9uABsDb+zdGbv6QiX/XSmLGqr/tj4f7Jkh0jq91Wlq+bENurqT6dqNS0QXHAzYk5xERWb5ys9if0at2GwD0nobWiyX32vIZx4fw==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:36:29 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:36:29 +0000
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
Subject: Re: [PATCH v6 6/9] PCI: tegra194: Disable L1.2 capability of Tegra234
 EP
Thread-Topic: [PATCH v6 6/9] PCI: tegra194: Disable L1.2 capability of
 Tegra234 EP
Thread-Index: AQHcpPTQI572vyBtMUycRvIuASTXybWWgXkA
Date: Fri, 27 Feb 2026 12:36:29 +0000
Message-ID: <a0438450-debf-453a-989c-11ae3e73367e@nvidia.com>
References: <20260223184538.3084753-1-mmaddireddy@nvidia.com>
 <20260223184538.3084753-7-mmaddireddy@nvidia.com>
In-Reply-To: <20260223184538.3084753-7-mmaddireddy@nvidia.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6744:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: 062530e9-3d30-4eae-bf31-08de75fcd482
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 4mypVTi+fHn8vf0NtKJzmSijErr5MIkDOOCzi/aUP3Dke8MpDcXZNZTAUFJpW00Mj2VbJtFOU9j/fb0aRsi/1jm8C2UPdMn7e6ChfLuqeN7W0R+w7QbjP1bQyChNjBG1Ie7Z7PAWwGbAPP2SvnjqHzFPLw+WhRs5aBehXzjnq4M1voxpme/ICfpPQnBvIXRmTuAEq9b4gjdGIDEJ6acxlUFAkypuV0rEiAl+CCIEJhpowzkrvoPA/MQRvf5tqXVWZ4+P+vF+epnmpjuWbBRoju9mN8IYeZlJSkSAQSXX9w3aTlYEITVKrvo/J0AHnbirgM38iQUFHpAZMNlCobaUtAeI7nqY8fmgrsl00tKe3dgwfbsGbrilRpJ6IJxzXXeZv2bY1G+dgwN14/a06czE6T3HtAa5DNS4WN652M6IcKMIQG9IqmdEOuYReWtEtK3fiJfB+9VxhozogZr16SUv2T/yVZskQrCd/TaeF6D9GuBTKdGahMZLmPF6pSaCg9huqaSNbZ19giz19376gMssPPS2V1H/eE2eWXz1ZQuvOj+ul5s8mkYHiadU5ePg8TmFngfCunrmDa2DcOPrAjJ2w7m/KAeKok0LKXtzJFlL1ZuyvJbbDK8ChezdqEfVxh8uyJIsX3y3GNI34k76VV1bQBfFOvrtBOXFFSmp4aL8dphRm8Qfl13Sw2fJtA22SJsV5vfGaRHksfn4mbCgo3UUFy+d5EKs/hjN+n0J3JlmIaZhBrPPTnH2epastcC4aff7xmkSI3PaJabkKP7vWNVZizYkfqFf1RTyvGhQvTaCBKQ2yqqk/tArRQztoTp9HgZL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjdKaURKbi9SSitSUG9SM2xQU3pha2RIdHVKU1VIeU9oUnFvNTFydEsxcjNj?=
 =?utf-8?B?RHRwSGg5dXhuWW10TEtXeDNGRVhnRzRNaUF1M0FXMkxFVkNyb3YwNVlXdzRk?=
 =?utf-8?B?S0h3TGVKVFhZZ2dvd0pxUGRxcTNzSlBKTE9MODZhcmJ6US9INlRBSmpMaDdk?=
 =?utf-8?B?UEN3ZnEvNlVsZUxuNTdvekswZ3V1eUNWcFNicW5CK0xMOHdsalNHWDg2RG9J?=
 =?utf-8?B?UnNZNWRoQVBpRUVUazJxcTVDSUZ1cEpxVEdxYzllZTd2dFkwVG5jbmVnY01i?=
 =?utf-8?B?L3dIMENkeEdNeWpxU3JWRnRJTit3NDRDSGxqVzBZb1lhN1RSZjRGVXZKTHYy?=
 =?utf-8?B?a3dqY2ozUC95eXF5b2NJd3NjUzhDVmhXYnpUbDd4ODVGR1o2ZkRZaEd6dDJN?=
 =?utf-8?B?UWxDSkZMaFdPbXVJTUZVWUdPRTFETm1DdHB0M2Y0SXUwOFhKd3I3TTNzSzd5?=
 =?utf-8?B?emN4ZGgzTEZ3VXlSTkJObXhHbDR2SE42dEZXUkRkZU0rZjBZWFdCU3JKZnlv?=
 =?utf-8?B?ODA3cnI5aEhZdnRkekI4MHFjbXZibjFKTGQrcksvbFZuUUFCL1FPU2JlUGJV?=
 =?utf-8?B?Y2VMTlN0WlFUUnhpZXpXWXJIQjdqY1lqK2djbXFsRmVRdmZieVhpQ3k1SnhZ?=
 =?utf-8?B?dWV2Z3g2aTRhSGJsY25JS09IN2lodFVOdE13TTJiRVplencrcEwvK25MYjFK?=
 =?utf-8?B?aXZOc21SckZKVEJZN0lIM1lhaWppc3NGSjJ0WkRscC9xS2hXUkd0Wm1hZFM0?=
 =?utf-8?B?dlBzb2lvQzErRlV3SzNGYzBPS1k4aFMxdVRHNDZxZWFvSjRVYjEyZU1iMVNp?=
 =?utf-8?B?Y0s3K0pGTzQ3UUUyNGNvNVd3S1lvQ2tSOFR2NTJydDQyR20zKzlWUytXU1pp?=
 =?utf-8?B?ZndyWTZGZEVuM3lHaEl6bE56SmV2aWZweGJCYy9sWjVwVDc0a0xXd08xaGE3?=
 =?utf-8?B?M0ZoQVE1QjVTUzVVcGxOazdOZXN4d09CYU0yaEZFZW1MVHRVUytkYUpvNGFr?=
 =?utf-8?B?K2N0S0I2Vzdsc1VLYUszSW5MTFVTTzJuanpwcWhRak9QNTY3U3oyZGltSlQv?=
 =?utf-8?B?ZSttUnBjMUU2c1VkSVo3T2k1SlhLbnhTY2NhcWE5K0lFbDVOLzJZaTFSMVg0?=
 =?utf-8?B?Ky90MlNsUExsMXhsVXk0OWNpM0Q3QW45OGFpSUhZTHNmYmNVc2d2N01Hd1c1?=
 =?utf-8?B?S0lwNTdCTjkzZHhVWVV0VzlJVDZteGxxYWRwMDhqeXpWSWJ5ZHB1ckN6L1I1?=
 =?utf-8?B?OGMwWWlLd1hJZ29URVVTbHNIMXRIcEMvVkRXb25xQXp6c09zVFJ4Zk5HTC8v?=
 =?utf-8?B?WXcvR2hNOWxoajVOeXBaVUR1alJzcXI0QXRVT25Fb2E5eHk1cmFQc3dpcE5J?=
 =?utf-8?B?UDdnaFQ0RlB4U2pUNU1nTmM4QXpBV2t4aFVRc2xucUNpdkR5V05zamRyUWRJ?=
 =?utf-8?B?bVF3VkRqZEZ0MmdzOWZXc3kwTWpkeHZ1czBsK3VyTnM5d2tUQTdqb1VJSkFh?=
 =?utf-8?B?OGxFT1hkYkM1d2RIMEtxbC8xNlZabVZDdXFyTVdKMkxoZy8xRVFKYXY1NHRl?=
 =?utf-8?B?cWt3YVprd1JOaUVaYy9JQ1BHalF6VzJXd0M0TzNGTGc3Tm1HbUhCRUdMSlc1?=
 =?utf-8?B?SGRNMFVFVFFrcHVUTEhHVVRBa3c4UzJDWkVyVjF1NTNRcnB1VWV6aWFJZUJK?=
 =?utf-8?B?dlpKSk9XaDZsNHBJdkpiVytEN0IyUHI4RGZNSkVpLzhLZXJvdVlwK1pRUDVt?=
 =?utf-8?B?U2Era1RmKzN3ZERKVjV6Mk9NYTF1dnk4Wmk3K1c1STNaVXBtL24xb1JRV2tk?=
 =?utf-8?B?UDVlTlBjZkFzUG9XMmpoTGFrM0FOSndkVHB4TkJuMyt5YkdzeC9MMGJQNHcy?=
 =?utf-8?B?NUFueU5KM1QyWk42WWRWZnpnR3BWODZ6YlVjeWYyVmJyUlZUK09IUzg4a1JB?=
 =?utf-8?B?bVU0TEFqZXZZS2RBVDhaV0FwNk42KzY0THFSMkloSGJQaVUxL0I0WlpGRXhy?=
 =?utf-8?B?c0J6cERuTUp3VUhSVlVkaHBjTlFsaFAyYS9RcUU5Ny9Xbm16K1BoTXU2VTZO?=
 =?utf-8?B?T29HYkRuNTlkU0UvMEpJSnkwR3NpcXNqb1hUQnRsM1M0SnhOclg5YTFRZmJi?=
 =?utf-8?B?V1FSZjhMb3U1TlZXSXFyclFNdC9tdmV2a3FpWmRvUzA4bE1NZEFibEZZekE2?=
 =?utf-8?B?M2ZPWUcveXh4RUtRdEtOVzFZNXVzMkFnQzJsS0JxcTI0U1FoM0ZCc3J2ajFk?=
 =?utf-8?B?S0QvL0kyT3BBSnJicEdYQ2J6Vnh4Rk16MkJiRTNaM3dacFEzbVRwcHRNL21a?=
 =?utf-8?B?eWpqL2xXajEvK3lma0xFMy9qb1hER1RtbjU2ZFhwbGpXWDJlOUxkZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <063FFFB658B3D340AF245D6542BA7702@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 062530e9-3d30-4eae-bf31-08de75fcd482
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:36:29.0654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JyijWSBdsTiCSj9nuM7SaHojePH7UJoMoxrVSmOAll1AH+kH/VAheBkZ/93PNEljytbKA0+oDiMFoGxk3sOJTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

T24gMjQvMDIvMjYgMDA6MTUsIE1hbmlrYW50YSBNYWRkaXJlZGR5IHdyb3RlOg0KPiBGcm9tOiBW
aWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+DQo+IA0KPiBXaGVuIFRlZ3JhMjM0IGlzIG9w
ZXJhdGluZyBpbiB0aGUgZW5kcG9pbnQgbW9kZSB3aXRoIEwxLjIgZW5hYmxlZCwgUENJZQ0KPiBs
aW5rIGdvZXMgZG93biBkdXJpbmcgTDEuMiBleGl0LiBUaGlzIGlzIGJlY2F1c2UgVGVncmEyMzQg
aXMgcG93ZXJpbmcgdXANCj4gVVBIWSBQTEwgaW1tZWRpYXRlbHkgd2l0aG91dCBtYWtpbmcgc3Vy
ZSB0aGF0IHRoZSBSRUZDTEsgaXMgc3RhYmxlLg0KPiBUaGlzIGlzIGNhdXNpbmcgVVBIWSBQTEwg
dG8gbm90IGxvY2sgdG8gdGhlIGNvcnJlY3QgZnJlcXVlbmN5IGFuZCBsZWFkaW5nDQo+IHRvIGxp
bmsgZ29pbmcgZG93bi4gVGhlcmUgaXMgbm8gaGFyZHdhcmUgZml4IGZvciB0aGlzLCBoZW5jZSBk
byBub3QNCj4gYWR2ZXJ0aXNlIHRoZSBMMS4yIGNhcGFiaWxpdHkgaW4gdGhlIGVuZHBvaW50IG1v
ZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaWR5YSBTYWdhciA8dmlkeWFzQG52aWRpYS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IE1hbmlrYW50YSBNYWRkaXJlZGR5IDxtbWFkZGlyZWRkeUBudmlk
aWEuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBWMSAtPiBWNjogTm9uZQ0KPiANCj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyB8IDE4ICsrKysrKysrKysrKysrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLXRlZ3JhMTk0LmMNCj4gaW5kZXggZjYzMDVhODgwY2FkLi45
NjU4MWZjZDg2OTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtdGVncmExOTQuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXRl
Z3JhMTk0LmMNCj4gQEAgLTI0MCw2ICsyNDAsNyBAQCBzdHJ1Y3QgdGVncmFfcGNpZV9kd19vZl9k
YXRhIHsNCj4gIAlib29sIGhhc19zYnJfcmVzZXRfZml4Ow0KPiAgCWJvb2wgaGFzX2wxc3NfZXhp
dF9maXg7DQo+ICAJYm9vbCBoYXNfbHRyX3JlcV9maXg7DQo+ICsJYm9vbCBkaXNhYmxlX2wxXzI7
DQo+ICAJdTMyIGNkbV9jaGtfaW50X2VuX2JpdDsNCj4gIAl1MzIgZ2VuNF9wcmVzZXRfdmVjOw0K
PiAgCXU4IG5fZnRzWzJdOw0KPiBAQCAtNjkyLDYgKzY5MywyMiBAQCBzdGF0aWMgdm9pZCBpbml0
X2hvc3RfYXNwbShzdHJ1Y3QgdGVncmFfcGNpZV9kdyAqcGNpZSkNCj4gIAlpZiAocGNpZS0+c3Vw
cG9ydHNfY2xrcmVxKQ0KPiAgCQlwY2ktPmwxc3Nfc3VwcG9ydCA9IHRydWU7DQo+ICANCj4gKwkv
Kg0KPiArCSAqIERpc2FibGUgTDEuMiBjYXBhYmlsaXR5IGFkdmVydGlzZW1lbnQgZm9yIFRlZ3Jh
MjM0IEVuZHBvaW50IG1vZGUuDQo+ICsJICogVGVncmEyMzQgaGFzIGEgaGFyZHdhcmUgYnVnIHdo
ZXJlIGR1cmluZyBMMS4yIGV4aXQsIHRoZSBVUEhZIFBMTCBpcw0KPiArCSAqIHBvd2VyZWQgdXAg
aW1tZWRpYXRlbHkgd2l0aG91dCB3YWl0aW5nIGZvciBSRUZDTEsgdG8gc3RhYmlsaXplLiBUaGlz
DQo+ICsJICogY2F1c2VzIHRoZSBQTEwgdG8gZmFpbCB0byBsb2NrIHRvIHRoZSBjb3JyZWN0IGZy
ZXF1ZW5jeSwgcmVzdWx0aW5nIGluDQo+ICsJICogUENJZSBsaW5rIGxvc3MuIFNpbmNlIHRoZXJl
IGlzIG5vIGhhcmR3YXJlIGZpeCBhdmFpbGFibGUsIHdlIHByZXZlbnQNCj4gKwkgKiB0aGUgRW5k
cG9pbnQgZnJvbSBhZHZlcnRpc2luZyBMMS4yIHN1cHBvcnQgYnkgY2xlYXJpbmcgdGhlIEwxLjIg
Yml0cw0KPiArCSAqIGluIHRoZSBMMSBQTSBTdWJzdGF0ZXMgQ2FwYWJpbGl0aWVzIHJlZ2lzdGVy
LiBUaGlzIGVuc3VyZXMgdGhlIGhvc3QNCj4gKwkgKiB3aWxsIG5vdCBhdHRlbXB0IHRvIGVudGVy
IEwxLjIgc3RhdGUgd2l0aCB0aGlzIEVuZHBvaW50Lg0KPiArCSAqLw0KPiArCWlmIChwY2llLT5v
Zl9kYXRhLT5kaXNhYmxlX2wxXzIgJiYgcGNpZS0+b2ZfZGF0YS0+bW9kZSA9PSBEV19QQ0lFX0VQ
X1RZUEUpIHsNCj4gKwkJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBsMXNzICsgUENJX0wx
U1NfQ0FQKTsNCj4gKwkJdmFsICY9IH4oUENJX0wxU1NfQ0FQX1BDSVBNX0wxXzIgfCBQQ0lfTDFT
U19DQVBfQVNQTV9MMV8yKTsNCj4gKwkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgbDFzcyArIFBD
SV9MMVNTX0NBUCwgdmFsKTsNCj4gKwl9DQo+ICsNCj4gIAkvKiBQcm9ncmFtIEwwcyBhbmQgTDEg
ZW50cmFuY2UgbGF0ZW5jaWVzICovDQo+ICAJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQ
Q0lFX1BPUlRfQUZSKTsNCj4gIAl2YWwgJj0gflBPUlRfQUZSX0wwU19FTlRSQU5DRV9MQVRfTUFT
SzsNCj4gQEAgLTI0NjQsNiArMjQ4MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfcGNp
ZV9kd19vZl9kYXRhIHRlZ3JhMjM0X3BjaWVfZHdfZXBfb2ZfZGF0YSA9IHsNCj4gIAkubW9kZSA9
IERXX1BDSUVfRVBfVFlQRSwNCj4gIAkuaGFzX2wxc3NfZXhpdF9maXggPSB0cnVlLA0KPiAgCS5o
YXNfbHRyX3JlcV9maXggPSB0cnVlLA0KPiArCS5kaXNhYmxlX2wxXzIgPSB0cnVlLA0KPiAgCS5j
ZG1fY2hrX2ludF9lbl9iaXQgPSBCSVQoMTgpLA0KPiAgCS8qIEdlbjQgLSA2LCA4IGFuZCA5IHBy
ZXNldHMgZW5hYmxlZCAqLw0KPiAgCS5nZW40X3ByZXNldF92ZWMgPSAweDM0MCwNCg0KUmV2aWV3
ZWQtYnk6IFZpZHlhIFNhZ2FyIDx2aWR5YXNAbnZpZGlhLmNvbT4NCg==
