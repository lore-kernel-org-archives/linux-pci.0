Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7996 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbJESDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Oct 2015 14:03:11 -0400
Date: Mon, 5 Oct 2015 18:03:09 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Ingo Molnar <mingo@kernel.org>
cc: Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <20151005164624.GA13737@gmail.com>
Message-ID: <alpine.LNX.2.00.1510051734310.23840@localhost.lm.intel.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com> <20151003094512.GA29104@gmail.com> <alpine.LNX.2.00.1510051424000.23840@localhost.lm.intel.com> <20151005164624.GA13737@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 5 Oct 2015, Ingo Molnar wrote:
> * Keith Busch <keith.busch@intel.com> wrote:
>> The immediate benefit is that devices on VMD domains do not use resources
>> on the default PCI domain, so we have more than the 256 buses available.
>
> Would be nice to incorporate that information in the help text and in the
> changelog.

Fair enough. Perhaps we thought the "secondary domain" description
implied that information, but maybe we've been doing this too long. :)

Thanks for the feedback.
