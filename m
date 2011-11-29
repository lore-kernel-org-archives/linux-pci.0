Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:35930 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755750Ab1K2OX4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2011 09:23:56 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4D5112169E
	for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2011 09:23:56 -0500 (EST)
Date: Tue, 29 Nov 2011 23:22:14 +0900
From: Greg KH <greg@kroah.com>
To: Anand Kanaginhal <anand_dk@hotmail.com>
Cc: Linux PCI mailing <linux-pci@vger.kernel.org>,
	linux kernel mailing <linux-kernel@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>
Subject: Re: PCIe Hotplugging not working
Message-ID: <20111129142214.GC14845@kroah.com>
References: <BAY163-W52E309F419E3588206D889FBB30@phx.gbl>
 <BAY163-W47DD39095DA3EB108AA3F2FBB30@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BAY163-W47DD39095DA3EB108AA3F2FBB30@phx.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 29, 2011 at 03:56:12AM -0800, Anand Kanaginhal wrote:
> 
> 
> I am trying to get PCIe endpoint hot - plugging working
> 
> The Set up is such that there is one endpoint (our custom device) connected to PCI  switch PLX 8609 8 port 8 lane switch. 
> 1. I have my driver module compiled, copied into /lib/modules/`uname -r`/kernel/drivers/char/

Why is a pci driver a "char" driver?  Do you have a pointer to the
source of this?

> 2. I run depmod and "modules.pcimap" also got updated with my module. 
> 
> However
>  if I unplug and plug in the endpoint, my driver .probe and .remove functions
>  are not being invoked. Is there something more to be done at the bus 
> level to get the driver to hot plug ?

You need a pci hotplug controller driver, is that loaded?  That is what
is responsible for eventually calling your remove function.

> I have tried various kernel version, Currently I am trying on 2.6.38.12 (UBUNTU flavor).

We can't help you with distro-specific kernels, please use a kernel.org
kernel and we will be glad to help you out.

greg k-h
