Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBBCC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9AE20879
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544714189;
	bh=u3fmyMRfU4+oCS96JhPzyR/MEVHb4pLXem2CbOGb3FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cx9RpO4l5KAwHG8PBaWhBEp49rWKJV53SUr/COfj/+8omEFGKC0MD9KlkpObr3y6x
	 V8h5//mqfFNPMBTvLJxRDHygvdgx+hERq22goa7cHKectoNTCbKhOEghAG+PmMgI6/
	 MPpwb886sJ6EUWXZT/VgM2ex5rI6DVgJZQR6WkXY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9AE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeLMPQ2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:16:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbeLMPQ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 10:16:28 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4533820851;
        Thu, 13 Dec 2018 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544714186;
        bh=u3fmyMRfU4+oCS96JhPzyR/MEVHb4pLXem2CbOGb3FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvWin+l0SiQETPghCglHY0Lxc8TRwFQlUAP3M68/EE8qn+4p7XRgQDTfxJ6JvZU7v
         XtR94WMcWgl/zhBUBjcwqGD5Kl8KaFDzfyw6PypuHHd9/3c3884zywi4WLJn194F7P
         nUKm6LeVal1ZH6gYy8fO9wb9kRLRcY8Etdc+NcAk=
Date:   Thu, 13 Dec 2018 09:16:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Wesley Sheng <wesley.sheng@microchip.com>,
        kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
Subject: Re: [PATCH 5/5] switchtec: MRPC DMA mode implementation
Message-ID: <20181213151625.GC4701@google.com>
References: <1544433144-7563-1-git-send-email-wesley.sheng@microchip.com>
 <1544433144-7563-6-git-send-email-wesley.sheng@microchip.com>
 <20181212225201.GL99796@google.com>
 <b96a3667-de25-9e51-bbdb-406cc4b879f3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96a3667-de25-9e51-bbdb-406cc4b879f3@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 03:58:22PM -0700, Logan Gunthorpe wrote:
> On 2018-12-12 3:52 p.m., Bjorn Helgaas wrote:
> > On Mon, Dec 10, 2018 at 05:12:24PM +0800, Wesley Sheng wrote:
> >> MRPC normal mode requires the host to read the MRPC command status and
> >> output data from BAR. This results in high latency responses from the
> >> Memory Read TLP and potential Completion Timeout (CTO).
> >>
> >> MRPC DMA mode implementation includes:
> >> Macro definitions for registers and data structures corresponding to
> >> MRPC DMA mode.
> >>
> >> Add module parameter use_dma_mrpc to select between MRPC DMA mode and
> >> MRPC normal mode.
> >>
> >> Add MRPC mode functionality to:
> >> * Retrieve MRPC DMA mode version
> >> * Allocate DMA buffer, ISR registration, and enable DMA function during
> >>   initialization
> >> * Check MRPC execution status and collect execution results from DMA buffer
> >> * Release DMA buffer and disable DMA function when unloading module
> >>
> >> MRPC DMA mode is a new feature of firmware and the driver will fall back
> >> to MRPC normal mode if there is no support in the legacy firmware.
> >>
> >> Include <linux/io-64-nonatomic-lo-hi.h> so that readq/writeq is replaced
> >> by two readl/writel on systems that do not support it.
> >>
> >> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> >> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> >> ---
> >>  drivers/pci/switch/switchtec.c | 108 +++++++++++++++++++++++++++++++++++++----
> >>  include/linux/switchtec.h      |  16 ++++++
> >>  2 files changed, 114 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> >> index 0b8862b..6b726cb 100644
> >> --- a/drivers/pci/switch/switchtec.c
> >> +++ b/drivers/pci/switch/switchtec.c
> >> @@ -13,7 +13,7 @@
> >>  #include <linux/uaccess.h>
> >>  #include <linux/poll.h>
> >>  #include <linux/wait.h>
> >> -
> >> +#include <linux/io-64-nonatomic-lo-hi.h>
> >>  #include <linux/nospec.h>
> >>  
> >>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
> >> @@ -25,6 +25,11 @@ static int max_devices = 16;
> >>  module_param(max_devices, int, 0644);
> >>  MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
> >>  
> >> +static bool use_dma_mrpc = 1;
> >> +module_param(use_dma_mrpc, bool, 0644);
> >> +MODULE_PARM_DESC(use_dma_mrpc,
> >> +		 "Enable the use of the DMA MRPC feature");
> > 
> > What's the purpose of the module parameter?  Can't you automatically
> > figure out whether the firmware supports DMA mode?
> > 
> > Module parameters make life difficult for users and lead to code
> > that's rarely used and poorly tested, so I think we should avoid them
> > whenever we can.
> > 
> > If you *can't* automatically figure out when to use DMA, please make
> > it clear in the changelog that the "use_dma_mrpc" parameter is
> > required with legacy firmware.  And in that case, it seems like it
> > should be named "disable_dma" or similar, since it defaults to being
> > enabled.
> 
> The code should already automatically determine whether the firmware
> supports DMA or not. This parameter is just to aid debugging/testing so
> we can run the module without DMA even if the firmware indicates it has
> support.
> 
> It's not that critical so I'm sure we can remove it at this point if you
> don't think that's a good enough justification.

You and Kurt are the maintainers of this, so it's up to you.  I
personally probably would not add a parameter that's only for
debugging, but at the end of the day I only want to double-check
that this is all as you intend.

I reworked the changelog as follows.


commit a5fa833d8008b9f8e211e2fbc7bc1f45f6457133
Author: Wesley Sheng <wesley.sheng@microchip.com>
Date:   Mon Dec 10 17:12:24 2018 +0800

    switchtec: Add MRPC DMA mode support
    
    MRPC normal mode requires the host to read the MRPC command status and
    output data from BAR.  This results in high latency responses from the
    Memory Read TLP and potential Completion Timeout (CTO).
    
    Add support for MRPC DMA mode, including related macro definitions and data
    structures and code to:
    
      * Retrieve MRPC DMA mode version from adapter firmware
      * Allocate DMA buffer, register ISR, and enable DMA during init
      * Check MRPC execution status and collect execution results from DMA buffer
      * Release DMA buffer and disable DMA function when unloading module
    
    MRPC DMA mode is a new feature of firmware, and the driver will fall back
    to MRPC normal mode if there is no support in the legacy firmware.
    
    Add a module parameter, "use_dma_mrpc", to select between MRPC DMA mode and
    MRPC normal mode.  Since the driver automatically detects DMA support in
    the firmware, this parameter is just for debugging and testing.
    
    Include <linux/io-64-nonatomic-lo-hi.h> so that readq/writeq is replaced by
    two readl/writel on systems that do not support it.
    
    Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
