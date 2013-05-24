Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34865 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007Ab3EXQer (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2013 12:34:47 -0400
Received: by mail-ie0-f171.google.com with SMTP id e10so35381iej.16
        for <linux-pci@vger.kernel.org>; Fri, 24 May 2013 09:34:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo40LBfJGHfGiveE-czMgbF=qqziySCPgPAAJT3BYBS__A@mail.gmail.com>
References: <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<518786a7.64bbec0a.58a0.1f6bSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAErSpo5MJCoaof=heFM4vLxuWz8pFqsyXAC356jZ7rbRvSOt9g@mail.gmail.com>
	<CAE9FiQWsZXfkSSVFzee4-J4bUDP8DdG=y9-k2du+ek90StDvNA@mail.gmail.com>
	<CAE9FiQXw=Q9hDWMS3kx8=G0eSqo2keKh-VP3=LWZ31PfXmrAmg@mail.gmail.com>
	<519dcfbe.89e9420a.4934.488bSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQW==Zvwv976-xjtRFj70JWoZW94yQyM0NMTvMpR-yDG9Q@mail.gmail.com>
	<CAErSpo5ASyYvRJgA3TDt7A5xtxL0sqopfAxbnJwDL=z_2hDJag@mail.gmail.com>
	<CAE9FiQX8o97RY-Bd9t1vj+gm_Uri0v_hAUwecaNoF2GwGGTNyA@mail.gmail.com>
	<CAErSpo5vY-DY9_bLWbM5UNrSZdO5dyASx1hLGMQg-ypgZHXLLg@mail.gmail.com>
	<CAE9FiQWyEhdQGjC+hiGxOHdHwZoajfwfcgp26wivqL0s62NPkA@mail.gmail.com>
	<1369344196.3870.35.camel@pasglop>
	<CAE9FiQUS9rUfhH=J5pgynO6Xhrnn8Rx4pHeZ=p0dHm0fUoHd3A@mail.gmail.com>
	<CAErSpo40LBfJGHfGiveE-czMgbF=qqziySCPgPAAJT3BYBS__A@mail.gmail.com>
Date: Fri, 24 May 2013 09:34:47 -0700
Message-ID: <CAE9FiQVu7JkTOQdsTPO5Y=rnkx+Xvjr6vgirx+F0xAWLVTAAyw@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 24, 2013 at 8:59 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 23, 2013 at 4:16 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> That should not happen, because the only reason we're reassigning is
> for IO space, and we shouldn't be touching the MEM assignments.  I
> agree that we should fix that.

yes, that is

https://patchwork.kernel.org/patch/2608461/

>
> I do not agree that your current patches are the right way to fix
> this.  You are trying to make a relatively small patch that we can
> wedge into v3.10 in a hurry.  I would prefer that we work out a
> cleaner solution that simplifies reassignment, *then* figure out the
> best way to backport it as needed.

ok, we can leave per root bus method to v3.11.

we can put only one patch in v3.10.

https://patchwork.kernel.org/patch/2608461/
PCI: Don't let mmio fallback to must-only, if ioport fails with must+optional

that should fix the problem that Ben and Shan met.

Thanks

Yinghai
