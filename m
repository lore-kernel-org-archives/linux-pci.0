Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Tue, 6 Sep 2016 17:18:34 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, Wei Zhang <wzhang@fb.com>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 3/3] pcie/aer: Cache capability position
Message-ID: <20160906211833.GA26153@localhost.localdomain>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <1470683667-28418-4-git-send-email-keith.busch@intel.com>
 <20160809173350.GE27301@localhost>
 <20160906210521.GA14521@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160906210521.GA14521@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 03:05:21PM -0600, Jon Derrick wrote:
> Hi Keith, I like really this patch and am looking forward to v2. Should aer_root_reset and aer_error_resume be changed as well?
> 
> Also is there any reason the same couldn't be done for any pci_dev? I'd like to have this optimization available for is_error_source(). 

Yeah, I think this can go in pci_dev like all the other cached
capabilities. I'll send out v2 of the series today.
