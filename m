Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42775 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab3H2UJa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 16:09:30 -0400
Received: by mail-ie0-f173.google.com with SMTP id qa5so1411046ieb.18
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2013 13:09:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001c01cea3e5$37716660$a6543320$%jun@samsung.com>
References: <001c01cea3e5$37716660$a6543320$%jun@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 29 Aug 2013 14:09:09 -0600
Message-ID: <CAErSpo6E0-BGx33fDwsi4QyOHCX3cfAPiNnM2sK-_Jcv9FNpGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: dw_pcie: amend I/O access functions
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Surendranath Gurivireddy Balla <suren.reddy@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 28, 2013 at 5:53 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This changes puts the 'dbi_base' into dw_pcie_readl_rc/
> dw_pcie_writel_rc. So usage of these funcions doesn't
> need to consider I/O base adddress anymore.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Applied to pci/misc for v3.12, thanks!
