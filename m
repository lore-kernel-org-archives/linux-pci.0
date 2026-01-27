Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384D2D9488;
	Tue, 27 Jan 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526288; cv=fail; b=snNhuNRPAjF/8L85ZKMAqA7fmajPPuDeTKZ8Pc9eoyMf+GCXJf1TJC7ahhji9fNlQAQo189j7w5Drmbr6j+f/ugUPJ0Mu0ZIhLW7Z8bWjfz83peuNf6kRLywXfME5sR8SFEg+GEcGF/3YzNjEWg+vBjPNPK+eLqfARMAnLbFO+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526288; c=relaxed/simple;
	bh=PjNwj4kdesmOlh7unjUIe63qyUx3ayFZQmCPLH+o08o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f8ElEezJOQnYvMt/j+jQGkZsYOW+gpKZIdcFeaiSt9/Qhb3ZWV6SrYBJAwjhgoz7PG0miROtU22Ev8U05nyaHTe90PRQJIfwyVaoKcC9YeGLekNH+wwi/+POMRh7FTvDpx4L/AQ/oG+amWXGUkn6Zi8b6mY8MFvpCgHdH9fkro8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LOvrlevl; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LOvrlevl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzYjEHhrCy6vmvCyUHQKc5u6K6PMvfcZVhr0MSUjgMGmMSkHEfvytzWupRxtTumoDunMJQ1sOVBfjOgwa0b9b8vojhpTd5wS+S27nouP9fsoEdf9gLblVIYmAStZokpRUe9hqT9RBd++RxQIl4PFMhfLrTUARcnpID6hxep9qweHSZSRFe6LTDaw4GZD8pFwu8XBzPV5VZW948i53DyvEMyJW5bqt9zG3Tp2JfRr+mkMYyVDBu7ckJsWobmXob5xbPUIc1dMILQWw0jEGLHCEwElSLD21rZ1UaROxgNOvgoCcz8J6Bt4Z53rE5kBlrhSNPQNI8aOJ3Du3peYoBPzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnGF8v0CIOSu0E1CvSk7rs2V4492ItlK93woBNZvEJ8=;
 b=nzsYYTtCKwRDoN5M5V23Ele79w2A7RBDxTdYmL3ShxXCZFL2UtbSI6Z8CKJ9e2fEgFWILS5+bBJX0PKawilAl/LoqB4+JDg6YFHjxOL+VUsyhSeNbR8kaAXI5GSsNgY02XW5Jx739hlI3pSYAKqu0UbrHTe0yYkcOl5nLN80PK6WrLtJ55YXOS//nx0Q6bm2nr6TcdU7ZryqPe+gF6d9hGoNzflSkQyH98+APcdF4xP+3bZsssNub0S3b7j3UPLcrx7l+OKpkofVIz6NYY9eupz1AWFdQ353pvQvRxqkpA+3w5qkQ/aHjoZaG8xwgc4A4IrQGLR6/jiOxE4orCAHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnGF8v0CIOSu0E1CvSk7rs2V4492ItlK93woBNZvEJ8=;
 b=LOvrlevlhIZsW11ucfd8KGRofB1M4enRqrw1cugdUVumuPtRM6tyekBcuDScm7vQOAcZY4z1v/xil+hy9nDTb98CvW4b1BhMmDfvR/2WlqTiCYefVPkyFaNYLEEhlfGj5swfuSg7a50aFFvNUtzo2MbAxbx5RTEDoDedD5UM41DaOT+YbmwAYASYNGxL6X/ssrPjpa1/fugR/h+igCj6XlQ52ao/t3EqAgMK0KBFQ5Kl6cieErqhTIrz4HgSh5zCfLzFu3BNtQePsEYVOU1EsaW6plKuMAPSm5+tDIPYj4hSXtkHlKPLmJ+QApxT8eG/8fM3H/+mXZ24LW+vdqzQWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 15:04:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 15:04:42 +0000
