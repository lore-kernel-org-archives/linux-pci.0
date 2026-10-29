Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285838;
	b=CceOZi8FBWFhBrzRPCfYRdvIAy+aPY9n0VFJXFpExD3oSOd8RU2SCbT667iKPqv7iLOO
	 /9GZEV+u/AYfXdx2drwwu3aeirSAHgTsOguZLmhPj1ZhFPLj3sd2qAgkMooVqOUWXmNLi
	 jUCHJXXr9kB11cFPNYN4ACc5v1M2xCJevjkP1Pe7TXoQSVJPbts5hwkGeUb2GnthCOw6V
	 PMea/VnNXeHsD06hjPcdfr5wjaOQzva1oA3gVHkWK3szXK9eI1we8LrtIm3nK4h+4TvLR
	 LqeT/4ei9q3v5TN6szhU1zFcmUtU7s/c1reIZYi4T4Y1+FI8vnR/jyqMJpTJILKCdtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285838;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=T36niJKseuNhN68PcieYaSicCehpaLHhPQV/J98R+AA=;
	b=0oH1jOba9OH9Le6IPTjBjfq+lFLLRkIyr5KIe9HU0gctP6snriuEdh2h4ZwVy6nT65ZT
	 FDY/GmfL1yRCwCsq5W68zWr9c3clNcuc3LlpU6KozUlo502B8+L3eWuWkoX73o/aXZFvv
	 gm5OxN7QNSli5zHCTUjLJTPZwOBQJ7PWwWNHBjcLCdsFij1P1/9Pp7JoNeSVqOtwKd4wc
	 Lsl/d5ImrePp8tvXaC18je0TTWwfCk6XDMNWY46oat/sVJ5xev/tB3DyLQ6mkrlW5X19p
	 vUtR1+/CwjJEIUWiQ5WZTrI7UMdcGofFSv9G2v0cxqOT1Xs3L30VI1oWOKmwpovkjTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GuaWviM+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.14
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271C606A31A;
	Thu, 29 Oct 2026 14:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2271C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GuaWviM+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIYrwsIwBm8PXMvRugniQ4VWAZpiSyN33czAulc97Rgq52hxqgTEKTCnZTjYgtRkQ9AYrOGjaorxO0H8ukk88buGbZ3cZhFGrP+5MvRQyCG2I30vSVX+rvVxGIOggnynxLxXNpyCtO4HC1yIkoO2XrZHk+LmwKorCWBZNyZ6bdxB/O6AOh7fLTm1tJkpNcTyHXl2xCwTir2auOhrm42ydgsBPPr5CwJGuS+JU3AIeMiPaAlsr3rxbOMPE1QKKz8AA6m25o9/Yejtuk9+MSN+UMEcxu2R7SUcPTNKpexd+hVQyY/Ed9nIQ6c7GI8cSRxyN3Z4Yr1uDf3R2fne6eX9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T36niJKseuNhN68PcieYaSicCehpaLHhPQV/J98R+AA=;
 b=jRVkwVYL0gLoKH/SaJvLQwC0HMwcjliQGZ1Ow+7NUZpssWaNhQ7T9+oAxO1D/I+6zUqR/11m7lVVdAXWmyUYdfvTH1DObud7Sa729NtYCM3PCvIPXuXm5VA02hMfHTMlIaQcd96cE3CM2cdpuDs4HjgMnnMj+D5JmtWMd665ovbQTBwjhR0ZPQMyNNehMkgEO6nzdFrVPXWdCZBvbMsjpwiWER3zucFl6F7+ltrZK22g8+bA13kh8vtPwA50w7BQlWcgEcrzOs8rpITUGBL6J1dgWF0Wryc2VN014xYwiv3PxFNN9WSeW2z5dPVlkSa0AQT2RYQPTrhOqUTqEi24VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T36niJKseuNhN68PcieYaSicCehpaLHhPQV/J98R+AA=;
 b=GuaWviM+In7xrR9ZaHtmHtaSqjhNQutVUOt3IThrFMspHMVLKtVLO+K519qeJAo5j7+mB/5X44jefVJTzcCLp/BAmHR1CTMh1cYxZVm5fWGHXlNQLVt48hUfXueWBjG7TPYHPdz8/4rasE4gZHyOuZnD+hhkch5+8drG/jmgL6ITc6OR53Kmi9RyfsCbpGhFlmtpi9TBZIT3z7Mism7UUUUJVVEnul90IObphO4p51GjlqM1lJrj+7TcPYNKuunQzDDRZlTezJrn7Jq89zmuKyQLX9om76c/ecgKvapB89ciUCUJd3ARvIEQVfXah0rQlTNMc9OFHHwQLJDDmVb3GQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV2PR12MB6014.namprd12.prod.outlook.com
 (2603:10b6:408:170::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 14:57:13 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:13 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 00/18] PCI/CXL: Add CXL reset support for Type 2 devices
