Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328D3A75BB;
	Mon, 24 Aug 2026 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559142; cv=fail; b=VkqYTLC65W08IMBJTUoePeGWw/Y82TfjJDxL7u/EKmoQRK2HO/tqZtOFkCfSFOVGkk2tLaWZ6j/0PfKb6TVP1YKfoAEFEEzKmV0IRgQGt3CBuePhRwD3otUq215ECeD/CGkkkNFKEnrHaRzEdfDf1RhMh6kbTaVaSzAYE7nmAY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559142; c=relaxed/simple;
	bh=/jFMMjjeijN6Ogahz9v8I845jOWcj1HrOaMGn2AKmP0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QC3laFJ0Q79X6zaKgy2E4yGtaa4Yq4gx/fkh7mfKMs4f9C8gQ42iAyC8ga/RQ8l732LyRMA7Y3DbDpezapEop20SMT6jH1+lFnkmaeyaJ9SALQCRDbsVM/cvbzLO4LCw6hc3RvJrcTho2TpL6Dbg4not6ypxTydHk6TaUYEQD60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGU45WGj; arc=fail smtp.client-ip=40.107.208.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGU45WGj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suN2G7jxZsFggZBVMJZTmKmbrZlw8+aEOou8oRU7WTXiYlDzvFhMRjeXESJKjA6Q538sxNVWlbZkIW+gR6G+bnHta14aPMM6EjgHPlYzkNKewJLvaOsj333sG1W+cRWIsmXpJAG7e79bp4D00Zdj22MwudtCZek+OEeQRHU/6qcebiAcW+TGthmDqqKjdGXc3AdorGfVE9Nyf7zII05q5UVGA1wRFGNT3S1S42JJsKACVBdLMJZzFDLc1ptGaLq+8h8AVa1Y/rD48bzCYQJOBXBeYR42slM689MVFAKdsHT8jor/HPm6Ll0FFyeqt/Ca/KNsbAGZ4VdPUr6hdCc+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/qeia3b0xZWdbWPpB4A7FsJKfJ+ImLsgxKuw/fr7hY=;
 b=dfMFjI71Avq4DY4q1kuHi2RpRuPiVAKo9wVZD12ws5GlzbYKVfbuJXonJyC7MmvHq4kcxSLt81Jv+JtkaXu2f2RJSJfutCfkuMTC2xYJFNbe5/zThs6P9vUw5oyD0LobZXahfJ6KY2a4aTM/Vl4fUiIpPZ4U/7KBx5v611d0buRLG8PZDuQ1S3bI8fRjeaFu7lHc3Stf3hd2FFYHua5mOKnaWBmp2FeKkgBN4Kw1FSpTdzUlLLoK4mQQYt/xlBAW/sFC5kMZNNIj6Wo+6EkoGjtJSxj9RGLT2ATjyG9AvKAUUYSWVduWvzt5v7Ur2lMSLF+a8ZN3fV4f3aIB0OiZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/qeia3b0xZWdbWPpB4A7FsJKfJ+ImLsgxKuw/fr7hY=;
 b=XGU45WGjfI3t+whdpwK1EPlNWfRkR8Fa+QTH9KeWxFjGW9UMFVMvTBPiPgc3U/MMkbeHkCH8kBR4pgYUC9yedqsUAUVLSxvm+8TtoXKikyfzjVt8L1ddNQXZbpxsPWUz9Bpta2RmnXpuRzxy+25zrZQaQ/kvBd25O5NubcaAgk+rtEJTFAnFYk0SCcLpTpUPVUkJhynA5qxbQcZ6YFOUGeuwTitonK35T/UzWjzdcpnEj0NRIhxLuh8epkM4QcJjBTsowPCVYbtu2Jnz23Xbaq6jy5mE/HFYUl0hNoAvw/04feEOfTZIYlswGfqERv/F25uvtzT2eRu5I84gJqk0Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:12:14 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 08:12:13 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 17:12:10 +0900