Date: Tue, 27 Jan 2026 11:04:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"praan@google.com" <praan@google.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"miko.lenczewski@arm.com" <miko.lenczewski@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260127150440.GF1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
 <BL1PR11MB5271F0BDC68C2D7F172122E98C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
 <20260121100307.00004e60@huawei.com>
 <20260121130315.GE1134360@nvidia.com>
 <6971b9406d069_1d33100df@dwillia2-mobl4.notmuch>
 <20260122131432.GJ1134360@nvidia.com>
 <69727e7ded712_3095100ab@dwillia2-mobl4.notmuch>
 <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527649A0049CA195E7BCF9218C90A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0050.prod.exchangelabs.com
 (2603:10b6:208:25::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: c30195fb-381d-4ee8-a477-08de5db56637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ossd/2vHpFrvqf8HKuISJSxTK9KqUnQ5n29W/iqpvvvvAjepmx3UCY/C3GF?=
 =?us-ascii?Q?0C5pO9/SwwFOKX0SYIXGszjTKU6YMLLrRFYsfO8pl8INA2Faylm72217Quma?=
 =?us-ascii?Q?oGrnykKuaGw4rIaWxrwHwQD8iQFbkYBnCMetytDR4FKkCt5ZemQmDYicKG1G?=
 =?us-ascii?Q?UMHISOnwjdZHD0R43Zc44hJlsOy2VG+TWPMeGCRnl46/2kbqpqzTOmaXnCGQ?=
 =?us-ascii?Q?P1fXhiyxJHqKzFJ8iIHw43ys2dmLq4SoPmD15ih8oMEDj4u/wAIpoOMqGPbn?=
 =?us-ascii?Q?bE71DhymYFlxsb8ctePIrhoxawmFRdBJdRMhGQHtjnJy3j2dAkBEgdLD9AiZ?=
 =?us-ascii?Q?bFR3C0J/sBMqAPKH0sn8oNEWHBuGGrKmGMc/kKVR9p1Dpi/hq34nlu4tuut0?=
 =?us-ascii?Q?r3pugM5EdDka2DDG3t2AA7z9/Q/yJGNa9yRihVl6B/dwzcHNxsfB8yv3Q0DN?=
 =?us-ascii?Q?drQryP3eDwqyEJ+5DD7sDAF9IS7iRCM3xsMP4Tvn7ZFrOE+sY9sadFmDht4A?=
 =?us-ascii?Q?eqneah25yBi/xqZqmEr8Qwj4Cg5vxT+g8rylf7ooErM5CElM+i//8WK3VX3M?=
 =?us-ascii?Q?k19ZVunXBCmNQBBuccsgIYI4nx6Yt33/INr4qELwe7NyIU+H/AIPe/0/PQNQ?=
 =?us-ascii?Q?2Rp0iwgGZNMfghwP3WDdmYgktdC1+h16TOYrZR8hgS/DabyZ/hFV2bkyuLi1?=
 =?us-ascii?Q?qMfLKuQaNd+nJ7l6uqDlWmGDV71zzf3CoWsJSGXlJwFG+Kr0uol8koUd43gV?=
 =?us-ascii?Q?/UpC+ZLFBl4EikTXs/BvNqrqcLtIQdSzODE4gUSSJflLj41ap4PHPE2HAklv?=
 =?us-ascii?Q?gF6G9dKiClAWAgQ8nlhehrb6UWYVMvpMFMoer1LVsjh+EfssdxbDjz/aTpAy?=
 =?us-ascii?Q?5puOUvCHHi9bjxF7IZbxi/L+eytWp+NTfG/WuF+H2n5cF3cmuDXqvMy8xEjJ?=
 =?us-ascii?Q?PFJxlqZuf1qYAfDR6iYdPUvEoDTvlvUzg9FQzadAWRmlcNLV804IvcjApApF?=
 =?us-ascii?Q?ccYMro/c9N0K0yn/KslAw4UsNc8fMevrJU7z+foDGMQ1gHw0Pd2b0PfOWqnk?=
 =?us-ascii?Q?hUVUv5kn5ZVTWaiTu09GapnTc8PbzmhAacE/lDaeFW0aT5mAL9WZVIBhU7TG?=
 =?us-ascii?Q?vcOvncX2/wSLlKMjyVkvZHBt2ExyK1kwdvs0eQxDj4HM4YbtmNeUselbEwL7?=
 =?us-ascii?Q?gTXcODyCSR9/oxLt2rGJC1NPo13zeK2I3WVvwBWveEssurvpdsz+MfbnxMMt?=
 =?us-ascii?Q?CtA/Tk1Sca/uTRu3hbjWZ2Njkf6bL2WNhZkIVnQQ+A5FbkpyM8Il0D/tM4D7?=
 =?us-ascii?Q?IcNugcAB4pu0alHmP1fd7kQNVPnRpoAAu8Aq+FZIiyugPCTyqkHTyYHvNmYK?=
 =?us-ascii?Q?/vj2QTyNFPfE+EWQpchHJ/jBp5FsoTDAFZG2d1xU9oJMQTAgVkQsUNi5LK60?=
 =?us-ascii?Q?dY991zW/Ug0Hx9z6ZdLyyjenNrTBlNuHqJ8BEHM0mITHHYsfp2N6zojFHRCo?=
 =?us-ascii?Q?IWzme64fyS0KX4Xf1JFaAiTCTtsDeA+lzg+9b+zCjFnaBknNZnRc/RiFLVuJ?=
 =?us-ascii?Q?rGY6D8ssaSdXBg+/6Lc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Xj1Yc6yemPo/hSFphn6MoUiDdCcBYqMsWusu/lf3wEbCvedY2peV27pcPfW?=
 =?us-ascii?Q?8JidbHehprzR7CyJ8eH+wmjFlkO6bpZqPePtmSahV4ZUU0x01sT4HoIu7Jby?=
 =?us-ascii?Q?cWnlYFsK6hx2QSeJk+bHHev062Y+XfyZwhd81P9B2y58PDa/LwaMMrLjijlF?=
 =?us-ascii?Q?SI5edgeKkPN/IH3MlOutbWQAoL5zp/cLOp0yfMnlSuOBfmQBjJY1hooINWik?=
 =?us-ascii?Q?hGeynhjR+fbrxxcUh34D37cjXkXEes8rBraYLX6zZ9D4a45m8Hs3s7jY+25w?=
 =?us-ascii?Q?WbMAD+U/u9GYFreTqUOVKuNCnOSCArk+M1y+kNPJjZkIXZ3uYAkks9HAxV41?=
 =?us-ascii?Q?1NiWqhz4vcqXKp/KyaJFQkZCQ7Cb/RVjeirnSFXIo8Qazwo8KbVT31DKl8Fh?=
 =?us-ascii?Q?+w0DEiR0HZbaZdvQbTGUk2GP1BgZUaL71vYORMHyyiQzXzRWomycaIM2GOzA?=
 =?us-ascii?Q?JTYXwiWKHnuOGsBDi94o3bmNqmVrIQ5bvPQv7Xdhoc/0tvmZbXqqJyfwRe8F?=
 =?us-ascii?Q?tuYwo221I7MyWou7XMTDxTafNjX4EpwtJbLv4O2uSRzcy3jbpHK6aiLvWlYP?=
 =?us-ascii?Q?tFgcvnfMvEgXSUgSpXhaI90rOH8cqBVz3lnbZy4IQ0FoXyrYmGyq1Gz5H+6d?=
 =?us-ascii?Q?ioYEjpB1/YdglIc3ARqZB27SN3HETbB5ZP6eXSRudtJODsI1CSmjL0CCu/sq?=
 =?us-ascii?Q?M/fk4YsU5M+UPMrg+E4PJzj11yWvd7CMAojKOcq4bP+E0ZKd3tEhQPI4HknQ?=
 =?us-ascii?Q?5jmEa4LyhUvGXGb0vfBKnLh3bhu+yNZP1ddkRHTVpHTLU5qVbwyT9OBbx9RV?=
 =?us-ascii?Q?cihbR2o5cCeb+EbqrPZfCUNhTKyeaAs6+jEJO6ZSHItnOX8k493wqwYbiGvT?=
 =?us-ascii?Q?1LBpCQyYhZm7CB8Hdm1mnlN20nfaipF+btAoCtpbSwLRrwK/y8VN+qsSlh0d?=
 =?us-ascii?Q?ZOIEJgefYp/Z/wNh7HZfcwAZ/0NwczGSKiFwskinVQnPZv36ITsUTTRnEiZy?=
 =?us-ascii?Q?YwO+fKW6cuv1Yu9E3dU8R3a0fLQM2Tw9E8M6YFDGLQuYhaBcJ1Pv+ZL9FiJj?=
 =?us-ascii?Q?nEmIq4CtyMjxxbT95bJtjTJJVTT4pAq5vOaagM5w7YNLDRO3gaD06QxMotFU?=
 =?us-ascii?Q?2RHsqZIGwd3GK12SGBfzLO9Q+YVR75FSpUulgv+WRwqIX3KJFjP6EaHnWG1P?=
 =?us-ascii?Q?UhPo0xOPlWDNfqzVXfkAlvU7sJsXN0+FO3eKNQgXV/bVFdx/wu55Jssn1lXh?=
 =?us-ascii?Q?yUdpwSxfUjOLkpEdOEP46nFPmbG5Njf2+ACsLUSnpg99xWL5mGS7/evhFE5C?=
 =?us-ascii?Q?kzOFa4iF9OQeXNcIuzUi7gps/F3igrTCXJK894fPohULiHU1ZOjJbJEfEi52?=
 =?us-ascii?Q?cPQHBpJL7/bkftUdx1aT3XVuRIP7ET8HY06URbNtwhhhbHApsrmp7xg+9ygI?=
 =?us-ascii?Q?XNuO3vjXrDUpWW7H76yMs9uTdz5KOoma5Ja2E/quQW+VI4f22LUUyPUxR4QO?=
 =?us-ascii?Q?I+LIl+LePMkQ9QbBv41t+3pIaMmf7StZY9uEsuJmbf1sKOUusLlr/JdMcK8O?=
 =?us-ascii?Q?tHOpcCMVyWmXNckwPMeOI8GcVEZGcvEcE4wXSpw6FUvz1ufViABqLSa8qmBQ?=
 =?us-ascii?Q?7eiAY1Nl70xBLTtKdoemHDAGcH1hVDMw2cutL5dl4wrteIi7bZ52KTLHf2dK?=
 =?us-ascii?Q?i4HtZFECln/aseByqn42wtcyHWQ6/i3CC81ANjErKc1qq7SWz8afYIIq9fUE?=
 =?us-ascii?Q?q8+F3PLbCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30195fb-381d-4ee8-a477-08de5db56637
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 15:04:42.0207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCzzGmrfYuCC9o9E24sWsLoVuarUmUyNXkTlWtfMiX5Qjfs4q22LNZN66uLNPTA2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116

On Tue, Jan 27, 2026 at 08:10:06AM +0000, Tian, Kevin wrote:
> > From: Williams, Dan J <dan.j.williams@intel.com>
> > Sent: Friday, January 23, 2026 3:46 AM
> > 
> > Jason Gunthorpe wrote:
> > > On Wed, Jan 21, 2026 at 09:44:32PM -0800, dan.j.williams@intel.com
> > wrote:
> > > > I do not immediately see what is wrong with requiring userspace policy
> > > > opt-in. That naturally gets replaced by installing the device's
> > > > certificate (for native PCI CMA), authenticating the device with the
> > > > TSM (for PCI IDE), or obviated by secure-ATS if that arrives.
> > >
> > > I think that goes back to the discussion about not loading drivers
> > > before validating the device.
> > >
> > > It would also make alot of sense to leave the IOMMU blocking until the
> > > driver is loaded for these secure situations. The blocking translation
> > > should block ATS too.
> > >
> > > Then the flow you are describing will work well:
> > >
> > > 1) At pre-boot the IOMMU will block all DMA including Translated.
> > > 2) The OS activates the IOMMU driver and keeps blocking.
> > > 3) Instead of immediately binding a default domain the IOMMU core
> > >    leaves the translation blocking.
> > > 4) The OS defers loading the driver to userspace.
> > > 5) Userspace measures the device and "accepts" it by loading the
> > >    driver
> > > 6) IOMMU core attaches a non-blocking default domain and activates ATS
> > 
> > That works for me. Give the paranoid the ability to have a point where they
> > can
> > be assured that the shields were not lowered prematurely.
> 
> Jason described the flow as "for these secure situations", i.e. not a general
> requirement for cxl.cache, but iiuc Dan may instead want userspace policy
> opt-in to be default (and with CMA/TSM etc. it gets easier)?

