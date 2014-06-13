Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:56522 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaFMFmX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jun 2014 01:42:23 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so2329203qcv.38
        for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2014 22:42:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
	<1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
Date: Fri, 13 Jun 2014 11:12:22 +0530
Message-ID: <CAHM4w1kfsVbcNquK4t1NJqYRc9Qrjg6JYNJuAV=cpZ81Zm-pnw@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: allow MSI chip providers to implement their own
 multiple MSI setup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>, kernel@pengutronix.de,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Richard Zhu <richard.zhu@linaro.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Pratyush ANAND <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

 Hi Lucas,


On Thu, Jun 5, 2014 at 8:16 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/msi.c   | 3 +++
>  include/linux/msi.h | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 27a7e67ddfe4..c45399d3061a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -68,9 +68,12 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> +       struct msi_chip *chip = dev->bus->msi;
>         struct msi_desc *entry;
>         int ret;
>
> +       if (chip && chip->setup_irqs)

I think, you should also check here for nvec > 1

> +               return chip->setup_irqs(chip, dev, nvec, type);

Before return, shouldn't we set chip_data for all desc->irq?

>         /*
>          * If an architecture wants to support multiple MSI, it needs to
>          * override arch_setup_msi_irqs()

This comment can be modified like "If an architecture wants
to support multiple MSI, it needs to either override arch_setup_msi_irqs()
or provide support of setup_irqs."

Regards
Pratyush
