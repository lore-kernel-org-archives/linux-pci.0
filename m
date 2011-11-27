Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44607 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751460Ab1K0NjB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2011 08:39:01 -0500
Subject: Re: (repost) vhost tree for linux-next
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-next@vger.kernel.org, sfr@canb.auug.org.au,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org
In-Reply-To: <20111127124816.GA23270@redhat.com>
References: <20111124203843.GC4873@redhat.com>
	 <20111127124816.GA23270@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 Nov 2011 07:38:59 -0600
Message-ID: <1322401139.2992.1.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2011-11-27 at 14:48 +0200, Michael S. Tsirkin wrote:
> I normally merge things through Dave, Rusty, Jesse or Jens,
> not directly to Linus. However, sometimes there's a large change
> (for example, my recent RFC for pci_iomap changes)
> where estimating how it interacts with other platforms and planned
> changes in the next kernel would be beneficial.
> 
> For this purpose, it would be helpful if my tree were added to linux-next.
> The tree is:
> git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> 
> Could you do this please?
> (The current contents of that tree was posted for review/feedback
> for the first time today.   It might make sense to give it a few days
> for any responses ...)

I'm a little confused by your to: field.  This is a linux-arch issue,
isn't it, since it's altering architecture implementations of a PCI
function rather than altering anything in SCSI or net?

James


