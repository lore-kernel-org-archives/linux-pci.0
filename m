Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:51974 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbaIJWNb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Sep 2014 18:13:31 -0400
Received: by mail-qa0-f51.google.com with SMTP id i13so139149qae.38
        for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2014 15:13:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG-92OOEkNOPmmyHP0=UGcT+qusPkWp7vy_qZCe6YEwKG27B6g@mail.gmail.com>
References: <CAG-92OOEkNOPmmyHP0=UGcT+qusPkWp7vy_qZCe6YEwKG27B6g@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 10 Sep 2014 16:13:10 -0600
Message-ID: <CAErSpo4g6GXwWLvh4qGLvXH-1bCrWKf-Pjf4pAWsoB05NYSmFw@mail.gmail.com>
Subject: Re: Running Adobe Flash triggers PCI bus failure
To: aw ful <awfl.awfl@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Josh Boyer <jwboyer@redhat.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Josh, Myron]

On Wed, Sep 10, 2014 at 10:10 AM, aw ful <awfl.awfl@gmail.com> wrote:
> I have a hardware system that is otherwise extremely stable, however,
> after 1 minute to 1 day of viewing Flash videos via Firefox a PCI bus
> fails and manifests in several different ways, including massive
> ethernet errors and frozen sata devices. This failure can also be
> invoked using multiple Live distributions, where the only thing I add
> is installing the Flash plugin from Adobe. Initially believed to be a
> hardware problem, I now believe it is a long term obscure bug as I
> have seen related symptoms in various bug reports which were never
> clearly resolved, and never associated with the flash plugin.
>
> I am writing to the kernel devs as I can easily make this occur on two
> distinct Linux distributions - standard Fedora 19, 20 Live, and 21 TC6
> Live, and Linux Mint 17 Live, experienced across many recent 3.14.17,
> 3.16.2 kernel versions. The failure occurs on a Asrock AM3+ system
> with AMD NB and SB. I was not clear how and where to write a further
> bug report because I can now demonstrate it on multiple distributions.
> Any assistance is appreciated.
>
> Detailed information can be found here:
> https://bugzilla.redhat.com/show_bug.cgi?id=1135801
> which includes dmesg and lspci -vv

Thanks for the report!  It sounds like you've reproduced the problem
on a non-RedHat kernel, so can you open a report at
http://bugzilla.kernel.org using an unmodified upstream kernel,
please?

Please attach "lspci -vv" output (as root) from before the problem and
another from after, as well as the complete dmesg log.  You mention
several other bugzilla reports; please include URLs to those as well.

You mention "taking down PCI bus"; what specifically do you mean by
that?  I do see some FFFFFFFF data from ata7 and ata8 in your dmesg,
which can be a symptom of a device not responding.  ata7 and ata8 seem
to be on 06:00.0, and your lspci shows UnsupReq+ set in that device's
AER Capability.  Please also attach "lspci -xxxxs06:00.0" output so we
can look at that in more detail.

The atl1c device is at 03:00.0, and your lspci also shows UnsupReq+
for it, so please also attach "lspci -xxxxs03:00.0" output.

Does your kernel have CONFIG_PCIEAER=y?  If not, can you turn that on
and see if you see anything useful in dmesg when the problem occurs?

Bjorn
