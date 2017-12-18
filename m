Return-Path: <SRS0=Eef5=DO=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=Eef5=DO=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v1 7/7] pseries/setup: Add Initialization of VF Bars
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, helgaas@kernel.org,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-8-bryantly@linux.vnet.ibm.com>
 <4ea33f2e-d98c-85ef-eedf-2e8ca49aa839@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:29:54 -0600
MIME-Version: 1.0
In-Reply-To: <4ea33f2e-d98c-85ef-eedf-2e8ca49aa839@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <8bdf7127-a3ec-1c75-2593-e39a8bd31e34@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

This is PF only path. Yes either we have a root returned otherwise
will fall back to iomem_resource.


On 12/18/17 1:21 AM, Alexey Kardashevskiy wrote:
> @dev here is a VF, right? I am not familiar with powervn much but from what
> I see - the devices are sitting on a root bus of their own PHB and they all
> either have a root returned from pci_find_parent_resource() or none of them
> has a root and will fall back to &iomem_resource, or both cases are possible?
