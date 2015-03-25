Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33206 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbCYA2l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2015 20:28:41 -0400
Received: by qgfa8 with SMTP id a8so16996384qgf.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2015 17:28:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1427175230-22325-1-git-send-email-rjui@broadcom.com>
References: <1427175230-22325-1-git-send-email-rjui@broadcom.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Mar 2015 19:28:20 -0500
Message-ID: <CAErSpo6MPw7m-zJbCAxGAaRm7jptpaJ-937A6qNXELNTggf9ZA@mail.gmail.com>
Subject: Re: [PATCH] pci: iproc: fix PCIE_IPROC in Kconfig
To: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 24, 2015 at 12:33 AM, Ray Jui <rjui@broadcom.com> wrote:
> Make PCIE_IPROC depending on both OF and ARM and default to be disabled,
> so it cannot be accidentally enabled by other platforms
>
> PCIE_IPROC is meant to be enabled by a front-end bus driver. Curenntly
> it's enabled by PCIE_IPROC_PLTFM driver
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> ---
>  drivers/pci/host/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index feccd0d..963b507 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -108,6 +108,8 @@ config PCI_VERSATILE
>
>  config PCIE_IPROC
>         tristate "Broadcom iProc PCIe controller"
> +       depends on OF && ARM
> +       default n
>         help
>           This enables the iProc PCIe core controller support for Broadcom's
>           iProc family of SoCs. An appropriate bus interface driver also needs

What pattern are you following?  There must be other drivers with
similar front-end bus driver schemes, and I'd rather copy their
Kconfig descriptions than invent something new.

With CONFIG_PCIE_IPROC_PLTFM, can we spell out "PLATFORM"?  Doesn't
seem like there's anything to gain by abbreviating it.

Bjorn
