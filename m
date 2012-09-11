Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:58138 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704Ab2IKDDS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2012 23:03:18 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Mon, 10 Sep 2012 21:03:17 -0600
Date: Tue, 11 Sep 2012 11:03:10 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, VL <vl.homutov@gmail.com>,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Check bridge secondary/subordinate bus register
Message-ID: <20120911030310.GA2424@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347322773-32283-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2012 at 05:19:33PM -0700, Yinghai Lu wrote:
> Intel DP43BF requires "pci=assign-busses" to discover some devices.
> 
> It turns out BIOS set the bridge 00:1e.0 bus register wrong.
> 
> Try to check that wrong range and reject so next pass could only assign
> bus for that bridge.
> 
> 	https://bugzilla.kernel.org/show_bug.cgi?id=18412
> 
> Reported-by: VL <vl.homutov@gmail.com>
> Tested-by: VL <vl.homutov@gmail.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: stable@vger.kernel.org
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3cdba8b..a8f1bf6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -729,7 +729,8 @@ int __devinit pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
> 
>  	/* Check if setup is sensible at all */
>  	if (!pass &&
> -	    (primary != bus->number || secondary <= bus->number)) {
> +	    (primary != bus->number || secondary <= bus->number ||
> +	     secondary > subordinate)) {
>  		dev_dbg(&dev->dev, "bus configuration invalid, reconfiguring\n");
>  		broken = 1;
>  	}

Adding a unlikely() around the condition may help?

RP

