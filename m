Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD26429CF2;
	Tue,  4 Aug 2026 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830189; cv=fail; b=EKnrd3LNzbgqvXekXBrGKn3rmoS924RNkTNF1Wvk+Rv7IFQQaS9+fqwGoa8haAb8HwKkNm/tjj4Gs88OErhSzPkITZzu+vg2zEMqAYkPy4WsWXqMDRmhF0ESTTPfu4cxjathN6xoWYwjzj+5SjJzP9YzwH4E30//aFDRdkwdFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830189; c=relaxed/simple;
	bh=Pt9gABvhkiq3schQz0Ww2U7gS+ygCChRUqqb7eUVd7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jLLamjNsJyYvPuX6YCQBFpwCGVUf4p2EJTm6HJVrQb5pUVOL/eXFIA2uy/WI8/1f23zO93i4QvseOHDzf04MmU9aZpnpHykr3db3YolDNLVqgQXu5uW4GojvYUkfXNuqk7etlrC+tphsZF7B3+6N5hlXgeB+SICyWXl7wjavhLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qxSxZsDP; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qxSxZsDP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+AcnOnqfU61zif30scURJwwzpw8Euazc3hr90/w67dFF3oZsljMqDRpRCGbOV8BZqCNJ7StjkMutJKm56N2JQrpoX/kBgqQcmXk40PrsaSpcwRAs3BCZfmXwaGkStnnXCeghtvgVNKjsBKxpE2QD7d/CkzGETgTfBEOKpu/KU7lIZmZNBGvlct+mmqpsumWM22SFhOCcv50xFtLBjalEHX7SlsP0F6VIjROEqaWSE7DgAGC4zHgrwBHTt4p/pdZar87+Qf+Op9AIcMsHC7EPPgByD5qjWiQ/1YGSEmW6Sc13z3Xomj6Ew+gRgGCyI6vE6kK4rV0JUTqr0cdJiBCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsB2pAIxQhrNwgXmy0TwCYXbOmZK/QG0/Coq2H+lSw4=;
 b=YJ+Dou8PLN3FG6eaw5UghMcHVqben7CHy+99mc+ohFEnHmhJ8GTGVQIpqZohnq7CVKwG5b6B+oUUaXLpysXu4s0pwVcd5inhxpxsWt13T6MINAUOEFP5XEl122hIh3x4WWMcjiTnkpUZux7PCvhLjl3ESRXeTlhl4vakaZxd8eLUpkYZ4tCOwyocVSMSwtkIrybNKNT1uk9Zdz5v2Vf92zaEC4uJlfTXJ4xcTMrqwPNoxI60VjFE71SnhinvsCysU7Pv50wxnhYgrnqQaD9zOzDPmbuxAToiGF0wppiAgF4qE74mdk5SP5XMdIo6me/AwTHd+2ztThx+4O/MpCoo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsB2pAIxQhrNwgXmy0TwCYXbOmZK/QG0/Coq2H+lSw4=;
 b=qxSxZsDPIMj6nIEwiOqSANoW1Co+QS4xqSUCACLSfro+8sKeu64v+ECZyQyVDLIe6yQtqSFVJhxwiz9YppWi45MspcrFGVseB2eWeQQgVFtYrclOY0iAV3e1habYC66K2eEYd9yHcXCqTXPddGL6pDxbigXyWCFWfqM4fHWFX5qQDKUxWmiWXI1GtyH9MjoXfh8s1aa+Ln4whNggkV4S/oy7rtL7bcsuzVSfaQiWE48nxxEgCbM/xmx6CnYBh2lTLiUbl2Cw+3vnrwOQHVjzhUq9zT5GacWLgrKq42FhtPAKuG9HNNRg/+PNE/i7/h+/no2jfF2XUWXW7CXFeCpW3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 07:56:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 07:56:20 +0000
Date: Tue, 4 Aug 2026 15:56:13 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Ben Cheatham <Benjamin.Cheatham@amd.com>, Robert Richter <rrichter@amd.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v19 12/14] cxl: Add port and dport identifiers to CXL AER
 trace events
