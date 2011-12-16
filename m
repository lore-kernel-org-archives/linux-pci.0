Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57883 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab1LPWeY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2011 17:34:24 -0500
Received: by ggdk6 with SMTP id k6so3152500ggd.19
        for <linux-pci@vger.kernel.org>; Fri, 16 Dec 2011 14:34:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111216223154.5963.39965.stgit@bhelgaas.mtv.corp.google.com>
References: <20111216223043.5963.87534.stgit@bhelgaas.mtv.corp.google.com>
	<20111216223154.5963.39965.stgit@bhelgaas.mtv.corp.google.com>
Date: Fri, 16 Dec 2011 14:34:24 -0800
Message-ID: <CANEJEGsm-vz767_98uaDT48mYwG_dJnUOmhqkgGPRqJpHhiFDA@mail.gmail.com>
Subject: Re: [PATCH 5/6] de4x5/PCI: use list_for_each_entry() for bus->devices traversal
From: Grant Grundler <grantgrundler@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	Grant Grundler <grundler@parisc-linux.org>,
	netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 16, 2011 at 2:31 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Replace open-coded list traversal with list_for_each_entry().

Hi Bjorn,

I don't have any de4x5 devices to test this but it looks correct to me.

Thanks!
grant

>
> CC: Grant Grundler <grundler@parisc-linux.org>
> CC: netdev@vger.kernel.org
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/net/ethernet/dec/tulip/de4x5.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/dec/tulip/de4x5.c b/drivers/net/ethernet/dec/tulip/de4x5.c
> index 871bcaa..3f5d3b9 100644
> --- a/drivers/net/ethernet/dec/tulip/de4x5.c
> +++ b/drivers/net/ethernet/dec/tulip/de4x5.c
> @@ -2127,14 +2127,9 @@ srom_search(struct net_device *dev, struct pci_dev *pdev)
>     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
>     int i, j;
>     struct de4x5_private *lp = netdev_priv(dev);
> -    struct list_head *walk;
> -
> -    list_for_each(walk, &pdev->bus_list) {
> -       struct pci_dev *this_dev = pci_dev_b(walk);
> -
> -       /* Skip the pci_bus list entry */
> -       if (list_entry(walk, struct pci_bus, devices) == pdev->bus) continue;
> +    struct pci_dev *this_dev;
>
> +    list_for_each_entry(this_dev, &pdev->bus->devices, bus_list) {
>        vendor = this_dev->vendor;
>        device = this_dev->device << 8;
>        if (!(is_DC21040 || is_DC21041 || is_DC21140 || is_DC2114x)) continue;
>
