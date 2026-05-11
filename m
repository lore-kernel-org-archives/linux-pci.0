Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021113.outbound.protection.outlook.com [52.101.125.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4633A8740;
	Mon, 11 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490924; cv=fail; b=TddR4qEW7xpZ+wnIjfmv2KbArNxTM1Xqy2xhHx37Z0CHBNoTxLTXRZBBPWjAnjTL3eBo4FlpzEt1KqiOTM0Yxm8g7RQDOQfZFqBgoKmXl2cf22kGRK/inWM/FTB/N+LENKXjZ7SfacAC5QM/fUkCSrEtn58Ya0cn31HiiRbKGzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490924; c=relaxed/simple;
	bh=esjuMst9fmcKSZXI5WWtUivhiH3bcIPMyGTATVFW9EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fXt2sKSSP4HL68fO91pxs9IyQ5xkTYylMA3oHmus8nKka/VlQmJ3kBdjjVpmew1U8krkksvn6s1NWBw6PdMwnycCBB5Mz8UKnEIaez7jmb588AuvVgBlVXt025JYLiq03Bnzk7woazDJelLWkQ90iBaxpcFWcAzg/WnzZ407a4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=akB3abc0; arc=fail smtp.client-ip=52.101.125.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="akB3abc0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1tjfztp0vWXyjcqAq7KKEKXTHo/7+R5wc1EwaMq3/+lI8v+T2HJhgueRodjDvz9mUJxZYysMPGbsXALzSqUvJL0ntMJGRSdDtcaT/+iC+EPAmzkXUdTXvAQznI50gHmZ6J6YHa6GUpo7b5XVhj9mU6NQLVyiufFTC+E/n9KfcnO3uuhxcJuj1GVhmNF8VQZfR4onVgYfiYkGwODImXborfQeWHRyI6YFYIbz9pezf4AB/neYk/ahNN0uKq8JZn9/e3vRsZiUQkwA/Z810GVVYgJZ2hJlzLf11yYpTVnzFPJsD25LBJt2+kfYcrV2uK36/QfpEO1WOPMTjWnH+JUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5I2wthB6XPLf0dY9O4u4mdd66H3aYBOTpsWJRy+7T8=;
 b=YjxiKtcBaRgQKbTXJC39xhD6HKWYcKOm+yopmiFLuW4eULf7rU+rtCiH3SAKnSfUR6Em4WzPdSjeTuIM2wz8j3HD7c9wK5VKkuicfonzwrzDxTQu+ifhQVgcOf0B6WXIG1jmjCXAvyNly24zLB/upqs2XEHDoxF+SS9H/3iTHc3Lo3g+gtnvcyeqld91dtRIxJumau7Ej0d2z8B3UVoJZYcBjN6s7QUIOeIaSGFubhahcJ8mSD+lpaOVPzZUOaZCSHdg9+TXOWQGlpmXdpRhJBpikwwmHMCMp98tJMV7iYVybV/2Ual4j/L4qMZZd6hoyOB0Fwp22vSgOQ9oA+D+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5I2wthB6XPLf0dY9O4u4mdd66H3aYBOTpsWJRy+7T8=;
 b=akB3abc0QYeFI10ZppFhKTE3T69XWRto7OP5/B3sAIix+r8XAHV0fuOOGGTSIkrd40aNs12Xo7x+UtPTeLi73GAgl3INqBtYOtKQis57BgoanWM9aVNJHJSlWF/JDXtDR7317FNHpyENeVZb17+3yTa3PsCp0fexvRCYIF/w/ko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3313.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 09:15:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 09:15:19 +0000
Date: Mon, 11 May 2026 18:15:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v3 09/10] NTB: epf: Fix doorbell bitmask handling in
 db_read/db_clear
Message-ID: <ezsg6zt5xjvw6f4jwikflh6x3vx6zxu7npzol7x5syl2clmfph@ywfpdvhlddqn>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <20260323031544.2598111-10-den@valinux.co.jp>
 <557gikafd5b5gryyosswktl7knexnu5gzhtd5ybgxkvdb56ftu@6ytkbxd5j57h>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <557gikafd5b5gryyosswktl7knexnu5gzhtd5ybgxkvdb56ftu@6ytkbxd5j57h>
