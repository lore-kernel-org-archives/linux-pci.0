Return-Path: <SRS0=FVMU=DI=ozlabs.org=michael@kernel.org>
Return-Path: <SRS0=FVMU=DI=ozlabs.org=michael@kernel.org>
In-Reply-To: <20171109140035.64975-2-bryantly@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, helgaas@kernel.org, bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jjalvare@linux.vnet.ibm.com, linux-pci@vger.kernel.org, saeedm@mellanox.com,  alex.williamson@redhat.com, seroyer@linux.vnet.ibm.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, eli@mellanox.com, "Juan J . Alvarez" <jjalvare@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,  bodong@mellanox.com
Subject: Re: [v5,1/3] powerpc/kernel: Separate SR-IOV Calls
Message-Id: <3ywyXX5ZKtz9t6n@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:24 +1100 (AEDT)
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-11-09 at 14:00:33 UTC, "Bryant G. Ly" wrote:
> SR-IOV can now be enabled in PowerNV platforms and Pseries
> platforms. Therefore, the appropriate calls were moved to
> machine dependent code instead of definition at compile time.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/988fc3ba5653278a8c14d6ccf68737

cheers
