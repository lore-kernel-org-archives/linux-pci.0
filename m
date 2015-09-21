Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35543 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbbIUWqe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 18:46:34 -0400
Received: by igbkq10 with SMTP id kq10so70645135igb.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2015 15:46:33 -0700 (PDT)
Date: Mon, 21 Sep 2015 17:46:29 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jay Cornwall <jay@jcornwall.me>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] Add AtomicOp Requester support
Message-ID: <20150921224629.GS25767@google.com>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
 <20150914195840.GA25767@google.com>
 <96e2c6b2b12b99282c59c97dbb8e5b69@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <96e2c6b2b12b99282c59c97dbb8e5b69@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 21, 2015 at 03:44:59PM -0500, Jay Cornwall wrote:
> On 2015-09-14 14:58, Bjorn Helgaas wrote:
> 
> >On Wed, Aug 19, 2015 at 04:10:01PM -0500, Jay Cornwall wrote:
> 
> >>Approach 2 could only establish that there is a path to at least
> >>one completer,
> >>but it would not prevent requests being sent to a different
> >>device which does
> >>not support AtomicOp completion. For example, a root complex
> >>might support
> >>completion but a transaction could be sent to a different device
> >>which does
> >>not. The routable guarantee is not precise and so less useful.
> 
> >I assume the common usage scenario is to enable AtomicOps for
> >host-to-device and/or device-to-host transactions, and we can ignore
> >device-to-device transactions for now.
> >
> >If I understand correctly, AtomicOps must be supported by all devices
> >along the path, e.g., a Root Port, possibly some Switch Ports, and
> >finally an Endpoint. I guess your worry with Approach 2 is for a
> >scenario like this:
> >
> >00:1c.0: PCI bridge to [bus 01-04] Root Port, with AtomicOp Routing
> >01:00.0: PCI bridge to [bus 02-04] Upstream Port, with AtomicOp Routing
> >02:00.0: PCI bridge to [bus 03] Downstream Port, with AtomicOp Routing
> >03:00.0: endpoint AtomicOp Completer Supported
> >02:00.1: PCI bridge to [bus 04] Downstream Port, with AtomicOp Routing
> >04:00.0: endpoint no AtomicOp Completer support
> >
> >It's true that we wouldn't want to enable AtomicOp routing to 04:00.0,
> >but isn't that what the AtomicOp Egress Blocking bit is for? If we
> >set that in 02:00.1, we should be safe in the sense that AtomicOps
> >targeting 04:00.0 should cause non-fatal errors.
> 
> If 02:00.1 had egress blocking then, if I understand correctly, a
> 00:1c.0 -> 04:00.0 AtomicOp request would be blocked.

Yes, a 1c.0 -> 04:00.0 AtomicOp request would be blocked, but 04:00.0
doesn't support AtomicOps, so we *want* that request to be blocked,
don't we?  If 04:00.0 received an AtomicOp, I think it would handle it
as a Malformed TLP, which by default is a Fatal Error.

If we set AtomicOpEgress Blocking in 02:00.1 and attempt a 1c.0 ->
04:00.0 AtomicOp request, my reading is that 02:00.1 should report an
AtomicOp Egress Blocked error, which by default is an Advisory
Non-Fatal Error, and 04:00.0 should never receive the AtomicOp.

This is from the second-to-last paragraph of PCIe spec r3.0, sec 6.15.

Even if we set AtomicOpEgress Blocking in 02:00.1, an AtomicOp to
03:00.0 should work, because that would be routed via 02:00.0, not
02:00.1.

Bjorn
