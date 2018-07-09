Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754433AbeGILmt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Jul 2018 07:42:49 -0400
Date: Mon, 9 Jul 2018 12:42:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: mobiveil: integer overflow in IB_WIN_SIZE
Message-ID: <20180709114241.GA1798@e107981-ln.cambridge.arm.com>
References: <20180705094539.xkmtfffbzl3kooum@kili.mountain>
 <20180706112652.GA14650@red-moon>
 <CAFZiPx1w_st+TY+EKm6nxvJ=S_ZJzUY2No8790V2haGX+ZO+Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFZiPx1w_st+TY+EKm6nxvJ=S_ZJzUY2No8790V2haGX+ZO+Rg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 09, 2018 at 03:55:00PM +0530, Subrahmanya Lingappa wrote:
> Hi Lorenzo,
> 
> Our reference IP's hardware registers require the to support 256GB
> inbound window size and this driver did exactly that I believe.

No it does not, please check what this patch does, the window size
is not currently configured as you wish.

More importantly, nobody can even test it given that this driver lacks a
Kconfig and a Makefile entry unless I am missing something, I presume
they were lost in patch reviews but you ought to fix this as soon as
possible please since this was something I should not have missed.

> May I ask, why do you think this size is questionable ?

The macro is not questionable, it is buggy, the size is what you
tell me it should be, I agree.

Lorenzo

> 
> Thanks.
> 
> 
> On Fri, Jul 6, 2018 at 4:56 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Thu, Jul 05, 2018 at 12:45:39PM +0300, Dan Carpenter wrote:
> >> IB_WIN_SIZE is larger than INT_MAX so we need to cast it to u64.
> >>
> >> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >> Untested...  Possibly the problem is that there are too many multiplies
> >> by * 1024.
> >
> > Hi Subrahmanya,
> >
> > I always thought that that macro value was questionable, please
> > can you comment on this ?
> >
> > Thanks,
> > Lorenzo
> >
> >> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> >> index 4d6c20e47bed..cf0aa7cee5b0 100644
> >> --- a/drivers/pci/controller/pcie-mobiveil.c
> >> +++ b/drivers/pci/controller/pcie-mobiveil.c
> >> @@ -107,7 +107,7 @@
> >>  #define CFG_WINDOW_TYPE      0
> >>  #define IO_WINDOW_TYPE               1
> >>  #define MEM_WINDOW_TYPE      2
> >> -#define IB_WIN_SIZE          (256 * 1024 * 1024 * 1024)
> >> +#define IB_WIN_SIZE          ((u64)256 * 1024 * 1024 * 1024)
> >>  #define MAX_PIO_WINDOWS      8
> >>
> >>  /* Parameters for the waiting for link up routine */
