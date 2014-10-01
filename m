Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33450 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaJASmF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Oct 2014 14:42:05 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so778394igc.6
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2014 11:42:04 -0700 (PDT)
Date: Wed, 1 Oct 2014 12:42:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Mohit Kumar <mohit.kumar@st.com>, Jingoo Han <jg1.han@samsung.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Designware MSI fixes
Message-ID: <20141001184202.GB22713@google.com>
References: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 30, 2014 at 06:36:25PM +0200, Lucas Stach wrote:
> Those two patches were part of my designware multi-msi series. I decided
> to postpone that one a little bit until the treewide MSI chip patches from
> Yijing Wang have landed, but those two patches are just too obvious
> fixes/style corrections to let them wait any longer.
> 
> Both patches were tested by Jingoo Han as part of the earlier series, but
> I had to modify them a bit for the rebase, so any review/testing much
> appreciated. Patches are on top of the pci/host-designware branch.
> 
> Lucas Stach (2):
>   PCI: designware: remove bogus multiple MSI setup
>   PCI: designware: remove open-coded bitmap operations
> 
>  drivers/pci/host/pcie-designware.c | 98 ++++++--------------------------------
>  1 file changed, 14 insertions(+), 84 deletions(-)

Applied to pci/host-designware for v3.18, with Pratyush's reviewed-by and
Jingoo's ack.  Thanks!
