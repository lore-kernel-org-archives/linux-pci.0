Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 20 Aug 2018 23:14:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC 00/15] PCI: turn some __weak functions into callbacks
Message-ID: <20180821061451.GB481@infradead.org>
References: <20180817102645.3839621-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180817102645.3839621-1-arnd@arndb.de>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 17, 2018 at 12:26:30PM +0200, Arnd Bergmann wrote:
> Hi Bjorn and others,
> 
> Triggered by Christoph's patches, I had another go at converting
> all of the remaining pci host bridge implementations to be based
> on pci_alloc_host_bridge and a separate registration function.

I really like the idea behind this series.

> I'm adding a bit of duplication into the less maintained code
> here, but it makes everything more consistent, and gives an
> easy place to hook up callback functions etc.

I wonder if there is a way to avoid some of that by adding a few
more helpers, but even without the helpers that approach looks
ok to me.

Do you have a git tree somewhere to play around with the changes?
