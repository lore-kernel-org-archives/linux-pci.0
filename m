Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35947441606;
	Fri,  9 Oct 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526473; cv=fail; b=nYxexhuaHG2qHchPnHfi4N9cthpZY88R33gFr64ZAZ1j9mWmG2N4QHrUUXKdOV6FfgU6rq5TaQt70v4pJWsBRXBwmzvqOfSmFvsJiDkDbRhnHNAWlgWUdeGLxlpbbBFmK1S+qsOclWLgdylN9De495/9CH2SX2JGrzmf52Td0/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526473; c=relaxed/simple;
	bh=BkzMgWA9qA4gQ3JC/oZNGdwUCVn+F93bm13TGddn7pU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qRH3+r62jpvdDwj5YgL2459Y7ta3jcSOI3YYjD16/siu7rSD+qbttUBc1REN3hHfA/C7/Xly430mrW/iGDhOLBtyL11kt0oAHPbd/X0QlB8doMGwjLTDWoKWReGI572LRumMe8Jv1asAAVFSMrCJK4m+khsS2U399vPx5NVfd8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AGPBsvak; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AGPBsvak"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdvxl6LaRyCRnDYJOoZS+2OrImE8gZIQYPr1iL03eekW+5GGNhrKStAJPDISkiT9AkV8uzOVmhTsJ7EiSwIr3UuVSCHgMHDEx8PpmM07kLC6UnoeLA+5OnWFN5PGZGuDKZka29gJopPxapv/Uq3sUPvqYWX2XovF51CeQq2ATeE1khYsiVM47vBfOGk96YFPapdHuVA4+1oW9UmDS47tRJbl7i7Puai3+NK2pis8upMVUhzGp45uL08ShE6d1VzkF0q3AMBhiAccSpIIwMhoa159QEQTo2rQewMPuAVregS2MIxHxBuJi06Gs3Igh99K8KOcwj4sQY7ktHfPRO+wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Td5vsKSe6GKSdgAXZnmlrhFJdGU4HIRfeBy/X3WgbcQ=;
 b=ANHtx9ryyezk/hCft2fRDUxKLlW3kanInxcnXnve6HRTDpr/Ymj7CHOHt0WdS3gRUUiaTn90KaNc8VOVdl2X7VcsuxPiJ6uMgrDvMZP+gWKrPZBNvTc1qviB17v/536j+WTELGRmi5T/UnwYEmHHi02424YARzxSGFAx/HzzzNEQyzohT315IlohKxeURJSkWNB7xeYTHikm9/lMGlaZYNJgFn5yfNH4yY2NnxlwzlFnoWqLsfByFRumDpQnSSTFt5CgnFhFZX3ZguYKrT3sGSO9y+VVevnAGItWHGRVPUYW/hSVMkzQFc/+oOwv/2CB1/jZ++DofgymSIFd5cpUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Td5vsKSe6GKSdgAXZnmlrhFJdGU4HIRfeBy/X3WgbcQ=;
 b=AGPBsvakjEufCs/aBOFNTBPy6U3V2BB5e+1bKThWM10wS5ruxz9rVEeC2lRGE4rRMm0jh3/IITQYa1FaR+fVKAItdU8FDfrlf+P/yzkvNqXHD4+qrOxhl8gV3fCHcu0B09DNuhIiaXvgbC+uADbpT94XRbNao2+mAANsPMXFMWPoIY6YhrPhSN0cx3ClPdlntcBDb/ur8Wpc06+6wemCtc687P/fHD7cdti/U41bXHafYniqQZ6+57DQ6KXO/dJHoMkHHBXJ71tpswQW6z/u+m+nUtri6cTCk+4IvQHJwjLxKgTlgz4bvYRqCEiJZF7pVUgp0NgnLx7hz/TcXYcg2A==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:26 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:25 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v5 09/27] vfio/pci: Add a generic excluded-range list
Thread-Topic: [PATCH v5 09/27] vfio/pci: Add a generic excluded-range list
Thread-Index: AQHdRgqCp98xPgepqE6dt1EfeJgYmrbf590AgBTmOyA=
Date: Fri, 9 Oct 2026 06:14:25 +0000
Message-ID:
 <IA1PR12MB9030C69AF2104724D1425EB5BD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-10-mhonap@nvidia.com>
 <20260925230528.33f70daf@jic23-hlaptop>
