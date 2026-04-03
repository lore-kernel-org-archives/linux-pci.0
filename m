Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599863148CF
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775225346; cv=fail; b=BaZJfG54dwNvrRAcwN6yMBGnnAvmDzZ3eRlUG2SCGg0nlDl0LlO3rM5xThOWKlgKo7zm/sQiOOwFaLcJWjcITWbVGWNt50F96QH8spuKNzPDoyHhloL/H7BzEPNtHFfp6LZ2zOpFOOClcJ6JoH0hC/fiWM3Ca0x1/TjrrFOk86I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775225346; c=relaxed/simple;
	bh=q5TIHxEguH5Jwihe5rB7yHawA+aK+EFIrp5hxx19JiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ve19GunlZslqbpJTQQjm6RjEq/PcC0MWQwrqXBbueLOvcrFDzI0qJ+hej99sAsieh5ucnN2bnSPFd1X+BLCiaotQr3WUEi+IhdXsmgcPKiUXKePJo9V7uxQDT9Awc5g43+H0aztuDOPLYQzzgsz4asghJP871mlYU5nsDIxHKQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D15wQgPS; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D15wQgPS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpffa++4rseqLX+c5HTBcmDVsfFWDqoBE2jWy0pr2Qru8K7oLBrvV9+D7srkhnMkvai8v/gPg9C9+Eq10dOVHfZPnrXRPuLXc8TvIreHEckf/JQR9suVKXTTxMXbgjy5OmKPsX5KPbmkLd2R5Qt64HQCgwQi2tGqPhl5zGZj3b/BKmnYR0nK5Cf/4M94sCbUZw3/AYG9JdyJTdE/P9AEdsXfbRFxk51AC3vejwQrr1jpYo9tPr6dzCyksubyZWZ1BSMFNOKW94EPnm7s1BkcQTGInO5lRSQVlzrG7K2DiNtKWILXBlTGhInc/2/SWTcnIdS3CJm3SVNlWmct/VGAVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB7L09RIH2F2z3Y+THZSjfHw+FCciXuygxMPJH4oVQY=;
 b=rmou37KBbT0qRHkRqBPtwWuyYxHR3dhTGhPyr2LFHgzRbsFwv6t+NzRm9nwnSgeErkTITMAMewBQGqgMpUISvWCvcDKhv1vQRE0ywJPOxo39fltlWCOqh1jixPN+npHl/FExZbvJY/ZBMBjgURbNeSb07xLzYxVXAry8JMYAYNdx5S1HXnk26qqgUOYXMAy0S+iwuBXpVj1vxbJDpDTw57/FKRw9ennhnBH8U4UIU3A1Ro7mC1l90WCUqLXOzJcdRTvQqFtI7HZc2n+F9Lvl1M3rnxrWJcOX/3XsIRESqJH5xlu7CukUXpBOwWdKoMQIFfqfXSoqeGIe1TFCilRtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB7L09RIH2F2z3Y+THZSjfHw+FCciXuygxMPJH4oVQY=;
 b=D15wQgPSAj25l/s7pWB/w1K07miJUxzY5201YMbFh/lKOY/kH8zGEeJ2ZQyprbce1O7/13E6NIoatTa0upM3j3gr9LI1S1iWZu7WM502mvusMWl5QZSy30hWAHXZYM4L8H8QgZWe/yV5p/kdHsK7szf4w8Jg0c5lnasDnF1JK1um5kvPvKPZi0fw4U/+b1rNgYmXmrT6fbG8XweyOTvttq//E+KHtGbOpfHy5z3ZSLFB13DpojUVh7gNvFFibUan7djmIpz2K+DRaRVvA5YZ7mWP7R/BkwGXo8sJI+s6QHxJVqmqeqR+uB9gqEZCc0A0Im0vOjJ7WuxarDMJqOT+3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Fri, 3 Apr
 2026 14:09:02 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 14:09:02 +0000
Date: Fri, 3 Apr 2026 11:08:58 -0300
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
Message-ID: <20260403140858.GJ310919@nvidia.com>
References: <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org>
 <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <228298b7-76bc-4ffb-bec0-0c35fd487c4c@amd.com>
 <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
