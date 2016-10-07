Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40630 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753254AbcJGURU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 16:17:20 -0400
Date: Fri, 7 Oct 2016 22:17:17 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/8] PCI: armada: Name private struct pointer "armada8k"
 consistently
Message-ID: <20161007221717.72f45013@free-electrons.com>
In-Reply-To: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007163118.24582.12385.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Fri, 07 Oct 2016 11:31:18 -0500, Bjorn Helgaas wrote:
> Use a device-specific name, "armada8k", for struct armada8k_pcie pointers
> to hint that this is device-specific information.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pcie-armada8k.c |   37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)

For the entire series:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

However, I don't have access to HW right now to test. I can give some
testing when I get back to the office.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
