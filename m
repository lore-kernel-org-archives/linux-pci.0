Return-Path: <SRS0=ea3o=7G=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=ea3o=7G=intel.com=keith.busch@kernel.org>
Date: Fri, 4 Aug 2017 01:07:51 -0400
From: Keith Busch <keith.busch@intel.com>
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] pciehp: Enable hot plug capable detection
Message-ID: <20170804050751.GA842@localhost.localdomain>
References: <1501650907-10969-1-git-send-email-keith.busch@intel.com>
 <20170802173249.GB20308@bhelgaas-glaptop.roam.corp.google.com>
 <20170803035924.GB13257@localhost.localdomain>
 <20170803201034.GW20308@bhelgaas-glaptop.roam.corp.google.com>
 <CACK8Z6FF_T7yc86_vc=carnp1N9XyNk_tYHrvaVGekTf8hf+jA@mail.gmail.com>
 <20170804034631.GB478@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170804034631.GB478@localhost.localdomain>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 03, 2017 at 11:46:31PM -0400, Keith Busch wrote:
> 
> Surprise removal is not supported. These do have Power Controller Control,
> though, and the user is supposed to power off the slot first like this:
> 
>   echo 0 > /sys/bus/pci/slot/<slot>/power
> 
> Then they can manually remove the device safely. They don't always do
> that, though, and it seems surprise yanks happen to work, but I doubt
> that's 100% safe.
> 
> Their expectation for hot add was that the kernel would handle it without
> the manual power control, and maybe that's not a valid expectation with
> this hardware even though it appears to work with my patch.
> 
> After reading all this, I'm starting to reconsider my patch, as well as
> the users' current processes. Maybe they should be using sysfs in lieu
> of physical attention buttons. To make that work, I will request they
> disable pciehp polling and require the user initiate the hot add with
> the slot's sysf. I will check if this is acceptable and have them run
> tests to confirm if that works.

Didn't take long to get confirmation: orderly add/remove through sysfs is
successful and acceptable. It even has better results than the previous
pciehp polling behavior, which occasionally experienced link training
failures. Considering all the information now, this even feels like the
correct way to have done things from the start.

Unless I hear anything different, I would like to self-Nak the patch at
this time. Thank you all for taking the time to consider.
