Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC893998AF;
	Mon, 24 Aug 2026 23:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613796; cv=fail; b=JmuQl2F82S9zn9YGf5Uw2QKGNLCEMezI7EijuvbQ+ArnK1IGByBBlLNphHsRJbbdQUh2cP707uGlelSSd8h0ICzhs3LLWXreG/ITIQLof5BJjTXQxy6I+giJVFRhYJAdQIO4/2sI8anwhj8HWMzatju2L2HRHiEPRbDoesKPeqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613796; c=relaxed/simple;
	bh=W1yMSmTS9w+AIEI1J2TJ6xauO89nUFt9mxyIU4HMw5k=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=Igo98iAwvb2tkzZ3egDY5rX0G6zOkZeL1PHONVhqXrQrlz9tOq4Z3AZv6xVO9W4FGC5w8JwxzfMLRWddKJiqMnbkflyp+RmbJzkLTMf4uyGGS1FZi4rZ7rEW2iKukfyFrSFu1EtKPOi1C7E4GqqG3abMzEBolBH7PoekbHGy3yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=phx7lSFD; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="phx7lSFD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFZSFC4SRaglcdu9LDW0vagQyWrghhR5ECXU/jAtdWG8k4MU5KBcJs5OETm6bPiXnUs8st7UbiuA7TbIfOGcmbzz6FlRyjmJFZT+TEcaZjGgX7tEhZuwIqof1EJT9nksIJMWGTpEpRSpGHJcdCt0ejxURJa6A1Nu31UEKhBWHiJBlCQoc8TQusVsKnjoDbDoxJq2b8nsISgJcV7iyXooJrB48JbA4CkrhAa8Fyd0NeozMG3pSbB2HWCglsiQ+274xsUI39GoD+Gu9z7721jR/R0L3KbtX1FerlUKwBW1QqLJtCrusHIhFgcnY2yoH4Y/sLO+YJBZFEt9Q0vPuHm5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH9HFRb38pjXp98joNOqdqk6DSGhhwhu6LV62mtCZaY=;
 b=H2yKByk2xa9pUWyD1nYvlCSi27d10q9ONEcbG4jUePdp+malHdVijw1V2M9XPVYfMdDpoAVEZXgFb96DI0NfRLO+xflFpxhaqm+Xvd9cJIIrXc+n1Ndlq8OiB6Zw10z6Zh95EApGwlbu8EESKDwd+UGnvt3gKCnLZAXjmZojqHD03IuzlQ038cNvolEo/k11e/POimZ3fYfz1Xc8Cr4c6jJWDlVtsVuujdB2KRWaDMherzyGnmPUNzLAqf4kv1o1um3OpE3j36qujThSwNH41lgtIZ7uwkfJbuocNy+xuxCu1VkcPHfeQwLqkB9qLajdJS8BWyPfxjG2vgyZYWhEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH9HFRb38pjXp98joNOqdqk6DSGhhwhu6LV62mtCZaY=;
 b=phx7lSFDbm6fSl/TnAkrjpvYqxIBF/Vb7X66oIGL8tQYTcw0Wvz5jdkAXLdfObjqwiw4L7qU3UuqH6Y+zJPTrXX1gdQfx/mUP5h6WZ17RQjtEDM2MIAE3WP1Gb0JA56rMZ8Dz4Z9rW7rL8nQvc19mj7FJHiXPYXFLH2l/3ZyoO5mwAS5T3tdn/5zR/KUpDW7rO8D6PyV+tNQtFiwrQBPdx52QtsMvsh4eOgLpZusY2vmJBpxIh43X+loYdgyyHVtXHlLm2o7odMKrwD6zIno7QgTNK1rMPfnLEWsW554PKzi6G/yljjNjeunxmnZeFzINm3QEPQrmO2d3LcwHjnagQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 23:22:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 23:22:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 00/18] PCI/P2PDMA: Fix ACS egress control handling
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>, 
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>, 
 Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
