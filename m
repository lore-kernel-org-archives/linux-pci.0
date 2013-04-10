Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:57800 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936455Ab3DJUSD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2013 16:18:03 -0400
Received: by mail-pd0-f180.google.com with SMTP id q11so457849pdj.11
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2013 13:18:03 -0700 (PDT)
Date: Wed, 10 Apr 2013 13:18:00 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: FAILED: Patch Upstream: Revert "PCI/ACPI: Request _OSC control
 before scanning PCI root bus"
Message-ID: <20130410201800.GB7125@kroah.com>
References: <20130406030022.8D4132A64@git.kroah.org>
 <20130409220525.GC6877@kroah.com>
 <20130410151133.GA4534@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130410151133.GA4534@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 10, 2013 at 09:11:33AM -0600, Bjorn Helgaas wrote:
> On Tue, Apr 09, 2013 at 03:05:25PM -0700, Greg KH wrote:
> > I tried to apply the patch below to the 3.8-stable tree, but it has
> > conflicts and doesn't apply.  So I tried a straight-revert of
> > 8c33f51df406e1a1f7fa4e9b244845b7ebd61fa6, which did work fine, but I
> > noticed that it really doesn't look anything like the patch below.
> > 
> > Is this patch a "logical" revert, and not a "literal" one?
> > 
> > Anyway, can someone send me a properly backported version so it can be
> > applied to the 3.8-stable tree?
> 
> Here's a literal revert for v3.8.

Thanks, applied.

greg k-h
