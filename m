Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 15 Aug 2016 18:35:03 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160815223503.GD18083@localhost.localdomain>
References: <1470687542-30155-1-git-send-email-keith.busch@intel.com>
 <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160815195058.GA8095@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160815195058.GA8095@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 15, 2016 at 02:50:58PM -0500, Bjorn Helgaas wrote:
> What?  This is August 15, not April 1.  That makes no sense
> whatsoever.

Yes, I agree, and not advocating this was a good idea. I'm just the
messenger in this case.

That said, it looks like this can fall under the intended usage for
the quirk framework if we can consider this a work-around for standard
non-compliance. Or are your thoughts that we've gone too far if it's
not a true erratum?
