Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27263 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab3DKTRf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Apr 2013 15:17:35 -0400
Date: Thu, 11 Apr 2013 22:17:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Or Gerlitz <ogerlitz@mellanox.com>,
	Ming Lei <ming.lei@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Miller <davem@davemloft.net>,
	Roland Dreier <roland@kernel.org>,
	netdev <netdev@vger.kernel.org>, Yan Burman <yanb@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH repost for-3.9] pci: avoid work_on_cpu for nested SRIOV
 probes
Message-ID: <20130411191717.GB25515@redhat.com>
References: <20130411153030.GA22743@redhat.com>
 <20130411180517.GJ17641@mtj.dyndns.org>
 <20130411185853.GE23301@redhat.com>
 <20130411190408.GM17641@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130411190408.GM17641@mtj.dyndns.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 11, 2013 at 12:04:08PM -0700, Tejun Heo wrote:
> Hey,
> 
> On Thu, Apr 11, 2013 at 09:58:54PM +0300, Michael S. Tsirkin wrote:
> > > Hmm... how about adding a work_on_cpu_nested() which takes @subclass
> > > argument?  Wouldn't that be much cleaner?
> > > 
> > > Thanks.
> > 
> > Is that 3.9 material though?
> 
> Why wouldn't it be?  It's actually safer as it doesn't change any
> logic.  It's just updating lockdep annotation, which is what's needed
> here anyway.
> 
> Thanks.

Hmm no, there's a real deadlock here: you are
trying to flush from work1 from within work2 running
on same workqueue. work2 can't event start running.
The problem is not annotation.

> -- 
> tejun
