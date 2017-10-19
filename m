Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:15293 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbdJSNXC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2017 09:23:02 -0400
Subject: Re: [PATCH] PCI: dwc: dra7xx: Print link state to console for debug
To: David Laight <David.Laight@ACULAB.COM>,
        "'Joe Perches'" <joe@perches.com>, "kishon@ti.com" <kishon@ti.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1508219031-25592-1-git-send-email-faiz_abbas@ti.com>
 <1508222128.6530.22.camel@perches.com>
 <063D6719AE5E284EB5DD2968C1650D6DD00997A7@AcuExch.aculab.com>
From: Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f7f37f47-2df0-be9d-76c0-188207b57adf@ti.com>
Date: Thu, 19 Oct 2017 18:53:04 +0530
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00997A7@AcuExch.aculab.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 17 October 2017 08:15 PM, David Laight wrote:
> From: Joe Perches
>> Sent: 17 October 2017 07:35
>> On Tue, 2017-10-17 at 11:13 +0530, Faiz Abbas wrote:
>>> Enable support for printing the LTSSM link state for debugging PCI
>>> when link is down.
>> []
>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>>> index 34427a6..7b150b0 100644
>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>> @@ -98,6 +98,18 @@ struct dra7xx_pcie_of_data {
>>>
>>>  #define to_dra7xx_pcie(x)	dev_get_drvdata((x)->dev)
>>>
>>> +static char state[][20] = {
>>> +	"DETECT_QUIET", "DETECT_ACT", "POLL_ACTIVE", "POLL_COMPLIANCE",
>>> +	"POLL_CONFIG", "PRE_DETECT_QUIET", "DETECT_WAIT", "CFG_LINKWD_START",
>>> +	"CFG_LINKWD_ACEPT", "CFG_LANENUM_WAIT", "CFG_LANENUM_ACEPT",
>>> +	"CFG_COMPLETE", "CFG_IDLE", "RCVRY_LOCK", "RCVRY_SPEED",
>>> +	"RCVRY_RCVRCFG", "RCVRY_IDLE", "L0", "L0S", "L123_SEND_EIDLE",
>>> +	"L1_IDLE", "L2_IDLE", "L2_WAKE", "DISABLED_ENTRY", "DISABLED_IDLE",
>>> +	"DISABLED", "LPBK_ENTRY", "LPBK_ACTIVE", "LPBK_EXIT",
>>> +	"LPBK_EXIT_TIMEOUT", "HOT_RESET_ENTRY", "HOT_RESET", "RCVRY_EQ0",
>>> +	"RCVRY_EQ1", "RCVRY_EQ2", "RCVRY_EQ3"
>>
>> what's wrong with using the far more typical
>>
>> static const char *link_state[] = {
>> 	"DETECT_QUIET",
>> 	...
> 
> Or 4 aligned columns.

4 aligned columns are difficult as the strings are of different sizes.

> Better still used named initialisers:
> 	[xxx_DETECT_QUIET] = "DETECT_QUIET",
> you really don't want an 'off-by-one' in that list.

Sounds good. Let me see how I can implement this.

Thanks,
Faiz
