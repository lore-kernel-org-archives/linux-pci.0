Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:47357 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab3LNUFe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Dec 2013 15:05:34 -0500
Received: by mail-ob0-f179.google.com with SMTP id wm4so3333083obc.24
        for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2013 12:05:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo59htYoPBoouUfSXAVXwCUQPK-TB_zG0BkE-PLhV=KRbQ@mail.gmail.com>
References: <CAHH3p5+3Zy+YkgDS_1bJ7B84w5iHOh6-QG7LRJXo2WQHREcRHw@mail.gmail.com>
	<CAErSpo59htYoPBoouUfSXAVXwCUQPK-TB_zG0BkE-PLhV=KRbQ@mail.gmail.com>
Date: Sun, 15 Dec 2013 01:35:33 +0530
Message-ID: <CAHH3p5J7Se8zu64MfoSDkAN_NtOp=qv1DcvWBAa8jWKouo0TXg@mail.gmail.com>
Subject: Re: Memory mapping of config space of pcie devices
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 15, 2013 at 12:29 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Sat, Dec 14, 2013 at 11:32 AM, shiv prakash Agarwal
> <chhotu.shiv@gmail.com> wrote:
>> Hi All,
>>
>> How devices config spaces are mapped to host memory?
>> Is it being handled by core driver? I could not locate.
>
> The PCI core does not map config space into memory.  That's not even
> possible for the legacy config access methods, e.g., using I/O ports
> 0xcf8 and 0xcfc [1].
>
> If you're wondering about how Linux uses ECAM, that's mostly in
> arch/x86/pci/mmconfig*.  That code does ioremap the ECAM area into
> kernel virtual space, but only for access via pci_read_config_word(),
> pci_write_config_word(), etc.
>
> Bjorn
>
> [1] http://en.wikipedia.org/wiki/PCI_configuration_space#Software_implementation

Thanks Bjorn for quick reply,

Above reference says:
During system initialization, firmware determines the base address for
this “stolen” address region and communicates it to the root complex
and to the operating system. This communication method is
implementation-specific, and not defined in the PCI Express
specification.

How above is implemented on ARM?
