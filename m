Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021080.outbound.protection.outlook.com [52.101.125.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC7416841;
	Thu, 15 Oct 2026 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048225; cv=fail; b=rtqcBb9sOjDWy95KNgPXX6KA93C9g16FqLjhtWhW/i8+6oCAIrPRKBIoE6NkNXWqfZv1AQGprRxtRBuTZ8xeLSs0Bg9JABj4pE75xtodrn3HwTm897JgpqzhiG4WIbP7AAYaPgqNipEHw13dgF5PhI9p22Q4Z5TpA5998EQkFQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048225; c=relaxed/simple;
	bh=XPyLkz6tY7fHIk2D+o8pW3I3QB1Oj6ykvpXrsr4yZ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J2Kdl3NC6zZkE8EXmqlopSjdGJJPQmOUHMhcgNWMeGPIhC6YVZt7n9jzqwVUjouPzGDnCfSjc0dOFD5rL9NPquKOhpY4HtonosW8SFYgPUmfLa6f/ZVhxvhnBmc5LQzH/bBpDbh2xGVsbUpGV9j8rBIIIYQtNZiOY+yNWaRhvHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PnVvjaMP; arc=fail smtp.client-ip=52.101.125.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PnVvjaMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/CFaYpoQAkhieX7Hjipk2WR5FBHGvMh4chRa+2EXMQETB/wHa234Aj6gIKdiI4O39QsQugFPLsVbQi/0KKNSuPg4M85/x2L5Q62WOYhrOsZLf1e3JRVK4Nr7W/tlDBhOr0vWYJfea+YWkeOAJLCPDMZOKna/hKtgvTiKfZ24/f+umm1yRZLnpC1hCf4eyIULaDbIIayB23moUNpVu99Mxhz43c+dP0DuLVXbHpqRs7O5mqiuDdOOARMRt0UX7a+iQTtu4nxGe0Vc5vLP4T3UGEtWNsQGoIZLuNhC7pHiMa6CSBJYupJy+IDCEHvouMolFp9v2HF9AlRqxl+hfPooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wELAVMVHZrMgwP9UwI0X3Ycryo8GRK2UHoFEvFCacKM=;
 b=mYVr0eSUe2e5U4Gi2SznYlDG/iHwlXThieVk9yVOQyHaMhu8fxRSeK1q9af5jjfPZVgDgb30H0NiX0kmL4qfwL3g/IwiF0r0lh0YqgViQJ5952XU+3L+828r8FbkCpMfxhXYzCW69f00uSZiIcDQvqP1Ros6Xe7oo0+/6FhrUZ/+HSXC4FJascvSUe+xxf9/ZyUpOqgZ678PvdtVL8kin6JZooRYXuzZPwnaaeOujXSC5yh1+QSrLz+/Ljqu2kZuOkb9t3aBuglBISpcBcmu4xyP68PElzOqhWe7hDLUpvX/DhTgXufyo5V1jwlEYid+nT27P9VkCTvDVncYh9II8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wELAVMVHZrMgwP9UwI0X3Ycryo8GRK2UHoFEvFCacKM=;
 b=PnVvjaMPVasE5icxWQ+ibyCVTW7nxv90bhVyIVFVLJAEK0H71pLHMeZ+KKLyOdoXa6mjsZ87ZHhNohWiTo8q1nMVvDYT/ciCjvfxZWgnVjPNiUsHwqnjty5iLXv3kXe4GOsCUhAbssrxZ/jOi5MTyZ1mWUq55CIJaxLv+hcYQNo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB521575.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:518::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:10:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 07:10:14 +0000
Date: Thu, 15 Oct 2026 16:10:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Message-ID: <xva2fpj23ijtdzfm2kgmtsnhyzpmizprboisrxstx42vthleww@n6v5bjos2pkk>
References: <20261014071448.2473208-1-den@valinux.co.jp>
 <atBuBPXKlQJLnBXL@debian>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atBuBPXKlQJLnBXL@debian>
X-ClientProxiedBy: TY4P286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB521575:EE_
X-MS-Office365-Filtering-Correlation-Id: da84e839-78c7-4107-8c44-08df2a8b5bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|23010399003|56012099006|4143699003|261009223027099003|18002099003|10067099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	CQq0IsHI3r8RnsiqHqHt2E0i1ZxlWx7HBAoFbvAnrK2hDPm/C4cr5aMWu6H399DbAKzbUXG7WA/eKbKcgn7GGoYDSEP/kVQzKXiaIjI61biVbsm1pIKMsriqrQkPebQqaPNvqCIEiCdnzDzRgT35h2KeMYAJVzJV3/O7wzvgGBWUsReGMmb0rI/QXq9n+lr4xFPVvXjPId8JYMpD50ftwRDotXP7jrbdCsH937qXIZw4M0J/Y/Z51LHNuaGh4tJYWv8wIee/qBqXfVqAgPcLHiwtkbdaXU0ZzK0y+PqHSu4a0RnEAOhWV+MwprxAQp9C0L6dYv0cHinllN9QOULjmc35zTWmBrx138Pg4C89zhtLHYO6k78AAEjZNV24AhBaNp0+50l6adJ/RdxkwBLojargDUlnB/DT5t1TBIN8qHFxak39mKhvPfvMN/V6IuLdoYkSDovbo53IjI0Dtv9zXgw8HYI2q5pisJUBDCe5LjhmYyXZjIIysedg+5ZPYoRzOQDBY8nZf9lFv1xmWulQgGVx17XecWERDfKQpnPLEonGRYhQdfen0uFL2cu6GaX0wfxzU/hIlVXXLGPlTR1NpctqcW/RHu0W52jhXgrgz1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(23010399003)(56012099006)(4143699003)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjFtTmJBdVB6K1hWaENSOHNkeTF5NDVNVEZGNTVWSGtaT2s2dWlNd2U1V3Yv?=
 =?utf-8?B?YXh1UkhlWjdDSlpKdFBMTmp2b0xXRWJXQ3B3eHB3QzRCN0dEYmlMMWQ3MmJ1?=
 =?utf-8?B?NFdxMjdFeHQ3eWYyTm1CZzFYMDh0WWVjeE1KZDk2UmJNYnZRY3pRRXJIa3ZZ?=
 =?utf-8?B?QTFwamJmS3VJMFgrVkNZU0I1dENyeUc1NnhvZ0w2K0s5Yy9oYmx3UzlrUDFm?=
 =?utf-8?B?aWhmYnFaRWlvbHNhWC9RSE51VzU1aWxCYjNsOUdkNEdqbGxwRFBIN1FlOFl1?=
 =?utf-8?B?NzNBcUExTTJxdmliRndtQUZYa0hvR21zNk50YnMyMklYOUtTRWFKNlVZaVdU?=
 =?utf-8?B?RzZYQVN2QmNITXlVYUExc0hzdi9SYkN6eUtVRE9BdG1oR1JNekZWRlZZL3Zy?=
 =?utf-8?B?RzlmSGdrTC91WjhPeDVreU5aMzdBd2RBbFY5cnJuY0R6QVhxSFkxVVVNVmoy?=
 =?utf-8?B?V0x5cGNtN01VbUVZVlFLV2ltSnZGWEdpbWthNlM0cWJQWGNualpSWDRNNjlO?=
 =?utf-8?B?L1ZaVzVZNjJFQ0R0V1FSbkNlMXR2OHF6MEV2Yk40YlhJWXNCb0F5UG9HbHFw?=
 =?utf-8?B?L1h3Nks4eU1QU3daa2NvazhKeGZyYXdvV2k2amRqVVNpRGNmTHhtRWNPMlRC?=
 =?utf-8?B?U3JmSjlHZ2NoMHh6OW9xT0RLMTVxWDd0eFFJOHZWVVM4cEloR0JOWVZMZ2Iy?=
 =?utf-8?B?Z0pDbVdnZUgxSU9nWGRudUdRdE90dkVtY3h0OWI4cnFQRnNONVJkU1ZDb1VC?=
 =?utf-8?B?a1h5eE8rN2VVTEVmNmZhajMyQTZvVDcwS2V6Zm1rQlBDYUhPUTFDdTVvaG5j?=
 =?utf-8?B?dEJENTNveU9sQnlYRm9tV1BUZGRmRnlsNDRuMXZVSkVTMlI5RGxIWi9oZVY1?=
 =?utf-8?B?MHF1emRKcHZCQk42TUZDTkZObG1DMjFNQXpTdFpIQ3lLQzRyanpjRFd2NFZy?=
 =?utf-8?B?Sm9scFdBR2YveS8wNDRhdHVVaHQ4bXcyUzJRMGg2U0F1UFJoalJxMTBSV2Y0?=
 =?utf-8?B?aUkvWWdXSnNFa1pyK2dPbTQwZWdDU210ZzBKaUR3QmZGM3RYL2IyQmlNZ0VU?=
 =?utf-8?B?THFxUWxLazM0cUJ0UUdKMVMvREZxOFpPVXFkVFRKMGRXbmp2Tjc1YnEwTDF3?=
 =?utf-8?B?UjhKVkY4dVJqNS9OUDNXLzNWaW5iRUtLSTJ5cjg5SXY4ZkhKUWZVSng1MmZV?=
 =?utf-8?B?YnFySHlZU3NLYUlkOUxRSUV1SEtGVW1QQmlwdmVqYnVtN01ydU8rY09sbmJo?=
 =?utf-8?B?dTJBOU9OcVpJQ3oxdGNPM3k1eHdwc25CMTJoNCtYN0xDMThZUGF3c0d2Yk5i?=
 =?utf-8?B?dWZjYWR5cm45eVhzV2RzUHJCNzZhWWdQRTVxNElaOWRMS1pkSjZsbmZXQUQz?=
 =?utf-8?B?TG9WOFNrNEZNc0p2cVEzV2tNOEpCSmVkT251V29KS2hBaE0vN1JjNG9NYUxz?=
 =?utf-8?B?ZEJHS05CbjUyRm82LzY2TER3eWZPYmZ3VjNpZzlKc29keFNQUytuQzBweVc0?=
 =?utf-8?B?TmRvdEh2V056UURmcE11Ukd5SExKalBUYmdjSTFxRGJjdjdvSTFKNWFTdFFX?=
 =?utf-8?B?VHpoZGw4MklTV1ZKUmx4aHVQM0VvaXlKRTAvUE9qMUlQVmNZekJnMTZEd29F?=
 =?utf-8?B?SEg4bHAweW83V1pBMEpLR25KUXBsT0Zad251ZzJxTVM0cXQzOHQxcDVEYlJU?=
 =?utf-8?B?eTIzcENXNk5tSnZ3Z3NIR2Z3b3FLaVBVYnZWYzJsZGpsVGo0Mll0TEZkYlZs?=
 =?utf-8?B?OCs0YWkwRWFVTEZDMHRuRUE2RTVicCtneGErT3hVcVh6ejJBM0xkeWUyNXFy?=
 =?utf-8?B?MG03M00yRWRXL3N6Wm04N204UGNLL0FMRFRXYmpsZmNoZWk1dXRGUjJuM0da?=
 =?utf-8?B?NmJIQ1hqT2F5UTJxd2FLZFFBWUtXNU5FWUFaS3J0dndUTlpyZVBMMStCQ0Zs?=
 =?utf-8?B?RUtMN2dVVTlNRDZGa3dkNERuc0J0Yy94d2FaT0pBUi9yeEk3akk5cmhVQXhp?=
 =?utf-8?B?RW8vQjR4S3JpeHM0SkRBdnJyM1g0OTZJRnhCR3BNUEt6dGJ1ODloWkFFK0hN?=
 =?utf-8?B?VHB2SnpHK1lpMzYyNlI5WkhTN3Vva2s5NUdsQk1HV2RJR2hJTFVpTi9wN3c3?=
 =?utf-8?B?NlB5TVdZN0FEL3MvN0puSmNNQm9mbFZkbFlXT2ltY2w5TTNTOW05cWFGMWZj?=
 =?utf-8?B?RHZYS3VqT2FzRzVSSW1DUDU2cEtpU1I1OFVXQU9DOHJ3SFNzNXptY0pmYlZN?=
 =?utf-8?B?d2xNZEdDNzErR2tQQXJaaTBodlhtaDZnWVdLcnJ0OFRwOVNUUTBTRCtNK2dX?=
 =?utf-8?B?RmZSaXZNMGM0MnNtUWF2UlhhelRDR1NtM3JIdGg4L1Y5K0pjeVBiMFB6dTVC?=
 =?utf-8?Q?vewvb8mLppCigr4OkovKRlNpfzuNYVkOFduBs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da84e839-78c7-4107-8c44-08df2a8b5bdf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:10:14.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbrjgFeu04JcXIfmH1GwCMDI/uTvFsLLgxzsSPgi5NPY1XvzwtWeOdqOMVz7F/BenNCKZ97fZufWz2JJCE7vCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB521575

On Thu, Oct 15, 2026 at 11:44:46AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 14, 2026 at 04:14:48PM +0900, Koichiro Den wrote:
> > The control-region link status is currently updated only by
> > COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
> > NTB link callbacks are empty. Consequently, the HOST can see the link as
> > up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
> > leaves LINK_STATUS_UP set without notifying either NTB client.
> > 
> > ntb_netdev can hide this device-level state bug because ntb_transport uses
> > a separate per-QP LINK_DOWN_FLAG message. Use ntb_tool to observe the
> > device link state directly:
> > 
> > After bringing both sides up, start one waiter on each side:
> > 
> >   HOST# echo N > /sys/kernel/debug/ntb_tool/<H-device>/peer0/link_event
> >   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/peer0/link_event
> > 
> > While both waiters are blocked, disable the link on the VHOST:
> > 
> >   VHOST# echo N > /sys/kernel/debug/ntb_tool/<V-device>/link
> > 
> > Without this patch, the link-disable command succeeds, but peer0/link
> > remains Y on both sides and neither waiter returns.
> > 
> > Track HOST and VHOST enablement separately and report the effective link
> > as up only when both sides have enabled it, as pci-epf-ntb does for its
> > two physical hosts. Both NTB clients observe this effective state, so
> > notify both sides only when it changes, including the side whose request
> > completes the transition. Serialize the two paths because HOST commands
> > run from delayed work while the VHOST callbacks may run concurrently.
> > 
> > With this patch, peer0/link changes to N on both sides and both waiters
> > return.
> > 
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v3:
> >   - Rebase onto the latest pci/endpoint.
> >   - Drop redundant dma_wmb(). (Frank)
> >   - Retest using ntb_tool.
> >   - Link to v2: https://lore.kernel.org/r/20260904162049.3432464-1-den@valinux.co.jp/
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 90 +++++++++++++++----
> >  1 file changed, 73 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 07ba338732d4..a11f9260ee86 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  #include <linux/slab.h>
> >  
> >  #include <linux/pci-ep-msi.h>
> > @@ -147,7 +148,10 @@ struct epf_ntb {
> >  	u16 vntb_pid;
> >  	u16 vntb_vid;
> >  
> > -	bool linkup;
> > +	/* Serialize HOST and VHOST link state changes. */
> > +	struct mutex link_lock;
> > +	bool host_linkup;
> > +	bool vhost_linkup;
> >  
> >  	/*
> >  	 * True when doorbells are interrupt-driven (MSI or embedded), false
> > @@ -183,24 +187,54 @@ static struct pci_epf_header epf_ntb_header = {
> >  	.interrupt_pin	= PCI_INTERRUPT_INTA,
> >  };
> >  
> > +static void epf_ntb_update_link(struct epf_ntb *ntb)
> > +{
> > +	u16 link_status = READ_ONCE(ntb->reg->link_status);
> > +
> > +	/* The link is usable only after both sides have enabled it. */
> 
> I see a bit of ambiguity here and it is confusing. This comment says that both
> host and vhost has to enable the link first. Yet, the variables are named as
> '{host/vhost}_linkup'. Also, the functions setting these variables are named
> as:
> 
> 	epf_ntb_link_up()
> 	vntb_epf_set_link() 
> 
> Even though these two are doing the same thing but on different side, these two
> functions are not symmetric. This needs to be fixed up.

That's indeed a fair point. How about the following renames?

       v3 (this rev)               v4 (next rev)
  --   --------------------        ---------------------------
  #1   epf_ntb::host_linkup   =>   epf_ntb::host_link_enabled
  #2   epf_ntb::vhost_linkup  =>   epf_ntb::vhost_link_enabled
  #3   epf_ntb_link_up()      =>   epf_ntb_set_link_enabled()
  #4   vntb_epf_set_link()    =>   vntb_epf_set_link_enabled()

We might as well rename the 'link_up' argument to 'enabled' in both functions.

note:

  #3 : This is an existing function, but with this patch it records HOST
       enablement, which does not necessarily mean the link is up. So I think
       renaming it in this patch makes sense.

  #4 : For symmetry, I realized that the VHOST helper could use the same return
       pattern:

       if (notify)
           return epf_ntb_notify_link(ndev);
       return 0;

If no objections, I'll respin accordingly.
Thanks for the review!

Best regards,
Koichiro Den

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
