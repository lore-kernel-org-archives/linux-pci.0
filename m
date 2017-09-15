Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:64640
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750866AbdIOH7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Sep 2017 03:59:42 -0400
To: "helgaas@kernel.org" <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Resizeable PCI BAR support V8
Message-ID: <67f83c31-d4ea-6939-1a9a-682c5600026d@amd.com>
Date: Fri, 15 Sep 2017 09:59:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> This seems 99.9% done, but there were some kbuild issues that need to be
> resolved.  Or did I miss the resolution of those?

Sorry for the long delay, I've been extremely busy the last few month 
and didn't had time to look into this task any more.

But I promise that I want to get it upstream before Christmas. We even 
have somebody new starting to work on our kernel driver next Monday, so 
hopefully I will find time to finish this soon.

And yeah I agree that it is 99.9% done, so if anybody wants to pick up 
and finish the last 0.1% feel free to do it.

BTW: My old mail address I've used for mailing list conversation doesn't 
work any more. So please just always use the work address.

Cheers,
Christian.
