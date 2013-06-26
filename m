Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:46611 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab3FZDdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 23:33:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so14349607oag.16
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 20:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372215737.30572.484.camel@ul30vt.home>
References: <20130626025001.GA25384@google.com> <1372215737.30572.484.camel@ul30vt.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Jun 2013 21:33:33 -0600
Message-ID: <CAErSpo5rps3grs_=DT4+t8Krb=M_nCBYUDS1MJ9Xkyp-_VwGpQ@mail.gmail.com>
Subject: Re: Current open PCI defects
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 9:02 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Tue, 2013-06-25 at 20:50 -0600, Bjorn Helgaas wrote:
>> Here's a list of the current PCI defects open in https://bugzilla.kernel.org
>>
>> Hint: maintainers really like it when people take the initiative to
>> resolve open issues.
>>
>> Regressions (8 total):
>>
>>   15388       After suspend to ram, laptop doesn't connect to the wired network. Sky2 error. Marvell 88E8036
>>   41622       [REGRESSION][BISECTED] Notebook crashes upon detecting the PCI subsystem with kernels >= 2.6.24-rc7
>>   42606       PCI I/O range not assigned under newer kernels
>>   44881       pci_find_upstream_pcie_bridge() warning
>
> http://www.spinics.net/lists/linux-pci/msg23262.html

Thanks, I haven't caught up on my email from vacation yet.
