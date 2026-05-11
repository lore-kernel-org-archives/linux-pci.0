Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021116.outbound.protection.outlook.com [52.101.125.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8E3AB294;
	Mon, 11 May 2026 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486091; cv=fail; b=n5exSZuEQipjMdP98VqSkFp2UHTHcaq1bynMHMe+PNXvX7YcUK4TW/1lM53MJgtKFbuH2YlSe9jFN0i16wuYyixwhc+uGZcU3Jkh3wFp4rdX+pX0O2fd2Qt+GjhcNi7TlAOTpGfgoCzyMmRThOR0Dbm3hWyygme6LXgLpIuh/ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486091; c=relaxed/simple;
	bh=jGqHnMhLU18YGefIwvZa+bkjRSf6P8ejD0QGy0P+CdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BDbW1SRZUSUlbkV8OtfXjPfbwCdrkglBTy7ygx2JBI7kUOmcwaerLEe+/3MkLVlv4I7ZK65khWBbdv+pK2Cgc8K2vUzjBgDx1fdHvwwCuzkovykF3dDhCdHuRFaIRiB0sVqy1pHBxzr6gw+6hH3FjVTSl1F4FGcisaCCj3XOwaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Q+HmyZiS; arc=fail smtp.client-ip=52.101.125.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Q+HmyZiS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcBUOsLdKGpS0/i0gl68s2eH9Dgx9pb24MxILQdsamO3ciR8xXFMBx6av2X3K5w77dNEEStYqPtzSqER1heqd/yHF6yb5FfQ1FEo4rb+0I7ubLSpPaq9bQvtdBtssYT+RRiyLc/MwY7DmB1cs2iRxphLnGEAOOZbPYMF/NrKH3RqaSoHgrC6JfQOSJROqmc1vuC0Me+VSimmRhlDgPtzPzagBZYIN0kA3K75Qmj560H8O/x+8WVNZjh1zC9Sv++r7ozjSTkES2YWG90v69c7cJ5gOAw7Zcw2Id9FzZeSkGE6kzUqbbqrWTF796kVWTrQ3cibo6fXOPKfPy4+CSiiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFDrYC6w+q6mJ0w1RLuJ6yPnsCBTypsYmOb5htjNS9U=;
 b=dVZwSjQGh2yGVuSeyRY4kDAQffzVVCPL7KD9CX9yCDwIJLvEzUF1MXkAIh4v67Q20H0tLIEhYoECKMVGj9QqSRw2GQCcf4SZ72I2qbZDVGkGy58K5UiOaiEmNxMUHczU5DIgEqrnq9Yd5GpCR77Mor858dlE0UNaPWbHlrUslpnIokOB0uzx8gkyndT0hhfMxEWX2aNbqnbmW+g/KINal4dunlleA3oMa2wOv931eNO4HLCBuAMb0ZE2gFhRia+myEU6yPmtLSyU21Nk2F/ZY39mo7O2vEkdCmpCssdb3I0J051h0Xl9eLYg4p5eTvUoiplvaBmXjDCDeOzstyIIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFDrYC6w+q6mJ0w1RLuJ6yPnsCBTypsYmOb5htjNS9U=;
 b=Q+HmyZiS1yM99ioUO5PRoMxOgDME+SLURcdR08RJgI+KG87vusiV96tWCroOlHwVMmfUE1rGkFCu7Rd365RRZh4WxBuPCHRTjz4wP1CWXVwfOxdj7Sf/v0DJg5RcUsLcOBNkcdvO4ZJnpvIFB9NE/Pyw2t1bazd7ZXETTqmMldI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB3724.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:54:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 07:54:38 +0000
Date: Mon, 11 May 2026 16:54:37 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v3 02/10] PCI: endpoint: pci-epf-vntb: Defer
 pci_epc_raise_irq() out of atomic context
