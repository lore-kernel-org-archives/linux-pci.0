Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B721CC43;
	Mon,  2 Feb 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048213; cv=fail; b=jA6Bu4dE75nQAgpA3/CkXAOsy24q03w2CTKhWyF5uM5QUCTpHnK1UZeypUaTaNIgcZefXlrmyZ58YQTMG4kFL4p1n4sYqkWYuYrCNOsK7iL43JwlI/mH5GikzYS6w6pQ1LQLrpY5xHeNoRvjIvrPetCYd9Wi4AVcsn0ptSAfNT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048213; c=relaxed/simple;
	bh=MydxU4JtLYtlICqBaWnvHrpe3/MJoCo+h94OQw5GL/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rz1u7Exzs3COjJQk9HyhbAqgJLktvPAESOuvHbMrqIBFmH5ZAs1iXp48zLmrPB6AIQWgMlVlN80egr46xo+62LXqGHr3Vkg6IAZWZ6eYsPNYpL5jdG6zgktetPTUSveFi2bdsg63hNNVbOgRvG5N0TXNkVwBwk+WDr47S8gAvJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DQvqohIs; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DQvqohIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFdBI3iUw9H9chd3Oo6oOBQTIGnooNNSpt057w6swndsqlZTfFRNVAt+ceugw0HPTMMDogQKfkfGLVq5jmMAzSQgyd4CMAx5xnSlE5XZgN2OVytOMtbIXEfMQVi/Xf5dT3fR575SHn7k1cODd/0cpdCDeHx8hPWlqF057lcLyYk/zuav6nomkYtxY8kSqjCksfjh06QupwYSwxinGYYhhItQRmoCWjt+K+GdXkmgrdCLcP57jhIUb6ifY6dYcXnO0R2h368bWUN0YiAk1urxsWEgLCu8jKb1TB64LtUHo/3iicDtL0WlJOnDZ+N5Q44s9jeS57HeClNhp8m7A5ZqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYn0sOBcDh3omWDQa6eCXGF3nDni+XX7WN4bMw6KPyk=;
 b=GnLpxbowjeJWhPlXQsWL17OC8P7QIXuLXNTx95aCsIKxFZKOxrao9n+W9iN/cbyaepL+ig904lq4OjpizQKoz67UF9WKESc2ALOrW6oV8XyPaQxdH+2oi7pGBt8Mn+jo74Ob4gm1yBZHsreR/06bufISNhUMVaPrdEt81H3siQTXE3mOt30Fa/F8Avgk378+ovi75XCQmoGFawEOA6mXNbRii3c1Bhwc7pXdJ/6EPUMutjpA6rhGLYOsmNoHMuw0vU9zE9O5fszW8D/TZGBtDRm4Hbkl28t03QUGQa6Hlxvd09jHAXdFE0a3uuATHh1AVxCJYKqd5M/8jgm7lxQhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYn0sOBcDh3omWDQa6eCXGF3nDni+XX7WN4bMw6KPyk=;
 b=DQvqohIsdPobqsfYxv8U8Pq72qdERnz2U9t3CNrkKcABIUjjQ5Xk+0iATOQjYOnc5aIJAdCztXIkJwmRY2Doi6D5vGPTWI5DoIsFYvr1Hai7gNmLO41s3VCKOE3F+1iM9tf+2UtmrXR/iLyE4NZgjweBC5DytMxz/2v0It0oFWmDUQBW3UaDG7fGMhckGgTgYa7XNFQTP7U7vUoBl4yp+kmodpJoWwrZMH5Q8xnf/Y+Mm3ipFcy82RrHPJoGIfAgPUTYBqW9cERn97tNPMSP2vTJPSSS3xWn/oyiH/JdfSrkZO1DQj01a0Vg+NiYIv33w64cV3W5vA7IxZxLJ+wzAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:03:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:03:25 +0000
