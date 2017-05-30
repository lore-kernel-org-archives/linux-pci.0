Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdE3V3w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 May 2017 17:29:52 -0400
Date: Tue, 30 May 2017 16:29:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Carlo Pisani <carlojpisani@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: PowerPC405 DHT-Walnut, PCI_IO problems
Message-ID: <20170530212950.GC14896@bhelgaas-glaptop.roam.corp.google.com>
References: <CA+QBN9ANaDgcTDVeMA45m7gkH65x2OMBaa4y_xg5t4KX7WavZw@mail.gmail.com>
 <20170530174143.GA27080@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170530174143.GA27080@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 30, 2017 at 12:41:43PM -0500, Bjorn Helgaas wrote:
> ...
> Could you open a report at http://bugzilla.kernel.org, component
> drivers/PCI, and attach the following to it?
> 
>   - complete dmesg log from 2.6.22 and 4.11
>   - complete "lspci -vvxxx" output from 4.11
>   - /proc/ioports contents from 4.11

Bug report at https://bugzilla.kernel.org/show_bug.cgi?id=195933
