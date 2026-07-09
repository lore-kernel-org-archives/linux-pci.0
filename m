Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D81A683B;
	Thu,  9 Jul 2026 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783557297; cv=fail; b=Zi/yDm1JIXjBnfQWoj7ihr1KqxFwPaSMACJRbMcmXtUZpnnRmA7eefT4bI1OIJi52M+wCT5cMZoocCHTHNvH3QECYT2Km/s/nwe41RJX2uxa71Z0TPXSK5Loxc8CIB74GuxZnncEMsacaJnw9hbcetBZwq/JHJLKPGdSlu1dmrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783557297; c=relaxed/simple;
	bh=1uLRCRpptzdSP0dTMQXzqan5vENjnE3yAvCiY6D2h7U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eEwlmlyE8r14gUwdR5xBzxXrwedlb8RIuADgyGsrEjdrjdn+uIYFCZXtmIacY2yqYRQB6DUrCg9on0IqH8a6liOtCaeiwcbeaxqtys5NRJ3s6a6nqMSqgwqGNRIAknJVbvhRURWnqsDQS4UnSOtssiqTeHw1Dw7ftCv1bcE4XGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GbSpl+Mr; arc=fail smtp.client-ip=40.93.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbSpl+Mr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQJYklGYnbKlH4BWP5uDVDEH0eqKIeJtmQUYGUa637lNWWVydN7gxKpKuJ1HpE4BCxoLiTSqfb7rZHiY8WzHYkKGnXpR1Vntl9M4Gn+krLsZyt4Sy20kvuT9O2DO2teS81iWgJAsHmFwLl/q7D0p5cvzSidHV+Wl8ym+gZfXzPPZXU/8/FIXi7dy6PXryvx5ZCH6HzeL4hWjgYnlfYzpaBMY4a4ihGqK6Ceoc1BB1EuaV/b2wfQkBBmsV/oJH4PQvtsHkAUxwI6Y41iYMJ1OLjF7k0E+ow/12dFRP2Q1Qdng7jPYolA8W7aMMU9f3bXKCrxbrRg09Sd1ehqXxipahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnkEzYrTSxQTQMgeDxSmAGgrdM7KEIl6fw9qyujpFFk=;
 b=f8zQ5N6rUWAzE8tTis36YSs3BW7Enp1qIS/kXoVX+PKtC1HoWtUrXtu+I/ZsijYauyKfVDI4EjjSD11fKnyNU+5G7AeRNBmUZyx2sdUPtSo9RgQmZmF5mJqCfp9t01UpZ6zg6XWVdGWU/xx3fTYmvYUQXQN+FxbkRW+S83Zuv6RDubLLsbPhsUvX51ev12HmDKmW7Tu9KlXmEq6caO2K2RZrq+1uJS9o+0DjF5pmUBHqbgPzfYW6GcE1wlF48e87jg02L1eP4Bw9RPbSazoRnHQ9zUgPOdxPhkyJcL9x2p/czrs14MzrTUNX7TclP+gmOmj2NV+vbtn7Qs2pswXxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnkEzYrTSxQTQMgeDxSmAGgrdM7KEIl6fw9qyujpFFk=;
 b=GbSpl+Mra/DnFvT/DKRkI1zn4/F07Fu72L2kSxqLBzIvlpYBCOzfacsZGa+6jWkMNGOVdcKo+RjGe2dCYQA+RU/S8Sbw8DNr0n41BnaqkyKDJA54prKfgzqKhZlZZ9/Echow202/n8NOzLda0V8+5A1SubxbB7O2S2SHMVA3IEF++c1ZOKe0UJzlnTTqQnWEaPmEnPxjZomfnVWABGPzaClPnN87y+6ppuFss4i5T7NXL/ZTG1n/y7+PGFsKIQQjx3IeHGsTyBf9BOUuvyYcdK+9VlRCBetRoqCIPS1IvdJ9wRUA3AuB9a+7CjXGyAWbmm9fn2eRHr00vdWh8MGmpA==
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 00:34:50 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%6]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 00:34:50 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Dan
 Williams <djbw@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny
	<ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Vikram Sethi
	<vsethi@nvidia.com>, Alex Williamson <alwilliamson@nvidia.com>, Dan Williams
	<danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 00/10] PCI/CXL: Add CXL reset support for Type 2
 devices
Thread-Topic: [PATCH v8 00/10] PCI/CXL: Add CXL reset support for Type 2
 devices
