Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:35619 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757885Ab3BAWc2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2013 17:32:28 -0500
Received: by mail-vb0-f42.google.com with SMTP id ff1so2776946vbb.1
        for <linux-pci@vger.kernel.org>; Fri, 01 Feb 2013 14:32:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358549645.2393.3.camel@zim.stowe>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
 <alpine.DEB.2.02.1301181324010.31163@jlaw-desktop.mno.stratus.com> <1358549645.2393.3.camel@zim.stowe>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 1 Feb 2013 15:32:07 -0700
Message-ID: <CAErSpo7HsNHoJtyMk0gQdUjS-mU+DS5roO7UDtp5SKVp9A8Dkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled
To: Myron Stowe <mstowe@redhat.com>
Cc: Joe Lawrence <Joe.Lawrence@stratus.com>, linux-pci@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	David Bulkow <david.bulkow@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 18, 2013 at 3:54 PM, Myron Stowe <mstowe@redhat.com> wrote:
> On Fri, 2013-01-18 at 13:24 -0500, Joe Lawrence wrote:
>> From 108cca7bee5b04f45d9712507d14b5f3fbc22c29 Mon Sep 17 00:00:00 2001
>> From: Joe Lawrence <joe.lawrence@stratus.com>
>> Date: Tue, 15 Jan 2013 15:31:28 -0500
>> Subject: [PATCH 2/2] PCI: Don't touch ASPM if forcibly disabled
>>
>> Don't allocate and track PCIe ASPM state when "pcie_aspm=off" is specified on
>> the kernel parameter list.
>>
>> Based-on-patch-from: Matthew Garrett <mjg59@srcf.ucam.org>
>> Reviewed-by: David Bulkow <david.bulkow@stratus.com>
>> Signed-off-by: Joe Lawrence <joe.lawrence@stratus.com>
>> ---
>>  drivers/pci/pcie/aspm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 6122447..f912a93 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -556,6 +556,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>>       struct pcie_link_state *link;
>>       int blacklist = !!pcie_aspm_sanity_check(pdev);
>>
>> +     if (!aspm_support_enabled)
>> +             return;
>> +
>>       if (!pci_is_pcie(pdev) || pdev->link_state)
>>               return;
>>       if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
>
> I was considering whether putting in a similar check in the
> pcie_aspm_exit_link_state() would be best in order to "short circuit"
> all the unnecessary processing that still occurs with ASPM turned off
> and also for symmetry.  Bjorn suggested just sticking with the fix in
> pcie_aspm_init_link_state() since adding something similar in
> pcie_aspm_exit_link_state() may create other issues and does not help
> with simplifying ASPM's implementation.
>
> Acked-by: Myron Stowe <myron.stowe@redhat.com>

I applied this to pci/joe-aspm for v3.9.  Thanks!
