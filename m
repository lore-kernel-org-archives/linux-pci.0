Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new
 __pci_reset_function_locked() API with reset type
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180905160805.5680-1-okaya@kernel.org>
 <20180905160805.5680-3-okaya@kernel.org>
 <20180912010929.GA118330@bhelgaas-glaptop.roam.corp.google.com>
 <c0f524c3-5b3f-f796-6a6b-3040db4462a3@kernel.org>
 <20180912015927.GB118330@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <9755ad74-a421-f51c-abd0-9e5bc2af2582@kernel.org>
Date: Tue, 11 Sep 2018 22:05:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180912015927.GB118330@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/11/2018 9:59 PM, Bjorn Helgaas wrote:
> Can we just move the pci_bridge_secondary_bus_reset() decl back to
> include/linux/pci.h temporarily and have trigger_sbr() call that
> again?  I'd rather do that than try to squeeze some API rework into an
> -rc.
yes, that was the initial proposal from Dennis. If you prefer to have
a simpler/temporary change instead for the moment, correct patches are:

https://patchwork.kernel.org/patch/10584283/
https://patchwork.kernel.org/patch/10584277/
