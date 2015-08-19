Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33780 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbHSFah (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 01:30:37 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.1508190747360.5154@math.ut.ee>
References: <alpine.LRH.2.11.1507260929000.30065@math.ut.ee>
	<trinity-122a736f-3aac-4830-afc5-2abcd91792ea-1439820380917@3capp-gmx-bs71>
	<trinity-5720bef8-5a4c-4465-b9eb-622daaef650a-1439902901415@3capp-gmx-bs02>
	<alpine.LRH.2.20.1508182141200.24742@math.ut.ee>
	<55D38BE6.6080302@gmx.de>
	<CAE9FiQVUUN-SLO0U4G5CC6MEoXfb=bGd+f3bRgQprtaMHjsvpA@mail.gmail.com>
	<alpine.LRH.2.20.1508190747360.5154@math.ut.ee>
Date: Tue, 18 Aug 2015 22:30:36 -0700
Message-ID: <CAE9FiQW9hjDe2NBEfwQqcVZoJKqDjKT1P=7FcGjhVrF7wQW9+g@mail.gmail.com>
Subject: Re: Aw: A500 boot crash in 4.2.0-rc3-00246-g763e326
From: Yinghai Lu <yinghai@kernel.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 18, 2015 at 9:48 PM, Meelis Roos <mroos@linux.ee> wrote:
>> On Tue, Aug 18, 2015 at 12:47 PM, Helge Deller <deller@gmx.de> wrote:
>>
>> Then we should change to
>>
>> config PCI_BUS_ADDR_T_64BIT
>>        def_bool y if (ARCH_DMA_ADDR_T_64BIT || SPARC64)
>>        depends on PCI
>
> Why SPARC64? The problem happened on parisc.
>

so will not set PCI_BUS_ADDR_T_64BIT for parisc.
