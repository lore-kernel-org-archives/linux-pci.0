Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:50283 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcBORSR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Feb 2016 12:18:17 -0500
Date: Mon, 15 Feb 2016 09:17:57 -0800
From: Marc MERLIN <marc@merlins.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: 4.4.x kernel (only) gives pcieport 0000:00:1c.4: AER: Corrected error received: id=00e4
Message-ID: <20160215171757.GL4115@merlins.org>
References: <20160213215736.GA1002@merlins.org> <20160215171423.GA12641@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160215171423.GA12641@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 15, 2016 at 11:14:23AM -0600, Bjorn Helgaas wrote:
> 
> Short story: the AER driver receives the corrected error notification
> but fails to clear it.  Nobody has stepped up to fix the bug yet.  You
> can probably work around it by disabling AER completely by booting
> with "pci=noaer".
 
Thanks, that's good to know. I wanted to make sure I had some idea why
before turning it off :)

> I attached your dmesg log to
> https://bugzilla.kernel.org/show_bug.cgi?id=111601

I appreciate it, thanks.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
