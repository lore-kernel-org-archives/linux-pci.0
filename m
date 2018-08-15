Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=/dXs=K6=kernel.crashing.org=benh@kernel.org>
Message-ID: <947d07eb6bc64eefe5cfd9a08420a33f855cbe2c.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org, ray.jui@broadcom.com,
        "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 16 Aug 2018 09:38:41 +1000
In-Reply-To: <20180815224028.GA12104@roeck-us.net>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
	 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
	 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
	 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
	 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
	 <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
	 <20180815224028.GA12104@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-08-15 at 15:40 -0700, Guenter Roeck wrote:
> On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> > (Resent with lkml on copy)
> > 
> > [Note: This isn't meant to be merged, it need splitting at the very
> > least, see below]
> > 
> > This is something I cooked up quickly today to test if that would fix
> > my problems with large number of switch and NVME devices on POWER.
> > 
> 
> Is that a problem that can be reproduced with a qemu setup ?

With difficulty... mt-tcg might help, but you need a rather large
systems to reproduce it.

My repro-case is a 2 socket POWER9 system (about 40 cores off the top
of my mind, so 160 threads) with 72 NVME devices underneath a tree of
switches (I don't have the system at hand today to check how many).

It's possible to observe it I suppose on a smaller system (in theory a
single bridge with 2 devices is enough) but in practice the timing is
extremely hard to hit.

You need a combination of:

  - The bridges come up disabled (which is the case when Linux does the
resource assignment, such as on POWER but not on x86 unless it's
hotplug)

  - The nvme devices try to enable them simultaneously

Also the resulting error is a UR, I don't know how well qemu models
that.

On the above system, I get usually *one* device failing due to the race
out of 72, and not on every boot.

However, the bug is known (see Bjorn's reply to the other thread) "Re:
PCIe enable device races (Was: [PATCH v3] PCI: Data corruption
happening due to race condition)" on linux-pci, so I'm not the only one
with a repro-case around.

Cheers,
Ben.
