Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:45993 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab2HWH2Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Aug 2012 03:28:25 -0400
Received: by wgbfm10 with SMTP id fm10so392505wgb.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2012 00:28:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120709182018.18165.98339.stgit@bhelgaas.mtv.corp.google.com>
References: <20120709181745.18165.93914.stgit@bhelgaas.mtv.corp.google.com>
	<20120709182018.18165.98339.stgit@bhelgaas.mtv.corp.google.com>
Date: Thu, 23 Aug 2012 00:28:23 -0700
Message-ID: <CAOesGMgUGUG9Z=x6ssumVkAxN6fHoeyAJ3-P8CoaNTGas7-vmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: leave MEM and IO decoding disabled during 64-bit
 BAR sizing, too
From: Olof Johansson <olof@lixom.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>,
	Robert Hancock <hancockrwd@gmail.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Mon, Jul 9, 2012 at 11:20 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> After 253d2e5498, we disable MEM and IO decoding for most devices while we
> size 32-bit BARs.  However, we restore the original COMMAND register before
> we size the upper 32 bits of 64-bit BARs, so we can still cause a conflict.
>
> This patch waits to restore the original COMMAND register until we're
> completely finished sizing the BAR.
>
> Reference: https://lkml.org/lkml/2007/8/25/154
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This patch causes boot lockup on PA Semi hardware, since it disables
the bar on the UART that is used for console, and it has printks
between the old and the new re-enable location. If I boot with 'debug'
level for printk, I hit this. If I boot with just regular console
args, I don't.

I'm guessing any other platform that uses MMIO-based UART on PCI for
console will have similar issues. I can verify on Chrome OS x86
hardware tomorrow if legacy powerpc isn't important enough to care
about. :-)

I have no proposal for a fix for this. Can you please consider
reverting for 3.6 unless someone has a better idea?


-Olof
