Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56863 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2JBEZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 00:25:26 -0400
Received: by ieak13 with SMTP id k13so13864480iea.19
        for <linux-pci@vger.kernel.org>; Mon, 01 Oct 2012 21:25:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <loom.20121002T002058-318@post.gmane.org>
References: <loom.20121002T002058-318@post.gmane.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 1 Oct 2012 22:25:05 -0600
Message-ID: <CAErSpo7q4tYwCHnMjovyDVXdCpGrWkqmO5u=1yAAhh7XBL_ASA@mail.gmail.com>
Subject: Re: pci_request_regions()
To: Paolo <paolopiace@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 1, 2012 at 4:28 PM, Paolo <paolopiace@gmail.com> wrote:
> I cannot locate pci_request_regions()
>
> Where can I find it?
>
> I am working with kernel 2.6.32.
>
> Supposedly, it should be in drivers/pci/pci.c but there is nothing like that.

In 2.6.32, the function pci_request_regions() is in the file
drivers/pci/pci.c.  It's still there in the current kernel (v3.6).

The stuff below looks like a directory hierarchy, not information
about the *contents* of the files.

> There, I see:
> .
> ├── hotplug
> │   ├── Kconfig
> │   └── Makefile
> ├── Kconfig
> ├── Makefile
> └── pcie
>     ├── aer
>     │   ├── Kconfig
>     │   ├── Kconfig.debug
>     │   └── Makefile
>     ├── Kconfig
>     └── Makefile
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
