Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51382 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab2DIXsF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 19:48:05 -0400
Date: Mon, 9 Apr 2012 18:47:55 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
To: stable@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Paul Menzel <paulepanter@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] x86/PCI: do not tie MSI MS-7253
 use_crs quirk to BIOS version
Message-ID: <20120409234755.GA7551@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
 <20120228213135.GA30986@burratino>
 <20120301105701.62ad4144@jbarnes-desktop>
 <20120302042523.GH5248@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120302042523.GH5248@burratino>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

Jonathan Nieder wrote:
> Jesse Barnes wrote:

>> Applied to my for-linus branch, thanks.
>
> Thanks for taking care of it.  I'll look into submitting these to
> -stable once they hit mainline if I notice.

Please queue

 84113717 (x86/PCI: use host bridge _CRS info on MSI MS-7253)
 a97f4f5e (x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS
           version)

for maintained stable trees 2.6.34.y and newer.

Those two patches address a regression that bisects to
v2.6.34-rc1~218^2~26 (x86/pci: AMD one chain system to use pci read
out res, 2010-02-10) and on the affected machines (Microstar MSI
MS-7253) results in misconfiguration and instability --- some example
symptoms were audio being silenced and crashes at boot time.  They
work by automatically enabling the pci=use_crs parameter so the kernel
can pay attention to information in ACPI tables that can save it from
trouble.

The patch was applied to mainline during the 3.3 merge window.

https://bugzilla.kernel.org/show_bug.cgi?id=42619 has details.
Thanks to Svante Signell and Carlos Luna for reporting it and Bjorn
Helgas and Paul Menzel for tracking it down.

Jonathan
