Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45356 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756254AbdJRLyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2017 07:54:31 -0400
MIME-Version: 1.0
In-Reply-To: <CAD8Lp47nOCt-93kBxmcJzUam=P7XRcm8vhwogoxXTJ_mwCH_Cg@mail.gmail.com>
References: <CAD8Lp47nOCt-93kBxmcJzUam=P7XRcm8vhwogoxXTJ_mwCH_Cg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 18 Oct 2017 14:54:30 +0300
Message-ID: <CAHp75VfiE7Xi76d58adttQPnsP1OyHguhdUnQcU=Drd674qp=w@mail.gmail.com>
Subject: Re: PCIe legacy interrupts blocked on Intel Apollo Lake platforms
To: Daniel Drake <drake@endlessm.com>
Cc: Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 11:36 AM, Daniel Drake <drake@endlessm.com> wrote:
> [retitling and re-summarizing in hope of attention from Intel]
>
> Andy / Rafael,
>
> Thomas Gleixner suggested that you might be able to help with a nasty
> issue related to Intel Apollo Lake platforms - or you can put us in
> contact with another relevant person at Intel.

While Rafael is looking for a solution, can you in meantime gather the
following on the affected hardware and share it via some resource on
Internet?

1. % acpidump -o tables.dat # tables.dat is point of interest
2. % lspci -vv -nk # output of the command
3. % dmidecode # output of the command
4. % grep -H 15 /sys/bus/acpi/devices/*/status # output of the command
5. % dmesg # when kernel command line has the 'ignore_loglevel
initcall_debug' added

-- 
With Best Regards,
Andy Shevchenko
