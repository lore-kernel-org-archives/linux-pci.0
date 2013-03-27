Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:56758 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab3C0ReX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2013 13:34:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so9057669oag.5
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 10:34:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363626009-25242-1-git-send-email-phil.edworthy@renesas.com>
References: <1363626009-25242-1-git-send-email-phil.edworthy@renesas.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Mar 2013 11:34:03 -0600
Message-ID: <CAErSpo4zpOvVrirWFwCHjaGg-K2M1kdCAhxopkWmO5Lir16MKA@mail.gmail.com>
Subject: Re: [PATCH] pci: Add ID for Renesas R-Car PCIe host
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus <magnus.damm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 18, 2013 at 11:00 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  include/linux/pci_ids.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index f11c1c2..04693b7 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2363,6 +2363,7 @@
>  #define PCI_DEVICE_ID_RENESAS_SH7763   0x0004
>  #define PCI_DEVICE_ID_RENESAS_SH7785   0x0007
>  #define PCI_DEVICE_ID_RENESAS_SH7786   0x0010
> +#define PCI_DEVICE_ID_RENESAS_RCAR     0x0018

See the comment at the top of pci_ids.h.  If this ID is actually used
in several places, please resend this patch along with the patches
that add those uses.  If it's only used in one place, just put the
definition there (or use the bare number).

>  #define PCI_VENDOR_ID_SOLARFLARE       0x1924
>  #define PCI_DEVICE_ID_SOLARFLARE_SFC4000A_0    0x0703
> --
> 1.7.5.4
>
