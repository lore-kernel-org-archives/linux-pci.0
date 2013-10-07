Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42380 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3JGWkx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 18:40:53 -0400
Received: by mail-ie0-f170.google.com with SMTP id x13so17904344ief.15
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 15:40:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001801cec162$4d74f770$e85ee650$%han@samsung.com>
References: <001801cec162$4d74f770$e85ee650$%han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Oct 2013 16:40:32 -0600
Message-ID: <CAErSpo6Mns0QzwzvKpDxfiZOCDFVjg3Vocq-Yz0E3WjRiMzxVg@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: designware: add missing header guards
To: Jingoo Han <jg1.han@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Seungwon Jeon <tgih.jun@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 4, 2013 at 6:31 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> From: Seungwon Jeon <tgih.jun@samsung.com>
>
> Add missing header guards against the redundant inclusion.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to my pci/host-designware branch for v3.13, thanks!

Bjorn

> ---
>  drivers/pci/host/pcie-designware.h |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index faccbbf..d87fbae 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -11,6 +11,9 @@
>   * published by the Free Software Foundation.
>   */
>
> +#ifndef _PCIE_DESIGNWARE_H
> +#define _PCIE_DESIGNWARE_H
> +
>  struct pcie_port_info {
>         u32             cfg0_size;
>         u32             cfg1_size;
> @@ -77,3 +80,5 @@ int dw_pcie_host_init(struct pcie_port *pp);
>  int dw_pcie_setup(int nr, struct pci_sys_data *sys);
>  struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys);
>  int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> +
> +#endif /* _PCIE_DESIGNWARE_H */
> --
> 1.7.10.4
>
>
