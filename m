Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120127102311.6027ea2c@jbarnes-desktop>
References: <1327140517-14811-1-git-send-email-yinghai@kernel.org>
	<1327140517-14811-19-git-send-email-yinghai@kernel.org>
	<20120127102311.6027ea2c@jbarnes-desktop>
Date: Fri, 27 Jan 2012 13:37:44 -0800
Message-ID: <CAE9FiQXQPFYU45rctaNX4kSqh7JGCnds8U-Bh1N93xVieuqz5Q@mail.gmail.com>
Subject: Re: [PATCH 18/21] PCI: Fix cardbus bridge resources as optional size handling
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 27, 2012 at 10:23 AM, Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> On Sat, 21 Jan 2012 02:08:34 -0800
> Yinghai Lu <yinghai@kernel.org> wrote:
>
>> We should not set the requested size to -2.
>>
>> that will confuse the resource list sorting with align when SIZEALIGN is used.
>>
>> Change to STARTALIGN and pass align from start.
>>
>> We are safe to do that just as we do that regular pci bridge.
>>
>> In the long run, we should just treat cardbus like regular pci bridge.
>>
>> Also fix when realloc is not passed, should keep the requested size.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>
> I'd like to see some testing on this one... Dominik?

Dominik,

Can you please test branch at

	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
for-pci2

Thanks

Yinghai
