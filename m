Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:43481 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab3EQTwj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2013 15:52:39 -0400
Received: by mail-ob0-f171.google.com with SMTP id ef5so5127645obb.30
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2013 12:52:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5196713A.1010102@ubuntu.com>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
 <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
 <5195596C.3000406@ubuntu.com> <CAErSpo6wSgquzJc22tFJozp8cfx0vpULnO3KZN2gr2YHt8EHrw@mail.gmail.com>
 <5196713A.1010102@ubuntu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 13:52:18 -0600
Message-ID: <CAErSpo7zESr5_PEyX=1JWEApCuW+yx+j3RKWh=qC-jReRgSXZw@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: Phillip Susi <psusi@ubuntu.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 17, 2013 at 12:04 PM, Phillip Susi <psusi@ubuntu.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 5/17/2013 1:31 PM, Bjorn Helgaas wrote:
>> You also have this bridge where lspci says "ASPM unknown":
>>
>> 00:01.0 bridge to [bus 01] ASPM unknown
>>
>> Just out of curiosity, can you collect the output of "lspci -xxxs
>> 00:01.0"?  There are only two bits in the Link Capabilities ASPM
>> support field, and all four encodings are defined, so I'm curious
>> about why lspci says "unknown".
>
> I'll get that as soon as I get home, but why would the ASPM status of
> the root complex have anything to do with the rest of the devices?
> Enabling ASPM on one link doesn't require it to be enabled on all
> upstream links does it?

Nope, that one shouldn't affect the other devices.  I was just curious.

I just sent a patch to make lspci decode all possible values there.
In the PCIe r2.1 spec, only 1 ("L0s") and 3 ("L0s and L1") were
defined.  The r3 spec added 0 ("not supported") and 2 ("L1"), but
lspci hadn't quite kept up.

Bjorn
