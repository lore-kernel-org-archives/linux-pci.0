Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA33F1069;
	Fri, 28 Aug 2026 00:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875260; cv=fail; b=ZTkHiBWWdAM2fbsHGbyuHNcZWqChQLmym4bKF5OeZ8MOw3cWhUYQYCRmThqHbLDPclplkRmsrD7bSPT/APU62/IpfMibHtpPvdCbER6/8afTE9l2u6RLIL9UeHMny7Zemy+OBNhPrgYroUW9vml0DNR6orfFI0/Yd8lB6EiwEAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875260; c=relaxed/simple;
	bh=XsFrY/K91Ag7RCQ0wKhPaux5Q+VKwZc8tqFBIfiShj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aiWMgdIXfpNXfJHH/9LF7Y0P+vhwdSAri8zxZoqiEkhebWEFCdGcvz/sTlVJsyFvWFJlr3sPizeGD6S8KdpduYKXIVI0sHS9twRF5cjGI8d8DwnXYxB+qs2Yb2y/xagqnWwYJ+DFcNDNXHN0Q+lJZICNJark31jnq3JqIrYNxjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gxKvVBgk; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gxKvVBgk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDJhwoFDn6viky2zloxolZioyiU5AsZXz0N0Uu+LfnpR1gwo08bjuzPOzLKW6NeES0cT8ySxNzRmmAHib3PbD64LLfDLKNIJvXX9ZiKdE4whUe76JYYT6upmMUSgFMswtlX2fQyamtvx/Eds9fLDR+Ykyx9HiQvLWzLVICIcC+m0/xzkRs5G7DRTwDy2YjW7Xh0AqMTaK/vGCq3ibNC1BzxDL8c01EjEK/HHqwXBWeALpB0qpikf9G9P7wyrLPmv95ZHjPGA6pZYhghni1g4lBHPHAB/rLB74uMqKB+IIPh2fIDohsVeT4if4wEa48wm40kcAa7XVb+PkKrIKlsZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH7/aNWP/qNff0UJCCDpymwnPeHCw53vcp4WZSaT4jY=;
 b=qYbJefHwP7Z6H2W2wZXuRIf+fb9+T27zv/ooo2Z18zVk6LXwBd1JkDJkmd4Yi6/gZbC1i11C8XNsNONxh0Ka9HbU4gKUXDFD7HtW5nT5gBmtlo+p2gW4t1M5vvVUrO12G+QSql2dxGJ+CtPfpXi3wF77ogGAO57wvlJkCbQSfd2FUJ4PPaqonqcus6eZIg4axUGGRtAKXn/Pv3sdiNDTPANMNZSw67c8GCkt9uMWZuSxyfNcOowo2SuPkcyOU/ui6qnIudggfzDq84tvSvPXX29BCiFvsbjEYmuZ/nJCKKzfxzDk1CYgjYKkK2g2642r42R4hb5e/C/+lxqrmnAohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH7/aNWP/qNff0UJCCDpymwnPeHCw53vcp4WZSaT4jY=;
 b=gxKvVBgkCmVJb4FaPO++PLtGoI4f3MBej4KO602WrQzsS58laBoyme+HK4wFfbr+afAJTHmUtk6aCCEBXsx320r116d172/RuzNopcGdfuCxmW7UfPiPpXw7HV3IS+mNC8ja/Cwvs9A1d7mlE9qnJLdPpT1+T4MN96wudA/jwbc8/8q14gEQbzoggThk0uskTWrRZ3tMEjbTF14CU12AYmXbt/SuOKYr1pFbz9HpLgbDIrKioD2wjehCascTBEDMZQzqcXPQiRCccijStJO9YnO4yz9y+iLpq6vPHKP/aJJ5cVLxq4r40xmG1MjUmcIgM6gTumlvuiv16cLPcJTarg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 00:00:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:00:52 +0000
Date: Thu, 27 Aug 2026 21:00:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v5 02/18] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Message-ID: <20260828000051.GA3922654@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <eb77bc0422c77158f48f370c3f7c1b937c319894.1783044582.git.nicolinc@nvidia.com>
 <178786269177.3808739.5968833634148757858.b4-review@b4>
 <apCiweYENYZcBYiV@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCiweYENYZcBYiV@nvidia.com>