X-ClientProxiedBy: TY4P286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3313:EE_
X-MS-Office365-Filtering-Correlation-Id: a636ebb4-6944-48a8-26ff-08deaf3dd23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|56012099003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	3df0QyqhiUfmDYf/6SLLpPUpbSBAIwa9Pc6TAq+0S1ewGhPr4qitoyEolY051R9KCZoOHUD8hyHXNSejeVN0d9oAbQ+9FcIyZTqHLroliOKTxfwtnjo2F7H1Kx3dZKvw5PK37sDCtl+idZHPCncRPovSrUHBN5qL6ZBYRYt4GN5MSVBH6kGT8PKIVQUXBQJRWbSumJbzAW5YIFgdGHJcdfy2R+okKJZ8I2JucDLGBigbKpX5vehto14ZiNBp1fwhSYwE1/JBfs8CtsAXlQku2LGnYw+yJztgLMc586upkeGZ2E4Fan9PI3v7ItaFUz+j5UpOUdhBme8E1WEjoFhyq1D2x9qY1gEnpH2nsMmg0o6hvKfMBQfCSObspPTVfqXgvx76qtQ2wlt0OsV9Y8u4DJl7P6abcWSVkHs4/+1lo0TC3A5BdtzJsBwQanDLjJQ31lfttwMd2Usf/Rb8yziezGCpYjopLvhVzWakWeDc71cqe46Shfk83D55AbrwhYK8i+6cUJt/UaJLDVFlSCpHupM2RCdA/5JYdIUIjQAh4cg+ZhlQ0XXyHqBFbXn1n14Mefy9zXfEHPJAgD9+VvCa9+LJSiShN6Hxs9UNVwQfb2QOA1QrasIcnbCQE8Te6GYwoc1h5ysuR9tu3p1lcE8iAy8JaT1lSRd2PSOkTdZwB0vEpYg5SqkePPRYnAikjmbG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG1XcmZLNlZDWlB1RHpMcGNSWUJNU28xYWtnSDdNWHRNLzBVZEdxa28rMDRS?=
 =?utf-8?B?WERBZHJOQ2VMY1RrcHlHZzRwVnNGbU05Y3JVdFM0blQvYkhlSGlxU1Zya1Z2?=
 =?utf-8?B?NlROZjliZGl3T0QxUzcxTFlsUTZPbkg3WkR4dUovTjJOb2FYMm1DNVJNNUVw?=
 =?utf-8?B?UTZBNTRXWGs3Wm5MUWZLRFpuOHJNL2JUb2FmYkE3ZUhCS1IvMjUwc3BRSjdC?=
 =?utf-8?B?WjFtMi8vZ3VUb3ArVGxHMUcySlRMdnlLYzFuSDdXN2g3aXVMczVCVU13ZHJF?=
 =?utf-8?B?ci9iN1ROZjZMUVF0eXhaWnpsVGcxQVNZRlh2elRiV0gxMXY3eGJKeUhyc0d1?=
 =?utf-8?B?SmFKaWkxZmVJZnk0aFdUT2RoUEREQmRvU3FpSm5vd0NXMGJVTHFTS0JGa2Ey?=
 =?utf-8?B?NTBNQVdpb3VNRWtRUFN1SzJwUXMxZWE5WmVQb3RlTTkxVDVrK01tMDlha1Fs?=
 =?utf-8?B?ZXZIai9BMEVqRXdtdU9jd2hNRlA5NFlUR0d2b0ZLQ012cUlXRDQ0WGY0N1F5?=
 =?utf-8?B?akJKRXMvS0FWZkZFcDRMWUF5UHZPSG9UbkRGcldScHByYjdSd25KTnpPamli?=
 =?utf-8?B?QkMwZFFVT3NLYklCYTQrVWQ4R0dENzVDYlVQdVRBMEN4Wm1mcFdKQ3Bkalow?=
 =?utf-8?B?ZXFrTlpuNDdmR0R4YThxUXBGN3N3dU9iN09lTkgwYURiSWJ5Y09hN0VNelpH?=
 =?utf-8?B?N3VzRXRKZ0d0dnFpM3NoNG9VL1JMWGRRM2lwSmcvZ3FhS3hrWXJZSk9xamV0?=
 =?utf-8?B?bzQ5Vk9ZWjM2MjVjMS9ybU9YaThtMVdZYzZFS2dadkVhUGQvUUtickM5VWkr?=
 =?utf-8?B?ZzlQd0R2RnVJWkkwMThmNkhGMjlmR3FQWmRBMDBZQXhvMy9MVXBDYUlsRUFj?=
 =?utf-8?B?R01wRitBbjdrL09JSDMrd1l3cVpodnN5RkFRL3k2TEw1WlFTWDU0ekJNdXlY?=
 =?utf-8?B?UkpuOTNKa0w0MG9KdUQrNWJQdFVPcWxNeU5naDJrOXpKVkNpQmVPL0g4YURy?=
 =?utf-8?B?RFNoV052dDgxQ3F0UUlRanVCL3dSQ0RDOGdlWVR5azRPTWFtdG93VHYybWxQ?=
 =?utf-8?B?NEJ1WHFkdVJLYWNIc3dpMFFnODExcWU5WE5FWGoxNGJqanFYbXVtdzFDd2Fm?=
 =?utf-8?B?eisvaVdLamF6cVBTVGVwaFRMODEzZTJTNEROZ2J3Nll0cSswcTg4QWdlYVpn?=
 =?utf-8?B?SjFMRXFDek94ZlNkTWZHbTU1RTZnLzhJQ0pJYkhlWVduWDV2OXZBVndpZGpk?=
 =?utf-8?B?MEtMbmZSZG5sS2hVMEtNTVNFVlJTbWlDNkVKZTdtYTVKK3RRYWJGczNEdU9J?=
 =?utf-8?B?cTFUSzRxcHJ6cGxTaEhNSHQxdXdZRENqQUFDQzNOYmlkT1loWVU0QzBJRXpr?=
 =?utf-8?B?b3dkZUN5TUtvZDZ1TDdheWd2NkpKYzRjeFI4cFRGc0JrNzRrSHpGKzJxQ2lh?=
 =?utf-8?B?YmxnRVZ0bFE3d0lSNkEzZXdBNkRTMG53bFpOcHR0MEt2Mko0d21rRDFsYkJl?=
 =?utf-8?B?RUV3MFBacnFsMnp0QlVoMXNldklRZ0V2K0UveHNNalVkRGpKM1pKS1NSRWRK?=
 =?utf-8?B?ekp5U3Y5YUxNcjJkVTFoRUpBRjBXRkcvS1JXMmdjSzQ5dmJDNU1WM1pZTUFl?=
 =?utf-8?B?SmlOeFZFR2NCTEVDc3doZVpCbldMS1ZkdXk2MUE5VlVDdHdzTFVCa2NXRzM0?=
 =?utf-8?B?SC9uUzhCR3hkbk9jd1ZjTHdFZC95MjlheXRmVnRzQzdBY0RyaExIUFBod1dD?=
 =?utf-8?B?d0xXZkV4RS8zaWRFZHh1WHBaSGZTdENyNGFkdEVpOVdxM1NDc3F0WHJEOGwy?=
 =?utf-8?B?UWlSbTlrT1dUUzgvRmJkS0VJZGdWZ0IyMHExSFlGS2RyZ21XdEJjcFBXZkR5?=
 =?utf-8?B?aFRPRGI1TVpORS9GcFM3elZtTTJDUXlEc1RYUFNOdTRCK0dDcE1RVTV5clVW?=
 =?utf-8?B?OWhNK2FGbEppNVA3QlRFL0hkdjEzOWVYVWNzN2hMaEt6TTdFR1NLanUwMXFh?=
 =?utf-8?B?b0UyWm9rSzU0anpySjdzSllGcUlRUXl0c1NOY2s1VStIR3ZtK0RrR0ZzZnQr?=
 =?utf-8?B?UXFtRis2eTRraTJwTGgyNExUdjE2NUN1MGxFY0YxTDNQWW14VEdGZ3pIajJS?=
 =?utf-8?B?Q0RXOWxoTUNJckkvcE5kZGs5TEZlMm1ibm5tY3NydTlMQXpDdFlmMnpnUnE5?=
 =?utf-8?B?ajlZUWZyR2tWbFdmbjNlSHFlZVpJUzdxbWQ2d1lDVWRXcUhEdFJZSGNUbUw4?=
 =?utf-8?B?N2pGQUY2TnFScnZKYWVrM3l2UkVNZk9vQUM0cTN1TlVVSHJFWVZva0U5bDZR?=
 =?utf-8?B?NlJNQjgxUHNBdnlnSEUyTUZ1MGZQRWpkbzZxbHYwQnV3bWpwa01nZWNnaWR1?=
 =?utf-8?Q?jArAv/V55CBNFT9LkomqkAtA623tUd5VPM/2/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a636ebb4-6944-48a8-26ff-08deaf3dd23d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:15:18.9625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsM1R7BeoZp2De4zOljsFN2FKVbyZKCOhMUWZkcXaYK25OCAyqUdR958clCMuuPHje3Mi5HRo3peMIlyiGj9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3313

