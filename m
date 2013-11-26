Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54917 "EHLO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab3KZIkW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 03:40:22 -0500
Message-ID: <52945E68.2090808@fold.natur.cuni.cz>
Date: Tue, 26 Nov 2013 09:40:08 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rajat Jain <rajatjain@juniper.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: Re: pciehp LinkState
References: <528D4739.80700@fold.natur.cuni.cz> <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com> <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com> <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz> <20131126031317.GA6258@google.com>
In-Reply-To: <20131126031317.GA6258@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Bjorn Helgaas wrote:
> On Tue, Nov 26, 2013 at 02:06:03AM +0100, Martin Mokrejs wrote:

Bjorn, thanks for all you clarifications, they are helpful.

> 
>> [  174.623769] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 108
>> [  174.623781] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [  174.623784] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [  174.623798] pciehp 0000:00:1c.7:pcie04: Data Link Layer State change
>> [  174.623801] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_active: lnk_status = 7011
>> [  174.623802] pciehp 0000:00:1c.7:pcie04: slot(7): Link Up event
>> [  174.624040] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [  174.624075] pciehp 0000:00:1c.7:pcie04: Link Up event ignored on slot(7): already powering on
>> [  174.625660] pciehp 0000:00:1c.7:pcie04: Enabling domain:bus:device=0000:11:00
>> [  174.625690] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_active: lnk_status = 7011
>> [  174.726003] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011
> 
> These messages are more verbose and possibly more alarming than necessary.
> We should clean this up somehow.  Some of it is probably debug stuff that
> is no longer relevant.  But I guess you're booting with "pciehp_debug=1",
> so maybe the normal messages aren't so verbose.

Yes, I have debug enabled (kernel config line should be in dmesg somewhere), I am glad debug
output says more, it helps when there is a problem popping up in future. ;-)

Martin