X-ClientProxiedBy: IA4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: 6603a529-4dba-477f-b5c7-08df04976cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|4143699003|22082099003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	FbgkTzPoSd7J8qnj5bW9t/T8BhtggDslT3fOmgBUiM7wh+NVoA2jgthhwqOIB9uBXb1pB/bfsiTSSZFZXTs7i4EUcTnJYG6jJz4llulNnVfqgvcvrHfosX1SzbITIG+IvTlv1fq/Jtt1OQkSdBFYtB33gTN/TfeKg8tQN24/rJl81zsXu+UtxwgVh9hNCPCh1J8x7gYY6YKlmnNLZl7uYWvw67Us5R60LeuCT543R6NwuaRNhNm03GnDGJtdSBhZEhIeK6j2yD76Rv8X0KfhCpc/gBvLZsGu+nBZ2GhA8AbBIU1BHr4VoXDOoyKfO7N5hSYgrjJIgMQ3Tj8gwagSl33v5mxxo68sPwMb0mJZ3+HEZSreSX3SLL4qDnhS5/WBE4RvmMCvUb1KVoKMjraSB6Q4hDGZF6Cb+S/7H3e6dTvaSQdL3gKW8hlsIpDuUUDiKfmo6QVJcBkd5a7S/g4j9h1hHYsepi4OJ8fbdhYUdMJvRFsnYCRZ41e10zJH/EhQ9eq4WhvJeQ36+nTlaZ7UjGhSbq1wo/ojtZoIxk4VVSWpvBAzkLqdIIlQfwnHD6fcDoU3+rQAp+lLctGPgcFaPpamTvUssFfwxKYZb0OT27H6CbAZILX71cc1D4JokyZPtmZ5XeSg/fV//Qp9fZMAMD9JzkN+YxsWqf/gOwZ2hq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(4143699003)(22082099003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCeq0LYY8u+H0LyAvytPDmKwSAjPpQBkSDGB5u93T+e1vdjV5ew9gwZdJ87t?=
 =?us-ascii?Q?dlbMbr4nlL37y/qzQE/z/6UqzdEwawEuzCyAfkr9SC5pERpT4xQ9jzpQUUBM?=
 =?us-ascii?Q?MHvhmICxLfVUQOxsP2gqMiDZC79Inl8UKyOGAnDqfTRggASmtSs4xBDRiE1Y?=
 =?us-ascii?Q?5yi4kz5qtKqbgLEUpmn9aYcUFJLjGf5oIHPjAvS4DvF2IYtRR+2kPFKIiZjf?=
 =?us-ascii?Q?sWX3TIafHxZGulqisHwhaHckmwTd4y4h0Of28omVXpbkVoJ62vWaxsuEoZ3v?=
 =?us-ascii?Q?JBxOzadhYMu2p1Z9P5TmhFfnayRGUnXFITL7tBO8C/B7XL21BkQqsgSpdJav?=
 =?us-ascii?Q?yVt2lcwEq7DKDO0kCNJyQXJB7qKZvqnSz0Kx7AKINSZmm6B9sJqv8mTdePwE?=
 =?us-ascii?Q?VMRo2rVER22xWszVNYwJ/fnm64/fJDVSlf9fcRB30jnrp7senrBSfVrR2hGu?=
 =?us-ascii?Q?xr/cwaqGYiEnyhrPQvGgLg4S8GzAhceVWI+nqW5CTKA5OrAcJWTiftBEsInf?=
 =?us-ascii?Q?txnVmeecaCGax1JRtRGHhF3IMZaAFbENEhzDE1IaVy6t46UAp7jVAGs9wSO9?=
 =?us-ascii?Q?sv1AI+w+MMVsyb2u3dsHtCLsN7xFx57wTTe83yH1KUWiNuDj6+j8zNz428W9?=
 =?us-ascii?Q?eZ8/Fm4jdAkr3qytLCwJnk5EpvjYlAqh6nx5wwDEQd7bWS1mp872460QT0Ya?=
 =?us-ascii?Q?CxSZDEXWpKV4qAvnXToYlSD3lWXtD8GTvGU98FZb+3zlpLFE5rKev3L3lhXg?=
 =?us-ascii?Q?+bQ+c0dOVv+/3BTYKFRR4jeKANvQzWv/SGRUC1vF8tnUCgkPG+Qnb5YvcxSm?=
 =?us-ascii?Q?be7HFA/jr07ugexSNVb6uaHQmwgkDvtK7LUa02Wo4LpQsRZC44kpN7a9sDf6?=
 =?us-ascii?Q?o2LtHUWmlMd5MGgq582nEtlXqWGFl2Rwr/Pqa9ecT/AqWsoFuJ0rW2L7L8PA?=
 =?us-ascii?Q?zRj1ZDVrbLmZ9UpOZzlZDnBgmHvt1ZpkHirfrD84hxtPXpt6LNqCS6+rsg5a?=
 =?us-ascii?Q?8/YKisNwzU2pv8y0nlORTLD2sHPQd0o2BEgnxDf+zeib7C+Dh0QXFfxaP8NS?=
 =?us-ascii?Q?cRUzQNrUGfaRCrqGf+u/GQK+4xVyZCjxs9FLFwX8L/KBIleoYTuG69l8034U?=
 =?us-ascii?Q?20X3cW6YoHtbMMcibcBbFvuR/qpcF4Kgo/siJ/Yo2UEj7cKvLF0kZbquIEsI?=
 =?us-ascii?Q?AJzvwPqpmjzWbAQVWRqL8zOEaBJt/5ZI7QJ/Zuja03tZh29Em427EdmzxTtw?=
 =?us-ascii?Q?4Obs17mcAf3Ge9Z/mZc/OCCnIDQWYopUao4RpTSY9BslxELxZfrT0JBuj3xx?=
 =?us-ascii?Q?Vbvsq+3iYWG4d5N4gcWAzc0JNMrijv8zLL+qWd4MKq3n50szn3wVbhBTzLVL?=
 =?us-ascii?Q?iED7LnzAOS/4HjOSdq32HnXHcY5MRdGOl5uY9a6Sjc4XPlWUQwsETmcN54fP?=
 =?us-ascii?Q?fULGf27rCUvOBiKuQT9NV2jLdXnMIV6S2hvAvT5NN3PJuFlq60P8haGV42C4?=
 =?us-ascii?Q?MZT1EkV+q+nSfox2ryPRTOOhRvc1BS/OLjt9IB/KnsoeD35R12OnLzPyXf3e?=
 =?us-ascii?Q?P3nTZVnwXHL9om4zSlABvlKNfeO1iaNY40bVTG2w0taFx8++6mVGXSZBMtbx?=
 =?us-ascii?Q?GhMmqrn2fO7KlJt810sWHAIyLGlH5I/cKB+1/XpY09OJD46rYiTvnqOi+2jY?=
 =?us-ascii?Q?om9ftkljVc5wYaM8QjHxGKtMJ+uQd2ol6OdsWOaTuuRuSg5T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6603a529-4dba-477f-b5c7-08df04976cee
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:00:52.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8rkGJObrbwAE+jZJjIl33P5MqzBVANb2LC6asdcK4VSxyyNZKm8oHMDx2FEqMln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453

