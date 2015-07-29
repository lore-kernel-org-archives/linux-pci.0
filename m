Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:32973 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbG2UK3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 16:10:29 -0400
Received: by laah7 with SMTP id h7so13012459laa.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 13:10:28 -0700 (PDT)
Date: Wed, 29 Jul 2015 22:10:14 +0200
From: Olof Johansson <olof@lixom.net>
To: Ray Jui <rjui@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, arm@kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: iproc: Fix BCMA dependency in Kconfig
Message-ID: <20150729201014.GA28206@localhost>
References: <1438189973-5712-1-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438189973-5712-1-git-send-email-rjui@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 10:12:53AM -0700, Ray Jui wrote:
> The current iProc BCMA front-end driver can only work on ARM32 based
> platforms; therefore its config option in Kconfig should be changed to
> reflect that. This fixes arm64 allmodconfig build failure when compiling
> the the iProc BCMA driver that contains struct pci_sys_data that is
> arm32 specific
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>

Applied to next/arm64 together with the original series.


-Olof
