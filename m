Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 10 Jul 2017 10:43:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] Documentation/devicetree: fix dead links to PCI/OF specs
Message-ID: <20170710174343.GA136482@google.com>
References: <20170707004323.22550-1-briannorris@chromium.org>
 <20170710143313.xfa7ezbgj67clkt3@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710143313.xfa7ezbgj67clkt3@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 09:33:13AM -0500, Rob Herring wrote:
> On Thu, Jul 06, 2017 at 05:43:23PM -0700, Brian Norris wrote:
> > www.firmware.org doesn't resolve for me. I found these equivalent URLs
> > by taking the redirects from the previous (openfirmware.org) URLs, as
> > seen before commit f517256a6867 ("Documentation/devicetree: Update PCI
> > Device Tree bindings") updated them.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > This is my best attempt at a resolution. I'm not sure what firmware.org is or
> > if its owner is even legit. It does seem like openfirmware.info is a proper
> > successor to openfirmware.org, and it's registered to a coreboot dev.
> 
> This site doesn't seem to be complete. There was still a complete mirror 
> (matching playground.sun.com) at one point, but I can't seem to find it 
> now. Fortunately, I had archived off the whole mirror with the intention 
> of putting it on devicetree.org. Let me get moving on that.

I don't really know what "complete" is; I just want my URLs to point
somewhere useful :) So whatever suits you best. At least these links
correctly have titles / reference numbers included alongside, so I can
search for the correct thing myself.

BTW, I think I missed some other bad links in the tree. v4.12 release
still points to these:

origin/master:Documentation/devicetree/bindings/usb/usb-device.txt:5:http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
origin/master:Documentation/devicetree/booting-without-of.txt:1285:<http://www.openfirmware.org/ofwg/practice/>

Regards,
Brian
