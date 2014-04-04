Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55237 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbaDDAMr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 20:12:47 -0400
Date: Thu, 3 Apr 2014 20:12:44 -0400 (EDT)
From: David Airlie <airlied@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Message-ID: <1888467261.2661221.1396570364156.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAE9FiQUHC4jPJttUpChAALd6zubbQQEZ9wRc329Lv5QAXGOUKw@mail.gmail.com>
References: <CAErSpo6JNDFiV6tmDKKDdnod+skBHx6T-+JGvjCRRLsL98h_uQ@mail.gmail.com> <CAE9FiQUHC4jPJttUpChAALd6zubbQQEZ9wRc329Lv5QAXGOUKw@mail.gmail.com>
Subject: Re: Coverity CID 142811: pci_set_vga_state() operands don't affect
 result
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



----- Original Message -----
> From: "Yinghai Lu" <yinghai@kernel.org>
> To: "Bjorn Helgaas" <bhelgaas@google.com>
> Cc: "Dave Airlie" <airlied@redhat.com>, linux-pci@vger.kernel.org
> Sent: Friday, 4 April, 2014 10:06:32 AM
> Subject: Re: Coverity CID 142811: pci_set_vga_state() operands don't affect result
> 
> On Thu, Apr 3, 2014 at 1:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Coverity complains about this in drivers/pci/pci.c:
> >
> > CID 142811 (#1 of 1): Operands don't affect result
> > (CONSTANT_EXPRESSION_RESULT)
> > result_independent_of_operands: flags & (2U /* 1 << 1 */) &
> > (command_bits & 4294967292U /* ~(1 | 2) */) is always 0 regardless of
> > the values of its operands. This occurs as the logical operand of if.
> >
> > 4128        WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) &
> > (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
> >
> > This is a result of 3448a19da479 "vgaarb: use bridges to control VGA
> > routing where possible."
> >
> > I wonder if that middle "&" was intended to be "&&"?
> 
> must be. otherwise always get 0.

Yeah I'd agree :-)

Dave.
