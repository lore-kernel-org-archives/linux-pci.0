Return-Path: <SRS0=ILc9=EY=ozlabs.org=michael@kernel.org>
Return-Path: <SRS0=ILc9=EY=ozlabs.org=michael@kernel.org>
In-Reply-To: <20180105164552.36371-8-bryantly@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jjalvare@linux.vnet.ibm.com, aik@ozlabs.ru, linux-pci@vger.kernel.org, eli@mellanox.com, saeedm@mellanox.com, alex.williamson@redhat.com, helgaas@kernel.org, seroyer@linux.vnet.ibm.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com
Subject: Re: [v4,7/7] pseries/setup: Add Initialization of VF Bars
Message-Id: <3zVGND3MxBz9t20@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:48 +1100 (AEDT)
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-01-05 at 16:45:52 UTC, "Bryant G. Ly" wrote:
> When enabling SR-IOV in pseries platform,
> the VF bar properties for a PF are reported on
> the device node in the device tree.
> 
> This patch adds the IOV Bar resources to Linux
> structures from the device tree for later use
> when configuring SR-IOV by PF driver.
> 
> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fc5f622163637308a3d520a3155274

cheers
