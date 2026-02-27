Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9002FFDDE;
	Fri, 27 Feb 2026 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176089; cv=fail; b=Gxfe3YbUgSUOTFr8zGoycI1aaukAphmBSwa1OS0tRUtaZ9D2lmx+wNAyLwTZMR8NG/76pcDSLAKfKiBRNdV2qgdecY9OihfnT1jolz0uuCluyM80AM81z33tBxAoB2z0ApmIUjvkGVq5strHXet+5xU5K1k9Zm3L2NI3Hgx1Uqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176089; c=relaxed/simple;
	bh=FeczEEQFhzKaK+I/L0dgnGhDdkcrtRJyJowjADZgiQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tVcT/tTYRAnTBf4of2szpx+gtc2yGcl+s3+j2DtujTTIItxxQsKOaAOgeQryIYr7KriHRQ85FeB4nTYPFogoIhxbt75iKsaPfoM7HVvp62Kx7t1Rf1/cXsvTVo5LAd42fTaL6HdwgbJ5oaIqzeLa6SfTC5b+8IMmD16BOnBCtyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BXW3Ulv+; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BXW3Ulv+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzYGEDrKlMvcQb8i5XCqomcf6XNvUP13shWOx8YOyLRPe/G6ZDNNZXP46ttp8sDMsSWh+fTASCj7aFntrsPEwP+ksC/J2Sup65uX1wmtf6VKM1TnnyYwTF6I8xHAbdFcxzat5YN5j2lvQtYZX/DKRWOJUixigs9ZQLgiKtY+nzN2rW8x//Pt36zzXXGFuI1paozS+nLxvLTXg9ddLFZf4Qq8PF5t2Fbo4EHBsrjjNDWJWZEVDYWrRPMwl8tVk9ULMaSHDxGSKQKTW3hdeFGhkAvmuuSZTzZ4nc73C+lsI5rllpxHz47fSerULaOIVwfrnL/+ZrPRdMuGhOSyhsqqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F58MbTbIu9arlg9pxQeNzCwfw/l2DCYOREY4wZgJh4A=;
 b=LFwG8ePE6hSQGA0APdibUr4cqYnG8hs03kRf6lXr/WzjFgsdfEjes4hbjQBAkEPdbDiNDqgj0hMRraYXnA+A4a71OLpBVHDGd4txLQMOjCR+HT1stvDpB26NJZk/gN1Exz9QrXtv22n9YYw9ITWi3f3BvoXVt3voJrrmAHhQrH1Glb48Qa0X0NCTbsL/htxv4bYZb8sFSX47oHHGH9NdPkdiRbmP8qK3PO3LcsqwF0TbkiMc3cfuFTiEJ+s1aBneUTgLo0OlM1DXLMbm/TYMUJo89w5Ps9BdkO48oqtuA2WOenX6+mVBKpS+01VFy0JT9qOtL0Bspj/H257pCnajew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F58MbTbIu9arlg9pxQeNzCwfw/l2DCYOREY4wZgJh4A=;
 b=BXW3Ulv+afY4epKVPtLG8rfztFaRUHOj11cNh3wjMLgx4fUoljL/FerT3OesXKM99pKG0Y6keXF7vCQOaofnyxItzf/Z+2U8aYQnpYxv1PM9OyHS0zSRI3Hp45g60u+y7sCOO8Ies1oYeyUsehUmLxHtV4nCGemv81gNYqbj7B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 07:08:06 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::da5c:267d:db9f:8ab3]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::da5c:267d:db9f:8ab3%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 07:08:06 +0000
Date: Fri, 27 Feb 2026 01:08:02 -0600
From: Wei Huang <wei.huang2@amd.com>
To: George Abraham P <george.abraham.p@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	giovanni.cabiddu@intel.com, Jing Liu <jing2.liu@intel.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 RESEND] PCI/TPH: Skip Root Port completer check for
 RC_END devices
Message-ID: <aaFC0pJDq5JW_ZAy@weiserver>
References: <20260109052923.1170070-1-george.abraham.p@intel.com>
 <564e872c-ecc0-479c-86c3-68b5d3fda512@intel.com>
 <20260218084254.GA10368@unreal>
 <561a71f3-dca9-49d7-a9cb-13c916340ad3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561a71f3-dca9-49d7-a9cb-13c916340ad3@intel.com>
