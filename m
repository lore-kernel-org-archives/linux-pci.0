Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40498 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753535AbcJGUHi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Oct 2016 16:07:38 -0400
Date: Fri, 7 Oct 2016 22:07:34 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] PCI: aardvark: Name private struct pointer "advk"
 consistently
Message-ID: <20161007220734.5f43e444@free-electrons.com>
In-Reply-To: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161007162053.22668.91420.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Fri, 07 Oct 2016 11:20:53 -0500, Bjorn Helgaas wrote:
> Use a device-specific name, "advk", for struct advk_pcie pointers to hint
> that this is device-specific information.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/host/pci-aardvark.c |  370 +++++++++++++++++++--------------------
>  1 file changed, 183 insertions(+), 187 deletions(-)

For the entire series:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks for those cleanups/improvements!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
