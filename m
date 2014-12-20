Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36566 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbaLTAe5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Dec 2014 19:34:57 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1650749ieb.7
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2014 16:34:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141220002306.GB30834@google.com>
References: <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
	<20141204173411.GA5949@google.com>
	<CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
	<1417777177.4741.69.camel@kernel.crashing.org>
	<20141208004735.GA15508@shangw>
	<CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
	<1418074683.13358.1.camel@kernel.crashing.org>
	<CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
	<20141208233855.GA15713@shangw>
	<CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
	<20141220002306.GB30834@google.com>
Date: Fri, 19 Dec 2014 16:34:57 -0800
Message-ID: <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 19, 2014 at 4:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Dec 08, 2014 at 04:21:34PM -0800, Yinghai Lu wrote:
>
> I don't see any patches that resolve the regression (bug 85491) yet.  If we
> don't figure something out, I'm going to have to revert 5b28541552ef.

As you don't like idea to clear the MEM64 bit in resource ...

After this merging window, I would like to post 5 patches in

https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/log/?h=for-pci-allocate-fit-3.18
that will make those two systems works with "pci=realloc".

We could have another patch that enable pci=realloc when VGA bar get
rejected at the first point.

The point is there is no performance difference between two solutions according
to Marek's test.

Thanks

Yinghai
