Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.com>
Subject: Re: [PATCHv2] pci: Update VPD size with correct length
Date: Wed, 16 Dec 2015 19:55:41 +0100
Message-ID: <1571929.py3SMrb2RG@lennox.hannes-reinecke.de>
In-Reply-To: <CAKgT0UcT_FxpjFUFF-HELHU7v_g_AcnPTg4tHWt3FsWO4G3fZg@mail.gmail.com>
References: <1450262992-77276-1-git-send-email-hare@suse.de> <4468155.Bdxh8senif@lennox.hannes-reinecke.de> <CAKgT0UcT_FxpjFUFF-HELHU7v_g_AcnPTg4tHWt3FsWO4G3fZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 16, 2015 09:13:35 AM Alexander Duyck wrote:
> On Wed, Dec 16, 2015 at 9:01 AM, Hannes Reinecke <hare@suse.de> wrote:
> > On Wednesday, December 16, 2015 08:52:10 AM Alexander Duyck wrote:
> >> On Wed, Dec 16, 2015 at 2:49 AM, Hannes Reinecke <hare@suse.de> wrote:
> >> > +               if (header[0] == 0xff) {
> >> > +                       /* Invalid data from VPD read */
> >> > +                       tag = header[0];
> >> > +               } else if (header[0] & 0x80) {
> >> > +                       /* Large Resource Data Type Tag */
> >> > +                       if (pci_read_vpd(dev, off+1, 2, &header[1]) !=
> >> > 2)
> >> > +                               return off + 1;
> >> > +                       off += 3 + ((header[2] << 8) | header[1]);
> >> > +                       tag = (header[0] & 0x7f);
> >> > +               } else {
> >> > +                       /* Short Resource Data Type Tag */
> >> > +                       off += 1 + (header[0] & 0x07);
> >> > +                       tag = (header[0] & 0x78) >> 3;
> >> > +               }
> >> > +               if (tag == 0x0f)        /* End tag descriptor */
> >> > +                       break;
> >> 
> >> It might make sense to just use the "return off" here since this is
> >> the only spot that should be returning the offset.
> > 
> > Which I'm not sure about.
> > We have three cases to worry about:
> > a) return after the 'end' tag
> > b) return after failing to read the 'end' tag
> > c) return after reading an invalid tag
> > 
> > For a) we obviously have to return the size.
> > But for b) and c)?
> > Just returning the maximal size (= old_size) would be exposing
> > invalid data to userland, with the possibility of hanging the system
> > by just reading from the attribute.
> > So to avoid that I've been returning the size of valid data.
> > 
> > But I'm open to suggestions if you think that's wrong.
> 
> If you didn't encounter an end tag how can you be sure you have valid
> data?  Maybe the random data managed to work out for the first couple
> of reads and then suddenly failed.  You might have a block of data
> that is valid for half of something like the read-only area and is
> going to return garbage data starting part way through.  I'd say you
> should handle this with an all-or-nothing type approach in order to
> err on the side of caution.  We could then see about white listing in
> those rare cases where a tag is missing using something like PCI quirk
> since we likely cannot use a parsing based approach if we cannot find
> the end tag.

Fair enough.

The only 'error' cases I've encountered so far is a read of all zeroes (and a 
halting the machine once you've read beyond a certain point) or a read of 0xff 
throughout the entire area. So that approach would work for both of them.

I'll be updating the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		 zSeries & Storage
hare@suse.de		+49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
