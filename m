Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33430 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbaIVU1v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 16:27:51 -0400
Received: by mail-ig0-f180.google.com with SMTP id a13so3442577igq.7
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 13:27:50 -0700 (PDT)
Date: Mon, 22 Sep 2014 14:27:48 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/5] x86/PCI: Minor size reduction by marking init code
 and data as such
Message-ID: <20140922202748.GE1880@google.com>
References: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 25, 2014 at 11:26:34PM +0200, Mathias Krause wrote:
> Hi Bjorn,
> 
> this series is a collection of patches trying to mark initialization
> code and data of the x86 specific PCI code as such. It also contains
> __init annotation cleanups to move them to the spot they belong to
> according to include/linux/init.h.
> 
> The annotation leads to a nice reduction of run-time memory size. At
> least two additional pages can be released after initialization which
> are otherwise occupied by code and data no longer needed.
> 
> Please apply!
> 
> Thanks,
> 
> Mathias Krause (5):
>   x86/PCI: Mark DMI tables as initialization data
>   x86/PCI: Move __init annotation were it belongs to
>   x86/PCI: Mark constants of pci_mmcfg_nvidia_mcp55() as __initconst
>   x86/PCI: Constify pci_mmcfg_probes[] array
>   x86/PCI: Mark PCI BIOS initialization code as such

All applied to pci/initdata for v3.18, thanks!

> 
>  arch/x86/pci/common.c          |   20 ++++++++--------
>  arch/x86/pci/mmconfig-shared.c |   40 ++++++++++++++++++--------------
>  arch/x86/pci/pcbios.c          |    8 +++----
>  3 files changed, 36 insertions(+), 32 deletions(-)
> 
> -- 
> 1.7.10.4
> 
