Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:45135 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933229AbdKGXaP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Nov 2017 18:30:15 -0500
In-Reply-To: <20170927065231.20382-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-pci@vger.kernel.org,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        kvm-ppc@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v2] powerpc/powernv: Reserve a hole which appears after enabling IOV
Message-Id: <3yWlys6rlfz9s7C@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:13 +1100 (AEDT)
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-09-27 at 06:52:31 UTC, Alexey Kardashevskiy wrote:
> In order to make generic IOV code work, the physical function IOV BAR
> should start from offset of the first VF. Since M64 segments share
> PE number space across PHB, and some PEs may be in use at the time
> when IOV is enabled, the existing code shifts the IOV BAR to the index
> of the first PE/VF. This creates a hole in IOMEM space which can be
> potentially taken by some other device.
> 
> This reserves a temporary hole on a parent and releases it when IOV is
> disabled; the temporary resources are stored in pci_dn to avoid
> kmalloc/free.
> 
> Cc: linux-pci@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d6f934fd48803d9e58040e2cbab2fe

cheers
