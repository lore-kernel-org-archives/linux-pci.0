Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33599 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbaDDAC4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 20:02:56 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so2697408iec.30
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 17:02:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7uQtRXcxC-9oAS8PJ6Vi3H8Z1fVB2wQR-uxGjyoLDkCQ@mail.gmail.com>
References: <CAErSpo7uQtRXcxC-9oAS8PJ6Vi3H8Z1fVB2wQR-uxGjyoLDkCQ@mail.gmail.com>
Date: Thu, 3 Apr 2014 17:02:55 -0700
Message-ID: <CAE9FiQV_ww7VAHaqhe4PuTA2WoxCaZ2vfAbr09xH0w5UkbenWw@mail.gmail.com>
Subject: Re: Coverity CIDs 138749, 138750: cnb20le_res() unintended sign extension
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 3, 2014 at 1:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Coverity complains about unintended sign extension in cnb20le_res() in
> arch/x86/pci/broadcom_bus.c here:
>
> 60        word1 = read_pci_config_16(bus, slot, func, 0xc4);
>  61        word2 = read_pci_config_16(bus, slot, func, 0xc6);
>  62        if (word1 != word2) {
>
> CID 138749 (#1 of 2): Unintended sign extension (SIGN_EXTENSION)
> sign_extension: Suspicious implicit sign extension: word1 with type
> unsigned short (16 bits, unsigned) is promoted in (word1 << 16) | 0 to
> type int (32 bits, signed), then sign-extended to type unsigned long
> long (64 bits, unsigned). If (word1 << 16) | 0 is greater than
> 0x7FFFFFFF, the upper bits of the result will all be 1.
>  63                res.start = (word1 << 16) | 0x0000;
>     CID 138750: Unintended sign extension (SIGN_EXTENSION) [select issue]
>  64                res.end   = (word2 << 16) | 0xffff;
>  65                res.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
>  66                update_res(info, res.start, res.end, res.flags, 0);
>  67        }

could just add (resource_size_t) cast for word1 word2.

Thanks

Yinghai
