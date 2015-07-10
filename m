Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56400 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386AbbGJOuG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jul 2015 10:50:06 -0400
Message-ID: <559FDB97.1090803@ti.com>
Date: Fri, 10 Jul 2015 20:19:59 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Pratyush Anand <pratyush.anand@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	<linux-omap@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
Subject: Re: [PATCH 2/3] PCI: host: pcie-designware: add support for suspend
 and resume
References: <1435921425-15121-1-git-send-email-kishon@ti.com>	<1435921425-15121-3-git-send-email-kishon@ti.com> <CAHM4w1m5gfFbKF6Up8YNQA8rK+avXuz8HZgtbj6pQAndSa_zBQ@mail.gmail.com>
In-Reply-To: <CAHM4w1m5gfFbKF6Up8YNQA8rK+avXuz8HZgtbj6pQAndSa_zBQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pratyush,

On Friday 10 July 2015 06:52 PM, Pratyush Anand wrote:
> Hi Kishon,
> 
> On Fri, Jul 3, 2015 at 4:33 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Certain platforms require MSE bit to be cleared to set the master
>> in standby mode. (In DRA7xx TRM_vE, section 24.9.4.5.2.2.1 PCIe
>> Controller Master Standby Behavior advises to use the clearing
>> of the local MSE bit to set the master in standby. Without this
>> some of the clocks do not idle).
>>
>> Cleared the MSE bit on suspend and enabled it back on resume.
>> This is required to get suspend/resume working.
> 
> Have you tested with a card having IO space memory as well.

I don't have any cards with IO space memory. Do you have any suggestion for
cards with IO space memory?
> I think you might need to require clear and enable PCI_COMMAND_IO
> in suspend and resume respectively.

okay.

Thanks
Kishon
