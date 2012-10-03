Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50367 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2JCTtT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 15:49:19 -0400
Received: by ieak13 with SMTP id k13so18121989iea.19
        for <linux-pci@vger.kernel.org>; Wed, 03 Oct 2012 12:49:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUXmURaO40sA4ibf7j9sokEHYXK_EaGiEq9b-ob=d1MRw@mail.gmail.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
 <1349159588-15029-2-git-send-email-yinghai@kernel.org> <20121002133303.GA502@kroah.com>
 <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
 <20121002174712.GA11843@kroah.com> <CAE9FiQXM6Cy64ZbXtjsnQaMFJi0C1QABC7TNYSBZ3FGsjC8D8w@mail.gmail.com>
 <20121002204548.GC28663@kroah.com> <CAE9FiQV51R2RBAZBPobDifq6jQUhBCyx_Bo8EHxOX4yrUMSnLg@mail.gmail.com>
 <CAErSpo5EuGVhu_ObioV-4n7930MkJzD9jrtkn6-JdBLikDBmMg@mail.gmail.com> <CAE9FiQUXmURaO40sA4ibf7j9sokEHYXK_EaGiEq9b-ob=d1MRw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Oct 2012 13:48:58 -0600
Message-ID: <CAErSpo4gFhiyS8GdZG21Eo0NPjvedr1+rXtY-MP11hDWCZ+LzA@mail.gmail.com>
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
To: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 6:00 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Oct 2, 2012 at 3:38 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> I don't know what the right answer is, but I do think it's better to
>> resolve it inside PCI and ACPI rather than playing games with driver
>> binding times in the driver core.
>
> is that ok to save that drivers_autoprobe bit in device.archdata for
> ia64 and x86 that using acpi?

You'll have to ask Len (cc'd) what he thinks about the ACPI piece, but
I don't like the PCI piece.  It's the same idea that Greg already said
he wouldn't put in the driver core.  Why would it be better to add
this complexity in the ACPI and PCI cores?

I still think you need to work on the ACPI/PCI binding issue.  Yes,
it's hard, but I'm not in favor of avoiding that hard work by adding
kludges everywhere.

Bjorn
