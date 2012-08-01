Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51015 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2HAQyH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 12:54:07 -0400
Date: Wed, 1 Aug 2012 17:54:00 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: matt.fleming@intel.com, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH V2 1/4] EFI: Stash ROMs if they're not in the PCI BAR
Message-ID: <20120801165400.GA3042@srcf.ucam.org>
References: <1343407934-459-1-git-send-email-mjg@redhat.com>
 <20120731223240.GD19134@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120731223240.GD19134@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2012 at 03:32:40PM -0700, Greg KH wrote:

> With this series, does the latest MacBook work properly for the Intel
> graphics driver?  Or is this to resolve some other hardware issue?

Apple only seem to provide the ROM for the radeon. Intel normally 
stands a much better chance of working without a ROM - the only thing it 
really uses it for is the VBT, and I'm thinking about a couple of ways 
of handlng that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
