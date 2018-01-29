Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4 05/26] agp: nvidia: deprecate pci_get_bus_and_slot()
To: Dave Airlie <airlied@gmail.com>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-6-git-send-email-okaya@codeaurora.org>
 <9b3cf544-173e-2450-589c-4bf14af307f2@codeaurora.org>
 <CAPM=9tzWpgF3mtq+ztKJ=P1Nw3Vh8ZEUfYH8Ep=+fRDZTbTtUg@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4fd0d418-ff34-8a3f-a233-5cdf80fe744f@codeaurora.org>
Date: Mon, 29 Jan 2018 17:01:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAPM=9tzWpgF3mtq+ztKJ=P1Nw3Vh8ZEUfYH8Ep=+fRDZTbTtUg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@linux.ie>, Linux PCI <linux-pci@vger.kernel.org>,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 1/29/2018 4:43 PM, Dave Airlie wrote:
>>  12/19/2017 12:37 AM, Sinan Kaya wrote:
>>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>>> where a PCI device is present. This restricts the device drivers to be
>>> reused for other domain numbers.
> So not a major problem, but it would be pretty much impossible for either
> of these agp drivers to be used in any other domain ever.
> 
> What does this buy us, maybe just rename pci_get_bus_and_slot to
> pci_get_domain0_bus_and_slot as a helper, or just pass the pdev in
> and have it do the right thing always.

There is nothing wrong with doing all three. Since nobody replied until
patch v4, I did the heavy-lifting and converted code to use pci_domain_nr()
as much as I can rather than hard-coding a 0 while calling
pci_get_domain_bus_and_slot().

>From PCI coding perspective, pci_domain_nr() call is the right thing. It is
guaranteed to work no matter what your domain number is. 

People look at other code for examples on how to write a PCI driver
in general. You want to minimize the exceptions as much as possible.

Some discussion here about the benefits:

https://lkml.org/lkml/2017/12/19/349


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
