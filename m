Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jcornwall.me ([50.116.27.114]:47663 "EHLO jcornwall.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbbIWQrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 12:47:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 23 Sep 2015 11:44:33 -0500
From: Jay Cornwall <jay@jcornwall.me>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] Add AtomicOp Requester support
In-Reply-To: <20150922162208.GU25767@google.com>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
 <20150914195840.GA25767@google.com>
 <96e2c6b2b12b99282c59c97dbb8e5b69@jcornwall.me>
 <20150921224629.GS25767@google.com>
 <99163c8fb92c573ec65219b14cb653ea@jcornwall.me>
 <20150922162208.GU25767@google.com>
Message-ID: <e7d98a4a66ba25e006b607b7dad19853@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015-09-22 11:22, Bjorn Helgaas wrote:
> On Mon, Sep 21, 2015 at 07:16:08PM -0500, Jay Cornwall wrote:
>> On 2015-09-21 17:46, Bjorn Helgaas wrote:
>> >On Mon, Sep 21, 2015 at 03:44:59PM -0500, Jay Cornwall wrote:
>> >>On 2015-09-14 14:58, Bjorn Helgaas wrote:
>> >>
>> >>>00:1c.0: PCI bridge to [bus 01-04] Root Port, with AtomicOp Routing
>> >>>01:00.0: PCI bridge to [bus 02-04] Upstream Port, with AtomicOp Routing
>> >>>02:00.0: PCI bridge to [bus 03] Downstream Port, with AtomicOp Routing
>> >>>03:00.0: endpoint AtomicOp Completer Supported
>> >>>02:00.1: PCI bridge to [bus 04] Downstream Port, with AtomicOp Routing
>> >>>04:00.0: endpoint no AtomicOp Completer support
>> >>>
>> I think I was confused by your earlier comment:
>> 
>> >>>I assume the common usage scenario is to enable AtomicOps for
>> >>>host-to-device and/or device-to-host transactions, and we can ignore
>> >>>device-to-device transactions for now.
>> 
>> 00:1c.0 -> 04:00.0 would be the host-to-device scenario. It's true
>> that 04:00.0 does not support AtomicOp completion in the above
>> example. However, enabling AtomicOp requests for 04:00.0 would cause
>> egress blocks to be set in the 00:1c.0 -> 03:00.0 path.
> 
> In this particular example, enabling AtomicOp requests for 04:00.0
> should fail and do nothing, because 04:00.0 doesn't support AtomicOps.
> 
> But you're right that if pci_enable_atomic_request() turns on egress
> blocking bits, and both 03:00.0 and 04:00.0 support AtomicOps,
> enabling AtomicOps for one device would block them for the other.
> 
> I'm not sure how we should use egress blocking.  I could imagine
> setting egress blocking bits for the whole tree at enumeration-time,
> based on analysis of which root ports and functions have "AtomicOp
> Complete Supported" bits set.

I think this was my central concern. If we were to do this analysis at 
enumeration-time then a similar argument might be put forward for 
setting AtomicOp Requester Enable here as well. This would make 
pci_enable_atomic_request redundant.

Thinking more, though, this case is different because AtomicOp Requester 
capability cannot be detected. Having a per-device call for drivers with 
knowledge of this capability would seem reasonable. The alternative 
would be to set DEVCTL2.ATOMICOP_REQUESTER_ENABLE for all devices at 
enumeration time.

> We don't have any guarantee that AtomicOps terminate correctly today,
> so maybe we don't need to add one right now.  If we *do* decide to add
> one, it seems like it would be better done at enumeration-time.
> 
> So I think your v2 patch seems like pretty much what we want, at least
> when we want to set up device-to-host AtomicOps: it validates that the
> the fabric from device to the root port supports AtomicOp routing,
> validates that the root port supports AtomicOp completion, and enables
> AtomicOp requests from the function.
> 
> The host-to-device case seems a little different, though.  In that
> case, I think we need to turn on AtomicOp Requester Enable in the root
> port.  I think it'd be nicer if the driver didn't have to look up the
> root port device, and there might be other issues, too.  If you don't
> have a need for this case yet, maybe we should leave it unsupported
> for now.

Yes, that case is somewhat awkward.

Our (AMD's) use case is to allow the CPU and GPU to synchronize access 
to shared data structures, in a uniform way with our integrated parts. 
These are located in system memory (so, device->host atomics). I can't 
think of a good reason to reverse this scenario. (Our GPUs don't support 
AtomicOp Completion in any case.)

I'll address your comments and submit a V3 with no design changes.

-- 
Jay Cornwall
