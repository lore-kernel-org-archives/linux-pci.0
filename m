Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:48488 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084Ab2ADSol (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2012 13:44:41 -0500
Date: Wed, 4 Jan 2012 13:43:08 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org
Subject: pci_reset_function() being called from "bind" or "unbind"
Message-ID: <20120104184307.GA30359@phenom.dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


I am looking at implementing the FLR functionality in the xen-pciback driver and
found a mutex issue I am not entirely sure how to resolve.

In essence I am trying to call pci_reset_function() when a PCI device is
"attached" (using "bind") to the xen-pciback driver.

This means that when a user does:

 echo "0000:01.07.0" > /sys/bus/pci/drivers/pciback/bind

we end up calling:
  driver_bind:
    device_lock(dev);
    pcistub_probe:
       pcistub_seize:
         pcistub_init_device:
           .. pci_enable_device()
           --> want also to do pci_reset_function(), which calls
                 pci_dev_reset(dev, 0):
			if (!0) {
				device_lock(dev) <==== DEADLOCK

           .. pci_disable_device()

So looking at the code I saw __pci_reset_function which I thought
would do the same as pci_reset_function but without locking.
However, it is actually the opposite - it is with the locking.

My thought is that one way to resolve this is by wrapping
pci_probe_reset_function with a EXPORT_SYMBOL_GPL and use that
instead. Or perhaps have a new function called
"pci_reset_function_locked" ?

Thoughts?
