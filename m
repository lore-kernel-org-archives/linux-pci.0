Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2449ECDFAC
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D53A214DA
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zEN+/pyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D53A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeJJBOo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeJJBOo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Oct 2018 21:14:44 -0400
Received: from localhost (57.sub-174-234-155.myvzw.com [174.234.155.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED08621479;
        Tue,  9 Oct 2018 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539107794;
        bh=90nU/dnPcTYtM11JVXcysOMtZmjw+kKDpdmQsgFloLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zEN+/pyFSoxR+XWEBnG/Zm6Bj6C1JH0Q6uRocurvqpvSbTtsB+LsOvFuyiUM0XVTX
         3FcG/naAqzC0HQluTP7cLKuk9xLysn5gbo/GH+DNOG2z4o6mHtw1/0SmRffc+cmhwo
         VlsV7+sBHM1x4dqcQ+9rYF/e/iGAQWV5tMXDvPvY=
Date:   Tue, 9 Oct 2018 12:56:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/portdrv: Enable error reporting on managed ports
Message-ID: <20181009175632.GB5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536085989-2956-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 04, 2018 at 12:33:09PM -0600, Jon Derrick wrote:
> During probe, the port driver will disable error reporting and assumes
> it will be enabled later by the AER driver's pci_walk_bus() sequence.
> This may not be the case for host-bridge enabled root ports, who will
> enable first error reporting on the bus during the root port probe, and
> then disable error reporting on downstream devices during subsequent
> probing of the bus.

I understand the hotplug case (see below), but help me understand this
"host-bridge enabled root ports" thing.  I'm not sure what that means.

We run pcie_portdrv_probe() for every root port, switch upstream port,
and switch downstream port, and it always disables error reporting for
the port:

  pcie_portdrv_probe          # pci_driver .probe
    pcie_port_device_register
      get_port_device_capability
        services |= PCIE_PORT_SERVICE_AER
        pci_disable_pcie_error_reporting
          # clear DEVCTL Error Reporting Enables

For root ports, we call aer_probe(), and it enables error reporting
for the entire tree below the root port:

  aer_probe                   # pcie_port_service .probe
    aer_enable_rootport
      set_downstream_devices_error_reporting(dev, true)
        pci_walk_bus(dev->subordinate, set_device_error_reporting)
          set_device_error_reporting
            if (Root Port || Upstream Port || Downstream Port)
              pci_enable_pcie_error_reporting
                # set DEVCTL Error Reporting Enables

This is definitely broken for hot-added switches because aer_probe()
is the only place we enable error reporting, and it's only run when we
enumerate a root port, not when we hot-add things below that root
port.

> A hotplugged port device may also fail to enable error reporting as the
> AER driver has already run on the root bus.

> Check for these conditions and enable error reporting during portdrv
> probing.
> 
> Example case:

pcie_portdrv_probe(10000:00:00.0):
> [  343.790573] pcieport 10000:00:00.0: pci_disable_pcie_error_reporting

aer_probe(10000:00:00.0):
> [  343.809812] pcieport 10000:00:00.0: pci_enable_pcie_error_reporting
> [  343.819506] pci 10000:01:00.0: pci_enable_pcie_error_reporting
> [  343.828814] pci 10000:02:00.0: pci_enable_pcie_error_reporting
> [  343.838089] pci 10000:02:01.0: pci_enable_pcie_error_reporting
> [  343.847478] pci 10000:02:02.0: pci_enable_pcie_error_reporting
> [  343.856659] pci 10000:02:03.0: pci_enable_pcie_error_reporting
> [  343.865794] pci 10000:02:04.0: pci_enable_pcie_error_reporting
> [  343.874875] pci 10000:02:05.0: pci_enable_pcie_error_reporting
> [  343.883918] pci 10000:02:06.0: pci_enable_pcie_error_reporting
> [  343.892922] pci 10000:02:07.0: pci_enable_pcie_error_reporting

pcie_portdrv_probe(10000:01:00.0):
> [  343.918900] pcieport 10000:01:00.0: pci_disable_pcie_error_reporting

pcie_portdrv_probe(10000:02:00.0):
> [  343.968426] pcieport 10000:02:00.0: pci_disable_pcie_error_reporting

...
> [  344.028179] pcieport 10000:02:01.0: pci_disable_pcie_error_reporting
> [  344.091269] pcieport 10000:02:02.0: pci_disable_pcie_error_reporting
> [  344.156473] pcieport 10000:02:03.0: pci_disable_pcie_error_reporting
> [  344.238042] pcieport 10000:02:04.0: pci_disable_pcie_error_reporting
> [  344.321864] pcieport 10000:02:05.0: pci_disable_pcie_error_reporting
> [  344.411601] pcieport 10000:02:06.0: pci_disable_pcie_error_reporting
> [  344.505332] pcieport 10000:02:07.0: pci_disable_pcie_error_reporting

> [  344.621824] nvme 10000:06:00.0: pci_enable_pcie_error_reporting
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 7c37d81..fdd953a 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -343,6 +343,16 @@ int pcie_port_device_register(struct pci_dev *dev)
>       if (!nr_service)
>               goto error_cleanup_irqs;
>  
> +#ifdef CONFIG_PCIEAER
> +     /*
> +      * Enable error reporting for this port in case AER probing has already
> +      * run on the root bus or this port device is hot-inserted
> +      */
> +     if (dev->aer_cap && pci_aer_available() &&
> +         (pcie_ports_native || pci_find_host_bridge(dev->bus)->native_aer))
> +             pci_enable_pcie_error_reporting(dev);
> +#endif

I plan to apply this after we clarify the changelog a bit, but I don't
really like this patch because it (and the corresponding code added by
2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port
initialization")) seem a little out of place.

The way I think this *should* work is that the PCI core should arrange to
handle AER interrupts when it enumerates the devices that can generate
them (Root Ports and Root Complex Event Collectors), even before it
enumerates the devices below the Root Port.

Then the PCI core could directly enable the AER interrupts on all devices
as it enumerates them.  I would envision both cases being handled somewhere
like pci_aer_init() in pci_init_capabilities().

This would also allow us to get rid of the pci_enable_pcie_error_reporting()
calls that are currently sprinkled around in drivers, because that would be
handled by the core for all devices.

Bjorn
