Return-Path: <SRS0=qZKk=DR=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=qZKk=DR=linux.vnet.ibm.com=jjalvare@kernel.org>
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
 <8bdf7127-a3ec-1c75-2593-e39a8bd31e34@linux.vnet.ibm.com>
 <fd876ee1-4c12-587b-a8a0-56233fea3401@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 21:04:38 -0600
MIME-Version: 1.0
In-Reply-To: <fd876ee1-4c12-587b-a8a0-56233fea3401@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <a9ef0e7f-c005-f52f-e707-92d9c7ba8d4c@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 12/19/17 12:38 AM, Alexey Kardashevskiy wrote:

> On 19/12/17 06:29, Juan Alvarez wrote:
>> This is PF only path. Yes either we have a root returned otherwise
>> will fall back to iomem_resource.
> You have removed context from my response, do not do that please.

My apologies. I will not do that.

>
> When will you have root and when you won't? imho it should always be either
> one or another.
>
Yes you are correct. The resource is carved out of a different mmio 
space and will never be passed in the assigned-addresses property in 
the device node of PF.

We will remove that function call, conditional check and set root accordingly.

>> On 12/18/17 1:21 AM, Alexey Kardashevskiy wrote:
>>> @dev here is a VF, right? I am not familiar with powervn much but from what
>>> I see - the devices are sitting on a root bus of their own PHB and they all
>>> either have a root returned from pci_find_parent_resource() or none of them
>>> has a root and will fall back to &iomem_resource, or both cases are possible?
>
- Juan 
