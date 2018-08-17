Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQGJV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Aug 2018 02:09:21 -0400
Date: Thu, 16 Aug 2018 22:07:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hari Vyas <hari.vyas@broadcom.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
Message-ID: <20180817030741.GC10316@bhelgaas-glaptop.roam.corp.google.com>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
 <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Srinath, Guenter, Jens, Lukas, Konstantin, Marta, Pierre-Yves]

On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> [Note: This isn't meant to be merged, it need splitting at the very
> least, see below]
> 
> This is something I cooked up quickly today to test if that would fix
> my problems with large number of switch and NVME devices on POWER.
> 
> So far it does...
> 
> The issue (as discussed in the Re: PCIe enable device races thread) is
> that pci_enable_device and related functions along with pci_set_master
> and pci_enable_bridge are fundamentally racy.
> 
> There is no lockign protecting the state of the device in pci_dev and
> if multiple devices under the same bridge try to enable it simultaneously
> one some of them will potentially start accessing it before it has actually
> been enabled.
> 
> Now there are a LOT more fields in pci_dev that aren't covered by any
> form of locking.

Most of the PCI core relies on the assumption that only a single
thread touches a device at a time.  This is generally true of the core
during enumeration because enumeration is single-threaded.  It's
generally true in normal driver operation because the core shouldn't
touch a device after a driver claims it.

But there are several exceptions, and I think we need to understand
those scenarios before applying locks willy-nilly.

One big exception is that enabling device A may also touch an upstream
bridge B.  That causes things like your issue and Srinath's issue
where drivers simultaneously enabling two devices below the same
bridge corrupt the bridge's state [1].  Marta reported essentially the
same issue [2].

Hari's issue [3] seems related to a race between a driver work queue
and the core enumerating the device.  I should have pushed harder to
understand this; I feel like we papered over the immediate problem
without clearing up the larger issue of why the core enumeration path
(pci_bus_add_device()) is running at the same time as a driver.

DPC/AER error handling adds more cases where the core potentially
accesses devices asynchronously to the driver.

User-mode sysfs controls like ASPM are also asynchronous to drivers.

Even setpci is a potential issue, though I don't know how far we want
to go to protect it.  I think we should make setpci taint the kernel
anyway.

It might be nice if we had some sort of writeup of the locking
strategy as a whole.

[1] https://lkml.kernel.org/r/1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com
[2] https://lkml.kernel.org/r/744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu
[3] https://lkml.kernel.org/r/1530608741-30664-2-git-send-email-hari.vyas@broadcom.com
