Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794809869;
	b=KShgD6fNkhwBuwiW0GzHzMFUTKFCm3Z6Ne8lzy/8n2aPty3uJG9QYYKeTR9ZfqHHS3Ay
	 9Z0sj1F7MCdF+dGnDd0tGysRsR1yL+qbhZEGSM+JEMyGnMCFecDWyxtKVGtg3hfOgVgWm
	 2by0o1ZSLswE7c6/Ehj/WKAbRFmNCYWT6bAk8xc6AJZuNcIFYsk+SM8hHSrhA0pMXNpvP
	 wpOLt1u6Y3UDULJEhXjli7jEavaKrbxUXfmJTWIBa0Dh2gO0ZXkDKGwLIn0PWaAqIlwxc
	 JaJ6iGSU/ESpYFKMgCsTM8AuHTLFtd4cC1uaCynfHlveYZ/xOsHTVOSIE0AEYEOKRGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809869;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=f/i5hHyRVzRJCR2elqW0hl0/nLysRzz+vRs6oU5wSVI=;
	b=GebuL7gwFYnpmj1MjNpsAvsNisFQLQuNjJ3jr53qyqBvcU0jhTOSjnJ/9gvjXkGw4ZaH
	 1aFL0NG7dYP7twdBx84PCZP6YqJ8QIE8R1RtupXKpQUCzrCpqQUq4xl0ymvyWgh0gGblN
	 gVW6Q0Tvf2BpKJLdcEapzZvkZrhH6Lm5884jzszbLKs/Yvl2HHRX/haxKbUrj3HywWa5t
	 GRE2LuB5O5nRYxoFG3KzRggzlzTMQDYbrDKxmnkbqwvZvyejmY6w5HimeLwvuCu2Teg7p
	 0MKXhgaxpOzCjPAkkXTP10IMBBhxwkoilgiJH1YAAdgrSfEh1Hk8Bxc1MWvJru+uJGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fjuilKCf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.64
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC7606A323;
	Mon, 16 Nov 2026 06:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBC7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fjuilKCf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvlVxRBUFQZcaTkZBRjpPPYbYlX/uewHWebl/xqJjtdHT4LZckkYVCU/gIHz8+HIJ2K5qiZPcfUPA0+OjC7hrFzWNM8bMdHtrN1x5yvDBMiy6YBG455yvqSS52dj58QozP9r8/2krT93X6Vk+KbzxTizowCmkVjl5otj+0dbYJh4Q1V/TDzcwLBzHSYtD+ErL0tBhDoZpN9assCiSjGAynAxOWPyrESuD/RgBI8WY2XoeT7WAtP9RQUIqO6pyfOUhzXzqwsNMMyFWFgL1hh9k8EnZ7yJi25DNFTzePSAsGEJY8cM4niWMrJlY8N0YGtApcDvs96nLRkI1jAxxx/z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/i5hHyRVzRJCR2elqW0hl0/nLysRzz+vRs6oU5wSVI=;
 b=b7Ns2T1ZGP4Tl7mkH/4A9EJLXppRBP+M0PyCjdDd7l7Q4mdG82albeLLWtReBdgSn2hZU+Xhmy01Kkzal7o8euVIOfBbiQgtgdLm3lBsmn2jfvaEJkLAo2m5rOdUIyDGcHzYvjKXUr1ahq/0HE2YZ17UpMM+D+aPDGBaeRjtpKMsdbDsReaEEIf13yqfudlYZNV2ODIMYdzZYZtjH+WdbeHNz2mtCSs4FEQpk6CuQJzNbJRQqwhSi2v6GglhcGBNYhKyAEiZ3klvT26pxnjij76ln6+d8bdYlaihLKt7Md8oJm9C+65B0+4T7gBH8OKVNexUXxNWc714BIwhx6q9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/i5hHyRVzRJCR2elqW0hl0/nLysRzz+vRs6oU5wSVI=;
 b=fjuilKCfpZBEImxOjHGa9JFya1PF/QSm4FA13Z6KiG61l5A1V3CP8KDzgN4p1R/5VQh15VanBmXnv6wiu+SU1G6V9iNG5ApjGPdreQ1ZNBwRUabwM4TA4fgkrv3x0DroddZwSXldUMikUBcIXo/j8KqgbqsJEXYoMLox4UBrHIseS121RQIISa1UVREJA7XBVZS+GqOZHpVL7NtiIwdNTE5BT/RUNNU6/HvcAhYCrlA+ZetnwiZLHjoaSWpsGf8vLTAL/1rPGkWEVHgfp+l9XNRBZL7nVMpca0V5URq+K0FXL7yywOa7XdExWCT8qAw9FWIbK4bNp0mpb4iJGslP1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 06:17:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 06:17:44 +0000
Date: Mon, 16 Nov 2026 14:17:36 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: bhelgaas@google.com, dave@stgolabs.net, jic23@kernel.org, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	benjamin.cheatham@amd.com, iweiny@kernel.org, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	tglx@kernel.org, wangruikang@iscas.ac.cn, vidyas@nvidia.com, 
	lihaoxiang@isrc.iscas.ac.cn, xiangzao@linux.alibaba.com, shawn.lin@rock-chips.com, 
	18255117159@163.com
