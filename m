Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6420 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757860AbcBXSED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Feb 2016 13:04:03 -0500
Date: Wed, 24 Feb 2016 18:03:55 +0000
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2] VMD: Attach vmd resources to parent domain's
 resource tree
Message-ID: <20160224180354.GA10990@localhost.localdomain>
References: <1456333597-10469-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456333597-10469-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 10:06:37AM -0700, Jon Derrick wrote:
> This patch attaches the new VMD domain's resources to the VMD device's
> resources. This allows /proc/iomem to display a more complete picture.
> 
> Before:
>   c0000000-c1ffffff : 0000:5d:05.5
>   c2000000-c3ffffff : 0000:5d:05.5
>     c2010000-c2013fff : nvme
>   c4000000-c40fffff : 0000:5d:05.5
> 
> After:
>   c0000000-c1ffffff : 0000:5d:05.5
>   c2000000-c3ffffff : 0000:5d:05.5
>     c2000000-c3ffffff : VMD MEMBAR1
>       c2000000-c22fffff : PCI Bus 10000:01
>         c2000000-c200ffff : 10000:01:00.0
>         c2010000-c2013fff : 10000:01:00.0
>           c2010000-c2013fff : nvme
>       c2300000-c24fffff : PCI Bus 10000:01
>   c4000000-c40fffff : 0000:5d:05.5
>     c4002000-c40fffff : VMD MEMBAR2
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
