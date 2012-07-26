Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55591 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545Ab2GZRJ1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2012 13:09:27 -0400
Date: Thu, 26 Jul 2012 10:09:25 -0700
From: Greg KH <greg@kroah.com>
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org
Subject: Re: Cabled PCIE device hotplug/hot-removal
Message-ID: <20120726170925.GA24751@kroah.com>
References: <CAHzK-V0XpkVJHgqWiWpYP1jx5DPX=voE0eymK+5FG-zhrJOwAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHzK-V0XpkVJHgqWiWpYP1jx5DPX=voE0eymK+5FG-zhrJOwAQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2012 at 08:03:09PM +0300, Shlomo Pongratz wrote:
> Hi,
> 
> I have a  PCIe device connected with cables to a host (kernel 3.5.0-rc7+).
> What are the handler I need to add to a driver in order to catch cable
> pull-out / push-in?

You shouldn't need anything special, aren't you already getting probe
and disconnect callbacks when the device is discovered and removed?

> The pcisig presentation
> "http://www.pcisig.com/developers/main/training_materials/get_document?doc_id=f4ca40ec1721aa7fadd05e2903b0172c36656294"
> talks about PERST# detection for cabled PCIe hotplug.
> 
> Does the kernel detect it?
> 
> None of the pci_driver or pci_error_handlers callbacks were called
> when using powered down/up the device (electrically).

Do you have the pciehp driver loaded properly when this happens?

thanks,

greg k-h
