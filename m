Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:36329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750922AbdDRFa5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Apr 2017 01:30:57 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v11 4/7] powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned
In-Reply-To: <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com> <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 18 Apr 2017 15:30:55 +1000
Message-ID: <87vaq2704w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> writes:

> From: Yongji Xie <elohimes@gmail.com>
>
> This overrides pcibios_default_alignment() to set default alignment
> to PAGE_SIZE for all PCI devices on PowerNV platform. Thus sub-page
> BARs would not share a page and could be mapped into guest when VFIO
> passthrough them.
>
> Signed-off-by: Yongji Xie <elohimes@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    2 ++
>  arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |    7 +++++++

This looks fine to me, here's an ack, but don't feel you have to rebase
to add it:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
