Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:47309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdFOJZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 05:25:09 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Yongji Xie <elohimes@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel 2/3] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host bridge
In-Reply-To: <20170615054845.8428-3-aik@ozlabs.ru>
References: <20170615054845.8428-1-aik@ozlabs.ru> <20170615054845.8428-3-aik@ozlabs.ru>
Date: Thu, 15 Jun 2017 19:25:06 +1000
Message-ID: <877f0dppql.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> From: Yongji Xie <elohimes@gmail.com>
>
> Any IODA host bridge have the capability of IRQ remapping.
> So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
> is detected.

Where's the code that actually enforces this property?

It would be good to have a comment in pnv_pci_ioda_root_bridge_prepare()
(probably), pointing to that code, so that we can remember the
relationship between the two.

cheers
