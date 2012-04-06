Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42410 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab2DFSQo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Apr 2012 14:16:44 -0400
Received: by lbbgg6 with SMTP id gg6so816818lbb.19
        for <linux-pci@vger.kernel.org>; Fri, 06 Apr 2012 11:16:42 -0700 (PDT)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 6 Apr 2012 12:16:22 -0600
Message-ID: <CAErSpo5a3t9-HQN-8zvK+wYjW6eAM5nVuQcfKPsaU6Ur1BZCwQ@mail.gmail.com>
Subject: linux-next: change PCI trees
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Stephen,

Would you please replace these PCI trees in linux-next:

    pci-current     git
git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci#for-linus
    pci             git
git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci#linux-next

with these new ones:

    pci-current git
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git#for-linus
    pci git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git#next

since I'm taking over PCI maintenance.

Thanks,
  Bjorn
