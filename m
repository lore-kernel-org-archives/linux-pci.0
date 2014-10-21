Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:51783 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933612AbaJUWk0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Oct 2014 18:40:26 -0400
Received: by mail-qg0-f41.google.com with SMTP id a108so1724620qge.28
        for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2014 15:40:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXs5wVsfK3ADVWoLVtsnfEmrV2ECj=rUR_=UptjrK1QWQJreA@mail.gmail.com>
References: <CAGXs5wVsfK3ADVWoLVtsnfEmrV2ECj=rUR_=UptjrK1QWQJreA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 21 Oct 2014 16:40:05 -0600
Message-ID: <CAErSpo4xHOMEZH0vTs_18OFVwrYG-ezijocdu0M2EjAbU7m9Fw@mail.gmail.com>
Subject: Re: Mailboxes userspace application communicating with a PCI driver
To: Kevin Wilson <wkevils@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 21, 2014 at 1:30 PM, Kevin Wilson <wkevils@gmail.com> wrote:
> Hi,
>
> Should all PCI devices support mailboxes ?

No, there's no requirement for a PCI device to support mailboxes.  The
spec only defines (via config space) a standard way to find out where
device registers live in the address space.  It doesn't say anything
about what sort of registers a device must implement.

> Is there some example of an opensource userspace application which
> communicates with a PCI driver by mailboxes?  (preferably a network
> device)

I don't know the answer to this one, sorry.

Bjorn
