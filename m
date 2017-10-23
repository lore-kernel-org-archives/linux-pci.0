Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:47424 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdJWEui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2017 00:50:38 -0400
Received: by mail-oi0-f46.google.com with SMTP id h200so28752123oib.4
        for <linux-pci@vger.kernel.org>; Sun, 22 Oct 2017 21:50:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHp75VfiE7Xi76d58adttQPnsP1OyHguhdUnQcU=Drd674qp=w@mail.gmail.com>
References: <CAD8Lp47nOCt-93kBxmcJzUam=P7XRcm8vhwogoxXTJ_mwCH_Cg@mail.gmail.com>
 <CAHp75VfiE7Xi76d58adttQPnsP1OyHguhdUnQcU=Drd674qp=w@mail.gmail.com>
From: Daniel Drake <drake@endlessm.com>
Date: Mon, 23 Oct 2017 12:50:36 +0800
Message-ID: <CAD8Lp45aUcSHK5yDWSHhtXkP6WF9Xzbb44cMDsD0u4hyD9wAcg@mail.gmail.com>
Subject: Re: PCIe legacy interrupts blocked on Intel Apollo Lake platforms
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi,

On Wed, Oct 18, 2017 at 7:54 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> While Rafael is looking for a solution, can you in meantime gather the
> following on the affected hardware and share it via some resource on
> Internet?
>
> 1. % acpidump -o tables.dat # tables.dat is point of interest

https://gist.githubusercontent.com/dsd/ef9b9da4c634f57de89f917c43703272/raw/391db13df07ceab78ccc2ca1d5f4e5ccd3fb10d8/acpi%2520tables

> 2. % lspci -vv -nk # output of the command

https://gist.githubusercontent.com/dsd/ef9b9da4c634f57de89f917c43703272/raw/391db13df07ceab78ccc2ca1d5f4e5ccd3fb10d8/pci

> 3. % dmidecode # output of the command

https://gist.githubusercontent.com/dsd/ef9b9da4c634f57de89f917c43703272/raw/391db13df07ceab78ccc2ca1d5f4e5ccd3fb10d8/dmidecode

> 4. % grep -H 15 /sys/bus/acpi/devices/*/status # output of the command

https://gist.githubusercontent.com/dsd/ef9b9da4c634f57de89f917c43703272/raw/391db13df07ceab78ccc2ca1d5f4e5ccd3fb10d8/grep%2520-H%252015%2520acpi%2520status

> 5. % dmesg # when kernel command line has the 'ignore_loglevel
> initcall_debug' added

https://gist.githubusercontent.com/dsd/ef9b9da4c634f57de89f917c43703272/raw/391db13df07ceab78ccc2ca1d5f4e5ccd3fb10d8/dmesg


All above files in a zip:
https://gist.github.com/dsd/ef9b9da4c634f57de89f917c43703272/archive/391db13df07ceab78ccc2ca1d5f4e5ccd3fb10d8.zip

Please let me know how we can help further!

Daniel