Thread-Index: AQHdCzgEuTE+32HQ8EmgWKGcZTRWp7ZhI5oAgAGKkACAAbAUEg==
Date: Thu, 9 Jul 2026 00:34:50 +0000
Message-ID:
 <DS7PR12MB9474EE81286538A24E1C095CC3FE2@DS7PR12MB9474.namprd12.prod.outlook.com>
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <fb9a53ea-2743-4e4c-b3b3-faa81dfac156@intel.com>
 <103e562b-1685-412f-adaa-679409818d7f@intel.com>
In-Reply-To: <103e562b-1685-412f-adaa-679409818d7f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9474:EE_|BN5PR12MB9464:EE_
x-ms-office365-filtering-correlation-id: 8a466ac3-ebd2-4ecb-71a0-08dedd51e327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|921020|38070700021|4143699003|22082099003|56012099006|11063799006|5023799004|3023799007|18002099003|6133799003;
x-microsoft-antispam-message-info:
 xB6nGohfw75K9TCezRK+BEDH9lYdcn3YIkjHiAzQ9hQxsMRgNEnsHLYrmjuZ5ok8m3wW/RrLSLMtyWn6WkcMQVPTXkd0mCPxUZI+/syVuShlsLH3RVQBLlVPpfM19RT2LJ8CyAlqomp78AZxrqYJ2HXYywg3vM80OL7R0SDL5l+sLppkVxZFLZ+wRL4xcgkNBj1Tmft9vAoFAQ/e1lGX3/GY272YFuLrpnKK7TlqatWs/NSrqMXofRBfzHGq2Tu15MXMAQ43gDg8eNbNLC3g19NDGwnfCcRaNWFTtKIjga5JOGdq8caPwPkeoZ5MZSjL3Vd85VFdkviY5ikKrl1a51H016V0FrrbEeFVGuOMyUdW6dUd6ymdW8evblD1JxcboKxs7rh7lbrFPr0c9FeRJHo+xWZXFAyhySNz5pSuvrjbPDZ+Yu4CPxqyCaogqI7ZVljNWYguOrAyfe+WjRD9fmHlrwwXMa/pnDtpWcV7EE9Pso4Jw52CMkIWvqyMlgbrIDubTesEpBCJPrkcI53CHktlZQmmMOMiUnkZ918Qc5i6fJl19G03KbeFds2vNDC1uS3UO8YzBolhUCFjJn+5kFJ4HTubpVO6vwEjZanx/iGoOaPz6TuZpjBJFS4i/v4O2QC2GBTZRTbJAsEGHPZX0Y3qUUAZdjDcC0MkSIxuzQGYGJMOeoBQEHofo88yYEfk1tPO62Jlo/NsYnk/MUrKndLk5SIVPfnh6drr08wHaAd3f89KZofkYIgdAFZ0AQdz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(921020)(38070700021)(4143699003)(22082099003)(56012099006)(11063799006)(5023799004)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0MSmY+e7ac0K1lDgydCCIRiYnZufJI4picUgSSTNj/2Gcw6JaK5O4wE/Yb4S?=
 =?us-ascii?Q?2dM78LvrCl2ktk2UbcVATvOJSST2v8L265Vb/fjYUSr4nUcx6fsXqhA5OABC?=
 =?us-ascii?Q?8MWm+AWrd4PIpxKWiOwZyg4nQr0peNVdB0+0JauwSPnWtm7Mhjg0BONcy/3v?=
 =?us-ascii?Q?YJvWP0OTxdYTsRDMBtxNKHhFOD1iq4VKLpqsbKYWj1dsBqUEDBNZPUwIRhPt?=
 =?us-ascii?Q?Fu3wnY0TXnsFL5REH9tUbljVFTSEKPcpBZ9m9gZih3R95YhD9uKSF8HGXsoC?=
 =?us-ascii?Q?cdfmC3Ft8daKFllnY0tGuJnt79i273h9NJpMs1SHSmdl3Ou1MaDDPud/DyKR?=
 =?us-ascii?Q?0BsTWjyjQ5ia3M1RkGMof/jAFrFuKSWGcyn1qwRTlXp4TuUdJzAFSvN0qXrX?=
 =?us-ascii?Q?daIL5SyTxc56uUx0gyWCOMfP6X+tcy9ylMKtXZuCMAieWe99hp7+UAkty+QD?=
 =?us-ascii?Q?dJl9kavi9W+ZKxIAZLuPpvHRJHGS4mdA9m0yq05zR93kdzExOHd+zYpFpFLp?=
 =?us-ascii?Q?FA1O+b5Ba8EunLupyVlvMaDe25CeTRHNCUbmp/FnUMpVWLIuVQPdtbzGMowy?=
 =?us-ascii?Q?bI9bfA3wWP5L1amHZiCzpKvSgvEvoYO1a1DFwEGWngdXvRldJml8d9+W9jss?=
 =?us-ascii?Q?hG6w+bgIrd+tgQz0Y5zZ+MiTLDqyCeXgogQUe1CYpK8lUk4JFb+mdk6Mi/sm?=
 =?us-ascii?Q?TD712Godo8UKYZj/jBYBDJQavCCYjs17JbmAkESYzwg1+REbTauHhgKEE+EJ?=
 =?us-ascii?Q?Ei5WPCUhLwwjAsjVdA6yew5jPOiZppZUUlltWPbQs2X8GaIQascMml2P4W00?=
 =?us-ascii?Q?h3zAVckN80U9/9r3Wu06UXm+pQimPxefPKY5cu2BZXCEmDBgNoTqO/yy4xra?=
 =?us-ascii?Q?qqMRZL0ZMHCiOCnhEotX4Is5Op8m9gqZ8lcj+QnqWcq2RqsEkndmNmJE6WmR?=
 =?us-ascii?Q?SQv6ax1rGQT8wBGUMOJ2u3LOYk9j8QXOxz5npbESYikY3kW1QSuuGPeew23t?=
 =?us-ascii?Q?Y7xY6B+hSRMhf0w36i9gtQjtvyoWjRiXvpok0GeQmKeqW+JxYNaaIbAKNFve?=
 =?us-ascii?Q?Uidx6WyMVkY8UyOiXhSuMvCm1tJKvr6v3c9Gr4DlwKlOjEYt2mN1yGMDft8s?=
 =?us-ascii?Q?AxiiiTJumcZYcLg+YAUtLIoioDL+o3SCf7Ef1lvCMmgKmW1ZcDmnDmAieMr4?=
 =?us-ascii?Q?7ibORzdqOScdxSZ48HMml/tv228STTo9mcZnuxFqCvEZkgdv4cQ+eGeugbcF?=
 =?us-ascii?Q?UA2pJs3eQyAPDL8eyr3frY/pyebQGTAA52EaUierY0AnbiAkK6mWm4umpwVT?=
 =?us-ascii?Q?Zit+RrAB3YvnrG6EK4Uvjpfxe5RhZnJ9lL5eNM8+haBbsACthepSiv7a3ZZ4?=
 =?us-ascii?Q?rUbVT23u99ChcAGZdY7s2MBOHZlRQpp+yTmD40Z+GW5yBiHg9CTDlowYrMiC?=
 =?us-ascii?Q?HN2L48hoimFKBlb1CJP8XBe6ARdTW07PcRhDeHvnRAZNVZLV+vXh+thS5kho?=
 =?us-ascii?Q?8/frV/BWm3Z5P9gRf9N6dvbHjfdENmrCkAv8LNfGb6bfN6e1Dc/Kroz4hsse?=
 =?us-ascii?Q?AOyzLpW1qUS0668cmgtMWGdaV3QHzFdDpxQ8Nl4YcD1p/JWOakxWVvfgHnzW?=
 =?us-ascii?Q?BsGV4XlUFRoXNdfPcQLglwRms35nPK9GV829zgpyp7sdWTUwmFTs9gl1q3Pb?=
 =?us-ascii?Q?lUlCvmG4jGeDBUIg6k/H50um3TfjLVCBy5WoVumEJL+5ZGtZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a466ac3-ebd2-4ecb-71a0-08dedd51e327
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 00:34:50.5807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gy16jXhJj9yohkfclzgdhjDKpslproSith6cKa1HE2udQIpFyslk6Ng3IC9bVRXfaV4fe0T1g5FwS5/At1rltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464

