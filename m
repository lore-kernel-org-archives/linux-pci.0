Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ed1-f44.google.com ([209.85.208.44]:46103 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNPx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2018 11:53:28 -0400
MIME-Version: 1.0
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com> <CA+Kvs9mV3u045acfBa2pEiUcVDyYroVrobtsKKBpDAfX+Os5iQ@mail.gmail.com>
 <3ffbd957-a62f-b1ec-63b9-4ab3e03c8873@ti.com>
In-Reply-To: <3ffbd957-a62f-b1ec-63b9-4ab3e03c8873@ti.com>
From: Ramon Fried <ramon.fried@gmail.com>
Date: Tue, 14 Aug 2018 14:06:09 +0100
Message-ID: <CA+Kvs9nSyB0t8DKnf3AQrke5rh1N7O8E8mFKOkOOoHCYbHC+=A@mail.gmail.com>
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To: kishon@ti.com
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 14, 2018 at 2:04 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On Tuesday 14 August 2018 06:25 PM, Ramon Fried wrote:
> > On Tue, Aug 14, 2018 at 1:53 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
> >>> Hi.
> >>> I recently saw that the PCI endpoint API only supports outbound memory
> >>> mapping: (AXI -> PCI) through the map_addr op.
> >>> Why inbound mapping is missing (PCI->AXI) is missing ?
> >>> In almost all of the PCI EP controllers I've worked with there was a
> >>> need to map complete BARS or part of BARS to mmio/aperature regions on
> >>> the device.
> >>
> >> pci_epc_set_bar() is used for mapping BAR.
> > Thanks Kishon.
> > what about address mapping ? Synopsys has this functionality if I
> > recall correctly.
>
> The addresses that the RC will put in BAR's is not known while we initialize
> the endpoint. So we really can't map BAR's PCI address to an inbound address
> while EP initialization.
>
> I think some older version of Synopsys had this (and didn't have BAR mapping).
> Actually TI's K2G had this IP. However the ATU registers here are mapped to
> BAR0. So the host side PCI driver can program the PCI address (that the RC has
> allocated for BARs) in ATU.
Yes. you're right.
Thanks for the clarification.
>
> Thanks
> Kishon