X-ClientProxiedBy: CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::10) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 764031d2-c9d6-43eb-040f-08de75cef440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	RsUy2oI74GSUlCSZst8Cf2ccWLSAfQZCj7zUszwdZcHjiI8IJXz+E+/kB3PhrqCWpoN9Kub9gYfujQGKzXVoFhWLz6uvB6UoP4j0mxgrOzd+d4HxhPu8UR//YmE27vtCVEpHMnrNqePeJBHqtSXk5MhFfv3gnSq3XAD8LntmCMaSKShoG72864+7PCiQfdLPY1Bcb9vRsPslyUxDZ41NiRvfJC3KcAb24DrJvl868kHMN0OcszPY2kk9i/L5n2YxEQXfWnUZIiy6Lp42UG0vvXQZyKYCfawNTBxwsjKHLDUzfeIRz1mIaaCW9sEES+4t7xgQpLBr6avr/78PCgWnuCLdrd45REwD10ONpgSWY6zqhbBCXTjriLZDlBoQmzgBsaWgbb8ymeEpPDBMDvHfBWH5OTAXKKJBBQcyeoxPb6qTTXR79xW0F0OzvtcFw4kSTf2V7hT+PyKDWNH+YnNHKh4miEGxnFxGhKwHINuPVrDWYBJxfxFLj2ByR9IDq9c9ZFaJMkfG6Fjr2XSwMXT5bw1DujQoe9FZ5zotGFsmje98cOucUgrmK7WMM4xokX1hiAV1QzEqZ2B7S9z6heDnofVDk2kNiVPUzqEOPaZxuJW7PrzMGCYIFyugTBmoby69lLo84+6LeHTjy727ZYKOqEMF9LCCRpl+t25jJQCKnQq0WBoxwH0cdorsSeBIRs/RDqkR7tusEyDnbGEDeFa9zs5CxUlvzXxY+uPhuwWsWmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LY3Aniq+krUUXxjWGbpNi0Mn2c2uYrKWZXitFlh7o6CRZX0zwzX7L7P4BRSG?=
 =?us-ascii?Q?yxRFATUgmDCPE+njatWD6NSjbSOkExmmb0u5N84BFBYI5z3Vctspde2G1JJN?=
 =?us-ascii?Q?ASRCdr8M1LXZuJZVSzF0MW99mX2yl/IqmhSpF1RJGSBhThNwbW5gvBNRG/is?=
 =?us-ascii?Q?O1pdF7tv4P+oxtRVT0TSo3KwVk1kiHKpVxBU10q/WF8Y64+H58IH2uQRsoYM?=
 =?us-ascii?Q?h5bnrGYRlGPq3fR51/LulfOSIEMXpirWZNOXXkGtSP24vD+zytSWyEc8CXR8?=
 =?us-ascii?Q?q1q6c9bS3oIV/dTuOfx16wzHk5XB2eGODi/qlalHLrJwGoFD43icD/8V27bu?=
 =?us-ascii?Q?yP+f2L+vWfX/XugXIP0SfLcXOD5JG7jGtyI5VWjPQ+hVcI5/v9vln9TnnITl?=
 =?us-ascii?Q?+BKvFeJHzUDy/zE2E+ZNOPHTRL/iUdtJRRMaFt5wqT8X8WiO1W9OUnOZ+TZ1?=
 =?us-ascii?Q?6py/3beW3DTa/nbgWW7wmwj4NTMsOOwcER9oKEyro9jKUmBObj7Ju9ckNNZN?=
 =?us-ascii?Q?1DS/OvQCqHEMpglf1vhs6EiNG8Wy0bExUcxIDK6FDx3M21Zvdr9e7RzEg6Xf?=
 =?us-ascii?Q?iL++szNNPmc34g1AQ0Iv1TVz4DtJ9+6uR1JufOylB0LbF6IqAYn1khVr+W73?=
 =?us-ascii?Q?ncZ3n+bTNT/XLTF/tHVyrFArIdcHYC/Zmw/9LFdG4SamK9+DZ1+zUaJf44Uz?=
 =?us-ascii?Q?7JWiGxMQUPt2Tnu9ZDT2856quxeGFEdhrxwRggORghXZP/VMzfhAAreqi4oe?=
 =?us-ascii?Q?NVcfawrHy7yp3Kp1z3VFY1apHCAIlQI3ySCOfh9s46GYokNORV4Iq2PvMVQW?=
 =?us-ascii?Q?xgpWMrKX3Cf4n0Cn5FMml37WFlQm6nC9nI8ljpQaxCnuFi6bWFd69iRT098w?=
 =?us-ascii?Q?dgSpjH0afKoNE7qLQAdcPtV3C+fbx24SrGcnE3BU2GftZIbGxB/pCKZbtKVD?=
 =?us-ascii?Q?8U1WFwJktIuptp9X8IrpSEtnjX1pxns7X388In9y+z6V5CQVZ1PXLM4/9rC7?=
 =?us-ascii?Q?V0FdrL5sWnE6hcvPnYZNbi9w1UlTkCwxwSCVHdyOYPIlP9VS1UlTQmOzmela?=
 =?us-ascii?Q?a9XEpSCpjdoKJDz/xhtL6RW1AeKLpozHIShMyeN4NIquo5MAbQ52bZ1aHRJy?=
 =?us-ascii?Q?4YO7lppQRL2xTgZ92OqVmbr2NxxzTHMIRTZfQMjGZ237o+hhzK6gtvRtj6qw?=
 =?us-ascii?Q?rdYI/o06orPdWyq6hfGrwKLlWY5m9sdUueRD+15VO5KNxRZ/bXv6geg4N9sz?=
 =?us-ascii?Q?w8udy6caLfr8+xwyCOr2xzZN2ULxzX/fvzS/eZqR5R4psa5s1f086jTBNUN+?=
 =?us-ascii?Q?Oexbq0d9/FmWaqF1hmTbAVKjDRwLvrBNth0DGvnab0KFKhKaCBImCxMKHqXL?=
 =?us-ascii?Q?/Z5PzKeCTI+mdwOi114f1+bNdyqqlPXyPiYXrvrOP+CfFnT9BdBOiM4S/Mm1?=
 =?us-ascii?Q?Hg4v+jArl+Aw187PmkzTtm/ThpdFWGoFo0xt4rwZ40wHRI3fY4TzW+QXaVRa?=
 =?us-ascii?Q?TMheUDBxnr7vBO9raR/MtL85hQBrjFpSLiJ10lhWduKT5WIBmLrYTnzS2UuU?=
 =?us-ascii?Q?FtrsCGXLdHwggA1Z7h3z+Ygrh1H/Rq/OqWupMzYaq++eg+SfNcE7U9n7rlqM?=
 =?us-ascii?Q?+iP7bw5zrkbdlQEdiWGQd8N8IorFWCFVS4R6VaBcwu2oIGvZbr8osN7QgELN?=
 =?us-ascii?Q?LLHDyLMNqb/uuXuWjeAw2TTCpMcB/vtLiZRWUy7iZ4arvT+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764031d2-c9d6-43eb-040f-08de75cef440
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:08:06.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8NPtgNR5iAdKSDA03CDgy0mq8icUURX2KZuVWH4Kyh+h5IJdDgDqe9bNdilxkYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745

