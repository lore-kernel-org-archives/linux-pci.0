Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356124A2061;
	Thu,  3 Sep 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456899; cv=fail; b=fVgRaCkA9ndXGu1pQXZFOPpa7/Pu8z2cQvXwwAi9peKnyd/7j+sjPedq2OHy6H5F9xdI8jnOFkBoqTjjSVKp98KYI7R2WQpsfP5KHJA/9v6otu+AVP69/Ykkw8CEh2gg9YbnhRq27ScIkXjJVFKURyGtLof2ZfJhXa2LdFKtWq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456899; c=relaxed/simple;
	bh=l9RNtYw55jyY8+XkQ1bWyC9QwWELrziS65YXaZdPHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XnTTRq1EUscBYDoUnh382Ltj1kHeLjsQQ8f/i1WM2hlDlxT1FuBIOsdcOhMsbovY96cWCcf7vn3zgDXIgEQfZfJfVV2eUg4eqnJHrLnK1z/Y6KeLubrCPZyMQJkGHRLgHpnnNQLc80NilPHVHB6EjV7Xve0AoTCr3LVYlWVLHV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hr7OfiGu; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hr7OfiGu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pd77au9FOF4iCXhnf0/1j+sJDvbXT90HofzOqCFJZCVWeg5Bh/Rj2vxcuE3Enk9PaEm90K1BsYpdja+6R2aTZSzkoyuXwg4D4OTyOXPmTOId/93u9zGz0ZuM4bKwKaft9gMx1MiKahrjpEADsq/sIk8LK/BLwo4+lG0G+/fMOsC414ysV6O54bnwh0c16XBpe3fPQ3UHDTzM6MPg8Qv/HwIO+eMQXgzj62xzaHRpx7kfkZ9WvxSOuvqVntWIFBDOeL0EwhMvkna17HcHFyl7gx4XDxpLIT/h5zBM+D9SlcI2NEkxJGLzr9hcS3B/uQi/gwxcu5EpHgwHMrm99jjBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYNPJziOoDi32Woktb6IGqq6G9r65dWSds0aXQ+dWa8=;
 b=ytxa5YoPmkLKsRoEabtkBsXBExPpX2fF7z56L8ti9U20rGV3RjQCaiKu2rD8qKYZa6O3Rc1zESv4aqqxzq9kPoALROkdZP5TAgeD0HC6+4buHBRdP7ozrdmwAYyOzqKU8AjEiNhiXvVlsIcPIEZS4bQhCjLpxWB44bNPIMXaLpcjKhjvSLmcKGc+pfUhHp6/sspEpYVMvYSTwtDfkxieM1pboPzfP7vO2/RPrhZMr52aXNJ25dKzm6XiuyYO1DknxodFGDl+5rwnAAlCI/3FqhhbrxN4peIhxmBZ7a2cR/Mq54tc1YPYTaObtC9sKXmyoIW1HkwOIpeEHPgXY2An7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYNPJziOoDi32Woktb6IGqq6G9r65dWSds0aXQ+dWa8=;
 b=hr7OfiGuApHr3y+UQHshS0RZwaV1K2+ewPG9u148n5KIPTnXAyDIaShkYVAq0P9HMhyQ68iLXhWsjwN+4ViEjs2yf5BkCozz74K7sw1NE4SkOH5F93iWMTdQz/UGZQ9F6uQM6cduvN4SOkK/eIHl5ujHxoXlgGFB9nvC1AnRqLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 17:34:54 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 17:34:53 +0000
Date: Thu, 3 Sep 2026 13:34:44 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Lin Wang <wanglin@open-hieco.net>
Cc: Borislav Petkov <bp@alien8.de>, mario.limonciello@amd.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>, bhelgaas@google.com,
	x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] x86/amd_node: Skip SMN setup on Hygon Fam18h
 models 0x04-0x08
Message-ID: <20260903173444.GA27025@yaz-khff2.amd.com>
References: <20260901071700.3255382-1-wanglin@open-hieco.net>
 <20260901071700.3255382-5-wanglin@open-hieco.net>
 <20260902024833.GJapeOgRJ50RAZvI3e@fat_crate.local>
 <5c6ebbf5-3b3c-47e7-800d-adb4049cd636@open-hieco.net>
 <20260902151340.GAapg9JDQMt2WTkjLM@fat_crate.local>
 <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20724518-2bf0-40ac-a5a9-1b2fe9df2b0c@open-hieco.net>
