Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbdJZPQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2017 11:16:58 -0400
Subject: Re: [RFC PATCH v8 7/7] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
To: Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com,
        shawn.lin@rock-chips.com, briannorris@chromium.org,
        rjw@rjwysocki.net, dianders@chromium.org, linux-pci@vger.kernel.org
References: <20171026132840.20946-1-jeffy.chen@rock-chips.com>
 <20171026132840.20946-8-jeffy.chen@rock-chips.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <334be327-543f-d379-83de-ce84799fa49a@codeaurora.org>
Date: Thu, 26 Oct 2017 11:16:55 -0400
MIME-Version: 1.0
In-Reply-To: <20171026132840.20946-8-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/26/2017 9:28 AM, Jeffy Chen wrote:
>  drivers/pci/Makefile |   2 +-
>  drivers/pci/pci-of.c | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pci-of.c
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 66a21acad952..4f76dbdb024c 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -49,7 +49,7 @@ obj-$(CONFIG_PCI_ECAM) += ecam.o
>  
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  
> -obj-$(CONFIG_OF) += of.o
> +obj-$(CONFIG_OF) += of.o pci-of.o

If the intention is to push this to pci directory, this code needs to be made
platform agnostic by splitting into two pieces.

I think you can make this code common by abstracting the IRQ number and
have some generic code like pci-wake.c in pci directory without the of prefix
in this file.

Then, you can have some other OF specific code in the drivers/of directory
that reads the IRQ from OF and calls the common code in PCI directory.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
