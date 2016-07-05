Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35726 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbcGEPxJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2016 11:53:09 -0400
Date: Tue, 5 Jul 2016 10:53:06 -0500
From: Rob Herring <robh@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/22] sh: Add PCI host bridge driver for SH7751
Message-ID: <20160705155306.GA7857@rob-hp-laptop>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
 <1467564402-2649-13-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467564402-2649-13-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 04, 2016 at 01:46:32AM +0900, Yoshinori Sato wrote:
> This is an alternative SH7751 PCI driver.
> Existing driver (arch/sh/drivers/pci/pci-sh7751) uses SH specific interface.
> But this driver uses common PCI interface. It is more modern and generic.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../devicetree/bindings/pci/sh7751-pci.txt         |  37 +++

Please add acks when posting new versions.

>  arch/sh/boards/Kconfig                             |   1 +
>  arch/sh/drivers/Makefile                           |   2 +
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-sh7751.c                      | 327 +++++++++++++++++++++
>  6 files changed, 375 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sh7751-pci.txt
>  create mode 100644 drivers/pci/host/pci-sh7751.c
