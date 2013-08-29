Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:42369 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606Ab3H2UL2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Aug 2013 16:11:28 -0400
Received: by mail-ie0-f177.google.com with SMTP id e14so1657995iej.36
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2013 13:11:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <001a01cea4b4$5754b200$05fe1600$%jun@samsung.com>
References: <001e01cea3e5$410cf6d0$c326e470$%jun@samsung.com>
 <20130828141417.139ad2b0@skate> <001a01cea4b4$5754b200$05fe1600$%jun@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 29 Aug 2013 14:11:07 -0600
Message-ID: <CAErSpo4xTdEi_rX5BOoG6qDQmbxsRrVO0c9G2oP+JADBSZVJew@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: mvebu: add wrapped I/O access functions
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 29, 2013 at 6:36 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> read/write operation for I/O mem is wrapped with hiding
> base address inside in order to simplify the usage.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

This depends on some mvebu changes that aren't in my tree.  If you
want me to apply it, please obtain an ack from Thomas and resend it
after v3.12-rc1.
