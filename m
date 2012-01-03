Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:35877 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516Ab2ACSxN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2012 13:53:13 -0500
Date: Tue, 3 Jan 2012 13:53:05 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org,
	bhelgaas@google.com, gregkh@suse.de, linux-pci@vger.kernel.org
Subject: Re: [PATCH] msi: fix imbalanced refcount of msi irq sysfs objects
Message-ID: <20120103185304.GA25184@hmsreliant.think-freely.org>
References: <1325604594-7184-1-git-send-email-nhorman@tuxdriver.com>
 <20120103.130526.2034128205205666131.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120103.130526.2034128205205666131.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 03, 2012 at 01:05:26PM -0500, David Miller wrote:
> From: Neil Horman <nhorman@tuxdriver.com>
> Date: Tue,  3 Jan 2012 10:29:54 -0500
> 
> > This warning was recently reported to me:
> 
> I've hit this too, see:
> 
> http://marc.info/?l=linux-kernel&m=132458146927890&w=2
> 
> and my analysis at:
> 
> http://marc.info/?l=linux-arch&m=132458391128660&w=2
> 
Yup, your analysis is correct. Regardless of the why behind msi enablement
failing, we need to gate the kobject_del/put in free_msi_irqs on successful
completion of kobject_init_and_add in populate_msi_sysfs.  This patch does that,
using the parent pointer as a flag.

Thanks
Neil