X-ClientProxiedBy: BN1PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:408:e2::21) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: e71f37ba-ff9f-4e6f-d120-08df09e1aa0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BZ2aq74EC6sf5cFuEi95gcCtkMbZlvpX9RScatD8hKAO3cXlWV9R17eP3TUGgXEA3XF5B51Gk2jLbW24EbhEbYUkHhV/T2bnf/B99PGOp/2SOGqqY3hvRs2AgpBwEd/1uSHCswfoangA1SjDChQEyu2M9uh59Vye+ZpLSOmnJvb/5ni+BdLUDW0HJbvFSPcPiTIBNY79akVM5p06zp2wNdMvPEwKN4xsxb3kOkFVHvka6goJjUD7b8bvLz9LqfH+yqtsVMlufbr8BdxouSOXfNZBCX8oNBfjEWywaqnl5rQZFhz8IWNtrdqznr8JvMOK6EBl42HPW+T71zjR7zdj8RVbez3Gpx3e2uHRsXy5Eny4fgUXgNNGCO94JQcJMRWsryTpVvsU9rRmIv4u+yZtqyJtlNFUTonECPzSjSSVrn3ExJy+N/fHQ+aHxbvSZl3mkCKYvSekhEsAQjPfXsMaINOiHBUPXoDHXjOLDRVUQdf2SMybuAyY7p2kJ5yvOLOS/LH36GmpR+UfQ2y0rJhq4j+5WMdJUNAm7SDGo081b1w5S8vMuC/ULjzeyVyeQRSDHAr3DIjhOZ55KR4qQ3RP+pxAUT4Q31H4wnp5hRUxC4Jr+dWgoRaJhHjI+36qpn7cFCVStstg6lfna70Pm3gROsnPnhC6udu0h+Dj+Rv5OhM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9gzwhBAKs97UDGLS8nbKjXjj+X6Sa4oPXQLSjcFoPDj7VlFtUr0ieeyHpqLB?=
 =?us-ascii?Q?cwyH7OBeYukcVzBFM4wEZoedfjxeb+OD2wVH1v0r0sVtn1wv2aVzZKWEuIuJ?=
 =?us-ascii?Q?aFASr9E44126BzS+424uerwOU03AGTAc9+nUaQZaqC3os3NFyci4dwlFNKCg?=
 =?us-ascii?Q?6TVC3xMXbEbbDfQ/5NfDdA/KSTjawFsXoseXG+a3PrJd/tsxPVKNRSX6RvAb?=
 =?us-ascii?Q?uGTmw8RTQ7RVfQWEi7RI2KyPEu1VGLFDonxO/A2AmVBC6yEHt6LaXsE6HO/c?=
 =?us-ascii?Q?4tX+9YLyoidKThIwxitJpVyVYNESXL1M/scQoeaW4s17+7bXVYhOSigJ0rcu?=
 =?us-ascii?Q?26tYv5Z2PPCUWAu9cZ2Hag7xBgGR21WGuiJDUwY9Botxt4SU4NMVp/OkHFlN?=
 =?us-ascii?Q?8tz6dWsnkU90VG39c7xVugHTdRexwl1XoSopIhzv/dS4A72hI9uHVuFglfpu?=
 =?us-ascii?Q?z7EkihZL2Pegh1Q1cd2u+G+CIlZN+sQPd1lU1PMFfpiEg8oEqOPXUiFhS6Lv?=
 =?us-ascii?Q?98E5/rf00mF18SpSKE1RT8+JlxiWNOIZcCRO1UqkIbqEgy8CghbGadKmtX+L?=
 =?us-ascii?Q?fqxJ4P3vZ23TIQ6xoZjleSrt/WPSC40ffhy0Scq72C1jX7X6V3UnFJBhjCm5?=
 =?us-ascii?Q?2LOOLZ54GblFwMFxQ3qQlWYN/54HUSvs+OYpdj7elWpvSJkfJzc5coGwwYzg?=
 =?us-ascii?Q?25tYpISQw5wmuKrRT4qgk3w84Nda/Eh8V/OoC9r+NCFIH961qqRSCgYI/Myo?=
 =?us-ascii?Q?Jmb+bjg5nNDWQ2zqWoanWZk2gFSVEiirZ6yCoNn4HesLEOoXazmQqa5ZtFy9?=
 =?us-ascii?Q?T40/27JKqTnGDnvB12lJSw6nCJnNMf2tzaEIQDQdnvD4+ZWfVodbVyexvZIi?=
 =?us-ascii?Q?uVkt59UVoWkIva2IurfSq3FVW2By+Ee2IIn4q+EHTvQ7Rpf3bjgmSt819qJQ?=
 =?us-ascii?Q?CMV0G6Dg5vA39eJ8clh60TCumj1Ep5lxSB1Av0SxDv8gyM6Gn1ZLTf0SVhyp?=
 =?us-ascii?Q?2xiiRmbpFmSXnZT4PnpQXZRdSJGlvQtZ62xSUTNGmQF2fc3fbhUKqMKzfVWK?=
 =?us-ascii?Q?hjmEqLGz813UexNgkrcaEXR2QVBdEmZGUndn7lKdyJ3vesCp5tt4coXap0x+?=
 =?us-ascii?Q?csfMmo2B01KNwn23oBzgdcw/0059AWmglCG14BI+UkSU2ZWeTvB8Rajb5g2P?=
 =?us-ascii?Q?ffUbHy7DTJAhejJkFM23F/2Km4gxTWEXbLn7P1H5s5DRnE415CyBG5pAHn8r?=
 =?us-ascii?Q?MN2sPBtiXeu5vfPRyZQubluL2Mx7s3AUo30pJ+WYrsLWcIUbUxmWTVaoC2lt?=
 =?us-ascii?Q?2s7+sYUQDUwdxIJXc69PIEBq0JqauUa+JwLKQncOiR3c9cKtnUckGar4/pdg?=
 =?us-ascii?Q?Hk5Ygk3hckzOHOt9xUSgGQt0ivAPLqTDBw5A9VLeicM/2BbsdjrRR98azyGR?=
 =?us-ascii?Q?hz31MH8rs8hXcHz57w8192X4sWoMOzMbZAH2QvAc6bc/ANf2h9H7ZP6xY3qK?=
 =?us-ascii?Q?q3rfA4sSIQEMcS1z9l2cvnn0OfaO8gXVexpsYoofN26RVN9ylOT469JTVtGj?=
 =?us-ascii?Q?zGb0c35gcwZRDhoek8kGNYhueuRfqwO4//TnC71Ef4w+j5oUysBvPChffrj8?=
 =?us-ascii?Q?QJ5s8rOXvlP9rnPxaumofFf7UVGnebTO4ExE0wAd0CnNi5tUuQKBepWiBdsw?=
 =?us-ascii?Q?HapXEu+euIyJa2GRhbarSZrP9WVbc/npCVYPcjJyfXG+uCHchbwYhZs+rAEj?=
 =?us-ascii?Q?pHK6xyQwqQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f37ba-ff9f-4e6f-d120-08df09e1aa0b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:34:53.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39IpuU2K4dvviEHc9K8po5KEBhBnqx97Ji5y/E/F64QoEkIhnanNWG3s9H7U1QuHdNuxVBE225QHdbDpnu8zsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

