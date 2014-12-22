Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:33215 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaLVIRy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 03:17:54 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 22 Dec 2014 18:17:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 124B32BB0060
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 19:17:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBM8Hjst34275500
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 19:17:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBM8HiK7030683
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 19:17:45 +1100
Date: Mon, 22 Dec 2014 16:17:43 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Marek =?iso-8859-1?Q?Kord=EDk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141222081743.GA5961@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
 <1417777177.4741.69.camel@kernel.crashing.org>
 <20141208004735.GA15508@shangw>
 <CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
 <1418074683.13358.1.camel@kernel.crashing.org>
 <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
 <20141208233855.GA15713@shangw>
 <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
 <20141220002306.GB30834@google.com>
 <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 19, 2014 at 04:34:57PM -0800, Yinghai Lu wrote:
>On Fri, Dec 19, 2014 at 4:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Mon, Dec 08, 2014 at 04:21:34PM -0800, Yinghai Lu wrote:
>>
>> I don't see any patches that resolve the regression (bug 85491) yet.  If we
>> don't figure something out, I'm going to have to revert 5b28541552ef.
>
>As you don't like idea to clear the MEM64 bit in resource ...
>
>After this merging window, I would like to post 5 patches in
>
>https://git.kernel.org/cgit/linux/kernel/git/yinghai/linux-yinghai.git/log/?h=for-pci-allocate-fit-3.18
>that will make those two systems works with "pci=realloc".
>
>We could have another patch that enable pci=realloc when VGA bar get
>rejected at the first point.
>
>The point is there is no performance difference between two solutions according
>to Marek's test.

One quick question. 

The patch in http://www.spinics.net/lists/linux-pci/msg37377.html doesn't use
"pci=realloc" as it mentioned. And seem worked on Marek's machine.

We wouldn't take it into consideration?

>
>Thanks
>
>Yinghai

-- 
Richard Yang
Help you, Help me

