Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jcornwall.me ([50.116.27.114]:37756 "EHLO jcornwall.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756623AbbIUUxx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Sep 2015 16:53:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 21 Sep 2015 15:44:59 -0500
From: Jay Cornwall <jay@jcornwall.me>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] Add AtomicOp Requester support
In-Reply-To: <20150914195840.GA25767@google.com>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
 <20150914195840.GA25767@google.com>
Message-ID: <96e2c6b2b12b99282c59c97dbb8e5b69@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015-09-14 14:58, Bjorn Helgaas wrote:

> On Wed, Aug 19, 2015 at 04:10:01PM -0500, Jay Cornwall wrote:

>> Approach 2 could only establish that there is a path to at least one 
>> completer,
>> but it would not prevent requests being sent to a different device 
>> which does
>> not support AtomicOp completion. For example, a root complex might 
>> support
>> completion but a transaction could be sent to a different device which 
>> does
>> not. The routable guarantee is not precise and so less useful.

> I assume the common usage scenario is to enable AtomicOps for
> host-to-device and/or device-to-host transactions, and we can ignore
> device-to-device transactions for now.
> 
> If I understand correctly, AtomicOps must be supported by all devices
> along the path, e.g., a Root Port, possibly some Switch Ports, and
> finally an Endpoint. I guess your worry with Approach 2 is for a
> scenario like this:
> 
> 00:1c.0: PCI bridge to [bus 01-04] Root Port, with AtomicOp Routing
> 01:00.0: PCI bridge to [bus 02-04] Upstream Port, with AtomicOp Routing
> 02:00.0: PCI bridge to [bus 03] Downstream Port, with AtomicOp Routing
> 03:00.0: endpoint AtomicOp Completer Supported
> 02:00.1: PCI bridge to [bus 04] Downstream Port, with AtomicOp Routing
> 04:00.0: endpoint no AtomicOp Completer support
> 
> It's true that we wouldn't want to enable AtomicOp routing to 04:00.0,
> but isn't that what the AtomicOp Egress Blocking bit is for? If we
> set that in 02:00.1, we should be safe in the sense that AtomicOps
> targeting 04:00.0 should cause non-fatal errors.

If 02:00.1 had egress blocking then, if I understand correctly, a 
00:1c.0 -> 04:00.0 AtomicOp request would be blocked. Host-to-device and 
device-to-device look quite similar from this perspective.

> Your pci_enable_atomic_request() enables AtomicOps for one component.
> I assume that means the driver would have to map out the topology,
> figure out whether all the components support AtomicOp routing, and
> call pci_enable_atomic_request() for the Root Port and the Endpoint.
> That seems like a lot of grubbing around for a driver.
> 
> I think a driver should only call pci_enable_atomic_request() for its
> own device, and the PCI core should figure out whether it can be
> enabled, and if it can, do everything needed to enable it.

OK. I've put together a v2 patch which checks the upstream bridges for 
AtomicOp routing and the root port for completion. I've left out egress 
blocking per the above concern.

-- 
Jay Cornwall
