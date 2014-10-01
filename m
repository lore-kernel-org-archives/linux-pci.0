Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36268 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaJAE2j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Oct 2014 00:28:39 -0400
Date: Wed, 1 Oct 2014 09:58:15 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] Designware MSI fixes
Message-ID: <20141001042815.GA24581@pratyush-vbox>
References: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1412094987-1894-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 01, 2014 at 12:36:25AM +0800, Lucas Stach wrote:
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

Looks cleaner to me.
Reviewed-by: Pratyush Anand <pratyush.anand@st.com>

>  drivers/pci/host/pcie-designware.c | 98 ++++++--------------------------------
>  1 file changed, 14 insertions(+), 84 deletions(-)
> 
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
