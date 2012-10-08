Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54555 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab2JHQhp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2012 12:37:45 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2389528lag.19
        for <linux-pci@vger.kernel.org>; Mon, 08 Oct 2012 09:37:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121008162830.GA1307@kroah.com>
References: <1349643467.16173.148.camel@deadeye.wl.decadent.org.uk> <20121008162830.GA1307@kroah.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 8 Oct 2012 10:37:24 -0600
Message-ID: <CAErSpo5WymA1qf_mL4F_VYeNt0Ed5EY0RHW4ts76DLbipLp8pQ@mail.gmail.com>
Subject: Re: [stable] PCI: acpiphp: check whether _ADR evaluation succeeded
To: Greg KH <greg@kroah.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 8, 2012 at 10:28 AM, Greg KH <greg@kroah.com> wrote:
> On Sun, Oct 07, 2012 at 09:57:47PM +0100, Ben Hutchings wrote:
>> Based on <https://bugzilla.kernel.org/show_bug.cgi?id=46481>, the
>> following commit should be cherry-picked for stable series < 3.6:
>>
>> commit dfb117b3e50c52c7b3416db4a4569224b8db80bb
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Wed Jun 20 16:18:29 2012 -0600
>>
>>     PCI: acpiphp: check whether _ADR evaluation succeeded
>>
>> It applies cleanly to 3.2.y and presumably also to later stable
>> branches.  I've attached a version that applies to 2.6.32.y and 3.0.y,
>> and presumably also to the intermediate stable branches.  Only 3.2.y has
>> actually been tested with this, though.
>
> Thanks, now applied.

Has anybody looked deeper to see exactly *how* this patch fixes the
problem?  The original reports were oopses caused by dereferencing bad
pointers in DRM, and it's not obvious to me how this patch is
connected to those.
