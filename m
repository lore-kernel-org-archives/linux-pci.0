Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938863AbcIFRYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Sep 2016 13:24:48 -0400
Date: Tue, 6 Sep 2016 12:24:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH 0/5] PCI: hv: some minor bug fixes and cleanups
Message-ID: <20160906172443.GB7554@localhost>
References: <MWHPR03MB266985BDDEE4EB1A9C481B0DBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB266985BDDEE4EB1A9C481B0DBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 04:42:41AM +0000, Dexuan Cui wrote:
> 
> 1. use zero-length array to make the code more readable.
> 2. remove an unused struct member.
> 3. small error handling improvement to some error cases.
> 
> Dexuan Cui (5):
>   PCI: hv: use zero-length message in struct pci_packet
>   PCI: hv: use pci_function_description[0] in struct definitions
>   PCI: hv: remove the unused 'wrk' in struct hv_pcibus_device
>   PCI: hv: hv_compose_msi_msg: handle the 'ret' value
>   PCI: hv: hv_pci_generic_compl(): handle the error case
> 
>  drivers/pci/host/pci-hyperv.c | 56 ++++++++++++++++++++++---------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)

Applied with KY's ack to pci/host-hv for v4.9, thanks!
