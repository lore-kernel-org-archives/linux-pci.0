Return-Path: <SRS0=Pv+1=GE=linux.vnet.ibm.com=desnesn@kernel.org>
Return-Path: <SRS0=Pv+1=GE=linux.vnet.ibm.com=desnesn@kernel.org>
Subject: Re: [PATCH 1/2, pci] pci: Addition of PCI_DEV_FLAGS_QUIET_PCI_REALIGN
 attribute to the PCI subsystem
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ruscur@russell.cc, aik@ozlabs.ru, david@gibson.dropbear.id.au,
        fbarrat@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
 <20180314163455.15854-2-desnesn@linux.vnet.ibm.com>
 <20180314180642.GC179719@bhelgaas-glaptop.roam.corp.google.com>
 <30c63477-620b-3f8b-82df-fd1e34cd99b8@linux.vnet.ibm.com>
 <20180314185508.GE179719@bhelgaas-glaptop.roam.corp.google.com>
From: =?UTF-8?Q?Desnes_Augusto_Nunes_do_Ros=c3=a1rio?=
 <desnesn@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 18:12:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180314185508.GE179719@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <442e2ae9-9423-8bf3-a7c1-a35381781145@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On 03/14/2018 03:55 PM, Bjorn Helgaas wrote:

>>> As far as I'm concerned, we can just remove these messages completely.
>>> I don't think there's any real value there.
>>
>> After I found out that this was happening to all PCI devices on powerpc due
>> to the __weak
>> pcibios_default_alignment() interface (necessary for VFIO passthrough and
>> performance), I confess that this was my first approach to this matter;
>> however I couldn't vouch the need of these messages on other architectures.
>>
>> If there are no further concerns, I definitely prefer sending a second
>> version of this patch only eliminating these messages and attesting the
>> reason why.
>>
>> Thank you very much for your review Bjorn,
> 
> No problem, welcome to PCI, and I hope we see more of your work!

Bjorn,

Awesome! A second version of this fix has been sent with a new title: 
"[PATCH, pci, v2] pci: Delete PCI disabling informational messages"

Thanks for the review and warm welcome!

-- 
Desnes A. Nunes do Rosário
--------------------------
