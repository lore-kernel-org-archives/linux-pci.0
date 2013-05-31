Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:33297 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab3EaIQ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 04:16:28 -0400
Date: Fri, 31 May 2013 17:16:23 +0900
From: Tejun Heo <tj@kernel.org>
To: Shane Huang <shane.huang@amd.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 3/3] i2c-piix4: add AMD CZ SMBus device ID
Message-ID: <20130531081623.GB17241@mtj.dyndns.org>
References: <1369987950-2894-1-git-send-email-shane.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369987950-2894-1-git-send-email-shane.huang@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 04:12:30PM +0800, Shane Huang wrote:
> To add AMD CZ SMBus controller device ID.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>

All three patches look good to me.

 Reviewed-by: Tejun Heo <tj@kernel.org>

Both 2 and 3 are dependent on the first patch, so it probably would be
a good idea to route them together (probably w/ stable cc'd).  Who
wants these?  Bjorn?

Thanks.

-- 
tejun
