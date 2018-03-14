Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCNPdZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 11:33:25 -0400
Message-ID: <1521041253.4511.16.camel@suse.com>
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
From: Oliver Neukum <oneukum@suse.com>
To: Richard Leitner <richard.leitner@skidata.com>,
        Richard Leitner <dev@g0hl1n.net>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bhelgaas@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Date: Wed, 14 Mar 2018 16:27:33 +0100
In-Reply-To: <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
         <20180314102933.21367-3-dev@g0hl1n.net> <1521029854.4511.12.camel@suse.com>
         <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 14.03.2018, 14:31 +0100 schrieb Richard Leitner:
> Hi Oliver,
> thank you for your feedback!
> 
> On 03/14/2018 01:17 PM, Oliver Neukum wrote:
> > Am Mittwoch, den 14.03.2018, 11:29 +0100 schrieb Richard Leitner:
> > > From: Richard Leitner <richard.leitner@skidata.com>
> > > 
> > > Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> > > pci_ids.h
> > 
> > Hi,
> > 
> > in general, why?
> > Does this patch generate any benefit for any developer
> > reading the source? I don't see it. Does it cause an
> > issue for anybody who has a log file with the nummerical
> > ID and needs to grep for it? Yes it does.
> 
> I'll send a v2 where I also use this definition in 
> arch/mips/netlogic/xlp/ instead of PCI_VENDOR_NETLOGIC from
> arch/mips/include/asm/netlogic/xlp-hal/iomap.h.
> 
> Therefore it will remove this definition from the iomap.h
> and move it to pci_ids.h
> 
> This will IMHO be a clear benefit as it removes a redundant
> definition.

Well, but it does not. Removing a redundant definition is a clear
benefit. But you are not removing a definition. You are introducing
a preprocessor constant. Why?
What is its benefit?

	Regards
		Oliver
