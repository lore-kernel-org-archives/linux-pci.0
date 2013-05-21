Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:55552 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab3EUR2v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2013 13:28:51 -0400
Received: by mail-ob0-f179.google.com with SMTP id wd20so1066236obb.38
        for <linux-pci@vger.kernel.org>; Tue, 21 May 2013 10:28:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1368768974.20726.1.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop> <1367712932.11982.20.camel@pasglop>
 <CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
 <1367732090.11982.38.camel@pasglop> <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
 <1367740336.11982.41.camel@pasglop> <51871088.4594420a.0ccc.7300SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAE9FiQXGUOM_h_X5tdGbkiuZGZkiFigSLbbftx3YXybFBg6trg@mail.gmail.com>
 <1367837311.15842.31.camel@pasglop> <CAE9FiQU=ZEfvVKeQgVOa0jeG5smJrKRaeLTOckR=v2vzTyTvLw@mail.gmail.com>
 <5188b791.a110420a.0bea.077eSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAE9FiQUc2q0GfVumVrp3_ba0q6N_a_WxjKhMWbyqbLfO=WGaFQ@mail.gmail.com> <1368768974.20726.1.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 21 May 2013 11:28:30 -0600
Message-ID: <CAErSpo4jW3v5CTDAoqNqr-q9BNFPPFjHuy3BcrgjQumQ8HGVNg@mail.gmail.com>
Subject: Re: Resource assignment oddities
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 11:36 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2013-05-07 at 15:21 -0700, Yinghai Lu wrote:
>> I just sent v3, please test that.
>>
>> That should be less invasive for v3.10. As it will skip adding failed
>> resource to failed list when the resource is IORESOURCE_IO, and bus
>> does not have IORESOURCE_IO.
>
> Any news about merging this ?

I'm starting to look at this.  Do you think this is v3.10 material?
My first impression is that it seems pretty large for that.

Bjorn
