Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdKVT6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 14:58:48 -0500
Subject: Re: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-pci@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-10-git-send-email-okaya@codeaurora.org>
 <1511337146.4512.6.camel@linux.intel.com>
 <4541eaef-745a-e78f-e61d-1c7c207b551e@codeaurora.org>
 <87o9nut7n1.fsf@intel.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <2eae0561-5597-9bb8-89a8-8bcac1a2de70@codeaurora.org>
Date: Wed, 22 Nov 2017 13:58:45 -0600
MIME-Version: 1.0
In-Reply-To: <87o9nut7n1.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 01:50 PM, Jani Nikula wrote:
>>> 	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0,
>>> 							   PCI_DEVFN(0, 0));
>>>
>>> Can you please resend like that.
>> I did this at the beginning and but, I hit a checkpatch problem with
>> more than 80 characters. That's why, I moved the devfn value assignment
>> to a different line.
> Please ignore checkpatch when it makes the code worse. 80 is not a
> strict limit.

How about this:

	dev_priv->bridge_dev =
		pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));

That should fit, and it's very readable.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