In-Reply-To: <20260925230528.33f70daf@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 18c594b4-464e-4929-dfc2-08df25cc91c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 dywwVrH3Jjw7mEHC1E/M2af09Hm9MuY9tPRJm1WJ4V37YquUBFnlEemRevuTOLo+ZiVhKvcZlwgAb+iUZJY74VdHRHcEYTkNhhYmG62q1MkIvACriG3T9Fb73LobjzsMr8pu0y8HW/S6bB4ZFUn3kHjGNcPvgAFuETnM2xru1W6nic0mF9cQ1aMDia0bgOg1hvHT5rQcar/a/zTtIyQchpFL4F1Q29OQ0epLsiDc2sZIey6//PdoF/piOJ5Sh6h5cqeceJXmJOli9rwi8qyaFHLra2znwNwu/tQXf4hzkp7YunP/wJjnhFDKvYpD3AySVmo1C6Wx1ED/cac/W1vrU/morSvED3rcTsM4Ntgi8ojm7GDhysX9hm2Dp+BqHYthpi37DVQI7nWWOgJRSCcJG/x5mVWqF37+v7tZnox42yfZvgAWhSr4HZKuyPKR4bJ0BkqqA34Trm6N6MvgS539bK85oTk6wNzwnI8zroobfdo1aeno8mOb1YokQxGKFBQoITMzkCrqn2iQNrciLwakReD6MpAC3ebGDizi8hYLlFBxau4JU39jD0xJ8lBgmxhJaE8KKQ4qfWWdgv7DPK+8tU6xrhN6a+2aMMAIVJ/fWzTtxb57KhG4UtV8Nv6PBVJuhDRvg3O9r42kjDY/U/xrtIQ6VcAiQh4R5jKpaYluY+jdvcVyWkVWFJzZNaQYFp1yneki5JvzPLP7ltRXI77VNn7BvtE/I+45FoTTc5/9o7Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/ZEC87h64/ZXyJmWjumIkACsX6eQzdNP1YsWNCbZ8dBE1ExeZmTDdyO8Dj8j?=
 =?us-ascii?Q?xsnsHQiwMIIRHmRnHPwPwRsT99VHF8pymUieA0sKpfbKldkWh3P6LUgZ363P?=
 =?us-ascii?Q?BSATTGlGFp1EVB7OPzHDqRwCcMb7TSQ8euGDon0NlTvP3jy0DTihliclUwHY?=
 =?us-ascii?Q?5NQzp7NvhrFWRhZoyuoDVNVXXz57a8hSr6HZhV0yAgROsFJ9YlXqAnv2ZgjZ?=
 =?us-ascii?Q?LPAn+1waqFOIRQKr/rRqy+up4YJ1o/mPcwIg++DjkISfdC4+8cCIv+DLfxzn?=
 =?us-ascii?Q?ty17XbITkCoaLImsiKr7FJ1U+ENg9EpGSMJRqfHyHDUuQnP+Np5JIM3CWq4W?=
 =?us-ascii?Q?AzOX0ln8plSVWYQtCnNO65cAJiNv61l/Wpygy1QYtm/yN263OodWc0+dE7I+?=
 =?us-ascii?Q?fOxEaT3gIWFWT4UYnKp1FTo0TFoU32b3V72PL6pDd4ZB7IKFTcNxoppIROzW?=
 =?us-ascii?Q?qf1PReyHD9UL4Rw0vaQPqfBjVaOHTWX+Tiis3B3pyqFwitPZENonDROgJpEv?=
 =?us-ascii?Q?ZEazLMZA6r6hpYZnVB+SuABqsYm2tCpFar8VBNeASKl4JHM+mSXpPjjmxBFd?=
 =?us-ascii?Q?3jsCGxGIcRCLcGq4BGUOSPUxcDVI4D5xfuI8DDC82QsJVJ2Bkmc6UujnLQoM?=
 =?us-ascii?Q?2FEeSbNIWelYgKJ90KIQQl95HBWUCZJK2UD/4qvekb/9iDMlqnWyB916/W4Z?=
 =?us-ascii?Q?1gCBGhg302L9o0HiTAlY9ihWR2UW0x7y31465TunslQ97isG1+mcnXtS4HXv?=
 =?us-ascii?Q?EwPu9obZmUVTP8u+tlYqdsfyB2prdamQuonX3usT2t/q9zk9myEsYqZkJvME?=
 =?us-ascii?Q?z0B+VRV9tV6RE/RTSNMCE7gA6OOlGLxUBSYySBILLQdIdReVmswH9fSQEC2v?=
 =?us-ascii?Q?hfAkuz3R0NMd+DYxQ3cx4wZFlAr9nKYcPmpoN2N/mJ6eqMumrE6erR1tlP8L?=
 =?us-ascii?Q?zaKaxLGIWdMojx2nJaVZXSF3RbsbaY/dRJC6sjBqG0nciaDc8IGXQrleI9tl?=
 =?us-ascii?Q?2s9aj1A0NK91uOIyuHPOxm6lR/G8Bd/MMtaNYjXZZdIfnerREbA/GlS1oCAC?=
 =?us-ascii?Q?+tXKw4+t4mFwBfp/nRE9SGyxC2k77zF/zVFRfMKLkGWW4qPkib2uSLziY3+9?=
 =?us-ascii?Q?TF9VQPFhegsU5cBoEcIGZu+5LdOTutbREc9l1qjTTRQYxg3m577Xf2fTxWrB?=
 =?us-ascii?Q?iaMQsTZUflJPDUEebIORO1MKQJ1Hr+ElNzixQoveAIsMGg1Rnz45RFzNOgUM?=
 =?us-ascii?Q?bU/nJwEG2+pIhvijbK2+6u9TmzUV+ATgl6MQXPJ/x8IbNMiIRhWpSSGGPXJD?=
 =?us-ascii?Q?K8Pq2oxrmL2qD5wfUUZelL7ZyCrgR5UXj9sJa4ypRd0tGrQ07s6MMDRmTcuA?=
 =?us-ascii?Q?htV5O9Vccp/u+q4AOmcDZIgR8ZGmCIvZ/STx+AqfyAUJgWBvR1gKTiC4/1cR?=
 =?us-ascii?Q?9a1juYh0pXJ1fYP5/L5B8/sDEsKoOjnSQMVG3Y56MJ2DUNeeotfAU67HSrzy?=
 =?us-ascii?Q?XDW1YdoCIxdznjfq4dUGeipOiEXXI18OsXJroTn3g09cQbvXtokH8T65cfzQ?=
 =?us-ascii?Q?FKpMErjJRDC7Mog5QLJ5/dSEMyE/y+UHi7Oc5QnQt5ovnGRa+3l/eRlSpri3?=
 =?us-ascii?Q?lFK/xGH9lTZ5CuopRxUcfkTpX4E8ln9vKYgrxluNQULXMz5G+LxGSReX21xe?=
 =?us-ascii?Q?Gky09B5DBeVkBE42htfQ2l5ycbBJUxT/7YT/7Pdf5vJS2VgY?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c594b4-464e-4929-dfc2-08df25cc91c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:25.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7QeouYAi5stqfD7czvLlitWve3tKZRmC5JGbB2CUgXFDE7i+aEvrNcghVtHzJ64WjJqEfDNaFQerLp1iC259A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, September 26, 2026 3:35 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org