Message-Id: <DKX0TRYM9KB1.HMIDNZDWMIJJ@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
In-Reply-To: <20260818084633.1673214-2-zhiw@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b02e68-77d2-4bb1-4d33-08df01b76733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XT4m7a9lEgaP3ENgnhHyYE6dfb/y2iXubLeTAYdmkU6BUCAViC5izV+4amoG4mJkMy34Wfg4at7ujGxIOdKy5tT0kpqQaNdmThj6JbF4XCEhpHxGtZSZIfVCwv3R+lKD3i+h8qgrXzkwQwJ1GSXDodnpnJpijnGjydZiLGlxBOpRBb+7voHB968bT1Sa4xMr8IMQZcreDdq7T0j1QGpsjn6WkN7n4JxLGGMsP6qCgGSEPi7fat+zAlK3eD+OFaT7KvZd5Jb1n0veQvriwy+3nfrc7yWr5WfLR6dSJCgDHIDM+6LR/NGVKBxnSV6mIhBfNbBGU0R7Pncnhe7l2hewE9XythfZBNqGVWBP8MoJionUuHgSgVDBro986Q4dXVdTtW+rxDgdPeHrc3xZWUbJZ92AJdTm7KFTWGW76bSTMIxRKVxtwgzUgFtz87NUdBTw/x4apsaG2vT1u4SzR1KsTgaIeq8pX3F5Ygk6+zC/LqlGJ2r/2cqzwO1Z2tf5Yv+4ZxX5A/928XJxztLqfH6XvrOepMs9oWvoyAg7jxZTE+K3KIFq0ZHjL/X2F9bYudzFHYRs3hmsNZ01LUqlkZBfRio3qYqGlNXYq9RyWnTKm9u0jV6Ywx1msw++1/ORcf8Ge2x5TUsHHAEUU8w8fwhATkfuqVprQnaF+/rh9m4pDqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW1vT1crdHRaS2plWkc4b2JZNEJZY2tWUS9iZFIvdTVzTmZNMGd1QlZHN2c3?=
 =?utf-8?B?bGRZQ1FEdDBZWjNIMjlVLzVxTTRrWHVka2NPSW9UbGR3TjZiYWRUQ0NGaGlw?=
 =?utf-8?B?REJsTWVocFlHZnVHa3RRNWc0cUxyanExQW11TGZjMTU0ZFI0RmJ2RlhsRHZU?=
 =?utf-8?B?Tzh0ekY1Zlg1K2hTVlV0c2FZNENERERjME01MndIdDJUZ0g0SGtSV2M0R1FS?=
 =?utf-8?B?K0RUVU8xYlZvMXA4TjUrNEdwek93YWFFemJYS0tHZmpxVXd1Ny9vZU4xcE1H?=
 =?utf-8?B?dEkvK2djSm5sWTMxL05ZQ3R2RTdyMnZkYkowMG5KOUV3T01FdE1sU085R0k3?=
 =?utf-8?B?UzBMK3ZQVTJBUTlnaC9Ia3RNendJVE5kaEIvblVDS0pKWFBnSlpETGFnUnkv?=
 =?utf-8?B?dHU5WXVQUWp0Nm5NVXBDSWl3SG1wZERTU3I1SWhVb2dqSlNKSEZkSE5mSDlh?=
 =?utf-8?B?c1VaeWlDM200Q3VRZGNzRWVEUWUvQmdzbFVRanNwVHF3M1lNTnAxWGtBaEFs?=
 =?utf-8?B?NFlVRXJFMlkzL2tQVGFYU3h4WkVWbFBFdEtBeHZ2ZStFVktYS0JhZ3gxdC9Y?=
 =?utf-8?B?SDZvUXhCMDFQS3NhdmxWdnpWWHhlVE9QY2xaTSs3MTZEbGx2VmdVdEs2cUdK?=
 =?utf-8?B?SmEyUmh3Mk5zOC9yS3lSbHBJNmJJVTJZSVU2ZXRtRTdSU0FwNTg5V09pUVNr?=
 =?utf-8?B?clNXbWJScWFUQnFVQmViYXh5eko1K2duK1VIbWIyQVJ0ZGVZUEdzaTY2YTRX?=
 =?utf-8?B?TkhHWEQ2OERXQnpGNVRwZy9SUFFJNEtkQjhzblA3WU80Q0pvRjZmWWtyaUI0?=
 =?utf-8?B?cW9aVkhEdUNnRTlRdXhEczEwQlh6bFBaSnZsNUQxQ1BQSVZYT2VtQTZnWExj?=
 =?utf-8?B?VVpCVXM4NDdGd2J4NUY4NFNxUzY3d05FR3l2aW0xeEl6MUtTWHdCVlE1djlJ?=
 =?utf-8?B?VTlhRDZXTmV0alpiNERRZUx2aEFHZVk1SWlxME1oTSsrMGR5OWFYZFFCQXVi?=
 =?utf-8?B?ZFlFc1lhVGJJM01nU3BqU2F1VXBQajhmVUg3UHJob3ZUZlZKdmJScnd3Vkgv?=
 =?utf-8?B?MGNSTjBxMFVBOE5udjhyS2ZVMGUrQUNIWENFUnlpQW1NQVViRzVEWXQvdGJD?=
 =?utf-8?B?U3lCRFArcWtVcTlkeGVjeU1PWjhjWXphNEtzb2NqTlQwRVFPMENONmpEMXJM?=
 =?utf-8?B?cVlUaWh3MUZFUlYxYW0zYkNseTRGekVTdlArK0Q0VnNUNXRMSitmbzhTK1c2?=
 =?utf-8?B?TDhnVkI2RHNyeTYvYzcwN3BDdlQvOFVkL1k5WTNhZk12RW92TVpDOUo2cTVZ?=
 =?utf-8?B?NG1oMWp0dWlabnVQZCt1S3BVWUl3ZCs5TXVZKzhYbTE2ZG92a08xQ3BrTmVY?=
 =?utf-8?B?M3hBV3QyNG1CeUZleFpHSk9zNUdDeGF2V2Q1dmJRTkkyaWN2b1VBYm1hT0Vq?=
 =?utf-8?B?MWxQNnFBRXJLdnFIdWZ5N3BnM29sYmJ1TE4zcGhmb2dwUzhYMk5FNVB3dkY4?=
 =?utf-8?B?WlZUN0YzZmwzNGpXVFNnV3dGNUJrSU55MzhENWJwenpJUlZoWVduZ0RQb3Ns?=
 =?utf-8?B?NmEzMFJQc0ZoOE1HNG5HQXBrS0hrelVBTHI4T0ZEYisyTk0xWUExU1J1MjZN?=
 =?utf-8?B?S3laY28yRW10b1VTR1hWTXAyWG0wdnA2c2w5dEtDWEplc0tOaTdkV25iTzZl?=
 =?utf-8?B?VjJZUmdnQmFoNnBQdzNaNHdTN0R2clo2TFBHa01ZcGxYZlM3em1rZ1pLNko2?=
 =?utf-8?B?N3RhcFFhOWw1Smpqc2NocVY3dnMyNk13RHBuNitNMVRrNG1tbm5zMjlzRzUr?=
 =?utf-8?B?YjlUQlBraFA0dHc4RFY0czYrbklWSGxBNXVCTUdoekNtUXVWWEpralBpdTcr?=
 =?utf-8?B?RnJlZTZwbXRMVXFwZFA1bWJhZy9OMFlJSEpjWjZrYXRWYitQdVNIRkVQWk9m?=
 =?utf-8?B?VStMblppeEhzMkFLMGd0NklRSEEwaXFLNXI3djUyTU9IWGUzUlNXeWlZK3B4?=
 =?utf-8?B?V1Nqei91WEdrSDVpSXg3UTgxWVhXU21lODZEb1d5V3UweEYxY0dFbXhscmp0?=
 =?utf-8?B?elJTMk1WK0QvMHcxSmI4NTJ1d25FbFovQko0OFpUcnRUUVd0Um9PRzJpY0dh?=
 =?utf-8?B?ZE9NaXRhamNXTjZGdEhTRDJPbjA5ZDRkakMwZXdRR3pYMG1NQlVEb2tTUngw?=
 =?utf-8?B?SlJYVS96ZlJZa1I4cXEraHJNNlNzdmw2bkthMjErVXlueTlqR2xtMkFjakVa?=
 =?utf-8?B?R1NQellqVzkyRnY3Qk4xVWpLQlBOdjgyWWxXZVBaaGhaWEFvYTluenczZFdt?=
 =?utf-8?B?QVFQa3M1SWhxc2FCUng2LzdnWUg1czcxZzh5eHFhSlc0Z0VvNFAxejNjUi95?=
 =?utf-8?Q?GDFPavf0NbQ0QGpHeCOHOFJd2MAfV1Yy9x2p5BZHe5n8k?=
