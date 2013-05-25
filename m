Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:42371 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758177Ab3EYXqk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 May 2013 19:46:40 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6749279obc.41
        for <linux-pci@vger.kernel.org>; Sat, 25 May 2013 16:46:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
References: <1369481787-21500-1-git-send-email-haokexin@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 25 May 2013 17:46:19 -0600
Message-ID: <CAErSpo7abMuK2Xsz6K_JF-guKO9TkZ09cpT9RudFSe_OZJ1U+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fix the pci device malfunction if a wrong bus
 address is assigned by firmware
To: Kevin Hao <haokexin@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 25, 2013 at 5:36 AM, Kevin Hao <haokexin@gmail.com> wrote:
> v2:
>  * Use the method suggested by Bjorn to check if we have a wrong bus address
>    set in the PCI BAR register.
>  * Split the "move the pcibios_bus_to_resource() call out of the if/else wrap"
>    change into a new patch.
>  * A minor new patch is introduced to add 0x prefix for the PCI BAR register
>    position.
>
> v1:
> On a fsl p2020rdb-pc board, the onboard pci device is assigned the bus address
> 0xa0000000 by firmware. But the kernel allocate the cpu address 0xa0000000 ~ 0xbfffffff
> to this PCIe controller and use 0xe0000000 ~ 0xdfffffff as its bus address.
> In this case the kernel would think that the bus address in this pci device
> is correct and leave it unchanged. Then causes this device not work.
>
> Even though this looks like a mismatch of the address space between firmware
> and kernel. I think we should detect this kind of error and fix it automatically
> if we don't want just to probe only (PCI_PROBE_ONLY is not set).
>
> ---
> Kevin Hao (3):
>   PCI: add 0x prefix when printing the BAR registers position in
>     __pci_read_base
>   PCI: converge the unnecessary sprinkling of pcibios_bus_to_resource in
>         __pci_read_base
>   PCI: unset the resource if a wrong bus address is assigned by firmware
>
>  drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)

Applied to my "next" branch for v3.11, thanks.

Bjorn
