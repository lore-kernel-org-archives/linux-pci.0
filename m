Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:59377 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739Ab3JCUI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Oct 2013 16:08:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 0D19312B0EF
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2013 22:08:26 +0200 (CEST)
Date: Thu, 3 Oct 2013 22:08:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH] iommu: Remove stack trace from broken irq remapping
 warning
Message-ID: <20131003200824.GA17455@8bytes.org>
References: <1380300815-1864-1-git-send-email-nhorman@tuxdriver.com>
 <20131003172142.GA20660@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003172142.GA20660@hmsreliant.think-freely.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 03, 2013 at 01:21:42PM -0400, Neil Horman wrote:
> On Fri, Sep 27, 2013 at 12:53:35PM -0400, Neil Horman wrote:
> > The warning for the irq remapping broken check in intel_irq_remapping.c is
> > pretty pointless.  We need the warning, but we know where its comming from, the
> > stack trace will always be the same, and it needlessly triggers things like
> > Abrt.  This changes the warning to just print a text warning about BIOS being
> > broken, without the stack trace, then sets the appropriate taint bit.  Since we
> > automatically disable irq remapping, theres no need to contiue making Abrt jump
> > at this problem
> > 
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > CC: Joerg Roedel <joro@8bytes.org>
> > CC: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > CC: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> 
> Ping Bjorn, Jeorg, any thoughts here?

Yes, the patch is doing the right thing. I have it already on my list
and will merge it soon.


	Joerg


