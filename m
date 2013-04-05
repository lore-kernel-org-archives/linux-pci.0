Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52112 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162674Ab3DETu3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Apr 2013 15:50:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: bugzilla-daemon@bugzilla.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [Bug 53811] acpiphp broken on Lenovo X220 from 3.6 onwards
Date: Fri, 05 Apr 2013 21:58:08 +0200
Message-ID: <2420501.lbdILrGNKL@vostro.rjw.lan>
In-Reply-To: <CAErSpo5n3svysQ71vStCfAOikTZBo89gmwOwHOXLTB4KSXk0zw@mail.gmail.com>
References: <bug-53811-41252@https.bugzilla.kernel.org/> <20130405101227.2AC9511FB82@bugzilla.kernel.org> <CAErSpo5n3svysQ71vStCfAOikTZBo89gmwOwHOXLTB4KSXk0zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 05, 2013 10:56:30 AM Bjorn Helgaas wrote:
> >> If the problem is with config space access, not with the SCI, why
> >> can't you just put the root port back in D0 before scanning its
> >> secondary bus?  That seems like a more direct fix.
> >
> > comment #4 patch does exactly like that.  ALLurGroceries tried that patch and
> > it works for him in comment #7.  But in comment #14, ALLurGroceries reported
> > that it does not work reliably enough.  So I write comment #26 patch to fix the
> > issue in a more conservative way, and it works reliable for ALLurGroceries.
> 
> The comment #4 patch adds "pm_runtime_get_sync(&bridge->pci_dev->dev)"
> before re-enumerating.  If that is supposed to keep the bridge in D0
> but doesn't, we need to figure out why.  I don't know how PM works,
> but maybe Rafael will chime in.

Quite frankly, this looks like unreliable hardware to me in the face of
comment #14.  It looks like with that patch applied the problem is randomly
reproducible, which suggests that we probably don't wait for a sufficiently
long time during the PCIe port resume.  Or there's a race I'm not seeing at
the moment.

So it might be a good idea to repeat the experiment with a similar patch,
but with increased timeouts (and the "put" part need not be "sync").


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
