Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:43530 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3EURjO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2013 13:39:14 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so2523598iec.11
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2013 10:39:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4jW3v5CTDAoqNqr-q9BNFPPFjHuy3BcrgjQumQ8HGVNg@mail.gmail.com>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
	<CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
	<1367740336.11982.41.camel@pasglop>
	<51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
	<1367837311.15842.31.camel@pasglop>
	<CAE9FiQU=ZEfvVKeQgVOa0jeG5smJrKRaeLTOckR=v2vzTyTvLw@mail.gmail.com>
	<5188b791.a110420a.0bea.077eSMTPIN_ADDED_BROKEN@mx.google.com>
	<CAE9FiQUc2q0GfVumVrp3_ba0q6N_a_WxjKhMWbyqbLfO=WGaFQ@mail.gmail.com>
	<1368768974.20726.1.camel@pasglop>
	<CAErSpo4jW3v5CTDAoqNqr-q9BNFPPFjHuy3BcrgjQumQ8HGVNg@mail.gmail.com>
Date: Tue, 21 May 2013 10:39:14 -0700
Message-ID: <CAE9FiQWiQfCrja05fNK5_-WiHPXXt4Dnw6gT=e_gMvtZUxmkNw@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 21, 2013 at 10:28 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 16, 2013 at 11:36 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Tue, 2013-05-07 at 15:21 -0700, Yinghai Lu wrote:
>>> I just sent v3, please test that.
>>>
>>> That should be less invasive for v3.10. As it will skip adding failed
>>> resource to failed list when the resource is IORESOURCE_IO, and bus
>>> does not have IORESOURCE_IO.
>>
>> Any news about merging this ?
>
> I'm starting to look at this.  Do you think this is v3.10 material?
> My first impression is that it seems pretty large for that.

Maybe could put first two for 3.10, and other three for v3.11.

Yinghai
