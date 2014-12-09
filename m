Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:43528 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaLIGnn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Dec 2014 01:43:43 -0500
Received: by mail-wi0-f169.google.com with SMTP id r20so9110303wiv.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2014 22:43:42 -0800 (PST)
From: Eli Cohen <eli@dev.mellanox.co.il>
Date: Tue, 9 Dec 2014 08:43:39 +0200
To: Yuval Mintz <Yuval.Mintz@qlogic.com>
Cc: Eli Cohen <eli@dev.mellanox.co.il>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	linux-pci <linux-pci@vger.kernel.org>,
	netdev <netdev@vger.kernel.org>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
	"yevgenyp@mellanox.com" <yevgenyp@mellanox.com>,
	Donald Dutile <ddutile@redhat.com>
Subject: Re: [PATCH RFC] pci: Control whether VFs are probed on
 pci_enable_sriov
Message-ID: <20141209064339.GA1806@mtldesk30>
References: <1417957693-24979-1-git-send-email-eli@mellanox.com>
 <B5657A6538887040AD3A81F1008BEC63BA6616@avmb3.qlogic.org>
 <20141207184242.GA24790@mtldesk30>
 <B5657A6538887040AD3A81F1008BEC63BA669B@avmb3.qlogic.org>
 <20141208191032.GC24790@mtldesk30>
 <B5657A6538887040AD3A81F1008BEC63BA7746@avmb3.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B5657A6538887040AD3A81F1008BEC63BA7746@avmb3.qlogic.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 08, 2014 at 07:25:24PM +0000, Yuval Mintz wrote:
> 
> >Currently the kerenl will call probe for any device for which there is
> >a supporting driver and I did not want to change that.
> 
> But what's next? How will this feature be activated?
> 
> Adding a parameter to pci_enable_sriov() might give developers the false
> impression they can change behavior by passing `0' to this function; 
> But that shouldn't be the method to control this - we should have uniform 
> control of the feature across different drivers, e.g., by an additional sysfs node.

I was planning on using this on mlx5 SRIOV support which is not
available upstream yet. So this could be a driver developer's decision
how to use this. I think adding another sysfs entry to control this
behavior is unnecessary since the administrator has the freedom to
later do any bidnings he wishes to do.

Keeping things as they are today is not so "nice". I mean, I could
fail probe for VFs to avoid them from being initialized at the
hypervisor but there are other questions: which error should I return
and how can I be sure how the bus driver will refer to such failures.

So, maybe the solution I suggested is not the best one but do we agree
that this needs to be addressed this way or another?