Message-ID: <tinplj6cswgjn6x4hc3csqc6zt367kxdqgwjynudkfp7lpf2xg@mh4bbnkh65d6>
References: <20260323031544.2598111-1-den@valinux.co.jp>
 <20260323031544.2598111-3-den@valinux.co.jp>
 <khzmasyosc7dsa7brifoblaa7x7m5tw53v3ws4kmitnqewxnu3@7kssuxojrsop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <khzmasyosc7dsa7brifoblaa7x7m5tw53v3ws4kmitnqewxnu3@7kssuxojrsop>
X-ClientProxiedBy: TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB3724:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5eb43a-40b5-4424-bb38-08deaf328d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oMqiQROMwIClm14A2LyjNX6o7Y1qkjyU0Mv3yxsmsHviES9eyFtnybBGhAWlhNFFla08M6I7WRWclGLDWrAF72o5gCELzWwwD847Ho9kHwh3FMSJf5uDqFMdLKPf9JTtX3Nq6CYusiX9gM/3Xv9uEXttyNQvQbyAlEUMaAufTylsuGF/VFpMjMHZermKgNS+k5MxbBdE+4uHihsk+KJCTkRn7x7LyoQuC+tm8BnuIVGldS/9ulz8hD9KKW0E1pEqK5KxOe85YjyMBNrC4tB8j+A/K+y9dqWN9C/r6a30BtmETEJf+mGLUTRtuUZnijDQ2T8AtQYIXdLHAXB47BEjHUxHhndwMXKmTKY5kbAzNNN82WwwLLQeundvOSoE/9jxug21740lO8qIMQsWJIKbC5XOfsyUHGPtURETYYpPJL02j8jBM7O/b0volzvQiDu/uedPnvpHTPuqJ5gLemkb90g9z6Uc6/udKbHRMmNRmAjpPCVmzJb0NqOXxQFO4Eqnh9sMIOmncnBeouzRMJr/wgtsEG5UlkC1CdruTMbHlAEDIH4h8RW6QwidPWtuHXlFZdpoVqZjrQLdwEL2v1Nb94oDxCsrcgaDDRpJ0FD+R67NCGVUA61ch0aDVaNQrkiT6Iq4YaqzuAonK3hGpYVLBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnlWWXJQYW93a3crbDRNYjNOYXhJaTRObE9zWFBHTWJrWjJYY0F4em9jNXRW?=
 =?utf-8?B?UDRpVGJKMXNXNWxPa0NlUjlyb2dERGZybjlsYk5HZnc4bUNDdWhvZVI3Vktj?=
 =?utf-8?B?VFlSOEI3NEdDODUwM1c5Z0NteWk4MmR2U29FczJMazNzNm1hOHAvMW85VGc5?=
 =?utf-8?B?TU11Z01kdklTTE4yVmViZ2VqRi9mWGU3bldqSGNyVVNvMHdrdUR4cVhrSzFo?=
 =?utf-8?B?NkpXNjZjRGFGY1RYVGl1dlFPZzg4YUsybjFiRGNIVWpLSlhYZXRFTVFUWmNJ?=
 =?utf-8?B?dUFJR1pnN0p3R05tR25GNDZ3N1NVODlLZDgxRFMrdjA3dHJyblJvMVMycHZo?=
 =?utf-8?B?TUFsc094WTJGTWJYWHhFZ1lYbEdCL3gwRjl2RTczUEsvUGU0alhwV1FSSkJB?=
 =?utf-8?B?MnIwclRRMlJaSVpaZHZmOGhVTERJL1JPNndXbWtlODJKSlJNR2szZGRyNVdO?=
 =?utf-8?B?c0dNQ0k2REs5MExnTmc4WXdTL0pzY0xrdlZaVzJuTHIwVC9ZYXBudGJtMEkw?=
 =?utf-8?B?QTdxai82Q25jaXpKNDkxSFpscmY2a1d5b0FkWlBZQ2ZBVEJRQThmUS9uN0xj?=
 =?utf-8?B?Z2ZRMEtrVGR5NVFkR3k0NXhxZkwyN05mZEFKcXJBWGhDKzZVeE5OeFJ0bzZh?=
 =?utf-8?B?OXBWRXVsMjYySlNGZVZUelNjOVFxb3dtWStvVmpZVGpWM2EwZjBNRGlIOWND?=
 =?utf-8?B?aWhFNmwvZWZYdWVtbHVMRFlqZSsvVmZBdFI5ZmgvZEx6YmFiajZKOTVvcVRq?=
 =?utf-8?B?NHJNUUU1K0Noc2ZEUTR6UmRFd0VncFBlQkV1YWxmUTBtMC9mTWp1bG9icEhp?=
 =?utf-8?B?bk9hVzFGSjBDNFlCdExHLzFBY2E3bWZ6QTdmNm1wTFpFTXhWcU02VkpWVnds?=
 =?utf-8?B?d3hhTnZjM0RzclVaRXVqaFhmOEtFSHNHSzB5NjZXK0hXbWNITVJ3M2krbHRN?=
 =?utf-8?B?b3Yya2xNZUxxcmtqbWFYbkZjbmQxOEwwMGEzNXBpc2tDaWRrTXJrYytObU9M?=
 =?utf-8?B?WHBqL0xZYTM5bG5SQnVheDRnazBNdkpuNmhMa3h6S2kxbHdnQWtvQ1lRRDRt?=
 =?utf-8?B?Z2lDUVJzRVhJVjZzc3BRSnQ5QWdoM2J4WnZFR2tWVlhQKzc1V0lzTlBpbjlp?=
 =?utf-8?B?eE5mc214OWdmbDczYXUxbG1EdE9HV0ZlTWYrMnNYNDRVS0pyZUQxWlR2THVt?=
 =?utf-8?B?VjlTZ1RtK28vOWpETDgraGtIUUdzdHBpdXRLZWtTYTdGaUFOKzNyL0pYbWxE?=
 =?utf-8?B?Tms2YlJKbkRtNms2T2szTW1tL0twMkpzTEt3TjNPZGZVK0xpRnZZbXFSLzJp?=
 =?utf-8?B?OEZzWlUrTmpCMlp4SUUvTHJEMWFJR3doRWRrYkRBOUdPQ1U5NWdHRWZLWjJh?=
 =?utf-8?B?WXNNNWJUQlZvaU0rbEZOUTYxSHg1cmc1SXdNbXJvVGtvRXhkNEpqYUU0SDhj?=
 =?utf-8?B?dDhCN3ZFSGs1SnI3WHNkUW1vRDVTM3hwd0dOeVBOTm0wSHpSK1VlQlZRRXNm?=
 =?utf-8?B?OSt0d3ZMdzZTL1RCYTdaR3lRM3pIVHFIYkttSXVWYTA5NFdLQ3ZOWHVQL2hz?=
 =?utf-8?B?ZWVrTXhXWVhzWG1GNlRDNmJEZWRPdmVEMkxjUHV3dWN6dzBVYUpwWjlzb0dT?=
 =?utf-8?B?d1RQTzJaYkliR0kwT3pGQUhvR25Jd01qNEZZbVIvMXVBOFJDQXFOSVpkRWkx?=
 =?utf-8?B?ZHZNV28yL3g0ZXdUeU13VXhaSFJKMG9Ccnd6QnJhRktpZ1cvS3JFd3NHbXRV?=
 =?utf-8?B?UzZOZHlWQlo0cnRkVDFuU3VsM2s2K1A3SWh0cFFGOXBTUXFzWXJHRmFSSS9W?=
 =?utf-8?B?enhhK05xbzNMTUozMWlhRkR2WWVnajFDT2k3YkUvUm8zOVhBOVV2WEI1c3dj?=
 =?utf-8?B?aUhJZHlsVWFhUVU3SEozd2pza3FyTTduM05VcWtSb3JEZnU3cTlCZVdiS1Nn?=
 =?utf-8?B?M1hsQmRvcDByemRCZEZqTzdFUjhYR09VVlgrMVlzUXBLbGVwMFBqS1RaNGsy?=
 =?utf-8?B?NWRxYll1bjhxNHlsVFNheE5CNHFKU1RTNFNZODBuMUJiekJTZjVPRWZMd1NE?=
 =?utf-8?B?Mzk4cVJWckVFSnBWZlY3MDNoaWFnL0pwMWdHbnZIL2gwZGxpdTZHcFF1Rm1v?=
 =?utf-8?B?YU1QdElIc1EyOTBkWXpiekJudFdNemlKQmo5L0hVV2FuaWlMU0V6cy82SUIy?=
 =?utf-8?B?SEVlN2x3UGpoSXVOMVpmMm4vZ1FIeE5NVmlNa0FndU1DWDRMdUNxdzZnQUZD?=
 =?utf-8?B?TUNTT3ZTQmR2VHdtYzZSNGpUOThiaXkzbEo2a3h6VVVsZDJnWXlKRVQ2UlFP?=
 =?utf-8?B?b1BXNHB1OXZoN0tab2phM1ZKT0RkREtYbWh6VEtQNHBkQWhNTThUZmsvNFdS?=
 =?utf-8?Q?xxh19QuRJvXIdaXj68l9WW4fp12RYcafFzoBK?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5eb43a-40b5-4424-bb38-08deaf328d29
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:54:38.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pEHS5HqZadEXmlpCoKsDV4AARwgYq3o/0UgLFC2JYsyMPqOb+OzOannr70tk6Hhx9ziuEkbhp9i+pwot7JaFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3724

