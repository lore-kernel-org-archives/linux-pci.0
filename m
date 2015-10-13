Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54785 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbbJMR6b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 13 Oct 2015 13:58:31 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 21AF320805
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2015 17:58:30 +0000 (UTC)
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com [209.85.212.182])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 095C6207FC
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2015 17:58:28 +0000 (UTC)
Received: by wicgb1 with SMTP id gb1so199240541wic.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2015 10:58:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442363962-29805-8-git-send-email-rjui@broadcom.com>
References: <1442363962-29805-1-git-send-email-rjui@broadcom.com>
	<1442363962-29805-8-git-send-email-rjui@broadcom.com>
Date: Tue, 13 Oct 2015 10:58:26 -0700
Message-ID: <CAMAWPa_Hsuv+skzt3S6e9X_kWY=2JXAScbVEVOVTGmn81_bcFw@mail.gmail.com>
Subject: Re: [PATCH 7/8] PCI: iproc: Add outbound mapping support
From: Kevin Hilman <khilman@kernel.org>
To: Ray Jui <rjui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Tyler Baker <tyler.baker@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 15, 2015 at 5:39 PM, Ray Jui <rjui@broadcom.com> wrote:
> Certain iProc SoCs require the PCIe outbound mapping to be configured in
> SW. This patch adds support for those chips
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>

kernelci.org bot found a new build failure in linux-next[1] and it was
bisected down to this patch, which landed in linux-next in the form of
90e4032eeaf2 PCI: iproc: Add outbound mapping support.

The build fails on arm[1] with multi_v7_defconfig and CONFIG_ARM_LPAE=y with:

drivers/built-in.o: In function `iproc_pcie_setup':
:(.text+0x6d874): undefined reference to `__aeabi_uldivmod'

Kevin

[1] http://storage.kernelci.org/next/next-20151013/arm-multi_v7_defconfig+CONFIG_ARM_LPAE=y/build.log
