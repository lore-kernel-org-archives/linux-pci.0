Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:51859 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaB0SnB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 13:43:01 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v2 4/4] pci: Add support for creating a generic host_bridge from device tree
Date: Thu, 27 Feb 2014 19:42:52 +0100
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1393506402-11474-1-git-send-email-Liviu.Dudau@arm.com> <5679503.gWR3MVnuZs@wuerfel> <20140227165449.GR1692@e106497-lin.cambridge.arm.com>
In-Reply-To: <20140227165449.GR1692@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201402271942.52764.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 February 2014, Liviu Dudau wrote:
> There are examples of other host controllers doing similar things. pci-tegra.c does it in
> tegra_pcie_setup_translations(), pcie-designware.c has dw_pcie_prog_viewport_*() functions.
> 
> I'm afraid for the moment the bootloader on my platform is not going to be of too much use on
> this, so it will have to be initially in Linux.

Ah, too bad. I know that we always do it wrong on arm32, I was hoping for a fresh
start on arm64 to fix this particular issue.

	Arnd
