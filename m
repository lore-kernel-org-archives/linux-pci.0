Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jcornwall.me ([50.116.27.114]:39304 "EHLO jcornwall.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbbIVASw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Sep 2015 20:18:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 21 Sep 2015 19:16:08 -0500
From: Jay Cornwall <jay@jcornwall.me>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] Add AtomicOp Requester support
In-Reply-To: <20150921224629.GS25767@google.com>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
 <20150914195840.GA25767@google.com>
 <96e2c6b2b12b99282c59c97dbb8e5b69@jcornwall.me>
 <20150921224629.GS25767@google.com>
Message-ID: <99163c8fb92c573ec65219b14cb653ea@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015-09-21 17:46, Bjorn Helgaas wrote:
> On Mon, Sep 21, 2015 at 03:44:59PM -0500, Jay Cornwall wrote:
>> On 2015-09-14 14:58, Bjorn Helgaas wrote:
>> 
>> >00:1c.0: PCI bridge to [bus 01-04] Root Port, with AtomicOp Routing
>> >01:00.0: PCI bridge to [bus 02-04] Upstream Port, with AtomicOp Routing
>> >02:00.0: PCI bridge to [bus 03] Downstream Port, with AtomicOp Routing
>> >03:00.0: endpoint AtomicOp Completer Supported
>> >02:00.1: PCI bridge to [bus 04] Downstream Port, with AtomicOp Routing
>> >04:00.0: endpoint no AtomicOp Completer support
>> >
>> >It's true that we wouldn't want to enable AtomicOp routing to 04:00.0,
>> >but isn't that what the AtomicOp Egress Blocking bit is for? If we
>> >set that in 02:00.1, we should be safe in the sense that AtomicOps
>> >targeting 04:00.0 should cause non-fatal errors.
>> 
>> If 02:00.1 had egress blocking then, if I understand correctly, a
>> 00:1c.0 -> 04:00.0 AtomicOp request would be blocked.
> 
> Yes, a 1c.0 -> 04:00.0 AtomicOp request would be blocked, but 04:00.0
> doesn't support AtomicOps, so we *want* that request to be blocked,
> don't we?  If 04:00.0 received an AtomicOp, I think it would handle it
> as a Malformed TLP, which by default is a Fatal Error.

I think I was confused by your earlier comment:

>> >I assume the common usage scenario is to enable AtomicOps for
>> >host-to-device and/or device-to-host transactions, and we can ignore
>> >device-to-device transactions for now.

00:1c.0 -> 04:00.0 would be the host-to-device scenario. It's true that 
04:00.0 does not support AtomicOp completion in the above example. 
However, enabling AtomicOp requests for 04:00.0 would cause egress 
blocks to be set in the 00:1c.0 -> 03:00.0 path.

Our immediate use case for AtomicOps is indeed device-to-host, and I 
expect this is the most common case. I can make a V3 patch which 
explicitly supports this case only by setting egress blocks on 
downstream ports of upstream bridges.

This would guarantee that AtomicOp requests terminate correctly, at the 
expense of potential users of host-to-device or device-to-device 
scenarios.

-- 
Jay Cornwall
