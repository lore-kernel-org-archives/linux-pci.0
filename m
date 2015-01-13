Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35750 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752542AbbAMOr2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jan 2015 09:47:28 -0500
Message-ID: <54B52EFF.3070505@st.com>
Date: Tue, 13 Jan 2015 15:43:11 +0100
From: Maxime Coquelin <maxime.coquelin@st.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, Srikanth Thokala <sthokal@xilinx.com>
Subject: Re: [PATCH] PCI: xilinx: fix harmless format string warning
References: <1759235.dcJCuiggea@wuerfel>
In-Reply-To: <1759235.dcJCuiggea@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 01/13/2015 03:20 PM, Arnd Bergmann wrote:
> The xilinx pcie driver prints a register value whose type is
> propagated to the type returned by the GENMASK() macro.
> Unfortunately, that type has recently changed as the result
> of a bug fix, so now we get a warning about the type:
>
> drivers/pci/host/pcie-xilinx.c: In function 'xilinx_pcie_clear_err_interrupts':
> drivers/pci/host/pcie-xilinx.c:154:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
>
> This changes the code so we always print the number as an
> 'unsigned long' type to avoid the warning. The original code
> was fine on 32-bit architectures but not on 64-bit. Now it
> works as expected on both.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 00b4d9a1412 ("bitops: Fix shift overflow in GENMASK macros")
>
>

You can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
