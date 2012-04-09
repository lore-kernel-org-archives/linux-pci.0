Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47249 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab2DIXuI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 19:50:08 -0400
Date: Mon, 9 Apr 2012 18:50:04 -0500
From: Jonathan Nieder <jrnieder@gmail.com>
To: stable@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Paul Menzel <paulepanter@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] x86/PCI: do not tie MSI
 MS-7253 use_crs quirk to BIOS version
Message-ID: <20120409235003.GB7551@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
 <20120228213135.GA30986@burratino>
 <20120301105701.62ad4144@jbarnes-desktop>
 <20120302042523.GH5248@burratino>
 <20120409234755.GA7551@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120409234755.GA7551@burratino>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jonathan Nieder wrote:

> [Subject: [3.0.y, 3.2.y, 3.3.y] Re: [PATCH] x86/PCI: do not tie MSI
> MS-7253 use_crs quirk to BIOS version]

Since v3.3 already contains the patches, 3.3.y does not need this.
3.0.y and 3.2.y do, though.  Sorry for the nonsense.
