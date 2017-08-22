Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752560AbdHVVFD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Aug 2017 17:05:03 -0400
Date: Tue, 22 Aug 2017 16:05:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        eric.auger@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix and amend express capability sizes
Message-ID: <20170822210501.GI6948@bhelgaas-glaptop.roam.corp.google.com>
References: <20170810165403.2968.49940.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810165403.2968.49940.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 10, 2017 at 10:54:31AM -0600, Alex Williamson wrote:
> PCI_CAP_EXP_ENDPOINT_SIZEOF_V1 defines the size of the PCIe express
> capability structure for v1 devices with link, but we also have a need
> in the vfio code for sizing the capability for devices without link,
> such as root complex endpoints.  Create a separate define for this
> ending the structure before the link fields.
> 
> Additionally, this reveals that PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 is
> currently incorrect, ending the capability length before the v2 link
> fields.  Rename this to specify an RC endpoint (no link) capability
> length and move PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 to include the link
> fields as we have for the v1 version.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied with Eric's reviewed-by to pci/misc for v4.14, thanks!

I think there was an underscore missing here:

> -#define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints end here */
> +#define PCI_CAP_EXP_RC ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