Subject: Re: [PATCH v2 1/2] PCI/MSI: Skip MSI-X restoration when
 configuration is inaccessible
Message-ID: <avqfAyIy7ytRBe8b@MWDK4CY14F>
References: <20261106111829.55823-1-icheng@nvidia.com>
 <20261106111829.55823-2-icheng@nvidia.com>
 <0a003a9e-573b-4c4d-b0a7-f88bc11818f4@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a003a9e-573b-4c4d-b0a7-f88bc11818f4@linux.ibm.com>
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: 453881dc-0af4-4a98-b446-08df43a95363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/TxgSwfMrHs3NGNkhkWbDE02qx9kmgM7jIVw0U7kXMejl+K1+HZiCuFfOBFXW9j4U9ClQfDj9l41BRm7UjmI1LQ2s9UBGTTNIiSnI8sKoG0VDOF4khm5+aMtCKtGZ9orWNTCdhIiAq6K/lf4msgnKTG3KDggrmi09BGSpTHMWpMw/nC8um4B4Zb7qWKg0vxFESDwOrDzAS3tvl9olgqkOm2jSTl+HXdjvKButEs3n1xD9MnBmQQc/n5jzwgQHzfteYRLRpMwYG2hRm7Rs0Ko1J4/uGcJeJsu8UYuj0ztpP0Hqz3Hcox1jUi+ScVmPz/190yz8oqdbAkyevNWRXt2AZm/TPt7Z+SK5SaPzxB5ASvTB/mqaBg5wJnr5wuLDabB+yR0GOdlsl1ibUFduhjDPLSafdvjeDO4JPhskRBKwSS1SRD1wjhiRhD2YxiTacPJ5M7BakpEjqcIDNPn7q2On60DNEosMHThVLzx0MgwqpPj5DB//0xnyT0hrit38rTOd21pzuBiekxTgzx6oXJMmbhtHas1ZEs7tKyUIsq9OQnHyLdUVvP07orkgudbKW0d7OTJCg2I0m32WFwnDE30SDdhpc1495BTNdasgGa3/q34If0dTp3wpBC1XgY1l2wnd3XYQzYhAGTY70Khn6oLiGdLnwVs/lclfO83cSwGans=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xtvS4KGU9dBmAAbVZZHr64mMhtT97UgDsFm9SIBFWnkaMbITs+ocbbBpHTsU?=
 =?us-ascii?Q?8Yz6CcWNCFGEPonIR+zfj5HuOizcEMGdJdQNdGCtu9KHCMMTSTT7SI53RGIh?=
 =?us-ascii?Q?WV1+jena8LlEFKo+lpDH6hHGlfbQdbB5QJtAkFBIYVdCEYeia2XPKF6qxxz7?=
 =?us-ascii?Q?hIQPxuXtoNs8HjaZmoOWC7o9FraBPwwBbBh6nmCFQguTuP1T1iZw5lKmm+c+?=
 =?us-ascii?Q?u707z8qLbeOShmSrBdip2m8SQ8DFhNNVHLkA+gPau6tvZ8AWbPisoXsJ6PUU?=
 =?us-ascii?Q?MYhX7WpRc4WipQkkqPUUI2BR/ZYBbLjjUEsHCTKM6iLy3Ggbog5fRqdELl0m?=
 =?us-ascii?Q?CdcVYGlviwZC+tsFr2GQQ4IYsl95w+YpmSU5altwVQEMxCfopg/58GfX6o0Q?=
 =?us-ascii?Q?ImJW6VNWLDmjBosSSAST3c5fdJySckG3xAnltjNCC4CzLZFba7CIF/S3oCrn?=
 =?us-ascii?Q?GaNfqVBXNOwikTeLNF9wMyi0MmWB5RX9yb9sWcYHwYzz8Cuu7P2g6lN2ti2R?=
 =?us-ascii?Q?MU+FED7ZVKYIdm6Xx6fbDIRf9dYwaa/zhhPF2e8Dl4WhRO1EjIZhEWoED4oi?=
 =?us-ascii?Q?ZF5GS4K4YwJyMBK/0h7uFkAjJB2k4RYvzXtZeJqGQB7Gv9b7r4ly5WdUOZSZ?=
 =?us-ascii?Q?8B1AsoqX1ExbmC0o9KnYRrMPCbEn4DaifbwfBfm1iH/v1465d3bKAB4Q5oLS?=
 =?us-ascii?Q?lkTg3+wY+0BB/pIzBzzlrxB/RzWNPMHs+BESqcWu8yeq9gf6r5z3gnQsFDMM?=
 =?us-ascii?Q?XBQN9jURacHS9YpFL41KSB2mo7i/QRsiS6z9ljYI7EVxTgIIrHUGCCR4CHcw?=
 =?us-ascii?Q?KFPv6bV9NiSubEfZxkOpK0Zxfl9EWyqksZGFZYktUX5Yf/l3UcWjcup/TISk?=
 =?us-ascii?Q?pVBfg4C0BfkODCyJjnp6XerBAO3CLsDKjctm4t8kHkiBRjLDyaIYfj27mMXk?=
 =?us-ascii?Q?emurkK/4SVlUCJl8TyeQoJiA+/oR8++Pxy6NEajkBcnXbOgqMlYJ/dO1sHWv?=
 =?us-ascii?Q?1A61zbe0n1W54Rv1TuJi5dHptx5H5OkHMLz4iua2kv7yS1K6THpz5qFRv5zw?=
 =?us-ascii?Q?dqL4ovpwZGULEYxUvq7uBRGTtak+DQsGq2futkO7kMKw0kuDjHIzBqSz9DoC?=
 =?us-ascii?Q?zKpO17GaVRYKhFgc+T0IGWK/5ocnGndObEwQfKDajzASKgu+nz3WHqTy9kyW?=
 =?us-ascii?Q?GV1+oOVRq4SU2R96u3+BpXNC53dighO+ZEs2aC5mGU4uTmuVLJJMb+Wdx+eX?=
 =?us-ascii?Q?3Mb6hiM+yPxpRsmsAMjVId3B0nhb2qysPIKcsNkjZxxlLPeEyhXGFArr/5YC?=
 =?us-ascii?Q?Tr06mBKqyplQ+Ncg63ghcV+eE/YhSrzx1JQ6xhZRpUpHKKoMnww4aqOO/fg6?=
 =?us-ascii?Q?vaC8fx6uIji8yx9AuChxxVqA1VFVIZetDHRA3TaiPiVoji2k8q8mE7dpol9w?=
 =?us-ascii?Q?IqmZuWLutuicsXijIPueR6F5OtHNV5NbW36K2TImv3ZgDCBoTKY/9PDEON9m?=
 =?us-ascii?Q?LpWkt9IISehZauNAVV80cRIL6r1p/HMUrTaw/03x2SG6VOnLHMQs2Ppo6zaj?=
 =?us-ascii?Q?fD5MoQywIngOkoWqRE/PySwMl4DYrHBslOz4WOe+G9z1zibP4lbSFKeNw194?=
 =?us-ascii?Q?m+h9HV/PHcG7hG/lIkZGmlmRz6gYQMDn6Cw6RZrxyLd7W9WS8Co22AQFCEEM?=
 =?us-ascii?Q?mWRNmClFuQhxeWg0iqbUZMS4cw1HyI75W9lziRFDGA1LycncOLy7nkZ7Mozv?=
 =?us-ascii?Q?36VAq0Dqgw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453881dc-0af4-4a98-b446-08df43a95363
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 06:17:44.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eti//OM7nd5/dHQSzs1w3tAJPeW4YzejoEHzn9pkyULt1IXPDs0xJyL0flJvZGfATBKfOEBYMXj1Q8ses1aF5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48

