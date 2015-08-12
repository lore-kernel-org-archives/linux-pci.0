Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jcornwall.me ([50.116.27.114]:59557 "EHLO jcornwall.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933060AbbHLAkL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 11 Aug 2015 20:40:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 11 Aug 2015 19:39:16 -0500
From: Jay Cornwall <jay@jcornwall.me>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe 3.0 AtomicOp capabilities
In-Reply-To: <CAErSpo6OLAjVde8St2kCoqx3h9hX9ki+X9Ojy0eFqugvBKRrwg@mail.gmail.com>
References: <8c1e7f957cc5a6f0404b883c864b5145@jcornwall.me>
 <CAErSpo6OLAjVde8St2kCoqx3h9hX9ki+X9Ojy0eFqugvBKRrwg@mail.gmail.com>
Message-ID: <841e1480e445f3bcde269a147a269a92@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015-08-11 10:10, Bjorn Helgaas wrote:

> On Mon, Aug 10, 2015 at 1:36 PM, Jay Cornwall <jay@jcornwall.me> wrote:
> 
>> Should the AtomicOp capabilities be similarly enabled if available? Or 
>> might
>> there be a reason for doing this on a per-driver basis?
> 
> I'm not very familiar with the AtomicOp functionality, but a quick
> skim of the spec suggests that it does have system implications and
> should be handled by the core. For example, AtomicOp support is
> optional, and it looks like it would be a bad idea to enable it in an
> endpoint if the upstream switch didn't support it.

This makes sense, but I think there are some cases in which upstream is 
ambiguous.

For example, consider a root complex which does not support AtomicOp 
completion but supports routing to another endpoint which does. Would 
the necessary condition for enabling AtomicOp requests be that at least 
one other completion-capable endpoint is reachable?

-- 
Jay Cornwall
