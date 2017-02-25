Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58525 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751647AbdBYIFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2017 03:05:08 -0500
Date: Sat, 25 Feb 2017 09:02:18 +0100
From: Greg KH <greg@kroah.com>
To: Long Li <longli@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Resend PATCH 2/2 v3] pci-hyperv: lock pci bus on device eject
Message-ID: <20170225080218.GA2291@kroah.com>
References: <BN3PR03MB22273E86EDBC8875C55E2FB7CE520@BN3PR03MB2227.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BN3PR03MB22273E86EDBC8875C55E2FB7CE520@BN3PR03MB2227.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2017 at 09:49:17PM +0000, Long Li wrote:
> A PCI_EJECT message can arrive at the same time we are calling pci_scan_child_bus in the workqueue for the previous PCI_BUS_RELATIONS message or in create_root_hv_pci_bus(), in this case we could potentailly modify the bus from multiple places. Properly lock the bus access.

Properly wrap your changelog comments at 72 columns like your editor is
telling you to do...