> Subject: Re: [PATCH v5 09/27] vfio/pci: Add a generic excluded-range list
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:22 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > The MSI-X table is virtualized in vfio_pci_bar_rw() by an open-coded
> > x_start/x_end window that fills reads with -1 and drops writes. Now
> > that a generic excluded-range list expresses the same fill/drop
> > behavior, register the MSI-X table as a read and write excluded range
> > instead of special-casing it in the read/write path.
> >
> > Add the range when the MSI-X capability is parsed in
> > vfio_pci_core_enable() and clear the list in vfio_pci_core_disable()
> > alongside the config teardown. The read/write path now relies solely
> > on vfio_pci_bar_find_exclusion(), so MSI-X and a provider's (e.g.
> > vfio-cxl) trapped registers share one mechanism.
> >
> > No functional change.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> A few things inline that might tidy up the implementation and make it a l=
ittle
> more readable. Also you've use object allocators in some places but not
> universally.
>=20
> Jonathan

Thank you; Alex asked on this patch for a sorted per-BAR list with
non-overlapping ranges and a two-pass build of the sparse capability,
which rewrites most of this code. The capability is then filled
straight from the list, so the holes array and struct
vfio_pci_mmap_hole go away, which also settles your struct range point.

In the code that remains, v6 will use kmalloc_obj(), kzalloc_flex() with
__free(kfree) for the sparse capability and separate declaration lines for
initialized and uninitialized variables as suggested.

