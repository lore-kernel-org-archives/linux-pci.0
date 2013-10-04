Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:60255 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab3JDOcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 10:32:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 15D4B12B11D
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2013 16:32:15 +0200 (CEST)
Date: Fri, 4 Oct 2013 16:32:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH] iommu: Remove stack trace from broken irq remapping
 warning
Message-ID: <20131004143211.GA2717@8bytes.org>
References: <1380300815-1864-1-git-send-email-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380300815-1864-1-git-send-email-nhorman@tuxdriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 27, 2013 at 12:53:35PM -0400, Neil Horman wrote:
> The warning for the irq remapping broken check in intel_irq_remapping.c is
> pretty pointless.  We need the warning, but we know where its comming from, the
> stack trace will always be the same, and it needlessly triggers things like
> Abrt.  This changes the warning to just print a text warning about BIOS being
> broken, without the stack trace, then sets the appropriate taint bit.  Since we
> automatically disable irq remapping, theres no need to contiue making Abrt jump
> at this problem

Applied to x86/vt-d, thanks Neil.


