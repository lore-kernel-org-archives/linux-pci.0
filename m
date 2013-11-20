Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61491 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752073Ab3KTLlB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2013 06:41:01 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Len Brown <len.brown@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during system suspend
Date: Wed, 20 Nov 2013 12:53:40 +0100
Message-ID: <1498151.XLZyrcjCz6@vostro.rjw.lan>
In-Reply-To: <20131120112303.GA5123@amd.pavel.ucw.cz>
References: <CAPDyKFpypLVKiOZEweWMig9LrNHcOpNQnm+J3KJ3KzCDBgkv9A@mail.gmail.com> <CAPDyKFopHvAvpb1O__3HoMv2YuhYnVLg5sk+NeRs9tsg8OLSig@mail.gmail.com> <20131120112303.GA5123@amd.pavel.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 20, 2013 12:23:03 PM Pavel Machek wrote:
> On Wed 2013-11-20 11:52:05, Ulf Hansson wrote:
> > On 19 November 2013 16:35, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Tue, 19 Nov 2013, Ulf Hansson wrote:
> > >
> > >> At the moment, system PM is already affecting behaviour of runtime PM
> > >> since it is preventing runtime suspend during system suspend.
> > >
> > > Sure.  And that behavior is documented.  In any case, it's a bug for
> > > drivers to depend on runtime suspend for carrying out a system suspend.
> > 
> > Why do you say that?
> 
> Because that's the way it is?
> 
> > A significant amount of drivers should be able to cope with only the
> > runtime PM callbacks, if only the PM core have respected the drivers
> > in the way my RFC proposes.
> 
> So what? It is not as additional callback is huge burden -- code is
> the same -- and we do want option of disabling runtime PM.
> 
> Don't make system suspend dependend on runtime PM.

Amen.

