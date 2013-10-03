Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:38126 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724Ab3JCQLG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2013 12:11:06 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so1221548eaj.11
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2013 09:11:04 -0700 (PDT)
Date: Thu, 3 Oct 2013 19:11:00 +0300
From: Jack Morgenstein <jackm@dev.mellanox.co.il>
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
Subject: Re: [PATCH RFC 51/77] mthca: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003191100.3e3e3bfd@jpm-OptiPlex-GX620>
In-Reply-To: <9d424912ef78993dc75e2af5006cd12913e9e7e7.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
	<9d424912ef78993dc75e2af5006cd12913e9e7e7.1380703263.git.agordeev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed,  2 Oct 2013 12:49:07 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> Subject: [PATCH RFC 51/77] mthca: Update MSI/MSI-X interrupts
> enablement code Date: Wed,  2 Oct 2013 12:49:07 +0200
> Sender: linux-rdma-owner@vger.kernel.org
> X-Mailer: git-send-email 1.7.7.6
> 
> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---

ACK.

-Jack
