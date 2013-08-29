Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:48150 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab3H2UKI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 16:10:08 -0400
Received: by mail-ie0-f179.google.com with SMTP id m16so1415649ieq.38
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2013 13:10:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001901cea4b4$4e9db530$ebd91f90$%jun@samsung.com>
References: <001d01cea3e5$3a07c8b0$ae175a10$%jun@samsung.com>
 <000f01cea48e$f5fc3160$e1f49420$%han@samsung.com> <001901cea4b4$4e9db530$ebd91f90$%jun@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 29 Aug 2013 14:09:47 -0600
Message-ID: <CAErSpo61si6nOKCCgO4hXAf=abMia5QupfBch5=KDXMr5f03QQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: exynos: add wrapped I/O access functions
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 29, 2013 at 6:35 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> read/write operation for I/O mem is wrapped with hiding
> base address inside in order to simplify the usage.
> [elbi_base, phy_base, block_base]
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>

Applied to pci/misc for v3.12, thanks.