>=20
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c | 209
> +++++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_priv.h |   9 ++
> >  drivers/vfio/pci/vfio_pci_rdwr.c |   8 ++
> >  include/linux/vfio_pci_core.h    |  14 +++
> >  4 files changed, 240 insertions(+)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c
> > b/drivers/vfio/pci/vfio_pci_core.c
> > index 9a75c30b67e2..9e4fa5d088a4 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/slab.h>
> > +#include <linux/sort.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/vgaarb.h>
> > @@ -1012,6 +1013,204 @@ static int msix_mmappable_cap(struct
> vfio_pci_core_device *vdev,
> >       return vfio_info_add_capability(caps, &header, sizeof(header));
> > }
> >
> > +struct vfio_pci_excluded_range {
> > +     struct list_head        entry;
> > +     int                     bar;
> > +     u64                     start;
> > +     u64                     size;
> > +     u32                     flags;
> > +};
> > +
> > +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev=
,
> int bar,
> > +                                  u64 start, u64 size, u32 flags) {
> > +     struct vfio_pci_excluded_range *range;
> > +
> > +     range =3D kzalloc_obj(*range);
> > +     if (!range)
> > +             return -ENOMEM;
> > +
> I'd be tempted to do kmalloc_obj and
>         *range =3D (struct vfio_pci_excluded_range) {
>                 .bar =3D bar,
>                 .start =3D start,
>                 .size =3D size,
>                 .flags =3D flags,
>         };
>         list_add_tail(...)
>=20
> > +     range->bar =3D bar;
> > +     range->start =3D start;
> > +     range->size =3D size;
> > +     range->flags =3D flags;
> > +     list_add_tail(&range->entry, &vdev->excluded_ranges);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
> > +
> > +static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device
> > +*vdev) {
> > +     struct vfio_pci_excluded_range *range, *tmp;
> > +
> > +     list_for_each_entry_safe(range, tmp, &vdev->excluded_ranges, entr=
y) {
> > +             list_del(&range->entry);
> > +             kfree(range);
> > +     }
> > +}
>=20
>=20
> > +
> > +/* A page-aligned mmap hole, derived from an mmap-excluded range. */
> > +struct vfio_pci_mmap_hole {
> > +     u64 start;
> > +     u64 end;
> > +};
> This is just a range. Do we need another define for this specific case?
>=20
> > +/*
> > + * Advertise the BAR as mmappable minus every page-aligned mmap-
> excluded hole.
> > + * A BAR can carry several holes at unrelated offsets (for example an
> > +MSI-X
> > + * table and one or more trapped CXL component sub-blocks, which the
> > +CXL spec
> > + * locates by pointer, not at fixed offsets).
> > + * Collect the holes, page-align and sort them, coalesce any that
> > +overlap or
> > + * touch, and advertise the gaps.
> > + */
> > +static int vfio_pci_excluded_sparse_cap(struct vfio_pci_core_device *v=
dev,
> > +                                     int index, struct vfio_info_cap
> > +*caps) {
> > +     u64 bar_len =3D pci_resource_len(vdev->pdev, index);
> > +     struct vfio_region_info_cap_sparse_mmap *sparse;
> > +     struct vfio_pci_excluded_range *range;
> > +     struct vfio_pci_mmap_hole *holes;
> > +     int nr_holes =3D 0, nr_areas =3D 0, i, j;
>=20
> Generally avoid mixing declarations with assignment with those that don't=
 on
> a single line. It is harder to read than splitting them into each time of
> declaration.
>=20
> > +     size_t size;
> > +     u64 pos;
> > +     int ret;
> > +
> > +     list_for_each_entry(range, &vdev->excluded_ranges, entry)
> > +             if (range->bar =3D=3D index &&
> > +                 (range->flags & VFIO_PCI_EXCLUDE_MMAP))
> > +                     nr_holes++;
> > +
> > +     if (!nr_holes)
> > +             return 0;
> > +
>         struct vfio_pci_mmap_hole *holes __free(kfree) =3D
>                 kzalloc_objs(*holes, nr_holes); or something like that.  =
Kees is well his
> way to getting rid of almost all places where objects are allocated in no=
n
> typesafe ways.
>=20
> > +     holes =3D kmalloc_array(nr_holes, sizeof(*holes), GFP_KERNEL);
> > +     if (!holes)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * mmap is page granular, so each hole rounds out to the page
> boundaries
> > +      * enclosing its excluded sub-range. The byte-granular exclusion =
still
> > +      * governs the fault and read/write paths; only the advertised mm=
ap
> areas
> > +      * round to whole pages.
> > +      */
> > +     i =3D 0;
> > +     list_for_each_entry(range, &vdev->excluded_ranges, entry) {
> > +             if (range->bar !=3D index ||
> > +                 !(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> > +                     continue;
>=20
>                 holes[i++] =3D (struct vfio_pci_mmap_hole) {
>                         .start =3D ALIGN_DOWN(range->start, PAGE_SIZE),
>                         .end =3D ALIGN(range->start + range->size, PAGE_S=
IZE),
>                 };
>=20
> Mind you vfio_pci_mmap_hole seems a lot like a range. So maybe just use a
> struct range then you get
>=20
>                 holes[i++] =3D DEFINE_RANGE(ALIGN_DOWN(range->start, PAGE=
_SIZE),
>                                           ALIGN(range->start + range->siz=
e, PAGE_SIZE));
>=20
>=20
> > +             holes[i].start =3D ALIGN_DOWN(range->start, PAGE_SIZE);
> > +             holes[i].end =3D ALIGN(range->start + range->size, PAGE_S=
IZE);
> > +             i++;
> > +     }
> > +
> > +     sort(holes, nr_holes, sizeof(*holes), vfio_pci_mmap_hole_cmp,
> > + NULL);
> > +
> > +     /* Coalesce holes that overlap or touch after page alignment. */
> > +     for (i =3D 0, j =3D 0; i < nr_holes; i++) {
> > +             if (j && holes[i].start <=3D holes[j - 1].end)
> > +                     holes[j - 1].end =3D max(holes[j - 1].end, holes[=
i].end);
> > +             else
> > +                     holes[j++] =3D holes[i];
> > +     }
> > +     nr_holes =3D j;
> > +
> > +     /* One mmappable area per gap: before, between, and after the hol=
es. */
> > +     for (i =3D 0, pos =3D 0; i < nr_holes; i++) {
> > +             if (holes[i].start > pos)
> > +                     nr_areas++;
> > +             pos =3D holes[i].end;
> > +     }
> > +     if (pos < bar_len)
> > +             nr_areas++;
> > +
> > +     size =3D struct_size(sparse, areas, nr_areas);
>=20
>         struct vfio_region_info_cap_sparse_mmap *sparse =3D
>                 kzalloc_flex(*sparse, areas, nr_areas);
>=20
> > +     sparse =3D kzalloc(size, GFP_KERNEL);
> > +     if (!sparse) {
> > +             kfree(holes);
> with the __free above this can simply return.
> > +             return -ENOMEM;
> > +     }
> > +
> > +     sparse->header.id =3D VFIO_REGION_INFO_CAP_SPARSE_MMAP;
> > +     sparse->header.version =3D 1;
> > +     sparse->nr_areas =3D nr_areas;
> > +
> > +     for (i =3D 0, j =3D 0, pos =3D 0; i < nr_holes; i++) {
> > +             if (holes[i].start > pos) {
> > +                     sparse->areas[j].offset =3D pos;
> > +                     sparse->areas[j].size =3D holes[i].start - pos;
> > +                     j++;
> Bit of a long line because of the indent but I'd still go for setting who=
le
> structure in one shot - so something like:
>=20
>                         sparse->areas[j++] =3D (struct vfio_region_sparse=
_mmap_area) {
>                                 .offset =3D pos,
>                                 .size =3D holes[i].start - pos,
>                         };
> > +             }
> > +             pos =3D holes[i].end;
> > +     }
> > +     if (pos < bar_len) {
> > +             sparse->areas[j].offset =3D pos;
> > +             sparse->areas[j].size =3D bar_len - pos;
>=20
> Similar for setting it in one go so we only do the indexing once + looks =
more like
> above (where this trick is more advantageous!)
>=20
>                 sparse->areas[j] =3D (struct vfio_sparse_mmap_area) {
>                         .offset =3D pos,
>                         .size =3D bar_len - pos,
>                 };
>=20
>=20
> > +     }
> > +
> > +     kfree(holes);
>=20
> This looks like a good place to use __free magic to simplify things.
>=20
> > +     ret =3D vfio_info_add_capability(caps, &sparse->header, size);
> > +     kfree(sparse);
> > +     return ret;
> > +}
> > +
>=20

