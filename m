Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610Ab3JYRcH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2013 13:32:07 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id r9PHW5oP027383
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 12:32:05 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id r9PHW5MR014539
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2013 12:32:05 -0500
From: "Karicheri, Muralidharan" <m-karicheri2@ti.com>
To: "Karicheri, Muralidharan" <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: PCIE AER driver on ARM platform
Date: Fri, 25 Oct 2013 17:32:04 +0000
Message-ID: <3E54258959B69E4282D79E01AB1F32B704625A04@DFLE11.ent.ti.com>
References: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704625941@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All,

rephrased the subject a bit

I am trying to use PCIE AER to support AER capability for the PCIe devices. Tried enabling the
device driver. But the AER device is not getting probed. How does the AER device gets added
and probed? Is there DT support available or I need to use tradition platform code to setup
device or does it probed through pci bus probe mechanism. If latter, what could be the reason
the device is not probed in this case? The AER driver in my case is initialized after the root
complex driver. We don't have hot plug support. Is there any specific order of initializing this
device driver?

Thanks for your time.

Murali
>> -----Original Message-----
>> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf
>> Of Karicheri, Muralidharan
>> Sent: Friday, October 25, 2013 11:57 AM
>> To: linux-pci@vger.kernel.org
>> Subject: AER driver on ARM platform
>> 
>> Did anyone successfully tested PCIe AER driver on an ARM platform? I saw this enabled in a
>> tegra platform. Could someone from nVidia please respond?
>> 
>> Murali Karicheri
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body of a message
>> to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
