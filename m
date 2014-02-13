Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:47617 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbaBMUUW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Feb 2014 15:20:22 -0500
Date: Thu, 13 Feb 2014 13:20:14 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140213202014.GF17248@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <20140213110721.GC13576@mudshark.cambridge.arm.com>
 <BA5E6077-77F8-4BE8-80E5-BAB9FE111387@codeaurora.org>
 <4110788.UI9TADVhpa@wuerfel>
 <20140213182654.GA20043@obsidianresearch.com>
 <20140213195317.GQ13576@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140213195317.GQ13576@mudshark.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 13, 2014 at 07:53:17PM +0000, Will Deacon wrote:
> > This may be less than 256 busses, as ECAM allows the implementor to
> > select how many upper address bits are actually supported.
> 
> Ok, but the ECAM/CAM base always corresponds to bus 0, right?

Yes, or it isn't ECAM.

> Ok, so this answers Kumar's point about the reg property. I'll augment it
> with a size.

Don't forget to request_region it as well...

Jason
