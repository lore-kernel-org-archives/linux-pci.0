Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150902163914.34988848@canb.auug.org.au>
References: <CAJZ5v0j71Zwe8H7Lais82+N97-eF==Yjf4SPnb40kdyBLu2THw@mail.gmail.com>
	<20150902163914.34988848@canb.auug.org.au>
Date: Wed, 2 Sep 2015 14:40:54 +0200
Message-ID: <CAJZ5v0hGhjwvYHqNcgSZd0ou4gScfA0XqKiSfafXUDTvrz3dRQ@mail.gmail.com>
Subject: Re: [GIT PULL] Power management and ACPI updates for v4.3-rc1
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Sep 2, 2015 at 8:39 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Linus,
>
> On Wed, 2 Sep 2015 01:41:11 +0200 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>
>> Hi Linus,
>>
>> Please pull from
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>  pm+acpi-4.3-rc1
>>
>> to receive power management and ACPI material for v4.3-rc1 with
>> top-most commit e625ccec1fa6c24620f38fd72d5b2fd62230ad2b
>>
>>  Merge branches 'pm-tools' and 'powercap'
>>
>> on top of commit 64291f7db5bd8150a74ad2036f1037e6a0428df2
>>
>>  Linux 4.2
>
> So there are about 20 commits in here that have not been in linux-next
> (unless they have bee rebased) and about 10 of those will be in today's
> linux-next.  Not judging, just notiing.

I needed to apply some of them (in the cpufreq branch) afresh because
I originally took them from Patchwork and I didn't notice that it
mangled the From: tags in them.

All of them were ready last week and went through the 0-day build
testing, though.

Thanks,
Rafael
