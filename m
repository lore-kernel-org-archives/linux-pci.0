Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEVwv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 17:52:51 -0400
Subject: Re: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new
 __pci_reset_function_locked() API with reset type
To: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20180905160805.5680-1-okaya@kernel.org>
 <20180905160805.5680-3-okaya@kernel.org>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <917432a5-398c-3cd6-fffd-7bdb00a22fdf@intel.com>
Date: Wed, 5 Sep 2018 13:21:40 -0400
MIME-Version: 1.0
In-Reply-To: <20180905160805.5680-3-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/5/2018 12:08 PM, Sinan Kaya wrote:
> pci_reset_bus() is being called from the probe context and causes
> a deadlock since pci_reset_bus() also tries to obtain kernel lock.
> 
> Use __pci_reset_function_locked() that provides locking guarantees.
> 
> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200985
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Tested-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
