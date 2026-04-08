Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532683D668E
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 16:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667305; cv=fail; b=I0YejH0PAk3PmvDS6cot7HpXT3X8l9izmZTCrX90UT6Y6fx0Uu4CzgllKy7l2XnqjeYDiC9b/xv14fqeQlw/xUW0SN+P5QvqrQWQfxX24YoOBoCWJ3L18mURdYabk7HaymzzBby9Ez79RmbhGLiP9DqSwBXwBLQ7T7F3WYXgY7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667305; c=relaxed/simple;
	bh=aJd4BmfmFuY8b6Z5d4Sul74/6umRC+IyrqhTEh2zCXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rzqek6qydVJ7GMb/SbO6DMKlDMLh8WyWmlLAmHg4QXzuu3MLLHQoabIFYVuEn4oXat/RQSmvSFl43TtSCXMxxj9nE/m4KSfvejlaLPTgNRUYwRAV2mWwmS5ny1CzdMEnhdM22Wq07Wv803U4hf00tAkoDA239yi2qSiWie5ekOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mFWk9eLq; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mFWk9eLq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPx+B8DjAur33mVqWA7xw8WuZ7Udxw0wjqQLHksHL4JqhmNkN9tt2NTehJkHp26ExfBBSBdHtJmL7XBEqtBvrf76R1yVtPzhtBQnkDIzgypgouPt0PusiVRgy2JUxHVOUGyaoJUi2swVWqeEmb7ch5o389iKou+ahyRtLGHv5hCQWdhZvytAfTXhDh2rTDo7SprHIewL0gyK0DSAWv9SH2Jsc8mzwxSHmO19TeS6/u8nJe7W/nqnhYWn6lcTLv7djX4VeH1tx5iqQHb/OmMqG3pGucCi1V/k/0a3pfOX1lBURPhGceUV8K/MTKk88ZkkijERfSExkJwmco0cOElH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMtQXE04C7z/MLk9dIb6xbVo+Kl5zI79Zfoo6pvJzcQ=;
 b=Xm3JsYG7Ppg61TjWDzQ5+veR1AT2JMJuMvPFYqv1LjOuAhG7XtID3Rz7O/MTdY1ZY97cC7IXPEbwPpJO0I9eNmPq3HsvHXXrbmXDbw9wAnccwKwvdNIDc+yxLLiI1XtJS0TVwvxsavqpXfK+KBByjcTjsz5ubb5t6Tym5IB7AcRriCqNIFpVP2FDCUTipBy3YL3wfmrazw0UELxRVDy4Ka/vr14qYRyg0MmG/9dmzkMay58g7wBmpyuRr1hdEWWv0KtdpMvVdKs9I9OMxlZkASGXXmWCWxLylCU3eo5la2NBzFOtf5DEKSusq2uc5Q9Sjso4fU8uBrsnExiqXCmXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMtQXE04C7z/MLk9dIb6xbVo+Kl5zI79Zfoo6pvJzcQ=;
 b=mFWk9eLqFj5A+9EIMpS4QgAgi3UKvWYYn6qjnWxe6dvndTqe+unOnx5sU8MMsJBD7mtFDKEAuy8fDj3oqDKYuR1+nDAJCWsU9N/Jiv+tZLqLpiRGJ/Xe16UfQYu7M8b9cn5ajTTnxv/sjHpnwhUAoULRPmfEYsEcg2NDpR8BDJUmHlX5d8yG84zgReBAi4P/NBSXWMXsegzsx77Z+5trYod4aCJ43zoLtuQolXCbH4Z5dzjbnIF/Xztn+OiwckstmZeJJPGJ6GsZUPOTCUovMsc9yUTejcxlR3bAkZ2e1OwBqZQc6/3ZXREbhEvLYKstcZq0lx+R3rcjP/OHYXm/IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.34; Wed, 8 Apr
 2026 16:54:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Wed, 8 Apr 2026
 16:54:54 +0000