>BTW, can this be applied cleanly against a Linus rc tag? If so please do t=
hat next rev. I understand you need the type2 stuff for testing.
> But preferably when posting, post it against a Linus tag if there are no =
symbol dependencies. I'd really like sashiko run a review through
> it and currently it is not able to. Thank you.

Thanks Dave.  And sorry for that mixup of the RFC patch & the applicability=
 issue.

  I rebased the series onto v7.2-rc2, folded the cxl_bus HDM restore
  follow-up into the same series as patch 11/11, and verified that b4 appli=
es
  the full series cleanly against that base. I'll send this as v9 (deferrin=
g other comments)

  I do not have a public branch ready yet, but I can publish one if it woul=
d
  still help review or testing.

________________________________________
From: Dave Jiang <dave.jiang@intel.com>
Sent: Tuesday, July 7, 2026 3:45 PM
To: Srirangan Madhavan; Alison Schofield; Bjorn Helgaas; Dan Williams; Davi=
dlohr Bueso; Ira Weiny; Jonathan Cameron; Vishal Verma; linux-cxl@vger.kern=
el.org; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: Alex Williamson; Vikram Sethi; Alex Williamson; Dan Williams; Sai Yashw=
anth Reddy Kancherla; Vishal Aslot; Manish Honap; Jiandi An; Richard Cheng;=
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 00/10] PCI/CXL: Add CXL reset support for Type 2 dev=
ices

