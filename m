Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36986 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbcFOIPh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2016 04:15:37 -0400
Date: Wed, 15 Jun 2016 10:15:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] x86/platform/intel-mid: Add Power Management Unit
 driver
Message-ID: <20160615081532.GB16023@gmail.com>
References: <1465928985-12113-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465928985-12113-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Add Power Management Unit driver to handle power states of South Complex
> devices on Intel Tangier. In the future it might be expanded to cover North
> Complex devices as well.
> 
> With this driver the power state of the host controllers such as SPI, I2C,
> UART, eMMC, and DMA would be managed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> In v2:
> - rename *pmu* to *pwr*
> - fix indentation to be consistent for definitions
> - add comments to explain what driver does
> - refactor quirks in intel_mid_pci.c
> 
>  arch/x86/include/asm/intel-mid.h     |   8 +
>  arch/x86/pci/intel_mid_pci.c         |  40 +++-
>  arch/x86/platform/intel-mid/Makefile |   2 +-
>  arch/x86/platform/intel-mid/pwr.c    | 416 +++++++++++++++++++++++++++++++++++
>  drivers/pci/Makefile                 |   3 +
>  drivers/pci/pci-mid.c                |  77 +++++++
>  6 files changed, 540 insertions(+), 6 deletions(-)
>  create mode 100644 arch/x86/platform/intel-mid/pwr.c
>  create mode 100644 drivers/pci/pci-mid.c

I've applied this to tip:x86/platform. I changed references to 'PMU' to 'PWRMU' - 
let me know if you'd like to use some other abbreviation.

Please send the clean-up patch on top of this. (Feel free to squash the one I sent 
into yours.)

Thanks,

	Ingo
