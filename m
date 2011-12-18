Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:41098 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751224Ab1LRFwF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2011 00:52:05 -0500
References: <20111217092935.2c2e075e@jbarnes-desktop> <CAE9FiQWueS=9aSAH4fLz=EpE=A_WanKU6pbfnR2a4gsymWjnDA@mail.gmail.com>
In-Reply-To: <CAE9FiQWueS=9aSAH4fLz=EpE=A_WanKU6pbfnR2a4gsymWjnDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [git pull] PCI fixes
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Sat, 17 Dec 2011 21:52:13 -0800
To: Yinghai Lu <yinghai@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
CC: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <dfbb748b-b9de-4390-bb8d-138fc4c5734f@email.android.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yinghai Lu <yinghai@kernel.org> wrote:

>On Sat, Dec 17, 2011 at 9:29 AM, Jesse Barnes
><jbarnes@virtuousgeek.org> wrote:
>> Ram Pai (1):
>>      PCI: defer enablement of SRIOV BARS
>
>oh, no!
>
>It seems you let the old version slip into linus tree.
>
>Now we need attached patch get into linus tree.
>
>Thanks
>
>Yinghai Lu

Crap, and after you guys spent so long coming up with a clean version.

Linus, can you just apply this one on top? I think it's the one Yinghai and Ram agreed to. 

Thanks, 
Jesse
-- 
Jesse Barnes, Intel Open Source Technology Center
