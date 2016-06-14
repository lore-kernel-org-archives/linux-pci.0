Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33020 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbcFNRgD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 13:36:03 -0400
Message-ID: <1465925834.30123.90.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] x86/platform/intel-mid: Add Power Management
 Unit driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 14 Jun 2016 20:37:14 +0300
In-Reply-To: <20160614172621.GA16566@psi-dev26.jf.intel.com>
References: <1465849087-54528-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1465919118.30123.73.camel@linux.intel.com>
 <20160614155835.GA29820@gmail.com>
 <1465920434.30123.87.camel@linux.intel.com>
	 <20160614172621.GA16566@psi-dev26.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-06-14 at 10:26 -0700, David Cohen wrote:

> > Yes. Will rename in this way, re-test and re-send.
> 
> I'm curious about that. What pmu prefix would stand for?

It's indeed widely used as Performance Monitoring Unit

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
