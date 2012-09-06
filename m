Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57091 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab2IFUri (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Sep 2012 16:47:38 -0400
Received: by lbbgj3 with SMTP id gj3so1436140lbb.19
        for <linux-pci@vger.kernel.org>; Thu, 06 Sep 2012 13:47:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7c9VmKt_j-TPTJLTrd1ggj+E4byGkOka0jVGPKz28ATA@mail.gmail.com>
References: <bug-750320-60020@http.bugzilla.novell.com/> <20120726204435.A2F49245526@molor.provo.novell.com>
 <CAErSpo7c9VmKt_j-TPTJLTrd1ggj+E4byGkOka0jVGPKz28ATA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 6 Sep 2012 14:47:16 -0600
Message-ID: <CAErSpo5+NmftFsaK0vbxUHVtk=V8-cnLmSQtJ4UA0Bsutpuz6w@mail.gmail.com>
Subject: Re: [Bug 750320] various Express Cards are not recognized by lspci
To: bugzilla_noreply@novell.com
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2012 at 8:27 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> https://bugzilla.novell.com/show_bug.cgi?id=750320
>
> I think this hotplug should be handled by the pciehp driver, but that
> driver doesn't appear to be loaded.  Can you load it and try this
> hotplug again, and attach the dmesg log?

Does anybody have time to look at this issue?  Elmar is very willing
to collect information and run tests, but I just haven't had a chance
to look into it.

Bjorn