Message-ID: <anGYFW9WC40gaAjp@MWDK4CY14F>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-13-terry.bowman@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803221810.3685703-13-terry.bowman@amd.com>
X-ClientProxiedBy: TPYP295CA0046.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c4e057-7751-45f5-940a-08def1fdde23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ND2L1rWiI3eExjZcXEZmamlqNbbYvpbNXjmXxz60TT1K5MF0JPXnEXporax1AJ9aBAxFAo5G52qDXaT7VZrWif1QYup5O3c7CAja4FSoMfI9mOziAEejN9vCFnwTpGqzjO9e6ljYF6vvO60TqkOcHgChVT8ZnjnYHJ8RfPkEaShJ/LUiHQ7y2c5b7opequwiWA9Ellw/16UFq7eMsMA0w4Ni1xVecoURcWyO2jjT4Z1W75ujVOoyAXLdCrxjEzJ2BEj3zZiyFxs7KGudZgoaFEBPR9oCOppgaZczFs4Idh2p9Y59ifZBnA5tQhrq8ANASSydtYWNenb8Zb0YOOEQOOHQQP7kt369nUgSWKRGL89BDa0oYfB23JGp3HwTI/fHlZkcU+ZbCMKHcdwFOyKi38eXgD+2NukY6Hp9lmuvP7+DRm/afuwOSXJTotMOuNSK/GYk0TZ+666F/1WdnT4tG8ZlKfTRO3fILpwP3h5tIG47LrLhV3nMVkiBkhDw4F0Unhwd5JhQS2uNgVo0iaBtMZnb1T1MFlYPQqJ7ubjgZzJbPjN0M/bTOzW1iqrEnBcQ+svoKk+T413YCTg9u/eQz7a/vhbZyA2x9Sure7T27+OJOs4SMFRx9d5cFlI0jotlmCALxz1gUpRCWEB8x9Rres7yiKoA8MpqXhBnPrMOzZs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Au77nwY9HV7nNaVmRp7MK3gT7hJyFVMZI/mClSD+NXdSpXQMPh02km4yB5+P?=
 =?us-ascii?Q?B0doSmhVSbdwtMT3GPC7JgLAXpn6Q3FlzBciPtUjMnzqRNI+ixMbiHJD02H/?=
 =?us-ascii?Q?ailOLOLGIyCBr6UX6fSHwrXcee8DN5J7iEqg987STgZDiadxh701Suua26e0?=
 =?us-ascii?Q?bkZORurWfiq7Cql3efzQI6L245qiapQRqfGeIAkI/uhNXDRF1N9cyODIR0Sl?=
 =?us-ascii?Q?tZ2lk+HK1m/pPObFrsGXmZC+T9hmsw0g4QsAwZgn/6ZsooEN679Im1cWIMgZ?=
 =?us-ascii?Q?YVYooL0nfEbfEckZoRViWCS3udWk1MuQAg0rtjmjADy92QzAmFT+S44nMz1G?=
 =?us-ascii?Q?cKT9XapmHl76zcPe2/ZS4KGUYdBDWLzBUkq9w7epMjYXlrjrylvfwfolwM5M?=
 =?us-ascii?Q?G7VRT7HqIgxBINxekcbB+wghglXVxWRA+XEQI+ksleeny4/kTh3thwwMXHMn?=
 =?us-ascii?Q?kCm3ThM5a0a73JD1UABGlkXcJc2h947lxLs+dSMLtH61BSyuiH4upGIg5bbY?=
 =?us-ascii?Q?XENhxm35y4DjIg2/l0Bh8rpmpBLbar9fI4Hu72YcxcM/k9Efgvy9G7xu3Wvw?=
 =?us-ascii?Q?Tf7H3lxSII1jpitH3zki56v6AtOBv+/jt+B3GuHmgGpRVms2IBv6TlrW0dZ7?=
 =?us-ascii?Q?mW36BYpHEceeZV3b4NR/lDSnrgRgDhGTkW0CF9IBxBadM98tT/7P00Kl2PnD?=
 =?us-ascii?Q?9903gvZavw22zyYTDvmtC4vJvKMwLHBujXmuDMQgqb1byfsO+RloVuoi5aAz?=
 =?us-ascii?Q?ssbSgB+MUY5RNBUgztYFmJIFv/GRVS+Oach60ypd4E33RUD2KI+22qMzS7/R?=
 =?us-ascii?Q?80mg+qt4qLSsLa6R7SEBljizLT71J5abVbbbLuZUh19Pkq03aPBlfIuWV5jb?=
 =?us-ascii?Q?VR4qPsP9djWbmKN3Zeol+XNtVhKgcDj3FSHlZn1PvgPAydSqL/RG7ig3qiaj?=
 =?us-ascii?Q?Il5nauBSvhcrI7BTAuY0URVBKnIvijiMjkhS6LcJJuJwqFpiaUeXip9SfEav?=
 =?us-ascii?Q?f05IOmjGNF0na/6yE8Tef2ijHQ78gNHNjuZ4UWNjtx46t3IhY6OPUH4WoA2H?=
 =?us-ascii?Q?YBa+FMIuYvUQWla4jDhtg6BuLaGmE6JRxs1qg0mWr5MK8j57zmlDENfsBbRs?=
 =?us-ascii?Q?Eic9t4XbuxH8sVYJRRosxNDPwmHqizREQ3kPNgrmPmd+g30dHoxqmwzbfGGh?=
 =?us-ascii?Q?GbrUvLqj+ntXma+MRF/fUTu7J7wBhXZlguymrdPepsCo2/JS11ZmbXVNvVKM?=
 =?us-ascii?Q?O2Jwxvf8JQMjUJuw4mW3XkfGXnaYhiOvkXtJ6EbIg+EUPf06qbxgP/zbosQp?=
 =?us-ascii?Q?aw7TeRyPFgy+oyzwvtsZTIBP7SiyVUe0rwOYATIHu8JkJtlsDBS+KkjIVifh?=
 =?us-ascii?Q?cG+yJ5GLp95ftbVobIAxDWMpanOvJmChmJkwG2ENAR1xjfNuMAnREtxkirH0?=
 =?us-ascii?Q?ITUHuU+fEcwRyO2IZIMaxTVjrLc8TEXPs7UdMy2HOpvN0c98PkTK0vTp/jPT?=
 =?us-ascii?Q?UacMvYm1nlyBieCxdi1KFPO4aF3PIT0vz60+ifqECdyc+vPnAeYWku21Grsi?=
 =?us-ascii?Q?4cq4EbPFcWfmu3869wB/7jWoF4Ae4/pIbsSPN6YEerOr20FPCWFXXBoYZAOT?=
 =?us-ascii?Q?JEoeGnP3aBtWySPkholvIaCrdLkBIWebjmNMMQulaUg9ruohjNegd8pRnAgd?=
 =?us-ascii?Q?kX5E3qyAp+KUtNzZIaX85PZatI3QgJ9uHuM46bRIAnXOGI3y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c4e057-7751-45f5-940a-08def1fdde23
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:56:20.5645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUxWHL3UKv8uSeFf4VBlwWyby7rgax/QXwdhOhdmpdjI4j13+0T9hT6gyXU1QUtDBbG9dZfq3flNp/gZ4zIOgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

