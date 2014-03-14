Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v7 3/3] arm64: Add architecture support for PCI
Date: Fri, 14 Mar 2014 20:10:39 +0100
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linaro-kernel" <linaro-kernel@lists.linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>
References: <1394811258-1500-1-git-send-email-Liviu.Dudau@arm.com> <201403141838.08900.arnd@arndb.de> <20140314180527.GZ6457@e106497-lin.cambridge.arm.com>
In-Reply-To: <20140314180527.GZ6457@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201403142010.39886.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 14 March 2014, Liviu Dudau wrote:
> > 
> 
> I haven't seen any reaction from Bjorn on this, so I threaded carefully on that
> subject. I'm new to this so I don't know how to handle this.
> 
> To my mind, and looking at the way every architecture has been setup, the pcibios_*
> function are intended to be provided by the architecture.

That is definitely correct.

> No matter how much wishful
> thinking we are going to put in here, it will not change the fact that the non-arm64
> specific version of pcibios_fixup_bus() that I wrote is not shared by anyone else
> and it will remain "for arm64 use only" regardless to where it is placed until the
> next architecture comes into the kernel. And even then its adoption is questionable.

Agreed as well.

> If we are looking for simple and common implementations of this function, maybe we
> should look at why microblaze and powerpc versions, that are identical, are not being
> made the default __weak implementation.

Microblaze could most likely just be moved over to your version. The only
reason it is shared with the powerpc implementation is that they were
anticipating the code to become shared again and that it was known to
be working with flattened device tree.

> As for the other two functions, I've no special attachment to where they are present
> and I'm happy to move them into drivers/pci on the condition that the patchset doesn't
> double in size. The reason why I'm weary of touching other architectures in a significant
> way is the current lack of engineering bandwidth and way of testing all the architectures.
> My low friction approach has been to introduce them in arm64 and then slowly move them
> into core (and yes, I know about good intentions and the road to hell.)

I think everyone working on PCI is fed up with having arch-specific implementations
of all these, and Bjorn has been very supportive of generic infrastructure in the
past. Even just adding a generic infrastructure in a common place that is used
only by one architecture in my mind would be a significant improvement.

	Arnd
