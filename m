Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33246 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbbF2Wor (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 18:44:47 -0400
Received: by wgck11 with SMTP id k11so153067157wgc.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2015 15:44:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXs5wWjokgKYdbj3mrXv_Bo_6jcGvGAW5S2Apg84DVanHzFEg@mail.gmail.com>
References: <CAGXs5wWjokgKYdbj3mrXv_Bo_6jcGvGAW5S2Apg84DVanHzFEg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 29 Jun 2015 17:44:26 -0500
Message-ID: <CAErSpo58Jacvm5WHUyTCZpX9WpPEA-hvRdi9XHja8wpPYvG+yw@mail.gmail.com>
Subject: Re: Patches to linux-pci - against which git tree?
To: Kevin Wilson <wkevils@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Kevin,

On Mon, Jun 29, 2015 at 4:03 PM, Kevin Wilson <wkevils@gmail.com> wrote:
> Hello,
> Against which git tree are patches which are sent to this mailing list
> (linux-pci) being prepared?

When I apply PCI patches, I put them on topic branches based on -rc1
or -rc2 of Linus' tree.  Then I merge those branches into my "next"
branch, which is what gets pulled into the linux-next tree.  The
"next" branch is what eventually gets merged into Linus' tree during a
merge window.

You can see my tree at
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/?h=next

Right now, we're in the middle of the v4.2 merge window, so my
"master" branch is still at v4.1-rc2.  I applied all the PCI patches
intended for v4.2 on branches based on v4.1-rc2.

After v4.2-rc1 is tagged, I'll advance my "master" branch to that, and
I'll start applying patches intended for v4.3.

Bjorn
