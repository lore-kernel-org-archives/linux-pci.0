Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62813 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408Ab3EQRbg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 13:31:36 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so4971270obb.5
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 10:31:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5195596C.3000406@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com> <5195596C.3000406@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 11:31:15 -0600
Message-ID: <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 4:10 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 05/16/2013 12:42 PM, Bjorn Helgaas wrote:
>> Can you collect a complete dmesg log and complete "lspci -vv" output, please?
> ...

Thanks.  The BIOS gave us control over ASPM via _OSC, and you have
these devices where it looks like we should be enabling ASPM, because
it's supported on both ends of the link:

    00:1c.1 bridge to [bus 03] ASPM L0s L1, ASPM disabled
      03:00.0 ASPM L0s L1, ASPM disabled
    00:1c.3 bridge to [bus 05] ASPM L0s L1, ASPM Disabled
      05:00.0 ASPM L0s L1, ASPM Disabled
    00:1c.4 bridge to [bus 06] ASPM L0s L1, ASPM Disabled
      06:00.0 ASPM L0s L1, ASPM Disabled
    00:1c.7 bridge to [bus 09] ASPM L0s L1, ASPM Disabled
      09:00.0 ASPM L0s L1, ASPM Disabled

You also have this bridge where lspci says "ASPM unknown":

    00:01.0 bridge to [bus 01] ASPM unknown

Just out of curiosity, can you collect the output of "lspci -xxxs
00:01.0"?  There are only two bits in the Link Capabilities ASPM
support field, and all four encodings are defined, so I'm curious
about why lspci says "unknown".

Bjorn
