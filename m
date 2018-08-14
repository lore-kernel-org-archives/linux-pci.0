Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46382 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPmu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2018 11:42:50 -0400
MIME-Version: 1.0
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
In-Reply-To: <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Tue, 14 Aug 2018 13:55:32 +0100
Message-ID: <CA+Kvs9mV3u045acfBa2pEiUcVDyYroVrobtsKKBpDAfX+Os5iQ@mail.gmail.com>
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2018 at 1:53 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
> > Hi.
> > I recently saw that the PCI endpoint API only supports outbound memory
> > mapping: (AXI -> PCI) through the map_addr op.
> > Why inbound mapping is missing (PCI->AXI) is missing ?
> > In almost all of the PCI EP controllers I've worked with there was a
> > need to map complete BARS or part of BARS to mmio/aperature regions on
> > the device.
>
> pci_epc_set_bar() is used for mapping BAR.
Thanks Kishon.
what about address mapping ? Synopsys has this functionality if I
recall correctly.

>
> Thanks
> Kishon
