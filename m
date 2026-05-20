Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE33A3E9C;
	Wed, 20 May 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299774; cv=fail; b=FHRpkpWaoIzrrbIHFKCYo1NbiLQvFZaERVJSrCn5e+/agAHdGmUyO29FrewxC5iNjj6mJk6ZKion1URKzIHJ2PYSYbCVyyTq+bhyFdYayh9HshkLln+ceT4w+wO1v/Y5qUqz4B46s22MnWs82kzM5IV7NRQJHU6PU+bMH45Rhi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299774; c=relaxed/simple;
	bh=yMvFj2ZISFnn949zRG838LWlUXJuu2fcNP6FqgbTbwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qDXefQl0K3tE5GY6jvlvQeS3P1pnDsLYmkhqR7m8Vxr66//dmI3aKpprPmoVAGh0PvghteCWu+EHHe5b9WuBMs3RjeXJDuIdcf973Tpyx5FtV6h8QDdpivXb4ScSsdPU/0zSbFzhr37gpz+Tq32kkgL/SQ08lTAWCAx+6ZRB3+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I88OxFe4; arc=fail smtp.client-ip=52.101.61.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I88OxFe4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT4/K440xYq22KpD4E/bDNsuk5nzJkIGPpvHAP701K68As2jqe58ysSpvqCbbkuhdkxMUD5L+PPZkdX9Xh9OQ/EcUTcthH63FTYyetuMaOTmC1dkTMqiBJiYI5epHjBpSPlELrbfQhi5Qdh6tlOUXpY/94QLgWAOStruLZn0hJs+G2Hrwe7D33PmE+38/vwNKzRceQrknNZX0AyXSPcD1kAUoik1sbFvE0ESlU6VaH37quJ7CuLYDr/h9j2bsr1NA8567fjw4uT/CMJBtzJoyqBv1e26Yu3bhqm9IrjrXgPf9QHVSMKdA+Ebd1Sw5rdd+bgKxAttbUu5Ca1LktVy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ml0hDQFnwDf3lDyLX0kMyIARhV3kMFDzH1agA9Mrl7Y=;
 b=fODogBVpNm3UsETNMl38WEvkiiiL0Xjdri6V8YNq4sOxC4Z0NjOCeJYvSIyxOi5iDg6mQiR/70hY2inkxev3CQhWOmd0nsCqxu59u9VSNPR9zUaIT86oaRzwUFp/72S9AOvwWP3jf48zBGWXkw8N4DURgm2EgCUImF5rsxKfR2p+CVRha5uWKQY3Y/IkqCoyNhT6maSDVgjSAYEnHzx6eHuVJbVuIUjfgS1iAD4c3fY7W5C3TGLsAUF/81lgSvTsyJXNbLiHcxAB3sCBlB45AW6WUSYVfH42cTAR1As+1byep0ZWreEUhAACskPM/cIZ5QZLg+3SRKYqG6GP6fEAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml0hDQFnwDf3lDyLX0kMyIARhV3kMFDzH1agA9Mrl7Y=;
 b=I88OxFe4O+kcQqKkj1CwSC+X/URQCCO85teYTE462EF/HPJ0KglSTpcSH1TsNYbiLlfi/FhOP6zdYL08wVG8YeGEHMIUlFo65BLTLLKqN5Qx2ScROoADEFg36N2oxrf/AAqYoYlrj/AwZ0PGomlhSiqKvjIvgRKCjfIjwHc2m4ODfnSj3QuOxwAC2yY26N5Zoktu6ynhshhgHCP3a26zXqHTf3eGMQHIUwB37397EBij4C5m+6muD4uO+tl1pWUn0z9RnEQ4Lf9cvavRnc3Wf1LXhf6jED5OmkaMx39uscs6RNQMHPTxmbYTp1jaNsypN1pOMzvGNeBgR+9Dnp26ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:56:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 17:56:07 +0000
Date: Wed, 20 May 2026 14:56:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, joro@8bytes.org,
	praan@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260520175606.GB3602937@nvidia.com>
