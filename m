Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021137.outbound.protection.outlook.com [52.101.125.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA783812C2
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400794; cv=fail; b=t2qi/nL7YKTxiqrELiNYoLYydYLzc8ySgPc6bXVWIL0s5N0xgK7T5kRHjqfn0PAuqfRq7mtM873sfLcjoLxtpbbrWtdezl8un6b2JFaZ6/lKKS17CYoCrjiW+Y5lNhWS6w6yv16oAjJH7U9r2q0DRw0J3cydQMLO5GBwJn3ShpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400794; c=relaxed/simple;
	bh=i1DU4lCLCofifImI6yabFrnHjn2GE3twADtqVUWLqKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pT2tqiqZqO8cl22anNzPM0nAoMasaYrzZF8bDHiOtfEyfSqG8d5ELrOO6GgdSdkidZt1d/Hr/yBm5B8h0Io8bJ78utbqF/DphzDpimFz/3t+d4s9h4ZxSjYcmFW6+ACo1hgI1HoidpHqzpidgpo+swNnQVW8LAu92HxwPGnYHRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kySf1Lp0; arc=fail smtp.client-ip=52.101.125.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kySf1Lp0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUUG+PdGFIVN9fs+4/DWCn+G4CyxobCdVqeSWMDLnZsdpj8unx0kJmKGd63mhboyvF5HkD4pvoxTm0eyg4NK6HECOmh1TWjg0rX/Lp12LiIJBKpBJ78qpnZSuLgLbLiLqChypbUzduUBFU5/fbilPVuDqGKqpOy9LfSkC1iTpVRxZD+bIHO38FH9mBMSCzzthSRka5INzJTNFgH1wb1Ueq+AFwufzbeN2Wj+T9qkdatQxnXT0LUIQUK+XZ0ObzkfnKSFiY7kI8fAI3vkiFpYa/ULPj3lpDD7ALGaRbST4mv45VZtriKZeBcGDVI/20cjhMEw8Fo2QolJjZ+TrLyc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPVy42Hs79r9K1wJUMJyJH7cZx4w0PAiNpvcHznPTWo=;
 b=VTymk1upRiDy5GpM0ejkTv2ISIh/3+Db7yE/J6YR1q5WiuhQo8oITG4SFogz8DvwguOyJZpatYZxp/DxGPAB8O88BnoydvL+B3dXSCWM4POhrTrQ3BYuW0dKU6Awmf5aRVUtTkD2GPBCB6XCBggHuCJUWWUqDoGA+qhgS6LcaDQ0UeYzHY9rmqd6hWxRv4sUg7jThoP2LQlM4v2R73uMEVPyRz/Zdu++Wm7C0gDWYiN1s6XyZTJHteVO2kbyryKk/5r2fO4xiyPacZeY8B5Usy4wUn0+Gtpts/Sz3ggQ0uLrgnbUxRlUhepeqzbijkX41x8z/lYlDKB4amuPPCACVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPVy42Hs79r9K1wJUMJyJH7cZx4w0PAiNpvcHznPTWo=;
 b=kySf1Lp0QAeWgJs99wBBjCQPI9JB35svfuyByWk79OaOXuf/UbplnDA7bKWoxoO5P+3us1zcFOsOWwuSFbdE7je8lBueaG5mvxQ1A0uVI8hP3e7VPdaeCtXTB4H9j3UTAZxjVdn8vMVYAmXpYBCN4adovr1wMqxY+lvwt660Rr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4603.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Thu, 30 Jul
 2026 08:39:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:39:47 +0000
Date: Thu, 30 Jul 2026 17:39:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: DWC eDMA weirdness
Message-ID: <egai6rd3umstjhkuelrnemr2ywjlfccfk4tipaxodav426wxex@kuu76gvznusa>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <ampndLtU32ODmncX@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ampndLtU32ODmncX@ryzen>
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bdeb505-a183-4b70-0313-08deee161cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|376014|4143699003|56012099006|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GUBHb920m+RJxH391oBmF4/p6sgOgIjwVzg7y+y1hMsCYSunqzesQqyJVvmxgKpTooQLpgWeKPcHrc2MqXudess4INUCjIqky7WapDOlUB+ggT5UJOHgJa/mPzb73i+PDCBhqnIAxy9+WnC2oWHfCIcRuvqtd4NshJNtL1i6v0MYTBAMwXl+6Av7eKgujMtlJKTA64TPeyJseYVNxrIJkV7KMptOaqgrqx4v0OIYEgWLJF/+ydBKV7SRhU4jLgGwn1sEYp2Is5jI20nTaHLt6iLg7Psn4h+lbQ9TQ813qU8ZLShVbBmIrmu5noHlonVx26k0s0TBzTq4tga/YecMjMlmsFfUIl73Aut/40abKHSYd1v6EZIkU2F5W2lquUTOnqfAFdopFL5scyc7z94Aq36AwOcY1DpS/QI4wqn69HZjkv6ftRpS2e+iONHFcuXwaK9G2kYIkafjgwAJ+7iJekMtKJfD4OL9RTlYP72A/WxClECgWACZRNe4zhPZq+Wtbh/Xi1P351hIyZLxsIzih+aTDkFabL7Uu2lv4ibvMsA3urnxhR7QI3Mo+zPsNouE8FK0gQtu/zuvISnpB4Y2+I4R3VKR9FhVHtDIV6d/xTlzsjKCarS/Y495wS4c9LVP7TCtgif4VJW2E1ROU8ms9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(4143699003)(56012099006)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?97tPdaf5dKMGYr4PwW9lan45jJNwbtOXzEV9yeNo2BI7e4FLFJRaTnQsjv1p?=
 =?us-ascii?Q?IGItb2oLU/xe2rJdDL1qQmAjSj75N6F+wVLEV9kmtKa0bspMTdq7dZYGFW7o?=
 =?us-ascii?Q?yTW1QyoHDmzWlVbntJ8UJHdKPaRrVjW1ihpW3ixLfJ+X3bq9fVZhc44wn0EP?=
 =?us-ascii?Q?WSDlNUJ+NPxppLmHqMpjN5e5umdTQboVtgZx1S2zhhnvklO9Z7NXtiXpikAE?=
 =?us-ascii?Q?NoCRQZJ8r/6I+GcLUlGE4aD8+DcIvViPT6SzGPsZiSPqZx0seSP6hOGHDFFC?=
 =?us-ascii?Q?l+oQvGSNJj3xGLTFEluF4+inHUc2TL2n2eQk2Kq6ZgMYhyQlRGldQlMITnX0?=
 =?us-ascii?Q?xT09gja9UnQWDlVoFaT4knfvkNxwF/46iC9RPW7hjgNRDUx7QJwc21dkoSg/?=
 =?us-ascii?Q?BNR5qQMzy0r5jBeaU9YsdF7VRPRk6v8TBAGrIJDqhbEpPHAGDoaAITYd7Zmb?=
 =?us-ascii?Q?2/Ot1b1tP9oWX6vuKjkpXZxGFVR5m8PLVka45MlFdwiGf4VOtw5QNjWaXNZi?=
 =?us-ascii?Q?yYwzg5ZlKs5dcmua/d+0Ag32ew7AM2MVqm5FZOx9y/T46F7DWyv4Wa6cuAMM?=
 =?us-ascii?Q?HA2GbysWJiKXb8gtPigcIYmcZWkJZivttqs5KGSKNB76QdJ9m0PbwoFuFAE6?=
 =?us-ascii?Q?SZcscp/J8d1Eq6eFPJB8rxys4h9yGZ5GB0ghgpR0r8MMN2UhME9/gW9oIzbF?=
 =?us-ascii?Q?QsbLIiMqlpiuqvLssa2B59+Qwdggi7+2QdzD3TIt3P5mPo05pawngRJ2W3Dg?=
 =?us-ascii?Q?ANzLv6hCN3QWb/pQadUNOJfO7rki+EwKlc7MtdQf7ncJSV3wEutkuRlKBwI/?=
 =?us-ascii?Q?wbYy2cZfG1NiQr+4v7Jtsqi2d6Znu2IV6n1lcsJJa5yXU2zOfMnNiYVu9A7n?=
 =?us-ascii?Q?6lkAS7ZbGAOs7j4WgmV874nDzC2bKzd2X9ZZY4qR7wxyg5iNGey6qXfHQQYh?=
 =?us-ascii?Q?DpVs2ms/krJ3LsndM2Sp7qRQkb2YNeVDxFk247+0pYjBP412sWY713LTt7kP?=
 =?us-ascii?Q?X+jhb6kLCp3XMgPTluQsKsHm3w6One8w2ltWacWZkf0+3JAZAFAH2VBOrFoM?=
 =?us-ascii?Q?cicNYfTkTRWhm4dfycuoBSdCkUzkBkIuoZJYPljeE/4H4+nzhhlV+Wiyy2WK?=
 =?us-ascii?Q?TqK342QJ4pcHVGvN+nU0HYrnc34vrUCoVrCKS2UMf/yoXsR7DzFF+5E78SLG?=
 =?us-ascii?Q?9LV0AMLOlv11xOXLIy59Gz02BsZmhBL1/xWKtnRYf7+xC1O1B2BWVEnbmKQ2?=
 =?us-ascii?Q?8ssvKifP003KLhpCi4QFJDtOAGjebEfVaVPQc37qND1eJkKgpwjFEukoPU2G?=
 =?us-ascii?Q?upH87DEGkPQAL+pZxyHlnkOPG9wCyyta+2bGslQ2yA9TV9BD2Y49XtM8FJxU?=
 =?us-ascii?Q?xF4CfFjjT9jp9XLNVHAajguT8TR4yP4BEdvJIOT+7am6g+ITdFL0De7T6zWe?=
 =?us-ascii?Q?K3qfTjjKhtph7UhdIjflZSK0GtKs4NUYh3MiNsRLsuN/xN+MuIubk3ygjEQw?=
 =?us-ascii?Q?fN/DEv+cYVGBEmJWntK9tKCJEO6UEOaTrP38taY2/n9ysHbsPemhjFjrWdmC?=
 =?us-ascii?Q?Mwd1DMVsg5bt4pZnR0nDaqVItargK/nCZohQxvtrv+KbuXAIqf6vn0zfHJi3?=
 =?us-ascii?Q?3Fv2esOiEDqWHLrjJfNzHN8btRhVZRROsix67+Mi807vJiwZvJLxXzrEnNpg?=
 =?us-ascii?Q?aNnKB1IVXd+MVwamuZD3x68/L6KUO8yWGI2NPbsk+VKbziQGgc2odrgfkmJD?=
 =?us-ascii?Q?kL242gKYrOXiLDZypx9aqHKd9U7ucxc/blZQw9X+tqmJ4F1TTnVr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdeb505-a183-4b70-0313-08deee161cdd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 08:39:47.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0AhipR/wzOD5DlXX3KuybMgFS34WoAlEVWliKsKvzl0aBRT8PsNWNZjfmcjC395p9YH+flvx61H423ot2kPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4603

On Wed, Jul 29, 2026 at 10:49:56PM +0200, Niklas Cassel wrote:
> On Wed, Jul 29, 2026 at 10:28:22PM +0200, Niklas Cassel wrote:
> > Getting two IRQs when we are only expecting a single IRQ is a very
> > serious error, and suggests that something is very wrong in the EPC
> > driver.
> > 
> > Scream loudly so that EPC driver developers can see the problem,
> > which might otherwise be very hard to detect.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 3635741c3e7a..a212e53654c6 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -178,6 +178,19 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
> >  	if (reg & STATUS_IRQ_RAISED) {
> >  		test->last_irq = irq;
> >  		complete(&test->irq_raised);
> > +		/*
> > +		 * The endpoint test driver performs all testing sequentially.
> > +		 * This means that test->irq_raised.done should never exceed 1.
> > +		 * If it does, then we received two IRQs in a row, without a
> > +		 * successful wait_for_completion_timeout() call in between.
> > +		 *
> > +		 * While complete() increases test->irq_raised.done by one,
> > +		 * wait_for_completion_timeout() reduces test->irq_raised.done
> > +		 * by one on success.
> > +		 *
> > +		 * Please debug your EPC driver if you see this warning.
> > +		 */
> > +		WARN_ON(test->irq_raised.done > 1);
> >  	}
> >  
> >  	return IRQ_HANDLED;
> > -- 
> > 2.55.0
> > 
> 
> Hello Koichiro,
> 
> I created this patch in response to a problem that I saw on v7.2-rc5.
> 
> When running the pci_endpoint selftest:
> # /pcitest
> (snip)
> #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> [  215.256772] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> #            OK  pcie_ep_doorbell.DOORBELL_TEST
> ok 23 pcie_ep_doorbell.DOORBELL_TEST
> # FAILED: 19 / 23 tests passed.
> # 2 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> # Totals: pass:17 fail:4 xfail:0 xpass:0 skip:2 error:0
> 
> 
> I saw the weird error:
> "Failed to trigger doorbell in endpoint"
> 
> Ignore that the test case leaves things to be desired, since it passes even
> though we see this warning.
> 
> 
> The problem seems to be that the embedded doorbell IRQ handler is executed twice,
> in response to a single writel() which rings the doorbell.
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 4802d4f80f78..7f4360579ffb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -714,6 +714,7 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
>  
>         status |= STATUS_DOORBELL_SUCCESS;
>         reg->status = cpu_to_le32(status);
> +       trace_printk("calling pci_epf_test_raise_irq()\n");
>         pci_epf_test_raise_irq(epf_test, reg);
>  
>         return IRQ_HANDLED;
> 
> 
> As you can see:
>  irq/58-pci-ep-t-221     [006] .....    58.601020: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
>  irq/58-pci-ep-t-221     [006] .....    58.601421: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
> 
> It is called twice for a single doorbell ring.
> 
> Note that you might need to run the whole selftest test a few times to trigger
> the WARN_ON(), even if you can see the trace printks every time.
> (Using printks instead of trace printks seems to affect the timing too much.)
> 
> 
> My first thought was that we should add reinit_completion() calls after each
> wait_for_completion_timeout() in pci_endpoint_test_doorbell(), but after
> reading up on complete() and wait_for_completion_timeout(), this should
> actually not be needed, and if we did, it would simply hide the read problem,
> which appears to be that the embedded doorbell IRQ handler on the EP side is
> called twice for a single writel() that rings the doorbell.

Hi Niklas,

I was struggling to reproduce this, but I think I figured out what triggers it.
It happens when the 'dma' variant runs before DOORBELL_TEST, e.g. when running
the full test suite with no arguments, or by running '-v dma' first.

I think the following patch fixes it:

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 89a4c498a17b..ec097c68cf5f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -755,6 +755,7 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
                return virq;

        irq_set_chip_and_handler(virq, &dw_edma_emul_irqchip, handle_level_irq);
+       irq_set_status_flags(virq, IRQ_LEVEL);
        irq_set_chip_data(virq, dw);
        irq_set_noprobe(virq);

Could you test this?

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas
