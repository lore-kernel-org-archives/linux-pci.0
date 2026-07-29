Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDF1A680E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290250; cv=fail; b=V2NZ6d9Ocf4ueUTnHn+T6R+mDyfkn2Dt8QfA6H/jOv6K8EL0QElfcgXiw137fxi/cY9sUJ+hx1mXSEUhT+KPT31a3AHFC3YBH/nJabwEC43xghQ/zWtpKpRMn0wu8XWA1FmfRwAkf/54kPEWA/044AKhTpELpyudVWoxDzVJj9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290250; c=relaxed/simple;
	bh=ZhQTmccztYWwc/FrkSOiSHL894R7YyR+9M1oT2DWvOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=axShF2emKsgww9bYdSRN/HHGm42WnIdR2Nzpbx1/EFk354kMq2xsBwDHV5+k3LbPc+vyAkEL4Rw55xEWNXpS5EQ4iMMnBKqegLdMcuTtLyFeCVdFkfpfzcCgF/m6Ntr68ICwJWDH9+2jk1gUX0aKhRccYgy0WKTC6oAg4cQ7udU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VUy4jJ97; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VUy4jJ97"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdsMS77SzTW59km67o4/OoxQm9vf0MUaAbbnQuxbJKMbeihXB7TDOb38rhyK3M99geFiE9cOhelcOUHBvhH4BSZ6srUBXn4O+gsJweLr6klAOQbeSTVLgew9c+P21+dUqmP4tq9yKEzUbOIXeFPlLea4xzCX5W2MIEUDRD9cipw/KgGI4w4ngIqrBlQZ6oyK0nRwzwI5c7+lo4sU8O7vw36me6kWig2pq+7nIcpJ5ebEX7fYEolKzfDueKcjdZNV2u7XCVeI1lRcQrJ5qWjr88+AG5cdjU9c7/CB1PJIp5Ih7xPoW3KjVju9mJ7BUGA3dQupo+/eacFfkrEbQ6ILsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhQTmccztYWwc/FrkSOiSHL894R7YyR+9M1oT2DWvOc=;
 b=NFNLYlLE2TFmbpkVnyoWJkJw7KN1v/olWYRz9vc5OLcw33qzjdbVlYrw9pdKBi035zbEkXTa8Q63Int61NP26DxCzBH0TPliNBu1cVFMp29OLhfy/DToPXJZSaer0s1957goDmZwsb8GE4qkFLZfLbvftOOsz/sa9zb90xcvaP2Tj29Sap+3tTkGpmpMT17gIe/xV6nNJQ08aosraYHi6KY4O7BWhrGpy9ACX2Nw5RX3FHORkemCwF7fo4U76gr/cDb/6M6HJxypXwDGQaVTGIsxvug46Xfy/twE8o/GgcxujLWwEOyH0ALKH6WR/73GYNfhaWnW5OoOjjMx74pNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhQTmccztYWwc/FrkSOiSHL894R7YyR+9M1oT2DWvOc=;
 b=VUy4jJ97mRF91vY1o2tYhaZTzCQfQE4yUtS9I4pPbzP+2PN6EITxO398KHAVIUKk4smX1dwpD7yP987fipFJK0swVkBsKyI9eOD9uJVg4kliEarZQBbJ5nVR6BfW9elzoTqd/o8LEMFwKPxsJ7F3FBXLELg5i25BJKMdZv5ZDeiOqmU25y5ttIitgX93ig/M/mlWKu03cWvXjV1YXG+W5SqSvQ1E95HUnzUm2zGSH6ylKUZeCW6evdBBPY4eT8iL5krN0y9G5KLtXpgcacIfLzw/u+DYspA2a9i8m+vmK8bsGd/LV3KMwH5pKUXxDuZkTFNBC+JEbI1RNQWgUZsfQQ==
Received: from DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) by
 SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Wed, 29 Jul 2026 01:57:23 +0000
