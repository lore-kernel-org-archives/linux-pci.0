Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60904 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbKITrf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Nov 2015 14:47:35 -0500
Date: Mon, 9 Nov 2015 13:47:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: ECRC and Max Read Request Size
Message-ID: <20151109194732.GB4789@localhost>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost>
 <563CE93F.5060209@codeaurora.org>
 <20151107001143.GA17842@localhost>
 <563D7287.1050500@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <563D7287.1050500@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 06, 2015 at 10:39:51PM -0500, Sinan Kaya wrote:
> On 11/6/2015 7:11 PM, Bjorn Helgaas wrote:
> >That should definitely be fixed.  Do we enable ECRC unconditionally,
> >or only when we boot with "pci=ecrc=on"?  The doc
> >(Documentation/kernel-parameters.txt) suggests the latter.
> >
> >It would be ideal if we could try to turn on ECRC all the time by
> >default for paths that support it.  I suppose there's some risk that
> >we'd trip over broken hardware.  If that's an issue, we could consider
> >turning it on all the time on machines newer than X (that's easy on
> >x86, where we have a DMI BIOS date, but maybe not so easy on other
> >arches).
> 
> ecrc=on kernel option works like "force on" rather than just a simple on.

What do you mean by "force on" as opposed to "simple on"?

> I agree we should enable it by default.

Part of the consideration is that enabling ECRC generation does
increase the size of every TLP by 4 bytes, which reduces the link
throughput slightly, so I'm not sure we want to blindly enable it.

If I understand the current Linux code correctly, by default (booting
with no parameter at all, or with "pci=ecrc=bios"), we don't touch
ECRC at all -- we don't even look to see whether it's supported, and
we don't enable or disable anything.

With "pci=ecrc=on", we turn on ECRC generation (if supported) and ECRC
checking (if supported) for every device, including those hot-added
after boot.

I do like the idea of letting platform firmware decide whether ECRC
should be enabled by default, because then we don't have to decide on
a policy in Linux.  Following the lead of the firmware lets OEMs
decide whether ECRC is a feature they want to market and support.

I think the current strategy could be improved for hot-added devices.
In the default ("pci=ecrc=bios") case, we leave them alone, which
means they won't check ECRC because the enable bits will be zero after
power-up.  If the platform firmware enabled ECRC generation in the
upstream Root Port, we're paying the cost of lower throughput without
getting any benefit for it.

It doesn't look like ECRC has any dependencies or ordering
requirements, so we could also consider adding sysfs knobs to
enable/disable ECRC at run-time.  I can imagine systems where we want
ECRC on some paths, e.g., to a disk or network, but not on others,
e.g., to a display.  Sysfs would be a way to allow that, although it
*is* an administrative burden.

Bjorn
