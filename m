Return-Path: <SRS0=ILc9=EY=ozlabs.org=michael@kernel.org>
Return-Path: <SRS0=ILc9=EY=ozlabs.org=michael@kernel.org>
In-Reply-To: <20180105164552.36371-2-bryantly@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jjalvare@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org, eli@mellanox.com, saeedm@mellanox.com, alex.williamson@redhat.com, helgaas@kernel.org, seroyer@linux.vnet.ibm.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com
Subject: Re: [v4,1/7] platform/pseries: Update VF config space after EEH
Message-Id: <3zVGND6VBLz9t3v@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:48 +1100 (AEDT)
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-01-05 at 16:45:46 UTC, "Bryant G. Ly" wrote:
> Add EEH platform operations for pseries to update VF
> config space. With this change after EEH, the VF
> will have updated config space for pseries platform.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/64ba3dc7bf7cb0cbc89821db54edfe

cheers