Date: Mon, 2 Feb 2026 12:03:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Message-ID: <20260202160324.GT2223369@nvidia.com>
References: <SI2PR01MB439325B4E44D5A39F34A4015DC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393537C4A9D8081FDC6B8EDDC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393537C4A9D8081FDC6B8EDDC9AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: MN2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:208:234::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbe2a1a-960a-4936-b2f1-08de627498d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0z9lz4z9IcapIoqIKChOLqokSDh+RbMzkue8UONlEFsv+BhWnI6F9UraH+gz?=
 =?us-ascii?Q?wBnYlQM6ukD/9Bq3aPN0O4ugFbMmA5apLze3bPYOljxHAItKGqp8zaf7C9Hb?=
 =?us-ascii?Q?umiiEaCxRxeS20GGAfZPTkimxJP7KPQTC/kEhgYQEf8jttw2BA5n5uhEPo0+?=
 =?us-ascii?Q?M4UEpzKcPhdxiuX1WK73pT60u1MLRcdpiwU876YumlLDI0BQA7YJPdebIxLw?=
 =?us-ascii?Q?nPuDjaC2PoXCf9BKA/IztavJgKmLowFLGOCzhekS2GmYfms6iq3LoXivJCCG?=
 =?us-ascii?Q?U50PvTFTVqPxEVnXqVT8BTkTJ1/hBnazg6Y23CdY0ytyQmWxcfZGxYU0z5EW?=
 =?us-ascii?Q?zPy3dpkKlDgIte7FUIur7OdL6kJ2MGRarM6XTdbIcM4hXro6sdqnG8j7CV0z?=
 =?us-ascii?Q?LMqRvnFxRuXaamk2i2dmrFOciBXD8U5B1IoLyxqYxFZNVhY9ql9IAABAKML2?=
 =?us-ascii?Q?vdCXygkOKPu+/Y3EDKAEf6f7Jv5pnLqTFSkwoTkJgDkIKzNXxdq3FbulwYCs?=
 =?us-ascii?Q?2r6Fwp6xuZJCrpxEjTHd/cRAQZTh2CfEB2FX/5q+OxJdaS659QNqVDoTlMoX?=
 =?us-ascii?Q?h2WR1Z8+iVdLfyMPPmtbIvOYWefOiyWCLjA95i0l7HPVXwgbaQQq1jh2/hg8?=
 =?us-ascii?Q?w9scMDH/lZ2qSuEFULfy9fVbLYr3cuM6uQ64Pzhzp8J5BhYKZUsEuXWKclPL?=
 =?us-ascii?Q?SWAT1/L9/FQOtoDMgAX7D510cN9Lw8Li5r7BR+nEfi3QScDarwMvT+UzA72o?=
 =?us-ascii?Q?Ju1V/1jio2rxJvl6NBHNiXMt0/O7wJTfLm599u1imkSVWn9pHvFz5hVrdx0x?=
 =?us-ascii?Q?M68foE0UKN4U78eIyIDHilWePwdTLOIx6NWb/ykjHWFMOECWGz1l45P19UCH?=
 =?us-ascii?Q?95/H8JLxgM42/YkxBPfAVBMDWpPL9lQ/rW3aap+zC53nkBOuulNMdYtDE+H1?=
 =?us-ascii?Q?61I67X+qgl5y4UygwFh5P0e20BbEEY8IP50AwfbpfzXpK+feDq+MWisCHFuY?=
 =?us-ascii?Q?lF3L4EBrCeg7MnnUXYSCLjfWjWH2qbrQ0K3T3gwrmN9bD67OXQCxUxXvd7R7?=
 =?us-ascii?Q?M0vWW5qk7bk6sjKZqprgAKCXBI9tC913N6853W9I23fUMfWstuaLziWs0eYq?=
 =?us-ascii?Q?eF9yyf3CWCFjHeugf8KBQEWQ6tzQYilNNNWXxUnH2TVcNUffbduPBmI7JSNl?=
 =?us-ascii?Q?lqrxAtZFEYahrK+ic6KBKiIP97dqbx8hUkQWEzvAGJVBchnil8ibvRP9Pra1?=
 =?us-ascii?Q?w/k6PdHgo+lyf/VEaX6mQcSGWPl5B75rcXJF3E+aZbczssii9OH67vkk8fP8?=
 =?us-ascii?Q?C4z2rB3ONytLxZGNnFN+NcrLxHgTb5yQ4h6mDApPbZSsnOE3ilYbmcKmDMi2?=
 =?us-ascii?Q?MYFQOX3iDxDLgoUhjFFb3YxY/zqfIESTP+93S7ZaUN8+C/4YBglwx3YifY+y?=
 =?us-ascii?Q?IP38YP4mxPAIQ8V6XRj/dSHTJFBWBWu+axcy5o7Iaj9gVBkKKBMdlYyBGNes?=
 =?us-ascii?Q?qmbI1r54kOC/856GyKVO3/5TOm3CAI1biGC91l5z1/sQ2I2yVW2jV8ltGfhg?=
 =?us-ascii?Q?d0qs0dxicJqeI5N0UQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQDJ9by0vsiM/BbeXDBSS2H02eo0BoKd2k3CVe6H2JSuXpYBMcNaQMR9OOQm?=
 =?us-ascii?Q?0RW4g2njDP3JqFAgBG6F2yLdWefd4twzivQaT6O6zqGB6VAoPFYG6MufRy0q?=
 =?us-ascii?Q?8sfOiwQvtb4VlLoO7CVRjwCYKEHThxIz4ewrT9tgbQIXwmxQjl4oBgkcxRvL?=
 =?us-ascii?Q?DTLyUYaV9uQ+RDvdOd2aPGDXgP+D7H5/T7stoen1kLuPkkLqcf4u4PLJWU/p?=
 =?us-ascii?Q?R0KCXqoYm6pun/PEnLj91tYCvx76DA3MbK5d3iIHwcMF0TGuha80QvOLj6Zq?=
 =?us-ascii?Q?2kdXXZL3vN5km3cT15y6TkjYbU+3k20ZuquUodwV41QHBLKee/Llvnumwqba?=
 =?us-ascii?Q?eML/EHlZC8IyolB+Lw+cfFzlsTmZpcb9K6N0MiSgu/aAkZIEnTVTDM8y6r63?=
 =?us-ascii?Q?5yyp6usrqafGLImQu7KV7CsOnlnu/19e53utCOKHBB3wB8hGraNTksHyhVoC?=
 =?us-ascii?Q?DChhJ4P/L0YigdaenVEqRxWnSmtWKB9wg6v1V71qYpXSi19BAuVCWaFlUzTF?=
 =?us-ascii?Q?m7jXwyEpef67KiFGv3/pcLR3FQ1M4m30/Ws9g5KRt9cyOpEbYwidClNJkWX5?=
 =?us-ascii?Q?BmxTR8eH0zq36r54PoPUGII4ZhZwncBJFgtCA1DEbT2q0nTiJc/lziFF0iWU?=
 =?us-ascii?Q?dPan9RS8QCS27GTx0ToTjiZh+pn223LMridCt/RkyN6V7c/LP+N8uzgiyCcB?=
 =?us-ascii?Q?s6At+xgkLf0eygrIPNes2/7JJVbVjsfeIBjHUBwbIvgCyqH37kNISagp3RKI?=
 =?us-ascii?Q?qvkydD/Td3vh4AboquMLcWq+hG0oH0MtsBScXPJCi1dy6jFwLCx5j34285P/?=
 =?us-ascii?Q?q+gMLXZJtHCGuyxDm6m3QOYQPy7Q9Ls+Rh8nkulAmjsoCMSsWT4fEzBMQg4k?=
 =?us-ascii?Q?9UOf6t/hhDCc7ZVL4wwtwfe++DUrjusuEIDgMCwVSbEFsSEzw9bjJmCnwWdX?=
 =?us-ascii?Q?rR49+7oatDntQXfmErKNvUh5Qnk/g+UC+gHU3wrZ29TJyBcWcEI59WJ0puk5?=
 =?us-ascii?Q?0v5Pd20U3KeukApEv88tNaEtIQ36MYDfWhvyRXBRX/PN2B2Ak8jcPe2hDrsa?=
 =?us-ascii?Q?vsbPnl0/CP1VkM4Ju3qoFzHUxb9ifNiJPh7zJZ5pr8MvQxk1I/aiQQVgjwp0?=
 =?us-ascii?Q?UZASsEDP17Xne6+VzWNMF8rZgvWcATg6/Jgzd8tIkvrDZO/cExeaO9KuY6/8?=
 =?us-ascii?Q?BduOaovNaLRqgg3zs52gZf0TBjBlS62x/RWbS+6RUWJLVQEZ5dWBFJlfuGJQ?=
 =?us-ascii?Q?RktVViqE976/GtNz/9jaqhgIgzMXlyxhzRxQ7n0l1LYuRpFCf88xjocetC/K?=
 =?us-ascii?Q?ITqneIgdBSC6/PMxP668Z2hS0UmzVIhwSuRFnHWtA5nt+BUK+O7HW/DBR6pk?=
 =?us-ascii?Q?rO7ul8vmXGPrAw7fyotfvnN1luqvqQQ0q885KSd751Emqj0pbrCrGjegc3p4?=
 =?us-ascii?Q?6GdXcgGYEWHLnS08AHJ2InO015jmQFArwOx087S+Dd2joQHfhLs5PeWPXJum?=
 =?us-ascii?Q?n1R9Oek4KaNqkLFH1sgRmE5exgVAXPCLE/y94YqO5PfyEIe6GVd7ThJdu5U+?=
 =?us-ascii?Q?4f0+wnyc8t2wIGI84pVpM8f/p/iItIf8JwxQmy4GoSMNjLBYZBjAoXuKJuFC?=
 =?us-ascii?Q?tLwcQ1X5R0VufT8G8JmjgqRpjUVh10ReBxE+gOv8PjpEMr5rerV+s488I6rX?=
 =?us-ascii?Q?DI0PE6TEmvMAbCVkEDNeFz81etpKUOBmzV9bJQSzZaRuyuiW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbe2a1a-960a-4936-b2f1-08de627498d4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:03:25.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vexEbeQWrFqsduvnYUT1VOMxKbdXkv3KN4/5hZCregOJJ59XIvp1a1gKzMxw2Mza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941

