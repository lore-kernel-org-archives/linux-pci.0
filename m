Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44181 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbaGTT0X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 15:26:23 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so6441301pdj.40
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 12:26:23 -0700 (PDT)
Date: Sun, 20 Jul 2014 12:26:49 -0700
From: Olof Johansson <olof@lixom.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arnd@linaro.org, arm@kernel.org,
	linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org, mohit.kumar@st.com,
	pratyush.anand@st.com
Subject: Re: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
Message-ID: <20140720192649.GA30124@quad.lixom.net>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 20, 2014 at 05:29:47PM +0530, Viresh Kumar wrote:
> Following compilation warning occurs when compiled with:
> CONFIG_DEBUG_SECTION_MISMATCH=y
> 
>  WARNING: drivers/pci/host/built-in.o(.data+0xc0): Section mismatch in
>  reference from the variable spear13xx_pcie_driver to the function
>  .init.text:spear13xx_pcie_probe()
> 
> Both .probe() and pcie_init() are marked with __init, but spear13xx_pcie_driver
> isn't. And so section mismatch.
> 
> Fix it by marking spear13xx_pcie_driver with __initdata.
> 
> Fixes: 51b66a6 (PCI: spear: Add PCIe driver for ST Microelectronics SPEAr13xx)

Please use 12 significant digits, since 7 might not be sufficient later
on in time. I've fixed it up here.

> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Olof/Arnd,
> 
> Let me know if a PULL request is required for this, otherwise just apply them
> directly.

I've applied both of these on top of next/drivers, where your previous branch
was. No need for a pull request.


-Olof
