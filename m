Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Tue, 14 Jun 2016 11:27:11 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Message-ID: <20160614092711.GA22613@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
 <20160613205823.GA18747@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160613205823.GA18747@localhost>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, Jun 13, 2016 at 03:58:23PM -0500, Bjorn Helgaas wrote:
> On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> > This series powers Thunderbolt controllers on Macs down when nothing is
> > plugged in, saving 1.7 W on machines with a Light Ridge controller and
> > reportedly 4 W on Cactus Ridge 4C and Falcon Ridge 4C.
> I suppose these depend on Mika's runtime PM patches (at least, I see
> Mika's commits in your github tree).  Would you mind rebasing your
> patches so they apply on my pci/pm branch?  I couldn't import them
> directly into stg.

Right, patch [08/13] no longer applies cleanly because the context has
changed slightly ("100 ms" instead of "10 ms").

I've just sent out a rebased version of that patch in-reply-to the
original version. So if you use threading in mutt (or limit the
messages displayed to e.g. "~f lukas@wunner.de" and order by subject),
you should be able to tag the rebased version and pipe that together
with the rest to stg.

If this doesn't work out for some reason and you'd prefer me to resend
the whole series just shout.

Thanks!

Lukas
