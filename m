Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:54283 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3JHAHp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 20:07:45 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so17406180iec.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 17:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 Oct 2013 18:07:24 -0600
Message-ID: <CAErSpo6KauiOBXh3QOS9=6QC_bjQqTgiDtnCAo1eb0d=uKgo-A@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
To: Jingoo Han <jg1.han@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 7, 2013 at 6:04 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> The following variables and functions are used only in pcie-designware.c,
> so make them static:
...
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index c10e9ac..900e875 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -64,7 +64,7 @@
>
>  static struct hw_pci dw_pci;
>
> -unsigned long global_io_offset;
> +static unsigned long global_io_offset;

While you're looking at this, I think "cfg_read()" and "cfg_write()"
are too generic to be global symbols.  I don't know if it would make
sense to rename them "dw_cfg_read()", pass around pointers in a
structure or what.

Bjorn
