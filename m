Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52024 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940AbcEQRSE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 May 2016 13:18:04 -0400
Date: Tue, 17 May 2016 13:25:02 -0400
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] x86/vmd: Initialize list item in irq disable
Message-ID: <20160517172502.GA19325@localhost.localdomain>
References: <1463505205-30431-1-git-send-email-keith.busch@intel.com>
 <1463505205-30431-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463505205-30431-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 17, 2016 at 11:13:25AM -0600, Keith Busch wrote:
>  	raw_spin_lock(&list_lock);
>  	list_del_rcu(&vmdirq->node);
> +	LIST_HEAD_INIT_RCU(&vmdirq->node);
>  	raw_spin_unlock(&list_lock);

Sorry, please disregard PATCH 2/2. I'll have to resend with the correct
patch using a real macro instead of the mistyped one above.
