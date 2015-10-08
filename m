Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] PCI: generic: Fix address window calculation for non-zero starting bus.
Date: Thu, 08 Oct 2015 23:09:16 +0200
Message-ID: <5232073.r65S9X2O3H@wuerfel>
In-Reply-To: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
References: <1444334056-4870-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 October 2015 12:54:16 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Make the offset from the beginning of the "reg" property be from the
> starting bus number, rather than zero.  Hoist the invariant size
> calculation out of the mapping for loop.
> 
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> 

Thanks a lot!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