Date: Wed, 8 Apr 2026 13:54:52 -0300
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
Message-ID: <20260408165452.GF3357077@nvidia.com>
References: <20260323182014.GR7340@nvidia.com>
 <fa1c6e1e-068c-46d7-a623-58c225bb03f4@amd.com>
 <20260327114921.GL67624@nvidia.com>
 <d5059386-1ed1-4110-8283-16e3a8407760@amd.com>
 <20260330114902.GA310919@nvidia.com>
 <46de1d41-a660-460c-a49f-ae2d2ad7afe1@amd.com>
 <20260403140858.GJ310919@nvidia.com>
 <70912675-0737-4ebf-8ba0-ab9a2e493bbe@amd.com>
 <20260406222109.GQ310919@nvidia.com>
 <7ac346d1-323a-4231-8a2c-bd287e627e1d@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac346d1-323a-4231-8a2c-bd287e627e1d@amd.com>
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 132e5ecd-d845-42e1-7c69-08de958f8e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	w4j+kHBXnTy3N/Ts86F5/EghxfekshYfvMdAlO6rO+nHA14ZXJrdrAGQWTLXEsTYlFvJlzzNz7nO6RBmijYxH/IdbUFcx8T5jAZIT8nz5axJeMDjAXj5VGfqb3Rty5vD2peeVkNM9L6QNEP2TFcfg53Pq1+iStiAuGp6KtHsv3+GuZ6/MVMOWVNK/U8/qAF91WISrEYWhCt6SY4U1s5EGe6omeude9VdGEKGVZnYeQnn6Wt1dU+1WvrMbIOKXbdExN0fItMvYwbjhvS/VzvbplqJTW2qSybRvk6nt8qSgwSFuhkrRQZbF/96fLawsEqjY2rCPGkmIZ0xuTWzpdYTaL58Yq5/S7awyiLEz3eqwHAcaAFKQz+7MWSp+rNPn7pfgGcHuieKkAvUnqJq93kebAi/UMpDcq6KQJiLpBRbbExyK7NABTzRRm/1JpBMvt3p9X6tC2mZdkYEUpZDwH1plrn1qtPf8wwzK0ASHPJsSRrPjfUz25Ct3xCSvIaVLWdVyDB9s9q+ibYmtxNWn1ayRHw4pLqgM68sGZTpALwBjQ4SOD4Iksjb/R3B2iHRjFyzHC8Vqrnw+tGwHQ+6d26dsX6bsx5nUcwTmowRMdLRBgFRGgalIK2MDihO1LaqZlUWmNyHyKmmKLEAfd6kgc65IoaTIKtYzuoo8UW20F8iCHeHBFZWeg8D2JlZUQnR7FzUSBFJuwvYWaaD9uT7Trx+udyBnRQDvtekq/tmC5PF0iM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lqrqDy9EzTZXxYD2RIGsUKFpbVmU6/W+DTQiVj8pYnf0nAnzsiJt5Hu4RwvH?=
 =?us-ascii?Q?3sWvjvcuvch6qVc0m9v6K84TFX4ixUgMaHbPr4GXf/kLNcI1AH+bZL624OxO?=
 =?us-ascii?Q?kYWcTHqz5LgsoRTZEKcagoHfRbsZx5hQqK+YSFd3/GGgiYphiY71tCFjnJ8w?=
 =?us-ascii?Q?e3V/gbPGGB+vt04eI2CFkdozf9jonO8uU8CYGkWaYC6wyHR+maAkddU4CrmA?=
 =?us-ascii?Q?YwUN/nJrWpL4nY+bfXOj1iEeP2N/kEx6Ft2xbJpYvhuc3tOyO6rRZ5DI193N?=
 =?us-ascii?Q?0YfFkCfOn7ttImJawiNm6nc8AKBOdOJKLbGZl/PHnE58Dq/7pPYS9WH/FbvV?=
 =?us-ascii?Q?i6z//1NSU48JuSTL8LYpNAjV4fTAd7y5YylTht8IHTftLr0OV3BXZn9D/ZRV?=
 =?us-ascii?Q?AMEtCzMoGOv4PRXx0b89280/R1+SYktqrc50YifncqY/ult07Nb37lqf9fG0?=
 =?us-ascii?Q?O/VyAVf+uUS/bzh2HND+hFjqz9KF2gSGYd+FIMD0zepF1sEldJAXGqHbaRD7?=
 =?us-ascii?Q?cTXNV2QegWsYmHN5Gj9ISl/X2QUI9gsJ07oZYEJRWKxCN7VKJ7A/QjU8WyI5?=
 =?us-ascii?Q?M5GB70+VVNACRaQG0NdVZm3pRrNqTTV73qTCDPR3Wnrm+u9fEkWmXS8svKVw?=
 =?us-ascii?Q?5RdGqpyKdqOk/NVcPsYxqH44XphQaSaMbM17vo+GJZ+gbLM7gi994UBFvcz8?=
 =?us-ascii?Q?ouaymjcFxyJx60KiEtaNh8Od6QEGw5kIumzcfpaE2hVY3klALK5vR8WDhkeO?=
 =?us-ascii?Q?Rquo89/KUX9qB+kCRP34aZkSv+caMceHwt0QJUY/Ta0/6E2SutviqG3k/ro1?=
 =?us-ascii?Q?ZW9m873bma3adTfp9HF5zAphYApNXDkEMYEW8ABNgatHtz6Qs5BQqsIR15ZF?=
 =?us-ascii?Q?2hE7KISSlOs3S6sPmbfyyTzeqUH4i3oKOa/5N2cpLI27ew1jlaaa1dlHsb/o?=
 =?us-ascii?Q?1GlAXf6E1U1rndSkUFn64+YHsE5ln0C3FdRBnDBYl7M6k8S6wQ6jzOOrQVqw?=
 =?us-ascii?Q?Yc8W3qAfTkjGeU+6gQEbt/70kKhiRz2xbxEvyIRnNCpUJm1I3sit6auAGlfx?=
 =?us-ascii?Q?nl+XHH0i6Pr7dS2c4k6sEiIIkgJNXU+Frh4Q/zcStkSuI1cpwVFkhKzXoLl5?=
 =?us-ascii?Q?jtA+/5ohP/m/ihUoCfTEH8Xq8ySQecdjWHB5kXTVmCq6eFaOI7QtNBNShvmn?=
 =?us-ascii?Q?5rDdXnVG3KHUb2VV2c1CP/HnT4CvRoVG4qstG9AA9x5pquUP0gQ3Xu69p3Hk?=
 =?us-ascii?Q?NdDQeNuPdFNHogS3CK80rwrwbU9rc0zkPAGdqwQs4MR+xMFZtjjnGgKUotS3?=
 =?us-ascii?Q?Ul35UlhT4yCJGWgHhyIl9JYIAtfxBu0RF1BrJ/AddQAaj06gHLaqjqRAVFUS?=
 =?us-ascii?Q?0gXYGRXZvOt1wCTP3onV2Xo1uuPNDT451iSZFLBoz1Xm17nJorT5mlPEM4S8?=
 =?us-ascii?Q?CkkK5FZY1CfGd7/++6AOx37PWC3G4cxcOeawKU/vLG/c4yEYdDXjYjTARi4g?=
 =?us-ascii?Q?9EItnLLWWGQyGpX/Nx9KZB6i9oFOLhr02yWQLxBt85ROSLaSGh6oy9gTNJLN?=
 =?us-ascii?Q?AdDIi36yH9vF6AZhx+gar0H+wYYyLdj9tMZIPug43YJX2NiWyZ38VGLe/10Q?=
 =?us-ascii?Q?JFBvr1H0ocFSOGwIneJwZsP9YnCEkGtDJM6XIDjFywAX8UzBZQSO7wevBD3l?=
 =?us-ascii?Q?RZcO9zOSH+6zkaV9faI1nlkLjJ3cCj3IA0qYC0+tdzEAklzl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132e5ecd-d845-42e1-7c69-08de958f8e80
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:54:53.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz3rEKyG3F+y/9xcFun6fKddVDBnEFvTnbI5d7SzTrIcYWU0Vxtv90uOuXVqsS+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358

