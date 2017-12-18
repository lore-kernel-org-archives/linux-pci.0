Return-Path: <SRS0=Eef5=DO=linux.vnet.ibm.com=jjalvare@kernel.org>
Return-Path: <SRS0=Eef5=DO=linux.vnet.ibm.com=jjalvare@kernel.org>
Subject: Re: [PATCH v1 4/7] powerpc/kernel Add EEH operations to notify resume
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com, helgaas@kernel.org,
        ruscur@russell.cc, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
        saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-5-bryantly@linux.vnet.ibm.com>
 <b2d30341-1945-0331-fb36-d441efc89109@ozlabs.ru>
From: Juan Alvarez <jjalvare@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 13:29:37 -0600
MIME-Version: 1.0
In-Reply-To: <b2d30341-1945-0331-fb36-d441efc89109@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Message-Id: <8e76e076-d003-03e0-2ed9-af445a14e326@linux.vnet.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Yes, way less. So our current design only supports less than or equal to
256 VFs per PF. That is 256*2 bytes.


On 12/17/17 11:02 PM, Alexey Kardashevskiy wrote:
> It is kind of assumed that the number of VFs is always less than 2048 minus
> rtas call parameters (RTAS_DATA_BUF_SIZE==4096 now)?
