Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44269 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbaAUTPT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Jan 2014 14:15:19 -0500
Date: Tue, 21 Jan 2014 11:15:14 -0800
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Chris Cheng <chris.cheng@atrustcorp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	USB list <linux-usb@vger.kernel.org>,
	"Chen, Jamie" <jamie.chen@intel.com>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: USB EHCI broken on Celeron N2920 (Bay Trail)
Message-ID: <20140121191514.GD9905@xanatos>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAAzarHXkEZNKbWzbMAwHYWNm_=m1uiyGGWHSWv6T7-ARAELaHg@mail.gmail.com>
 <20140117182231.GA18421@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Chris,

We think the Baytrail BIOS has an issue where it doesn't set the EHCI
PCI interrupt enable bit when the computer is in "EHCI only mode".
Please try this patch:

http://marc.info/?l=linux-usb&m=138998295909608&w=2

Sarah Sharp

On Tue, Jan 21, 2014 at 10:04:41PM +0800, Chris Cheng wrote:
> I'm sorry forgot kernel version: 3.13.0 .
> --
> Chris Cheng  鄭宇廷
> Atrust Computer Corp.  冠信電腦股份有限公司
> http://www.atrustcorp.com
> Tel: +886-3-3288837 ext.1074
> 3F., No.361, Fusing 1st Rd., Gueishan Township, Taoyuan County 333, Taiwan
> 333 桃園縣龜山鄉復興一路361號3F
> 
> 
> 2014/1/21 Chris Cheng <chris.cheng@atrustcorp.com>:
> > Here is kernel message:
> >
> > [    2.939251] usb 1-1: new high-speed USB device number 2 using ehci-pci
> > [   18.490987] usb 1-1: device not accepting address 2, error -110
> > [   18.595095] usb 1-1: new high-speed USB device number 3 using ehci-pci
> > [   34.182233] usb 1-1: device not accepting address 3, error -110
> > [   34.286352] usb 1-1: new high-speed USB device number 4 using ehci-pci
> > [   44.744589] usb 1-1: device not accepting address 4, error -110
> > [   44.849590] usb 1-1: new high-speed USB device number 5 using ehci-pci
> > [   55.307858] usb 1-1: device not accepting address 5, error -110
> > [   55.310239] hub 1-0:1.0: unable to enumerate USB device on port 1
> >
> > Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

