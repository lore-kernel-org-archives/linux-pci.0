Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43179 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab2DKBmB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 21:42:01 -0400
Date: Tue, 10 Apr 2012 20:41:54 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: stable@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Paul Menzel <paulepanter@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] x86/PCI: do not tie MSI
 MS-7253 use_crs quirk to BIOS version
Message-ID: <20120411014154.GE11506@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
 <20120228213135.GA30986@burratino>
 <20120301105701.62ad4144@jbarnes-desktop>
 <20120302042523.GH5248@burratino>
 <20120409234755.GA7551@burratino>
 <20120410230049.GA6140@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120410230049.GA6140@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg Kroah-Hartman wrote:
> On Mon, Apr 09, 2012 at 06:47:55PM -0500, Jonathan Nieder wrote:

>> Please queue
>>
>>  84113717 (x86/PCI: use host bridge _CRS info on MSI MS-7253)
>>  a97f4f5e (x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS
>>            version)
>>
>> for maintained stable trees 2.6.34.y and newer.
>
> Applied to 3.0-stable and newer.

Thanks much.

Paul Gortmaker: FYI.  [1] has context.

Ciao,
Jonathan

[1] http://thread.gmane.org/gmane.linux.kernel.pci/13825/focus=14618