Date: Mon, 24 Aug 2026 20:22:50 -0300
Message-Id: <178761377033.3197084.14418777457559555376.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: aff39800-32af-4cd9-ea8a-08df0236a0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E9mZV7AcB7int/20RgzZpMeeHjVaMwh6TKi6gQigQURLInZeSN+8WIfLaaN7xCQV+MPGWcDrHZly4e+eJ79iL3aJjnofUWbXf2+5LFftCyLgIfdo1MnWKG0h49J6D3Isu1+hWtzvDBfxYw73aXEnQnm19wd4P76UpgkPppyDRaP/tHyOPQgisTRFCK3Ebe7x+pRWUif+BTP+UVNuT/OIoRks4KVxU4P9NfKyUyscEgoGffpYRdFSeFX2cCnqDsIOCr5EnktfYYsl1WsL4T+WTUueyzH7kHiXUcS1OLUo8Cf9GlyrQitOlgkAkOboCTgVoRGZCTPAg6I5qfybzokKNeAI3BlDHOr/SueuHcBVwpapqyyh1XM96l3TOBIjwOWLBJ/9AW/5kKpgsrD9T+Am26Dg7W0nyx5a+mxSS3YEnXoBXcWJitTbcBpCc7pFbxyrSHeuiIFezsHNxP2nZEH/MZmIzfHIRRoujwSdr3Cjq29DxbkEZzQ3ZhrqHIX8AcpCdfqGzS5RyS9Lp1dCRymcy4BCQ9pEaz6ml3A9USJ0xr0WfNw4qW9EhgeKxpPuTFCPu4DosqwcEgDIeBYr0mTBJbdPR45u4NpqsjoqslT+2/kfqrf44yOp3z4xrNrkB8f+fa6f2WwaizTSu/u6VwXVuUV6JTuL1jeJfl7inxiIlXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnJXem1mNytMWTlpcjdwdDRvQ3VsSmNSYnUwQnQyM2QvTGFEOWM4cjIrRTM4?=
 =?utf-8?B?c0MvQy9qSFp4Rm9CUHo0SmdTSytaZFRBRjJBQzI3bUs0VTE4eTZ5RG5WdXQx?=
 =?utf-8?B?ZHA1NWRjMDUvenFudXBjdnJLS1R3WGJVNXZMN1FLZ21mbzJ4dC9aYzZ0ZDEz?=
 =?utf-8?B?QlUwS3FPbWRVckkzRW5maTNtTTBXTmdUZXRiK2w2NWttMnk4bWNuVFkvTzZN?=
 =?utf-8?B?VEpMcS9LZ0tJSjRpbUtVOEZOdWhwT3E0Q1BTSk5qV3gvUjBLbmhKVW1Hb1dS?=
 =?utf-8?B?Z1ZYcWk3Y25Kek5QdXp0bHdvMHEyMG9lclBpTytsREo2UGh6Z0JCRnV1TVY1?=
 =?utf-8?B?ZW8vTjhYVEliNTRqMHIzNmZIdE1SSkpGeDQ3VW9pK3N5Qjhpa2wraUhOdEpi?=
 =?utf-8?B?a0tHODNBQ3ZuVVdicTd4Ym52OTF5QXlhTno2M1hQcGN6ak1LWW5Zak5xUjJ0?=
 =?utf-8?B?VENQMGs2VVUzc1Z2ZVlySnhGTjRZZHN4dEJUZGpkenpSbkVrWHlNd1hETmE3?=
 =?utf-8?B?NHlWSEpETkJiNDlyWWdpcjVBUmpxMVd6VEJjaVZDNWx4TkFhV2xKaVc0alpK?=
 =?utf-8?B?emhLckZ3c3ZSaUZ5ZnFQVFFMZXdIWWF5UTNMYlNYcEJ4bXVqKzlHUXFhYW1P?=
 =?utf-8?B?YWw3WUhuTkVaUjJqMjQ5K1l2ZXhBQzhjLzdScDgzbFRuUGZac2NBbGw0YzZt?=
 =?utf-8?B?Qk5EY0xySkRsYjc5MVJaUW11L2x4UTJaU0NMWm9OZ1loTjN6dkdGaDNFOTkv?=
 =?utf-8?B?Z1BscmpidW0wWU1DRU9FODVqSXRaQ05mNnNIWVZwdUw3dXphaWVCa1NzSGhl?=
 =?utf-8?B?VWVHZ1FtUjFLRkplSFlYYWZBMGpwWm4wRE9JOHNFckpIaGRla1ppcWN4R1VR?=
 =?utf-8?B?aVV0cUd2aytDRzY5UDJ5c0dRK0ZDbjIrR0NRbnpIdU5PUnlwUm4zSW5sdzZq?=
 =?utf-8?B?YjJLRW82cE0wT09wQ0htQnpWTVdQb2J1bkI5bS81WFp4MVlEZFFadUY1Zzg0?=
 =?utf-8?B?TU4xdHhqcENPaDlneERqMURnZ00xZ2xJcWdyNDRHc3F1Y281cUtMYWJ2UUhW?=
 =?utf-8?B?ZUlBVTFYTzczcC95YmI2K2J0YjE5SGxPZ0NhV1FISmUvTVIxMkVtdDk5VTVX?=
 =?utf-8?B?V1c4MDdFRi9mbHFIdTdPZk1hbG9zWGI4NEQzMlJtZGRrVmI1OFB2UnZuRFdH?=
 =?utf-8?B?QXh6aUtxM3YrdGM5RSt2eHJZTW5CUEpHK1hXOVJhNExLZ0RYY1hWbXBlL3Nr?=
 =?utf-8?B?RXNjT0N5cGVzZktnTVpuUnpmSWZFK1RrbEU2cGNLUHBtUmtGYm9EQnN1WDYx?=
 =?utf-8?B?V3ZzbzZ6T01vUWdwWmN6UXRQanQ3ZjdKMHh1SXZtdTNWUDQrM3hVQzVLcy8r?=
 =?utf-8?B?RmJxUU1yMkEwbWNJRXZibGVyektGakpaQmoxcWVpOXRRQ2RuaUVCeW9YZ2N6?=
 =?utf-8?B?eWtpUHBManhzbTM2alpRb245OUVKSkhVbmtiM3J3azdmY0FJSkZwaTlOQ1g3?=
 =?utf-8?B?dVJLRDBIWW1zVW5kU1p1K3g2bmlCNDlOTm1SRkJ6UkNkSGZtUnpBUjN5aS9t?=
 =?utf-8?B?TUFadVU3U2tOQ2dRSCtubCsxK0k1Tk9ZQTMxaXFCSjNsVUIrSEtxdjBwUFpN?=
 =?utf-8?B?QUNtRXJiZVFCSEtFR3VMWHdpdGV5cWJvRERoSGZVOVd4NkxRWkpaVDFXT3Nq?=
 =?utf-8?B?ZTdmM0Y0VlN6QURNRVJwc29XZ1c5QU5PYnBQMHRTVmg4dGFqNTRoQWJiMXlU?=
 =?utf-8?B?TFhiaGpLWEhta3k4bXJMQ0dZTUdrV1RxN3F0S1VBV0Zpa0Z5a0NXWHdJbHdX?=
 =?utf-8?B?VDBXUUczWGV4N2Q4ZnBhOGZiSHFwNWJvYUJDbmhSRTR5QzhsVTZnTHJwMk9j?=
 =?utf-8?B?S3JtdWtiVDc5ZDV5MC91K0FHRWN5RUhXeWlycGJWZEU2N0lXMG55WG8xaTBh?=
 =?utf-8?B?dlRBSDlGbnhqazlPQkYwd2ZCS2Y2ei9Rc1BFV1liVEp6OFNEZGxzVFJnSUpa?=
 =?utf-8?B?RXpjcXZCZjFJdU0rV0RESVloVTRBTWxKamlIUFlzRm5BVmN6ZmtSeUhoZENo?=
 =?utf-8?B?enRpQVFIbDN6czRxMmpkOG1MMUxQa0dWRGRZZGtBSDd5eitwYWN1Qk9BNXdT?=
 =?utf-8?B?UEhXM3FHRHlvR3ZlTTQrTnlYNzJiYW10Ym9mZm1XYklyc1RRZWJESTk1NVVt?=
 =?utf-8?B?WW0xRFJ2aEtmMjg3dlp2YnJTTDJFZW5SQlF6TzQ4d01JajNCUndITDBtMlVz?=
 =?utf-8?B?RUlrMzNmWUVGWS9UTHJRV1RKOWlhMEJHVzFvay9McTErMEZndWpYbDdpeTVx?=
 =?utf-8?Q?oAE0z2xhojgv2uepEH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff39800-32af-4cd9-ea8a-08df0236a0ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 23:22:55.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB+5IQkAfbHwWeCLMbhbJUmgItW/zPpPkCZOlEv8k0smcLwGt/Yvsu+MWy6QWOXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386

