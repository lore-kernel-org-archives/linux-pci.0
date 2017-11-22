Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 12/30] Drivers: ide: deprecate pci_get_bus_and_slot()
To: Greg KH <gregkh@linuxfoundation.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-13-git-send-email-okaya@codeaurora.org>
 <20171122075302.GB26583@kroah.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ae1b877c-1398-9099-4b00-d3d0c6ff9cb1@codeaurora.org>
Date: Wed, 22 Nov 2017 11:24:35 -0500
MIME-Version: 1.0
In-Reply-To: <20171122075302.GB26583@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IDE SUBSYSTEM" <linux-ide@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 2:53 AM, Greg KH wrote:
> On Wed, Nov 22, 2017 at 12:30:57AM -0500, Sinan Kaya wrote:
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> where a PCI device is present. This restricts the device drivers to be
>> reused for other domain numbers.
>>
>> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
>> extract the domain number. Other places, use the actual domain number from
>> the device.
> 
> While this is a great generic text, you might want to make it a bit more
> custom to each specific patch.  For example, you don't use a domain of 0
> in this one, so the text is a bit wrong and confusing if you look at it
> stand-alone.
> 
> I like the series and the idea, just fix up this text in some of the
> patches and you should be fine.

OK. Will do on the next version.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
