Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F9C433FE
	for <linux-pci@archiver.kernel.org>; Fri,  4 Dec 2020 18:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3A122B4E
	for <linux-pci@archiver.kernel.org>; Fri,  4 Dec 2020 18:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgLDSWB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:22:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgLDSWB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 13:22:01 -0500
Date:   Fri, 4 Dec 2020 12:21:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607106080;
        bh=cZFPzlHJbvuqT1IggsL+1KT9IMXHxDS/MVaBMDyNjeY=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=YcfViyM93Q9keCM8ix789WAmuzfqqdPuZupGKrCrKWU+qg1wYJX7wT9wWWAk+b4cw
         wIna5EiyB0BfQIq3yobvz9sR0zymfylurVd3onOCD3uaMCKZ9DNwDl1BbpHXyp5MUJ
         ctnvBDXqexqy07O+SkSC43U2ijtLXQ5AGCfaFI6qw9GRs2ONGKOLoQtn0T7eX0Lv/Q
         Ut33VscZOPhuX1hH8GagEoPa9Y6VNQ9JwKtVyGm8Th/LxBgzVVYH2ojPYYbaws+HfT
         gR7uROORpbH8oBLRi1aj0oLEmsI6gA5QjWvpgt6IfEIxhIONYxqOc4/EL7LkcrpmOn
         s+zaAE+CSHWMw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] PCI/MSI: Cleanup init and improve 32-bit MSI
 checking
Message-ID: <20201204182118.GA1929556@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203185110.1583077-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 12:51:07PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> MSI/MSI-X init was a little unconventional.  We had pci_msi_setup_pci_dev()
> to disable MSI and MSI-X, in probe.c instead of msi.c so we could do it
> even without CONFIG_PCI_MSI.  Move that to msi.c and fix the config issue
> with an #ifdef.
> 
> Then add Vidya's patch on top.  Previous postings at
> 
> https://lore.kernel.org/linux-pci/20201117145728.4516-1-vidyas@nvidia.com/
> https://lore.kernel.org/linux-pci/20201124105035.24573-1-vidyas@nvidia.com/
> 
> Bjorn Helgaas (2):
>   PCI/MSI: Move MSI/MSI-X init to msi.c
>   PCI/MSI: Move MSI/MSI-X flags updaters to msi.c
> 
> Vidya Sagar (1):
>   PCI/MSI: Set device flag indicating only 32-bit MSI support
> 
>  drivers/pci/Makefile |  3 +-
>  drivers/pci/msi.c    | 70 ++++++++++++++++++++++++++++++++++++++++----
>  drivers/pci/pci.h    | 23 ++-------------
>  drivers/pci/probe.c  | 21 ++-----------
>  4 files changed, 70 insertions(+), 47 deletions(-)

I fixed my typo ("#ifdef CONFIG_MSI" when it should have been
"#ifdef CONFIG_PCI_MSI"), added the reference from Vidya, added
Thierry's Reviewed-by, and put these on pci/msi for v5.11.
