Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbdLFV1o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 16:27:44 -0500
Date: Wed, 6 Dec 2017 15:27:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: Add vendor ID for Cadence
Message-ID: <20171206212741.GP23510@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <a93032cbbe02dc9efef8536a4b2a851d1b08ab6f.1511439189.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a93032cbbe02dc9efef8536a4b2a851d1b08ab6f.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 04:01:46PM +0100, Cyrille Pitchen wrote:
> This patch adds a new PCI vendor ID for Cadence.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume Lorenzo will merge this along with the rest of the Cadence
support.

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ab20dc5db423..eb13e84e1fef 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2381,6 +2381,8 @@
>  
>  #define PCI_VENDOR_ID_LENOVO		0x17aa
>  
> +#define PCI_VENDOR_ID_CDNS		0x17cd
> +
>  #define PCI_VENDOR_ID_ARECA		0x17d3
>  #define PCI_DEVICE_ID_ARECA_1110	0x1110
>  #define PCI_DEVICE_ID_ARECA_1120	0x1120
> -- 
> 2.11.0
> 
