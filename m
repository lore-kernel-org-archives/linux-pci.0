Return-Path: <SRS0=d5tq=C7=ozlabs.ru=aik@kernel.org>
Return-Path: <SRS0=d5tq=C7=ozlabs.ru=aik@kernel.org>
Subject: Re: [PATCH v5 0/3] Prepartion for SR-IOV PowerVM Enablement
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, helgaas@kernel.org,
 bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <520bad85-e4a5-a8a8-c893-e53e7b46c65c@ozlabs.ru>
Date: Sun, 3 Dec 2017 12:45:58 +1100
MIME-Version: 1.0
In-Reply-To: <20171109140035.64975-1-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 10/11/17 01:00, Bryant G. Ly wrote:
> v1 - Initial patch
> v2 - Addressed Bjorn's comment on creating a highly platform
>      dependent global exported symbol.
> v3 - Based patch off linux-ppc/master
> v4 - Using the sriov-drivers_autoprobe mechanism per Bjorn's request
> v5 - Fixed comments and commit message


What is this made against of? I'd like to give it a try but it does not
apply to Linus'es tree or powerpc/next. Thanks.

> 
> Bryant G. Ly (3):
>   powerpc/kernel: Separate SR-IOV Calls
>   pseries: Add PSeries SR-IOV Machine dependent calls
>   PCI/IOV: Add pci_vf_drivers_autoprobe() interface
> 
>  arch/powerpc/include/asm/machdep.h           |  7 ++++++
>  arch/powerpc/include/asm/pci-bridge.h        |  4 +---
>  arch/powerpc/kernel/eeh_driver.c             |  4 ++--
>  arch/powerpc/kernel/pci-common.c             | 23 +++++++++++++++++++
>  arch/powerpc/kernel/pci_dn.c                 |  6 -----
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 33 ++++++++++++++--------------
>  arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++--
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 24 ++++++++++++++++++++
>  arch/powerpc/platforms/pseries/pci.c         | 31 ++++++++++++++++++++++----
>  drivers/pci/iov.c                            | 11 ++++++++++
>  include/linux/pci.h                          |  2 ++
>  11 files changed, 118 insertions(+), 33 deletions(-)
> 


-- 
Alexey