On Thu, Aug 27, 2026 at 01:49:05PM -0700, Nicolin Chen wrote:
> On Thu, Aug 27, 2026 at 05:31:31PM -0300, Jason Gunthorpe wrote:
> > > [ ... 27 lines skipped ... ]
> > > @@ -4979,8 +4979,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
> > >  	if (!dvsec)
> > >  		return -ENOTTY;
> > >  
> > > -	if (probe)
> > > -		return 0;
> > > +	/*
> > > +	 * Do not probe via pci_reset_bus_function(), which would reject a
> > > +	 * masked SBR that the do-reset path below unmasks before resetting.
> > > +	 */
> > > +	if (probe) {
> > > +		rc = pci_dev_reset_slot_function(dev, PCI_RESET_PROBE);
> > > +		if (rc != -ENOTTY)
> > > +			return rc;
> > > +		return pci_parent_bus_reset(dev, PCI_RESET_PROBE);
> > > +	}
> > 
> > Why not put this a little lower after the:
> > 
> > >
> > >  	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
> > >  	if (rc)
> > 
> > ?
> 
> Hmm, the "if (probe)" was checked before pci_read_config_word, so I
> kept it there. I don't quite get the reason of putting it behind.
> 
> Mind elaborating?

I'm looking at the ENOTTY:

	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
	if (rc)
		return -ENOTTY;

If the general point with these fixes was probe should capture all the
ENOTTY cases under probe there should not be an ENOTTY return outside
probe.

So maybe that should be ENODEV, or maybe probe should check it. I'm
not really sure how config read can fail, so maybe ENODEV is the right
direction

Jason
