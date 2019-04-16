Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85C3C10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9438820821
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 11:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTYGXKd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDPLVq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:21:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36200 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDPLVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2019 07:21:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so24877727wml.1;
        Tue, 16 Apr 2019 04:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zu1nQwlj5uOmb4uRKlUVAbsL89BWfTJRhCzjzid6Kqc=;
        b=LTYGXKd8aWnWY68WJ/7nYkgQNRz2eDt9nm/rBsjsXnmxBuArKd80OoxMI0p1DsN6nW
         vSJ1KiNRRZyhBYI2xp2pI7JysRps+tEOtJHGgFpVeewsKt7J3ICcu5+MKyrgS80k1wNV
         dV4ivsrXMauV7Ibso9aGF7nTkgEJk17cbg3QsLfvESy13Ot0Up276l7YoOhWFdpNZpYf
         qOPlJ5VsqzYH8A+MBIrILCj+rqK8b+WC1BxQyAUtEzmNxxGUh2YKdJNidJArQzxfwBa0
         ovHZvZVjY0DZTfWMUJFSKFBVJBQdnXdqk2Ukxqjr9oCREt6htyWNsFhBKfcRWVNixqyy
         6jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zu1nQwlj5uOmb4uRKlUVAbsL89BWfTJRhCzjzid6Kqc=;
        b=mQNIp5w+fVNmQUE+ZEA3In6cehKxli8BX30z91+QbsGuGO2hcJwaPK627u/xs6+6UT
         sFMEz1+yPJYUeRlvqPzRY68moCDsFCy455XDMAtvUbaFgeW/21TNA4yGRFsJc0EL3HuV
         /Q6aixY72CPq3PqI86HM3YXJzyc0XkszOopZ3lNpBf3o3mOlN3tdwF2QYTP0vemZBRBs
         M6eSkIZi7uxHcOOpGYMunu41jOzjKF4qmL3iBEn9XV12n9BeUCqEcvaTN5pqg0TUNRui
         bhSHCT1WhXXpwD0DusfOELrQLaarVoVfcyS1cLdC6xSUzFlsch8cFroA2kQoFxjwWflv
         +ZCQ==
X-Gm-Message-State: APjAAAWHNRPyzwqg/nHHlbqar1drfZX95D1SkR1CHLG0QqSqCTVL/Z4n
        oHiO4UgZ6JGc5jaCt8cGNPm6FxVALFRddNhPZvY=
X-Google-Smtp-Source: APXvYqzyGyrlS47xZanrHxWyc2qvseOmowgNBVm+bxbwv+dUGS6caHGsTaDuoAy+xKwo0MOh6JB+WolYwRcaGaVuIHA=
X-Received: by 2002:a1c:720a:: with SMTP id n10mr25278838wmc.107.1555413704607;
 Tue, 16 Apr 2019 04:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <1554380425-29215-1-git-send-email-vidyas@nvidia.com> <1554380425-29215-2-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1554380425-29215-2-git-send-email-vidyas@nvidia.com>
From:   vidya sagar <sagar.tv@gmail.com>
Date:   Tue, 16 Apr 2019 16:51:33 +0530
Message-ID: <CAN7O0+LrM8pdSZaVpy-G1BZJUQPSPKPrfBBBm5WiEN8+XJGn8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Add API support to de-initialize host
To:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, NManikanta <mmaddireddy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Anyone for the review of this patch series (total 2 patches)?

On Thu, Apr 4, 2019 at 5:50 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Add an API to group all the tasks to be done to de-initialize host which
> can then be called by any Designware core based driver implementations
> while adding .remove() support in their respective drivers.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e4169e738a5..d7881490282d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -516,6 +516,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>         return ret;
>  }
>
> +void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +       pci_stop_root_bus(pp->root_bus);
> +       pci_remove_root_bus(pp->root_bus);
> +       dw_pcie_free_msi(pp);
> +}
> +
>  static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>                                      u32 devfn, int where, int size, u32 *val,
>                                      bool write)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index adff0c713665..ea8d1caf11c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -343,6 +343,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>  void dw_pcie_free_msi(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_host_deinit(struct pcie_port *pp);
>  int dw_pcie_allocate_domains(struct pcie_port *pp);
>  #else
>  static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> @@ -367,6 +368,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
>         return 0;
>  }
>
> +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +}
> +
>  static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>  {
>         return 0;
> --
> 2.7.4
>
