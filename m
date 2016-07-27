Return-Path: <gregkh@linuxfoundation.org>
Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 27 Jul 2016 15:15:52 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: Xavier Gnata <xavier.gnata@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] thunderbolt: Add support for INTEL_FALCON_RIDGE_2C
 controller.
Message-ID: <20160727221552.GA9975@kroah.com>
References: <20160726164038.1481-1-andreas.noever@gmail.com>
 <20160726164038.1481-2-andreas.noever@gmail.com>
 <ed33043d-fe00-9478-80fa-bdca311a52f1@gmail.com>
 <CAMxnaaULYgu00dNzbu3LLNkdnAFz0bkke3vVt19yfHT=Y0_dkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMxnaaULYgu00dNzbu3LLNkdnAFz0bkke3vVt19yfHT=Y0_dkw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 28, 2016 at 12:08:42AM +0200, Andreas Noever wrote:
> On Wed, Jul 27, 2016 at 10:11 AM, Xavier Gnata <xavier.gnata@gmail.com> wrote:
> >
> >
> > On 26/07/2016 18:40, Andreas Noever wrote:
> >>
> >> From: Xavier Gnata <xavier.gnata@gmail.com>
> >>
> >> From: Xavier Gnata <xavier.gnata@gmail.com>
> >>
> >> Add support to INTEL_FALCON_RIDGE_2C controller and corresponding quirk
> >> to support suspend/resume.
> >> Tested against 4.7 master on a MacBook Air 11" 2015.
> >>
> >> Signed-off-by: Andreas Noever <andreas.noever@gmail.com>
> >> ---
> >>  drivers/pci/quirks.c      | 4 ++++
> >>  drivers/thunderbolt/nhi.c | 6 ++++++
> >>  2 files changed, 10 insertions(+)
> >>
> >> Rebased version of Xavier's patch.
> >>
> >> Xavier, could you verify that this still works on your system?
> >>
> > It does work on my system.
> >
> > Thanks,
> > Xavier
> 
> Cool.
> 
> Greg, can we still get these into the current merge window?

Hah, no, trees closed a week or so ago.  This is all for 4.9, sorry.  My
trees will open up after 4.8-rc1 is out and I'll start working on
reviewing patches then.

thanks,

greg k-h
