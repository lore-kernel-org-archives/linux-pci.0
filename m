Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C99C282C4
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2904F21924
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549551773;
	bh=mf7YvNy2ymNhGgzWJxld1375NUPr8mbaLqzAcWxU95k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R0coc2kO2Zf3JwQMFtQwa5bm/bxZf6esDcavF3tzNqy+oMGaSAsLyIFvczlAog4LW
	 BKiSUyiQBcCL6Y4OdljP0+7AHxXimc/lxtbI9hx2Dzp31O+sWv2Bl4J7gYODo91SZ5
	 wjXCdG/taMF1e+KqdkYOk74MSWyrPI2YeBG+Tr/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGPCr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPCr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 10:02:47 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F13C2190C;
        Thu,  7 Feb 2019 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549551765;
        bh=mf7YvNy2ymNhGgzWJxld1375NUPr8mbaLqzAcWxU95k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSfZOiwAS/CdkgPVEv0rWlZFBdXZSTkPHiTm4pqjrvslKo1F9OJP3mmhTsFvCac1T
         ZxmDd6c3k8vkoC4hg/K6s6JYQ/BNBAnlKp4ibXS6zwFXhfHlv9rBcjLgvcsOOlzTHo
         TX6Q5kS10ijzeHcoQ+EXZtPwTMTN6/+10Ihvj9eQ=
Date:   Thu, 7 Feb 2019 09:02:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fixup the RTIT_BAR of Intel TH on Denverton
Message-ID: <20190207150243.GH7268@google.com>
References: <20190207133005.67328-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190207133005.67328-1-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 03:30:05PM +0200, Alexander Shishkin wrote:
> On Denverton's integration of the Intel(R) Trace Hub (for a reference
> and overview see Documentation/trace/intel_th.txt) the reported size of
> one of its resources (RTIT_BAR) doesn't match its actual size, which
> leads to overlaps with other devices' resources.
> 
> In practice, it overlaps with XHCI MMIO space, which results in the xhci
> driver bailing out after seeing its registers as 0xffffffff, and perceived
> disappearance of all USB devices:
> 
> > intel_th_pci 0000:00:1f.7: enabling device (0004 -> 0006)
> > xhci_hcd 0000:00:15.0: xHCI host controller not responding, assume dead
> > xhci_hcd 0000:00:15.0: xHC not responding in xhci_irq, assume controller is dead
> > xhci_hcd 0000:00:15.0: HC died; cleaning up
> > usb 1-1: USB disconnect, device number 2
> ...
> 
> For this reason, we need to resize the RTIT_BAR on Denverton to its
> actual size, which in this case is 4MB. The corresponding erratum is
> DNV36 at the link below.
> 
> Link: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/atom-c3000-family-spec-update.pdf
> Fixes: 5118ccd34780 ("intel_th: pci: Add Denverton SOC support")
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: stable@vger.kernel.org

I applied this with the changelog below to pci/enumeration for v5.1,
thanks!

commit 68071384ca08
Author: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date:   Thu Feb 7 15:30:05 2019 +0200

    x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub
    
    On Denverton's integration of the Intel(R) Trace Hub (for a reference and
    overview see Documentation/trace/intel_th.txt) the reported size of one of
    its resources (RTIT_BAR) doesn't match its actual size, which leads to
    overlaps with other devices' resources.
    
    In practice, it overlaps with XHCI MMIO space, which results in the xhci
    driver bailing out after seeing its registers as 0xffffffff, and perceived
    disappearance of all USB devices:
    
      intel_th_pci 0000:00:1f.7: enabling device (0004 -> 0006)
      xhci_hcd 0000:00:15.0: xHCI host controller not responding, assume dead
      xhci_hcd 0000:00:15.0: xHC not responding in xhci_irq, assume controller is dead
      xhci_hcd 0000:00:15.0: HC died; cleaning up
      usb 1-1: USB disconnect, device number 2
    
    For this reason, we need to resize the RTIT_BAR on Denverton to its actual
    size, which in this case is 4MB.  The corresponding erratum is DNV36 at the
    link below:
    
      DNV36.       Processor Host Root Complex May Incorrectly Route Memory
                   Accesses to Intel® Trace Hub
    
      Problem:     The Intel® Trace Hub RTIT_BAR (B0:D31:F7 offset 20h) is
                   reported as a 2KB memory range.  Due to this erratum, the
                   processor Host Root Complex will forward addresses from
                   RTIT_BAR to RTIT_BAR + 4MB -1 to Intel® Trace Hub.
    
      Implication: Devices assigned within the RTIT_BAR to RTIT_BAR + 4MB -1
                   space may not function correctly.
    
      Workaround:  A BIOS code change has been identified and may be
                   implemented as a workaround for this erratum.
    
      Status:      No Fix.
    
    Note that 5118ccd34780 ("intel_th: pci: Add Denverton SOC support") updates
    the Trace Hub driver so it claims the Denverton device, but the resource
    overlap exists regardless of whether that driver is loaded or that commit
    is included.
    
    Link: https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/atom-c3000-family-spec-update.pdf
    Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    [bhelgaas: include erratum text, clarify relationship with 5118ccd34780]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org

> ---
>  arch/x86/pci/fixup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 30a5111ae5fd..527e69b12002 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -635,6 +635,22 @@ static void quirk_no_aersid(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>  			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_aersid);
>  
> +static void quirk_intel_th_dnv(struct pci_dev *dev)
> +{
> +	struct resource *r = &dev->resource[4];
> +
> +	/*
> +	 * Denverton reports 2k of RTIT_BAR (intel_th resource 4), which
> +	 * appears to be 4 MB in reality.
> +	 */
> +	if (r->end == r->start + 0x7ff) {
> +		r->start = 0;
> +		r->end   = 0x3fffff;
> +		r->flags |= IORESOURCE_UNSET;
> +	}
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x19e1, quirk_intel_th_dnv);
> +
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  
>  #define AMD_141b_MMIO_BASE(x)	(0x80 + (x) * 0x8)
> -- 
> 2.20.1
> 
