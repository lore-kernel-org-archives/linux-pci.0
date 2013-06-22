Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:54992 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab3FVTOi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jun 2013 15:14:38 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so21828904iea.17
        for <linux-pci@vger.kernel.org>; Sat, 22 Jun 2013 12:14:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t_Mkz3Jnqw_pENF2A4+a9e2mC=s6Q-5wRYoqL4DpyJGZA@mail.gmail.com>
References: <CAH9N0t_qrzLqeR6tZ8ykbFEzx0dZtCREjz9wCwCDTDDFwic6-Q@mail.gmail.com>
	<CAE9FiQWJV=NPn9yBX2nQ9z8hFc4_9tNHm5BWwsY4dG_h7yYmvA@mail.gmail.com>
	<CAH9N0t_gPz_MBiBSbLpATD3j-+LgS=7jqNbtv3qqg6v8K76dzg@mail.gmail.com>
	<CAE9FiQWXKJvhmmPHWX+v7EZdTkNWZAWgTtjibgsBVhWRYadoWg@mail.gmail.com>
	<CAH9N0t_Mkz3Jnqw_pENF2A4+a9e2mC=s6Q-5wRYoqL4DpyJGZA@mail.gmail.com>
Date: Sat, 22 Jun 2013 12:14:37 -0700
Message-ID: <CAE9FiQUPTxMKvjj-tsruwcZLViv2FBfF1c--5NO6nDDzBG0-rQ@mail.gmail.com>
Subject: Re: PCIe Hotplug Script Automatization.
From: Yinghai Lu <yinghai@kernel.org>
To: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 22, 2013 at 3:15 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Hello Yinghai,
> Here goes the dmesg output (ni the attach file).

well, the bios does not have _OSC...

 pci0000:00: Requesting ACPI _OSC control (0x1d)
 pci0000:00: ACPI _OSC request failed (AE_NOT_FOUND), returned control
mask: 0x1d
ACPI _OSC control for PCIe not granted, disabling ASPM

what is debug message when you insert pciehp?

Yinghai
