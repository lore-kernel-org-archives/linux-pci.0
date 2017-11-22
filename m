Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 30/30] PCI: remove pci_get_bus_and_slot() function
To: Greg KH <greg@kroah.com>, Timur Tabi <timur@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-31-git-send-email-okaya@codeaurora.org>
 <c0df99c9-9170-be3a-3789-6b25be30936f@codeaurora.org>
 <6a78596e-720a-80a2-9d96-dcc79a32f677@codeaurora.org>
 <25ec431a-2c1b-d352-f9ef-c663864664b6@codeaurora.org>
 <20171122075124.GA26583@kroah.com>
 <a443e88e-3abd-0dab-2828-9753326e8d5d@codeaurora.org>
 <20171122144959.GA8081@kroah.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3b1e00b6-c193-8767-ba23-8a8b3eb41e90@codeaurora.org>
Date: Wed, 22 Nov 2017 10:18:15 -0500
MIME-Version: 1.0
In-Reply-To: <20171122144959.GA8081@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 9:49 AM, Greg KH wrote:
>>> If you have out-of-tree drivers, then yes, they can make a wrapper for
>>> this function like this if they really feel the need, or they can get
>>> their code merged:)
>> Sorry, I guess I should have been clearer.  My suggestion was to fix some of
>> the drivers where the domain can be determined, and for the rest, just mark
>> the old function as deprecated.
> So the build now gets warnings?  That's annoying, and then someone else
> will have to make the exact same patches that were created here?
> 
>> If that's still a terrible idea, well, okay.  I'm just unsure that simply
>> hard-coding a 0 for the domain for some drivers is really a solution.  Don't
>> we really want all drivers to properly support all domains?
> I bet all of those drivers don't care because they are running only in
> systems with 1 domain, otherwise they would be broken today, right?  But
> really, it shouldn't be that hard to get to the "real" PCI device to
> provide the correct pointer to the domain for most of these, as I
> pointed out in one patch review already.

I agree. Point is 95% drivers do support multiple segments. These are the
exceptions. 

We should try to fix them as much as we can. (I'll take a look at Greg's
suggestion)

In the end, this API is a backdoor and workarounds the proper APIs and
usual practices like carrying struct pci_dev pointer.

I'm trying to shoot that API in the foot so that a developer thinks twice
before putting number 0 there.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
