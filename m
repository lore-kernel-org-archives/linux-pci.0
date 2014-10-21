Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55950 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539AbaJUISe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Oct 2014 04:18:34 -0400
Message-ID: <1413879507.2751.1.camel@pengutronix.de>
Subject: Re: [PATCH v8]PCI: imx6: enable pcie on imx6sx sdb and imx6qdl
 sabreauto.
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com, m-karicheri2@ti.com
Date: Tue, 21 Oct 2014 10:18:27 +0200
In-Reply-To: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
References: <1413782724-30795-1-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 20.10.2014, 13:25 +0800 schrieb Richard Zhu:
> Main changes since the v6(v7 is ignored):
> 1. Regarding to Lucas' suggestion, assert per-reset in suspend,
> and de-assert it in resume.
> 2. Use pp->ops->get_msi_data in dw_pcie_msi_cfg_restore()
> if there is one get_msi_data pp ops callback, refer to Muali's comment.
> 3. In order to avoid the compilation, squash imx6 changes with patch2-5
> of v6, since the prototype of the host_init is changed.

No, this isn't what I wanted. This is completely separate change and
needs to be in one patch.

But to move this patchset forward without keeping those endless loops
back and forth between us both let's turn the thing around: I will take
most of your patches (namely the ones adding imx6sx support) and rework
them so they look good to me. I'll send them to you so you can test them
on your hardware and after that send them to the list for inclusion.

I'll leave out the purely DTS changes, as those are separate hardware
enablement patches, that don't strictly need to be in this series.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

