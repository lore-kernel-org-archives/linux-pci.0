Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56027 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbbKGALu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Nov 2015 19:11:50 -0500
Date: Fri, 6 Nov 2015 18:11:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: ECRC and Max Read Request Size
Message-ID: <20151107001143.GA17842@localhost>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost>
 <563CE93F.5060209@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563CE93F.5060209@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 06, 2015 at 12:54:07PM -0500, Sinan Kaya wrote:
> On 11/6/2015 12:22 PM, Bjorn Helgaas wrote:
> >On Wed, Oct 28, 2015 at 01:51:48PM -0400, Sinan Kaya wrote:
> >>I'm seeing two problems with the current PCI framework when it comes
> >>to end-to-end CRC (ECRC) and Max Read Request Size.
> >>
> >>The problem with ECRC is that it blindly enables ECRC generation on
> >>devices without checking if it is supported by the entire bus with
> >>ECRC=on option.
> >>
> >>ECRC check can be enabled on all devices but ECRC generation on the
> >>root complex and switches needs to be set only if all devices
> >>support ECRC checking.
> >>
> >>I'm thinking of making changes in this area to cover this gap with
> >>ECRC=safe option.
> >
> >Sometimes they can't be avoided, but I'm generally not in favor of
> >adding command line parameters because they require too much of our
> >users and they introduce code paths that are rarely exercised.
> >
> >What specific ECRC problem are you seeing?  Do you have devices that
> >don't operate correctly with the current code?  Or do you want to add
> >some new functionality, e.g., to enable ECRC in cases where we don't
> >enable it today?
> 
> ECRC is an optional PCIe feature. Even ECRC support has some flavors
> 
> - A card can support ECRC checking.
> - A card can support ECRC checking and generation.
> 
> Right now, the code is enabling both without checking if they are
> supported at all.
> 
> I have some legacy PCIe cards that don't support ECRC completely
> even though the host bridge supports it. If ECRC checking and
> generation is enabled under this situation, I have problems
> communicating to the endpoint.

That should definitely be fixed.  Do we enable ECRC unconditionally,
or only when we boot with "pci=ecrc=on"?  The doc
(Documentation/kernel-parameters.txt) suggests the latter.

It would be ideal if we could try to turn on ECRC all the time by
default for paths that support it.  I suppose there's some risk that
we'd trip over broken hardware.  If that's an issue, we could consider
turning it on all the time on machines newer than X (that's easy on
x86, where we have a DMI BIOS date, but maybe not so easy on other
arches).

> Another opinion is let the firmware do its magic before the OS
> starts but there is no way to apply the same settings after a
> hot-plug insertion.

The ACPI _HPX method does allow the BIOS to specify Device Control
register values, so it's conceivable that MPS and MRRS could be
configured that way for hot-added devices.  But we currently
explicitly ignore those _HPX fields (see 302328c00341) because I don't
think it's safe to use them blindly, at least for MPS.  If the Linux
MPS configuration stopped making assumptions about MRRS settings, I
think it probably would be safe to use _HPX MRRS values.

Bjorn
