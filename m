Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788DB3C65EC
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290026; cv=fail; b=B3HWZVmdOaWgjA5Fd4f8QmlwhNCRAHy4W9DT8WR+F5ZwuaqJk7cgxmXYlA5O7I3E4VirjLe/pyzMxd0uqrYKm/98otWKKNpe8NXL0m6ldwu3Hned5jfvrE1eCELIXFjpSGZh0KdRKYcoZ2xto/8iKt+m8l/e3VuZzk8E7eaN84s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290026; c=relaxed/simple;
	bh=6pET2kt3BUaYbSH7YaGe7O1m1s+tipUM6DLuE1S2PeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FKpQ67dmXDCSwtENVNpRTj3HvFYplQEGHFarsI7KmvpiT/dOt9s556kmy0WbJLNK3k/s5DC3GF8jaJxCE0UbdJ0AqOUQyDL+E6jdQUDE1iZPUqR9SCtFCOyup/6Mh3o9nzz2tqQe6z3SGEgKL7UDLwfoxV+XyPSaRJr1CF0nXY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FBQOsVpy; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FBQOsVpy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJbeas47ZLaZdUCMRjGrdQB9UvFO979GNcxvDg0qJ1NVjIQO8d8nQsp04KgFx2dh6K19A6OdCdqAKgtgBIJ2ozPgncfgzJubPdpcvnLD5xoLB59b1OFrxI0f7xoHDjEvH0waIgSn43N0p3vO2UrJUa7Q+1K38eo0Jbxa6a+K7fpVj356hVRW6S/qAdLP57RZHxXnhhwbdCOxXHY3BSt2K+TDJow+X4+QpgGQUueSEYfJgXImRFZ3a3oxx7DDesHVoet+HrwkuB/+HZ7MvlzRvn58UW1LJEntvvI6l1NeZ4Mpw6iwme8B1qvPW4U8GsIYxJ99SSo5oL0m82RvElStWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pET2kt3BUaYbSH7YaGe7O1m1s+tipUM6DLuE1S2PeI=;
 b=lyUYOkiL7olvQ1P70fy8Mh6Grh54ON1BQkQGOh4ROKoNomSSJZpYfU4KOYCHNztlt9uOONqOLnpN6mCzGaZ/nbZP0CupxtKRDb1DUVKfNR6kNNpXRwC8DGkX8gTnFGvSsWH7qjkKfhZZVomBY33/pzZuuITvaWJjkn73bPD9t4zF+lAARnd3y0u/O5liwJwsvoe4SugCsBzzGRYLXGyxdgxenfszybO4HGdG04nagscvNRQZAr8Vc7pWd6xZNAHl6lO3Z4vW1D3vVXXPqfEKK7pe2cVUpzdBl2zG6iydvGj1NgVtK5AAmrcFkRHCvNSfWOS9/sGsLFG1mZDJqqBo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pET2kt3BUaYbSH7YaGe7O1m1s+tipUM6DLuE1S2PeI=;
 b=FBQOsVpynJ0d2XJaSbcffT7LubGaOcglvZkXxtEmJeBDe6dPhMdEJDlFX0kDyAj01aKaMGzyaRgl1y70/qEuNgKBgb24qAtRvqezNPrdUVezke7v0mVmsmDf0vtyxPvu7q9epG7QBnmWItPaaMfVF7KBw36VmP9dJ7jnXq7Sp5Yvvrfm00nnt9CzdZLkN6VzmKbEESCUx0I98VAxX7misyS/7uZDoVP+xk0rs6dyREsnieFSMmyNRg6MnXYUruvL8cy0lzZXpCpi4SK6oPJP4XaG4W6v9p+f2pK6ltT8jteEpQO5sMLAfUmKN3+gdbk13oFJPH/rmFmPyKrzZaUrKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 18:20:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 18:20:16 +0000
