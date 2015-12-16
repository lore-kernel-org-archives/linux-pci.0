Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37573 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933033AbbLPRNh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2015 12:13:37 -0500
MIME-Version: 1.0
In-Reply-To: <4468155.Bdxh8senif@lennox.hannes-reinecke.de>
References: <1450262992-77276-1-git-send-email-hare@suse.de>
	<CAKgT0Ucjv0GK02T5jeE79MnR1g57XOr0ZWhGe4ETA15Y3Cnh-g@mail.gmail.com>
	<4468155.Bdxh8senif@lennox.hannes-reinecke.de>
Date: Wed, 16 Dec 2015 09:13:35 -0800
Message-ID: <CAKgT0UcT_FxpjFUFF-HELHU7v_g_AcnPTg4tHWt3FsWO4G3fZg@mail.gmail.com>
Subject: Re: [PATCHv2] pci: Update VPD size with correct length
From: Alexander Duyck <alexander.duyck@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 16, 2015 at 9:01 AM, Hannes Reinecke <hare@suse.de> wrote:
> On Wednesday, December 16, 2015 08:52:10 AM Alexander Duyck wrote:
>> On Wed, Dec 16, 2015 at 2:49 AM, Hannes Reinecke <hare@suse.de> wrote:

>> > +               if (header[0] == 0xff) {
>> > +                       /* Invalid data from VPD read */
>> > +                       tag = header[0];
>> > +               } else if (header[0] & 0x80) {
>> > +                       /* Large Resource Data Type Tag */
>> > +                       if (pci_read_vpd(dev, off+1, 2, &header[1]) != 2)
>> > +                               return off + 1;
>> > +                       off += 3 + ((header[2] << 8) | header[1]);
>> > +                       tag = (header[0] & 0x7f);
>> > +               } else {
>> > +                       /* Short Resource Data Type Tag */
>> > +                       off += 1 + (header[0] & 0x07);
>> > +                       tag = (header[0] & 0x78) >> 3;
>> > +               }
>> > +               if (tag == 0x0f)        /* End tag descriptor */
>> > +                       break;
>>
>> It might make sense to just use the "return off" here since this is
>> the only spot that should be returning the offset.
>>
> Which I'm not sure about.
> We have three cases to worry about:
> a) return after the 'end' tag
> b) return after failing to read the 'end' tag
> c) return after reading an invalid tag
>
> For a) we obviously have to return the size.
> But for b) and c)?
> Just returning the maximal size (= old_size) would be exposing
> invalid data to userland, with the possibility of hanging the system
> by just reading from the attribute.
> So to avoid that I've been returning the size of valid data.
>
> But I'm open to suggestions if you think that's wrong.

If you didn't encounter an end tag how can you be sure you have valid
data?  Maybe the random data managed to work out for the first couple
of reads and then suddenly failed.  You might have a block of data
that is valid for half of something like the read-only area and is
going to return garbage data starting part way through.  I'd say you
should handle this with an all-or-nothing type approach in order to
err on the side of caution.  We could then see about white listing in
those rare cases where a tag is missing using something like PCI quirk
since we likely cannot use a parsing based approach if we cannot find
the end tag.
