Return-Path: <SRS0=w5mv=VW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC14C7618B
	for <linux-pci@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7592E21851
	for <linux-pci@archiver.kernel.org>; Thu, 25 Jul 2019 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564073614;
	bh=QXnJjsSgCBpXtm/7YZ1N7f+XQIDcMQuyCcyT3t/mIbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BqnylZbgnlpdwlLHiG+9Mmo48iV1VCn23LXFvVdDTjBqkUtqcNY88MHuLpf/Xu4xU
	 LTgZUdDazb/7CmaJZjH0dPJOU3feUy9hzAUmz7ZFMNXA/BiiEjker072f6qUtsmmJv
	 qtqVbBFYXrc3+ebua91mGcdy68fF27KznyORq9yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfGYQxd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:53:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:26370 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfGYQxc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jul 2019 12:53:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 09:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="164237571"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2019 09:53:30 -0700
Date:   Thu, 25 Jul 2019 10:50:37 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH v5 8/9] PCI/DPC: Add support for DPC recovery on
 NON_FATAL errors
Message-ID: <20190725165037.GA7055@localhost.localdomain>
References: <cover.1563912591.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <211d4bf8f856c6aa5454751e25ab5c90970960ff.1563912591.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211d4bf8f856c6aa5454751e25ab5c90970960ff.1563912591.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 01:21:50PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Currently, in native mode, DPC driver is configured to trigger DPC only
> for FATAL errors and hence it only supports port recovery for FATAL
> errors. But with Error Disconnect Recover (EDR) support, DPC
> configuration is done by firmware, and hence we should expect DPC
> triggered for both FATAL/NON-FATAL errors. So add support for DPC
> recovery with NON-FATAL errors.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/dpc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 6e350149d793..5d328812aea9 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -267,15 +267,20 @@ static void dpc_process_error(struct dpc_dev *dpc)
>  	/* show RP PIO error detail information */
>  	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
>  		dpc_process_rp_pio_error(dpc);
> -	else if (reason == 0 &&
> +	else if (reason <= 2 &&
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
>  		aer_print_error(pdev, &info);
>  		pci_cleanup_aer_uncorrect_error_status(pdev);
> -		pci_aer_clear_fatal_status(pdev);
> +		if (reason != 1)
> +			pci_aer_clear_fatal_status(pdev);

I'm not quite sure I understand the above. If the reason is 1 or 2,
then the DSP received an error message from something downstream. In
otherwords, the port was notified an error occured somewhere, but it
was not the device that detected that error, so we should not expect
aer_print_error on that device to show anything useful. Right?

>  	}
>  
> -	/* We configure DPC so it only triggers on ERR_FATAL */
> +	/*
> +	 * Irrespective of whether the DPC event is triggered by
> +	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
> +	 * use the FATAL error recovery path for both cases.
> +	 */
>  	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
>  }
>  
> -- 
> 2.21.0
> 
