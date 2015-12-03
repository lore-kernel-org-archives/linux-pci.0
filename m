Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34180 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbLCUfZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 15:35:25 -0500
Received: by ioir85 with SMTP id r85so94260444ioi.1
        for <linux-pci@vger.kernel.org>; Thu, 03 Dec 2015 12:35:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151203172128.GA17565@localhost>
References: <6ff64f0313c4e6400ef536017078e58ec3487c71.1447949082.git.luto@kernel.org>
 <20151203172128.GA17565@localhost>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 3 Dec 2015 12:35:04 -0800
Message-ID: <CALCETrW1oS9Xr82Zxbb-gC4hY694bXGbxo4RMFPyNJmsTNTdzg@mail.gmail.com>
Subject: Re: [PATCH] pcie_aspm: Make link_state_store consistent with link_state_show
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Dec 3, 2015 9:21 AM, "Bjorn Helgaas" <helgaas@kernel.org> wrote:
>
> On Thu, Nov 19, 2015 at 08:05:35AM -0800, Andy Lutomirski wrote:
> > If CONFIG_PCIEASPM_DEBUG is set, then pci devices have a link_state
> > attribute.  Reading that attribute shows the state as a bit mask: 1
> > means L0S upstream, 2 means L0S downstream, and 4 means L1.
> >
> > Oddly, writing to link_state is inconsistent and gets translated,
> > leading to mysterious results in which the value you store isn't
> > comparable the value you load back out.
> >
> > Fix it by making link_state_store match link_state_show.
> >
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Applied to pci/aspm for v4.5, thanks!  You didn't touch the
> "aspm_disabled" check, but I moved it above the input validation code to
> make the patch look like the attached.  I think it's better to not
> even look at the input if aspm_disabled, and this also puts the
> validation code all together.

Looks good to me.

--Andy
