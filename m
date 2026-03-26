Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C3934F26F
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553289; cv=fail; b=Fdh5GROXe4C4eJaXSTUqFTziSBFAj+3yKzZfbDf6qzgsCIQx0+zHogpsTSvUAz3t8JEYXQeCKFNMk2l3TOu5Acu5ZkKcmRDVrzuDnrF7c2BCbyJCp9ipe++7ZI0KFa1EJ1tzo+Kjbrkh+K8aSAAcH8t5jSokYAET6N4MI7rvMTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553289; c=relaxed/simple;
	bh=rJZP0wQnlI071J6HcL1cdMwik86/mgU4Jg6tgFcarR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rTdc80uClpW5sAeP6V0+3MYOa4EdY49hKVqXjZ9RSJPdJIE5pxSCbOukGwEcsWp8AHJP7FZgiATuiYgswEJdKXoghOi+zSjAQCD3qkTHJUWVJVHCBFSwyNr576qB65UEFSpRUK3GBWKiC0EQmRPFtA/BER92q3FWCwwplUISPMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQtpY0WB; arc=fail smtp.client-ip=52.101.57.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQtpY0WB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwtelAQf7DH8wxTmDQ6o3CXsk7/5yFtUvkNZ2Na6BFrZPVAdDlEa2YejXODfEBRbN4vUP+WDjmw0VU0z3L3ca1M45bkTca7+PrteNUdNAYUc5NqLYs+0dbuNZL2vhFMg3Z9yYFgfT8dgw0wfs75deeVitULOWCi++7XMLM8EZKv+ocQjZ9FG6ECV+Aj2BT1o/jClXEaiz1AM08lXx/bSCK5C3ZNVe3ADEAejNsKWXl6uheCdH1bpAQS60dfDevJnSX7VcwPBUn9zdt2TcTbnxbZhWn5IJCxJJSzSCVBhjwf13ubX5cEi6mYwHumgHsA28wujBCqGnUXUgrul8zG3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wV8eOr5w4jAzdjiCQwWNrmOFgQYSTvWI0T2e95Iw9U=;
 b=lM8KqWaredDo0AgTCbjhzteaJjnMdbsOaJochf/9F9t15+KazKXcCyVrAtDFdxaruDb6I4wbra2VMmqJ76V0N7/KSXxCv5SUa5KuavPPsFJoPfxznJ2p1GPFqTebN/6MeeLu3EkJJNZ/b5vdM+T8Qy9Vqcktb2aQ9qfd4VZxHkMdfqRt2qwZbUE2SSj+MCEGhNpuvn9XVxFr9eFTFRMafNxTk0Y0zzmsUcWZ6AbVw3TQfbxjUlZmbFIzwDdXoLuKNycYfUSXAaJGV2+TPlHH13v17hQsyXDGFdXXZFE5Hwqa3riWWgETtYXstx4zdsiRgZMIge1FKigz5mV+J6uCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wV8eOr5w4jAzdjiCQwWNrmOFgQYSTvWI0T2e95Iw9U=;
 b=DQtpY0WB+pvRcKrRAJUxSPrtkO/s5Y28PQAZ9yEcSPFfbrTwxoACtERiJ1KyO7/3xAuuQKyuR0s8g/o6sh3ybCkD+gp6Wd1DxljEMPGQc4jlITKHc+dU2j2i63uk1b1yD1sN386H3NtmUK3QLvIrAJSsVbJfIlGgfEX2K+HqJNAJqB5/eTb38HQNXSXvnFz26A1e8BeMDXCnpzJp+HHPZXthc2wfjx1WHaQig7EpwykPfEgk6gLey6znAA5VP68D5eASLD6Sf54Kf5OSH844wvakRk6NwxkHko24OqpKv3E39lifLLc++9e+HGFJek64ha9dsiG/SghbThXGrn1IFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 19:28:02 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 19:28:02 +0000
