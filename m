Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:54662 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932582Ab3LIUnz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 15:43:55 -0500
Received: by mail-qa0-f52.google.com with SMTP id cm18so1377372qab.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 12:43:54 -0800 (PST)
Date: Mon, 9 Dec 2013 13:43:49 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: =?iso-8859-1?Q?Bj=F8rn?= Erik Nilsen <ben@datarespons.no>
Cc: jg1.han@samsung.com, marex@denx.de, pratyush.anand@gmail.com,
	linux-pci@vger.kernel.org, kishon@ti.com, Mohit.KUMAR@st.com,
	ajay.khandelwal@st.com, tharvey@gateworks.com,
	Eric.Nelson@boundarydevices.com, troy.kisky@boundarydevices.com
Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
Message-ID: <20131209204349.GA2135@google.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1385732125-28630-1-git-send-email-ben@datarespons.no>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 29, 2013 at 02:35:23PM +0100, Bjørn Erik Nilsen wrote:
> This patchset address Marek Vasut's comments on the previous
> patches. I decided to split into two separate commits as they are
> unrelated.
> 
> Bjørn Erik Nilsen (2):
>   PCI: designware: Fix crash in dw_msi_teardown_irq
>   PCI: designware: Remove redundant call to pci_write_config

Hi Bjørn,

There's been a fair amount of discussion about the first patch, so I'm
ignoring these for now.  Please repost these (again) when that all settles
down.

Bjorn