X-MS-Exchange-AntiSpam-MessageData-1: 0W0Vzq55DUzaJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b02e68-77d2-4bb1-4d33-08df01b76733
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:12:13.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkeDWYDs73jWnYj01J3lkoLeRhoK9oq3aOdSvoz3nTW2DhCUfXn3t2Fb2L7SFuuw24q/2cMJixkOS24EAZo4vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

On Tue Aug 18, 2026 at 5:46 PM JST, Zhi Wang wrote:
> Rust PCI drivers have no typed interface for locating and accessing PCIe
> extended capabilities.
>
> The SR-IOV extended capability describes VF topology and VF BARs. Expose
> this information through the Rust PCI abstraction so drivers can use the
> existing typed configuration-space accessors instead of raw bindings.
>
> Define ExtCapability to associate a capability ID with a register layout,
> and add ConfigSpace::find_ext_capability() to locate and project that
> layout. Bound the view at the next capability or the end of extended
> configuration space. Add ExtSriovRegs and a decoded VF BAR iterator that
> reads and validates all six VF BAR register slots up front, yields decode=
d
> BAR addresses and widths in logical order, and keeps the raw
> configuration-space slot advancement internal. Since PCI_EXT_CAP_NEXT() i=
s
> a function-like macro, expose it through a Rust helper.
>
> Link: https://lore.kernel.org/rust-for-linux/20260804161612.776752-1-zhiw=
@nvidia.com/
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Gary Guo <gary@garyguo.net>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/helpers/pci.c     |   5 +
>  rust/kernel/pci.rs     |   8 +
>  rust/kernel/pci/cap.rs | 329 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 342 insertions(+)
>  create mode 100644 rust/kernel/pci/cap.rs
>
> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
> index 4ebf256dff23..b946b14d79e4 100644
> --- a/rust/helpers/pci.c
> +++ b/rust/helpers/pci.c
> @@ -24,6 +24,11 @@ __rust_helper bool rust_helper_dev_is_pci(const struct=
 device *dev)
