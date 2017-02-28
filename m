Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36053 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdB1Kg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2017 05:36:29 -0500
MIME-Version: 1.0
In-Reply-To: <1488277876-29859-1-git-send-email-ley.foon.tan@intel.com>
References: <1488277876-29859-1-git-send-email-ley.foon.tan@intel.com>
From: Ley Foon Tan <lftan.linux@gmail.com>
Date: Tue, 28 Feb 2017 18:32:41 +0800
Message-ID: <CAFiDJ5-24Ya_7TEASiO=KFkBWLAWzcL2FncqyM6dDmp6LazE8Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera: Fix TLP_CFG_DW0 for TLP write
To: Ley Foon Tan <ley.foon.tan@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 28, 2017 at 6:31 PM, Ley Foon Tan <ley.foon.tan@intel.com> wrote:
> Commit eb5767122feba1 used the TLP_FMTTYPE_CFGRD* for TLP write operation
> and this cause writing to configuration space will fail. This patch
> fix it by using correct FMTTYPE for write operation.
>
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  drivers/pci/host/pcie-altera.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 0c15402..68c839f 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -57,10 +57,14 @@
>  #define TLP_WRITE_TAG                  0x10
>  #define RP_DEVFN                       0
>  #define TLP_REQ_ID(bus, devfn)         (((bus) << 8) | (devfn))
> -#define TLP_CFG_DW0(pcie, bus)                                         \
> +#define TLP_CFGRD_DW0(pcie, bus)                                       \
>      ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGRD0                 \
>                                     : TLP_FMTTYPE_CFGRD1) << 24) |      \
>       TLP_PAYLOAD_SIZE)
> +#define TLP_CFGWR_DW0(pcie, bus)                                       \
> +    ((((bus == pcie->root_bus_nr) ? TLP_FMTTYPE_CFGWR0                 \
> +                                   : TLP_FMTTYPE_CFGWR1) << 24) |      \
> +     TLP_PAYLOAD_SIZE)
>  #define TLP_CFG_DW1(pcie, tag, be)     \
>      (((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
>  #define TLP_CFG_DW2(bus, devfn, offset)        \
> @@ -222,7 +226,7 @@ static int tlp_cfg_dword_read(struct altera_pcie *pcie, u8 bus, u32 devfn,
>  {
>         u32 headers[TLP_HDR_SIZE];
>
> -       headers[0] = TLP_CFG_DW0(pcie, bus);
> +       headers[0] = TLP_CFGRD_DW0(pcie, bus);
>         headers[1] = TLP_CFG_DW1(pcie, TLP_READ_TAG, byte_en);
>         headers[2] = TLP_CFG_DW2(bus, devfn, where);
>
> @@ -237,7 +241,7 @@ static int tlp_cfg_dword_write(struct altera_pcie *pcie, u8 bus, u32 devfn,
>         u32 headers[TLP_HDR_SIZE];
>         int ret;
>
> -       headers[0] = TLP_CFG_DW0(pcie, bus);
> +       headers[0] = TLP_CFGWR_DW0(pcie, bus);
>         headers[1] = TLP_CFG_DW1(pcie, TLP_WRITE_TAG, byte_en);
>         headers[2] = TLP_CFG_DW2(bus, devfn, where);

Resend the patch by adding stable@vger.kernel.org to cc list.
Please ignore the previous one.

Thanks.

Regards
Ley Foon
