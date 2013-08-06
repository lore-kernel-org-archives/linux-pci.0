Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:35725 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab3HFR7B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 13:59:01 -0400
Received: by mail-qe0-f41.google.com with SMTP id a11so410454qen.28
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2013 10:59:00 -0700 (PDT)
Date: Tue, 6 Aug 2013 11:58:56 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] PCI: fix the io resource alignment calculation in
 pbus_size_io()
Message-ID: <20130806175856.GA1246@google.com>
References: <CAErSpo5Lv7-Op3hg_ZRgSjzMNYZpZGphQFJyxxP6B8xLpwrSkw@mail.gmail.com>
 <CAE9FiQU3DSZGFSENxy84bQ_URurWUAh2secoq5KN7c3BVXb9OQ@mail.gmail.com>
 <20130805195149.GA19127@google.com>
 <CAE9FiQXjL+=9XqUiFCmJNkU8vedbjs82cvxjGGBZnzaWN0HgTg@mail.gmail.com>
 <CAErSpo4ANAE3ggEcaJhFvGEpP48y37CxnXedn6cFt1gscPR-gw@mail.gmail.com>
 <CAE9FiQVJZWFBvOJPna_CFo=Pt2hGXmx39Q278f+0BOwV_38oRQ@mail.gmail.com>
 <20130805222135.GA29875@google.com>
 <20130806061534.GA10876@weiyang.vnet.ibm.com>
 <20130806133929.GB31970@google.com>
 <20130806153410.GA10680@weiyang.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130806153410.GA10680@weiyang.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 06, 2013 at 11:34:10PM +0800, Wei Yang wrote:
> On Tue, Aug 06, 2013 at 07:39:29AM -0600, Bjorn Helgaas wrote:
> >> Personal Conclusion
> >> ============================================================================
> >> I think Bjorn's patch works.
> >> Will test on powernv platform and give the result.
> >
> >Great, let me know what happens.
> 
> In both case, with/with out your patch, the assignment result is the same.
> Below is the /proc/ioports file.
> 
> 00010000-0080ffff : /io-hub@3efe00000000/pciex@3efe00080000
>   00010000-00010fff : Legacy IO
>   00020000-0003ffff : PCI Bus 0000:01
>     00020000-0003ffff : PCI Bus 0000:02
>       00020000-0002ffff : PCI Bus 0000:40
>       00030000-0003ffff : PCI Bus 0000:a0
> 00820000-0101ffff : /io-hub@3efe00000000/pciex@3efe00090000
>   00820000-00820fff : Legacy IO
>   00830000-0083ffff : PCI Bus 0001:01
> 01030000-0182ffff : /io-hub@3efe00000000/pciex@3efe000a0000
>   01030000-01030fff : Legacy IO
>   01040000-0104ffff : PCI Bus 0002:01
> 01840000-0203ffff : /io-hub@3efe00000000/pciex@3efe000b0000
>   01840000-01840fff : Legacy IO
>   01850000-0185ffff : PCI Bus 0003:01
> 02050000-0284ffff : /io-hub@3efe00000000/pciex@3efe000c0000
>   02050000-02050fff : Legacy IO
>   02060000-0206ffff : PCI Bus 0004:01
> 02860000-0305ffff : /io-hub@3efe00000000/pciex@3efe000d0000
>   02860000-02860fff : Legacy IO
>   02870000-0287ffff : PCI Bus 0005:01
> 
> The arch_align is 0x10000. When sizing for Bus 0000:01, its child has a I/O
> bridge window with size 0x20000/alignment 0x10000. And the result
> [0x20000,0x3ffff] looks like size 0x20000/alignment 0x20000 or size
> 0x20000/alignment 0x10000. 

Obviously, an address with alignment of 0x20000 is *also* aligned to
0x10000.

> But I still think the alignment is 0x10000.

Yes, as it should be.  These are all bridge windows, which never have to be
aligned at more than 1K (if supported), 4K, or the arch alignment,
whichever is largest.

I *think* you're saying that the patch works correctly.

Bjorn
