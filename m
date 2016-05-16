Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:62433 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbcEPPhN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 May 2016 11:37:13 -0400
Date: Mon, 16 May 2016 11:44:10 -0400
From: Keith Busch <keith.busch@intel.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH] pciutils: Add support for 32-bit PCI domains
Message-ID: <20160516154409.GB10776@localhost.localdomain>
References: <1458242357-28833-1-git-send-email-keith.busch@intel.com>
 <mj+md-20160514.095828.61188.camelot@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <mj+md-20160514.095828.61188.camelot@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 14, 2016 at 11:59:55AM +0200, Martin Mares wrote:
> I have applied the patch and fixed a couple of minor problems. Most
> importantly, the 16-bit domain number was maintained in the sysfs back-end,
> so backward compatibility was not kept on other systems.
> 
> Could you please review the changes in pciutils.git?

Thanks for merging this in. Your changes look good to me, and tests
successfully on the h/w requiring it.

Thanks!
