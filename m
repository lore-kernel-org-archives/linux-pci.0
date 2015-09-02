Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:58867 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbbIBGjQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 2 Sep 2015 02:39:16 -0400
Date: Wed, 2 Sep 2015 16:39:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [GIT PULL] Power management and ACPI updates for v4.3-rc1
Message-ID: <20150902163914.34988848@canb.auug.org.au>
In-Reply-To: <CAJZ5v0j71Zwe8H7Lais82+N97-eF==Yjf4SPnb40kdyBLu2THw@mail.gmail.com>
References: <CAJZ5v0j71Zwe8H7Lais82+N97-eF==Yjf4SPnb40kdyBLu2THw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

On Wed, 2 Sep 2015 01:41:11 +0200 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> Hi Linus,
> 
> Please pull from
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm+acpi-4.3-rc1
> 
> to receive power management and ACPI material for v4.3-rc1 with
> top-most commit e625ccec1fa6c24620f38fd72d5b2fd62230ad2b
> 
>  Merge branches 'pm-tools' and 'powercap'
> 
> on top of commit 64291f7db5bd8150a74ad2036f1037e6a0428df2
> 
>  Linux 4.2

So there are about 20 commits in here that have not been in linux-next
(unless they have bee rebased) and about 10 of those will be in today's
linux-next.  Not judging, just notiing.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
