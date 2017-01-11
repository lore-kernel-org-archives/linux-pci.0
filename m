Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753535AbdAKSmS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jan 2017 13:42:18 -0500
Date: Wed, 11 Jan 2017 12:42:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Subject: Re: [PATCH pci/next] PCI: rcar: return ENODEV code when PCIe card
 does not insert
Message-ID: <20170111184212.GF14532@bhelgaas-glaptop.roam.corp.google.com>
References: <1481889004-26124-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481889004-26124-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 16, 2016 at 12:50:04PM +0100, Simon Horman wrote:
> From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> 
> R-Car PCIe does not support hotplug so it is appropriate to
> treat the absence of a PCIe card as an ENODEV error.
> 
> Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
> [simon: updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied to pci/host-rcar for v4.11 with the following changelog (I updated
the summary line):

commit e94888d23736cec51ba851f6e798d0eeb9ef5f41
Author: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Date:   Fri Dec 16 12:50:04 2016 +0100

    PCI: rcar: Return -ENODEV from host bridge probe when no card present
    
    R-Car PCIe does not support hotplug so it is appropriate to treat the
    absence of a PCIe card as an -ENODEV error.
    
    Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
    [simon: updated changelog]
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
