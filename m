Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36416 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933796AbbIVQWN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2015 12:22:13 -0400
Received: by igcrk20 with SMTP id rk20so84115133igc.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2015 09:22:12 -0700 (PDT)
Date: Tue, 22 Sep 2015 11:22:08 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jay Cornwall <jay@jcornwall.me>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] Add AtomicOp Requester support
Message-ID: <20150922162208.GU25767@google.com>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
 <20150914195840.GA25767@google.com>
 <96e2c6b2b12b99282c59c97dbb8e5b69@jcornwall.me>
 <20150921224629.GS25767@google.com>
 <99163c8fb92c573ec65219b14cb653ea@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99163c8fb92c573ec65219b14cb653ea@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 21, 2015 at 07:16:08PM -0500, Jay Cornwall wrote:
> On 2015-09-21 17:46, Bjorn Helgaas wrote:
> >On Mon, Sep 21, 2015 at 03:44:59PM -0500, Jay Cornwall wrote:
> >>On 2015-09-14 14:58, Bjorn Helgaas wrote:
> >>
> >>>00:1c.0: PCI bridge to [bus 01-04] Root Port, with AtomicOp Routing
> >>>01:00.0: PCI bridge to [bus 02-04] Upstream Port, with AtomicOp Routing
> >>>02:00.0: PCI bridge to [bus 03] Downstream Port, with AtomicOp Routing
> >>>03:00.0: endpoint AtomicOp Completer Supported
> >>>02:00.1: PCI bridge to [bus 04] Downstream Port, with AtomicOp Routing
> >>>04:00.0: endpoint no AtomicOp Completer support
> >>>
> >>>It's true that we wouldn't want to enable AtomicOp routing to 04:00.0,
> >>>but isn't that what the AtomicOp Egress Blocking bit is for? If we
> >>>set that in 02:00.1, we should be safe in the sense that AtomicOps
> >>>targeting 04:00.0 should cause non-fatal errors.
> >>
> >>If 02:00.1 had egress blocking then, if I understand correctly, a
> >>00:1c.0 -> 04:00.0 AtomicOp request would be blocked.
> >
> >Yes, a 1c.0 -> 04:00.0 AtomicOp request would be blocked, but 04:00.0
> >doesn't support AtomicOps, so we *want* that request to be blocked,
> >don't we?  If 04:00.0 received an AtomicOp, I think it would handle it
> >as a Malformed TLP, which by default is a Fatal Error.
> 
> I think I was confused by your earlier comment:
> 
> >>>I assume the common usage scenario is to enable AtomicOps for
> >>>host-to-device and/or device-to-host transactions, and we can ignore
> >>>device-to-device transactions for now.
> 
> 00:1c.0 -> 04:00.0 would be the host-to-device scenario. It's true
> that 04:00.0 does not support AtomicOp completion in the above
> example. However, enabling AtomicOp requests for 04:00.0 would cause
> egress blocks to be set in the 00:1c.0 -> 03:00.0 path.

In this particular example, enabling AtomicOp requests for 04:00.0
should fail and do nothing, because 04:00.0 doesn't support AtomicOps.

But you're right that if pci_enable_atomic_request() turns on egress
blocking bits, and both 03:00.0 and 04:00.0 support AtomicOps,
enabling AtomicOps for one device would block them for the other.

I'm not sure how we should use egress blocking.  I could imagine
setting egress blocking bits for the whole tree at enumeration-time,
based on analysis of which root ports and functions have "AtomicOp
Complete Supported" bits set.

I could also imagine setting egress blocking bits at the time a driver
calls pci_enable_atomic_request(), but I don't really like the way this
could affect unrelated devices.  For example,

  Case A
    - Enumerate devices, leaving egress blocking bits cleared
    - Send 1c.0 -> 04:00.0 AtomicOp
    - 04:00.0 raises Malformed TLP Fatal Error

  Case B
    - Enumerate devices, leaving egress blocking bits cleared
    - 03:00.0 driver calls pci_enable_atomic_request()
      - Set 02:00.01 egress blocking bit
    - Send 1c.0 -> 04:00.0 AtomicOp
    - 02:00.01 raises AtomicOp Egress Blocked Advisory Non-Fatal Error

It seems wrong that the same action (AtomicOp to 04:00.0) causes
different errors, depending on an unrelated device.

We don't have any guarantee that AtomicOps terminate correctly today,
so maybe we don't need to add one right now.  If we *do* decide to add
one, it seems like it would be better done at enumeration-time.

So I think your v2 patch seems like pretty much what we want, at least
when we want to set up device-to-host AtomicOps: it validates that the
the fabric from device to the root port supports AtomicOp routing,
validates that the root port supports AtomicOp completion, and enables
AtomicOp requests from the function.

The host-to-device case seems a little different, though.  In that
case, I think we need to turn on AtomicOp Requester Enable in the root
port.  I think it'd be nicer if the driver didn't have to look up the
root port device, and there might be other issues, too.  If you don't
have a need for this case yet, maybe we should leave it unsupported
for now.

Bjorn
