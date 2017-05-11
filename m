Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40019 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755154AbdEKIQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2017 04:16:31 -0400
Message-ID: <1494490587.15454.9.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: dwc: fall back to legacy IRQs when multiple
 devices are attached
From: Lucas Stach <l.stach@pengutronix.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        patchwork-lst@pengutronix.de
Date: Thu, 11 May 2017 10:16:27 +0200
In-Reply-To: <CAJ+vNU0pcivE53grF6n939gXC0E6-HN4fFJ7Pm9hq3nV1YYSUQ@mail.gmail.com>
References: <20170426181502.770-1-l.stach@pengutronix.de>
         <CAJ+vNU0AEZtc+DaYSV7S1LtXCncVh9nV4hG7BtYxJE=m6-80EA@mail.gmail.com>
         <1493282584.13947.6.camel@pengutronix.de>
         <CAJ+vNU3tHG2c0XJhs3qD0xS4BP==fWEwP6Y78+4WpUmn-KksBg@mail.gmail.com>
         <CAJ+vNU0pcivE53grF6n939gXC0E6-HN4fFJ7Pm9hq3nV1YYSUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

Am Mittwoch, den 10.05.2017, 14:44 -0700 schrieb Tim Harvey:
> On Thu, Apr 27, 2017 at 8:32 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> > On Thu, Apr 27, 2017 at 1:43 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> >> Am Mittwoch, den 26.04.2017, 14:11 -0700 schrieb Tim Harvey:
> >>> On Wed, Apr 26, 2017 at 11:15 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> >>> > The DWC host does not support legacy PCI IRQs and MSIs at the same time,
> >>> > so we need to fall back to using only legacy IRQs if there is a chance
> >>> > that multiple devices with differing MSI capabilities are connected to
> >>> > the host. The only configuration where MSIs can be safely used is when
> >>> > the device below the host bridge is not a bridge, i.e. the only device
> >>> > connected to this host.
> >>> >
> >>> > By disallowing MSI allocation when multiple devices might be attached
> >>> > we get those configurations in a working state. The only configurations
> >>> > that depend on MSIs being available, that I am aware of, are some
> >>> > embedded devices with a PCIe attached FPGA, that is incapable of
> >>> > generating PCI legacy IRQs. Those are kept working by allowing MSIs
> >>> > when only a single device is attached to the host.
> >>> >
> >>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> >>> > ---
[...]
> Lucas,
> 
> Are you not able to repeat my findings?

Yes, I see what's going on.

> Since Linux 4.8 IMX PCIe is completely broken for PCIe devices that do
> not support MSI interrupts (and there are a whole lot of 802.11n
> radios that fall into this category) as you can no longer disable MSI
> because the IMX PCIe driver depends on it.
> 
> It seems like your patch is the right approach but something must
> still be getting set that causes the legacy interrupts to not fire.

The issue here are the port-services, which are using MSI when
available, which might conflict with the device requirements, even if
only a single device is attached.

Probably we need to disable MSI on all systems, unless we know that we
absolutely need them (EP devices, which don't support legacy IRQs). I'll
send a patch to do this, but other issues have been higher priority
again.

Regards,
Lucas
