Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:46384 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbeGQV03 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 17:26:29 -0400
To: Matthew Wilcox <willy@infradead.org>, Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180717170204.30470-1-logang@deltatee.com>
 <20180717203900.GA1771@bombadil.infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1e1f1e0d-520a-e2f9-15cb-09e97cd4a836@deltatee.com>
Date: Tue, 17 Jul 2018 14:51:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180717203900.GA1771@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: lspci: Display path to device
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 17/07/18 02:39 PM, Matthew Wilcox wrote:
> On Tue, Jul 17, 2018 at 11:02:00AM -0600, Logan Gunthorpe wrote:
>> The second patch expands the new helper to optionally take a path of
>> PCI devfns. This is to address Alex's renumbering concern when using
>> simple bus-devfns. The implementation is essentially how he described it and
>> similar to the Intel VT-d spec (Section 8.3.1).
> 
> I don't like telling the user to grovel around lspci -t by hand.  It's
> not many lines of code to add a new -P option to lspci to show the path
> to each device instead of bus:dev.fn

Thanks, this looks great! I also found parsing the lspci -t output
cumbersome.

I've also got patches pending for switchtec-user[1] that help users find
the path of downstream ports for Microsemi switches. (An example is
shown below). As the ACS feature is primarily for PCI switch users, this
should help a good segment of people. The lspci patches should cover a
lot more people though.

Logan

sudo switchtec status /dev/switchtec0 -v
Partition 0:    (LOCAL)
    Logical Port ID 0 (USP):
	Phys Port ID:    	32 (Stack 4, Port 0)
	Bus-Dev-Func:    	0000:02:00.0
	Bus-Dev-Func Path:	0000:00:02:0/00.0
	Status:          	UP
	LTSSM:           	L0
	Max-Width:       	x16
	Neg Width:       	x16
	Rate:            	Gen3 - 8 GT/s  15.76 GB/s
	Out Bytes:       	70.3 GB
	In Bytes:        	70.8 GB
    Logical Port ID 1 (DSP):
	Phys Port ID:    	8 (Stack 1, Port 0)
	Bus-Dev-Func:    	0000:03:00.0
	Bus-Dev-Func Path:	0000:00:02:0/00.0/00.0
	Status:          	UP
	LTSSM:           	L0
	Max-Width:       	x8
	Neg Width:       	x8
	Rate:            	Gen3 - 8 GT/s  7.88 GB/s
	Out Bytes:       	12.2 MB
	In Bytes:        	441 MB
	ACS:             	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Device:          	10b5:8724 (0000:04:00.0)
	                 	0000:05
    Logical Port ID 2 (DSP):
	Phys Port ID:    	12 (Stack 1, Port 4)
	Bus-Dev-Func:    	0000:03:01.0
	Bus-Dev-Func Path:	0000:00:02:0/00.0/01.0
	Status:          	UP
	LTSSM:           	L0
	Max-Width:       	x8
	Neg Width:       	x8
	Rate:            	Gen3 - 8 GT/s  7.88 GB/s
	Out Bytes:       	1.65 MB
	In Bytes:        	107 MB
	ACS:             	SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
	Device:          	11f8:f117 (0000:0b:00.0)
	                 	nvme4




[1] https://github.com/Microsemi/switchtec-user/pull/25