Date: Thu, 26 Mar 2026 16:28:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260326192800.GJ67624@nvidia.com>
References: <20260313202421.GG1586734@nvidia.com>
 <69b4baab2b950_b2b610013@dwillia2-mobl4.notmuch>
 <20260323181413.GP7340@nvidia.com>
 <69c1f469f2814_51621100bc@dwillia2-mobl4.notmuch>
 <20260324123649.GY7340@nvidia.com>
 <69c360d2107ca_7ee310052@dwillia2-mobl4.notmuch>
 <20260325115607.GB67624@nvidia.com>
 <69c48b682e6fe_7ee310068@dwillia2-mobl4.notmuch>
 <20260326120046.GG67624@nvidia.com>
 <69c57b745af0f_7ee31003@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c57b745af0f_7ee31003@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BN8PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:408:d4::16) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 289cf57f-5400-4609-9896-08de8b6dcbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YovGqPgUoA8d23c4ieOCOzi/6ZwVzM0UdanQaDbJNMaC/WGh/+w5K5KhZSjm/Nu7KKU2Vnig4M9Y2hDOODfMrNopvzJL9riHhmooihaQiO7Dhpka+LLBOeLgvnv9gA51R0VUub7VlmtiU4+wY01GNNPHxZjO78wRhgS2KtpWnk3sa5pdSlxlJawAYd5hdHP1fw7c3mW2o4pWoWaguo6qdrbfsMR+3DeVDnf0tjcO1vODrV7arjsgS9sO3qwldEvBk+k1vFA2DLefwHWaeE7j61lfMuVILmr4vEUwxIccIyVmUjtARfxPS4eAgFK4VNcd1TbNWk8YVKmJeQu6gA/ZpSpyFNQBM8lPwBW9q3kUkqtxWejR/ySHwd++jvFAstbBnBFQ/dYW6bSJloc5g7180/gOxAvhtzO/mffXj6llDYsSKR3qqP5NcpTaTZCDB3WtEIsVNIbxeVN5X1XunfS292QyM72EAUGzNZXCTsBXUSa4RJ58VSY6Y1P3DHxsGYFcQTpYF/TqkVX/B7iTPOt5Hr+rCKrTBanNslImoZnVV+j3FpWC1QvrltV6lMaejdB2gPMzssmWIguTMLJgt369yOkIQPNF4IGjoyVtLRywgCoLpmZTWQMe2bAqpvlWdolPgs2Tv9/V6r/h8dDtU674dYkDnDBolwLOxZif9EYN19i4f/DUUna9g5Zwlh9/2CzEq/zJfuzbm8cqiiYznh8jvOaEVIAI3vhhT1ECx9vHZp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KA8vKoKJoDtvTOJq05EJnmOEG3M+LFXo0dGMDOX5p2XQhqO/ouxa0JnTvlvU?=
 =?us-ascii?Q?RMxjVFrcpNaYps3LWaNjvyzHtXpioRVE3h+JY+mQXEs21xwXabk7ulGadokb?=
 =?us-ascii?Q?30rKXQ4X+c3Dq+SD5+eJnjZx89mYMMQFP+X8+SfE0Uai9JD3AnNb5x07vvN0?=
 =?us-ascii?Q?ahhBk7bMKjOUhVeoEEv10kWkRyTBCqGZWhOmyBUvJDrsR+xaT5FHGc89tQEV?=
 =?us-ascii?Q?+py8YXAOc1HUq6TGSuV6OHb2DyBIsQ/x8dI+4bSHKvmjXOsqWmyjamzn33t5?=
 =?us-ascii?Q?9tiKyB22x2VOp1cR23EvSOExERqwdSzEKK95MfBYrZnjm81pLU1X0UzGwgG2?=
 =?us-ascii?Q?IZ6j7wYx2T/a4kRjTiAizNRxTw1sNtKEKG01O6LZolujK0/a11/yHhfpWxGg?=
 =?us-ascii?Q?C7I1C85oJtwnUqwF5PArbY+KdZosCtZvlXlv82cRaLCXuFLDJ4iivb8SDEAy?=
 =?us-ascii?Q?ppRmItO3IJyefla0xDCYD4pMDTJcgpw73Z9/ajowXJY2JA0076gTxXXP0cFp?=
 =?us-ascii?Q?UnSqCvWa2HfS8JPNLzU37s6oYpbZVTKkTgiBcaap4MEHXmc/rZI/c3G8P4Hr?=
 =?us-ascii?Q?AkmBvkX6URmQ5XnHQRXGo5dlk4VdQOhhs5U0LdwGCCkLWNSiEV6f8mTrmuFQ?=
 =?us-ascii?Q?Vlj56kVoK/vOXLU4NE/hr1BaeUxY/PDpedt+jqTqnS9Zc0hQfTgq/sdMr3P9?=
 =?us-ascii?Q?0njntoKjCvCS0gu8DByCPr8t5tbV9iPRj6UmE6ZWKEv+z5rWIx/finmkKdFn?=
 =?us-ascii?Q?suwoYeWE6i0lpWa6f/Z5ZYzIiNd3Sz4KJ+cfCO8hvmnD7uK6JFQCfIcJ9+S/?=
 =?us-ascii?Q?SuyXyeUPBuEPRhfwOFrSAUSGe+vDfKh3jteAixdqYHh23JgfiwAd91qz1NDo?=
 =?us-ascii?Q?rjofmTtMwOE6GkV5zgI6wEG96L4SzVBAvE9y0cf9fOl1BPJsxpS12TSV60e7?=
 =?us-ascii?Q?pZ1HyVwa203HCBPn/i6CHFH0YIvnvnTXh3Db8YQfKUZY/FPNCRN7fg9tK96V?=
 =?us-ascii?Q?/xK186kPoXH09UVSKMFjnGjBEeatTSarX3wfaql108s3xp9CVRsMOH6gg+s6?=
 =?us-ascii?Q?3wFSEUU6sGEny5hFJjcPavNo7PRdoiZMZ6PUTPRC6bk8ch9ZZoqRzCkGTvgc?=
 =?us-ascii?Q?m15lkmFDBamlUWEYHxOL9UtPSGKD/ea9I4R4uFQqwVJqpOzne81UeprdxE2q?=
 =?us-ascii?Q?ZBggGiXIKPv6l4plGG9PxCdX1dhj/SMK9OkVM5/XuQNrZrF3Tjm65ocGytHN?=
 =?us-ascii?Q?GeYqvdnqLXSOq5KqFvlKJfriifWl59Ps3vE/6aPubjT6DLWNFy4w30qzhMSq?=
 =?us-ascii?Q?ixaYYZXOrA1tUqD+KbuXsvz1De3gKP/lur3aGBbB6gW2TOAQPWwspsCVRoMq?=
 =?us-ascii?Q?/tYP+Fcp6sSkIxmiVVmq6NpbmMSYzQJHmrXbpSrRkAjk93wHqIKbvFVN1ksd?=
 =?us-ascii?Q?NFrIM/6InB+B4O5XMkagP+nUJ2OPDvcpSp2cZAXxmDn3I3LTLSS/8vwwO/F0?=
 =?us-ascii?Q?wKGtGfib+hr+J1BF3NboiMQPYszNpuGpC5wZmykcQ4awFmrIqEyhj6nKyt8O?=
 =?us-ascii?Q?5/DYvDPQOugd3tXOOFfzR3wppTIiC4ij2WX2Y5xoTBWjCTFrUE97D5bAgr8S?=
 =?us-ascii?Q?+Q3YSVlOmiMU1zPWSWAFv7ITdzQIOgC376bagCqfBPvy0KRrF8vUfVXAx6xr?=
 =?us-ascii?Q?3vX1fNUrtckCoyRFcOfCTpcnMHetDE9fgYWAYO1p2JOp2v0z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289cf57f-5400-4609-9896-08de8b6dcbc6
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:28:02.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RVwXtFYEeFPyH7uZ6QAkE5RAbvkhORPncsuSsO2jilZfo7Rq1laObNcsWWvnw+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

On Thu, Mar 26, 2026 at 11:31:16AM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:
> [..]
> > > I assume this would also expect that encrypted MMIO mappings are also
> > > not established while trust is less than "TCB"? That would require some
> > > additional enabling to catch attempts to establish an encrypted mapping
> > > that the hardware is prepared for, but dev->trust is not, all without
> > > needing to modify the driver to worry about this difference. Drivers
> > > would just see ioremap() failure in this case.
> > 
> > Hmm.. I don't know if this matters. Once we decide to use the device
> > the MMIO should be mapped in the correct way, whatever that is.
> > 
> > If we decide to eventually allow a lower trust while T=1 then that
> > should be taken to mean the user wants all the features protecting the
> > communication channel but also all the IOMMU features restricting what
> > memory the device can access.
> 
> The question is whether any part of the kernel would ever track that
> secrets in MMIO writes should not be written to TCB-external devices...
> but that is probably a "trust=0" situation. "trust=1" means "be careful
> what you send to this device whether the transport is protected or not".

Right, the kernel has no idea what is secret or not, it is up to
userspace not to give the device secrets if it doesn't fully trust it.

Jason
