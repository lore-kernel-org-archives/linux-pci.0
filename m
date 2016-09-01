Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34170 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbcIABRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2016 21:17:30 -0400
MIME-Version: 1.0
In-Reply-To: <1472176045-27815-1-git-send-email-lftan@altera.com>
References: <1472176045-27815-1-git-send-email-lftan@altera.com>
From: Ley Foon Tan <lftan.linux@gmail.com>
Date: Thu, 1 Sep 2016 09:17:27 +0800
Message-ID: <CAFiDJ5-q9=+aLOuHuMtRMnx2Ep3P6h+LXqfeM26Ku1oHbZVQfw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] PCI: altera: Retrain link in rootport mode only
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 26, 2016 at 9:47 AM, Ley Foon Tan <lftan@altera.com> wrote:
> Altera PCIe IP can be configured as rootport or device and they might have
> same vendor ID. It will cause the system hang issue if Altera PCIe is in
> endpoint mode and work with other PCIe rootport that from other vendors.
>
> This series of patch rework configs accessors and move retrain function
> from _FIXUP to altera_pcie_host_init().
>
> History:
> v2: change to check PCIe type is PCI_EXP_TYPE_ROOT_PORT
> v3: Move retrain function to before pci_scan_root_bus and remove _FIXUP
> v4: Split patch to 2 patches
>
> Ley Foon Tan (2):
>   PCI: altera: Rework configs accessors
>   PCI: altera: Move retrain from _FIXUP to altera_pcie_host_init()
>
>  drivers/pci/host/pcie-altera.c | 215 +++++++++++++++++++++++++----------------
>  1 file changed, 132 insertions(+), 83 deletions(-)
>
Hi Bjorn

Do you have further comment on this patch series?
Thanks.

Regards
Ley Foon
