Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=Ly/z=KY=deltatee.com=logang@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Matthew Wilcox <willy@infradead.org>
References: <20180730161840.13733-1-logang@deltatee.com>
 <20180809230332.GH113140@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0efce4ce-3b86-7efd-39c0-84d5740d49ef@deltatee.com>
Date: Thu, 9 Aug 2018 17:27:18 -0600
MIME-Version: 1.0
In-Reply-To: <20180809230332.GH113140@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v8 0/4] Add parameter for disabling ACS redirection for
 P2P
List-ID: <linux-pci.vger.kernel.org>



On 09/08/18 05:03 PM, Bjorn Helgaas wrote:

> I reorganized this a bit and split the quirk code into a couple
> patches an put the result on my pci/peer-to-peer branch for v4.19.
> 
> I think the result is equivalent, but let me know if I made a mistake.

Thanks for the cleanup, Bjorn. I reviewed the patches and did a quick
diff between my v8 and your branch. Everything looks good.

Logan
