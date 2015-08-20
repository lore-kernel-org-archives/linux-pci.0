Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37919 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbbHTGQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2015 02:16:27 -0400
Received: by wicja10 with SMTP id ja10so26551459wic.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2015 23:16:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55CBCF96.7060102@intel.com>
References: <20150812233914.451d1fcf@canb.auug.org.au> <55CB8AF0.4060905@infradead.org>
 <20150813075322.064035f8@canb.auug.org.au> <55CBCF96.7060102@intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Aug 2015 23:16:06 -0700
Message-ID: <CAErSpo4+H6AJs9shVGN8fm9=GwPL9EzNcyMNt5FW81JGEA1sDA@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 12 (include/linux/pci.h)
To: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-next list <linux-next@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Michal Marek <mmarek@suse.cz>,
	"Yann E. MORIN" <yann.morin.1998@free.fr>,
	linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yann, linux-kbuild]

On Wed, Aug 12, 2015 at 3:58 PM, Tadeusz Struk <tadeusz.struk@intel.com> wrote:
> On 08/12/2015 02:53 PM, Stephen Rothwell wrote:
>> On Wed, 12 Aug 2015 11:05:36 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>> >
>>> > on i386 or x86_64:
>>> >
>>> > Many (repeated) errors like this one:
>>> >
>>> > ../include/linux/pci.h:390:12: error: â€˜struct pci_devâ€™ has no member named â€˜physfnâ€™
>>> >
>>> > when CONFIG_PCI_ATS is not enabled.
>> Maybe caused by commit
>>
>>   dd0f368398ea ("crypto: qat - Add qat dh895xcc VF driver")
>>
>> from the crypto tree Which adds a
>>
>>   select PCI_IOV
>>
>> to drivers/crypto/qat/Kconfig without the necessary
>>
>>   select PCI
>>
>> but PCI_IOV selects PCI_ATS, so I am not sure what happened here.  I am
>> assuming that your config has PCI_IOV enabled?  What about PCI?
>
> There is a patch submitted, but not yet applied
> https://patchwork.kernel.org/patch/6994171/
> maybe it will help?

I don't understand this.  In drivers/pci/Kconfig, we have:

  config PCI_IOV
    depends on PCI

and in drivers/crypto/qat/Kconfig, dd0f368398ea adds:

  config CRYPTO_DEV_QAT_DH895xCCVF
    select PCI_IOV

And apparently it's possible to end up with a .config with
CONFIG_PCI_IOV=y but CONFIG_PCI is not set?  That seems wrong, since
we declared that PCI_IOV depends on PCI.  Does select ignore that
dependency somehow?

Bjorn