Date: Mon, 23 Mar 2026 15:20:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Message-ID: <20260323182014.GR7340@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
X-ClientProxiedBy: BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: faf9a0a5-5f68-4c63-883b-08de8908d4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GvSNi7AvS+evcZUAQpPiJ+CFqHDAFaEv96XKRI8adzki0K9PjebeqcjGC2PFZFNIpQ7UfxXrQgDY64yx6N5YQnxlsi+WeXanoAVlvZTn9eAYXaOEio+d/N5u+KPbSWASQ0FwkMb1EQaOo26QMfLZ2/vYryS5hwnARnJIUFQT/smUY1K8hvO2gtSTSG3Vh8m7QIDI4DQuAcn15mSJhUwjdxrQpMnV9hoKtYjDLPggpnQ5/Q6qEkb5SS1Gc9/Mh7v+apvz95tTB3jAhrqI9Lr1lZ4Ixnj6o1sh7ZfXpsT+P7Lmoo70kt207iWt/CEx+4yIXFs0CnQdy3y0O4OxaoGTOGQ2GEbi7tGYkcpRLz8fPu1OBfmUXHSdGaX9RO9mI/zyeZ5Vg8HLtzLBQJl+OWzirTt1GPIGXrKpH4UgvVkL13vED4CPPuq2pGeI8Mo7V5HnPgSgn4xKnE2rpOkoNgvqMo5NcyPPgdTx1d7sLyzr9l18qxn//xV8TF3NHgRNUrp5fEpEbGJBEVLZgvPI48oKxp42HPTaKJVR7ANMObJoqGOklCe0fkzwvRI/6mzTMfWipj5uvx1azQcuT4FSP1w2oZ/CQUNtyAYEOALXlZ7W4dWYB8y1/JFxxU6nusK7olByvZnCn7rbaiIesURaI3ev/xxQQHjjecY1BWbg2zZfUO/6POCffYieQ6qAMPYOkeQNCxeN0dsoS6fa1wzOMm4AMw2tXW5VXRWldyhyKBI68LY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tzsc1DvNPmeS1SqDuICwqefUTHT5KYrJO0hRvkNdO69KVj7i8R9SRXglV+E1?=
 =?us-ascii?Q?b6qRd2pAsmYtwqUAcYkeW6IMEqEF9wgIIPe4NmKtG1AoSkpvsm6ttFOirZGz?=
 =?us-ascii?Q?nG8nG3mE1pnNIuIFxaSf8M/CMbUXghMSFeyG+WiEbkYmswf0v5A8uzyIS1QD?=
 =?us-ascii?Q?fLaYxEAZvUZPrVzsrDtNZxJoqmMjDDHcKnA0tFdW3gYm+umjSK/fsgrNYcql?=
 =?us-ascii?Q?doVTbpx1vTx4vdrbo5gv2jWGz1TLT1S0UdzgUROGPeWkIefJn7h2kuxkDr77?=
 =?us-ascii?Q?v3VeZElTINkkqy9nfn5vJznjEMwnqohNsrevR6HIAfvuTGIbqs/+lzRsv1Su?=
 =?us-ascii?Q?yWz95+8eKLlPBEf0h8v8z+oKNkEzie88I97pLheKaBkqna3N5SEf0jCSyWpZ?=
 =?us-ascii?Q?Ep0weTU71SgvSgsGKwwtyToR9SrkxwdV92CgFoLHFI9rWHZWHHJxEwVNEkwJ?=
 =?us-ascii?Q?cSymoouk9w4/AB7MzmXz90hk+Sxab/oNVmFFDnzKSszq2WLtp5z1uTVch+O3?=
 =?us-ascii?Q?xwnl5vmKcuE2+3LzHNVdjpMfYhzYoLDbtbS4rleOMixf918LWvj8BLIgrdfB?=
 =?us-ascii?Q?5a3fYJ0sht1PnvKCk7DnVTKBtxgm31PLelvViiDgGE6F/MTI+7jKhCMaRXkb?=
 =?us-ascii?Q?Bld+U7X+/rasQdGNIee1LHRzDAv0g4n1s95ZQHqpkAGSlmzR0KCcGQfIXmtx?=
 =?us-ascii?Q?aGJY2LwrKyB8sy+QAt2dW3SkZC06TFTl8V8Yu8IUqG2ESP3P2q6mHueMK8IX?=
 =?us-ascii?Q?FgpWmfp+6lnJAh/HKbqJSLKMp+Eb3A4GXanu5lh6Cv6fysneYQ1jj1sctBz8?=
 =?us-ascii?Q?Xfunf456COiQQDeqXWUS+7Z7aJUstwoJT+rk/B8g1aJXds8mIWVM+ZwitJe3?=
 =?us-ascii?Q?tQc4sGj4fWIqPkFakq1dzf6b5VHgSIBDWywTXw+cptpRyuNHo49Iyv+ffrPu?=
 =?us-ascii?Q?BoMrVgbI3xXg2pF/aF1F0PGI3Ec8Q28yjk9WR9uhbzGWHlZy2RFEGK1Cm/bN?=
 =?us-ascii?Q?RxAJgMfle+llrmY1DEZZ8vp3g4OXwwwmq+WdBQ386R9NRZOQrZ0zP4ctEz1z?=
 =?us-ascii?Q?8HfIHo+j5RF5T2iZL2Vaok1XZmn7ZuCdQRJf4sA7pOMeZoTXYWnUYEivnrUB?=
 =?us-ascii?Q?h/VJ/mrTFsR/Hhv59Ri2gM3vA+hUcyuV+cd6YTpuMQ7uq0IxivZHctMfVzG4?=
 =?us-ascii?Q?Q34Gz+Mn+8v1ZzhF9eX7ZlBe7xAGd4XhUETMVriWVBBkYQ/QqLc6N9O5EoRP?=
 =?us-ascii?Q?tDEYzjKKs7n8dgoiYOm5lastLfinKA0VO/jBpI9bzn0Uxvd9OgQFZcAZh2eb?=
 =?us-ascii?Q?W1uWuS+i4WCgmLxipviTtwd2L6Xms2IVKIa9poDRx/B5Uve66t8SiYn+wmgD?=
 =?us-ascii?Q?S3yh5JpmLSOpCXIbONUUZPpNA+M+RWa01UxOjoOcmeFnnB5fSKG0Ol7NpfeQ?=
 =?us-ascii?Q?ZUoPGcqwkxyk/ZwGTmNg46cIbvIu0hd0dbQH1DEqGt0vs4yV1yT+Q0/qQwMR?=
 =?us-ascii?Q?kn0lyq6LbOifEKkBQlZB5++M70P1r+T0klJr0aSs0lUisw14myLiwTmnWjSq?=
 =?us-ascii?Q?DVu7ika3CuKXwFcs5UbtbVAPvfNG6mi7QichDg8sC62ln2jR2s9V0YPiMk1A?=
 =?us-ascii?Q?jOruYf5ARzGM8HPCfxTNYOCLbA3bBuMfsYnRKRthnZnulNMDsSWsTSz6u/+z?=
 =?us-ascii?Q?aAmeyt7UT+1A8cxn91smwjZ57MDzUy41vLV/anQymhu6lT76?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf9a0a5-5f68-4c63-883b-08de8908d4dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:20:16.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QCW3CcgcAVqHnP6J3X+/iyZFiLji8lBg6HGZY9I+A2PkbbsYaPsviLbo91v5jMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

On Mon, Mar 16, 2026 at 04:19:30PM +1100, Alexey Kardashevskiy wrote:

> and btw this only works if the entity generating the MMIO reporting
> offset (==TSM) knows about BARs sizes, which is not the case for AMD
> - the FW has no access to the config space (so the HV needs to feed
> this to the FW? may be). Thanks,

Then your platform just shouldn't use the mmio offset feature. Set it
to 0 always.

Jason
