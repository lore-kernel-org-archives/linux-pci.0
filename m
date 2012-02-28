Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35188 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab2B1S4L (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2012 13:56:11 -0500
Received: by wejx9 with SMTP id x9so1192579wej.19
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2012 10:56:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 Feb 2012 11:55:49 -0700
Message-ID: <CAErSpo5FxTc63Cw_zWqcSON=6D7g=+yCpNpoJu1GYUV2GQ3WYw@mail.gmail.com>
Subject: Re: [PATCH] x86/PCI: use host bridge _CRS info on MSI MS-7253
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>, caralu74@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 28, 2012 at 11:51 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> From: Jonathan Nieder <jrnieder@gmail.com>
>
> In the spirit of commit 29cf7a30f8a0 ("x86/PCI: use host bridge _CRS
> info on ASUS M2V-MX SE"), this DMI quirk turns on "pci_use_crs" by
> default on a board that needs it.

Hi Jesse,

This patch is against upstream (891003abb0d), and I think it also
applies cleanly on your linux-next branch.  It fixes a regression and
shouldn't affect other machines, so you might consider it even for
3.3.  Otherwise it can go in the merge window.

Bjorn
