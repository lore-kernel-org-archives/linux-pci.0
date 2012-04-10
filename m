Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55367 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab2DJAob (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2012 20:44:31 -0400
Received: by lbbgg6 with SMTP id gg6so2344282lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 09 Apr 2012 17:44:29 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Apr 2012 18:44:09 -0600
Message-ID: <CAErSpo7PanjK2oemhGhoFJEkd47tJDgkK0LxK8k2Zc0Kz_ee8Q@mail.gmail.com>
Subject: PCI maintenance details
To: linux-pci@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi everyone,

As you've probably noticed, I'm taking over maintenance of the PCI subsystem
from Jesse.  I don't plan any radical changes, so hopefully this is just
"business as usual" for most of you.

GIT TREE

    I have a git tree (currently empty) here:

        git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=summary

    and I plan to operate it the usual way, with a "next" branch for
    integration via the linux-next tree and a "for-linus" branch for urgent
    fixes outside the merge window.

PATCHWORK

    Since the kernel.org patchwork instance is still defunct, Jeremy Kerr has
    kindly set up a new one at ozlabs:

        http://patchwork.ozlabs.org/project/linux-pci/list/

    If your patches are not in my "next" branch and not in the patchwork, I
    probably missed them, so please resend them.

BUG REPORTING

    Please post bug reports, patches, and questions on the
    linux-pci@vger.kernel.org mailing list as usual.

    I might be the only person left who uses bugzilla, but I do like it for
    keeping track of things.  My ideal bug report would be a report opened
    in bugzilla ("PCI" component in the "Drivers" product):

        https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers&component=PCI

    and then also reported on the mailing list with the bugzilla URL.  If you
    post a patch to fix an issue, please include a URL to the bugzilla or
    another report of the issue in the changelog.

Bjorn
