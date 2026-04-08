Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83B37C0FA
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775692572; cv=fail; b=rjy4wXHTy2IqviA1qhjo98WTkbTbIHJpTF0+OKtqOKWwt1QFQpLcJgUPQ5s+xOy3VijwBOyuShUjQn/Kqs+dN/TOJrAIRztNHmPqf6lSWb9cCR57Y6FzLrfSaApnU2wu/RUdJHq4a5C4itPFLLsDXBWdpy9e/cKNVrMNmic/D8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775692572; c=relaxed/simple;
	bh=2La164JK/cLP+lHNKReB5qsB014pGOYVBnoRuHgeKJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nHOy0oUo9tih3cvQuo8SjhONtQ82xRPwxzcPDIAFFWW8OhlQM4YZpUJv6D+dguv99QurNibzSMMCa6Y6VM9e/6LAGo09ejePk09LZxGHrH2ygoc+ipksGUvBpFRmYek7Husr7+wbW8OUwsE3+blqO4VP3QoEONEQeHcP8BCcADM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RmoxrYgv; arc=fail smtp.client-ip=52.101.53.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RmoxrYgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwJv8zGZu9aBXSFCDOw679jrRQIQwF5k6bzTj/bgmArKMAEsICvdcAGfaWhh/LDqAqk7vDVTi1X+vDdKAq+Gh/vbgzGtnVKbI4oB6QNSFLE+zepsV+X0+gw2KK/TYPg2bldHenfEk02GE7UV5VOBMqMRodG0HPPtGkUIDZWh8XUehwnexroaWdZNF4b4Z5RKGSY8fIU2/9x1fKDd5fRawZdZhT6eAcHXe4Cv1eW09exlQRKe4h+oEH/4PFjA+PBEd5z1oSJ2+LBsbYt8JwPsjH209OKS9gC30QqkfRJV8X4Y4KEBpwjsJ+OW/7q80+vDoTxcpA+USo8u0OWqhyzgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmXhT38NgDOV4aZbGj+lUx7FpMefvkkd42p9Z22+bTo=;
 b=cxFPowqOfkS94aeoe3xYQ1aViSbtFoqtuUrPcBaD6Gz9K924tTuZEX2dyy4BNAFhKWAnK1D7q6dCpHT7v4jAquGbbzZtNIaVAjQIVthq1p76I5vK7q0ptD/zB8O8zGM7TFOG0G7LLryKjSrwDQVBDVl1scMNAZkEj1XYoeZ7LKfX1vHnVUVDXlRXOPR87050UCRppRsg4c4qHB8fJ30sgV82r9vQZg5tHDTVqfemBOm8oEGXxjkN5kesVtXkI9UxQ4UPaQLm6f1I2JUdsb2828r36ZiIxFGjvDwMsG0991PXTK0TR/6kNNcW6QuNvGjyo+t1bfZU5HiHhcAmUMl4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmXhT38NgDOV4aZbGj+lUx7FpMefvkkd42p9Z22+bTo=;
 b=RmoxrYgvV6/9b8ZzGdmjtm3CBqHh4ydwnhZ9HdpazVms9A6XYmM8wrQAaMM7KCcqy4vxP8qFi1M/Cv0PmKrHellOXuC/uhaYJCFGNW6AhZDMd0ncTplnDrs89LVOVUaQmFkRhaxeTOzMiDcAqBxQu4pqtr6vaPuB02ong1GlzWIWdUiA4UbX2z8H0LJ6pljzb4t4fh0n3FJ3WzibPtrtLAWqlOW9ZrIHAh9ZNlpvDWQPFkFFxwTx5z2duBde33h7jIVCptOtB8W4m15Efe8fe5NKb//QdDvLQTawCMCv+bbBF8ghmw6yPGX9VvkxOq6ZDQeU1+lHe3hlJc8GqpqiAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 23:56:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 23:56:05 +0000
Date: Wed, 8 Apr 2026 20:56:02 -0300
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
Message-ID: <20260408235602.GI3357077@nvidia.com>
References: <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
 <20260403140858.GJ310919@nvidia.com>
 <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
 <20260406222109.GQ310919@nvidia.com>
 <7ac346d1-323a-4231-8a2c-bd287e627e1d@amd.com>
 <20260408165452.GF3357077@nvidia.com>
 <3685257e-9dbb-408a-81db-c32ed13cdf77@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3685257e-9dbb-408a-81db-c32ed13cdf77@amd.com>
