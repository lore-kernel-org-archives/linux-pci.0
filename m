Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38436 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbeIGMqG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2018 08:46:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so15358690qtk.5
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2018 01:06:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3b37e4fd-c793-bd52-7d70-950f846a7d5a@kernel.org>
References: <20180907053614.6540-1-drake@endlessm.com> <3b37e4fd-c793-bd52-7d70-950f846a7d5a@kernel.org>
From: Daniel Drake <drake@endlessm.com>
Date: Fri, 7 Sep 2018 16:06:19 +0800
Message-ID: <CAD8Lp466EffdgL5zVZi-L+s78Yxa9+FryB8ch1=UAwwCPqu9Ag@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Wu <peter@lekensteyn.nl>, kherbst@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Thomas Martitz <kugel@rockbox.org>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2018 at 2:40 PM, Sinan Kaya <okaya@kernel.org> wrote:
> On 9/6/2018 10:36 PM, Daniel Drake wrote:
>>
>> +       if (pci_dev->class == PCI_CLASS_BRIDGE_PCI << 8)
>> +               pci_setup_bridge_mmio_pref(pci_dev);
>
>
> This should probably some kind of a quirk rather than default
> for the listed card as it sounds like you are dealing with
> broken hardware.

With that approach there's a sizeable list that your quirk list is
incomplete or out of date.

And when the bug bites, it's extremely cryptic. We've spent months
working on this issue and only found this magic register write mostly
through a stroke of good luck. Separately there's been a flurry of
mails around the r8169 MSI-X problem but as far as I can see nobody
suggested even looking at the values of the parent bridge prefetch
registers. And even if they did, they'd probably have said "values are
fine, nothing to see here" (exactly as we did 4 months ago when Nvidia
mentioned these registers as a possible cause - oops!).

So here I'm instead following a suggestion from Bjorn, after also
having confirmed the windows behaviour:

https://marc.info/?l=linux-pci&m=153574276126484&w=2
> Can we tell whether Windows rewrites this register unconditionally at
> resume-time?  If so, it may be more robust for Linux to do the same.
> The whole thing is black magic, which I hate, but if it's our only
> choice, it may be better to have this applied everywhere so we don't
> keep stubbing our toes on new systems that require the quirk.

Also, we just spoke to Asus BIOS engineers who told us that the BIOS
does already restore the PCI bridge prefetch registers on resume. I
guess this is why the other registers like the (non-zero) prefetch
base address lower 32 bits do have the right value on resume even
before my patch. It sounds like a more subtle bug related to register
write timing or sequence, in that case it will be harder to define who
is responsible for the breakage and hence under which conditions the
quirk should apply.

Daniel
