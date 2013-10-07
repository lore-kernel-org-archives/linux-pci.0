Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f180.google.com ([209.85.213.180]:35200 "EHLO
	mail-ye0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3JGSKs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 14:10:48 -0400
Date: Mon, 7 Oct 2013 14:10:43 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
Message-ID: <20131007181043.GA27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, Oct 02, 2013 at 12:48:21PM +0200, Alexander Gordeev wrote:
> Make pci_msix_table_size() to return a error code if the device
> does not support MSI-X. This update is needed to facilitate a
> forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> 
> Device drivers will use this interface to obtain maximum number
> of MSI-X interrupts the device supports and use that value in
> the following call to pci_enable_msix() interface.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

Hmmm... I probably missed something but why is this necessary?  To
discern between -EINVAL and -ENOSPC?  If so, does that really matter?

Thanks.

-- 
tejun
