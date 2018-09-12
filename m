Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new
 __pci_reset_function_locked() API with reset type
To: Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20180905160805.5680-1-okaya@kernel.org>
 <20180905160805.5680-3-okaya@kernel.org>
 <20180912010929.GA118330@bhelgaas-glaptop.roam.corp.google.com>
 <c0f524c3-5b3f-f796-6a6b-3040db4462a3@kernel.org>
 <20180912015927.GB118330@bhelgaas-glaptop.roam.corp.google.com>
 <20180911203440.5779363b@t450s.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <0a958b77-f044-9222-95b4-86d5728e083e@kernel.org>
Date: Tue, 11 Sep 2018 22:47:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180911203440.5779363b@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/11/2018 10:34 PM, Alex Williamson wrote:
> For rc, I'd certainly agree that a simple revert might be a better
> option and this API can play out for v4.20, but I definitely want to
> get back an API that allows vfio to specify the bus reset type before
> implementations diverge.  Thanks,

I posted these per Alex's feedback:

https://patchwork.ozlabs.org/patch/967557/
https://patchwork.ozlabs.org/patch/967558/
https://patchwork.ozlabs.org/patch/967559/
https://patchwork.ozlabs.org/patch/967560/

Please feel free to comment on them targeting v4.20.
