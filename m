Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37311 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbcFOJ5w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jun 2016 05:57:52 -0400
Message-ID: <1465984750.30123.115.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/1] x86/platform/intel-mid: Add Power Management
 Unit driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>
Date: Wed, 15 Jun 2016 12:59:10 +0300
In-Reply-To: <20160615081532.GB16023@gmail.com>
References: <1465928985-12113-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160615081532.GB16023@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-06-15 at 10:15 +0200, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Add Power Management Unit driver to handle power states of South
> > Complex
> > devices on Intel Tangier. In the future it might be expanded to
> > cover North
> > Complex devices as well.
> > 
> > With this driver the power state of the host controllers such as
> > SPI, I2C,
> > UART, eMMC, and DMA would be managed.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 

> I've applied this to tip:x86/platform. I changed references to 'PMU'
> to 'PWRMU' - 
> let me know if you'd like to use some other abbreviation.

It works to me. Thanks!


> Please send the clean-up patch on top of this. (Feel free to squash
> the one I sent 
> into yours.)
> 

Will do soon.


-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
