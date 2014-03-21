Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:56784 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaCUPmm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 11:42:42 -0400
Received: by mail-lb0-f170.google.com with SMTP id s7so1822820lbd.29
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2014 08:42:41 -0700 (PDT)
Message-ID: <532C6BF7.1050404@cogentembedded.com>
Date: Fri, 21 Mar 2014 19:42:31 +0300
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
CC: Phil.Edworthy@renesas.com, Simon Horman <horms@verge.net.au>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for
 R8A7790
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <532C5ADE.4030708@cogentembedded.com> <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com> <6044873.2S2Xlhp0hC@wuerfel>
In-Reply-To: <6044873.2S2Xlhp0hC@wuerfel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 03/21/2014 05:57 PM, Arnd Bergmann wrote:

>>>> +      reg = <0 0xfe000000 0 0x80000>;
>>>> +      #address-cells = >;
>>>> +      #size-cells = <2>;
>>>> +      device_type = "pci";

>>>      This legacy property is only meaningful for the true OF firmware and thus
>>> have been phased out (it's only actively used for the memory nodes).

>> Ok, thanks for pointing this out.

> I think the code still relies on it for PCI though.

    OK, I have found where it does that but the recommended value seems to be 
"pciex" for PCI-Express case.

> 	Arnd

WBR, Sergei