On Fri, May 01, 2026 at 09:59:42PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 23, 2026 at 12:15:43PM +0900, Koichiro Den wrote:
> > The EPF driver currently stores the incoming doorbell as a vector number
> > (irq_no + 1) in db_val and db_clear() clears all bits unconditionally.
> > This breaks db_read()/db_clear() semantics when multiple doorbells are
> > used.
> > 
> > Store doorbells as a bitmask (BIT_ULL(vector)) and make
> > db_clear(db_bits) clear only the specified bits. Use atomic64 operations
> > as db_val is updated from interrupt context.
> > 
> > Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> On this patch too, but some pre-existing issues as well:
> 
> https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp?part=9

Hi Mani,

I also revisited Sashiko's feedback against patch 9.

My current understanding is still that most of the underlying IRQ handling
concerns are pre-existing. However, I realized that patch 9 does make one of
them more relevant because this series starts giving the reported doorbell
vector real per-vector semantics, so I think this should be fixed in this
series.

For the individual Sashiko reports against patch 9:

1) irq_no derivation from the Linux IRQ number

   The reverse calculation itself is not introduced by patch 9. The existing
   code already derives irq_no from the Linux IRQ number and uses it as the
   doorbell event number. Patch 9 preserves that assumption.

   Still, I agree the assumption is fragile. Linux IRQ numbers are not the
   device vector numbers, and the code should not rely on arithmetic on Linux
   IRQ numbers to recover the device vector. Since I will respin in any case,
   I'll resolve this as well in v4.

   The IRQ series in [2] addresses the request_irq() unwind problem and avoids
   calling pci_irq_vector() from hardirq context. It is already acked, but is
   not visible in mainline yet. I will therefore make [2] an explicit
   prerequisite for v4 and call that out in the cover letter.

   So, on top of [2], v4 will replace the remaining irq_base-style vector
   derivation with a per-vector IRQ context passed as request_irq()'s dev_id, so
   the ISR receives the device vector index directly.

