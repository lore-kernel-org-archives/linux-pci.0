Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673D4322E8;
	Fri,  9 Oct 2026 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526470; cv=fail; b=dGIs4p0MQbBWiHSIxwS8GGUpxwfGVSGVY6dmuXmmlyP/pt7s5lkJ3m3+wPjm4KCRHD6fcy6xs0xoXhSNrhBgLdkWdOMQwY660Ivndct61HtKa/4CLVVi5lWHI9q4l1bDSTWVHYnHmBoU0lQekW8mC4ihQrcQnqKAAPByK39gbOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526470; c=relaxed/simple;
	bh=mWc4JnGtVni8Zs1mgVq6cdRm9GPRDjj9mGUVURZ9zDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JcuLQwMrfd1qRpc+gIh8+g8q+3FJuWnRY8Q5EoNwRGs1WlBFM06w1ncRAoJqDNGkASPhSisXeSyeqrbuZQC+g3PCVeO6lFBb2UJh8Zih2vZsfHGyhtAkxjPy0c47x0ApOIQYKTJMr7KJuYtWpJS0EIpl5NDh9UJ3FcUR659ZdC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uk+II/VG; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uk+II/VG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IB4D0fqjANW7CEnqAAuhMb7YXHiowvodtDFFf2qv2aIQDzYP1x0yJOmwuXN5yw66F8j7x6Gk4egO6cyWGKP5HnLLG+qkPsNk0spbnGyHBvIGNzPnPP8vS0H5QxDEUX9/NbDdk3Z3NNFM6bTKlCshk0U3MjNiCA21XIvgWWW5fY16lKrys3Duyco/YpoUdWsoc613MFJiU7xd8rxejlD7el7bN8tV84mZh1HT7+67jsk4DBBQFlOa8L1+rHFlD1mDBu7thtZhERG4asXwEZqXncW0sECrYm1ZD/Ccuo74OnOgHJ5e0Xvdrrk7XoFwzZR9dGUWocCBUyQw9WE79Jf3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pAwocxQXK6nxd/luq8vJszWNlx2YFNDR+BbPjvrsTM=;
 b=nWYoiHRqQRdhOvqMM4a9yS18IoTrvQjCYkbbgw0DJAZ/bz7ssqpExuqqlGQIPry7GjZkr01mBL6HLazUqZ9E2UAP96R/WfU5CW6rNJ2DXxU4V+7ITRiASPBUyg56OG8h0xDEBDz22EXLnO41ekdq/rR6AdPHZLbtMntb/EZeZOr+UhHqyRUUoS/DpeNHFgJ+99pPCaYtMu3Zxa9lIFHMmHZl1zBk9m8/vyBja/1a9Qyv++HXNB+H32bMcX4e6bCi/V//VFGdrDXM2EECmJtUUpIApLMdZf0PWg6x35YGU98/5KC0WGNpknY3C5NKcRoQQevlAlREb75V5Pf3GJKwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pAwocxQXK6nxd/luq8vJszWNlx2YFNDR+BbPjvrsTM=;
 b=Uk+II/VGjPzr1O8UoIDuOm0qbIU2XF350PTmYxkXnYVnobsdW01q0259ncp6qClKxVgu+nR32eiCjhmhb9XH4rpHr76qpILOoEM8aFtfDUtVtbb8eJtkqVQabElbQlznCxEI3yD2DSuOPyX3OV4HEmOfNdELPa1x9PXADruK1vncj2NeUzMVbUTH92qWoU0T0VcN3NucMf3vWuNKRKPaJUJ3FvTDweH6BBt0tJX3mXHbfYOStV+7pbriUeS2S0wraM0uCE/r12MUtB9JIyDh7RN0nZgq3WdjD2Qi86YM0P6kN5qS+ImgvrIlf6Sba90DwZdgVGlcz9ZGPkWT+S7mKQ==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:22 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:21 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
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
Thread-Index: AQHdRgqCp98xPgepqE6dt1EfeJgYmrbZ49eAgBroClA=
Date: Fri, 9 Oct 2026 06:14:21 +0000
Message-ID:
 <IA1PR12MB903054228FEC8F5511AC2D1DBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-10-mhonap@nvidia.com>
 <20260921201331.0c54aaf5@shazbot.org>
