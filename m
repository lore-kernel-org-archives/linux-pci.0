Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46260 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbaLIAVf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Dec 2014 19:21:35 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so5581995ieb.12
        for <linux-pci@vger.kernel.org>; Mon, 08 Dec 2014 16:21:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141208233855.GA15713@shangw>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	<CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
	<CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
	<20141204173411.GA5949@google.com>
	<CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
	<1417777177.4741.69.camel@kernel.crashing.org>
	<20141208004735.GA15508@shangw>
	<CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
	<1418074683.13358.1.camel@kernel.crashing.org>
	<CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
	<20141208233855.GA15713@shangw>
Date: Mon, 8 Dec 2014 16:21:34 -0800
Message-ID: <CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
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

On Mon, Dec 8, 2014 at 3:38 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> On Mon, Dec 08, 2014 at 02:46:00PM -0700, Bjorn Helgaas wrote:
>>Yeah, I didn't word that very clearly.  I meant that after
>>5b28541552ef, that 64-bit window is wasted unless there's a 64-bit BAR
>>below it; we can't even place the window below 4GB and use it for
>>32-bit prefetchable BARs.
>>
>
> Yes, I agree. It's why I suggested to return error from pbus_size_mem()
> to indicate the case: 64-bits prefetchable window isn't used and it's
> still available to be used by child 32-bits prefetchable BARs. Please
> take a look on the attached draft patch, which helps to explain the idea
> only.

That would not help. The 00:01.0 on Zermond's system support hotplug. so mem
pref will be used for 64bit pref.
