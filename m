Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 21 Aug 2018 06:14:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
Message-ID: <20180821131441.GA6156@infradead.org>
References: <20180817102645.3839621-1-arnd@arndb.de>
 <20180821061451.GB481@infradead.org>
 <1534851050.14722.3.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1534851050.14722.3.camel@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2018 at 12:30:50PM +0100, David Woodhouse wrote:
> On Mon, 2018-08-20 at 23:14 -0700, Christoph Hellwig wrote:
> > On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> > > Hi Bjorn and others,
> > > 
> > > Triggered by Christoph's patches, I had another go at converting
> > > all of the remaining pci host bridge implementations to be based
> > > on pci_alloc_host_bridge and a separate registration function.
> > 
> > I really like the idea behind this series.
> 
> Hm... are you turning direct calls into retpolined indirect calls?

He does.  But not anywhere near the fast path.
