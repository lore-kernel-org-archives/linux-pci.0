Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47786 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756053AbbCFGOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Mar 2015 01:14:46 -0500
Message-ID: <1425622481.5200.372.camel@redhat.com>
Subject: Re: PCIE link reset in older kernels < 2.6.33
From: Alex Williamson <alex.williamson@redhat.com>
To: Hariprasad S <hariprasad@chelsio.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 05 Mar 2015 23:14:41 -0700
In-Reply-To: <26E3F92EC670BD429DB5CB319D773C13C9E62D@nice.asicdesigners.com>
References: <26E3F92EC670BD429DB5CB319D773C13C9E62D@nice.asicdesigners.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2015-03-06 at 05:24 +0000, Hariprasad S wrote:
> Hi Alex,
> 
> I am a newbie to PCIE driver. 
> How can we achieve PCIE link reset in older kernels?
> 
> I do see that in newer kernels we can achieve it by pci_try_reset_slot(). Is there a similar API available for older kernels.

pci_reset_function() has been around for quite a while, but it has the
limitation that it will only do a bus reset if there are no other reset
mechanisms available and the bus only hosts a single device.  Otherwise,
no, there's no API I'm aware of that would be available on older
kernels, which is why I created the bus/slot reset interfaces we have
today on newer kernels.  Thanks,

Alex