2) unvalidated irq_no

   This is also pre-existing in the sense that the current code already passes
   the derived irq_no to ntb_db_event() without validation.

   However, patch 9 additionally uses the derived value in BIT_ULL(), and this
   series implements db_vector_count/mask(), so an invalid vector could lead to
   both an invalid bit shift and wrong downstream per-vector doorbell handling.

   So v4 will validate the doorbell vector before updating db_val and reporting
   the doorbell event.

3) request_irq() unwind / probe failure cleanup

   This is the ntb_hw_epf IRQ lifetime issue I mentioned in [1], and what I was
   trying to address in [2]. I still think this is orthogonal to the doorbell
   bitmask semantics, so I'll keep [2] as a prerequisite rather than fold that
   cleanup into this series.

To summarize, I'm planning to include the following in v4:
  - list [2] as an explicit prerequisite and call it out in the cover letter,
  - stop deriving the device vector from Linux IRQ-number arithmetic by
    using per-vector IRQ context for ntb_epf_vec_isr(), and
  - validate the doorbell vector before BIT_ULL() and ntb_db_event().

Please let me know if you would prefer a different split.

[1] https://lore.kernel.org/linux-pci/7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y/
[2] https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
> - Mani
> 
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index 67cdc5d729d5..741d30821390 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -6,6 +6,7 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> >  
> > +#include <linux/atomic.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > @@ -108,7 +109,7 @@ struct ntb_epf_dev {
> >  	unsigned int self_spad;
> >  	unsigned int peer_spad;
> >  
> > -	int db_val;
> > +	atomic64_t db_val;
> >  	u64 db_valid_mask;
> >  };
> >  
> > @@ -337,15 +338,16 @@ static irqreturn_t ntb_epf_vec_isr(int irq, void *dev)
> >  	int irq_no;
> >  
> >  	irq_no = irq - pci_irq_vector(ndev->ntb.pdev, 0);
> > -	ndev->db_val = irq_no + 1;
> >  
> >  	if (irq_no == EPF_IRQ_LINK) {
> >  		ntb_link_event(&ndev->ntb);
> >  	} else if (irq_no == EPF_IRQ_RESERVED_DB) {
> >  		dev_warn_ratelimited(ndev->dev,
> >  				     "Unexpected irq_no 1 received. Treat it as DB#0.\n");
> > +		atomic64_or(BIT_ULL(0), &ndev->db_val);
> >  		ntb_db_event(&ndev->ntb, 0);
> >  	} else {
> > +		atomic64_or(BIT_ULL(irq_no - EPF_IRQ_DB_START), &ndev->db_val);
> >  		ntb_db_event(&ndev->ntb, irq_no - EPF_IRQ_DB_START);
> >  	}
> >  
> > @@ -530,7 +532,7 @@ static u64 ntb_epf_db_read(struct ntb_dev *ntb)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> >  
> > -	return ndev->db_val;
> > +	return atomic64_read(&ndev->db_val);
> >  }
> >  
> >  static int ntb_epf_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
> > @@ -542,7 +544,7 @@ static int ntb_epf_db_clear(struct ntb_dev *ntb, u64 db_bits)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> >  
> > -	ndev->db_val = 0;
> > +	atomic64_and(~db_bits, &ndev->db_val);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
