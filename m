Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26942 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab3LPEUS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Dec 2013 23:20:18 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>,
	'shiv prakash Agarwal' <chhotu.shiv@gmail.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	'linux-arm' <linux-arm-kernel@lists.infradead.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <CAHH3p5+3Zy+YkgDS_1bJ7B84w5iHOh6-QG7LRJXo2WQHREcRHw@mail.gmail.com>
 <CAErSpo59htYoPBoouUfSXAVXwCUQPK-TB_zG0BkE-PLhV=KRbQ@mail.gmail.com>
 <CAHH3p5J7Se8zu64MfoSDkAN_NtOp=qv1DcvWBAa8jWKouo0TXg@mail.gmail.com>
 <CAErSpo5k1KZuaL7jYp1-5YaxjdZseDPrFo64mJcb2tu2PWJowA@mail.gmail.com>
 <20131216034544.GA2445@pratyush-vbox>
In-reply-to: <20131216034544.GA2445@pratyush-vbox>
Subject: Re: Memory mapping of config space of pcie devices
Date: Mon, 16 Dec 2013 13:20:10 +0900
Message-id: <006801cefa16$1c0f91d0$542eb570$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, December 16, 2013 12:46 PM, shiv prakash Agarwal wrote:
> On Sun, Dec 15, 2013 at 04:18:23AM +0800, Bjorn Helgaas wrote:
> > [+cc devicetree, linux-arm-kernel]
> >
> > On Sat, Dec 14, 2013 at 1:05 PM, shiv prakash Agarwal
> > <chhotu.shiv@gmail.com> wrote:
> > > On Sun, Dec 15, 2013 at 12:29 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > >> On Sat, Dec 14, 2013 at 11:32 AM, shiv prakash Agarwal
> > >> <chhotu.shiv@gmail.com> wrote:
> > >>> Hi All,
> > >>>
> > >>> How devices config spaces are mapped to host memory?
> > >>> Is it being handled by core driver? I could not locate.
> > >>
> > >> The PCI core does not map config space into memory.  That's not even
> > >> possible for the legacy config access methods, e.g., using I/O ports
> > >> 0xcf8 and 0xcfc [1].
> > >>
> > >> If you're wondering about how Linux uses ECAM, that's mostly in
> > >> arch/x86/pci/mmconfig*.  That code does ioremap the ECAM area into
> > >> kernel virtual space, but only for access via pci_read_config_word(),
> > >> pci_write_config_word(), etc.
> > >>
> > >> Bjorn
> > >>
> > >> [1] http://en.wikipedia.org/wiki/PCI_configuration_space#Software_implementation
> > >
> > > Thanks Bjorn for quick reply,
> > >
> > > Above reference says:
> > > During system initialization, firmware determines the base address for
> > > this “stolen” address region and communicates it to the root complex
> > > and to the operating system. This communication method is
> > > implementation-specific, and not defined in the PCI Express
> > > specification.
> > >
> > > How above is implemented on ARM?
> >
> > On x86, we learn the ECAM address via ACPI (the MCFG table or a host
> > bridge _CBA method).  I don't know how this is done on ARM.  I could
> > imagine it being done via device tree, but I really don't know.
> > Unfortunately both the address discovery and the actual ECAM accesses
> > are in arch-specific code.
> 
> Yes, it comes from device tree. DT sends CPU address range allocated
> for cfg transfers. pci_read_config_word and pci_write_config_word
> send bdf and offset. Address translation unit of your RC driver should
> be programmed in such a way that it translates cpu address to the cfg
> address based on bdf and offset.
> 
> You can see one such implementation in drivers/pci/host/pcie-designware.c

As Bjorn said, the PCI core does not map config space into memory.
As Pratyush Anand said, address mapping can be done via device tree.
Please refer to the following in order to understand PCI Device
tree standard.

http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge

Best regards,
Jingoo Han