References: <ag3vb4SWIfuw++vp@Asurada-Nvidia>
 <20260520174758.GA66039@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520174758.GA66039@bhelgaas>
X-ClientProxiedBy: BN9PR03CA0602.namprd03.prod.outlook.com
 (2603:10b6:408:106::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fc3fe5-e937-41a4-728d-08deb6991168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	m6RlOGUKXxNsHU7tesX57+GB2vYLuVfOxNyVs3fzdUd/kAvQYEyzxRlzdNdtUXHb7DdsNvRVybCPv3csBPHF/jm2xxUpx/r8n/fktDoYGlMGyX6EtWYwZ+c6gs16nOpr5yCnLwpw6RTZp7ggdF8sD7VH33n1YQsl7PVCWGhSMEYV9uX3zA0M20RkYnaryS8QqVescbS/w92t6fTYbCILWrp+jUKhZTimkcOAmN0Rf2AdxADnndXYSfEnFQ/4+PXU5h8b94tBI8uphFgGM+I/Z7rfT97rGt/VH0orJyTTuDRnsb8zi7qaL3dwwzUC07kzy40Sg0YYnNCXjCOY+XMl3GKCCKoHArH7CmBfHp+wrUfN6Y5099jyIK5jVL5aqNXpsn4fJnx0DM2cJ2Ob08ZClswRXRlJfFypFlUAFpbNSNPTPqzf6Vu7h1ITcuG0luoYa5mrXCCKDD59ceR0/OrruHA1RX9xHICivCQgIl0gldZMZ4G2j+vsNDwAODr4RmkMGBJbwO0YOhFX+I0yCsCiPZqVb2dp1mLqBcJnAT8sTOgKT3cN8x9TrxT2Ai9HhMHh6skiaVf/mXdUDD4qF3XhyLL5yt07+Dbb0CCNJmbL2ILEDUKwrVqobMaC56CcxKugbytx6RNTH4A0nm3IuuyhMAkavJHklOwLHRaSaG2o6wP9eksAGxPsYJFEjbTVPdla
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?piU/gXMkWd7kXHNYd1WvuEDRM9RDExfbv32MhjC6VXkULnSic9DBknTqWa5f?=
 =?us-ascii?Q?s3/QyDGbMOgpRES3K7QTPkvK4XMzsSHfNOVH5JfH4a+li3JCoPNxl25EhazD?=
 =?us-ascii?Q?u4VzQHFvpI6ZbyGQpFrUvc19FYZeEeO4RoeApf9yYi3ADkI6rkJ0bR42dUG7?=
 =?us-ascii?Q?imlmtL2yNA7THhpFl7v/Bvc7FUpW4svqdeH0udpAcW5C+c343foQxybcF8WG?=
 =?us-ascii?Q?hOFpyj4LihLWO7Rhe6GJQkBLxpMjjO+Atj0+6d0gqL1zCA3WGcYH0fFxjBf/?=
 =?us-ascii?Q?8ueVXfalxCPnYVLBZa5Kilk5Y7CTUYVTTzLb7qEReF4syr4/SHofdYhsCcyM?=
 =?us-ascii?Q?4Jy0U3Nz99S4V4ISpmSPrHoSG9AUM+NWT5z6hExkXOCeQXWK+pfARRrnyVH3?=
 =?us-ascii?Q?MtOi1AipSNekRiqaqWdanyLlQxSOTEN0YBE8tb2KXWHOc+aBi71PNgeqvfli?=
 =?us-ascii?Q?tFjDorS+IWfImKQlZirYuHunlm2BMQ7vf7tBtK1bivdP/O9gR60nhfnj/K9A?=
 =?us-ascii?Q?7T4T7LrCDQ/GgEpHmJpOMVm8TYZN07FwaDSCxbrG2WgU7ghKkW0BQta8aEMv?=
 =?us-ascii?Q?W/HDZbm14NkB8KlNK4KVjo+N9RaOwi5aC5obSYG4xuPYbKG7iuIEbj64RYiv?=
 =?us-ascii?Q?wOJZTKHYNUDfM1AVqJuQQ0abM0MY0YiNh11QVwBpdvwKY8e4/J6S8cIgc3U7?=
 =?us-ascii?Q?You5p5BA6zrjPUdEB2JqHCysWWjZ4fwWqGTJ2OSxwsYErtlXSdZgejm/zDXH?=
 =?us-ascii?Q?q2FxinswXG6fVd12ewTGbVfPPyFJsTnE+/nKVclj9dlDZPsYFVYM58Q8Sgpf?=
 =?us-ascii?Q?lDxz6J5erQqHLp9bubJoW79Kp627S4o4pEAuqulVb+ouh+qTVxFV9e4LJGD7?=
 =?us-ascii?Q?bATsskWmqLiBtIm/ULuo0dYv38ykBzdicqXylhpm1DvgaGBuIGfC4WsKFcdA?=
 =?us-ascii?Q?BQ+IHfULOZxLURIa2lf8S+Wx17o9SzE2YwU6zoWCpd5e7AsXVKFEbPh0ggSA?=
 =?us-ascii?Q?dg2aePWaxnz+iJUSYM3eKVyrCODWNlp0JHOJARtFZSUTWyjrBakzT5hXwD9N?=
 =?us-ascii?Q?0LLk8A8t8F1Az8tcfThHVPGYI6/V39kX/xGvBcyAeFUFMNgAMc/VxcA3KCxn?=
 =?us-ascii?Q?fowF5r//InRGqtTletHUDq0NzNZkkxBHq3nKUbEN0Vlm4XQXysqdYrvSxqAI?=
 =?us-ascii?Q?MuvPkV2FMx9CKmHK/mM+ke53O9Z0zXTy/MKHisXw9wWhyu2iaKCsoSu1gyjK?=
 =?us-ascii?Q?1DzxEwF2FFrVPKNgjB/poE6hA6f9t19stdr8a270uCitCehDYYIz9gCn7kAV?=
 =?us-ascii?Q?nnfzmkF5g/Ql7QCEPHbxOLlgI3dDl4t8SEvDOd8aJO0pbI3+4hkRCMLalfOj?=
 =?us-ascii?Q?WsqxbiI22ugjMKZz6CwBpM167E/GAlbDo9AiYfk9GM38LyfO4QHYCU6p2PrV?=
 =?us-ascii?Q?512/yVjaHvoSKnAdMLFCD1dBNlKuSZJePVnwMTRU8zTowEYM+um4pCyTt2Fx?=
 =?us-ascii?Q?ohTOjn/rcxSBDuZ+9m1CvyFhyxj/IWWNraGRDEh4r9hd4wlS1npN/UVKU3Kb?=
 =?us-ascii?Q?B0FzTqwgx/hMdexpRcIBzu12+FxaI9fUROz8eoc/TLaLD5cYmUtxu7i7iucg?=
 =?us-ascii?Q?yX8dYUc7QS6ck+z+9uUGBxmVQWE9zg1xuNxX/30VZ4zQn71IPHtAkc9JrpfM?=
 =?us-ascii?Q?uDzKR63bN6b3HSlKSvQ5q1aTEpWeDQLY+4K9Tk08wGMv7pKW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fc3fe5-e937-41a4-728d-08deb6991168
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:56:07.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrG7o87+7fnnZUkvFntZCbE9zp6AxZjW+sFu2nQ3Q3KTqCII5EtUkT5PZvvgbed5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329

On Wed, May 20, 2026 at 12:47:58PM -0500, Bjorn Helgaas wrote:

> I don't know enough about CXL to know what's behind the ATS
> requirement.  It sounds like it's more than a simple performance
> optimization.  If you happen to know the reason, it might be worth
> a short comment about that too.

At the core of this is underlying physical interconnect protocols that
only work with translated addresses.

Ie CXL.cache only has a definition for translated physical in its
protocol spec. The use of true physical only is due to the cache
coherence shootdown protocol..

It is why I suggested 'pci_translated_required()' earlier, there are a
few more than CXl.cache why a device might need translated physical
addresses only.

ATS is the only way for a device to get those addresses, so
ats_required is fine too, but it sort of glosses over what is driving
it.

Jason
