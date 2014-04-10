Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 10 Apr 2014 18:51:18 -0400 (EDT)
From: Parag Warudkar <parag.lkml@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Parag Warudkar <parag.lkml@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Yinghai Lu <yinghai@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: BAR 14: can't assign mem (size 0x200000)
In-Reply-To: <CAErSpo6XjtrzSJE6n5aCMzketKv+rPt5eVvrzOQgUnviiRTWnA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1404101846120.4929@parag-Z230>
References: <CAOULuOY5eryuH1KgaqiuGXyYiQd2h=TZoPe2M2+juts9XuzW6Q@mail.gmail.com> <CAE9FiQXmO_sSCnd-0NvXKmyeLP0m4XGRRkAgqSiMkfeTcvXs+A@mail.gmail.com> <CAOULuOaeBPpuiYc_Aru+awBDf=Ahbok-UjgY9o7gfO4VMctoqg@mail.gmail.com> <CAE9FiQWpprkp_dzviD8wRpqosJq5Oe+8UTwhL87fbzFm3OknUw@mail.gmail.com>
 <CA+55aFx_zAO0iJVi==4X-bYFTopgaOCopCdUBbqUwKfOrXRYqw@mail.gmail.com> <20140329171903.GA10551@google.com> <CAOULuOaUke-W1W0o=1rhhk43Fy_RAYLdfhXQjdhy2xjHxP0oWA@mail.gmail.com> <CAErSpo6XjtrzSJE6n5aCMzketKv+rPt5eVvrzOQgUnviiRTWnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Thu, 10 Apr 2014, Bjorn Helgaas wrote:

> On Sat, Mar 29, 2014 at 6:14 PM, Parag Warudkar <parag.lkml@gmail.com> wrote:
> >> On Sat, Mar 29, 2014 at 09:41:20AM -0700, Linus Torvalds wrote:
> >
> >>> Parag, can you add a WARN_ON_ONCE() to that message, so that we see
> >>> what the call chain is for it.
> 
> Parag, did you ever try this?

No I haven't so far - I assumed the call chain you posted initially was 
the only possibility. I will give it a try.

> I doubt that Ubuntu includes any patches relevant to this issue.
> 
> Even though it doesn't seem to cause any problems, we're going to get
> a lot of complaints about these scary-looking messages when resuming,
> so I think we should figure this out and fix it.

Sure, since the resource assignments aren't an issue during fresh boot, it 
might just be something worth fixing in the resume path.

Thanks,
Parag
