Return-Path: <bhelgaas@google.com>
Return-Path: <bhelgaas@google.com>
MIME-Version: 1.0
In-Reply-To: <20160615102659.GB32253@infradead.org>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <20160613211411.GC18747@localhost> <20160613212810.GG12766@localhost.localdomain>
 <20160613215736.GH12766@localhost.localdomain> <20160613222630.GD18747@localhost>
 <20160613223551.GJ12766@localhost.localdomain> <20160615102659.GB32253@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 15 Jun 2016 10:38:49 -0500
Message-ID: <CAErSpo79D9uP-0OA4YSGBJ8rbfaeMNy13AWO-s1jZKncGC0GLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 15, 2016 at 5:26 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 13, 2016 at 06:35:52PM -0400, Keith Busch wrote:
>> On Mon, Jun 13, 2016 at 05:26:30PM -0500, Bjorn Helgaas wrote:
>> > My take on that is, "it's a pretty trival check; just put it directly
>> > in nvme and don't bother doing anything in the PCI core."  Maybe
>> > someday we'll come up with a way to make things more common.  It
>> > doesn't really seem worth it to add something that only helps three
>> > drivers.
>>
>> Fair enough. Will withdraw the check in pci and resend nvme.
>
> Sorry for leading you down this path..

No problem, I think it would be awesome if we could unify these
drivers somehow, and unification always involves lots of dead-ends :)
