Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbeIQPOU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 11:14:20 -0400
Date: Mon, 17 Sep 2018 10:47:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Vignesh R <vigneshr@ti.com>, KISHON VIJAY ABRAHAM <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Message-ID: <20180917094736.GA7072@e107981-ln.cambridge.arm.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
 <20180808165700.GB486@e107981-ln.cambridge.arm.com>
 <ba428a15-77bf-e09c-3bd7-b5a0eae7ee13@ti.com>
 <20180907170009.GJ5662@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907170009.GJ5662@atomide.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 10:00:09AM -0700, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [180810 10:10]:
> > 
> > 
> > On Wednesday 08 August 2018 10:27 PM, Lorenzo Pieralisi wrote:
> > > On Tue, Jul 24, 2018 at 11:01:46PM +0530, Vignesh R wrote:
> > >> Make workaround for errata i870 applicable in Host mode as
> > >> well(previously it was enabled only for EP mode) as per errata
> > >> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
> > >>
> > >> Tested on DRA72 EVM
> > >>
> > >> Tony,
> > >>
> > >> If you are okay with the series, could you pick this via omap tree?
> > >> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
> > >> rest of DTS changes.
> > > 
> > > I think we have missed the v4.19 merge window by now - 
> > 
> > Right. I didn't get any response from Tony.
> 
> Sorry catching up with pending mails.. I try hard to not touch
> anything except fixes around -rc6 time.
> 
> > > please let me know if I can drop this series from the PCI patch queue.
> > > 
> > 
> > Ok, I will resend the patch after 4.19-rc. Thanks!
> 
> FYI, I'm untagging this thread too. Please post the dts
> changes separately once the dependencies (if any) have
> cleared.

Ok, Vignesh: I shall drop this series from the PCI patches queue,
waiting for your new version, let me know how you want to handle this
then please.

Thanks,
Lorenzo
