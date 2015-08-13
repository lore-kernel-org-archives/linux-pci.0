Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34573 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495AbbHMUk1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2015 16:40:27 -0400
Received: by wicne3 with SMTP id ne3so272351228wic.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2015 13:40:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <841e1480e445f3bcde269a147a269a92@jcornwall.me>
References: <8c1e7f957cc5a6f0404b883c864b5145@jcornwall.me>
 <CAErSpo6OLAjVde8St2kCoqx3h9hX9ki+X9Ojy0eFqugvBKRrwg@mail.gmail.com> <841e1480e445f3bcde269a147a269a92@jcornwall.me>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Aug 2015 15:40:07 -0500
Message-ID: <CAErSpo7p1aX0z41H2Js=qdDSGq9gw-w3Y5-fs=h4H8wiYyDCVA@mail.gmail.com>
Subject: Re: PCIe 3.0 AtomicOp capabilities
To: Jay Cornwall <jay@jcornwall.me>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 11, 2015 at 7:39 PM, Jay Cornwall <jay@jcornwall.me> wrote:
> On 2015-08-11 10:10, Bjorn Helgaas wrote:
>
>> On Mon, Aug 10, 2015 at 1:36 PM, Jay Cornwall <jay@jcornwall.me> wrote:
>>
>>> Should the AtomicOp capabilities be similarly enabled if available? Or
>>> might
>>> there be a reason for doing this on a per-driver basis?
>>
>>
>> I'm not very familiar with the AtomicOp functionality, but a quick
>> skim of the spec suggests that it does have system implications and
>> should be handled by the core. For example, AtomicOp support is
>> optional, and it looks like it would be a bad idea to enable it in an
>> endpoint if the upstream switch didn't support it.
>
>
> This makes sense, but I think there are some cases in which upstream is
> ambiguous.
>
> For example, consider a root complex which does not support AtomicOp
> completion but supports routing to another endpoint which does. Would the
> necessary condition for enabling AtomicOp requests be that at least one
> other completion-capable endpoint is reachable?

I don't know enough about AtomicOps to get into a discussion about
what the exact conditions for enabling it are.

I thought your original questions were basically (1) should the PCI
core automatically enable AtomicOps? and (2) should drivers contain
code to enable AtomicOps?

I think drivers should *not* contain code to directly enable
AtomicOps, because it looks like doing that safely requires knowledge
about the topology beyond the driver's device.  But I think it *would*
be reasonable a driver to call a PCI interface like
pci_enable_atomic() or something, and the PCI core could figure out
whether it's safe and enable it or fail.

I don't know whether we should try to automatically enable AtomicOps
even without an explicit driver request.  I don't say that to
discourage that approach; I just don't know whether it makes sense or
can be done safely.  I'm certainly open to reviewing patches that
would do that.

Bjorn
