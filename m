Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50756 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbbKGDjz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2015 22:39:55 -0500
Subject: Re: ECRC and Max Read Request Size
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost> <563CE93F.5060209@codeaurora.org>
 <20151107001143.GA17842@localhost>
Cc: linux-pci@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <563D7287.1050500@codeaurora.org>
Date: Fri, 6 Nov 2015 22:39:51 -0500
MIME-Version: 1.0
In-Reply-To: <20151107001143.GA17842@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/6/2015 7:11 PM, Bjorn Helgaas wrote:
> That should definitely be fixed.  Do we enable ECRC unconditionally,
> or only when we boot with "pci=ecrc=on"?  The doc
> (Documentation/kernel-parameters.txt) suggests the latter.
>
> It would be ideal if we could try to turn on ECRC all the time by
> default for paths that support it.  I suppose there's some risk that
> we'd trip over broken hardware.  If that's an issue, we could consider
> turning it on all the time on machines newer than X (that's easy on
> x86, where we have a DMI BIOS date, but maybe not so easy on other
> arches).

ecrc=on kernel option works like "force on" rather than just a simple on.

I agree we should enable it by default.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
