Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934627AbeFLW1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jun 2018 18:27:22 -0400
Date: Tue, 12 Jun 2018 17:27:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        shawn.lin@rock-chips.com
Subject: Re: [GIT PULL] PCI changes for v4.18, part 2
Message-ID: <20180612222718.GA96078@bhelgaas-glaptop.roam.corp.google.com>
References: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
 <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFyo-NmP_zkyjnMXxJEq-93ha4akLDpF8biiFQ-hhWnZmg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 12, 2018 at 03:08:53PM -0700, Linus Torvalds wrote:
> On Tue, Jun 12, 2018 at 2:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   - squash AER directory into drivers/pci/pcie/aer.c (Bjorn Helgaas)
> 
> Could we please see *reasons* for this series of commits?
> 
> Those commit messages have trivial "what", but no explanations "why".

Sure, I'll update that branch and send a new pull request.
