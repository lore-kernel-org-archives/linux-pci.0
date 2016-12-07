Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932777AbcLGW5n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 17:57:43 -0500
Date: Wed, 7 Dec 2016 16:57:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH pci/next v3 0/3] PCI: rcar, rcar-gen2: Bindings cleanups
Message-ID: <20161207225739.GJ22129@bhelgaas-glaptop.roam.corp.google.com>
References: <1481039491-30364-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481039491-30364-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 06, 2016 at 04:51:28PM +0100, Simon Horman wrote:
> Hi,
> 
> this short series makes some bindings cleanups to the Renesas PCI drivers.
> 
> Changes v2->v3:
> * Reworded changelogs to indicate that re-ordering struct of_device_id
>   entries does not effect run-time behaviour
> * Corrected compile error due to typo in symbol name
> Changes v1->v2:
> * re-order struct of_device_id entries
> 
> Simon Horman (3):
>   PCI: rcar-gen2: Use gen2 fallback compatibility last
>   PCI: rcar: Use gen2 fallback compatibility last
>   PCI: rcar: Add gen3 fallback compatibility string for pcie-rcar
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  drivers/pci/host/pci-rcar-gen2.c                   | 2 +-
>  drivers/pci/host/pcie-rcar.c                       | 5 +++--
>  3 files changed, 5 insertions(+), 3 deletions(-)

Applied to pci/host-rcar for v4.10, thanks!
