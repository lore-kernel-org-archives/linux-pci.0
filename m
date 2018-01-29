Return-Path: <SRS0=S8NQ=EY=gmail.com=airlied@kernel.org>
Return-Path: <SRS0=S8NQ=EY=gmail.com=airlied@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180129223821.GE232763@bhelgaas-glaptop.roam.corp.google.com>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-6-git-send-email-okaya@codeaurora.org> <9b3cf544-173e-2450-589c-4bf14af307f2@codeaurora.org>
 <CAPM=9tzWpgF3mtq+ztKJ=P1Nw3Vh8ZEUfYH8Ep=+fRDZTbTtUg@mail.gmail.com> <20180129223821.GE232763@bhelgaas-glaptop.roam.corp.google.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 30 Jan 2018 08:43:37 +1000
Message-ID: <CAPM=9tzA19rHudfFWMpv_J9ctCs5QYU-o3BBooixLm_LyeV6zQ@mail.gmail.com>
Subject: Re: [PATCH V4 05/26] agp: nvidia: deprecate pci_get_bus_and_slot()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Airlie <airlied@linux.ie>,
	Linux PCI <linux-pci@vger.kernel.org>, timur@codeaurora.org,
	open list <linux-kernel@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 30 January 2018 at 08:38, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jan 30, 2018 at 07:43:21AM +1000, Dave Airlie wrote:
>> On 3 January 2018 at 22:44, Sinan Kaya <okaya@codeaurora.org> wrote:
>> > On 12/19/2017 12:37 AM, Sinan Kaya wrote:
>> >> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> >> where a PCI device is present. This restricts the device drivers to be
>> >> reused for other domain numbers.
>>
>> So not a major problem, but it would be pretty much impossible for either
>> of these agp drivers to be used in any other domain ever.
>>
>> What does this buy us, maybe just rename pci_get_bus_and_slot to
>> pci_get_domain0_bus_and_slot as a helper, or just pass the pdev in
>> and have it do the right thing always.
>
> I already have this patch on my "next" branch, planned for the v4.16
> merge window, so it's done unless you have a major objection.

Yeah I don't really care either way, I just can't seen the point in changing
agp drivers that definitely will never see a domain, but if it gets
rid of a dumb API,
so be it.

Dave.