On Fri, Nov 06, 2026 at 10:30:50AM +0800, Farhan Ali wrote:
> 
> On 11/6/2026 3:18 AM, Richard Cheng wrote:
> > PCI state restoration runs even when a reset fails. If the device's
> > configuration space remains inaccessible, MSI-X restoration can issue
> > table MMIO accesses that trigger additional errors, including DPC
> > containment.
> > 
> > Check the existing PCI Command register read and skip MSI-X restoration
> > if it fails or returns all ones. Preserve the existing handling of a
> > valid Command register with Memory Space Enable clear, which temporarily
> > enables memory decoding while restoring the MSI-X table.
> > 
> > Limit the change to MSI-X restoration. Leave other PCI state
> > restoration, driver reset callbacks, and reset return values unchanged.
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> 
> Just curious, why are we limiting this to only MSI-X and not MSI? I think
> MSI restoration will fail as well since the config space is not accessible.
>

Hi Farhan,

The orginal intention was to keep the change small, and the failure I hit
was DPC triggered by the MSI-X table writes, which are MMIO, I didn't
expect MSI to cause the same error since it's programmed entirely in
config space, so I left it alone.

But I think you're right, the MSI restoration is equally pointless when
config space is inaccessible, and it ends up writing back values derived
from all-ones reads. I'll cover both MSI and MSI-X in v3.

 
> > ---
> >   drivers/pci/msi/msi.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 8a0133a6a286..37de31f4cfb6 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -887,7 +887,11 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> >   	 * Since the MSI-X Table and PBA are in Memory Space, enable it
> >   	 * while restoring them.
> >   	 */
> > -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > +	if (pci_read_config_word(dev, PCI_COMMAND, &cmd) ||
> > +	    PCI_POSSIBLE_ERROR(cmd)) {
> > +		pci_warn(dev, "Device config space inaccessible; unable to restore MSI-X state\n");
> > +		return;
> > +	}
> 
> We have a helper function pci_dev_config_accessible() that does the same
> check, so might be appropriate to use (of course we would have to make the
> function global rather than static).
> 

Agree, I'll make it non-static in v3.

> And maybe the check should be moved up before any config space access in
> this function?
> 
> Thanks
> 
> Farhan
> 

Yes, will do, this will be covered in v3.

Thanks for the review.

Best regards,
Richard Cheng.

> 
> >   	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> >   	write_msg = arch_restore_msi_irqs(dev);
