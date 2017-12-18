Return-Path: <SRS0=Eef5=DO=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=Eef5=DO=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v1 3/7] platforms/pseries: Set eeh_pe of EEH_PE_VF type
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, helgaas@kernel.org,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-4-bryantly@linux.vnet.ibm.com>
 <5a9a3c99-ae38-ac52-415c-fe3c2042acb2@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:29:14 -0600
MIME-Version: 1.0
In-Reply-To: <5a9a3c99-ae38-ac52-415c-fe3c2042acb2@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <d87099af-e6f4-cc1a-d5df-86e00eb48ce4@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Here we need to set the config_addr as PHYP (platform) 
does not enable the PE until the PE is bound to a VM, 
reason why we disable VF autoprobe.


On 12/17/17 10:34 PM, Alexey Kardashevskiy wrote:
> powernv does this from eeh_ops::probe, and so does pseries_eeh_probe(), do
> you still need this here?