X-ClientProxiedBy: BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: c1183f5d-e7bf-434e-5454-08de95ca6565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	b/zUZRK1Sb1jZ7O3QilTOEacSLLU3yLQ4xOkZmR+h8zrfkymJsBfpSipxE/WCo99V+VSZp51aUL6vMlgBA5LqXWhISsxoJbCsN8r8W5oO39a+wG5bvStwedvNeEKkZPKtwAw+ro+D/x92S7I318pjnP5KxWNdMnB4P2R7e5NKFJTKGj4MKH9N208x3PowhjlfCGfy1ZZrkUQfyM+CK0kH+EmMswmD7SfD29+ebVjugZLJsNLQQSTwjFsel7UUod0MamClqLvI/wmyUfqWSiWvdfpvM4rEBlHjDhElzdWZbvUPD2VzsyRau/J0w59pHUJwZKDloIhhdX+kIFkaGz+CoqQ/oHashktdYLIGeKzLOAADC9/hlirWTtC+yDT34XsVyROOhNNnBouVdrdA5ybQSCSV6JmvVEYpwVnCGLE9UCgsBNdTg/+J6idt9LuAg91WK8771P04xCv2IMBMB3cHsHrodS2Nc/6Dpim4kLgH0dEuVAL5hrg1bc1Zusv679Y9/GlXUSOPYnhNeQH7Wv9/hRT1O2Hbl1YkIkyShAOH+znBo7jVaaDudBo7k49RySu491k+ketf+bomyd9mSodBtnW7rwvcPGSt7kR5+5vx3mmcuUIvPJ96zAmgNIwY49Ad6sX9V6+IiS28gjcKWcSmBCry7VG0Jnam9PIIybwRtwEkCZEYRPpW1BsWEC+YgZTyaZTOYtj2TiW1BuyTA8W0FgaJPgyvrDKp6XnJfgbMOI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qt0Q07ObSwy0vZhq9TO8AEVT2xCs83QDnIq8L34LfFWnm+naBdD8eIcf+Nbh?=
 =?us-ascii?Q?kQwHz7prUF34Qg647N9ncPzb4JlnkLR514mguxo8HQOK+use4e2uYJ8XCic9?=
 =?us-ascii?Q?adHzkCQkDPAGCaZnyvY9bQlwe/pCfuJU0iGr3IljDkM/Uc1pRUs0GDlV0h4T?=
 =?us-ascii?Q?3orm+idwEWbENAClt5vHsxYaOaRzUOUDYIp/eofSCPslv3i6Hp1ipIGng0Lv?=
 =?us-ascii?Q?JLzziLhjz3f+OQdQALlUTfBAABduMxwIcBc+qGbbWUfB0blP0poegOlVFE3J?=
 =?us-ascii?Q?Jq/qT40o3zEvQz2OdHddHaWneGpO/PowAtnNC+LHwuLLo20ekFjEj5jhGMvg?=
 =?us-ascii?Q?tCChwQw3HiO1r2Ru5JKR+zPlRz1s17iqbnVln6HCccZSZIqyyjA4LYNouvsw?=
 =?us-ascii?Q?TGu0vl30NjLddcuwDbjT0lttX7UglgAK1aDdD5oDirdhGCYQOPRo5av/K0jm?=
 =?us-ascii?Q?PeWzsYRC3YmYP/B8VFWlE9Pm1Z3knB1QyEQvz6gP+qLam2fjno88byGy1rpW?=
 =?us-ascii?Q?sRm6qDfEtGuWeAa3BF7Cl4AkU5wl1fBsXUvhS3Kc/yY5dtKG0C7Bvw2L7EL1?=
 =?us-ascii?Q?TbqQH3KyPJhnxVUeWV96sVhG028Lh0a5YZf+hhgQjlMofs3ZVMSe6oIj6AfF?=
 =?us-ascii?Q?Q/JKTXf/zuy1PVW0N+8s2WM/EQlxbV+fl3aSA6kMmQxOfDRTvvvlUCnW1VPk?=
 =?us-ascii?Q?VIdQZfUqkYoTjBj/wB4ZWzicneOWpm2sN3Y3zDQ01BoYiNdZ8gcGHMR+C+cL?=
 =?us-ascii?Q?lz8A6lNdt8QtQgeJRkVsoCLLQVfBOeYfmcF8HJrJZHDIRYkKBavVHXQZoAHo?=
 =?us-ascii?Q?codEvAuQWBSIeeu4oEYG1zZbBI4Dq2YVHWwhU44Ax9HX4MVfWHuJil6SSobT?=
 =?us-ascii?Q?27bEbsBj9jcbZT8QeHcfjneJ9tKMjxvKQ95tiTEH2QA9xm4HfsxhAiT1mUhk?=
 =?us-ascii?Q?pbX6uX8A20amgWpz9nqS4E0EqyqIq2q9TJlAxEMqjtcovhx4OoGmwxHfTUvO?=
 =?us-ascii?Q?SaT9dseS0RtyAPxIwogenPv0SEUT/MLtnKEw4JpHwEfsxoNSldbbzGt+q0vw?=
 =?us-ascii?Q?YIjJ/rX66JfZMW+Wrj5s4YDDwjlM6uQiTbk5Z4ezmUa8n1UXFgZjaDlVSOiU?=
 =?us-ascii?Q?K9ss7RwvoRG0raYdeedF6fkyTs10KauxCpbUEt7Jd6JnG3UfQ9FGZ/J5lLp1?=
 =?us-ascii?Q?SE5q4jxCDSIJhyJXKt6/klWJRUDRxFd+Go4IO5UxQaJmLOmc0oUaU3dBxy6X?=
 =?us-ascii?Q?+e8j0wvP340mV29RTeQeH//vt+eym8kKFOHXYA3YcPNcfk94gCTy1ophGrdg?=
 =?us-ascii?Q?Tf1FzekYHD2WXPagGnXya8bxweOBEy3rfHcqzxZsSKwL723Aq46475oAEJAF?=
 =?us-ascii?Q?fWi13ghsEQ6CKWl0RJ2nO6GYzj/i7sK62kgaSr3f5WzpgJGDw178q9/4KS5V?=
 =?us-ascii?Q?xslsHoigPufzkLJq+Rb80OuARy31yvSJ0M1hoPIM/GlEBSu3LIEBaFjmKXXY?=
 =?us-ascii?Q?p6kJQoD94IEgIr1zxMebaUB7+brSk92umgJoOBk0uuiKi9K6Fiv2WpUriFt9?=
 =?us-ascii?Q?CYzHEyoR5COzxpJ8itMMTfKvhyJlIEU6FgH+3GlE+/c2cJLiALvxa3OuqsQe?=
 =?us-ascii?Q?+ZWds6mHnTR7je1h1CXt2xMpVhxHCdIgtS61o6OpF4xS/gov/1GxWHfWnQAR?=
 =?us-ascii?Q?DCl6MoqhsdhX+vNEAQn0ItwAFhFelxqBzdCFSQs1v1YMjW4g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1183f5d-e7bf-434e-5454-08de95ca6565
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 23:56:05.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw8R8KXc/Lzq1NgGxbD0KdVeq/tYifUlfTu2M7K+iM8567zFiMa1MTOKarGp/ShF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

