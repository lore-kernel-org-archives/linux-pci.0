Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36700 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbbDNN6n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2015 09:58:43 -0400
Received: by igblo3 with SMTP id lo3so74518082igb.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2015 06:58:43 -0700 (PDT)
Date: Tue, 14 Apr 2015 08:58:40 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: moussa ba <musaba@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI Out of Resources
Message-ID: <20150414135840.GB19151@google.com>
References: <CAEkKNCc9BpCXNCw1RD2gngUhSs13_-P_rtk=w4tVDW+3QaR6xQ@mail.gmail.com>
 <CAErSpo5K9utm4Bt75L75jTY5HPZO8qTtHfy9OzVqzxjV3FAW4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo5K9utm4Bt75L75jTY5HPZO8qTtHfy9OzVqzxjV3FAW4A@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 14, 2015 at 08:05:42AM -0500, Bjorn Helgaas wrote:
> 2) Please post a complete dmesg log, complete "lspci -vv" output,
> contents of /proc/iomem, and a transcript of what you're doing with
> setpci (remove vendor/device IDs if they are confidential, ...

BTW, here are some sed scripts I've used to sanitize dmesg output
in the past.  It's tedious to do this by hand.

  dmesg | sed -r 's/(pci ....:..:..\..: \[)....:....(\].*)/\1VVVV:DDDD\2/' | sed -r 's/(DMI:).*/\1 (removed)/' | sed -r 's/(ACPI: [A-Z]{4} [0-9a-fA-F]{16} .*\().*(\).*)/\1...\2/' | sed -r 's/(scsi.*: Direct-Access).*/\1 .../'