> PCI P2PDMA treats any enabled ACS P2P Egress Control bit as an upstream
> redirect. PCIe r7.0, sec 6.12.3, table 6-11 says the Egress Control
> Vector bit for the target port decides instead: a clear bit routes a peer
> request directly, regardless of P2P Request Redirect. Firmware can
> therefore enable Egress Control with a permissive vector while Linux
> incorrectly rejects a valid direct P2P path.

I've never seen anyone use the egress control vector and broadly Linux
doesn't support it. The ACS command line shouldn't enable "P2P Egress
Control Enable" for this reason.

It is not a bad thing to accommodate the egress vector when improving
the ACS logic, but the main stream usage is the interaction of the
other bits along with ATS & RO in the TLP. See the comment I left a
long time ago:

https://elixir.bootlin.com/linux/v7.2/source/drivers/infiniband/hw/mlx5/mlx5_ib.h#L1649

So it would be nicer to read in the commit message how the mainstream
stuff is fixed up and just a little bit about egress control.

> [ ... 36 lines skipped ... ]
> A pre-existing gap comes first. The routing analysis covers only Requests
> carrying an Untranslated address; ACS Direct Translated P2P overrides
> those controls, so that scope is now written down rather than implied.

What I talked about with Thomas is we probably need the P2P subsystem
to know what kind of TLP the driver intends to put here when doing the
evaluation: strict order, relaxed order and translated all have
different possible routing options, and real system configure things
so each one takes a different path :\

Currently I think the P2P subsystem is assuming strict order
non-translated TLPs when it makes its calculations. Which is fine, but
as we go toward enhancing this each of the different paths should be
kept seperate.

I don't know how the driver facing API should work, but at least real
devices have options to use ATS or not, use RO or not, and can make
use of information from the P2P subsytem to make the right choice.

Further, when we get to things like an ACPI description of this stuff,
it would be nice to still discover these differences as well.

-- 
Jason
