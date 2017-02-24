Return-Path: <SRS0=HBWb=2F=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=HBWb=2F=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
 <20170224003559.GB21548@bhelgaas-glaptop.roam.corp.google.com>
Cc: Keith Busch <keith.busch@intel.com>, Myron Stowe <myron.stowe@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Wei Zhang <wzhang@fb.com>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Stephen Bates <stephen.bates@microsemi.com>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <665fc46c-6b26-8b4c-fdd8-a720801158d5@deltatee.com>
Date: Fri, 24 Feb 2017 11:32:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170224003559.GB21548@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
List-ID: <linux-pci.vger.kernel.org>

Hey Bjorn,

Thanks for the thorough review. It definitely helped a lot to make the
code as good as it can be.

I've made all of the changes you suggested. I'm just going to do a bit
more testing and then post a v4. See my responses to all of your
feedback bellow.

Logan

On 23/02/17 05:35 PM, Bjorn Helgaas wrote:
> Would it make any sense to integrate this with the perf tool?  It
> looks like switchtec-user measures bandwidth and latency, which sounds
> sort of perf-ish.

That would be cool but lets file that under potential future work. This
driver also enables more than bandwidth and latency so it's still
required for us.

>> +MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCI-E Management Driver");
> 
> Nit: s/PCI-E/PCIe/
> 

Fixed.

>> +MODULE_VERSION("0.1");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Microsemi Corporation");
>> +
>> +static int max_devices = 16;
> 
> This static initialization is slightly misleading because
> switchtec_init() immediately sets max_devices to at least 256.

Oops copied that from dax without thinking. I've just removed the max()
call in the init function.


>> +	atomic_t event_cnt;
> 
> Why is this atomic_t?  You only do an atomic_set() (in stdev_create())
> and atomic_reads() -- no writes other than the initial one.  So I'm
> not sure what value atomic_t brings.

If you looked at a following patch in the series you'd see that there's
an atomic_inc in the ISR. The splitting of the series wasn't as precise
as it maybe should have been and thus this became a bit confusing.

>> +	memcpy_fromio(stuser->data, &stdev->mmio_mrpc->output_data,
>> +		      sizeof(stuser->data));
> 
> Apparently you always get 1K of data back, no matter what?

Yes, sort of unfortunately. Because these transactions can occur before
the user actually does the read, we don't know how much data the user
wants. This may be a performance improvement in the future (ie. if the
user reads before the MRPC transaction comes back, then only read the
requested amount). But we will leave it this way for now.


>> +	if (!stdev_is_alive(stdev))
>> +		return -ENXIO;
> 
> What exactly does this protect against?  Is it OK if stdev_is_alive()
> becomes false immediately after we check?

Yup, you're right: that's racy. Turns out cleanup is hard and I've
learned a lot even in the short time since I wrote this code. I've
gotten rid of stdev_is_alive and moved the pci cleanup code into the
device's release function so they won't occur until the last user closes
the cdev. I think that should work better but please let me know if you
see an issue with this.

>> +
>> +	if (size < sizeof(stuser->cmd) ||
>> +	    size > sizeof(stuser->cmd) + SWITCHTEC_MRPC_PAYLOAD_SIZE)
> 
> I think I would use "sizeof(stuser->data)" instead of
> SWITCHTEC_MRPC_PAYLOAD_SIZE so it matches what mrpc_complete_cmd()
> does.  Same below in switchtec_dev_read().

Ok.

> mrpc_mutex doesn't protect the stuser things, does it?  If not, you
> could do this without the gotos.  And I think it's a little easier to
> be confident there are no buffer overruns:

I was using the mutex to protect stuser->state as well. But I've made
your changes and just adjusted stuser->state to be atomic and I think
this should be just as good.

>> +static int switchtec_init_msix_isr(struct switchtec_dev *stdev)
>> +{
>> +	struct pci_dev *pdev = stdev->pdev;
>> +	int rc, i, msix_count, node;
>> +
>> +	node = dev_to_node(&pdev->dev);
> 
> Unused?

Yup, I've removed it.

>> +	for (i = 0; i < ARRAY_SIZE(stdev->msix); ++i)
>> +		stdev->msix[i].entry = i;
>> +
>> +	msix_count = pci_enable_msix_range(pdev, stdev->msix, 1,
>> +					   ARRAY_SIZE(stdev->msix));
>> +	if (msix_count < 0)
>> +		return msix_count;
> 
> Maybe this could be simplified by using pci_alloc_irq_vectors()?

Yup! I wasn't aware of that function. It's a _huge_ improvement. Thanks.
Still I'd really appreciate a quick re-review after I post v4 just to
make sure I got it correct.

>> +	stdev->event_irq = ioread32(&stdev->mmio_part_cfg->vep_vector_number);
>> +	if (stdev->event_irq < 0 || stdev->event_irq >= msix_count) {
>> +		rc = -EFAULT;
>> +		goto err_msix_request;
>> +	}
> 
> Not sure what this is doing, but you immediately overwrite
> stdev->event_irq below.  If you're using it as just a temporary above
> for doing some validation, I would just use a local variable to avoid
> the connection with stdev->event_irq.

Yes, I made this temporary.

>> +	stdev->event_irq = stdev->msix[stdev->event_irq].vector;
> 
> Oh, I guess you allocate several MSI-X vectors, but you only actually
> use one of them?  Why is that?  I was confused about why you allocate
> several vectors, but there's only one devm_request_irq() call below.

The event_irq is configurable in hardware and won't necessarily be the
first irq available. (It should always be in the first four.) As I
understand it, we need to allocate all of them in order to use the one
we want. The hardware has a couple of other IRQs that do other things
that we are not currently using.

>> +	iowrite32(SWITCHTEC_EVENT_CLEAR |
>> +		  SWITCHTEC_EVENT_EN_IRQ,
> 
> Does this enable the device to generate IRQs?  You haven't connected
> the ISR yet (but I guess you probably also haven't told the device to
> do anything that would actually generate an IRQ).

Yes on both counts. I've moved it past the ISR initialization just so
it's more correct.
