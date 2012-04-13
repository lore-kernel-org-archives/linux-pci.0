Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:53573 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754648Ab2DMOUS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 10:20:18 -0400
Message-ID: <4F88360E.704@snewbury.org.uk>
Date: Fri, 13 Apr 2012 15:19:58 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Daniel Vetter <daniel@ffwll.ch>
CC: linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: drm-next i915 regression? ( was: Re: PCI resources above 4GB)
References: <1334229754.30606.7.camel@Nokia-N900> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com> <1334317529.2910.21.camel@Nokia-N900> <4F8814F7.20808@snewbury.org.uk> <4F8820F0.5010607@snewbury.org.uk> <4F88297B.3020200@snewbury.org.uk> <1334325128.2910.24.camel@Nokia-N900> <4F883364.3080601@snewbury.org.uk> <20120413141305.GI4525@phenom.ffwll.local>
In-Reply-To: <20120413141305.GI4525@phenom.ffwll.local>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/04/12 15:13, Daniel Vetter wrote:
> On Fri, Apr 13, 2012 at 03:08:36PM +0100, Steven Newbury wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 13/04/12 14:52, Steven Newbury wrote:
>>> On Fri, 13 Apr 2012, 14:26:19 BST, Steven Newbury 
>>> <steve@snewbury.org.uk> wrote:
>>> 
>>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>> 
>>>> On 13/04/12 13:49, Steven Newbury wrote:
>>>>> On 13/04/12 12:58, Steven Newbury wrote:
>>>>> 
>>>>>>> It's not stable, crashes soon after GMA comes up.
>>>>>>> (Could be unrelated breakage in linus/master? Probably
>>>>>>> not but I will verify.)   I noticed the high
>>>>>>> allocations are occuring from the top of 64-bit
>>>>>>> address-space, whilst /proc/cpuinfo shows only 48 bits
>>>>>>> of virtual addressing.   Could that be why..?
>>>>>> To reply to myself again, I should have said crashes
>>>>>> shortly after Xorg initialises using the intel driver, in
>>>>>> both cases! I'm building a kernel now without the patch
>>>>>> set to see if it's unrelated.   If it still dies I'll try
>>>>>> applying your patch set to a branch without the changes
>>>>>> from linus/master... (should have done that anyway...)
>>>>> 
>>>>> Okay, I instead created a branch from an older 3.4-rc1+
>>>>> kernel tree, running it now, and it seems to be stable.
>>>>> Something perhaps in the newer tree not playing nicely.
>>>>> I'll see if I can bisect it, or at least base of rc2 if
>>>>> that works... (I'm a little wary of crashing the system too
>>>>> much and losing my btrfs filesystem...)
>>>> rc2 is fine as well.   Not sure what happened there, I need
>>>> to be more careful about keeping a clean tree to work from.
>>> I'm pretty sure the crash was a from a drm-next regression.
>>> I'll try bisecting it....
>> Sorry, posted too soon!  Almost as I clicked on send it froze
>> again (using rc2 + for-pci-res-alloc ).  I had problems with the
>> earlier patches re. X/i915 stability.  Strange.  I'll see if I
>> can track it down.
> 
> Please upgrade to the latest version of Linus' upstream git. A few
> fixes for regressions in drm/i915 just landed there for -rc3. 
> -Daniel

Okay.  I'll try clean latest linus + for-pci-res-alloc.  Will report back.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+INg4ACgkQGcb56gMuC60pJgCfS/g2k3mzIqU34de/Y4wTvfCP
+hwAmQEEdgQ/y0QvDbPffNZ6izqs2Dce
=EGwB
-----END PGP SIGNATURE-----