On Fri, May 01, 2026 at 09:56:36PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Mar 23, 2026 at 12:15:36PM +0900, Koichiro Den wrote:
> > The NTB .peer_db_set() callback may be invoked from atomic context.
> > pci-epf-vntb currently calls pci_epc_raise_irq() directly, but
> > pci_epc_raise_irq() may sleep (it takes epc->lock).
> > 
> > Avoid sleeping in atomic context by coalescing doorbell bits into an
> > atomic64 pending mask and raising MSIs from a work item. Limit the
> > amount of work per run to avoid monopolizing the workqueue under a
> > doorbell storm.
> > 
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes since v2:
> >   - Resolved a trivial context-only conflict after
> >     d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup")
> >     landed in pci/endpoint.
> > 
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 106 +++++++++++++-----
> >  1 file changed, 78 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index a75f8a30f8dc..bc3b3df53ddb 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -69,6 +69,9 @@ static struct workqueue_struct *kpcintb_workqueue;
> >  #define MAX_DB_COUNT			32
> >  #define MAX_MW				4
> >  
> > +/* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
> > +#define VNTB_PEER_DB_WORK_BUDGET	5
> > +
> >  enum epf_ntb_bar {
> >  	BAR_CONFIG,
> >  	BAR_DB,
> > @@ -129,6 +132,8 @@ struct epf_ntb {
> >  	u32 spad_count;
> >  	u64 mws_size[MAX_MW];
> >  	atomic64_t db;
> > +	atomic64_t peer_db_pending;
> > +	struct work_struct peer_db_work;
> >  	u32 vbus_number;
> >  	u16 vntb_pid;
> >  	u16 vntb_vid;
> > @@ -920,6 +925,8 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  	INIT_DELAYED_WORK(&ntb->cmd_handler, epf_ntb_cmd_handler);
> >  	queue_work(kpcintb_workqueue, &ntb->cmd_handler.work);
> >  
> > +	enable_work(&ntb->peer_db_work);
> > +
> >  	return 0;
> >  
> >  err_write_header:
> > @@ -943,6 +950,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
> >  {
> >  	disable_delayed_work_sync(&ntb->cmd_handler);
> > +	disable_work_sync(&ntb->peer_db_work);
> 
> Sashiko has flagged a couple of valid issues on this patch. Could you please
> take a look?
> https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp?part=2

Hi Mani,

Thanks for the pointer, and sorry for the late response.

I revisited Sashiko's comments. My eralier reply [1] grouped the patch 2 reports
too broadly under follow-up lifecycle work. After going through them again, I now
think two of the issues are local enough to handle in this series, while the
driver-unbind/.remove part remains part of the broader vNTB lifecycle work.

For the individual Sashiko reports against patch 2:

1). peer_db_pending

    The EPC unbind/bind path is already not fully safe today, independently of
    this patch. Some of that was discussed and posted in [2], and the remaining
    .remove work is still pending (sorry about the delay).

    Nevertheless, patch 2 adds a new deferred doorbell state, so v4 will clear
    peer_db_pending after disabling peer_db_work in epf_ntb_epc_cleanup() and
    before enabling peer_db_work in epf_ntb_epc_init().  This is intended as
    local hygiene for the new state, not as a claim that the whole EPC/EPF
    lifecycle is fixed.

2). ffs(db_bits) on a u64 mask

    I agree this is worth cleaning up, although I would classify it as a
    pre-existing hardening issue rather than a newly reachable bug in patch 2.
    For valid doorbell masks, the bits are expected to be within the supported
    doorbell range, so the upper-32-bit case should not be a normal input path.

    Still, the callback takes a u64 mask and patch 2 stores/drains it in an
    atomic64_t, so relying on ffs() implicitly truncating the value to int is
    fragile for future changes. I will make the supported-mask invariant
    explicit in v4 by masking unsupported bits before walking the mask and by
    using a u64 bit iterator. This should not change the behaviour for valid
    doorbell masks while keeping the existing DB#0 -> MSI #3 legacy mapping
    unchanged.

3). possible peer_db_work UAF on driver unbind

    I still think this belongs to the broader vNTB lifecycle hardening work.
    Driver unbind while still bound to an EPC is unsafe independently of this
    patch, and the real fix needs a .remove implementation that unregisters the
    NTB device and drains/cancels the work items, including the newly added
    peer_db_work. I will handle this in the follow-up lifecycle series to [2]
    and call it out in the v4 cover letter.

So, I'm planning to include the following in v4 patch 2:
  - For 1), clear peer_db_pending in epc_cleanup/init around peer_db_work.
  - For 2), make the u64 doorbell mask handling explicit by masking unsupported
    bits and iterating the mask as u64.

Please let me know if you would prefer a different approach.

[1] https://lore.kernel.org/linux-pci/7jkibbdz3m3vuq2kq2xxnkt2rjdt5v7itgowc7qormtwgnf6tv@krl5brfjul5y/
[2] https://lore.kernel.org/all/20260226084142.2226875-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
> - Mani
> 
> >  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
> >  	epf_ntb_db_bar_clear(ntb);
> >  	epf_ntb_config_sspad_bar_clear(ntb);
> > @@ -1357,41 +1365,79 @@ static int vntb_epf_peer_spad_write(struct ntb_dev *ndev, int pidx, int idx, u32
> >  	return 0;
> >  }
> >  
> > +static void vntb_epf_peer_db_work(struct work_struct *work)
> > +{
> > +	struct epf_ntb *ntb = container_of(work, struct epf_ntb, peer_db_work);
> > +	struct pci_epf *epf = ntb->epf;
> > +	unsigned int budget = VNTB_PEER_DB_WORK_BUDGET;
> > +	u8 func_no, vfunc_no;
> > +	u32 interrupt_num;
> > +	u64 db_bits;
> > +	int ret;
> > +
> > +	if (!epf || !epf->epc)
> > +		return;
> > +
> > +	func_no = epf->func_no;
> > +	vfunc_no = epf->vfunc_no;
> > +
> > +	/*
> > +	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> > +	 * Limit the number of snapshots handled per run so we don't monopolize
> > +	 * the workqueue under a doorbell storm.
> > +	 */
> > +	while (budget--) {
> > +		db_bits = atomic64_xchg(&ntb->peer_db_pending, 0);
> > +		if (!db_bits)
> > +			return;
> > +
> > +		while (db_bits) {
> > +			/*
> > +			 * pci_epc_raise_irq() for MSI expects a 1-based
> > +			 * interrupt number. ffs() returns a 1-based index (bit
> > +			 * 0 -> 1). We historically add +2 to compute
> > +			 * interrupt_num.
> > +			 *
> > +			 * Legacy mapping (kept for compatibility):
> > +			 *
> > +			 *   MSI #1 : link event (reserved)
> > +			 *   MSI #2 : unused (historical offset)
> > +			 *   MSI #3 : doorbell bit 0 (DB#0)
> > +			 *   MSI #4 : doorbell bit 1 (DB#1)
> > +			 *   ...
> > +			 *
> > +			 * Do not change this mapping to avoid breaking
> > +			 * interoperability with older peers.
> > +			 */
> > +			interrupt_num = ffs(db_bits) + 2;
> > +			db_bits &= db_bits - 1;
> > +
> > +			ret = pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> > +						PCI_IRQ_MSI, interrupt_num);
> > +			if (ret)
> > +				dev_err(&ntb->ntb.dev,
> > +					"Failed to raise IRQ for interrupt_num %u: %d\n",
> > +					interrupt_num, ret);
> > +		}
> > +	}
> > +
> > +	if (atomic64_read(&ntb->peer_db_pending))
> > +		queue_work(kpcintb_workqueue, &ntb->peer_db_work);
> > +}
> > +
> >  static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
> >  {
> > -	u32 interrupt_num = ffs(db_bits) + 1;
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > -	u8 func_no, vfunc_no;
> > -	int ret;
> > -
> > -	func_no = ntb->epf->func_no;
> > -	vfunc_no = ntb->epf->vfunc_no;
> >  
> >  	/*
> > -	 * pci_epc_raise_irq() for MSI expects a 1-based interrupt number.
> > -	 * ffs() returns a 1-based index (bit 0 -> 1). interrupt_num has already
> > -	 * been computed as ffs(db_bits) + 1 above. Adding one more +1 when
> > -	 * calling pci_epc_raise_irq() therefore results in:
> > -	 *
> > -	 *   doorbell bit 0 -> MSI #3
> > -	 *
> > -	 * Legacy mapping (kept for compatibility):
> > -	 *
> > -	 *   MSI #1 : link event (reserved)
> > -	 *   MSI #2 : unused (historical offset)
> > -	 *   MSI #3 : doorbell bit 0 (DB#0)
> > -	 *   MSI #4 : doorbell bit 1 (DB#1)
> > -	 *   ...
> > -	 *
> > -	 * Do not change this mapping to avoid breaking interoperability with
> > -	 * older peers.
> > +	 * .peer_db_set() may be called from atomic context. pci_epc_raise_irq()
> > +	 * can sleep (it takes epc->lock), so defer MSI raising to process
> > +	 * context. Doorbell requests are coalesced in peer_db_pending.
> >  	 */
> > -	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
> > -				PCI_IRQ_MSI, interrupt_num + 1);
> > -	if (ret)
> > -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> > +	atomic64_or(db_bits, &ntb->peer_db_pending);
> > +	queue_work(kpcintb_workqueue, &ntb->peer_db_work);
> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static u64 vntb_epf_db_read(struct ntb_dev *ndev)
> > @@ -1629,6 +1675,10 @@ static int epf_ntb_probe(struct pci_epf *epf,
> >  	ntb->epf = epf;
> >  	ntb->vbus_number = 0xff;
> >  
> > +	INIT_WORK(&ntb->peer_db_work, vntb_epf_peer_db_work);
> > +	disable_work(&ntb->peer_db_work);
> > +	atomic64_set(&ntb->peer_db_pending, 0);
> > +
> >  	/* Initially, no bar is assigned */
> >  	for (i = 0; i < VNTB_BAR_NUM; i++)
> >  		ntb->epf_ntb_bar[i] = NO_BAR;
> > -- 
> > 2.51.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 
