Return-Path: <jonathan.derrick@intel.com>
Return-Path: <jonathan.derrick@intel.com>
Date: Wed, 14 Sep 2016 08:48:29 -0600
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [RFC] pci/aer: kmalloc the aer_err_info struct once
Message-ID: <20160914144826.GA8342@localhost.localdomain>
References: <1473186952-8998-1-git-send-email-jonathan.derrick@intel.com>
 <20160913213205.GH4138@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160913213205.GH4138@localhost>
List-ID: <linux-pci.vger.kernel.org>

> I like the idea of this.  The part I *don't* like is using kmalloc()
> in this path.
> 
> We've always done this, and this patch means we would only do it the
> first time for each device, but the struct aer_rpc (which we allocate
> for each device at probe time) is over 900 bytes, while the struct
> aer_err_info is only about 70 bytes.  Why don't we just include
> aer_error_info directly in aer_rpc and allocate the whole shebang once
> at probe time?  I don't really see what we gain by doing the
> allocation in the runtime path.
Sounds good! Will follow up with a patch
