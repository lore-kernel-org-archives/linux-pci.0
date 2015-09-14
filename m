Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43495 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952AbbINIIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Sep 2015 04:08:10 -0400
Subject: Re: [Bugfix 1/3] eata: Use IDA to manage eata board IDs
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>,
	Dario Ballabio <ballabio_dario@emc.com>,
	"James E.J. Bottomley" <JBottomley@odin.com>
References: <CAErSpo4oignSpK-LCLO=deW_FZ-V58GUhBxJ5uvmXe4DYo4WdA@mail.gmail.com>
 <1442200140-30808-1-git-send-email-jiang.liu@linux.intel.com>
 <1442200140-30808-2-git-send-email-jiang.liu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <55F68065.7030608@suse.de>
Date: Mon, 14 Sep 2015 10:08:05 +0200
MIME-Version: 1.0
In-Reply-To: <1442200140-30808-2-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/14/2015 05:08 AM, Jiang Liu wrote:
> Use IDA to manage eata board IDs, so we could dynamically allocate
> and free board IDs later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
