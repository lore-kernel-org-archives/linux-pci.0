Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57242 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcFRSPu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 18 Jun 2016 14:15:50 -0400
Date: Sat, 18 Jun 2016 13:15:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v5] PCI: PTM preliminary implementation
Message-ID: <20160618181546.GC20504@localhost>
References: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com>
 <1462956446-27361-2-git-send-email-jonathan.yong@intel.com>
 <20160613185648.GA6901@localhost>
 <575F5EAC.2030904@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <575F5EAC.2030904@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 14, 2016 at 09:32:28AM +0800, Yong, Jonathan wrote:
> On 06/14/2016 02:56, Bjorn Helgaas wrote:
> >I'm also a little confused about how Root Complex Integrated Endpoints
> >are supposed to use PTM, since they don't have an upstream bridge.
> >Maybe it has to do with an RCRB (Root Complex Register Block, spec
> >r3.1, sec 7.2.3)?  I don't think Linux really has any support for that
> >(yet).
> 
> The spec (7.32.3 PTM Control Register) says:
> 
> For Root Complex Integrated Endpoints, system software must set this
> field to the value reported in the Local Clock Granularity field by
> the associated PTM Time Source.
> 
> I'm not familiar with RC integrated endpoints either. I'm guessing
> whatever device 0, function 0 on the "bus"? Just copy the
> granularity value over?

I don't know what the answer is, but I don't think device 0, function
0 is it.  There's no reason to expect that to be related to an
integrated endpoint.

I suspect it has to do with the RCRB, but I haven't had a chance to
work through that yet.  For now, I just made it use zero (unknown)
for the effective granularity of integrated endpoints.

Bjorn
