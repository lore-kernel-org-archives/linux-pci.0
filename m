Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUEJ4Jvz0BHJ8LCBNpXWB3Cf6u3k9F1avAd4a-fkGOB=Q@mail.gmail.com>
References: <1332135996-13860-1-git-send-email-yinghai@kernel.org>
 <1332135996-13860-41-git-send-email-yinghai@kernel.org> <4F7F10C5.1050901@gmail.com>
 <CAE9FiQUEJ4Jvz0BHJ8LCBNpXWB3Cf6u3k9F1avAd4a-fkGOB=Q@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 6 Apr 2012 10:07:03 -0600
Message-ID: <CAErSpo6gitMTVXeMBOSJFRHvQT_iJ-RGmLduYsGEM+3YAPE2CQ@mail.gmail.com>
Subject: Re: [PATCH -v3 40/47] PCI: Add pci bus removal through /sys/.../pci_bus/.../remove
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jiang Liu <liuj97@gmail.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 6, 2012 at 10:01 AM, Yinghai Lu <yhlu.kernel@gmail.com> wrote:
> On Fri, Apr 6, 2012 at 8:50 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> Hi Yinghai,
>>        I found many other drivers assume that a pci bus won't disappear if
>> the corresponding PCI bridge device still exists. The sysfs interface proposed
>> here breaks that assumption and may cause many access-after-free issues.
>> So what's the purpose of this interface? Should we remove this interface or
>> enhance other drivers to avoid invalid memory access issues?

Can you point out some of the specifics about drivers making this
assumption?  I'm not thrilled about the idea of removing a pci_bus
while the upstream bridge pci_dev still exists either.

> ok, will make it only show up on root bus.

OK.  I'm still interested in the specifics because I don't like the
way the pci_bus is exposed, even inside the kernel.  The bus itself is
not an active entity, and we can't really do anything with it except
by touching a device connected to it.

Bjorn
