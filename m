Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:44855 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbEDBbQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 May 2015 21:31:16 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 4 May 2015 11:31:14 +1000
Date: Mon, 4 May 2015 11:30:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rob Herring <robherring2@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 19/21] drivers/of: Support adding sub-tree
Message-ID: <20150504013012.GA15561@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAL_JsqKEUevxSe0Q=pGdsWOiT+TW9iAnCsAWuuqOYj3ZPOG7dg@mail.gmail.com>
 <1430493730.7979.58.camel@kernel.crashing.org>
 <CAL_JsqLrBSB4y_0j+i=kXbDA08HO23JuYjJGHR9nhsPnMC_Zyg@mail.gmail.com>
 <1430521038.7979.70.camel@kernel.crashing.org>
 <1430522976.7979.78.camel@kernel.crashing.org>
 <1430534906.7979.85.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430534906.7979.85.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 02, 2015 at 12:48:26PM +1000, Benjamin Herrenschmidt wrote:
>On Sat, 2015-05-02 at 09:29 +1000, Benjamin Herrenschmidt wrote:
>
>> Looking a bit more at it, I don't quite see how I can attach a subtree
>> using that stuff.
>> 
>> Instead, each node in the overlay seems to need extra nodes and
>> properties to refer to the original.
>> 
>> So the FW would essentially have to create something a lot more complex
>> than just reflattening a bit of its internal tree. For each internal
>> node, it will need to add all those __overlay__ nodes and properties.
>> 
>> That is not going to fly for me at all. It's order of magnitudes more
>> complex than the solution we are pursuing.
>> 
>> So I think for our use case, we should continue in the direction of
>> having a helper to unflatten a piece of FDT underneath an existing
>> node. I don't like the "HYBRID" stuff though, we should not refer to
>> the original FDT, we should just make them normal dynamic nodes.

Just took a close look on the overlay code. Hopefully I understand
how it works completely. Yeah, there is one questions according to my
understanding. The "overlay" device node should have been in child list
of the device node, who also has the indicator to "target" node. That
means some one else has to create "overlay" node and figure out the
"target" node in advance, then invokes overlay module to apply the
changes. From this perspective, the mechanism is something used to
apply the changes to device-tree, not parsing and create device nodes
from input. It does gurantee all the changes will be applied or none
of them. So I agree on what Ben suggested: to continue the direction
of having a helper to unflatten FDT blobk underneath the existing node,
and "HYBRID" should be replaced with "OF_DYNAMIC".

>
>A bit more thought... if we were to use the overlay stuff, Gavin, what
>we *could* do is add to OPAL FW internal representation a generation
>count to every node and property.
>
>That way we could essentially know whenever something's changed from
>what we flattened originally for the kernel.
>
>We can then create a generic (not PCI specific) call that generates
>an overlay tree for every node and property that has a generation
>count that is newer than what was flattened (or passed by the OS).
>
>It's still a LOT more complex than what we need though...
>

Thanks, Ben. If we really need utilize overlay to support our case,
we need some one to parse the input (device-tree changes) from firmware
and create "overlay" device node and "target" node as I mentioned above.
It's not simpler than the way we had to support our case. I'm not sure
if we really need utilize overlay for our case.

Thanks,
Gavin