Date: Thu, 29 Oct 2026 14:56:45 +0000
Message-ID: <20261029145703.2185231-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:303:dd::26) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: bc331968-afec-470e-6b4e-08df35ccea53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|261028144727099003|260925021911599003|260925021311599003|260925022911599003|5023799004|11063799006|56012099006|261009223027099003|261021123027099003|261022113327099003|261021121427099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|10067099003|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dmE0NgbZ0ko9GfyW53l6Ni8Az+7RSqd5GSb+HGtAOSoAd0HTtTFaFSuPlO8k9Mtu9cjUVAQafUclR0njd+vtMJfXyyyaPivK7iHvP1WHlpjLFFP8AaHB8TgKFoQmfLqq36kSlVcc8ltSocUVKECiCw1GFfirl6kbDX2tWNVn/14YwjPX+S2gTQsuPd/o0A+hkePKrjF0VjbL6bdARNCQj1877f9YXk5sMJOSZ9qb6xg2R7IRV56Idniylo1dHTJ+7aR7d7+mfRTW0uR1YLpyRrHwuDfG9ijyZVcikNssfgAuwii58DjqBwvriJgwJfaGUSiYh8ZGHlNEbojawrml+U2jf1V6Y0d3CQsmUK/wvYMS2dns0YGMm3SGYoVlXLLXRfHmu2Z7BlpM6gaXnz8qPiEwCHYRYupqfnM3qVS56LW+AtuqV8K6QkPV5KgCPWFFIP7LnYLsHgO6sa3sBjnHapsV18PefDhth3+vrDo3N2asLcKMCIJunb2QPWOYBwD+Y0abQCccisEN9WYU01WDUg2+RjS0xOYJp+ehB4Ix8jiZNdiccj27JJzqP1UB6Zp0YcyvOvkFB7hAvHKNajVZOL5ozifYFxkHgtadOYyAMJNifKMQX+nQmJlMI9FkKNbG3ex1+ubdf9xmsh79zU95xFMy0NMqbFbjOLdcjj8WglT+YOIvm3un5D5i1+K+mdT5nwcNSGlP0VOTr3xXG+9SDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(261028144727099003)(260925021911599003)(260925021311599003)(260925022911599003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261022113327099003)(261021121427099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(10067099003)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0ELwNyd8UfTbjJ8HFMhxYKc1mo4iVoOD73rKiPvbaqjV97nMrFIWsj8g9Faz?=
 =?us-ascii?Q?bL6yQ1Ff5OeDlxQ86Ccv5oTRE7XI7ElOZhK0Ee2V6wNgFqvMvSSDVnHv3uux?=
 =?us-ascii?Q?PdlPM0ooeYWWuF0vKk3Xp7bMXxMuTFewL8FSepw1LCGx/h+F2idvmX+c3b2/?=
 =?us-ascii?Q?s5QEQVC9ZGun0nO2fm95Lmv53bDTmO15JRcuRCk8Bp/ohpb4gjMu84UA4eAq?=
 =?us-ascii?Q?ecNn5k+rnnTM0ZdOynZxjiXn7uuN4ZtHGyCDruCz/AtwwVIwV1zVebT6HtRJ?=
 =?us-ascii?Q?cpeoMn4htAvHiLhSp0l8Wh5vNQQD9HEqUNVhHBkQWF+Ff560BhomuSXZRXr7?=
 =?us-ascii?Q?cPJHA66WpnFudKu+3rH++oOsULCirdYCPzXn2IdgsGEaboLOnkbK8Jz63PP2?=
 =?us-ascii?Q?iJhDSWcp3+5ptEdesiw7ZLf+PyWCZM6Dz4AzpQJ9Y6Gi5AECCAYVWzEjlLO6?=
 =?us-ascii?Q?5z1hfmStpY3vlO2cZ2tLOjRNIHWzzEzHzBOP24qd/1yg9s8etoMDchRjil8Z?=
 =?us-ascii?Q?6bFM5lZW3tIkPaxZc0ceeOMqAcjGfsGUHwGpmgeFpTEGmDYmuP/zNpJb8R9f?=
 =?us-ascii?Q?gUGJ31Ak6LuIAmFjBzLgEyzonH0IaiG0JiD+a3mzSt+AdhwdRo5x4i0mjKf0?=
 =?us-ascii?Q?lLF5kJwonIZHGT7BJOHKeaIAU4R1P2BYLtatGwjZ77kDyw+9sTT/wq0NMXNG?=
 =?us-ascii?Q?KsI8Nk25VlRhE27TKzjaTD7mx4WtswUuE1hN2AdQdYoR9Y7AK7FjX1c+7LdB?=
 =?us-ascii?Q?iBP37fQdZRwXECxrpXi4lqDsFU1wJ9FPMJNR37YWX5dfAUl3ozWk5kkSvga3?=
 =?us-ascii?Q?gLMgMe9yE0v0RAcU3UJBuPs5a51lcJ2uI3OpZIUY1FbgNM8ojBZOnz+Zv0cz?=
 =?us-ascii?Q?FHfZPF+ce1rWy3jOPE3hJCymUCZ1uQV1nfTzzgTmHxQjN8jYRA4Iikhzu1Bh?=
 =?us-ascii?Q?BpGhdYm0tRJqCIcjqRT4k01Obl7lGQyp68naBSIiuFPdyWI61FyNFqtB2hab?=
 =?us-ascii?Q?ZG029HxxBDYMxtrPwuNwg5LKWw/sxFMfvQFCWCJWgPAkhQteQuqQ6MIDvGLt?=
 =?us-ascii?Q?zyYxD7D4hDezoqrTXjb40QKw8WlgFUJyhZCkhvlDPOVRBzlOc92Va2fD+BCk?=
 =?us-ascii?Q?6bTBc62nKXpbLmooiLZ0/R0aXhdcBYpvz/BwTXxQho9oi/+s7o8TPkiS1ZRy?=
 =?us-ascii?Q?exwGddYV0pR4C+119y5U1M0zBiq6p3sem7+5kohb6w0YTaNxF/hdwFHnqPiR?=
 =?us-ascii?Q?MVGBJrOwc06zkLlB3lAhC95z7bNuN+76c8WohMkp7kwxNmnxASInlGluOF2w?=
 =?us-ascii?Q?JqrA1bInlfBAHcLIu3aXbaWs6CGZGmwwXuOYdZmHvFcDZO30TfbhJu5Re3U0?=
 =?us-ascii?Q?EuLwUz8WS1t1zWNf7r58xk/EUm2d4dCntWInLpNPKo2K8EInn/9lP1bhmrnx?=
 =?us-ascii?Q?K1PqW5Qr+mSvvAoAp0WmW+s/Ft3PD9KxHXpVLeCeV1OoyhlL+XQ6dbOp4GYI?=
 =?us-ascii?Q?Mt+1m283RxhuCMCm/MRmTP9680UYyyE/Cq9IIgxX7LdJQocsf4wSmbmNPPgZ?=
 =?us-ascii?Q?LKFxWiSb064X0y1dYU2T4uCCe6t4+CU5q48tnrCbVIMn8J8muzX0jW8GbhHl?=
 =?us-ascii?Q?kCOTHKhdEOB6DEDTpIech8vctyZsLN/+8qVOtYoITo6oj7a1WE1xL/w7GKxT?=
 =?us-ascii?Q?3GKnggK9DUUg+sFpiJnNjt1SYPVN0Y/SbXLNT7JhQixqY3F7+3eI9G3H/lz0?=
 =?us-ascii?Q?T5YNbUxGyA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc331968-afec-470e-6b4e-08df35ccea53
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:13.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMCclHJ5Uqth2HzOviMBIqZBxSqIuctFVBfxMfn8GRzAJrAczgh7ECNejvJgVyzgm4DeyED94K+C/C22Ny5oUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

Hi folks,

This series adds CXL Reset for Type 2 devices through the existing PCI
reset_method and reset sysfs attributes. It disables CXL.cache, performs
supported cache writeback, initiates CXL Reset with Memory Clear, and
restores cached HDM decoder and CXL Device DVSEC state before PCI use
resumes. Active HDM ranges are reserved and CPU caches invalidated before
and after reset. The method remains limited to eligible single-function
devices with both CXL.cache and CXL.mem enabled.

The reset sequence follows the CXL 4.0 specification [3], including
CXL.cache disable, optional cache writeback, CXL Reset Memory Clear,
ResetComplete polling, and ResetError reporting. Sections 9.7.2 and 9.7.3
define the completion timeout encodings and reset access restrictions.

The userspace ABI is the existing PCI reset interface:

    /sys/bus/pci/devices/.../reset_method
    /sys/bus/pci/devices/.../reset

Userspace selects "cxl_reset" in reset_method and triggers the reset
through reset. Following Dan's v6 feedback, this uses the PCI interface
instead of adding a memdev-specific sysfs ABI.

For sysfs reset, the generic PCI path invokes the driver's reset_prepare()
callback when provided and disables PCI I/O, memory decoding, and bus
mastering. The CXL path reserves affected HDM ranges exclusively and
blocks IOMMU translations where applicable. It does not offline memory
or revoke mappings; it relies on CXL.mem users retaining conflicting
iomem resources while access remains active.

Changes from v15 [1]:
- Split register discovery and cxl_rwsem preparation out of the HDM cache
  patch. Share decoder register reads, read register pairs low then high,
  and keep cache access and locking in HDM state helpers.
- Dropped Dave Jiang's and Li Ming's Reviewed-by tags from the decoder
  unpacking and cache refresh patches (v15 patches 7 and 8; v16 patches 7
  and 9) because those changes need another review.
- Clarify the 16-way decoder interleave limit and incorporate the review
  comments on decoder helpers and cache refresh.
- Keep a successfully read HDM snapshot if restoring PCI_COMMAND fails,
  while reporting the failure.
- Clarify cache writeback timeout handling and report the effective reset
  timeout. Keep all-ones config-read checks.
- Split cache preparation and state restoration into reusable helpers,
  and simplify range error reporting.
- Allow the test-only region invalidation bypass for CXL reset.
- Explain the scope and duration of the global region lock.
- Reject virtual functions for CXL reset and CXL bus reset.
- Consolidate decoder commit polling, set Lock On Commit before commit,
  and report HDM restore failures at the PCI restore path.
- Move the saved-PCI-state check into the CXL reset preparation helper.
- Move the standalone HDM decoder checks from cxl_test to KUnit. The test
  layout follows Alison's proposed CXL KUnit series [4]; if it lands first,
  these tests can be rebased onto that infrastructure.

HDM caching now requires CXL.cache, CXL.mem, CXL Reset and Reset Memory
Clear capabilities. CXL bus reset state restoration uses that cache.

CXL Reset requires a registered CPU cache clean/invalidate provider
and matching firmware, such as the separate SMCCC provider series [2].
Without that provider, cxl_reset can be advertised while execution returns
-ENOTTY, unless the test-only CXL_REGION_INVALIDATION_TEST bypass is enabled.

The KUnit suite checks HDM range boundaries, zero-size and uncommitted
state, lock and target-type decoding, and 12-way interleave. The unit test
suite passed on an earlier ARM64 test kernel.
Type 2 device reset cycles are also successful with this. The reset test
kernel also included the separate CXL bus cache maintenance patch.

[1] https://lore.kernel.org/linux-cxl/20261011021422.3428136-1-smadhavan@nvidia.com/
[2] https://lore.kernel.org/all/20260910082142.1522865-1-smadhavan@nvidia.com/T/
[3] https://computeexpresslink.org/wp-content/uploads/2026/02/CXL-Specification_rev4p0_ver1p0_2026February26_clean_evalcopy_v2.pdf
[4] https://lore.kernel.org/all/cover.1791949910.git.alison.schofield@intel.com/

Srirangan Madhavan (18):
  cxl: Clarify decoder interleave limit
  cxl: Share CXL port upstream PCI device lookup
  cxl: Move decoder declarations to shared header
  cxl: Embed decoder configuration in a standalone structure
  cxl: Introduce endpoint HDM decoder settings
  cxl: Move HDM decoder helpers to built-in code
  cxl: Share HDM decoder register unpacking
  cxl: Move cxl_rwsem into built-in code
  cxl: Refresh cached PCI HDM decoder settings
  cxl: Build register block helpers into the kernel
  PCI/CXL: Cache endpoint HDM state during PCI enumeration
  PCI/CXL: Add CXL Device Reset sequencing
  cxl: Validate and synchronize HDM ranges around reset
  PCI/CXL: Reject reset with unsafe function scope
  PCI/CXL: Restore CXL state after PCI reset
  PCI/CXL: Expose CXL Reset as a PCI reset method
  PCI/CXL: Restore CXL state after CXL bus reset
  cxl: Add KUnit checks for HDM decoder unpacking

 MAINTAINERS                          |   1 +
 drivers/cxl/.kunitconfig             |   4 +
 drivers/cxl/Kconfig                  |  18 +-
 drivers/cxl/Makefile                 |   1 +
 drivers/cxl/acpi.c                   |  26 +-
 drivers/cxl/core/Makefile            |   2 +-
 drivers/cxl/core/atl.c               |   4 +-
 drivers/cxl/core/core.h              |  15 +
 drivers/cxl/core/hdm.c               | 273 ++++------
 drivers/cxl/core/hdm_regs.c          | 419 ++++++++++++++
 drivers/cxl/core/hdm_state.c         | 408 ++++++++++++++
 drivers/cxl/core/pci.c               |  70 ++-
 drivers/cxl/core/port.c              |  68 ++-
 drivers/cxl/core/region.c            | 102 ++--
 drivers/cxl/core/regs.c              |   9 +
 drivers/cxl/cxl.h                    |  46 +-
 drivers/cxl/pci.c                    |   2 +-
 drivers/cxl/port.c                   |   4 +-
 drivers/cxl/tests/Makefile           |   5 +
 drivers/cxl/tests/hdm_unpack_kunit.c |  90 +++
 drivers/pci/Makefile                 |   1 +
 drivers/pci/bus.c                    |   1 +
 drivers/pci/cxl.c                    | 784 +++++++++++++++++++++++++++
 drivers/pci/pci.c                    |  12 +
 drivers/pci/pci.h                    |  29 +
 drivers/pci/probe.c                  |   1 +
 include/cxl/cxl.h                    |  60 +-
 include/cxl/hdm.h                    | 109 ++++
 include/cxl/pci.h                    |  13 +
 include/linux/pci.h                  |   8 +-
 include/uapi/linux/pci_regs.h        |  14 +
 tools/testing/cxl/Kbuild             |   1 -
 tools/testing/cxl/test/cxl.c         | 158 +++---
 33 files changed, 2337 insertions(+), 421 deletions(-)
 create mode 100644 drivers/cxl/.kunitconfig
 create mode 100644 drivers/cxl/core/hdm_regs.c
 create mode 100644 drivers/cxl/core/hdm_state.c
 create mode 100644 drivers/cxl/tests/Makefile
 create mode 100644 drivers/cxl/tests/hdm_unpack_kunit.c
 create mode 100644 drivers/pci/cxl.c
 create mode 100644 include/cxl/hdm.h


base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
-- 
2.43.0