On Wed, Apr 08, 2026 at 05:03:16PM +1000, Alexey Kardashevskiy wrote:
> > > This is what I am trying to clarify - if all ranges muI thinkst be reported
> > > (as some think this is what the PCIe spec says), then no, not
> > > anywhere.
> > > 
> > > pcie r7, Table 11-16 TDI Report Structure, MMIO_RANGE:
> > > 
> > > "Each MMIO Range of the TDI is reported with the MMIO reporting offset added."
> > 
> > I think the argument was something like it didn't have to report
> > non-secure ranges? But I don't know, it was hashed out in some thread
> > for ARM and then I know our folks looked at it and nobody pushed back
> > to insist that every single byte of the BAR had to be covered by a
> > reported range.
> 
> That's (my ignorant guess) because of the ARM FW TSM guy which sees the BARs and can easily make sure that MMIO_OFFSET is such that BAR alignment is preserved (and there is a clause in PCIe about how such offset is "permitted" to be calculated) => does not make much difference on ARM but it does in my case :-/
> > I wouldn't take the sentance you quoted as confirmation, you need a
> > sentance that says every single byte of the BAR is covered by a single
> > reported range.
> 
> Why "by a single range"? Every byte of a BAR needs to be covered
> (which is what my quote suggests)

No, your quote doesn't suggest that at all, it just says if a range is
present it has to be offset.

In fact the spec specifically says not to report ranges sometimes:

 Bit 0 -  MSI-X Table - if the range maps MSI-X table. This
 must be reported **only if locked** by the
 LOCK_INTERFACE_REQUEST.

So if the MSI-X table is not locked then what is reported? Seems not
covered by a range at all is the consensus answer.

Thus you get this case where the non-reported MSI-X table could be at
byte 0, not get a range and then there is no range covering byte 0 of
the bar at all.

> and the spec allows multiple ranges but also requires strict
> ascending order of the ranges, 3 paragraphs of text about
> it. Thanks,

single range per byte means there are not overlapping ranges.

This was the old thread with my suggestion.

https://lore.kernel.org/all/20250911134107.GG882933@ziepe.ca/

If this is important to AMD they need to get an ECN with PCI-SIG to
clarify. I think as of right now Linux can't assume the ranges start
at bar physical offset 0.

Jason
