Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:53089 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbaDCQsw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 12:48:52 -0400
Received: by mail-ig0-f177.google.com with SMTP id ur14so2059336igb.10
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 09:48:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo79w7n=kOUM7D+USA7tHGJ50Sggndun=LwTkeirVqKfvg@mail.gmail.com>
References: <CAErSpo79w7n=kOUM7D+USA7tHGJ50Sggndun=LwTkeirVqKfvg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Apr 2014 10:48:32 -0600
Message-ID: <CAErSpo4-sW3Ge55oAzz=Xm1rbU1UZWQ=jBKUtL28yeTx-YOapw@mail.gmail.com>
Subject: Re: Coverity CID 714665: vfio_ext_cap_len() use of uninitialized variable
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 3, 2014 at 9:53 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Coverity complains that "byte" is used uninitialized in
> drivers/vfio/pci/vfio_pci_config.c in vfio_ext_cap_len():
>
> 1139                        sts = byte & PCI_TPH_CAP_ST_MASK;
> 1140                        sts >>= PCI_TPH_CAP_ST_SHIFT;
> 1141                        return PCI_TPH_BASE_SIZEOF + round_up(sts * 2, 4);
>
> This is CID 714665.

I think "dword" was probably intended instead of "byte".  Changing
that would also fix CID 715156:

1136                if ((dword & PCI_TPH_CAP_LOC_MASK) == PCI_TPH_LOC_CAP) {
1137                        int sts;
1138
    CID 714665: Uninitialized scalar variable (UNINIT) [select issue]

CID 715156 (#1 of 1): Operands don't affect result (CONSTANT_EXPRESSION_RESULT)
result_independent_of_operands: byte & 0x7ff0000 is always 0
regardless of the values of its operands. This occurs as the operand
of assignment.
1139                        sts = byte & PCI_TPH_CAP_ST_MASK;

Bjorn
