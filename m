Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:37180 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3LNS7y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 14 Dec 2013 13:59:54 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so4461586iec.23
        for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2013 10:59:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5+3Zy+YkgDS_1bJ7B84w5iHOh6-QG7LRJXo2WQHREcRHw@mail.gmail.com>
References: <CAHH3p5+3Zy+YkgDS_1bJ7B84w5iHOh6-QG7LRJXo2WQHREcRHw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 14 Dec 2013 11:59:34 -0700
Message-ID: <CAErSpo59htYoPBoouUfSXAVXwCUQPK-TB_zG0BkE-PLhV=KRbQ@mail.gmail.com>
Subject: Re: Memory mapping of config space of pcie devices
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 14, 2013 at 11:32 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> How devices config spaces are mapped to host memory?
> Is it being handled by core driver? I could not locate.

The PCI core does not map config space into memory.  That's not even
possible for the legacy config access methods, e.g., using I/O ports
0xcf8 and 0xcfc [1].

If you're wondering about how Linux uses ECAM, that's mostly in
arch/x86/pci/mmconfig*.  That code does ioremap the ECAM area into
kernel virtual space, but only for access via pci_read_config_word(),
pci_write_config_word(), etc.

Bjorn

[1] http://en.wikipedia.org/wiki/PCI_configuration_space#Software_implementation
