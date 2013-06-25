Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58363 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab3FYS5E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 14:57:04 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so29069382iea.31
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 11:57:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130625172608.GA11914@google.com>
References: <20130625172608.GA11914@google.com>
Date: Tue, 25 Jun 2013 11:57:03 -0700
Message-ID: <CAE9FiQVN+iLTV0u0vsJMQyeeRg=oSudcn5EnKWAFSzD+-Uohfw@mail.gmail.com>
Subject: Re: Changes for v3.11 merge window
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 10:26 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Below are the patches currently in my "next" branch, planned for
> release in v3.11.  If I'm missing something important, let me know.

can you put this one in ?
https://patchwork.kernel.org/patch/2647131/

[v5,1/7] PCI: Don't let mmio fallback to must-only, if ioport fails
with must+optional


it will not just help powerpc case.
also found that it is needed for one of 8 socket system that support pciehp
but some root bus does not have ioport range allocated.
in that case sriov does not work.

Thanks

Yinghai