External email: Use caution opening links or attachments


On 7/6/26 4:13 PM, Dave Jiang wrote:
>
>
> On 7/3/26 3:04 PM, Srirangan Madhavan wrote:
>> Hi folks!
>>
>> This series adds CXL Reset support for CXL Type 2 devices through the
>> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
>> specification [1], including CXL.cache disable, optional cache
>> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
>> reporting.
>>
>> The userspace ABI is the existing PCI reset interface:
>>
>>     /sys/bus/pci/devices/.../reset_method
>>     /sys/bus/pci/devices/.../reset
>>
>> Userspace can select "cxl_reset" in reset_method and then trigger reset
>> through the existing reset attribute.
>>
>> Following Dan's v6 feedback, this replaces the proposed memdev sysfs ABI
>> with the existing PCI reset_method interface.
>>
>> v8 changes from v7 [2]:
>> - Drop the PCI helper export patch.
>> - Drop the multi-function sibling coordination patch. cxl_reset is only
>>   exposed as a function-scoped reset method when the CXL reset scope is
>>   limited to the target function.
>> - Keep the reset-scope discovery needed to reject non-function-scoped
>>   CXL resets.
>> - Cache HDM location as BAR-relative metadata instead of keeping an
>>   enum-time MMIO mapping.
>> - Restore HDM through a temporary mapping based on the current BAR
>>   assignment after PCI config state is restored.
>> - Cache raw HDM decoder register state so uncommitted decoders can be
>>   restored as uncommitted, while committed decoders are recommitted
>>   through the normal HDM commit flow.
>> - Share HDM decoder decode and validation between normal CXL core
>>   enumeration and early PCI HDM caching.
>> - Put cxl_reset ahead of FLR in reset_method priority because FLR does
>>   not reset CXL.cache or CXL.mem protocol state.
>>
>> Motivation:
>> -----------
>> - Type 2 devices need a CXL-specific reset mechanism beyond existing PCI
>>   reset methods.
>>
>> - FLR does not reset CXL.cache or CXL.mem protocol state. CXL Reset is
>>   the architectural reset mechanism for those protocols.
>>
>> - The PCI reset_method ABI lets userspace select this narrower CXL reset
>>   before falling back to broader bus reset methods.
>>
>> Change Description:
>> -------------------
>>
>> Patch 1: cxl/hdm: Split decoder programming into a reusable helper
>> - Move shared decoder settings to include/cxl/cxl.h.
>> - Factor low-level HDM register programming into cxl_commit().
>>
>> Patch 2: cxl/hdm: Cache decoder settings on PCI devices
>> - Cache CXL core HDM decoder settings in pci_dev->hdm.
>> - Refresh the cache as decoders are enumerated, committed, or reset.
>>
>> Patch 3: cxl/hdm: Share HDM decoder decode logic
>> - Share HDM decoder decode and validation between normal CXL core
>>   enumeration and early PCI HDM cache setup.
>>
>> Patch 4: cxl/hdm: Cache endpoint decoder settings during PCI enumeration
>> - Snapshot endpoint HDM state during PCI capability initialization.
>> - Cache the HDM register locator as BAR-relative metadata.
>> - Cache raw decoder register state in addition to committed decoder
>>   settings.
>>
>> Patch 5: PCI/CXL: Add CXL Device Reset helper
>> - Add the internal DVSEC reset sequence.
>> - Disable CXL.cache, perform cache writeback where supported, initiate
>>   CXL Reset, and wait for completion.
>>
>> Patch 6: PCI/CXL: Validate HDM ranges before CXL reset
>> - Collect enabled cached HDM ranges.
>> - Reject reset if affected ranges are busy.
>> - Invalidate CPU caches when runtime cache-invalidation support is
>>   available, otherwise continue after warning.
>>
>> Patch 7: PCI/CXL: Discover the CXL reset scope
>> - Discover whether CXL Reset is function-scoped using the Non-CXL
>>   Function Map and CXL cache/mem capability bits.
>>
>> Patch 8: cxl/pci: Restore CXL HDM state after PCI reset
>> - Restore cached global and per-decoder HDM state after reset.
>> - Re-map HDM registers from the current BAR assignment during restore.
>> - Replay raw decoder state for uncommitted decoders and recommit
>>   decoders that were committed before reset.
>>
>> Patch 9: PCI/CXL: Expose CXL Reset as a PCI reset method
>> - Add "cxl_reset" to the PCI reset_method table for Type 2 reset-capable
>>   CXL devices.
>> - Prioritize cxl_reset ahead of FLR.
>>
>> Patch 10: Documentation/ABI: Document CXL Reset PCI reset method
>> - Document the new reset_method value and reset behavior.
>>
>> The CPU cache invalidation step depends on
>> cpu_cache_invalidate_memregion() support for the affected address ranges=
.
>> If no runtime provider is available, the kernel emits a warning and
>> continues after the affected HDM ranges have been reserved.
>>
>> Example:
>>
>>     echo cxl_reset > /sys/bus/pci/devices/0000:bb:dd.f/reset_method
>>     echo 1 > /sys/bus/pci/devices/0000:bb:dd.f/reset
>>
>> Testing:
>> - Ran 100 iterations of cxl_reset through the PCI reset sysfs ABI on a
>>   CXL Type 2 device. All iterations completed successfully and
>>   ResetComplete was observed.
>> - Exercised cxl_bus reset separately with an add-on HDM restore patch.
>>
>> References:
>> [1] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specif=
ication_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
>> [2] https://lore.kernel.org/linux-cxl/20260623032453.3404772-1-smadhavan=
@nvidia.com/
>> [3] https://lore.kernel.org/linux-cxl/20260306080026.116789-1-smadhavan@=
nvidia.com/
>>
>> Srirangan Madhavan (10):
>>   cxl/hdm: Split decoder programming into a reusable helper
>>   cxl/hdm: Cache decoder settings on PCI devices
>>   cxl/hdm: Share HDM decoder decode logic
>>   cxl/hdm: Cache endpoint decoder settings during PCI enumeration
>>   PCI/CXL: Add CXL Device Reset helper
>>   PCI/CXL: Validate HDM ranges before CXL reset
>>   PCI/CXL: Discover the CXL reset scope
>>   cxl/pci: Restore CXL HDM state after PCI reset
>>   PCI/CXL: Expose CXL Reset as a PCI reset method
>>   Documentation/ABI: Document CXL Reset PCI reset method
>>
>>  Documentation/ABI/testing/sysfs-bus-pci |   14 +
>>  drivers/cxl/Kconfig                     |    4 +
>>  drivers/cxl/core/Makefile               |    2 +-
>>  drivers/cxl/core/hdm.c                  |  257 ++---
>>  drivers/cxl/core/region.c               |    6 +-
>>  drivers/cxl/core/regs.c                 |    4 +
>>  drivers/cxl/core/reset.c                | 1354 +++++++++++++++++++++++
>>  drivers/cxl/cxl.h                       |   43 -
>>  drivers/pci/pci.c                       |    2 +
>>  drivers/pci/probe.c                     |    3 +
>>  include/cxl/cxl.h                       |  102 +-
>>  include/linux/pci.h                     |    8 +-
>>  include/uapi/linux/pci_regs.h           |   15 +
>>  tools/testing/cxl/test/cxl.c            |   10 +-
>>  14 files changed, 1615 insertions(+), 209 deletions(-)
>>  create mode 100644 drivers/cxl/core/reset.c
>>
>> base-commit: 90cf2e0d702c8a132ccbe72e7687f33c04c14658
>
>
> Hi Srirangan,
> I am not able to apply the patch series using b4 with the above base comm=
it.
> b4 picks up the last RFC patch as the first patch and fails to apply. How=
ever, skipping it b4 is still having trouble. Can you push a public git bra=
nch somewhere please? Also in the future the last RFC patch should be label=
ed 11/11. Thanks!
>

BTW, can this be applied cleanly against a Linus rc tag? If so please do th=
at next rev. I understand you need the type2 stuff for testing. But prefera=
bly when posting, post it against a Linus tag if there are no symbol depend=
encies. I'd really like sashiko run a review through it and currently it is=
 not able to. Thank you.

