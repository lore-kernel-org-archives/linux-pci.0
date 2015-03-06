Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from stargate.chelsio.com ([67.207.112.58]:2164 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbbCFHWB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 02:22:01 -0500
Date: Fri, 6 Mar 2015 12:56:25 +0530
From: Hariprasad S <hariprasad@chelsio.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCIE link reset in older kernels < 2.6.33
Message-ID: <20150306072450.GA22416@hariprasad-pc.asicdesigners.com>
References: <26E3F92EC670BD429DB5CB319D773C13C9E62D@nice.asicdesigners.com>
 <1425622481.5200.372.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1425622481.5200.372.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 05, 2015 at 23:14:41 -0700, Alex Williamson wrote:
> On Fri, 2015-03-06 at 05:24 +0000, Hariprasad S wrote:
> > Hi Alex,
> > 
> > I am a newbie to PCIE driver. 
> > How can we achieve PCIE link reset in older kernels?
> > 
> > I do see that in newer kernels we can achieve it by pci_try_reset_slot(). Is there a similar API available for older kernels.
> 
> pci_reset_function() has been around for quite a while, but it has the
> limitation that it will only do a bus reset if there are no other reset
> mechanisms available and the bus only hosts a single device.  Otherwise,
> no, there's no API I'm aware of that would be available on older
> kernels, which is why I created the bus/slot reset interfaces we have
> today on newer kernels.  Thanks,
> 
> Alex
> 
Thanks. Will have a look into it.

Hariprasad
