Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy19-pub.mail.unifiedlayer.com ([70.40.200.33]:47055 "HELO
	oproxy19-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755677AbaAFQv2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2014 11:51:28 -0500
Date: Mon, 6 Jan 2014 08:47:16 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH pci-next 2/2] pci: remove dead code
Message-ID: <20140106084716.068edc9f@jbarnes-desktop>
In-Reply-To: <CAErSpo49y7q_E4kHtFsZ-hOkbeWaAgEAt38YdP1TJ6Dk0XwOWw@mail.gmail.com>
References: <20131227132530.5c02d9d8@nehalam.linuxnetplumber.net>
	<20131227132710.7190647c@nehalam.linuxnetplumber.net>
	<CAErSpo49y7q_E4kHtFsZ-hOkbeWaAgEAt38YdP1TJ6Dk0XwOWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2 Jan 2014 16:12:52 -0700
Bjorn Helgaas <bhelgaas@google.com> wrote:

> [+cc Jesse, Myron]
> 
> On Fri, Dec 27, 2013 at 2:27 PM, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > My philosophy is unused code is dead code.
> > And dead code is subject to bit rot and is likely source of bugs.
> > Use it or lose it.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> This removes pci_enable_ido(), pci_enable_obff(), pci_enable_ltr(),
> etc., which I think you added, Jesse.  In principle I like the idea of
> removing code that isn't being used.  Of course, these might be used
> by out-of-tree drivers, but I don't think we should go *too* far out
> of our way to support them.
> 
> Anybody have any objections to removing them?  Obviously they'll still
> be in the git history, so it would be trivial to resurrect them.

No objections.  If driver folks haven't yet found a use for them (and/or
hw is scarce) there's no reason to keep these.

-- 
Jesse Barnes, Intel Open Source Technology Center
