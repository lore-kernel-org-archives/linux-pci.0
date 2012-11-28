Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58366 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754378Ab2K1TBI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Nov 2012 14:01:08 -0500
Date: Wed, 28 Nov 2012 11:01:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/9] PCI: Remove use of CONFIG_HOTPLUG
Message-ID: <20121128190106.GA30376@kroah.com>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 21, 2012 at 03:34:51PM -0500, Bill Pemberton wrote:
> This is a respin of the patches to remove CONFIG_HOTPLUG for the PCI
> subsystem.  The end result is the same as the patches in the big
> patchset I sent out earlier this week but the changelog entries have
> been changed to be consistent with the capitalization of PCI.  The
> removal of the __dev* entries has also been squashed into a single
> patch.

Bjorn, any objection for me taking these patches through my driver-core
tree?  If not, can I get your ack?

thanks,

greg k-h
