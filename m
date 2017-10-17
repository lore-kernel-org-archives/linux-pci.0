Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965772AbdJQTQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 15:16:44 -0400
Date: Tue, 17 Oct 2017 14:16:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 0/3] pci_endpoint_test: Fix module removal/insertion cycle
Message-ID: <20171017191643.GJ5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171011084438.8296-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171011084438.8296-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 02:14:35PM +0530, Kishon Vijay Abraham I wrote:
> This series fixes module removal/insertion cycle of pci_endpoint_test.
> 
> Without this series, when trying to modprobe pci_endpoint_test after
> rmmod pci_endpoint_test results in the following errors.
> 
> pci-endpoint-test 0000:01:00.0: BAR 0: can't reserve [mem 0x20204600-0x202046ff]
> pci-endpoint-test 0000:01:00.0: Cannot obtain PCI resources
> pci-endpoint-test: probe of 0000:01:00.0 failed with error -16
> 
> Kishon Vijay Abraham I (3):
>   misc: pci_endpoint_test: Fix failure path return values in probe
>   misc: pci_endpoint_test: Fix pci_endpoint_test not releasing resources
>     on remove
>   misc: pci_endpoint_test: Fix BUG_ON error during pci_disable_msi
> 
>  drivers/misc/pci_endpoint_test.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

Applied to pci/endpoint for v4.15, thanks!
