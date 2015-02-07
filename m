Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:38568 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbbBGVMi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 7 Feb 2015 16:12:38 -0500
Received: by mail-qa0-f41.google.com with SMTP id i13so3101733qae.0
        for <linux-pci@vger.kernel.org>; Sat, 07 Feb 2015 13:12:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXsk3WK2K6nXrcFczY8oNhn=AiW--Ks7xT+0e_3Z-HHDg@mail.gmail.com>
References: <1423011246-14429-1-git-send-email-yinghai@kernel.org>
 <CAErSpo6MV_obn_31J3zTSfR0ke7kNYdr0mxgyuMYstr5RJcQHA@mail.gmail.com> <CAE9FiQXsk3WK2K6nXrcFczY8oNhn=AiW--Ks7xT+0e_3Z-HHDg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 7 Feb 2015 15:12:16 -0600
Message-ID: <CAErSpo7yiW0gOuHhvjuge84EG_eoyezLPSLT20x=fKxnu2RDDQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: disable auto realloc detection for lsi devices
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	pjay@nwtrail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Paul]

On Sat, Feb 7, 2015 at 1:42 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Feb 7, 2015 at 6:14 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> The BIOS sets the BAR.  Why does the device work when the BIOS sets
>> the BAR but not when Linux does?
>
> If you reset the firmware with disable/enable pcie link, the new BAR will
> work.

I remember experiments like that with changing the bus number on an
LSI device (https://bugzilla.kernel.org/show_bug.cgi?id=84281,
http://lkml.kernel.org/r/ghiol53r9u.fsf@lena.gouders.net).  Did you do
similar experiments with link enable/disable when changing the BAR?

It sounds like you think it's standard practice for BIOSes to disable
and re-enable the link after programming BARs?  I'm not confident
about that because I don't think there's anything in the spec that
would suggest that.

Bjorn
