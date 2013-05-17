Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33250 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238Ab3EQFg1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 May 2013 01:36:27 -0400
Message-ID: <1368768974.20726.1.camel@pasglop>
Subject: Re: Resource assignment oddities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 17 May 2013 15:36:14 +1000
In-Reply-To: <CAE9FiQUc2q0GfVumVrp3_ba0q6N_a_WxjKhMWbyqbLfO=WGaFQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-05-07 at 15:21 -0700, Yinghai Lu wrote:
> I just sent v3, please test that.
> 
> That should be less invasive for v3.10. As it will skip adding failed
> resource to failed list when the resource is IORESOURCE_IO, and bus
> does not have IORESOURCE_IO.

Any news about merging this ?

Thanks !

Cheers,
Ben.


