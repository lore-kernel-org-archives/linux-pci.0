Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58012 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab2DMQRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2012 12:17:14 -0400
Received: by pbcun15 with SMTP id un15so3797302pbc.19
        for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 09:17:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F884B21.604@snewbury.org.uk>
References: <1334229754.30606.7.camel@Nokia-N900>
	<CAE9FiQXhzAOErMeQxz6U-BSYAK1LirHMpiFH90iRoXxwduPhPw@mail.gmail.com>
	<1334248841.2910.6.camel@Nokia-N900>
	<CAE9FiQXvHjW3pL4Nrb-3Oqw5Ht-7MqCL7_isL+Gm41qWOd1yRQ@mail.gmail.com>
	<1334317529.2910.21.camel@Nokia-N900>
	<4F8814F7.20808@snewbury.org.uk>
	<4F8820F0.5010607@snewbury.org.uk>
	<4F88297B.3020200@snewbury.org.uk>
	<1334325128.2910.24.camel@Nokia-N900>
	<4F883364.3080601@snewbury.org.uk>
	<20120413141305.GI4525@phenom.ffwll.local>
	<4F88360E.704@snewbury.org.uk>
	<4F8844E1.5080806@snewbury.org.uk>
	<4F884B21.604@snewbury.org.uk>
Date: Fri, 13 Apr 2012 09:17:13 -0700
Message-ID: <CAE9FiQVWSW9cQYuM8RWBVb4dP5vJJ_e=Ld7PSgchzhp6muYToA@mail.gmail.com>
Subject: Re: drm-next i915 regression? ( was: Re: PCI resources above 4GB)
From: Yinghai Lu <yinghai@kernel.org>
To: Steven Newbury <steve@snewbury.org.uk>
Cc: Daniel Vetter <daniel@ffwll.ch>, linux-pci@vger.kernel.org,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	"Barnes, Jesse" <jesse.barnes@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Looks like either a btrfs regression or bad interaction with
>> for-pci-res-alloc.  Oops attached.
> Just hit the same oops on the rc1+for-pci-res-alloc kernel I tried
> earlier so it's not definitely something new in the btrfs code.  Seems
> like it's a 64/32bit pointer issue??

for-pci-res-alloc include

for-pci-hostbridge-cleanup
for-pci-busn-alloc
for-pci-root-bus-hotplug
for-pci-for-each-res-addon
at plus 7 patches.

maybe there is some problem with for-pci-for-each-res-addon.

just rebase for-pci-res-alloc to for-pci-root-bus-hotplug. Please
check if the problem still there.

Thanks

Yinghai
