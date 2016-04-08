Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38288 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757483AbcDHGvX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 02:51:23 -0400
Received: by mail-wm0-f50.google.com with SMTP id u206so10106291wme.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Apr 2016 23:51:22 -0700 (PDT)
Subject: Re: [PATCH 2/2] pci, acpi: free IO resource during shutdown
To: Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
 <20160407160624.GB8780@localhost> <57069CAF.8090803@codeaurora.org>
 <20160407214108.GB24492@localhost> <5707281B.6020805@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
	agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <570754D7.3010009@semihalf.com>
Date: Fri, 8 Apr 2016 08:51:03 +0200
MIME-Version: 1.0
In-Reply-To: <5707281B.6020805@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On 08.04.2016 05:40, Sinan Kaya wrote:
> Hi Tomasz,
>
> On 4/7/2016 5:41 PM, Bjorn Helgaas wrote:
>>>> You say this is undoing the effect of pci_remap_iospace(), but that's
>>>>>> only called by native drivers and the generic (OF) driver, not by
>>>>>> pci_root.c.
>>>>
>>>> See the ACPI root bridge driver above.
>> If this is a fix to patches that haven't been merged yet, we need to
>> squash the fix into the patches.
>>
>
> Can you merge these to two patches to your series for the next post?
>
> I need to remove weak on the first patch per direction from Bjorn and
> fix the function comments. You could as well do this while you are merging.
>
> Let me know what your preference is.
>

Please do necessary fixes for your patches and send me the repo 
reference link. I will merge these to my patch set. Thanks!

Tomasz
