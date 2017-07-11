Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756538AbdGKTCB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jul 2017 15:02:01 -0400
MIME-Version: 1.0
In-Reply-To: <20170710174343.GA136482@google.com>
References: <20170707004323.22550-1-briannorris@chromium.org>
 <20170710143313.xfa7ezbgj67clkt3@rob-hp-laptop> <20170710174343.GA136482@google.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Jul 2017 14:01:38 -0500
Message-ID: <CAL_Jsq+1NuBedduhO=RqAo9Jq4mzQXudKgTn8L+kk_=q5vpCRg@mail.gmail.com>
Subject: Re: [PATCH] Documentation/devicetree: fix dead links to PCI/OF specs
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 12:43 PM, Brian Norris <briannorris@chromium.org> wrote:
> On Mon, Jul 10, 2017 at 09:33:13AM -0500, Rob Herring wrote:
>> On Thu, Jul 06, 2017 at 05:43:23PM -0700, Brian Norris wrote:
>> > www.firmware.org doesn't resolve for me. I found these equivalent URLs
>> > by taking the redirects from the previous (openfirmware.org) URLs, as
>> > seen before commit f517256a6867 ("Documentation/devicetree: Update PCI
>> > Device Tree bindings") updated them.
>> >
>> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>> > ---
>> > This is my best attempt at a resolution. I'm not sure what firmware.org is or
>> > if its owner is even legit. It does seem like openfirmware.info is a proper
>> > successor to openfirmware.org, and it's registered to a coreboot dev.
>>
>> This site doesn't seem to be complete. There was still a complete mirror
>> (matching playground.sun.com) at one point, but I can't seem to find it
>> now. Fortunately, I had archived off the whole mirror with the intention
>> of putting it on devicetree.org. Let me get moving on that.
>
> I don't really know what "complete" is; I just want my URLs to point
> somewhere useful :) So whatever suits you best. At least these links
> correctly have titles / reference numbers included alongside, so I can
> search for the correct thing myself.

Here's what it looks like:

http://people.linaro.org/~rob.herring/openfirmware/1275/

There's a bunch of really ancient stuff that we don't care about with
FDT and non-PC style systems.

> BTW, I think I missed some other bad links in the tree. v4.12 release
> still points to these:
>
> origin/master:Documentation/devicetree/bindings/usb/usb-device.txt:5:http://www.firmware.org/1275/bindings/usb/usb-1_0.ps

This should be in the above.

> origin/master:Documentation/devicetree/booting-without-of.txt:1285:<http://www.openfirmware.org/ofwg/practice/>

That should be this I think:

http://people.linaro.org/~rob.herring/openfirmware/1275/practice/

But don't send me patches with the above urls.

Rob
