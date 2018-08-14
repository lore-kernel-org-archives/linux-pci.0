Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33130 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729955AbeHNPz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Aug 2018 11:55:28 -0400
MIME-Version: 1.0
In-Reply-To: <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
References: <CA+Kvs9kZKt0tvsB-YqomM7grvRyDr=B-HPWUNv1ZcKi8w9ms-A@mail.gmail.com>
 <cdc09cf9-27dd-7838-34e7-12d63571e770@ti.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 Aug 2018 15:08:00 +0200
Message-ID: <CANiq72mfrdTkgUamfTZ7rizfwVP-bzTbPBQ=waz0zKUpxnggiQ@mail.gmail.com>
Subject: Re: PCI Endpoint - Missing inbound mapping ops ?
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ramon Fried <ramon.fried@gmail.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On Tue, Aug 14, 2018 at 2:53 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Tuesday 14 August 2018 06:19 PM, Ramon Fried wrote:
>> Hi.
>> I recently saw that the PCI endpoint API only supports outbound memory
>> mapping: (AXI -> PCI) through the map_addr op.
>> Why inbound mapping is missing (PCI->AXI) is missing ?
>> In almost all of the PCI EP controllers I've worked with there was a
>> need to map complete BARS or part of BARS to mmio/aperature regions on
>> the device.
>
> pci_epc_set_bar() is used for mapping BAR.

Just to let you know, the ARC/DKIM seems wrong according to gmail and
is marked as spam. It seems it happens from time to time. Bjorn
Helgaas (in CC) also had the same problem a couple of years ago.

Cheers,
Miguel

>
> Thanks
> Kishon
