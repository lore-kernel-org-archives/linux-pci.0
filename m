Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-pci@vger.kernel.org, timur@codeaurora.org
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
 <1513680330.7000.167.camel@linux.intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
Date: Tue, 19 Dec 2017 07:17:41 -0500
MIME-Version: 1.0
In-Reply-To: <1513680330.7000.167.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kees Cook <keescook@chromium.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 Tobias Klauser <tklauser@distanz.ch>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 12/19/2017 5:45 AM, Andy Shevchenko wrote:
> On Tue, 2017-12-19 at 00:37 -0500, Sinan Kaya wrote:
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> where a PCI device is present. This restricts the device drivers to be
>> reused for other domain numbers.
>>
>> Getting ready to remove pci_get_bus_and_slot() function in favor of
>> pci_get_domain_bus_and_slot().
>>
> 
> Where this idea come from?

There are systems out (mostly ARM) there with non-zero segment numbers. The
pci_get_bus_and_slot() API is restrictive and unnecessarily forces 0 segment
numbers for some generic device drivers. Obtaining the segment number is as
easy as calling pci_domain_nr().

The problems with pci_get_bus_and_slot() are:

1. we don't know if the device driver intentionally called pci_get_bus_and_slot()
to limit 0 segment number.
2. we don't know if the driver developer just copied an example from another
system and it just happened to work on x86 architecture while broken on other
architectures.

Some device drivers may want to limit the segment number. Than specifying 0
while calling pci_get_domain_bus_and_slot() is a better way to express this.

pci_get_bus_and_slot() is unnecessarily restricting some device drivers. Nvidia
as an example. I remember that somebody came up with a very ugly patch to force
segment 0 into Microsoft hypervisor layer. 

This was rejected out right and told to fix the Nvidia driver instead. This patch
essentially fixes some of these flaws while removing the limiting API from the
kernel altogether so that same mistakes are not made.

> 
> pci_get_bus_and_slot() still might be useful for the wired devices in
> SoC where we know for sure that domain == 0.
> 

Then hard code the domain number as 0 while calling pci_get_domain_bus_and_slot()
if you know for sure that this device will never work on a non-zero domain.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
