Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:53534 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab3I0V6T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 17:58:19 -0400
Received: by mail-ie0-f169.google.com with SMTP id tp5so5423594ieb.28
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2013 14:58:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6dOq8-vDP1G=pMV8fNrf81GyBtWrR5pkvynSkr834JTA@mail.gmail.com>
References: <CAOJFanW+QFjeUX40JhGHuaPRW7-7jh21OCijneWgPo=Nnf5Oaw@mail.gmail.com>
	<CAOJFanV9WewKjCyx6X-+nq4=EKoCwJTM6zg2PJ2BBBC_0aWNWw@mail.gmail.com>
	<CAErSpo6dOq8-vDP1G=pMV8fNrf81GyBtWrR5pkvynSkr834JTA@mail.gmail.com>
Date: Fri, 27 Sep 2013 14:58:18 -0700
Message-ID: <CAE9FiQXOK7BH84Dg_5-zXxKLxeLqNUh8OfFu=D4Edb7+S3oG0Q@mail.gmail.com>
Subject: Re: PCI: PCIe rescan resource allocation/re-size failure
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sasikanth babu <sasikanth.v19@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 27, 2013 at 1:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> pci 0000:0a:00.0: reg 10: [mem 0x00000000-0x00003fff 64bit pref]
>> pci 0000:0a:00.0: reg 18: [mem 0x00000000-0x03ffffff 64bit pref]
>> pcieport 0000:02:08.0: BAR 9: can't assign mem pref (size 0x6000000)
>> pci 0000:0a:00.0: BAR 2: can't assign mem pref (size 0x4000000)
>> pci 0000:0a:00.0: BAR 0: can't assign mem pref (size 0x4000)
>>
>> Linux kernel : 2.6.34.10 (It is very old. Have no option so can't use
>> latest version)

> But in general, it's just too hard to work on old kernels unless you
> can also demonstrate the problem on a current kernel, fix it there,
> and backport the fix.  Or, if the current kernel has already been
> fixed, you can figure out what fixed it and backport it.

yes, that kernel is too old.  4 years old?

Yinghai
