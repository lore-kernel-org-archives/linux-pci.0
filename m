Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35351 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaDDAGd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 20:06:33 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so2665754iec.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 17:06:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6JNDFiV6tmDKKDdnod+skBHx6T-+JGvjCRRLsL98h_uQ@mail.gmail.com>
References: <CAErSpo6JNDFiV6tmDKKDdnod+skBHx6T-+JGvjCRRLsL98h_uQ@mail.gmail.com>
Date: Thu, 3 Apr 2014 17:06:32 -0700
Message-ID: <CAE9FiQUHC4jPJttUpChAALd6zubbQQEZ9wRc329Lv5QAXGOUKw@mail.gmail.com>
Subject: Re: Coverity CID 142811: pci_set_vga_state() operands don't affect result
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 3, 2014 at 1:43 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Coverity complains about this in drivers/pci/pci.c:
>
> CID 142811 (#1 of 1): Operands don't affect result (CONSTANT_EXPRESSION_RESULT)
> result_independent_of_operands: flags & (2U /* 1 << 1 */) &
> (command_bits & 4294967292U /* ~(1 | 2) */) is always 0 regardless of
> the values of its operands. This occurs as the logical operand of if.
>
> 4128        WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) &
> (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
>
> This is a result of 3448a19da479 "vgaarb: use bridges to control VGA
> routing where possible."
>
> I wonder if that middle "&" was intended to be "&&"?

must be. otherwise always get 0.
