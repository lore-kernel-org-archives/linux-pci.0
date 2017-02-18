Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdBRXsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Feb 2017 18:48:09 -0500
Date: Sat, 18 Feb 2017 17:46:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170218234624.GA13573@bhelgaas-glaptop.roam.corp.google.com>
References: <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de>
 <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de>
 <20170206204249.GA679@wunner.de>
 <CAE9FiQXSmB6Cs55nFtdw3rRrVrivwpDGNTwLwYtvWCEe4nsuHg@mail.gmail.com>
 <20170207060811.GA791@wunner.de>
 <CAE9FiQUxAfzLvd1icaJr=i8n_cQs5PL2q3y3PW9HYpaaPq8zZw@mail.gmail.com>
 <20170208084624.GA13086@linux-siqj.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208084624.GA13086@linux-siqj.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 12:46:26AM -0800, Yinghai Lu wrote:
> after that change will get:
> 
> sca05-0a81fd7f:~ # echo 1 > /sys/bus/pci/slots/7/power 
> [  300.949937] pci_hotplug: power_write_file: power = 1
> [  300.955502] pciehp 0000:73:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 17f1
> [  300.982557] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010 from Slot Status

Can anybody explain this Command Completed interrupt?  I think we should be
in this path:

  pciehp_sysfs_enable_slot
    pciehp_enable_slot
      pciehp_get_adapter_status
      pciehp_get_power_status
        "SLOTCTRL a8 value read 17f1" (DLLSCE PWR_OFF PWR_IND_OFF CCIE HPIE ATTN_IND_OFF ABPE)
      board_added
	pciehp_power_on_slot
	  pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_PWR_ON, PCI_EXP_SLTCTL_PCC)
          "SLOTCTRL a8 write cmd 0" (PWR_ON)
	  pciehp_link_enable
	    __pciehp_link_set

I don't see a write to SLTCTL between pciehp_get_power_status() and
pciehp_power_on_slot(), so I don't know why we see a Command Completed
interrupt.

> [  300.991171] pciehp 0000:73:00.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
> [  301.000033] pciehp 0000:73:00.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
> [  301.009274] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> [  301.662172] pciehp 0000:73:00.0:pcie004: pciehp_check_link_active: lnk_status = f083
> [  301.670827] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0108 from Slot Status
> [  301.679376] pciehp 0000:73:00.0:pcie004: Slot(7): Link Up
> [  301.685463] pciehp 0000:73:00.0:pcie004: Slot(7): Link Up event ignored; already powering on
> [  301.685508] pciehp 0000:73:00.0:pcie004: pciehp_check_link_active: lnk_status = f083
> [  302.005967] pciehp 0000:73:00.0:pcie004: pciehp_check_link_status: lnk_status = f083
> [  302.014859] pci 0000:74:00.0: [15b3:1003] type 00 class 0x0c0600