On Mon, Aug 03, 2026 at 05:18:08PM +0800, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
> trace events instead of a plain struct device * derived at the
> caller. The trace event helpers then derive the right strings for
> Endpoints, Switch Ports, Root Ports, and RCH Downstream Ports
> consistently across the CPER and native AER paths.
> 
> The unified cxl_aer_* events keep "memdev" as the legacy field
> (endpoint events populate it with the memdev name; non-endpoint
> events emit memdev="") and add new "port" and "dport" string fields
> populated for all CXL device classes. Updated userspace can key
> off "port" and "dport" without a parallel set of events.
> 
> Remove the separate cxl_port_aer_uncorrectable_error and
> cxl_port_aer_correctable_error trace events. All CXL AER events now
> use the unified cxl_aer_* events with port and dport fields.
> 
> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
> the unified trace helpers, replacing the per-port-type branching and
> bus_find_device() memdev lookup.
> 
> The TP_printk format string places "port=%s dport=%s" between
> "memdev=%s" and "host=%s", changing the text-mode field order from
> the pre-patch output. This does not affect consumers such as
> rasdaemon that use libtraceevent to parse fields by name rather than
> by fixed text position.
> 
> For non-Endpoint events (Switch Port, Root Port, RCH Dport),
> "memdev" is empty and "port"/"dport" carry the topology information.
> 
> Below are examples of the different CXL devices' error trace logs
> after this patch:
> 
>      ---------------------
>      | CXL RP - 0C:00.0  |
>      ---------------------
>                |
>      ---------------------
>      | CXL USP - 0D:00.0 |
>      ---------------------
>                |
>      --------------------
>      | CXL DSP - 0E:00.0 |
>      --------------------
>                |
>      ---------------------
>      | CXL EP - 0F:00.0  |
>      ---------------------
> 
> Root Port:
> cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
>    first_error: 'Cache Address Parity Error'
> 
> Upstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
> PCI AER callbacks that are not CXL aware.
> 
> Downstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> Endpoint:
> cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
>    host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v18->v19:
> - Drop redundant device lock in cxl_cper_handle_prot_err(); the port
>   reference already keeps the object alive and no RAS iomap is accessed.
> - Swap order in series with ("PCI: Cache PCI DSN into pci_dev->dsn during
>   probe")
> - Add review-by for DaveJ
> 
> Changes in v17->v18:
> - Consolidate double find_cxl_port_by_dev() in cxl_cper_handle_prot_err()
> - Add comment noting dport is NULL for Endpoint and Upstream Port devices
> - Add cxl_trace_* helpers
> - Add CPER refactor
> 
> Changes in v16->v17:
> - Replace cxlds->serial with pci_get_dsn()
> - Change 'memdev' to 'device' (Dan)
> - Updated Commit message
> 
> Changes in v15->v16:
> - Add Dan's review-by
> - Incorporate Dan's comment into commit message:
> "Add the serial number at the end to preserve compatibility with
> libtraceevent parsing of the parameters."
> 
> Changes in v14->v15:
> - Update commit message.
> - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (terry)
> 
> Changes in v13->v14:
> - Update commit headline (Bjorn)
> 
> Changes in v12->v13:
> - Added Dave Jiang's review-by
> 
> Changes in v11 -> v12:
> - Correct parameters to call trace_cxl_aer_correctable_error()
> - Add reviewed-by for Jonathan and Shiju
> 
> Changes in v10->v11:
> - Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
> and unchanged TP_printk() logging.
> ---
>  drivers/cxl/core/core.h    |   8 +--
>  drivers/cxl/core/ras.c     | 129 +++++++++++--------------------------
>  drivers/cxl/core/ras_rch.c |   3 +-
>  drivers/cxl/core/trace.c   |  35 ++++++++++
>  drivers/cxl/core/trace.h   |  91 ++++++++------------------
>  drivers/cxl/cxlmem.h       |   7 ++
>  6 files changed, 113 insertions(+), 160 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5ca1275fd8f35..a55a4e409feda 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -186,11 +186,11 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> -		    void __iomem *ras_base);
> +		    void __iomem *ras_base, u64 serial);
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  		     struct cxl_dport *dport);
>  void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> -			void __iomem *ras_base);
> +			void __iomem *ras_base, u64 serial);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
> @@ -200,14 +200,14 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  static inline void cxl_ras_init(void) { }
>  static inline void cxl_ras_exit(void) { }
>  static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> -				  void __iomem *ras_base)
> +				  void __iomem *ras_base, u64 serial)
>  {
>  	return false;
>  }
>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport) { }
>  static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> -				      void __iomem *ras_base) { }
> +				      void __iomem *ras_base, u64 serial) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 5183b3c532952..0254b7ec64c30 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -12,69 +12,37 @@
>  static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
>  	      "rasdaemon ABI requires exactly 128 u32s");
>  
> -static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> -					      struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -
> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> -}
> -
> -static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> -						struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
> +					   u64 serial, struct cxl_ras_capability_regs *ras_cap)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
>  	u32 fe;
>  
>  	if (hweight32(status) > 1)
>  		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   ras_cap.cap_control));
> -	else
> -		fe = status;
> -
> -	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
> -}
> -
> -static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> -					 struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -
> -	trace_cxl_aer_correctable_error(cxlmd, status);
> -}
> -
> -static void
> -cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> -			       struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> -	u32 fe;
> -
> -	if (hweight32(status) > 1)
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   ras_cap.cap_control));
> +				   ras_cap->cap_control));
>  	else
>  		fe = status;
>  
>  	/*
> -	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
> +	 * ras_cap->header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
>  	 * dwords. Copy them into the front of a zero-filled
>  	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
>  	 * event memcpy sees a full 512-byte source and the userspace ABI
>  	 * (rasdaemon) is preserved.
>  	 */
> -	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> +	memcpy(hl, ras_cap->header_log, CXL_HEADERLOG_SIZE);
> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
> +					  hl, serial);
>  }
>  
> -static int match_memdev_by_parent(struct device *dev, const void *uport)
> +static void cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
> +					 u64 serial, struct cxl_ras_capability_regs *ras_cap)
>  {
> -	if (is_cxl_memdev(dev) && dev->parent == uport)
> -		return 1;
> -	return 0;
> +	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
> +
> +	trace_cxl_aer_correctable_error(port, dport, status, serial);
>  }
>  
>  /**
> @@ -108,44 +76,32 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
>  
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
> +	struct cxl_dport *dport;
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>  				       data->prot_err.agent_addr.function);
> -	struct pci_dev *pdev __free(pci_dev_put) =
> -		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
> -					    data->prot_err.agent_addr.bus,
> -					    devfn);
> -	struct cxl_memdev *cxlmd;
> -	int port_type;
> -
> -	if (!pdev)
> -		return;
> -
> -	port_type = pci_pcie_type(pdev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    port_type == PCI_EXP_TYPE_UPSTREAM) {
> -		if (data->severity == AER_CORRECTABLE)
> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> -		else
> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> -
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> +		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
> +	if (!pdev) {
> +		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
>  		return;
>  	}
>  
> -	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver)
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
>  		return;
> +	}
>  
> -	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> -	if (!mem_dev)
> -		return;
> +	/* dport is NULL for Endpoint and Upstream Port devices */
> +	dport = cxl_find_dport_by_dev(port, &pdev->dev);
> 

