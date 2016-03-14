Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39036 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbcCNPmT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Mar 2016 11:42:19 -0400
Date: Mon, 14 Mar 2016 10:42:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
Message-ID: <20160314154215.GB13471@localhost>
References: <1457681184-20439-1-git-send-email-jonathan.yong@intel.com>
 <1457681184-20439-2-git-send-email-jonathan.yong@intel.com>
 <20160311155332.GA31716@localhost>
 <56E66BF3.4080500@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E66BF3.4080500@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 14, 2016 at 03:44:51PM +0800, Yong, Jonathan wrote:
> On 03/11/2016 23:53, Bjorn Helgaas wrote:
> 
> >I haven't read the PTM spec yet so I don't know how it works.  But in
> >general, I don't like having to tweak a setting all the way up the
> >hierarchy based on a leaf device.  That makes it hard to handle
> >hotplug correctly, because obviously there may be many leaf devices
> >that share part of all of the upstream path.
> >
> 
> This part in 6.22.3 in the PCIe 3.1 spec:
> 
> Software must not have the PTM Enable bit Set in the PTM Control
> register on a Function associated with an Upstream Port unless the
> associated Downstream Port on the Link already has the PTM Enable
> bit Set in its associated PTM Control register.
> 
> Seems to suggest starting from the leaf device, I'm open to
> suggestions on how to better do this.

The nomenclature is confusing, but I think you're reading this
backwards.  An Upstream Port is on the downstream end of a Link.  The
"Upstream" definition in the PCIe spec "Terms and Acronyms" section
says:

  The Port on a Switch that is closest topologically to the Root Complex
  is the Upstream Port. The Port on a component that contains only
  Endpoint or Bridge Functions is an Upstream Port.

I think the spec is saying that PTM must be enabled in a bridge before
it is enabled in any device downstream from the bridge.

Bjorn