In-Reply-To: <20260921201331.0c54aaf5@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 4d190e87-4cf6-4962-67f8-08df25cc8f60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 PReX3Xb+f8A2Aod/mYzMlH0gF1b0LqIyNdti9tndLpUdpxSc67LOdgwAxTmz1LWbcV9rhuRQ4Aiao9CWk+Myt6tWBQBfHGxY6u74DJSOl8DTWm76lU7hWm9S1zTHapRu/3kTOknn6CearOcAOSwXlGeKSKSOXnK+uI0WoAls3x8H4r9SJV8P3h0qmMAje0H/OwK8bv+vKh7xXd2LqGGUolmOMJB3H/td8ZrB99v9U+S5rV3BhTafBc2ndpEBCbeKCIz6wW6Op8e3g33QlHQOUv+WogGiaged5skU5puKJpGkuqGjCeCWqrI4k6Sz6vArxfmFKWpxYpCz90eDi54Wr0PZFxU2zM+7YFSFYQKP3T7z1XbXOo5f+3WWFuo4CVGaG1aLkMhVwwwLzaGgdcXHNVmrbwGM9gSbWxRzKeIvTd0zT+JzsmVOS1VTOHYyvoCjdvsqmU+1XpYqf0CB10j+wIiYyfhqxmHzSoHBrZE5+kZsoggC3W3UsMWRglNu6B/dCka4el6oqL42ZiHrtkueHLMA5YcJeC2YSWFiYAHRRHkOEu3429rJKeEXUnLRmq72/wOwJ1uW3e5QF6uBsqHSz47CXfyPikz4Auq0Rh+oVTgEEr2wfacg3VVZRnfyrD6DsVsLKOxqYUKjexyXQntHswD3rN38X85htT79yzp029k1Nczde0w99xLNgpq2oIqTkSQkZJT1s7I4OYqqOQYPZpB0BDGXP9hfFEP9BVBpdp0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wHEpcroVcO7nCIJ4OL5cEwJx4y+9baSUcVKM5T/jWzbQU3xT/gyQXlTpiZoU?=
 =?us-ascii?Q?2cQfuMgqTvrkwlcq2J4HMoLt21DgsOOYFZob3FVgtO3yFGilCEg+wiL8ZyaG?=
 =?us-ascii?Q?B9zKk/hyH2fozGOkKR90DIlkW9Qbl7yT6EBMn5RBrvC4s+xMyCVwVFT5Qov8?=
 =?us-ascii?Q?ypOIz5P35NLyB/uGuiNei/CEWO9rsMe5rOySLKg9phKBCKGsWa438l5rdmAd?=
 =?us-ascii?Q?iAlZiepY7T5/nw0ktIQ26PfIekuZCycQciWcPeGCR8EMecHIP21M0+ti0XCx?=
 =?us-ascii?Q?OOJp+MbDJZs2pURq5D5lEgjCzBfL4lyzoptV3fkzED3uWVsTImYoCIrbvdCZ?=
 =?us-ascii?Q?50n78/5bgBIy185g1KlXnVGNfamQmyeOwmUXVMSGTSgCJIVGOwZN/SeFBdhY?=
 =?us-ascii?Q?gZtZb37hkTXuHEqTPUaUZ6HmJRir6zwQCp6V5gFexwQycvF9ggSVkbBOXVEB?=
 =?us-ascii?Q?UkPTPmxfekmvuTUQfPyXtNePTuJQDtIUy1E1NAB/Hfb1qyWRnP4AdH7FqZjh?=
 =?us-ascii?Q?dkNo9f7CchQUEMAeUQ5glV3029O1OYFR7/ePZus/bRWh/u2Zz0mQIYd8eYEN?=
 =?us-ascii?Q?dnqXIhXrj5HlKnwfvqFnRff2QPEcLUAYJRtTL3qdLxvNFrfzcmkRVuwoNZIb?=
 =?us-ascii?Q?beVqVgc8f5B2elG8yJPPjhUPul3GcxBCLFTGcBP9e4ubSII+8SrTUJfNEyHK?=
 =?us-ascii?Q?ZWz8SHiFbdpTf/XCcjlo7TJ6qc75NxIp7OHAnHENYwSq3RWnZJFrG+xN5OAo?=
 =?us-ascii?Q?50rii6rI2pw0Q8LkvmMo5poXPAtezol0vNMo8mFc4dFc8nDbasCA9pDlt24/?=
 =?us-ascii?Q?dK8OCZnjsHfV89vn86IZKDWduvH2WdmlalhAJXht6BVMg5cuXlp5b0Cy9bcy?=
 =?us-ascii?Q?6XmOSIlkOg9P1KMfNIhKUcUg2wlHnbh/MsIBFPsd2YQHMLgbsk9yT/3MdcyN?=
 =?us-ascii?Q?HdeN4c5/6EfZlZzAqTchpagtltCmyy9Dx5rpI06UB2T9rrL+c4+8VKHFxBgL?=
 =?us-ascii?Q?p39Cwp75E59qE9eLGelbjt1U5kEZcvs0NEDNlfFywqhQUiwgWT4bB6GkmNCY?=
 =?us-ascii?Q?JmAeU5Ajg1D1ZT7QieCckZFcEgceVAvdxQREfYD8iXVzMdb7u8dnuUNyZU74?=
 =?us-ascii?Q?iTOl26EzPAGl3jlfoTZnPqRBEviqXQcyvSa8Fzf4U1wWrkaz0We6qz4dC/NX?=
 =?us-ascii?Q?kTHHDiyz2MNKEuYrxaX6XYMnV0nWT4Bsr2YLgkVUpxxn1P/n0zUVYat/MtIh?=
 =?us-ascii?Q?tSX3AiiYT2f/xIZwfNeFML+pLIbLmRXzcnlX/+s4SmifuuyULia3mdNojkKx?=
 =?us-ascii?Q?yKsM2vtw5LH1jh1xpF1Nxbg6WPGrBbZff96P4JRmxws2RWCbDMyMRJg5aHHy?=
 =?us-ascii?Q?IRhEBlECAY6PnHTxHbMRQEF78BlBLlvLoSxR3Fq3AZUkh9f4KxFAZdE+kqJZ?=
 =?us-ascii?Q?SUtDSSn5V19T2LQ1Rm1y1S+GUDsGqghASz95a/iIxeiU4wPzmncWkFNBx4OA?=
 =?us-ascii?Q?xePSgnnypn9QiesWKLZR/p8coMJokITNmWJ4hD80zu+djij1s8TTe9eTVts+?=
 =?us-ascii?Q?E98iJJs5hUba8Ohh7QiZpJYWqgbSoCO7+C7+V7qJGVxMEP05Y4Mq5xLmOoRt?=
 =?us-ascii?Q?2rvod6kivNYS3UxjegbtDwo8S3noBIOsloTsk8EHjGaONMVIWpdaNyDUx5he?=
 =?us-ascii?Q?NwkIvx04YurIlOdWjL+e6F65WMqkfsksrDauV6vn8O3TxR12?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d190e87-4cf6-4962-67f8-08df25cc8f60
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:21.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PChZeyI3jpsZbhFR1iqyOmI9xHNUbLvzdI7z+ki7Sm2LTnq5S7Qx06aVkGQaWqYVZj280pHEzd/lwga/KVBvxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:44 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
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
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
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
>=20
> This is kind of a backwards introduction.
>=20
> "Now that a generic excluded-range list expresses the same fill/drop beha=
vior,
> register the MSI-X table as a read and write excluded range instead of sp=
ecial-
> casing it in the read/write path."
>=20
> The generic excluded-range list doesn't exist now, we're adding it here. =
 We
