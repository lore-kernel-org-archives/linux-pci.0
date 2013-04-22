Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:33207 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3DVRgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 13:36:21 -0400
Received: by mail-ve0-f181.google.com with SMTP id d10so214264vea.26
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 10:36:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5175067F.3030307@linux.vnet.ibm.com>
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1366612577.2723.21.camel@pasglop> <5174E9C3.6080203@linux.vnet.ibm.com>
 <1366617867.2723.23.camel@pasglop> <5175067F.3030307@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Apr 2013 11:35:58 -0600
Message-ID: <CAErSpo4Y0zkWDsyJi47awtz67oWO4Qj+J4mDA3B0cfaYx_v_VQ@mail.gmail.com>
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 22, 2013 at 3:44 AM, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
> 于 2013/4/22 16:04, Benjamin Herrenschmidt 写道:
>
>> On Mon, 2013-04-22 at 15:41 +0800, Mike Qiu wrote:
>>>
>>> Anyway, I think it's better to remove the check code as it is useless,
>>> as it
>>> will shows that this "NULL" pci_controller pointer may happen...
>>
>> Ok. It *might* still be worth adding a BUG_ON then in pci_bus_to_host()
>> itself ... no big deal either way.
>
> OK, you mean the code will remain the same and my patch is worthless?
>
> Anyway, it will be OK for me. But I hope it can be accept for more stable
> reason.

This is powerpc code, so I'm kibitzing here, but it was cc'd to linux-pci :)

There should be no way to get a struct pci_bus * where bus->sysdata
(== "hose") is NULL.  The sysdata pointer is always supplied to
pci_create_root_bus() (or a similar interface that calls
pci_create_root_bus()), so every root bus has a valid sysdata pointer.
 And every child bus inherits the sysdata pointer of its parent (in
pci_alloc_child_bus()).  Therefore, every pci_bus should have a valid
sysdata pointer.

So I think you should just remove even the existing "if (hose ==
NULL)" check.  That way, if bus->sysdata actually *does* turn out to
be NULL, we'll oops on the null pointer dereference, get a nice
backtrace, and have a chance to fix the problem.  Testing and
returning an error means whatever bug or memory corruption caused the
null pointer will most likely be ignored.

Bjorn
