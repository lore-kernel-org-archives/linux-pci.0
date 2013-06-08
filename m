Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:50931 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3FHSBT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Jun 2013 14:01:19 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so4486472oag.31
        for <linux-pci@vger.kernel.org>; Sat, 08 Jun 2013 11:01:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201306081343.23776.gianogli@tiscali.it>
References: <201306081343.23776.gianogli@tiscali.it>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 8 Jun 2013 12:00:55 -0600
Message-ID: <CAErSpo4=wdtdOk3L_mFeXVZp-A6PiNqy7mtzhrJhfjYash4tpA@mail.gmail.com>
Subject: Re: Reconfigure the Intel 5520 I/O hub
To: Gianluca Oglietti <gianogli@tiscali.it>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 8, 2013 at 5:43 AM, Gianluca Oglietti <gianogli@tiscali.it> wrote:
> I've a Supermicro server with a X8DTU-6TF+ matherboard. (You can find the
> system block diagram at http://goo.gl/ibWhb).
> It is a NUMA system with 2 processors and only one Intel 5520 I/O hub.
> In the last weeks I've made some studies about the optimization of the
> TCP/IP packets realtime analysis but I've encountered a problem.
> All the PCIe interfaces, where are used the NICs, are interconnected,
> through the Intel 5520 I/O hub, only to the NUMA node 0:
> ...

> Is there a way to reconfigure the Intel 5520 I/O hub (via software,
> without a new BIOS) to connect one NIC to NUMA node 0 and the other one
> to NUMA node 1?

There's no standard way to do this via the PCI core, because it's too
system-specific.

You might be able to learn something by reading the 5520 spec:
http://www.intel.com/content/www/us/en/chipsets/5520-5500-chipset-ioh-datasheet.html

It sounds like your system is similar to Figure 1-1 in that doc, which
looks pretty symmetric.  I don't know anything about the 5520
internals, or why there might be preferential routing to NUMA node 0
over node 1.

Have you measured a difference in NIC performance between NUMA node 0
and 1?  Maybe the I/O connections actually are symmetric, and the BIOS
just uses the same distance tables, i.e., whatever determines the
local_cpulist contents, for both a single-node and a two-node system?

Bjorn
