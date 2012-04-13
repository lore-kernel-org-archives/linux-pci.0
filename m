Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:38320 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753534Ab2DMRi2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 13:38:28 -0400
Message-ID: <4F88647B.9070209@snewbury.org.uk>
Date: Fri, 13 Apr 2012 18:38:03 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: drm-next i915 regression? ( was: Re: PCI resources above 4GB)
References: <1334229754.30606.7.camel@Nokia-N900> <CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com> <1334248841.2910.6.camel@Nokia-N900> <CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com> <1334317529.2910.21.camel@Nokia-N900> <4F8814F7.20808@snewbury.org.uk> <4F8820F0.5010607@snewbury.org.uk> <4F88297B.3020200@snewbury.org.uk> <1334325128.2910.24.camel@Nokia-N900> <4F883364.3080601@snewbury.org.uk> <20120413141305.GI4525@phenom.ffwll.local> <4F88360E.704@snewbury.org.uk> <4F8844E1.5080806@snewbury.org.uk> <4F884B21.604@snewbury.org.uk> <CAE9FiQVWSW9cQYuM8RWBVb4dP5vJJ_e=Ld7PSgchzhp6muYToA@mail.gmail.com>
In-Reply-To: <CAE9FiQVWSW9cQYuM8RWBVb4dP5vJJ_e=Ld7PSgchzhp6muYToA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/04/12 17:17, Yinghai Lu wrote:
>>> Looks like either a btrfs regression or bad interaction with 
>>> for-pci-res-alloc.  Oops attached.
>> Just hit the same oops on the rc1+for-pci-res-alloc kernel I
>> tried earlier so it's not definitely something new in the btrfs
>> code.  Seems like it's a 64/32bit pointer issue??
> 
> for-pci-res-alloc include
> 
> for-pci-hostbridge-cleanup for-pci-busn-alloc 
> for-pci-root-bus-hotplug for-pci-for-each-res-addon at plus 7
> patches.
> 
> maybe there is some problem with for-pci-for-each-res-addon.
> 
> just rebase for-pci-res-alloc to for-pci-root-bus-hotplug. Please 
> check if the problem still there.
> 
Still Oopses.  I'm going to try linus/master.  Perhaps it's a
filesystem corruption triggering it?  I do find it a little suspicious
that it occurs in "btrfs:find_workspace" though, code which deals with
memory allocations...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+IZHsACgkQGcb56gMuC62WhQCgkVBccCKKLqjL1S7f+4wzXnT7
DbsAn2wQNiQLGo95Q3W9bWu6n5Q3xqr8
=Rtn+
-----END PGP SIGNATURE-----
