Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33450 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2CBEZ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2012 23:25:29 -0500
Received: by iagz16 with SMTP id z16so1781185iag.19
        for <linux-pci@vger.kernel.org>; Thu, 01 Mar 2012 20:25:29 -0800 (PST)
Date: Thu, 1 Mar 2012 22:25:23 -0600
From: Jonathan Nieder <jrnieder@gmail.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Svante Signell <svante.signell@telia.com>,
	Carlos Luna <caralu74@gmail.com>
Subject: Re: [PATCH] x86/PCI: do not tie MSI MS-7253 use_crs quirk to BIOS
 version
Message-ID: <20120302042523.GH5248@burratino>
References: <20120228185110.16227.58753.stgit@bhelgaas.mtv.corp.google.com>
 <20120228213135.GA30986@burratino>
 <20120301105701.62ad4144@jbarnes-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120301105701.62ad4144@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and Jesse,

Jesse Barnes wrote:

> Applied to my for-linus branch, thanks.

Thanks for taking care of it.  I'll look into submitting these to
-stable once they hit mainline if I notice.
