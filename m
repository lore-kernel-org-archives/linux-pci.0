Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1723 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbcDZVR3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 17:17:29 -0400
Date: Tue, 26 Apr 2016 21:17:28 +0000
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pcie: Add driver for Downstream Port Containment
Message-ID: <20160426211727.GB24243@localhost.localdomain>
References: <1461703693-29400-1-git-send-email-keith.busch@intel.com>
 <20160426210558.GB17561@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426210558.GB17561@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 26, 2016 at 11:05:58PM +0200, Lukas Wunner wrote:
> You need to amend your patch to fixup get_descriptor_id() in portdrv.h
> as well as dev_set_name() in portdrv_core.c to cope with more than four
> service types, as I've done in this commit:
> 
> https://github.com/l1k/linux/commit/b688d6e4873ab082e5916b1a993bc1d38c6f4178

Thanks for the pointer. I hadn't noticed since it seemed to work as-is,
but I see this could generate duplicate names with the PME service.
 
> You may also want to fixup these small nits in the commit message:

My proof-reading is atrocious. Thanks for the fixes.

Will send a new version.