On Thu, Sep 03, 2026 at 09:49:58AM +0800, Lin Wang wrote:
> 
> 
> On 9/2/2026 11:13 PM, Borislav Petkov wrote:
> > On Wed, Sep 02, 2026 at 02:22:13PM +0800, Lin Wang wrote:
> > > Please let me know how you would prefer this to be handled.
> > 
> > Well, X86_FEATURE_ZEN isn't Hygon apparently. Otherwise, we wouldn't be having
> > this conversation. And we wouldn't need ugly workarounds like that.
> > 
> > Which means, you cannot set it on Hygon. Instead, you should check vendor or
> > define your own X86_FEATURE_HYGON if you think it would be useful to denote
> > common set of features between all Hygon cores.
> > 
> > Reusing an AMD-specific flag but then having different hardware which needs
> > hacks and workarounds to the code is not what you do. Hygon is a different
> > vendor and it should be treated as such - not piggyback on AMD code.
> > 
> > Unless you wanna piggyback. But then you have to extract it properly and make
> > it generic so that it can be shared. I have been asking all people submitting
> > Hygon code to do that and you are starting to do it but then you need to stick
> > to it and do only that.
> > 
> 
> Hi Boris,
> 
> Thanks for clarifying the direction.
> 
> My proposed approach is to use explicit vendor checks to make
> init_amd_nbs() and amd_smn_init() AMD-only. Hygon node enumeration and
> SMN setup would remain in Hygon code.
> 
> Sashiko's concern with v3 was that the AMD initializers were restricted
> while Hygon call sites remained. However, as currently implemented, the
> AMD NB and SMN paths are based on AMD topology assumptions and cannot
> provide the Hygon node and SMN mappings.
> 

The "vendor != HYGON" restriction would be fair.

I don't understand how the "model-specific" restriction is better.
Wouldn't it cause similar problems?

> I would first stop the affected Hygon call sites from entering those AMD
> paths, and then make the two initializers AMD-only in the same series.
> Later driver support would use the Hygon interfaces.
> 
> Would this ordering address the Sashiko concern?
> 

Right, so first you provide a Hygon-only option for all affected call
sites. Then you add the vendor check. This ensures that the affected
callers don't break in the middle of the patch series.

Is this your intent?

Regarding the Zen feature flag, I think it may be overloaded.

Hygon systems are Zen systems. The same Zen1 architecture was used
orginally, though I don't know how much things have diverged since then.

All Hygon systems are Zen systems, but not all AMD systems are Zen
systems.

So we have three diverging Platforms:
1) AMD legacy (Northbridge / !Zen)
2) AMD modern (Zen)
3) Hygon (Zen by default)

(2) and (3) where the same until recently.

Maybe we define new feature flags that indicate a Platform/Interconnect
group? That way we won't need to rely on PCI IDs or vendor+core
combinations.

FYI, that was the intent to use the Zen feature flag here. It was a way
to distinguish (1) and (2/3) above. It worked until it didn't. :)

Thanks,
Yazen
