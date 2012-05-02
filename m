Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62555 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752806Ab2EBQD7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 May 2012 12:03:59 -0400
Received: by lahj13 with SMTP id j13so555318lah.19
        for <linux-pci@vger.kernel.org>; Wed, 02 May 2012 09:03:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <403610A45A2B5242BD291EDAE8B37D300FDA2550@SHSMSX102.ccr.corp.intel.com>
References: <403610A45A2B5242BD291EDAE8B37D300FD24698@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4Dm45uRsvdzSAfrvGNPPA_7QqvC_Se-JxpJErsasoTKw@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD3ABC3@SHSMSX101.ccr.corp.intel.com>
 <CAErSpo4Qm1DP-i2YWc1ZibiUAnPC-tLG9X0xceAvGFxs8e+mPQ@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD8BEA9@SHSMSX102.ccr.corp.intel.com>
 <CAErSpo4tUnA6oFr1uXyfVPHQh7F-LMN913pu=MfaEsRi5isLLQ@mail.gmail.com>
 <403610A45A2B5242BD291EDAE8B37D300FD906DD@SHSMSX102.ccr.corp.intel.com>
 <20120427174141.GA11634@google.com> <403610A45A2B5242BD291EDAE8B37D300FDA2550@SHSMSX102.ccr.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 2 May 2012 10:03:37 -0600
Message-ID: <CAErSpo40-Wh_Kx_e1ZVnqduEREibrK70ecA5ENSDPH4WKkdvBg@mail.gmail.com>
Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
To: "Hao, Xudong" <xudong.hao@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@linux.intel.com>,
	"Zhang, Xiantao" <xiantao.zhang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 1, 2012 at 6:37 PM, Hao, Xudong <xudong.hao@intel.com> wrote:
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Saturday, April 28, 2012 1:42 AM
>> To: Hao, Xudong
>> Cc: linux-pci@vger.kernel.org; Don Dutile; Matthew Wilcox; Zhang, Xiantao
>> Subject: Re: [PATCH v6] Quirk for IVB graphics FLR errata
>>
>> On Fri, Apr 27, 2012 at 01:26:18AM +0000, Hao, Xudong wrote:
>> > Maybe something configuration wrong on my mail client, I attach the patch
>> as an attachment, can you open it in your side?
>>
>> Yes, I could open the attachment.  But it makes it easier for everybody to
>> read & review your patches if you can figure out how to post patches
>> directly in the message rather than as an attachment.
>>
>
> Sure, I'm trying configure my email, make it better to work.
>
>> Here's an updated version of your patch.  I changed the following:
>>
>>     - Wrapped changelog text so it fits nicely for "git log".
>>     - Added #define for 0xd0100 offset (please supply a more useful name).
>>     - Used pci_iomap() and ioread32()/iowrite32().
>>     - Used msleep() rather than spinning (Matthew suggested this earlier,
>>       but you apparently missed it).  Note that I went back to your
>>       original "do {} while ()" structure to make sure we read PCH_PP_STATUS
>>       at least once.
>>     - Added message if reset times out.
>>
>> This is still x86-specific code that clutters all other architectures.  We
>> might fix this someday by adding a DECLARE_PCI_FIXUP_RESET(), so the IVB
>> code could live in arch/x86, and the linker could still collect all the
>> device-specific reset methods.  But I haven't done that yet.
>>
>> Please test and comment on this (and supply a name for 0xd0100):
>>
>
> We can named 0xd0100 "NSDE_PWR_STATE" instead of "XXXX" in code.
>
> Testing done, patch works.
>
> I do not send patch again, can you replace XXXX to NSDE_PWR_STATE and apply this patch?

Fixed up and applied to my "next" branch, thanks.

Bjorn