> don't change MSI-X to use it until the next patch.  We're not doing anyth=
ing
> noted in the second paragraph in this patch either.  The next patch has a=
 nearly
> identical commit log, please be precise in what each patch does.

Okay, in v6, I will reorganize the split as below instead of only wording c=
hange.

1. Add the excluded-range list and make the read/write path use it,
     with MSI-X moved onto the list and accesses that span several
     windows handled in the same patch.
  2. Build the sparse mmap capability from the list.
  3. Make ioeventfd registration and dma-buf export consult the list.

>=20
> > No functional change.
> >
> > Assisted-by: LLM
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
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
>=20
> Better packed to move the bar to the end, it only needs to be a u8, but i=
s it
> instead better to make a per-BAR list and keep it sorted on insert to avo=
id the
> runtime complexity?

Okay, I will make this per-BAR and sorted on insert. With one list head per=
 BAR the
entry no longer needs a bar field.

>=20
> There should be a comment somewhere relative to the list only being fille=
d at
> the already serialized open_device and therefore safe for lockless access
> runtime.

I Will add it on the list heads. Ranges are added only from
vfio_pci_core_enable() and freed in vfio_pci_core_disable(), and every
reader runs on an open device in between.

>=20
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
> > +     range->bar =3D bar;
> > +     range->start =3D start;
> > +     range->size =3D size;
> > +     range->flags =3D flags;
> > +     list_add_tail(&range->entry, &vdev->excluded_ranges);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
>=20
> If this does an ordered insert, I think we could also require that ranges=
 cannot
