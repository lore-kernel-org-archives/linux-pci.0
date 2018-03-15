Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCOALI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 20:11:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 14 Mar 2018 20:11:07 -0400
From: okaya@codeaurora.org
To: Brian McGrew <brian.mcgrew@vxdatadesign.com>
Cc: linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org
Subject: Re: Help Updating Device Drivers
In-Reply-To: <8F6C8BF9-FC37-4E24-B573-5D8A0A4C8DF7@vxdd.onmicrosoft.com>
References: <8F6C8BF9-FC37-4E24-B573-5D8A0A4C8DF7@vxdd.onmicrosoft.com>
Message-ID: <769a37ad0f762ee05abefdd5b82112b9@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-14 16:28, Brian McGrew wrote:
> Hello...
> 
> Would this be the correct list to seek help in updating an old device
> driver?  I have a vendor provided device driver for a piece of PCIe
> hardware that compiles and runs in kernel-3.14 but is outdated for the
> newer kernel-4.1X series.  I’m not a kernel developer and haven’t done
> any real kernel work since the 2.4/2.6 days and am totally lost while
> undressing pressure to make it work ASAP.  Can I post code excepts and
> get help here, or is there a better mailing list?

Google is your friend. Search for each compilation failure in mailing 
lists.

There are too many changes. You will have to deal with each one.

> 
> Thanks in advance,
> 
> -brian
