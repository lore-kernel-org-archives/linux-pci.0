Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 23 May 2016 13:21:44 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
Message-ID: <20160523172144.GD17208@localhost.localdomain>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
 <20160523170652.GA12826@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160523170652.GA12826@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 23, 2016 at 12:06:52PM -0500, Bjorn Helgaas wrote:
> I do not subscribe to the belief that every function should have a
> single exit.  In this case, I think it makes the function much harder
> to understand than this:

No problem with multiple exists. 
 
>   if (numvfs == 0)
>     pci_disable_sriov(pdev);
>     return 0;
>   }
> 
>   return pci_enable_sriov(pdev, numvfs);

Slight change to the above: pci_enable_sriov returns 0 on success,
but a driver's .sriov_configure is supposed to return the number of
VF's successfully configured, so need to return 'numvfs' on success.