Received: from DS0PR12MB6463.namprd12.prod.outlook.com
 ([fe80::e373:bb96:8d5a:3df2]) by DS0PR12MB6463.namprd12.prod.outlook.com
 ([fe80::e373:bb96:8d5a:3df2%6]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 01:57:23 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>, Aaron Tomlin
	<atomlin@atomlin.com>, Alistair Francis <alistair.francis@wdc.com>, "Aneesh
 Kumar K.V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>, Donald Hunter
	<donald.hunter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Luis
 Chamberlain <mcgrof@kernel.org>, Lukas Wunner <lukas@wunner.de>, Petr Pavlu
	<petr.pavlu@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Sami Tolvanen <samitolvanen@google.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Saravana Kannan <saravanak@google.com>, Will Deacon
	<will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, "Fontenot, Nathan"
	<Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
Thread-Topic: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Thread-Index: AQHdDMrOwfwmCkkN7EeGRZV1a3LRYbaCujkAgAEnA30=
Date: Wed, 29 Jul 2026 01:57:23 +0000
Message-ID:
 <DS0PR12MB64631390FD686D8E752CA393B0CA2@DS0PR12MB6463.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
In-Reply-To: <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6463:EE_|SN7PR12MB7204:EE_
x-ms-office365-filtering-correlation-id: d59e031d-ce3b-4a09-f725-08deed14bba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 GVcbwZJIyzFYkBl0pWHjgS4mUSbtu9IvoV9vfSr45ln0PRB7umKN8gifMpfpo3/r9bbhfrz9kx3pQgW2WMJKgIRY8TN04JqF0Fe1t8pEdvgRyQf4MHWesAuhu3s8jbf1oRHRon4xmpl7O2i2alupVUkSg+PUCyxduD/1CQcrl/qghH9+YEQXSQ3EYxefK/HYveeTsGRqEUud+zAP/dh1f+n5v2K9i18zY2x59ZRN+y6dDQqwnXASzrjTBpv5gpW4nqd56IMUJvCa+MOKTvQzrfg6x7A5zbi/6Cc456U8AzuyuDiA6MzFvQeXKQmsUR39kq0tGVd6Y8oNxmSv5EFuKjHcGUuzDV+raYgKRi4FWoUtZJc408dOWQU4h3ZuHtHKYb+C42ainOIjx3C5ju6zzqEiX+ctTBOW6mzuz1TMi7YkxDiCy+/3hzU/So1oKH9nBYDCza0fhXNNkKhP/8q9TblNvkHEZ5ykttGF+RSwln/4p0jBPpPd6xA9jouG/k28fIfanARndvqMnnovu/VgAhm9wFqH1C9LYXEEw4TCG0bP6I9PXJlnIuXCmVe2OHNxxmWawcqwzf1dTEUXX/MQ9wGI4YDQbisArtly+q9LzTn07oAM4/utTpx5DhnkRtj2W/28ZXah0ecPZFa+12yOKmDsXyDqnnBrJP+F25zWXusqWQ34SSb7JKa8wqwuKvZZa3UnkmhedR7XZH/qcXxKxZVZEhHJ1WzA7V5nC36Ukuc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6463.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?f+7f5vtK1m2YedXQQEb4bdxpqtAYUhoNkXNOq9RyQcf+NCKSM0xdnv70yS?=
 =?iso-8859-1?Q?5oUDH45vkO8RPv17yPQrgJ9MKrZxWpnxesIMJ6/ryeofP7CxJafvhlN7fQ?=
 =?iso-8859-1?Q?FM6DpeXVcFOh/bvSwkfJkzAXF31HaGWdYbfjZLAPyvLfJsEF8eW0sKDASv?=
 =?iso-8859-1?Q?2v8rgFqlvANaWJOD8/lQnoUtCbfFthe0rVb+2sexw1CvLCD3BbLXFmDBsi?=
 =?iso-8859-1?Q?5OKIOcyduflDrQPK/SIzX3FwKBLHKESaH3ITva+QYXXzdGNTgQtEh11TY9?=
 =?iso-8859-1?Q?MEOSu0Y868sy9ZEZMXHI/+/QF3bQ/cm80oL56lyEJUPVZ8kvplrL/rxRCd?=
 =?iso-8859-1?Q?sKBVaDZ4z30PA/7J/S3zh/1rxHNN+GnQyFAoooYuuuQfobcu6wJfZjEK/u?=
 =?iso-8859-1?Q?zGXFvk1pTyvlIUu9nvVp1Ff1AFxAFjiWwVkdgjwOWVT5J3XGfX62bQS08T?=
 =?iso-8859-1?Q?8jzZC75AU6TixN7fANgAB2KdVqsl4uroJ/mB+aEUtz+346MAtFbFjbraCy?=
 =?iso-8859-1?Q?zgkQc8ZXhQwa9TiW1ah1ZrbFoNthjNVwSYsvsMuz7x3cSK/j+oserR0l8i?=
 =?iso-8859-1?Q?MbZEDRcGaAHhSiJeFJ1S5ISyHlB03skksq2nHBk7BkFj5DbfQQfosDx1iJ?=
 =?iso-8859-1?Q?3I+zkFrL5NJAUeWDPwzqyB6KjDRtWMw7cj+Hr8L4eA+jCJhw8o1V3fkM8Z?=
 =?iso-8859-1?Q?+p44WR1EE1nSW6KbgPnRR/5ATn4FrXgGsKUwTgSuojbpkcTDhVN94HVrqb?=
 =?iso-8859-1?Q?KCbN/wLGAf6ZuWdE1rF1pKr8xFaXtLw9zPupNIcd15c2JUGTi4AHSZea5O?=
 =?iso-8859-1?Q?9iw3LqcU9sWMmRMxV4NaWAya7g7FR7oVYRo8xWLHsa9kBmuSGfH8mlTduh?=
 =?iso-8859-1?Q?/9leS7p07FuswiyEne66qPzuOL9faSAlp2Sk3orlIVUtkadlF8+ldPvL5j?=
 =?iso-8859-1?Q?rTD4fvGwYlLZ3MYrV7k8W6T+9ekAQmlt9Y8n1LyhrbMud+du+veatzH9/B?=
 =?iso-8859-1?Q?Ew4TGr10+6toEocu4ZZRRk59K8YyFIUo5++mkOvzTheR5j9aClbsT0t0gs?=
 =?iso-8859-1?Q?pG/XnEX2n0Tigm7MDPGuWKFLxfxyl/U6LogzNXuIc1boDM7fy/6c4di+ow?=
 =?iso-8859-1?Q?0T8IZ5wBghDPar8/WvKI9OJZdVLxsh5Lu9QqiNL1nnlvHs7hMEf9VhLsN9?=
 =?iso-8859-1?Q?xEzWv927NOd1WnpO0P+qgzLOjcIusyh7cIalfhLcA4gwO6Mk+b8gGZugU8?=
 =?iso-8859-1?Q?cbKOdxtdmqxE8TIrNAYFJBvzQSxPWSN0/YKlOLWqrNak0aDt6rTphJJJ0D?=
 =?iso-8859-1?Q?4nodVn1eCv+oMGRU9u3ZGR+H7uxYh7EhoAfGTmv82jy6NnxYOmRRUpnVYL?=
 =?iso-8859-1?Q?veqwl9lMG9HTSUgX2NCTzKRFruhNV7p4oqu7NQJFZL9qTdieStylYnxIPy?=
 =?iso-8859-1?Q?4WCWG+g33sq/jcL8gfl0d8EwrKUeIx1Kg0JvxELMHHVO6yxmF16CS54tYE?=
 =?iso-8859-1?Q?XpbK0lOlAm47v73IGlTbErpYcyU3Sb+QMPRehHRNqxTYMQvM/QA4xdJhWP?=
 =?iso-8859-1?Q?HdaWQL4E675HAs1wYYwon/1otRNPBufsiU1V6TrL4S9INSPaLdWWyJ5PYy?=
 =?iso-8859-1?Q?7i6CsKTiFHz5CXI/Du+ksOT7J03eMJ+DLG+K4ukVyfiFvVQewu05jyKEsi?=
 =?iso-8859-1?Q?dxOSJJNg6Nq+Sfcf7SI2Z3C6mtUJopy9ehLU5Gp7o/2QpnOIe+enouY9bm?=
 =?iso-8859-1?Q?41W+pPHARZG6Rd3GuukHz5rOi0xKEKji6JmHp4bAa9r3N9?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59e031d-ce3b-4a09-f725-08deed14bba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 01:57:23.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJZy3JGXo1EJKPVDT8O6Q5aHGBd4qesRJnW6L9ncxgZEIh8mqsWnPCJw5GxnNJ+d3jFF7KRR1U3AafxjEUXAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

> Any volunteers? Yilun, Aneesh, Jason?=0A=
=0A=
Hi Alexey, thanks for bringing this up. =0A=
=0A=
I was working internally with Dan for the CCA support and will continue=0A=
on his work.=0A=
=0A=
Thanks=0A=
Ankit Agrawal=
