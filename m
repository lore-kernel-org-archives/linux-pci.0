Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:36017 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab3DWBrG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 21:47:06 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Tue, 23 Apr 2013 07:13:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 331A3E0054
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2013 07:19:04 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3N1ksfR7340478
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2013 07:16:54 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3N1l0bs015849
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2013 11:47:01 +1000
Message-ID: <1366681602.1654.8.camel@localhost.localdomain>
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 22 Apr 2013 21:46:42 -0400
In-Reply-To: <CAErSpo4Y0zkWDsyJi47awtz67oWO4Qj+J4mDA3B0cfaYx_v_VQ@mail.gmail.com>
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
	 <1366612577.2723.21.camel@pasglop> <5174E9C3.6080203@linux.vnet.ibm.com>
	 <1366617867.2723.23.camel@pasglop> <5175067F.3030307@linux.vnet.ibm.com>
	 <CAErSpo4Y0zkWDsyJi47awtz67oWO4Qj+J4mDA3B0cfaYx_v_VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-22 at 11:35 -0600, Bjorn Helgaas wrote:
> On Mon, Apr 22, 2013 at 3:44 AM, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
> > 于 2013/4/22 16:04, Benjamin Herrenschmidt 写道:
> >
> >> On Mon, 2013-04-22 at 15:41 +0800, Mike Qiu wrote:
> >>>
> >>> Anyway, I think it's better to remove the check code as it is useless,
> >>> as it
> >>> will shows that this "NULL" pci_controller pointer may happen...
> >>
> >> Ok. It *might* still be worth adding a BUG_ON then in pci_bus_to_host()
> >> itself ... no big deal either way.
> >
> > OK, you mean the code will remain the same and my patch is worthless?
> >
> > Anyway, it will be OK for me. But I hope it can be accept for more stable
> > reason.
> 
> This is powerpc code, so I'm kibitzing here, but it was cc'd to linux-pci :)
> 
> There should be no way to get a struct pci_bus * where bus->sysdata
> (== "hose") is NULL.  The sysdata pointer is always supplied to
> pci_create_root_bus() (or a similar interface that calls
> pci_create_root_bus()), so every root bus has a valid sysdata pointer.
>  And every child bus inherits the sysdata pointer of its parent (in
> pci_alloc_child_bus()).  Therefore, every pci_bus should have a valid
> sysdata pointer.
And the kernel has checked whether if sysdata is NULL after call
pci_create_root_bus().
> 
> So I think you should just remove even the existing "if (hose ==
> NULL)" check.  That way, if bus->sysdata actually *does* turn out to
> be NULL, we'll oops on the null pointer dereference, get a nice
> backtrace, and have a chance to fix the problem.  Testing and
> returning an error means whatever bug or memory corruption caused the
> null pointer will most likely be ignored.
> 
Yes, I agree with you, because it is useless, and meaningless. Also
it never achieve its goals even if the "hose==NULL". 

So I suggest either use my patch or remove that check code.
If the second case, I will write v2 patch to remove that check code.
I don't know what's to go for next step, it depends on the
maintainer :)

Thanks
Mike
 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


