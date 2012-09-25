Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64354 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831Ab2IYQ3J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2012 12:29:09 -0400
Received: by eaac11 with SMTP id c11so2357765eaa.19
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2012 09:29:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo5Arj=rh4mZJk3tEsaWKBFqxK6tAu1N5SKn2Cq=vTj+bw@mail.gmail.com>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
	<CAErSpo5Arj=rh4mZJk3tEsaWKBFqxK6tAu1N5SKn2Cq=vTj+bw@mail.gmail.com>
Date: Tue, 25 Sep 2012 09:29:08 -0700
Message-ID: <CAE9FiQUu++bPNree995uY3bGURxJ6hSi8m77ah_8KK6S2aMUaQ@mail.gmail.com>
Subject: Re: [PATCH 00/29] PCI: use pci host bridge to loop pci root bus
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 25, 2012 at 9:23 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Sep 25, 2012 at 2:26 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>> could remove pci_root_buses list.
>>
...
>>   PCI: Add dummy bus_type for pci_host_bridge
...
>>   PCI: Add for_each_pci_host_bridge() and pci_get_next_host_bridge
>
> I'm not thrilled about adding a new iterator for all host bridges.
>
> The iterator design pattern does not work for collections that can
> change over time.  In this case, it looks like you're adding a safer
> way to iterate through all host bridges we know about at this time.
> But we still have the problem of the host bridge that's added
> tomorrow.
>
> I'd prefer a design where the PCI core provides an interface that
> means "call this function for every host bridge we know about now
> *and* for every one that's added in the future."

yes, that is the point to add pci_root_bridge_bus_type. We can register
bus notifier on that.

-Yinghai
