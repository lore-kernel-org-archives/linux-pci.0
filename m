Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51158 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3FZOeR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 10:34:17 -0400
Date: Wed, 26 Jun 2013 07:35:00 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Current open PCI defects
Message-ID: <20130626143500.GB13337@kroah.com>
References: <20130626025001.GA25384@google.com>
 <CAE9FiQXmP54PLSOYq17hi54ziDRM0fe+i0sRymz4+yeAxhT3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXmP54PLSOYq17hi54ziDRM0fe+i0sRymz4+yeAxhT3-w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 25, 2013 at 10:51:22PM -0700, Yinghai Lu wrote:
> On Tue, Jun 25, 2013 at 7:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Here's a list of the current PCI defects open in https://bugzilla.kernel.org
> >
> > Hint: maintainers really like it when people take the initiative to
> > resolve open issues.
> >
> > Regressions (8 total):
> 
> >   57961 ExpressCard hot-remove and hot-add not recognized by acpiphp
> 
> for 3.9 stable:
> https://patchwork.kernel.org/patch/2676821/
> 
> Greg, can you pick that for 3.9.8?

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
