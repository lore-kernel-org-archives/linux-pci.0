Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbdE3TpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 15:45:08 -0400
Date: Tue, 30 May 2017 14:45:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jork Loeser <jloeser@microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com
Subject: Re: [PATCH-v2 0/5] Hyper-V vPCI: use vPCI protocol version 1.2
Message-ID: <20170530194506.GA4664@bhelgaas-glaptop.roam.corp.google.com>
References: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495658488-13199-1-git-send-email-jloeser@linuxonhyperv.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 01:41:23PM -0700, Jork Loeser wrote:
> From: Jork Loeser <jloeser@microsoft.com>
> 
> Update the Hyper-V vPCI driver to use the Server-2016 version of the vPCI
> protocol, fixing MSI creation and retargeting issues.
> 
> Changes since v1:
> - reduced spew in protocol negotiation (Dan Carpenter)
> - work-around work racing Hyper-V patch (Stephen Hemminger)
> - formatting (Dan)
> 
> Jork Loeser (5):
>   Hyper-V vPCI: Minor format and semantic fix
>   Hyper-V vPCI: Use page allocation for hbus structure
>   PCI-HyperV vPCI: Temporary own CPU-number-to-vCPU-number infra
>   Hyper-V vPCI: Add vPCI version protocol negotiation
>   Hyper-V vPCI: use vPCI protocol version 1.2
> 
>  arch/x86/include/uapi/asm/hyperv.h |   6 +
>  drivers/pci/host/pci-hyperv.c      | 445 ++++++++++++++++++++++++++++++-------
>  2 files changed, 370 insertions(+), 81 deletions(-)

Waiting for a maintainer ack:

  Hyper-V CORE AND DRIVERS
  M:      "K. Y. Srinivasan" <kys@microsoft.com>
  M:      Haiyang Zhang <haiyangz@microsoft.com>
  M:      Stephen Hemminger <sthemmin@microsoft.com>
  ...
  F:      drivers/pci/host/pci-hyperv.c
