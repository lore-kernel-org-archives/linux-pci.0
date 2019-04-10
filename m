Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E212C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 19:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E462070D
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924593;
	bh=voP+TTLqHtU68WSzxkUUCT24S+tBMRWoaAcw1CfxllE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rtR13uq4fUtW7InBvtD1UypUgZsrVBuVQuUX0oVVE+n4AM/byruOxTWIyDaHAYUzm
	 UZBIAByI9CNSvn21o7+RBy4dZvI7QHmGJyJGJWqYdHdteAfTvoAeySlvMtomPRJGyq
	 Mx7tImaB/gH158VSAVqbVHH60ZfoDDHKMnJWmdmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfDJT3v (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfDJT3v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 15:29:51 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE8D52070D;
        Wed, 10 Apr 2019 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554924590;
        bh=voP+TTLqHtU68WSzxkUUCT24S+tBMRWoaAcw1CfxllE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2hnv2U59MW+L+YxGghNJOR/lp9Q2mvKF25WswNsVo0BXiN8v2zpXcpq1vmFeSxIYT
         glY15B3WjXHw/NYbHiE/ClLKFWTs1FAtSQmEJ7530+WPnhVErOx2Rj7xl+IR3Sfm85
         Kjqg5GUeksbHbVmSKv30Vv+NAuF9/YfKSIwpEa8w=
Date:   Wed, 10 Apr 2019 14:29:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>, dledford@redhat.com,
        Kamenee Arumugam <kamenee.arumugam@intel.com>
Subject: Re: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Message-ID: <20190410192948.GG256045@google.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dennis,

On Wed, Apr 10, 2019 at 05:35:01AM -0700, Dennis Dalessandro wrote:
> From: Kamenee Arumugam <kamenee.arumugam@intel.com>
> 
> For hfi1, the unsupported request error is not considered a fatal
> error. When the PCIe advanced error reporting capability (AER) is
> configured to report unsupported requests as fatal, the system will
> hang on this error.

I know there are a few drivers that fiddle with AER bits, but that
makes me a little bit nervous because error handling is more than just
a driver issue.  It involves the PCI core and the platform firmware as
well.

Anyway, let's figure out more about this particular case.  Unsupported
Request is a PCIe protocol-level issue.  You're masking it in the HFI
adapter, which I guess means you want to prevent it from reporting UR.
So the HFI is receiving a TLP that it doesn't support?

What exactly is causing the UR?  Is it something the driver could
potentially avoid, e.g., an AtomicOp that HFI doesn't support?  I have
a vague notion that InfiniBand allows some sort of direct user-space
access to hardware; is there something there that can cause a UR?

The system hang sounds like a separate problem that should also be
fixed.  Even if HFI signals a UR error, I would not expect a system
hang.

Bjorn

> Set Unsupported Request Error bit in Uncorrectable Error Mask
> register to disable error reporting to the PCIe root complex.
> 
> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index c96d193..a033e28 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -114,6 +114,7 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
>  	}
>  
>  	pci_set_master(pdev);
> +	pcie_aer_set_dword(pdev, PCI_ERR_UNCOR_MASK, PCI_ERR_UNC_UNSUP);
>  	(void)pci_enable_pcie_error_reporting(pdev);
>  	return 0;
>  
> 
