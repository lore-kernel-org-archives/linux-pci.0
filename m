Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:44553 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab3JJP3t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 11:29:49 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so1220028eae.24
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2013 08:29:48 -0700 (PDT)
Date: Thu, 10 Oct 2013 18:29:45 +0300
From: Eli Cohen <eli@dev.mellanox.co.il>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
	linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
	linux-s390@vger.kernel.org, x86@kernel.org,
	linux-ide@vger.kernel.org, iss_storagedev@hp.com,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
	linux-driver@qlogic.com,
	Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
	"VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 50/77] mlx5: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131010152945.GC7299@mtldesk30>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
 <20131003071433.GA7299@mtldesk30>
 <20131003194837.GA27636@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131003194837.GA27636@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 03, 2013 at 09:48:39PM +0200, Alexander Gordeev wrote:
> 
> pci_enable_msix() may fail, but it can not return a positive number.
>

That is true according to the current logic but the comment on top of
pci_enable_msix() still says:
"A return of < 0 indicates a failure.  Or a return of > 0 indicates
that driver request is exceeding the number of irqs or MSI-X vectors
available"

So you're counting on an implementation that may change in the future.
I think leaving the code as it is now is safer.
