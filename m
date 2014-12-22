Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:32863 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbaLVTuz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 14:50:55 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so3801702qcv.36
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 11:50:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141222081743.GA5961@richard>
References: <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org> <20141208004735.GA15508@shangw>
 <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
 <1418074683.13358.1.camel@kernel.crashing.org> <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
 <20141208233855.GA15713@shangw> <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
 <20141220002306.GB30834@google.com> <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
 <20141222081743.GA5961@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Dec 2014 12:50:34 -0700
Message-ID: <CAErSpo693zHPwpUPdKcXVUoKh4-8j4=u8ra=55FGZ0tKstQHGw@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 22, 2014 at 1:17 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Fri, Dec 19, 2014 at 04:34:57PM -0800, Yinghai Lu wrote:
>>On Fri, Dec 19, 2014 at 4:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Mon, Dec 08, 2014 at 04:21:34PM -0800, Yinghai Lu wrote:
>>>
>>> I don't see any patches that resolve the regression (bug 85491) yet.  If we
>>> don't figure something out, I'm going to have to revert 5b28541552ef.
>>
>>As you don't like idea to clear the MEM64 bit in resource ...
>>
>>After this merging window, I would like to post 5 patches in
>>
>>https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/log/?h=for-pci-allocate-fit-3.18
>>that will make those two systems works with "pci=realloc".
>>
>>We could have another patch that enable pci=realloc when VGA bar get
>>rejected at the first point.
>>
>>The point is there is no performance difference between two solutions according
>>to Marek's test.
>
> One quick question.
>
> The patch in http://www.spinics.net/lists/linux-pci/msg37377.html doesn't use
> "pci=realloc" as it mentioned. And seem worked on Marek's machine.
>
> We wouldn't take it into consideration?

Nope.  https://lkml.org/lkml/2014/12/19/392