>  	return dev_is_pci(dev);
>  }
> =20
> +__rust_helper u32 rust_helper_pci_ext_cap_next(u32 header)
> +{
> +	return PCI_EXT_CAP_NEXT(header);
> +}
> +
>  #ifndef CONFIG_PCI_IOV
>  __rust_helper unsigned int
>  rust_helper_pci_sriov_get_totalvfs(struct pci_dev *pdev)
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9f19ccd5905c..008c2770a3f3 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -32,10 +32,18 @@
>      },
>  };
> =20
> +mod cap;
>  mod id;
>  mod io;
>  mod irq;
> =20
> +pub use self::cap::{
> +    ExtCapId,
> +    ExtCapability,
> +    ExtSriovCapability,
> +    ExtSriovRegs,
> +    ExtSriovVfBar, //
> +};
>  pub use self::id::{
>      Class,
>      ClassMask,
> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 000000000000..ddb3fd73e195
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! PCI extended capability support.
> +
> +use super::{
> +    io::ConfigSpaceBackend,
> +    ConfigSpace,
> +    Extended, //
> +};

Let's merge this block with the one below, i.e. using `crate::pci`?

> +use crate::{
> +    bindings,
> +    io::{
> +        Io,
> +        IoBackend,
> +        Region, //
> +    },
> +    num::Bounded,
> +    prelude::*,
> +};
> +
> +/// Number of VF BAR register slots in an SR-IOV capability.
> +// CAST: `PCI_SRIOV_NUM_BARS` is the PCIe-specified number of VF BAR reg=
ister slots and fits in
> +// `usize`.
> +const NUM_VF_BARS: usize =3D bindings::PCI_SRIOV_NUM_BARS as usize;

The infallible casts module is now available in `master`. If you import
`crate::num::casts` you can now turn this into

    const NUM_VF_BARS: usize =3D casts::u32_as_usize(bindings::PCI_SRIOV_NU=
M_BARS);

and remove the `CAST` comment.

> +
> +/// PCI extended capability IDs.
> +#[repr(transparent)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtCapId(u16);
> +
> +impl ExtCapId {
> +    /// Single Root I/O Virtualization.
> +    // CAST: PCI extended capability IDs are 16-bit values defined by th=
e PCIe specification.
> +    pub const SRIOV: Self =3D Self(bindings::PCI_EXT_CAP_ID_SRIOV as u16=
);

Same here, the `CAST` comment can be removed if you turn this line into

    pub const SRIOV: Self =3D Self(casts::u32_into_u16::<{ bindings::PCI_EX=
T_CAP_ID_SRIOV }>());

> +
> +    /// Creates an extended capability ID from its raw PCIe value.
> +    #[inline]
> +    pub const fn new(id: u16) -> Self {

For symmetry with `as_raw`, should this be `from_raw`? The other PCI
types (e.g. Class and Vendor) also use this naming pattern.

> +        Self(id)
> +    }
> +
> +    /// Returns the raw PCIe extended capability ID.
> +    #[inline]
> +    const fn as_raw(self) -> u16 {
> +        self.0
> +    }

... and for symmetry as well, let's make this `pub`. :)

> +}
> +
> +/// A typed PCI extended capability register layout.
> +///
> +/// Implementors describe the register layout of one extended capability=
. The layout must start at
> +/// the extended capability header, and [`Self::ID`] must identify that =
layout.
> +pub trait ExtCapability: FromBytes + IntoBytes {
> +    /// PCI extended capability ID for this register layout.
> +    const ID: ExtCapId;
> +}
> +
> +impl<'a> ConfigSpace<'a, Extended> {
> +    /// Finds and projects an extended capability into its typed registe=
r layout.
> +    ///
> +    /// Returns [`None`] if the device does not implement the capability=
.
> +    ///
> +    /// Returns an error if the capability is present but its register s=
pan is too small or
> +    /// insufficiently aligned for `C`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::{
> +    ///     device::Bound,
> +    ///     io::io_read,
> +    ///     pci,
> +    ///     prelude::*,
> +    /// };
> +    ///
> +    /// fn probe_sriov(pdev: &pci::Device<Bound>) -> Result {
> +    ///     let Some(sriov) =3D pdev
> +    ///         .config_space_extended()?
> +    ///         .find_ext_capability::<pci::ExtSriovRegs>()?
> +    ///     else {
> +    ///         return Ok(());
> +    ///     };
> +    ///
> +    ///     let total_vfs =3D io_read!(sriov, .total_vfs);
> +    ///     let vf_offset =3D io_read!(sriov, .vf_offset);
> +    ///     let mut vf_bars =3D sriov.vf_bars()?;
> +    ///     let bar0 =3D vf_bars.next().ok_or(EINVAL)?;
> +    ///     let bar1 =3D vf_bars.next().ok_or(EINVAL)?;
> +    ///     let bar2 =3D vf_bars.next().ok_or(EINVAL)?;
> +    ///
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    pub fn find_ext_capability<C: ExtCapability>(&self) -> Result<Option=
<ConfigSpace<'a, C>>> {
> +        let offset =3D usize::from(
> +            // SAFETY: `self.pdev` is valid by the type invariant of `Co=
nfigSpace`.
> +            unsafe {
> +                bindings::pci_find_ext_capability(self.pdev.as_raw(), i3=
2::from(C::ID.as_raw()))
> +            },
> +        );
> +
> +        if offset =3D=3D 0 {
> +            return Ok(None);
> +        }
> +
> +        let size =3D self.calculate_ext_cap_size(offset)?;
> +
> +        let base =3D ConfigSpaceBackend::as_ptr(*self)
> +            .cast::<u8>()
> +            .wrapping_add(offset);
> +        let ptr =3D Region::<0>::ptr_try_from_raw_parts_mut(base, size)?=
;
> +
> +        // SAFETY: `offset` was returned by `pci_find_ext_capability`, a=
nd
> +        // `calculate_ext_cap_size` bounds `ptr` at the next capability =
or the end of the extended
> +        // configuration space. `ptr_try_from_raw_parts_mut` verified th=
e region layout.
> +        let capability =3D unsafe { ConfigSpaceBackend::project_view(*se=
lf, ptr) };
> +
> +        capability.try_cast::<C>().map(Some)
> +    }
> +
> +    /// Calculates the size of the extended capability at `offset`.
> +    ///
> +    /// The capability extends to the next extended capability, or to th=
e end of the extended
> +    /// configuration space if it is the last one. `offset` must be a DW=
ORD-aligned offset within
> +    /// the extended configuration space returned by `pci_find_ext_capab=
ility`. Returns an error if
> +    /// the capability header is outside the extended configuration spac=
e.
> +    fn calculate_ext_cap_size(&self, offset: usize) -> Result<usize> {
> +        let header =3D self.try_read32(offset)?;
> +        // SAFETY: Pure bit manipulation, no preconditions.
> +        // CAST: The next-cap pointer is a 12-bit field (max 0xFFC), alw=
ays fits in `usize`.
> +        let next =3D unsafe { bindings::pci_ext_cap_next(header) } as us=
ize;

This `CAST` as well can be removed:

    let next =3D casts::u32_as_usize(unsafe { bindings::pci_ext_cap_next(he=
ader) });

> +
> +        Ok(if next > offset {
> +            next - offset
> +        } else {
> +            self.size() - offset
> +        })
> +    }
> +}
> +
> +/// SR-IOV register layout per PCIe spec (64 bytes starting at cap offse=
t).
> +#[repr(C)]
> +#[derive(FromBytes, IntoBytes)]
> +pub struct ExtSriovRegs {
> +    /// Extended capability header.
> +    _header: u32,
> +    /// SR-IOV capabilities.
> +    pub cap: u32,
> +    /// SR-IOV control.
> +    pub ctrl: u16,
> +    /// SR-IOV status.
> +    pub status: u16,
> +    /// Initial VFs.
> +    pub initial_vfs: u16,
> +    /// Total VFs.
> +    pub total_vfs: u16,
> +    /// Number of VFs.
> +    pub num_vfs: u16,
> +    /// Function dependency link.
> +    pub func_dep_link: u8,
> +    _reserved_0: u8,
> +    /// First VF offset.
> +    pub vf_offset: u16,
> +    /// VF stride.
> +    pub vf_stride: u16,
> +    _reserved_1: u16,
> +    /// VF device ID.
> +    pub vf_device_id: u16,
> +    /// Supported page sizes.
> +    pub supported_page_sizes: u32,
> +    /// System page size.
> +    pub system_page_size: u32,
> +    /// VF BARs (BAR0=E2=80=93BAR5).
> +    pub vf_bar: [u32; NUM_VF_BARS],

Now that we have an iterator method, we can make this member private.
I'd even say we should as making this public enables the kinds of
invalid accesses we built the iterator to avoid.

> +    /// VF migration state array offset.
> +    pub migration_state: u32,
> +}
> +
> +impl ExtCapability for ExtSriovRegs {
> +    const ID: ExtCapId =3D ExtCapId::SRIOV;
> +}
> +
> +/// A typed view of an SR-IOV extended capability.
> +pub type ExtSriovCapability<'a> =3D ConfigSpace<'a, ExtSriovRegs>;
> +
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +enum VfBarMemoryType {
> +    Bits32,
> +    Bits64,
> +}
> +
> +impl TryFrom<Bounded<u32, 2>> for VfBarMemoryType {
> +    type Error =3D Error;
> +
> +    fn try_from(value: Bounded<u32, 2>) -> Result<Self> {
> +        match value.get() {
> +            0b00 =3D> Ok(Self::Bits32),
> +            0b10 =3D> Ok(Self::Bits64),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<VfBarMemoryType> for Bounded<u32, 2> {
> +    fn from(value: VfBarMemoryType) -> Self {
> +        match value {
> +            VfBarMemoryType::Bits32 =3D> Self::new::<0b00>(),
> +            VfBarMemoryType::Bits64 =3D> Self::new::<0b10>(),
> +        }
> +    }
> +}
> +
> +crate::bitfield! {
> +    /// Low DWORD of an SR-IOV VF BAR.
> +    struct VfBarLow(u32) {
> +        /// Base address bits 31:4.
> +        31:4 address;
> +        /// Whether the address range is prefetchable.
> +        3:3 prefetchable =3D> bool;
> +        /// Memory BAR type.
> +        2:1 memory_type ?=3D> VfBarMemoryType;
> +        /// Whether this is an I/O-space BAR.
> +        0:0 io_space =3D> bool;
> +    }
> +}
> +
> +/// A decoded VF BAR register encoding.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub struct ExtSriovVfBar {
> +    /// The BAR address without PCI attribute bits.
> +    pub address: u64,
> +
> +    /// Whether the BAR is 64-bit.
> +    pub is_64bit: bool,
> +}
> +
> +/// Iterator over decoded VF BAR register encodings.
> +///
> +/// A 32-bit memory BAR encoding uses one register. A 64-bit memory BAR =
encoding uses that register
> +/// for bits 31:0 and the immediately following register for bits 63:32.
> +///
> +/// # Invariants
> +///
> +/// - `next_bar <=3D bar_count <=3D NUM_VF_BARS`.
> +/// - Entries before `bar_count` contain decoded VF BARs in logical orde=
r.
> +struct ExtSriovVfBars {
> +    bars: [ExtSriovVfBar; NUM_VF_BARS],
> +    bar_count: usize,
> +    next_bar: usize,
> +}
> +
> +impl ExtSriovVfBars {
> +    fn new(slots: [u32; NUM_VF_BARS]) -> Result<Self> {
> +        let mut bars =3D [ExtSriovVfBar {
> +            address: 0,
> +            is_64bit: false,
> +        }; NUM_VF_BARS];
> +        let mut bar_count =3D 0;
> +        let mut config_slot =3D 0;
> +
> +        while config_slot < NUM_VF_BARS {
> +            let low =3D VfBarLow::from(slots[config_slot]);
> +
> +            if low.io_space() {
> +                return Err(EINVAL);
> +            }

A comment would be appreciated for those not familiar with the PCI spec.
:)

> +
> +            let is_64bit =3D low.memory_type()? =3D=3D VfBarMemoryType::=
Bits64;
> +            let low_address =3D u64::from(low.address()) << VfBarLow::AD=
DRESS_SHIFT;
> +
> +            let address =3D if is_64bit {
> +                if config_slot + 1 >=3D NUM_VF_BARS {
> +                    return Err(EINVAL);
> +                }
> +
> +                let high =3D slots[config_slot + 1];
> +                config_slot +=3D 2;
> +                (u64::from(high) << 32) | low_address
> +            } else {
> +                config_slot +=3D 1;
> +                low_address
> +            };
> +
> +            bars[bar_count] =3D ExtSriovVfBar { address, is_64bit };
> +            bar_count +=3D 1;
> +        }

This looks a lot like C code - double counters in particular are
error-prone. We can make this a bit more idiomatic. I sense you didn't
use iterators because 64-bit entries take two slots, but you can use
this trick:

    // Store a mutable iterator.
    let mut slots =3D slots.into_iter();

    // Note the early conversion to `VfBarLow`
    while let Some(low) =3D slots.next().map(VfBarLow::from) {
        ...

        let bar =3D match low.memory_type()? {
            VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
                // We read the second slot here.
                address: (u64::from(slots.next().ok_or(EINVAL)?) << 32) | l=
ow_address,
                is_64bit: true,
            },
            VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
                address: low_address,
                is_64bit: false,
            },
        };

        ...
    }

... but we can go a bit further, please read along.

> +
> +        Ok(Self {
> +            bars,
> +            bar_count,
> +            next_bar: 0,
> +        })
> +    }
> +}
> +
> +impl Iterator for ExtSriovVfBars {
> +    type Item =3D ExtSriovVfBar;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.next_bar >=3D self.bar_count {
> +            return None;
> +        }
> +
> +        let bar =3D self.bars[self.next_bar];
> +        self.next_bar +=3D 1;
> +        Some(bar)
> +    }
> +}
> +
> +impl ExtSriovCapability<'_> {
> +    /// Returns an iterator over decoded VF BAR register encodings.
> +    ///
> +    /// All six raw VF BAR register slots are read and decoded up front.=
 A 32-bit encoding yields
> +    /// one entry; a 64-bit encoding combines two slots into one entry.
> +    ///
> +    /// A zero-valued low DWORD is yielded as a 32-bit BAR at address ze=
ro; this method does not
> +    /// probe whether a BAR is implemented.
> +    ///
> +    /// Returns [`EINVAL`] and logs an error if a BAR low DWORD does not=
 encode a 32-bit or 64-bit
> +    /// memory BAR, or if a 64-bit encoding has no upper DWORD.
> +    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar=
>> {

Since `ExtSriovVfBars` is private and we are returning an `impl`, I
think we can get rid of it altogether. Combining with my suggestion from
above, here is an alternative version of this method:

    pub fn vf_bars(&self) -> Result<impl Iterator<Item =3D ExtSriovVfBar>> =
{
        let slots: [u32; NUM_VF_BARS] =3D
            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[pani=
c: slot]));
        let mut slots =3D slots.into_iter();
        let mut bars =3D [None; NUM_VF_BARS];
        let mut count =3D 0;

        while let Some(low) =3D slots.next().map(VfBarLow::from) {
            if low.io_space() {
                return Err(EINVAL);
            }

            let low_address =3D u64::from(low.address()) << VfBarLow::ADDRE=
SS_SHIFT;
            let bar =3D match low.memory_type()? {
                VfBarMemoryType::Bits64 =3D> ExtSriovVfBar {
                    address: (u64::from(slots.next().ok_or(EINVAL)?) << 32)=
 | low_address,
                    is_64bit: true,
                },
                VfBarMemoryType::Bits32 =3D> ExtSriovVfBar {
                    address: low_address,
                    is_64bit: false,
                },
            };

            bars[count] =3D Some(bar);
            count +=3D 1;
        }

        Ok(bars.into_iter().flatten())
    }

With this you don't need `ExtSriovVfBars` at all, which removes a bit
(almost 50 LoCs!) of code.

> +        let slots: [u32; NUM_VF_BARS] =3D
> +            core::array::from_fn(|slot| crate::io_read!(*self, .vf_bar[p=
anic: slot]));

Can't this be `build:`? `vf_bar` is sized by `NUM_VF_BARS`, and so is
the result, so I'd assume the optimizer can infer this. Not that `panic:`
is problematic here but I wonder whether you chose this because you hit
an issue. To reiterate, I'm fine with `panic:` here, as long as the
alternative has been considered.
