Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33721 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753381Ab3KCT7b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Nov 2013 14:59:31 -0500
Date: Sun, 3 Nov 2013 14:59:28 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Subject: Re: [PATCH 2/3] PCI: mvebu: Remove redeundant of_match_ptr
Message-ID: <20131103195928.GB3060@titan.lakedaemon.net>
References: <1382346403-29576-1-git-send-email-sachin.kamat@linaro.org>
 <1382346403-29576-2-git-send-email-sachin.kamat@linaro.org>
 <CAErSpo6n4F1zREyYXuwq9LCRLCD+yZ9o8j==ANamiAZesFz=EA@mail.gmail.com>
 <CAErSpo4CFitR_CbG+TBYF-S-nKLdz9+CfV2mex76b=pnh24Vqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4CFitR_CbG+TBYF-S-nKLdz9+CfV2mex76b=pnh24Vqw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

Sorry for the delayed response.  Apparently, work doesn't stop when you
go out of town for a week. :-)

On Wed, Oct 30, 2013 at 10:06:58AM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 29, 2013 at 4:12 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Jason]
> >
> > On Mon, Oct 21, 2013 at 3:06 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> >> mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
> >> not required.
> >>
> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> >
> > Jason, I assume you'll merge this if you want it.

Hmm, we seem to be at a good transition point.  The arm-soc tree tries
not to take any more patches after -rc6, so we've been frozen since
then.

I have a few pci patches in my mvebu-next/drivers branch that didn't
make it in in time.  Jason Gunthorpe has a hotplug patch that needs
testing and a few other fixes floating around.

Perhaps we should just go ahead and transition back to the mvebu
maintainers Ack'ing patches and then going through your tree (as it's
supposed to be)?

If we run into another complicated dependency mess, we'll hash it out
then.  atm, I don't see anything on the horizon.

Sound good?  If so, I'll drop the following from mvebu-next/drivers:

  ca02ce7f863f PCI: mvebu - The bridge secondary status register should be 0
  b09d7cdf75dc PCI: mvebu - Support a bridge with no IO port window
  dbbe1efd61e3 PCI: mvebu: return NULL instead of ERR_PTR(ret)

You can take them for v3.13 if you'd like, or hold them for v3.14 (which
was the current plan due to the -rc6 cutoff).

I've intentionally kept mvebu-next/* branches out of linux-next, so
cherry picking the above shouldn't cause any conflicts.

thx,

Jason.
