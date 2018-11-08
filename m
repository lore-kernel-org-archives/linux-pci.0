Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD5EC32789
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 10:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E0C20825
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 10:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+rOrC0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E0C20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeKHTmA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 14:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeKHTmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Nov 2018 14:42:00 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF452086A;
        Thu,  8 Nov 2018 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541671637;
        bh=05S/zBqjC9RS2AVCCmjFb0kN6AECFnjqYtyW9ksPBAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+rOrC0reItmL/kXl+dmoFt5yOSkwlgtdcXfKtl5ohV+CEa9rLj+XobZUHUZV5deh
         Le/QWXpVGSPIEThdomzs+bU/tNyNRfVrnUS5VCCYWzP22+yyeBLR18AaICLsPGuaVe
         PLAynr7q+HP2nS51Vnd1ZEOjjeRb0tFpcc2C2jp8=
Date:   Thu, 8 Nov 2018 02:05:55 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Move Rohm vendor ID to generic list
Message-ID: <20181108100555.GB27328@kroah.com>
References: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 09:58:56PM +0200, Andy Shevchenko wrote:
> Move the Rohm vendor ID to pci_ids.h from dozen of drivers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> I believe the best chance to get it merged and be less intrusive to ongoing
> work is through PCI subsystem as a _fix_ for v4.20.

What?  Why?  Who cares?

This can trickle in over the next year or never, as it isn't a bugfix,
or "necessary" at all.  Just add it to pci_ids.h and when that gets
merged, you can try to remove it from the individual drivers if it
really is annoying to you.

But this is _NOT_ a fix for anything, don't try to mask it as one, that
feels like "crying wolf" here :(

thanks,

greg k-h
