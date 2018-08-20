Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46453 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbeHTOfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Aug 2018 10:35:18 -0400
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-8-arnd@arndb.de>
 <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Aug 2018 13:19:48 +0200
Message-ID: <CAK8P3a31Ds14Ke1qLoMapK1Wq1M4tR6n+nL1VOKzR8+oN0eOBw@mail.gmail.com>
Subject: Re: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
To: Rafael Wysocki <rafael@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 10:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 17, 2018 at 12:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > @@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >         int ret, busnum = root->secondary.start;
> >         struct acpi_device *device = root->device;
> >         int node = acpi_get_node(device->handle);
> > -       struct pci_bus *bus;
> > -       struct pci_host_bridge *host_bridge;
> > +       struct pci_host_bridge *bridge;
>
> Why "bridge" and not "host" or even something to stand for "root complex"?
>
> Or maybe it can still be "host_bridge"?

I did this for consistency with the naming in drivers/pci/probe.c,
which always declares the local variable as 'struct pci_host_bridge *bridge'.
It's easy to change here if you feel strongly about it (I don't).

        Arnd
