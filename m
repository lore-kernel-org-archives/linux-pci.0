Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52227 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab2ARE2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 23:28:00 -0500
Received: by yhoo21 with SMTP id o21so535291yho.19
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 20:28:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120118003507.467.40594.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
	<20120118003507.467.40594.stgit@bhelgaas.mtv.corp.google.com>
Date: Tue, 17 Jan 2012 20:27:59 -0800
Message-ID: <CAE9FiQX7-ceMTnh+wzDdNTMXYoea1Qt+H=nT0-Nwi3hj-Z81Ow@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: add struct pci_host_bridge and pci_scan_host_bridge()
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2012 at 4:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> This adds a struct pci_host_bridge so the PCI core can keep track of
> generic attributes like the subordinate bus number range and the
> resources available to that PCI device tree.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/probe.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |   20 +++++++++++++++
>  2 files changed, 89 insertions(+), 0 deletions(-)
>
> +struct pci_host_bridge *pci_scan_host_bridge(struct device *parent,
> +               int domain, struct resource *subordinate,
> +               struct list_head *resources, struct pci_ops *ops,
> +               void *sysdata)
> +{
> +       struct pci_host_bridge *bridge;
> +       struct pci_bus *bus;
> +
> +       bridge = pci_create_host_bridge(parent, domain, subordinate, resources,
> +                                       ops, sysdata);
> +       if (!bridge)
> +               return NULL;
> +
> +       bus = bridge->bus;
> +       bus->subordinate = pci_scan_child_bus(bus);
> +       pci_bus_add_devices(bus);
> +       return bridge;
> +}

looks like there is no user for pci_scan_host_bridge() in this series.

Yinghai
