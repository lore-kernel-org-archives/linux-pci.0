Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:7229 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeHQRFp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Aug 2018 13:05:45 -0400
Date: Fri, 17 Aug 2018 08:03:06 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] dpc.c: fix missing return value check of
 pci_find_ext_capability()
Message-ID: <20180817140305.GA9244@localhost.localdomain>
References: <20180817081719.11156-1-jasonwood2031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817081719.11156-1-jasonwood2031@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 04:17:19PM +0800, Jiecheng Wu wrote:
> Function dpc_probe() defined in drivers/pci/pcie/dpc.c calls
> pci_find_ext_capability(). Function pci_find_ext_capability() returns
> the address of the requested extended capability structure within the
> device's PCI configuration space or 0 if the device does not support
> it. The return value of this function should be checked against 0.

dpc_probe will not get called if the capability doesn't exist. The
capability existing is the criteria for PCIE_PORT_SERVICE_DPC flag,
which is required to call dpc_probe.
