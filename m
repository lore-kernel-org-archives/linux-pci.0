Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39343 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab3JaRLE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2013 13:11:04 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so5664178iec.29
        for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2013 10:11:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131031164810.GA26426@obsidianresearch.com>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131031101357.5a56e2d0@skate> <20131031164810.GA26426@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 31 Oct 2013 11:10:42 -0600
Message-ID: <CAErSpo7bUP63J5RkXr-DkQE8qmvKT7ri-vjkfq+TtGEaYWxSwA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 31, 2013 at 10:48 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:

> Indeed.. I was having problems here because linux was writing 0,0
> during discovery to the base,limit registers to 'disable' the IO
> window, which triggered a window allocation. So I re-read the PCI
> bridge spec (apparently too quickly) and decided 0,0 was OK, and it
> should be <=.
>
> However, looking again at the spec - it is very clear, < is the
> correct test, and when the values is equal a 4k window should be
> created.
>
> So, I wonder if there is a little bug in the Linux discovery code
> path, should it write FFFF,0 instead?

Sounds like a bug to me.  Do you want to fix it, or point me at it the
place where we write 0,0 so I can fix it?

Bjorn
