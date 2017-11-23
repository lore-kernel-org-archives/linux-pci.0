Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:25623 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751129AbdKWHOz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Nov 2017 02:14:55 -0500
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Timur Tabi <timur@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-pci@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <2eae0561-5597-9bb8-89a8-8bcac1a2de70@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org> <1511328675-21981-10-git-send-email-okaya@codeaurora.org> <1511337146.4512.6.camel@linux.intel.com> <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org> <87o9nut7n1.fsf@intel.com> <2eae0561-5597-9bb8-89a8-8bcac1a2de70@codeaurora.org>
Date: Thu, 23 Nov 2017 09:14:48 +0200
Message-ID: <87lgixtqjb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 22 Nov 2017, Timur Tabi <timur@codeaurora.org> wrote:
> On 11/22/2017 01:50 PM, Jani Nikula wrote:
>>>> 	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0,
>>>> 							   PCI_DEVFN(0, 0));
>>>>
>>>> Can you please resend like that.
>>> I did this at the beginning and but, I hit a checkpatch problem with
>>> more than 80 characters. That's why, I moved the devfn value assignment
>>> to a different line.
>> Please ignore checkpatch when it makes the code worse. 80 is not a
>> strict limit.
>
> How about this:
>
> 	dev_priv->bridge_dev =
> 		pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>
> That should fit, and it's very readable.

*shrug* I'm fine with either, though I think the first one I like more
when I git grep stuff. Get more contex. But let's not get hung up on
this.

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Technology Center
