Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeFEWWl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jun 2018 18:22:41 -0400
Date: Tue, 5 Jun 2018 17:21:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI/AER: Clean up minor logging issues
Message-ID: <20180605222158.GD226399@bhelgaas-glaptop.roam.corp.google.com>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 12:54:10PM -0500, Bjorn Helgaas wrote:
> AER logging printed the plain 16-bit Requester ID straight out of the TLP,
> which is hard to interpret, e.g., id=00e4 corresponds to what we normally
> see as 00:1c.4 in dmesg or lspci.
> 
> Also, there's no need to print the vendor/device ID of the root port
> reporting an error; we can easily find that from dmesg or lspci.
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI/AER: Decode Error Source Requester ID
>       PCI/AER: Stop printing vendor/device ID
> 
> 
>  drivers/pci/pcie/aer/aerdrv_errprint.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)

I applied the first but not the second to pci/aer for v4.18.