On Thu, Apr 09, 2026 at 08:22:57AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 9/4/26 02:54, Jason Gunthorpe wrote:
> > On Wed, Apr 08, 2026 at 05:03:16PM +1000, Alexey Kardashevskiy wrote:
> > > > > This is what I am trying to clarify - if all ranges muI thinkst be reported
> > > > > (as some think this is what the PCIe spec says), then no, not
> > > > > anywhere.
> > > > > 
> > > > > pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
> > > > > 
> > > > > "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
> > > > 
> > > > I think the argument was something like it didn't have to report
> > > > non-secure ranges? But I don't know, it was hashed out in some thread
> > > > for ARM and then I know our folks looked at it and nobody pushed back
> > > > to insist that every single byte of the BAR had to be covered by a
> > > > reported range.
> > > 
> > > That's (my ignorant guess) because of the ARM FW TSM guy which sees the BARs and can easily make sure that MMIO_OFFSET is such that BAR alignment is preserved (and there is a clause in PCIe about how such offset is "permitted" to be calculated) => does not make much difference on ARM but it does in my case :-/
> > > > I wouldn't take the sentance you quoted as confirmation, you need a
> > > > sentance that says every single byte of the BAR is covered by a single
> > > > reported range.
> > > 
> > > Why "by a single range"? Every byte of a BAR needs to be covered
> > > (which is what my quote suggests)
> > 
> > No, your quote doesn't suggest that at all, it just says if a range is
> > present it has to be offset.
> 
> At all? My hw architect says it does.

I don't see how you can possibly read that phrase that way. Go ask
your PCI SIG rep.

> PCIe says "Each MMIO Range of the TDI is reported with the MMIO
> reporting offset added."

"MMIO Range" does not refer to an entire bar, it refers to an entry in
the rage table.

> > In fact the spec specifically says not to report ranges sometimes:
> > 
> >   Bit 0 -  MSI-X Table - if the range maps MSI-X table. This
> >   must be reported **only if locked** by the
> >   LOCK_INTERFACE_REQUEST.
> > 
> > So if the MSI-X table is not locked then what is reported? Seems not
> > covered by a range at all is the consensus answer.
> > 
> > Thus you get this case where the non-reported MSI-X table could be at
> > byte 0, not get a range and then there is no range covering byte 0 of
> > the bar at all.
> 
> This is the only case when dropping a range in the report is allowed
> and even required. 

Which firmly disproves the assertion about the first phrase.

> When this happens, the OS knows MSIX is not
> locked (part of the FW ABI) and the OS knows where MSIX BAR is and
> can easily amend the report.

Typically OS has no idea how big MSIX things actually are, there is no
way to fix things if the hole is at the start of the BAR, and that's a
legal design.

Jason