Hi Terry,

I have a question here.

Do we need the port device lock here ?

cxl_find_dport_by_dev() is xa_load(), and the free side is serialized by that
lock. del_dports() has device_lock_assert(&port->dev) and frees the dport which
in the end resolves to kfree().

__free(put_cxl_port) doesn't cover it, that's a kobject ref on &port->dev,
so it pins the struct cxl_port but not the dports.

I think cxl_cper_handle_prot_err() might race cxl_detach_ep() calling
del_dports(), and cxl_trace_dport_name() then does dev_name(dport->dport_dev)
on freed memory.

I see __cxl_proto_err_work_fn(), cxl_handle_rdport_errors() and
cxl_pci_error_detected() all take the guard first, should we do the same here?


Though I didn't poke this issue out in runtime, I guess it needs
FW-first, cxl_aer_* enabled, and a concurrent teardown. Not an expert of FW,
let me knowo if something already rules it out.

Best regards,
Richard Cheng.

 
> -	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(port, dport, pdev->dsn,
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(port, dport, pdev->dsn,
> +					       &data->ras_cap);
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>  
> @@ -232,14 +188,15 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>  	if (!ras_base)
>  		panic("CXL: UCE with unmapped RAS registers");
>  
> -	if (cxl_handle_ras(port, dport, ras_base))
> +	if (cxl_handle_ras(port, dport, ras_base, pdev->dsn))
>  		panic("CXL cachemem error");
>  
>  	dev_dbg(&pdev->dev,
>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>  }
>  
> -void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> +			void __iomem *ras_base, u64 serial)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -251,12 +208,7 @@ void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __i
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		if (is_cxl_endpoint(port))
> -			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
> -		else if (dport)
> -			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
> -		else
> -			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
> +		trace_cxl_aer_correctable_error(port, dport, status, serial);
>  	}
>  }
>  
> @@ -281,7 +233,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +		    void __iomem *ras_base, u64 serial)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	void __iomem *addr;
> @@ -308,12 +261,7 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_endpoint(port))
> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
> -	else if (dport)
> -		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
> -	else
> -		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> @@ -354,7 +302,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  		 * cases below handle AER recovery for devices without active
>  		 * CXL.mem traffic.
>  		 */
> -		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
> +				    pdev->dsn);
>  	}
>  
>  	/*
> @@ -386,7 +335,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
>  {
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pdev->dsn);
>  	else
>  		cxl_do_recovery(pdev, port, dport);
>  }
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index a5c62c71060d9..a371174536a8b 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -113,7 +113,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  	 */
>  	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
>  		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
> -		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport),
> +			pdev->dsn);
>  	}
>  
>  	if (aer_regs.uncor_status & ~aer_regs.uncor_mask) {
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index 7f2a9dd0d0e3f..df42d119c53dd 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -2,7 +2,42 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include "core.h"
>  
> +const char *cxl_trace_memdev_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(&cxlmd->dev);
> +	}
> +
> +	return "";
> +}
> +
> +const char *cxl_trace_host_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(cxlmd->dev.parent);
> +	}
> +
> +	return dev_name(port->uport_dev);
> +}
> +
> +const char *cxl_trace_port_name(struct cxl_port *port)
> +{
> +	return dev_name(&port->dev);
> +}
> +
> +const char *cxl_trace_dport_name(struct cxl_dport *dport)
> +{
> +	if (dport)
> +		return dev_name(dport->dport_dev);
> +	return "";
> +}
> +
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index d37876096dd7c..910aceb2ca3ab 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,44 +48,15 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
>  
> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev, status, fe, hl),
> -	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -		__field(u32, first_error)
> -		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -		__entry->first_error = fe;
> -		/*
> -		 * Embed headerlog data for user app retrieval and parsing,
> -		 * but no need to print in the trace buffer. Only
> -		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
> -		 * the remaining entries preserve the 512-byte ABI layout
> -		 * rasdaemon depends on and are zero-filled by the caller.
> -		 */
> -		memcpy(__entry->header_log, hl,
> -			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
> -	),
> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_uc_errs(__entry->status),
> -		  show_uc_errs(__entry->first_error)
> -	)
> -);
> -
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(cxlmd, status, fe, hl),
> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
> +		 u32 status, u32 fe, u32 *hl, u64 serial),
> +	TP_ARGS(port, dport, status, fe, hl, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(memdev, cxl_trace_memdev_name(port))
> +		__string(port, cxl_trace_port_name(port))
> +		__string(dport, cxl_trace_dport_name(dport))
> +		__string(host, cxl_trace_host_name(port))
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
> @@ -93,8 +64,10 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	),
>  	TP_fast_assign(
>  		__assign_str(memdev);
> +		__assign_str(port);
> +		__assign_str(dport);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -107,8 +80,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		memcpy(__entry->header_log, hl,
>  			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> +		  __get_str(memdev), __get_str(port), __get_str(dport),
> +		  __get_str(host), __entry->serial,
>  		  show_uc_errs(__entry->status),
>  		  show_uc_errs(__entry->first_error)
>  	)
> @@ -132,42 +106,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
>  
> -TRACE_EVENT(cxl_port_aer_correctable_error,
> -	TP_PROTO(struct device *dev, u32 status),
> -	TP_ARGS(dev, status),
> -	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -	),
> -	TP_printk("device=%s host=%s status='%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_ce_errs(__entry->status)
> -	)
> -);
> -
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
> -	TP_ARGS(cxlmd, status),
> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
> +		 u32 status, u64 serial),
> +	TP_ARGS(port, dport, status, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(memdev, cxl_trace_memdev_name(port))
> +		__string(port, cxl_trace_port_name(port))
> +		__string(dport, cxl_trace_dport_name(dport))
> +		__string(host, cxl_trace_host_name(port))
>  		__field(u64, serial)
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
>  		__assign_str(memdev);
> +		__assign_str(port);
> +		__assign_str(dport);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s'",
> +		  __get_str(memdev), __get_str(port), __get_str(dport),
> +		  __get_str(host), __entry->serial,
>  		  show_ce_errs(__entry->status)
>  	)
>  );
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2f..f1ef8b78db18a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -125,6 +125,13 @@ static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>  #endif
>  
>  struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
> +
> +/* trace-event helpers */
> +const char *cxl_trace_memdev_name(struct cxl_port *port);
> +const char *cxl_trace_host_name(struct cxl_port *port);
> +const char *cxl_trace_port_name(struct cxl_port *port);
> +const char *cxl_trace_dport_name(struct cxl_dport *dport);
> +
>  struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  					 const struct cxl_memdev_attach *attach);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,
> -- 
> 2.34.1
> 
