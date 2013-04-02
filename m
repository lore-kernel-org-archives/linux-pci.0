Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:36981 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762286Ab3DBVPm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Apr 2013 17:15:42 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so358691dak.16
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2013 14:15:41 -0700 (PDT)
Date: Tue, 2 Apr 2013 14:15:37 -0700
From: Jonathan Nieder <jrnieder@gmail.com>
To: szabolcs <szabolcs@cohortor.org>
Cc: 701620@bugs.debian.org, linux-pci@vger.kernel.org
Subject: Re: [3.8.y] Unable to use PCI cards on Intel DZ77SL50K motherboard
 (likely any Z77 board)
Message-ID: <20130402211537.GJ28148@google.com>
References: <CALvyPWOuPbx82JTuqcn1zva_8dmowQ=q26veKKdv0t9-yT7MPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALvyPWOuPbx82JTuqcn1zva_8dmowQ=q26veKKdv0t9-yT7MPg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi again,

szabolcs wrote:

> Would there be anything else I could help with to resolve this?

Some ideas collected by private mail:

 * Have you checked if there are BIOS updates available for this
   motherboard?  It looks like an interrupt routing problem, which could
   mean a bad ACPI interrupt routing table.

 * please attach:
   * full "dmesg" output from booting and trying to use the NIC
   * full output from running "lspci -vvv" as root
   * full "acpidump" output

Thanks,
Jonathan