On Wed, Feb 18, 2026 at 09:00:59PM +0530, George Abraham P wrote:
> Hi Leon,
> 
> On 18-Feb-26 2:12 PM, Leon Romanovsky wrote:
> > On Wed, Feb 18, 2026 at 10:24:28AM +0530, George Abraham P wrote:
> >> [+cc TPH authors that were missed in the previous mail]
> >>
> >> On 09-Jan-26 10:59 AM, George Abraham P wrote:
> >>> Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
> >>> directly integrated into the root complex and do not have an
> >>> associated Root Port in the traditional PCIe hierarchy. The current
> >>> TPH implementation incorrectly attempts to find and check a Root Port's
> >>> TPH completer capability for these devices.
> >>>
> >>> Add a check to skip Root Port completer type verification for RC_END
> >>> devices, allowing them to use their full TPH requester capability
> >>> without being limited by a non-existent Root Port's completer support.
> >>>
> >>> For RC_END devices, the root complex itself acts as the TPH completer,
> >>> and this relationship is handled differently than the standard
> >>> endpoint-to-Root-Port model.
> >>>
> >>> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> >>> Signed-off-by: George Abraham P <george.abraham.p@intel.com>
> >>> ---
> >>> v1->v2:
> >>>   - Added "Fixes:" tag to link the commit hash that introduced the code
> > 
> > I do not have a strong preference; I am fine with adding a Fixes tag or
> > leaving it out. Up to commit 2961f841b025, pcie_enable_tph() is called
> > in two drivers: bnxt and mlx5. Which of these devices is the RC_END
> > device?
> > 
> > Thanks
> 
> qat_6xxx supports TPH and is a RC_END device. The patches to enable TPH on qat_6xxx is yet to be reviewed. However, it requires this fix for the same to work.
> 

The patche looks fine to me - it shouldn't affect regular PCI Express Endpoint (type 0000b) devices.

> Thanks,
> George
