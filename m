Return-Path: <benh@au1.ibm.com>
Return-Path: <benh@au1.ibm.com>
Subject: Re: [PATCH] PCI: Add parameter @mmio_force_on to
 pci_update_resource()
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, clsoto@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Sep 2016 10:06:44 +1000
In-Reply-To: <20160927233749.GA19797@gwshan>
References: <1474242810-11530-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <20160927192003.GA14642@localhost> <1475012732.2857.293.camel@au1.ibm.com>
	 <20160927233749.GA19797@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1475021204.2857.302.camel@au1.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-09-28 at 09:37 +1000, Gavin Shan wrote:
> 
> Yeah, it's safe to update it with memory decoding on. As the function call
> flow I listed in the changelog (as below), nobody should access the IOV BAR
> when pci_update_resource() is called. However, the PF's memory BARs might
> be accessed that time and it's not safe to disable PF's memory decoding.

The problem isn't so much whether anybody accesses the IOV BAR while
it's updated but whether the IOV BAR will decode at all.

IE. The BAR is updated in two steps, 32-bit each. That means that there
is a window where it contains a "bogus" value.

If that bogus value conflicts with another BAR (another BAR of the  PF
or another PF of the same device for example) then there is a risk of
something bad happening if the driver accesses that conflicting
resource during that window.

On the other hand, if the IOV BAR doesn't decode at all while the
update is done, which I think is the case as I believe SR-IOV isn't
enabled during the update (please verify), then we are safe.

Cheers,
Ben.
