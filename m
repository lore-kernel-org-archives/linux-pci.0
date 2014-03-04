Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:42129 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbaCDRqR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Mar 2014 12:46:17 -0500
Received: by mail-ig0-f180.google.com with SMTP id hl1so2023173igb.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2014 09:46:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140304035917.GA3032@pratyush-vbox>
References: <CAHH3p5JzL-9T-Hn=fp1S9=URzycpKTy6toaA0AjQfJYt7mQXsA@mail.gmail.com>
 <20140304035917.GA3032@pratyush-vbox>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Mar 2014 10:45:56 -0700
Message-ID: <CAErSpo7s7fdUZH6zXr3ZWHq8s+zQ_5_sszzBZWrqFOh+jXHUgA@mail.gmail.com>
Subject: Re: PCIE: Program pcie device private registers
To: Pratyush Anand <pratyush.anand@st.com>
Cc: shiv prakash Agarwal <chhotu.shiv@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 3, 2014 at 8:59 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
> On Thu, Feb 27, 2014 at 05:12:38PM +0800, shiv prakash Agarwal wrote:
>>    Hi All,
>>
>>
>>
>>    One query:
>>
>>
>>
>>    We can program config space registers of a pcie device using setpci but
>>    how can we program private registers of a pcie device?
>
> You mean application specific registers?
> These registers will not be accessible through any generic user space program.
>
> If you want to access them for debug purposes then you can provide
> support in your driver.

If the registers are in config space, you can use setpci, even if they
are non-architected registers specific to the device.

If they are in MMIO space, you can use lspci to learn where the BARs
are mapped, and then use something like rdwrmem
(http://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c) to access the
registers.

If they are in I/O port space, you can again use lspci to learn where
they are mapped, and then use ioperm()/iopl()/inb()/outb()/etc.

Bjorn
