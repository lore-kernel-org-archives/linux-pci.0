Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <507E6355.40904@huawei.com>
References: <CAE9FiQWFcVNKMnV1qaHchwCXfZuMpyxf_f7GQy3FZid9YuLD3w@mail.gmail.com>
	<1348080894-23412-1-git-send-email-yinghai@kernel.org>
	<507E6355.40904@huawei.com>
Date: Wed, 17 Oct 2012 09:19:52 -0700
Message-ID: <CAE9FiQWW2zMK0fQ1RGox653PNxoH_RY_X8N4Oh_osu8Pt9gWpg@mail.gmail.com>
Subject: Re: [PATCH 00/40] PCI, ACPI, x86: pci root bus hotplug support
From: Yinghai Lu <yinghai@kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Jiang Liu <jiang.liu@huawei.com>, x86 <x86@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 17, 2012 at 12:50 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2012/9/20 2:54, Yinghai Lu wrote:
>
> Hi Yinghai,
>    I applied this series patches to the latest pci-next, but git am fail occured.
> When I try to pull from for-pci-root-bus-hotplug branch, I found some patches missed(eg. SCI_EMULATE).
> Where can I get the newest pci root bus hotplug patches?

should be
for-pci-split-pci-root-hp-2
or
for-pci-next-2
branch.

but
>> part6: acpi add/remove simulation
>> [PATCH 40/40] ACPI: Enable SCI_EMULATE to manually simulate physical

is not in. you need to apply that separately.
