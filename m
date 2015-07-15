Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:22081 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGORbE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2015 13:31:04 -0400
Message-ID: <55A698D0.3070203@broadcom.com>
Date: Wed, 15 Jul 2015 10:30:56 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: Add Broadcom North Star 2 support
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com> <1436935343-4437-5-git-send-email-rjui@broadcom.com> <20150715092101.GB9627@leverpostej>
In-Reply-To: <20150715092101.GB9627@leverpostej>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/15/2015 2:21 AM, Mark Rutland wrote:
> Hi,
> 
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +		bootargs = "earlycon=uart8250,mmio32,0x66130000";
>> +	};
> 
> You shouldn't need those earlycon arguments if your driver has
> of_earlycon support. If that's currently missing, could you add that
> instead?
> 
> Thanks,
> Mark.
> 

I can look into this and add the of_earlycon support for
8250_dw. It looks like it may be only a matter of hooking it up to the
setup function in 8250_early.c, which is quite straightforward.

So does it make more sense for me to do the following?
1) Drop the earlycon bootargs from ns2-svk.dts and continue the Broadcom
iProc arm64 upstreaming process with the current patch series
2) Start a separate, new patch series with OF_EARLYCON support to 8250
DW driver

Thanks,

Ray