> overlap.  Everything we're considering currently, MSI-X vector table, HDM
> registers, are distinct.  They could theoretically overlap relative to th=
e sparse
> mmap capability once page aligned, but the excluded range list itself sho=
uld
> only contain distinct, non-overlapping ranges, and I think that simplifie=
s things
> a little.
>=20
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
> > +

Agreed. The insert will return -EINVAL for a range that overlaps
another on the same BAR.
I will update v6 with the new flow you have suggested.

> > +bool vfio_pci_bar_find_exclusion(struct vfio_pci_core_device *vdev, in=
t bar,
> > +                              loff_t pos, size_t count, bool iswrite,
> > +                              size_t *x_start, size_t *x_end) {
> > +     u32 want =3D iswrite ? VFIO_PCI_EXCLUDE_WRITE :
> VFIO_PCI_EXCLUDE_READ;
> > +     struct vfio_pci_excluded_range *range;
> > +     bool found =3D false;
> > +
> > +     list_for_each_entry(range, &vdev->excluded_ranges, entry) {
> > +             if (range->bar !=3D bar || !(range->flags & want))
> > +                     continue;
> > +             if (pos < range->start + range->size &&
> > +                 pos + count > range->start) {
> > +                     /*
> > +                      * A BAR can carry more than one excluded window =
(e.g.
> > +                      * the MSI-X table and a CXL HDM decoder block). =
Return
> > +                      * the overlapping window with the lowest start s=
o the
> > +                      * caller can walk them in order.
> > +                      */
> > +                     if (!found || range->start < *x_start) {
> > +                             *x_start =3D range->start;
> > +                             *x_end =3D range->start + range->size;
> > +                             found =3D true;
> > +                     }
>=20
> For example, we wouldn't need to iterate if the list were sorted.
>=20
> > +             }
> > +     }
> > +
> > +     return found;
> > +}
> > +
> > +/* True when [start, start + len) on @bar overlaps an mmap-excluded
> > +range. */ static bool vfio_pci_bar_mmap_excluded(struct
> vfio_pci_core_device *vdev,
> > +                                    int bar, u64 start, u64 len) {
> > +     struct vfio_pci_excluded_range *range;
> > +
> > +     list_for_each_entry(range, &vdev->excluded_ranges, entry) {
> > +             if (range->bar !=3D bar ||
> > +                 !(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> > +                     continue;
> > +             if (start < range->start + range->size &&
> > +                 start + len > range->start)
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/* A page-aligned mmap hole, derived from an mmap-excluded range. */
> > +struct vfio_pci_mmap_hole {
> > +     u64 start;
> > +     u64 end;
> > +};
> > +
> > +static int vfio_pci_mmap_hole_cmp(const void *a, const void *b) {
> > +     const struct vfio_pci_mmap_hole *x =3D a, *y =3D b;
> > +
> > +     if (x->start < y->start)
> > +             return -1;
> > +     return x->start > y->start;
> > +}
>=20
> We wouldn't need sorting if we just did an ordered insert.
>=20
> > +
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
> > +     sparse =3D kzalloc(size, GFP_KERNEL);
> > +     if (!sparse) {
> > +             kfree(holes);
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
> > +             }
> > +             pos =3D holes[i].end;
> > +     }
> > +     if (pos < bar_len) {
> > +             sparse->areas[j].offset =3D pos;
> > +             sparse->areas[j].size =3D bar_len - pos;
> > +     }
> > +
> > +     kfree(holes);
> > +     ret =3D vfio_info_add_capability(caps, &sparse->header, size);
> > +     kfree(sparse);
> > +     return ret;
> > +}
>=20
> I imagine this could be simplified quite a bit:
>=20
>  - walk the list once, count mmap exclusions, if none return
>  - allocate sparse structure assuming # mmap exclusions + 1 =3D=3D # area=
s
>  - walk list again aligning to page alignment, fill in areas, coalesce
>    as needed, set resulting nr_areas.
>=20

Okay, I will update accordingly in the v6.

> > +
> >  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vde=
v,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,
> > @@ -1160,6 +1359,10 @@ int vfio_pci_ioctl_get_region_info(struct
> vfio_device *core_vdev,
> >                               if (ret)
> >                                       return ret;
> >                       }
> > +                     ret =3D vfio_pci_excluded_sparse_cap(vdev, info->=
index,
> > +                                                        caps);
> > +                     if (ret)
> > +                             return ret;
> >               }
> >
> >               break;
> > @@ -1853,6 +2056,10 @@ int vfio_pci_core_mmap(struct vfio_device
> *core_vdev, struct vm_area_struct *vma
> >       if (req_start + req_len > phys_len)
> >               return -EINVAL;
> >
> > +     /* An excluded sub-range is reachable only through its trap, not =
mmap.
> */
> > +     if (vfio_pci_bar_mmap_excluded(vdev, index, req_start, req_len))
> > +             return -EINVAL;
> > +
> >       /*
> >        * Ensure the BAR resource region is reserved for use.
> >        */
> > @@ -2317,6 +2524,7 @@ int vfio_pci_core_init_dev(struct vfio_device
> *core_vdev)
> >       INIT_LIST_HEAD(&vdev->dmabufs);
> >       init_rwsem(&vdev->memory_lock);
> >       xa_init(&vdev->ctx);
> > +     INIT_LIST_HEAD(&vdev->excluded_ranges);
> >
> >       ret =3D vfio_pci_core_cxl_init(vdev);
> >       if (ret)
> > @@ -2332,6 +2540,7 @@ void vfio_pci_core_release_dev(struct
> vfio_device *core_vdev)
> >               container_of(core_vdev, struct vfio_pci_core_device,
> > vdev);
> >
> >       vfio_pci_core_cxl_release(vdev);
> > +     vfio_pci_free_excluded_ranges(vdev);
> >
> >       mutex_destroy(&vdev->igate);
> >       mutex_destroy(&vdev->ioeventfds_lock);
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h
> > b/drivers/vfio/pci/vfio_pci_priv.h
> > index 4e7162234a2e..c268c99aea82 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -44,6 +44,15 @@ ssize_t vfio_pci_config_rw_single(struct
> > vfio_pci_core_device *vdev,  ssize_t vfio_pci_bar_rw(struct
> vfio_pci_core_device *vdev, char __user *buf,
> >                       size_t count, loff_t *ppos, bool iswrite);
> >
> > +/*
> > + * If a read (or write) to [pos, pos + count) on @bar overlaps an
> > +excluded
> > + * range, report the byte window do_io_rw() should fill with -1 (or
> > +drop) and
> > + * return true. A single access spans at most one such window.
> > + */
> > +bool vfio_pci_bar_find_exclusion(struct vfio_pci_core_device *vdev, in=
t bar,
> > +                              loff_t pos, size_t count, bool iswrite,
> > +                              size_t *x_start, size_t *x_end);
> > +
> >  #ifdef CONFIG_VFIO_PCI_VGA
> >  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user=
 *buf,
> >                       size_t count, loff_t *ppos, bool iswrite); diff
> > --git a/drivers/vfio/pci/vfio_pci_rdwr.c
> > b/drivers/vfio/pci/vfio_pci_rdwr.c
> > index 7f14dd46de17..48da1cb08296 100644
> > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > @@ -261,6 +261,14 @@ ssize_t vfio_pci_bar_rw(struct
> vfio_pci_core_device *vdev, char __user *buf,
> >               x_end =3D vdev->msix_offset + vdev->msix_size;
> >       }
> >
> > +     /*
> > +      * A provider-excluded sub-range is filled with -1 on read and dr=
opped on
> > +      * write for the same reason: the guest reaches it only through t=
he trap.
> > +      * An access spans at most one exclusion window.
> > +      */
> > +     vfio_pci_bar_find_exclusion(vdev, bar, pos, count, iswrite,
> > +                                 &x_start, &x_end);
> > +
>=20
> This is not well integrated, we're stomping on the MSI-X and ROM set
> exclusion range just above.  As a result, we likely need to integrate sup=
port for
> both at the same time, and we also need to address the multiple exclusion
> range per access range, that's only in the next patch for some reason.

Yes, agreed. I will follow this in the first patch reorganization mentioned=
 above.

>=20
> I don't think we want to move the pci_map_rom() call elsewhere, we try to=
 do
> it in correlation to the access.  People are crazy enough to update devic=
e
> firmware while in use as well, so I'm not sure the length read from the R=
OM is
> static.  Maybe this should instead be handled as a hard stop at the end o=
f the
> BAR vs a soft stop at the end of the data, filled with -1 on read, and ha=
ve that
> live outside the excluded range list?  It needs some finesse, this is clu=
nky.

I will leave pci_map_rom() in the access path as it is upstream. The
ROM stays out of the list: a read past the end of the ROM data and
inside the BAR returns -1, and the BAR size is the hard limit.

>=20
> Also, what about ioeventfds and dmabufs?  Thanks,

Richard asked the same on patch 21; I will add the checks in v6

vfio_pci_ioeventfd() refuses a registration that overlaps a
write-excluded range, and a dma-buf export is refused when its ranges
overlap an excluded range on that BAR.

v6 will move these into this part of the series (patch 3 above), so the lis=
t
covers every access path from the start.

>=20
> Alex
>=20
> >       done =3D vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM=
,
> io, buf, pos,
> >                                     count, x_start, x_end, iswrite,
> > max_width);
> >
> > diff --git a/include/linux/vfio_pci_core.h
> > b/include/linux/vfio_pci_core.h index 7f3a2bcb5830..92e3db116068
> > 100644
> > --- a/include/linux/vfio_pci_core.h
> > +++ b/include/linux/vfio_pci_core.h
> > @@ -162,6 +162,7 @@ struct vfio_pci_core_device {
> >       struct notifier_block   nb;
> >       struct rw_semaphore     memory_lock;
> >       struct list_head        dmabufs;
> > +     struct list_head        excluded_ranges;
> >  };
> >
> >  enum vfio_pci_io_width {
> > @@ -172,6 +173,19 @@ enum vfio_pci_io_width {  };
> >
> >  /* Will be exported for vfio pci drivers usage */
> > +/*
> > + * A provider can keep a BAR sub-range off the direct guest path,
> > +reached only
> > + * through its own trap. The flags select which paths are excluded:
> > +mmap, and
> > + * region read and write (an excluded read fills -1, an excluded
> > +write is
> > + * dropped).
> > + */
> > +#define VFIO_PCI_EXCLUDE_MMAP        BIT(0)
> > +#define VFIO_PCI_EXCLUDE_READ        BIT(1)
> > +#define VFIO_PCI_EXCLUDE_WRITE       BIT(2)
> > +
> > +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev=
,
> int bar,
> > +                                  u64 start, u64 size, u32 flags);
> > +
> >  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vde=
v,
> >                                     unsigned int type, unsigned int sub=
type,
> >                                     const struct vfio_pci_regops *ops,

