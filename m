Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4518 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcDZVG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 17:06:56 -0400
Date: Tue, 26 Apr 2016 21:06:42 +0000
From: Keith Busch <keith.busch@intel.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Add support for Downstream Port Containment
Message-ID: <20160426210641.GA24243@localhost.localdomain>
References: <1461703673-29363-1-git-send-email-keith.busch@intel.com>
 <mj+md-20160426.204835.23574.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20160426.204835.23574.nikam@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 26, 2016 at 10:49:01PM +0200, Martin Mares wrote:
> > The PCI SIG added the Downstream Port Containment capability. This patch
> > decodes this for lspci and defines the extended capability for setpci.
> 
> Yes, that looks good.
> 
> Could you please add a test case to tests/ ?

Thanks for the quick reply!

I'll confirm with the vendor that they're okay with me adding their switch
to the test cases (I don't know if they've released this product yet).
