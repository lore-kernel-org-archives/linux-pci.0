Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:38699 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaEUPkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 11:40:11 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so3435239qgd.37
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 08:40:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Frustrating PCI x ACPI x APIC(?) interaction/bug
From: Micah Dombrowski <mpdwibble@gmail.com>
In-Reply-To: <CAErSpo5U4UpMdBC8nGTJcsatste17THf7Ko1RPZpaC01UyS6tw@mail.gmail.com>
Date: Wed, 21 May 2014 11:40:07 -0400
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-Id: <9F1CDCD7-94EC-43C3-9568-D5C348531D85@gmail.com>
References: <EF1232FA-308B-4261-82E6-6E3B932181E2@gmail.com> <CAErSpo5U4UpMdBC8nGTJcsatste17THf7Ko1RPZpaC01UyS6tw@mail.gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On May 20, 2014, at 10:02 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Mon, May 19, 2014 at 6:37 PM, Micah Dombrowski <mpdwibble@gmail.com> wrote:
> Thanks for the problem report.  If I understand correctly, the 4020
> works fine when connected to a desktop PC, but not when connected to
> the Lenovo T530 laptop.

Correct.

> I use http://bugzilla.kernel.org as a place to collect info like this,
> so if you want, you can open a report there and attach the logs.  Or
> I'd be glad to do that for you if you just include them in email.

I opened a report https://bugzilla.kernel.org/show_bug.cgi?id=76641

And attached dmesg and lspci -vv output from both systems.

Thanks,
MPD