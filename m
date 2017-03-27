Return-Path: <SRS0=g4On=3E=ellerman.id.au=mpe@kernel.org>
Return-Path: <SRS0=g4On=3E=ellerman.id.au=mpe@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 2/3] PCI: Add a macro to set default alignment for all PCI devices
In-Reply-To: <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com> <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com> <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 27 Mar 2017 21:17:37 +1100
Message-ID: <8737dzf2gu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:
>
> I don't know how powerpc kernels are built: can you build a kernel
> that will run on PowerNV as well as on different powerpc systems?

Yes you can. But there are some restrictions.

You can only build a 64-bit OR a 32-bit kernel.

And within 64-bit you can only build a *kernel* for the "server
architecture (~= IBM CPUs)" or the "embedded architecture
(Freescale/NXP)".

So in practice you can build a 64-bit kernel that supports:
 - powernv (bare metal on IBM server chips)
 - pseries (virtualised on IBM server chips or qemu)
 - powermac (Apple G5s)
 - pasemi (long dead but still used by some Amiga folks?)
 - Cell/PS3 (also long dead)

> If so, is it acceptable to force that kernel to user 64K alignment even
> when it's running on non-PowerNV systems?

Probably, but I'm not sure TBH. Benh will know, I'll try and get his
attention.

cheers