X-ClientProxiedBy: MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::22) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: e13e6f5d-20b0-462c-48e7-08de918a8dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8jry0z1v43G+tN0fqUw9Ssu0UBarpPyfO7GXczUG+6Bdq3DpJ/WBTQbPXh8SaUzTVKGjMxhOgBhFX0axDmLZbc/2eFE0yaSyyAcVWJ9NsLdsE8vzojtGlT2236I7ZM0KohwptxugZHnBAvbFdlzNNX8taTWvPHJCQeaU33xZQlj5gN7GRfcBD+eMZioBttJbhpLir+mSaFG9hl+Ye+EILKvz1TIXRsZGH9l9zTg7XlIo6K/iHfREbBg/3+KO8BZ20VyGIIus6pVuoOBJYf8GU8FOWjk0lLs0iq1s0xhik2EKKKi5oCYoNwK32u002qoYa0NerkpJHKcG4t73AzhTkLDVtnH1Vxog0OZ7J9PZ9wrU1xWkb/kO7tOA74QbSgn01JTM6sFG5eiUW/kY+kA4bs2Pi9s0a/EqlF2imALaB5nBUTJX5NmSsmjE5RfTcpr3RjVew5kGE9S4Y/5fH5wiF5hcvh8KSQ9Mp8yL4wK7L51g8UIi9s6/qwTqWx9o55EN/BUotdd3yelo9WfV4fhrRGw3n+JuUdZzVfIkVDVAxKCd2RkVHVEQCjfw9WFKcWFB4f5GZ7p4odz9h5gYwb9sv1MOu3/migmoYT+4q6xB8iu4lVl4zmsc3dYemCvrmWbnWa2QKE/o9rIS9ifA3SQ62SSub2fyqYNrFTmQdw29OX8r4uKlzYhX2N6I/bE2BNUl8MaPhdGWZIFJ/dfCjx/Kevub9w4ZJjO1uyRWLO3ZfN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWEWKSWN5CDhLR7BWhglm/lORyzJnNONDCvLvtKEveAhAV22n5tDJDxSlus5?=
 =?us-ascii?Q?/AEk96nMTAtu+/UYnyxmmxf/MSwagCbcoQXAw+C05jtff91XByq6i4gmJZ+5?=
 =?us-ascii?Q?QNPm9fz50G4zs52QzAwNpY6doyshnAw7FUrl8bcDJCDEIHbJo03DbipDMp+3?=
 =?us-ascii?Q?Bt4GvbXtvsaSw1psxtwb+Ej7g0cY1HxGHnw3Y0VN3C0GfZUafIXbbOb80HQk?=
 =?us-ascii?Q?30KVtObY1U3IiBEDORYdCP14PvM6smWtCSLHQm1UfGWVzYNkzdUuF6RE54or?=
 =?us-ascii?Q?hLQUehvXeDJOuoHyvnI2L7XSl/4OPP8tdj42gR0MFVqU/+3eXlIxCflW2SBX?=
 =?us-ascii?Q?g/KOYX02CkOgV1OyIDxagcaCCVHSwI8Ar94++Lvnrn+6sjTMgLSc0IGu97J5?=
 =?us-ascii?Q?IubU0FnIoQ5waWcTfMfW/3Uq1+M30+wElGWn0pno5q+9i4cjABqclkrTGCBy?=
 =?us-ascii?Q?nBKYgNtaqEjEF4fFTGo1SURkoxWXI4cDROgAyrTceyk07siRbEN7aIA3gGTP?=
 =?us-ascii?Q?hgRdl5bSpMp4QTypzISa4pZIEfTwB5/Tt/0Svwnt5/qa8d1NyO/jnDRq9Gxf?=
 =?us-ascii?Q?KXm8Co2mxPiK/0g2XzcYoeA5DvnU8NpE+1lVZe5/0K0u3HBOsqkwOzyqK3Zk?=
 =?us-ascii?Q?b+QcuinijI6GBZ4cFS2i5N9k6myKJddrtD0rnf33NMpA7vxuU9Lp2Cv1cfdu?=
 =?us-ascii?Q?tIT1GvphbD90WrupFa3lMmIEI2fCpMmw8zphuZivt3NS2pSPHF0nujADYYyI?=
 =?us-ascii?Q?9LxcEJJy2EhchRS5WFKdY9aZItnme2Oa8ZYdoW32b2U1LBWb+mOw6womhLoQ?=
 =?us-ascii?Q?Rrz+mLSKbDzsH9i1tlcpNW7Im5c7t7z5W4NAzV/BuUXl9M+gyZqguNj/S2qQ?=
 =?us-ascii?Q?KDEUWhkf7TPtk3DFIapUomjq7PweJkmz3hmRkC84KdsrQvHFLAjECnSdnSKI?=
 =?us-ascii?Q?TWs38kRFiS6MPJQlSM4lc3cVWq5KWBmWSLqfoMqvTGT6TSdQqv2/rQ2b4Ckw?=
 =?us-ascii?Q?x7I8CM1BzuD7WFc74W/CBLJ2otyulVAuFZ+5pW+lw4V6IhVrMsIJLWAaP/yO?=
 =?us-ascii?Q?MWCnI8oi9Sz9xIKFDJpC5tDJ7DWR7m2OBnc93vBHu9npajcJgxfxR8xDgjr/?=
 =?us-ascii?Q?zNcWEEUVw+hXGOZt87brDi6ZZZwVBnyB057wOtBLDsa6Jqs6ViIubG8RVJUI?=
 =?us-ascii?Q?uE+JTR0+UIDq2w1jups4rqhSo7OOjOfN0LNE//Yy8VJg3gDOUdgXEx17B+vo?=
 =?us-ascii?Q?BGyv2HMeJaNPZcSTfNMvZOdW1uXzxSRAAmE3rdrYODffJMHWPSZiX/gjv8BE?=
 =?us-ascii?Q?nGuSwW3DihcH6NWlGfKetwgEBxMvndZtn4CIvRDOl1kQq3XYZd3zZKqZv2Pl?=
 =?us-ascii?Q?VHrbRcRAzJAh3YbPjLAhPJMUyZsI6zZZqEyoIe+NObjsoiQUfJjiR3aR524n?=
 =?us-ascii?Q?N3P5r+PHzo3uFJcUsWWOU9IcJGDWwQEWoNX/LaieYuWJc3LSf+sar3ukx5dB?=
 =?us-ascii?Q?lCEIYFTaXll8AUMWYjJ4m7bRqDXb0mF+2dvipEXbT8xVidQwXazaxMsvkDRl?=
 =?us-ascii?Q?GSFUDlhA/LUEF6Hz2qUkcIzWbONMXRaW9e3gmWuADYLRKDuwwYvFZijd/mGa?=
 =?us-ascii?Q?Tz4MjYH/b3ddnqwyG+b3p/C2VQYPuCOXwp/YJcoo7z+OqVxIW8ImAaQgi1Ci?=
 =?us-ascii?Q?/fJlQ0dQbbx/Xo+IHt+/BfnUSGa7RR/FTA3gG30fA+HmtI/x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13e6f5d-20b0-462c-48e7-08de918a8dab
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 14:09:00.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hkhPDBdwpPFeXOE0DpPdTKpAIAGgXhkiSnH9EDm8D1ydREZyVgFGPmkieBhY87z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453

On Fri, Apr 03, 2026 at 11:41:25PM +1100, Alexey Kardashevskiy wrote:
> 
> 
> On 30/3/26 22:49, Jason Gunthorpe wrote:
> > On Mon, Mar 30, 2026 at 04:47:44PM +1100, Alexey Kardashevskiy wrote:
> > 
> > > What do I miss? Thanks,
> > 
> > You can't tell where things start so there is no way to relate the
> > offsets to something the kernel can understand.
> 
> Reported ranges have BAR indexes and start addresses (with the
> reported MMIO offset added), and the first reported range starts at
> the first 4K of that BAR.

I was told this is not the case, the first reported range can start
anywhere in the BAR?

Jason