I think the general strategy has been to push userspace to do security
decisions before binding drivers. So we have a plan for confidential
compute VMs, and if there is interest then we can probably re-use that
plan in all other cases.

> At a glance cxl.cache devices have gained ATS enabled automatically in
> most cases (same as for all other ats-capable PCI devices):

Yes.
 
> - ARM: ATS is enabled automatically when attaching the default domain
>   to the device in certain configurations, and this series tries to auto
>   enable it in a missing configuration

Yes, ARM took the position that ATS should be left disabled for
IDENTITY both because of SMMU constraints and also because it made
some sense that you wouldn't want ATS overhead just to get a 1:1
translation.

> - AMD: ATS is enabled at domain attach time

I'd argue this is an error and it should work like ARM

> - Intel: ATS is enabled when a device is probed by intel-iommu driver
>   (incompatible with the suggested flow)

This is definately not a good choice :)

IMHO it is security required that the IOMMU driver block Translated
requests while a BLOCKED domain is attached, and while the IOMMU is
refusing ATS then device's ATS enable should be disabled.

> Given above already shipped in distributions, probably we have to keep
> them for compatibility (implying this series makes sense to fix a gap
> in existing policy), then treat the suggested flow as an enhancement
> for future?

I don't think we have a compatability issue here, just a security
one.

Drivers need to ensure that ATS is disabled at PCI and Translated
requestes blocked in IOMMU HW while a BLOCKED domain is attached.

Drivers can choose if they want to enable ATS for IDENTITY or not,
(recommend not for performance and consistency).

Jason
