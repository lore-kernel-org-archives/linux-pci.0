Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:41536 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423244Ab3DFQNJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 6 Apr 2013 12:13:09 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so4984521oag.9
        for <linux-pci@vger.kernel.org>; Sat, 06 Apr 2013 09:13:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365235201.31207.9.camel@pasglop>
References: <201304042158.r34LwEOV010607@d03av02.boulder.ibm.com>
 <CAErSpo5ReUcSPvyBs_u0HLh=90anEREZn4p6EUX4yO52bDBaeg@mail.gmail.com> <1365235201.31207.9.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 6 Apr 2013 10:12:48 -0600
Message-ID: <CAErSpo4oaG8-rPVXt=Qb3m3VT6DdkX15Gz8gqPenQTtsLnaM7w@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Enable boot_vga sysfs attribute for graphics
 adapters on Power
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brian King <brking@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	klebers@linux.vnet.ibm.com, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 6, 2013 at 2:00 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-04-05 at 14:11 -0600, Bjorn Helgaas wrote:
>>
>> I think sparc has the same issue in its own copy of
>> of_create_pci_dev().
>>
>> Of course, both of_create_pci_dev() implementations are basically
>> copies of the generic pci_setup_device() that most arches use.  That's
>> the reason why I wish sparc and powerpc had used config space
>> accessors that hid the OF mangling internally so they could use the
>> generic pci_setup_device() instead of cloning it.
>
> I disagree :-) I want the config space accessors to actually do the
> config space access (it might be necessary for some reasons, if anything
> for diagnostic). Also one of the reasons we create devices that way
> originally iirc, is that on older pre-PCIe setups, we could have cases
> of a bridge showing up at function N > 0 without anything at function
> 0.
>
> We are also not allowed to mess with bridge BARs on old EADS bridges,
> and similar issues where the hypervisor can get upset.
>
> A "filtering" config space code would be a lot messier than just
> creating them like we do.

Yeah, maybe so.  I guess it's just hard for me to let go of ideas
until I've tried myself and failed :)

Anyway, I hope putting a little more into alloc_pci_dev() will resolve
this particular issue.

Bjorn
