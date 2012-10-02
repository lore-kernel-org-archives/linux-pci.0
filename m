Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36550 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab2JBOaO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 10:30:14 -0400
Received: by lagh6 with SMTP id h6so2415417lag.19
        for <linux-pci@vger.kernel.org>; Tue, 02 Oct 2012 07:30:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20121002T080608-96@post.gmane.org>
References: <loom.20121002T002058-318@post.gmane.org> <CAErSpo7q4tYwCHnMjovyDVXdCpGrWkqmO5u=1yAAhh7XBL_ASA@mail.gmail.com>
 <loom.20121002T080608-96@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 2 Oct 2012 08:29:52 -0600
Message-ID: <CAErSpo6CtjZ-vWHF_q3Gi=kHHWLMMtJ7nOyoBOw_iU1YdA-tXA@mail.gmail.com>
Subject: Re: pci_request_regions()
To: Paolo <paolopiace@hotmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 2, 2012 at 12:16 AM, Paolo <paolopiace@hotmail.com> wrote:
> Bjorn Helgaas <bhelgaas <at> google.com> writes:
>>
>> In 2.6.32, the function pci_request_regions() is in the file
>> drivers/pci/pci.c.  It's still there in the current kernel (v3.6).
>>
>> The stuff below looks like a directory hierarchy, not information
>> about the *contents* of the files.
>>
>
> Don't know what to say. There is NO string "pci_request_regions" in any of those
> files. They are just Makefile and Kconfig.
> Yet, I'm working on a driver that calls that function and works just fine.
> How/where does it find that pci_request_regions()?
>
> Here is the output of the ls command, purged of the dot directories.
>
> paolo@paolo-DT0:/usr/src/linux-headers-2.6.32-43$ ls -laR drivers/pci/
>
> drivers/pci/:
> drwxr-xr-x  2 root root 4096 2012-09-20 14:55 hotplug
> -rw-r--r--  1 root root 1977 2009-12-02 19:51 Kconfig
> -rw-r--r--  1 root root 1600 2009-12-02 19:51 Makefile
> drwxr-xr-x  3 root root 4096 2012-09-20 14:55 pcie

You don't have a complete kernel source tree.  I think you're looking
at just a kernel headers tree, e.g., what's installed in Ubuntu by the
linux-headers package.  You need to install something like the
"linux-source" package to get the entire source tree.

Bjorn
