Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:34743 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3ICQYS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2013 12:24:18 -0400
Date: Tue, 3 Sep 2013 12:24:11 -0400
From: Tejun Heo <tj@kernel.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jan Beulich <JBeulich@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] AHCI: Conserve interrupts with
 pci_enable_msi_block_part() interface
Message-ID: <20130903162411.GA25040@mtj.dyndns.org>
References: <cover.1378111919.git.agordeev@redhat.com>
 <20130903135541.GB10522@htj.dyndns.org>
 <20130903145719.GB14221@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130903145719.GB14221@dhcp-26-207.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, Sep 03, 2013 at 04:57:19PM +0200, Alexander Gordeev wrote:
> Multiple MSI support enables threaded IRQ handling, because at the time of
> posting I did not want to intrude into the existing single-MSI codebase while
> multiple MSI/multipe CPU approach gained good numbers (below).

Please separate out threaded IRQ support from multiple MSI.

> Besides, the ports interrupt handling moved from the interrupt-disabled
> hardware context to the interrupt-enabled threaded context and also ports
> got per-port locks instead of the single host lock. AFAIR I did not post
> the numbers, but it was something close to no-contention.

Which is a completely separate issue, right?  Let's please not mix the
two.

Thanks.

-- 
tejun
