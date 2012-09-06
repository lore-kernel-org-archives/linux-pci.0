Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60510 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab2IFXUz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2012 19:20:55 -0400
Received: by lbbgj3 with SMTP id gj3so1511966lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 06 Sep 2012 16:20:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1345470395-17295-2-git-send-email-shangw@linux.vnet.ibm.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com> <1345470395-17295-2-git-send-email-shangw@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 6 Sep 2012 17:20:34 -0600
Message-ID: <CAErSpo4EMC+wzfhue=LPAOpE=M0KY1Wgb1331NXvmZiD5S7D=g@mail.gmail.com>
Subject: Re: [PATCH 1/8] pci: change variable name for find_pci_host_bridge
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com, yinghai@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2012 at 7:46 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> The patch changes the variable name for function find_pci_host_bridge()
> so that it looks more meaningful. More specificly, the "bus" has been
> replaced with "root_bus".
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>

I don't understand the point of patches 1-3:

  pci: change variable name for find_pci_host_bridge
  pci: argument pci_bus for find_pci_host_bridge
  pci: fiddle with conversion of pci and CPU address

As far as I can tell, they don't have anything to do with patches 4-8.

I don't mind considering them later if they make things easier to read
or if they enable some other rework, but right now I want to make
progress on the P2P window alignment stuff, and patches 1-3 seem to be
distractions from that.

>  drivers/pci/host-bridge.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index a68dc61..c19776a 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -22,9 +22,9 @@ static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
>
>  static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
>  {
> -       struct pci_bus *bus = find_pci_root_bus(dev);
> +       struct pci_bus *root_bus = find_pci_root_bus(dev);
>
> -       return to_pci_host_bridge(bus->bridge);
> +       return to_pci_host_bridge(root_bus->bridge);
>  }
>
>  void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
> --
> 1.7.5.4
>