On Mon, Feb 02, 2026 at 07:33:35PM +0800, Wei Wang wrote:
> +static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
> +{
> +	struct pci_dev *usp_pdev = pci_upstream_bridge(pdev);
> +	u16 mask = PCI_ACS_DMAC_RB | PCI_ACS_DMAC_RR;
> +
> +	/*
> +	 * For ACS DSP/USP Memory Target Access Control, either Request
> +	 * Redirect or Request Blocking must be enabled to enforce isolation.
> +	 * According to PCIe spec 7.0, the DSP Memory Target Access is
> +	 * applicable to both Root Ports and Switch Upstream Ports that have
> +	 * applicable Memory BAR space to protect. So if the device does not
> +	 * have a Memory BAR, it skips the check.
> +	 */
> +	if (pci_dev_has_memory_bars(pdev) &&
> +	    (ctrl & mask) != PCI_ACS_DMAC_RB &&
> +	    (ctrl & mask) != PCI_ACS_DMAC_RR)
> +		return false;
> +
> +	mask = PCI_ACS_UMAC_RB | PCI_ACS_UMAC_RR;
> +	/*
> +	 * The USP Memory Target Access is only applicable to downstream ports
> +	 * that have applicable Memory BAR space in the Switch Upstream Port to
> +	 * protect. Root Ports, which have usp_pdev set to NULL, will skip the
> +	 * check.
> +	 */
> +	if (usp_pdev && pci_dev_has_memory_bars(usp_pdev) &&
> +	    (ctrl & mask) != PCI_ACS_UMAC_RB &&
> +	    (ctrl & mask) != PCI_ACS_UMAC_RR)
> +		return false;

I'm not sure about using this logic to detect a USP, it would be
better to drive it off PCI_EXP_TYPE_DOWNSTREAM

Everything else looks OK though

Jason
