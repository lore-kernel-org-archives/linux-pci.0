Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:10667
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753201Ab3I0QsO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2013 12:48:14 -0400
Message-ID: <1380300453.24959.389.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with
 Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
CC: Minghuan Lian <Minghuan.Lian@freescale.com>,
	<linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Date: Fri, 27 Sep 2013 11:47:33 -0500
In-Reply-To: <52456C0C.2020504@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
	 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
	 <52456C0C.2020504@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-09-27 at 19:29 +0800, Lian Minghuan-b31939 wrote:
> Hi All,
> 
> Can anyone comment on my code or help to pick up?

Please break it up into multiple patches, each with one logical change
that is individually explained.  It will be much easier to review that
way.

-Scott



