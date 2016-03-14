Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:41584 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933535AbcCNHoy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Mar 2016 03:44:54 -0400
Message-ID: <56E66BF3.4080500@intel.com>
Date: Mon, 14 Mar 2016 15:44:51 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	"Yong, Jonathan" <jonathan.yong@intel.com>
Subject: Re: [PATCH] PCI: PTM preliminary implementation
References: <1457681184-20439-1-git-send-email-jonathan.yong@intel.com> <1457681184-20439-2-git-send-email-jonathan.yong@intel.com> <20160311155332.GA31716@localhost>
In-Reply-To: <20160311155332.GA31716@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/11/2016 23:53, Bjorn Helgaas wrote:

> I haven't read the PTM spec yet so I don't know how it works.  But in
> general, I don't like having to tweak a setting all the way up the
> hierarchy based on a leaf device.  That makes it hard to handle
> hotplug correctly, because obviously there may be many leaf devices
> that share part of all of the upstream path.
>

This part in 6.22.3 in the PCIe 3.1 spec:

Software must not have the PTM Enable bit Set in the PTM Control 
register on a Function associated with an Upstream Port unless the 
associated Downstream Port on the Link already has the PTM Enable bit 
Set in its associated PTM Control register.

Seems to suggest starting from the leaf device, I'm open to suggestions 
on how to better do this.

