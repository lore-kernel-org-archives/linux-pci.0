Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:45560 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbaC0QBi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 12:01:38 -0400
Received: by mail-ig0-f177.google.com with SMTP id ur14so1764123igb.10
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2014 09:01:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5+aJfJ_vdkpVbOvi8OgDsv-UgbRg+keE-YSUwrF8c93tA@mail.gmail.com>
References: <CAHH3p5+aJfJ_vdkpVbOvi8OgDsv-UgbRg+keE-YSUwrF8c93tA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 27 Mar 2014 10:01:17 -0600
Message-ID: <CAErSpo4FXCKCyXzz+pj4O4hX6vGeZuDdG0YpShU9NhovCSYk7g@mail.gmail.com>
Subject: Re: Test MSI without device driver
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 27, 2014 at 4:54 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Could we test MSI functionality of Root Complex without having Endpoint driver?
> If not, could we use some test code just to simulate endpoint driver
> for MSI functionality?

An Endpoint signals an MSI by issuing a DMA write.  The OS configures
the target of that write when it enables MSI on the device.  The
target of the write may be something in the Root Complex, a local APIC
in a CPU, or something else.

I don't think the PCIe spec says anything about how this should be
implemented, so from a PCIe spec point of view, the PCI/PCIe fabric
and the Root Complex route the DMA write but otherwise don't do
anything special with it.

You should be able to test some MSI functionality if you can generate
a write similar to what the Endpoint would generate.  On x86, MSI DMA
writes typically target a CPU Local APIC, and you could write to those
by ioremapping the LAPIC physical address.  Of course, this wouldn't
test the whole path because the transaction would not traverse any of
the PCIe fabric.

If the MSI target is in the Root Complex, you'd have to know more
details about the topology and routing details, but you could probably
do the same thing.

But it's probably a lot easier to just put an Endpoint in the system
and test it that way :)

Bjorn
