Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbdHSRKU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Aug 2017 13:10:20 -0400
Date: Sat, 19 Aug 2017 12:10:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: Re: [PATCH v6 0/2] PCI: iproc: SOC specific fixes
Message-ID: <20170819171018.GR28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1501861696-25767-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 04, 2017 at 09:18:14PM +0530, Oza Pawandeep wrote:
> PCI: iproc: Retry request when CRS returned from EP
> Above patch adds support for CRS in PCI RC driver, otherwise if not
> handled at lower level, the user space PMD (poll mode drivers) can
> timeout.
> 
> PCI: iproc: add device shutdown for PCI RC
> This fixes the issue where certian PCI endpoints are not getting
> detected on Stingray SOC after reboot.
> 
> Changes Since v6:

This current series is v6, so I guess you mean "since v5".

> Bjorn's comments addressed.
> Added reference to PCIe spec and iproc Controller spec in Changelog.
> 
> Changes Since v5:
> Ray's comments addressed.
> 
> Changes Since v4:
> Bjorn's comments addressed.
> 
> Changes Since v3:
> [re-send]
> 
> Changes Since v2:
> Fix compilation errors for pcie-iproc-platform.ko which was caught by
> kbuild.
> 
> Oza Pawandeep (2):
>   PCI: iproc: Retry request when CRS returned from EP
>   PCI: iproc: add device shutdown for PCI RC
> 
>  drivers/pci/host/pcie-iproc-platform.c |   8 ++
>  drivers/pci/host/pcie-iproc.c          | 139 +++++++++++++++++++++++++++++----
>  drivers/pci/host/pcie-iproc.h          |   1 +
>  3 files changed, 132 insertions(+), 16 deletions(-)

What is this series based on?  It doesn't apply to my master branch,
my next branch, or my pci/host-iproc branch.  It's always best to base
patches on my master branch, unless they depend on something that's
not there.
